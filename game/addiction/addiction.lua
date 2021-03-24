local skynet = require "skynet"
local snax = require "skynet.snax"
local timext = require "timext"

local user_dc
local achievement
local info_dc

---@return table 返回时间结构 days/hours/mins/secs
local function timediff(timediff)
    if timediff == nil then
        return nil
    end
    local timeda = {}
    timeda.days = tonumber(timediff // 86400)
    timeda.hours = tonumber(timediff % 86400 // 3600)
    timeda.mins = tonumber(timediff % 3600 // 60)
    timeda.secs = tonumber(timediff % 60 % 60)
    return timeda
end

---时间转表结构
local function format_unix_time(unixTime)
    if unixTime and unixTime >= 0 then
        local tb = {}
        tb.year = tonumber(os.date("%Y", unixTime))
        tb.month = tonumber(os.date("%m", unixTime))
        tb.day = tonumber(os.date("%d", unixTime))
        tb.hour = tonumber(os.date("%H", unixTime))
        tb.min = tonumber(os.date("%M", unixTime))
        tb.sec = tonumber(os.date("%S", unixTime))
        return tb
    end
end

function init(...)
    user_dc = snax.queryservice("userdc")
    info_dc = snax.uniqueservice("infodc")
end

function exit(...)
end

local function addiction_match(uid)
    if user_dc.req.check_role_exists(uid) then
        local userinfo = user_dc.req.get(uid)
        userinfo.ltime = timext.current_time()
        local etime = format_unix_time(userinfo.etime)
        local currenttime = format_unix_time(userinfo.ltime)
        if (etime.year == currenttime.year and etime.day ~= currenttime.day) or etime.year ~= currenttime.year then
            userinfo.daytime = 0
        end
        user_dc.req.update(userinfo)

        if userinfo.age >= 18 then
            skynet.error("用户已成年:", uid)
            return
        end

        local maxtime = 1.5 * 3600
        if tonumber(os.date("%w")) == 0 or tonumber(os.date("%w")) == 6 then
            maxtime = 3 * 3600
        else
            --在工作日非8-21点，不允许登录
            if tonumber(os.date("%H")) < 8 or tonumber(os.date("%H")) > 21 then
                skynet.error("此时间段，未成年不可登录")
                send_kick_addiction(uid)
                return
            end
        end
        
        if userinfo.daytime >= maxtime then
            -- userinfo.addictiontime = userinfo.addictiontime or (timext.current_time() + 900)
            skynet.error("未成年用户已超时")
            send_kick_addiction(uid)
        end
	end
end

function response.online(uid, fd)
    addiction_match(uid)
end

---当前天的零点
local function zerotime()
    local time = os.date("*t")
    time.min = 0
    time.sec = 0
    time.hour = 0
    return os.time(time)
end

function response.offline(uid)
    local userinfo = user_dc.req.get(uid)
    userinfo.etime = timext.current_time()
    local etime = format_unix_time(userinfo.etime)
    local ltime = format_unix_time(userinfo.ltime)
    if etime.year == ltime.year and etime.day ~= ltime.day then
        local extime = os.time({year = etime.year, month = etime.month, day = etime.day, hour = 0, min = 0, sec = 0}) 
        userinfo.daytime = userinfo.etime - extime
    else
        userinfo.daytime = userinfo.daytime + userinfo.etime - userinfo.ltime
    end
    userinfo.onlinetime = userinfo.onlinetime + userinfo.etime - userinfo.ltime
    user_dc.req.update(userinfo)
    achievement = snax.queryservice("achievement")
    achievement.req.updatechallenge(uid, achievementdefine.achievetype.gametime, nil, math.floor(userinfo.onlinetime / 3600), true)

    --设置当前在线玩家数量
    local zerotime, playingnum = zerotime(), get_user_fds()
	info_dc.req.setvalue(zerotime, "playingsum", math.max(0, table.size(playingnum) - 1))

	skynet.error("game day time:", tostring(timediff(userinfo.daytime)))
end





















