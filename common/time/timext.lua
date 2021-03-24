local skynet = require "skynet"
local sharedata = require "sharedata"

--local core = require "time.core"

--[=[
os.date ([format [, time]])
返回一个按format格式化日期、时间的字串或表。

如果format以“！”开头，则按格林尼治时间进行格式化。

如果format是一个“*t”，将返一个带year(4位)，month(1-12)， day (1--31)
    ， hour (0-23)， min (0-59)，sec (0-61)，wday (星期几， 星期天为1),
    yday (年内天数)和isdst (是否为日光节约时间true/false)的带键名的表;

如果format不是“*t”，os.date会将日期格式化为一个字符串，具体如下：
%a  一星期中天数的简写   (Fri)
%A  一星期中天数的全称   (Wednesday)
%b  月份的简写   (Sep)
%B  月份的全称   (May)
%c  日期和时间   (09/16/98 23:48:10)
%d  一个月中的第几天    (28)[0 - 31]
%H  24小时制中的小时数  (18)[00 - 23]
%I  12小时制中的小时数  (10)[01 - 12]
%j  一年中的第几天 (209)[01 - 366]
%M  分钟数 (48)[00 - 59]
%m  月份数 (09)[01 - 12]
%P  上午或下午   (pm)[am - pm]
%S  一分钟之内秒数 (10)[00 - 59]
%w  一星期中的第几天    (3)[0 - 6 = 星期天 - 星期六]
%W  一年中的第几个星期　　 (2)0 - 52
%x  日期  (09/16/98)
%X  时间  (23:48:10)
%y  两位数的年份  (16)[00 - 99]
%Y  完整的年份   (2016)
%%  字符串'%'  (%)

注意使用format "*t"返回的table中wday如果是1表示星期天，而使用通用格式时%w用0表示星期天。
]=]

--[[
时间扩展说明：
open_clock函数开启时钟，只有时钟开启的情况才能使用定时器create_timer
    ，定点时间函数reg_time_event。
开启时钟会建立一个协程，执行AI函数
获取时间，时间格式化不需要开启时钟
]]
local _close
local timext = {}

function timext.getIsClose()
    return _close
end

local timezone
do--初始化本地时区
    local now = os.time()
    timezone = math.floor(os.difftime(now, os.time(os.date("!*t", now))))
    --log.Info("timext", "timezone:", timezone)
end

local systime
--获取当前时间 单位为秒
function timext.current_time()
    if not systime then
        systime = skynet.starttime()
    end
    return math.floor(systime + skynet.now()/100)
end

--获取当前时间 单位为毫秒
function timext.current_militime()
    if not systime then
        systime = skynet.starttime()
    end
    return systime * 100 + skynet.now()
end

function timext.ostime(param)
    local temp = math.floor(os.time(param) + timezone)

    --夏令时再加一个小时
    if param.isdst then
        temp = temp + 60 * 60
    end
    return temp
end

function timext.osdate(timesecond)
    return os.date("!*t", timesecond)
end

-- 格式%H:%M:%S 时间格式转化
function timext.from_unix_time(param)
    local tt = 0
    local ret = {}
    if type(param) == "table" then
        tt = param.hour * 3600 + param.min * 60 + param.sec
        ret = param
    elseif type(param) == "string" then
		local t = {}
		for w in string.gmatch(param, "%d+") do
			table.insert(t, w)
		end
		tt = t[1] * 3600 + t[2] * 60 + t[3]
        ret.hour = tonumber(t[1])
        ret.min = tonumber(t[2])
        ret.sec = tonumber(t[3])
    end
    return tt, ret
end

function timext.to_unix_time(tt)
    local t = {}
    if not tt then
        tt = timext.from_unix_time(os.date("!*t", timext.current_time()))
    end
    t.hour = tt // 3600
    t.min = tt % 3600 // 60
    t.sec = tt % 60

    return string.format("%d:%d:%d", t.hour, t.min, t.sec), t
end

-- 2015-01-01 01:01:01 日期格式转化
function timext.to_unix_time_stamp(tt)
    tt = tt or timext.current_time()
    return os.date("!%Y-%m-%d %X", tt)
end

-- 2018-01-01 日期格式化
function timext.to_unix_time_stamp_lit(tt)
    tt = tt or timext.current_time()
    return os.date("!%Y-%m-%d", tt)
end

function timext.from_unix_time_stamp(str)
    local t = {}
    if not str then
        LOG_ERROR("err call from_unix_time_stamp str is nil")
        return
    end
	for w in string.gmatch(str, "%d+") do
		table.insert(t, w)
    end
    if #t ~= 6 then
        return 0, t
    end

    t.year = tonumber(t[1])
    t.month = tonumber(t[2])
    t.day = tonumber(t[3])
    t.hour = tonumber(t[4])
    t.min = tonumber(t[5])
    t.sec = tonumber(t[6])
    return timext.ostime(t) , t
end

--系统刷新时间
local rfseconds, rftm
function timext.system_refresh_time()
    if not rfseconds or not rftm then
        --临时定位0点，后期改为配置
        local sys_refresh = 0
        rfseconds, rftm = timext.from_unix_time(sys_refresh)
    end
    return rfseconds, rftm
end

--获取相对系统刷新的时间
function timext.get_time_relative_system_refresh(hour, min, sec)
    hour = hour or 0
    min = min or 0
    sec = sec or 0
    local sys_refresh = getGameConfig("sc_systemconfig", "system_refresh_time")
    local secs = (sys_refresh.hour + hour) * 3600
         + (sys_refresh.min + min) * 60
         + sys_refresh.sec + sec
    secs = secs % 86400
    local t = {}
    t.hour = secs // 3600
    t.min = secs % 3600 // 60
    t.sec = secs % 60
    return t
end

--获取系统刷新时间
function timext.get_refresh_time(time)
    local current = timext.current_time()
    local zero = timext.day_zero_time(current + time)
    local temp = timext.system_refresh_time()
    return math.floor(zero + temp)
end

local system_timezone
-- 获取游戏的时区
function timext.get_system_timezone()
    if not system_timezone then
        system_timezone = getGameConfig("sc_systemconfig", "system_timezone")
    end
    return system_timezone
end

--获取当天0点整时间
function timext.day_zero_time(utc)
    utc = utc or timext.current_time()
    local t = os.date("!*t", utc)
    local hour = t.hour * 60 * 60
    local min = t.min * 60
    local sec = t.sec
    return utc - hour - min - sec
end

-- 获取系统0点
function timext.system_zero_time(utc)
    utc = utc or timext.current_time()
    local t = os.date("!*t", utc)
    local sys_timezone = timext.get_system_timezone()
    local hour = t.hour * 60 * 60
    local min = t.min * 60
    local sec = t.sec
    local zero_utc = utc - hour - min - sec - sys_timezone
    if zero_utc < (utc - 86400) then
        zero_utc = zero_utc + 86400
    end
    return zero_utc
end

-- 获取上一次星期一零点零分零秒的时间
function timext.last_monday_time(utc)
    utc = utc or timext.current_time()
    local t = os.date("!*t", utc)
	local wday
	if t.wday == 1 then--sunday
		wday = 6 * 24 * 60 * 60
	else
		wday = (t.wday - 2) * 24 * 60 * 60
	end
	local hour = t.hour * 60 * 60
    local min = t.min * 60
    local sec = t.sec
    return utc - hour - min - sec - wday
end


-- 获取上一次星期一零点零分零秒的时间(系统设定时区)
function timext.last_system_monday_time(utc)
    utc = utc or timext.current_time()
    local t = os.date("!*t", utc)
	local wday
	if t.wday == 1 then--sunday
		wday = 6 * 24 * 60 * 60
	else
		wday = (t.wday - 2) * 24 * 60 * 60
	end
	local hour = t.hour * 60 * 60
    local min = t.min * 60
    local sec = t.sec
    local sys_timezone = timext.get_system_timezone()
    local monday_utc = utc - hour - min - sec - wday - sys_timezone
    if monday_utc < (utc - 7 * 86400) then
        monday_utc = monday_utc + 7 * 86400
    end
    return monday_utc
end

-- 比较两个时间不是同一天
function timext.IsSameDay(t1,t2)
	if not t1 or not t2 or t1 == 0 or t2 == 0 then
        return false
    end
    --判断是否相差24小时以上
    if math.abs(t2 - t1) > 24 * 60 * 60 then
        return false
    end
    local isSame = false
    if os.date("!%j",t1) == os.date("!%j",t2) then--一年中的第几天
        isSame = true
    end
    return isSame
end

-- 比较两个时间不是同一天 系统时间分界线
function timext.IsSameSystemDay(t1, t2)
    local sys_timezone = timext.get_system_timezone()
    t1 = t1 + sys_timezone
    t2 = t2 + sys_timezone
    return timext.IsSameDay(t1,t2)
end

-- 比较两个时间不是同一周
function timext.IsSameWeek(t1,t2)
    if not t1 or not t2 or t1 == 0 or t2 == 0 then
        return false
    end
    --判断是否相差一周以上
    if math.abs(t2 - t1) > 7 * 24 * 60 * 60 then
        return false
    end
    local isSame = false
    if os.date("!%W",t1) == os.date("!%W",t2) then--一年中的第几个星期
        isSame = true
    end
    return isSame
end


-- 比较两个时间不是同一周 5点分界线
function timext.IsSameWeekBy5(t1,t2)
	if not t1 or not t2 or t1 == 0 or t2 == 0 then
		return false
	end

	if t2 < t1 then
		t1, t2 = t2 , t1
	end
	if t2 - t1 > 7 * 24 * 60 * 60 then
		return false
    end

    local week1 = os.date("!%W",t1)
    local week2 = os.date("!%W",t2)
    local d1 = os.date("!*t",t1)
    local d2 = os.date("!*t",t2)
	local sec1 = d1.hour * 60 * 60 + d1.min * 60 + d1.sec
    local sec2 = d2.hour * 60 * 60 + d2.min * 60 + d2.sec
    local tempsec = timext.system_refresh_time()
    if week1 == week2 then--两个时间在同一周
        --星期一系统刷新时间边界判断
        if d1.wday == 2 and sec1 < tempsec and (d2.wday ~= d1.wday or sec2 >= tempsec) then
            return false
        end
        return true
    else
        --星期一系统刷新时间边界判断
        if d2.wday == 2 and sec2 < tempsec and (d1.wday ~= d2.wday or sec1 >= tempsec) then
            return true
        end
        return false
    end
end

--判断两个时间是否相差两周
function timext.IsTowWeek(t1,t2)
	local d2 = os.date("!*t",t2)
	local temp2 = timext.ostime({year=d2.year,month=d2.month,day=d2.day})
	local d2_week = (d2.wday  - 1) ==  0 and 7 or (d2.wday  - 1)
	local TwoWeeksAgo = temp2 - (d2_week -1 + 7) *24 * 3600
	if t1 < TwoWeeksAgo then
		return true
	end
	return false
end

--AAAABBCCDDEEFF 201503021201 转秒
function timext.tosectime(t)
	local date = {}
	date.year = t // 100000000
	date.month = t // 1000000 % 100
	date.day = t // 10000 % 100
	date.hour = t // 100 % 100
	date.min = t %100
	return timext.ostime(date)
end

--返回星期N [1 - 7], tt时间结算点
--以 5：00（5 * 3600）为每日刻度,则周一4：49 返回的值是周日(7)
function timext.weekday(utc)
    --默认时间为0点
    local time = utc or timext.current_time()
    time = time + timext.get_system_timezone()
    local day = tonumber( os.date("!%w", time) )--[0-6]周日表示0
    if day == 0 then
        day = 7
    end
    return day
end

--返回当前月份有N天
function timext.month_days()
    local day = os.date("!%d", timext.ostime({year=os.date("!%Y"),month=os.date("!%m")+1,day=0}))
    return tonumber(day)
end

--返回当前月份第N天
function timext.month_day(utc)
    local time = utc or timext.current_time()
    local day = os.date("!%d", time)
    return tonumber(day)
end

--
function timext.month(utc)
    utc = utc or timext.current_time()
    local m = os.date("!%m", utc)
    return tonumber(m)
end

------------------------------------------------------------------------------------------------------------------------
--定点时间事件
local time_event = { }
local s_eventid = 0

--周几类型
timext.week_day = {
    sunday = 1,
    monday = 2,
    tuesday = 4,
    wednesday = 8,
    thurday = 16,
    friday = 32,
    saturday = 64,
}
local all_day = timext.week_day.sunday | timext.week_day.monday | timext.week_day.tuesday | timext.week_day.wednesday
    | timext.week_day.thurday | timext.week_day.friday | timext.week_day.saturday

local _week_day = {
    sunday = 1,
    monday = 2,
    tuesday = 3,
    wednesday = 4,
    thurday = 5,
    friday = 6,
    saturday = 7,
}
--计算下一次触发时间
function timext.next_event_time(last_time, hour, min, sec, day)
    hour = hour or 0
    min = min or 0
    sec = sec or 0
    day = day or all_day
    last_time = last_time or timext.current_time()
    local t = os.date("!*t", last_time)
    local zerotime = timext.day_zero_time(last_time)
    local closest_time
    sec = hour * 60 * 60 + min * 60 + sec
    for k,v in pairs(timext.week_day) do
        if (day & v) ~= 0 then
            local day = _week_day[k]
            if day == t.wday then
                local temp = zerotime + sec
                if temp <= last_time then
                    temp = temp + 7 * 24 * 60 * 60  --加上一周的时间
                end
                if not closest_time or temp < closest_time then
                    closest_time = temp
                end
            else
                if day < t.wday then
                    day = day + 7
                end
                local temp = zerotime + (day - t.wday) * 24 * 60 * 60 + sec
                if not closest_time or temp < closest_time then
                    closest_time = temp
                end
            end
        end
    end
    if not closest_time then
        skynet.error("event no found next time!")
    end
    return closest_time
end

--注册定点时间事件 func为时间到达后的回调函数,last_event_time上一次触发时间
function timext.reg_time_event(func, last_event_time, hour, min, sec, day, busesystemtime)
    if not func then
        skynet.error("not time event func!")
        return
    end
    local event = {
                    _func = func,
                    _hour = hour or 0,
                    _min = min or 0,
                    _sec = sec or 0,
                    _day = day or all_day,
                    busesystemtime = busesystemtime or true,
                  }
    if event.busesystemtime then
        local sys_timezone = timext.get_system_timezone()
        last_event_time  = (last_event_time or timext.current_time()) + sys_timezone
        event._next_time = timext.next_event_time(last_event_time, event._hour, event._min, event._sec, event._day)
            - sys_timezone
    else
        event._next_time = timext.next_event_time(last_event_time, event._hour, event._min, event._sec, event._day)
    end
    s_eventid = s_eventid + 1
    event.id = s_eventid

    table.insert(time_event, event)
    return event
end

--注册系统定点时间事件 func为时间到达后的回调函数,last_event_time上一次触发时间
function timext.reg_systemtime_event(func, last_event_time, hour, min, sec, day)
    if not func then
        skynet.error("not time event func!")
        return
    end
    local event = {
                    _func = func,
                    _hour = hour or 0,
                    _min = min or 0,
                    _sec = sec or 0,
                    _day = day or all_day,
                    busesystemtime = true,
                  }

    local sys_timezone = timext.get_system_timezone()
    last_event_time  = (last_event_time or timext.current_time()) + sys_timezone
    event._next_time = timext.next_event_time(last_event_time, event._hour, event._min, event._sec, event._day)
         - sys_timezone
    s_eventid = s_eventid + 1
    event.id = s_eventid

    table.insert(time_event, event)
    return event
end

--反注册定点时间函数
function timext.unreg_time_event(event)
    for k,v in pairs(time_event) do
        if v.id == event.id then
            table.remove(time_event, k)
            break
        end
    end
end

local last_time = skynet.now()
local function clock(clock_func, interval)
    interval = interval or 100
    while true do
        if _close then
            break
        end
        local new_time = skynet.now()
        local diff_time = new_time - last_time
        last_time = new_time
        if clock_func then
            local ok,err = xpcall(clock_func, debug.traceback, diff_time)
            if not ok then
                LOG_ERROR(tostring(err))
            end
        end

        if next(time_event) then
            local current = timext.current_time()
            for _,event in ipairs(time_event) do
                if event._next_time < current then
                    event._func()
                    if event.busesystemtime then
                        local sys_timezone = timext.get_system_timezone()
                        local last_event_time  = current + sys_timezone
                        event._next_time = timext.next_event_time(last_event_time, event._hour, event._min
                            , event._sec, event._day) - sys_timezone
                    else
                        event._next_time = timext.next_event_time(current, event._hour, event._min
                            , event._sec, event._day)
                    end
                end
            end
        end

        skynet.sleep(interval)
    end
end

--启动时钟  clock_func为回调函数  interval为时钟间隔时间（0.01秒）
function timext.open_clock(clock_func, interval)
    skynet.fork(clock, clock_func, interval)
    _close = false
end

--关闭时钟
function timext.close_clock()
    _close = true
    time_event = {}
end

-----------------------------------------------------------------------------------------------------------------------
--skynettimer 定时器 单位为0.01秒
local skynettimer = {}
skynettimer.__index = skynettimer

--创建一个定时器
function timext.create_skynettimer(sec)
    local obj = {
	}
	setmetatable(obj, skynettimer)
    obj:update(sec)
	return obj
end

--开始计时 sec为距离当前时间多久过期
function skynettimer:update(sec)
    self._time = timext.current_militime()
    self._expired = self._time + (sec or 0)
    self._pause = nil
end

--剩余时间
function skynettimer:remain()
    local time = self._pause
    if not time then
        time = timext.current_militime()
    end
    local temp = (self._expired > time) and (self._expired - time) or 0
    return temp
end

--是否过期
function skynettimer:expire()
    local time = self._pause
    if not time then
        time = timext.current_militime()
    end
    return time >= self._expired
end

--距离开始计时 经过的时间
function skynettimer:elapsed()
    local time = self._pause
    if not time then
        time = timext.current_militime()
    end
    return time - self._time
end

--是否开启
function skynettimer:isopen()
    return not self._pause
end

--暂停
function skynettimer:pause()
    self._pause = timext.current_militime()
end

--启动
function skynettimer:open()
    self:update(self:remain())
end

------------------------------------------------------------------------------------------------------------------------
--timer 定时器 单位为秒
local timer = {}
setmetatable(timer, skynettimer)
timer.__index = timer

--创建一个定时器
function timext.create_timer(sec)
    local obj = {
	}
	setmetatable(obj, timer)
    obj:update(sec)
	return obj
end

--开始计时 sec为距离当前时间多久过期
function timer:update(sec)
    skynettimer.update(self, (sec or 0) * 100)
end

--剩余时间
function timer:remain()
    return skynettimer.remain(self) // 100
end

--距离开始计时 经过的时间
function timer:elapsed()
    return skynettimer.elapsed(self) // 100
end

------------------------------------------------------------------------------------------------------------------------

-- localtime timer
--skynettimer 定时器 单位为0.01秒
local localskynettimer = {}
localskynettimer.__index = localskynettimer

--创建一个定时器
function timext.create_localskynettimer(milsec)
    local obj = {
	}
	setmetatable(obj, localskynettimer)
    obj:update(milsec)
	return obj
end

--开始计时 milsec为距离当前时间多久过期
function localskynettimer:update(milsec)
    self._time = skynet.now()
    self._expired = self._time + (milsec or 0)
    self._pause = nil
end

--剩余时间
function localskynettimer:remain()
    local time = self._pause
    if not time then
        time = skynet.now()
    end
    local temp = (self._expired > time) and (self._expired - time) or 0
    return temp
end

--是否过期
function localskynettimer:expire()
    local time = self._pause
    if not time then
        time = skynet.now()
    end
    return time >= self._expired
end

--距离开始计时 经过的时间
function localskynettimer:elapsed()
    local time = self._pause
    if not time then
        time = skynet.now()
    end
    return time - self._time
end

--是否开启
function localskynettimer:isopen()
    return not self._pause
end

--暂停
function localskynettimer:pause()
    self._pause = skynet.now()
end

--启动
function localskynettimer:open()
    self:update(self:remain())
end

return timext