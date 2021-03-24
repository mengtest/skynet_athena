local skynet = require "skynet"
local snax = require "skynet.snax"
local sharedata = require "skynet.sharedata"
local errCodeDef = require "errcodedef"
local json = require "cjson"
local timext = require "timext"
local assignmenthandler = require "game.assignment.assignmenthandler"

local user_dc
local usertask_dc
local daytask_dc
local urgenttask_dc
local plottask_dc
local achievement
local warehouse
local scan
local chip


---当前的零点
local function zerotime()
    local time = os.date("*t")
    time.min = 0
    time.sec = 0
    time.hour = 0
    return os.time(time)
end


function init(...)
    user_dc = snax.queryservice("userdc")
	usertask_dc = snax.uniqueservice("usertaskdc")
	daytask_dc = snax.uniqueservice("daytaskdc")
    urgenttask_dc = snax.uniqueservice("urgenttaskdc")
    plottask_dc = snax.uniqueservice("plottaskdc")
    achievement = snax.queryservice("achievement")
    warehouse = snax.uniqueservice("warehouse")
    scan = snax.uniqueservice("scan")
    chip = snax.uniqueservice("chip")
    assignmenthandler:inithandler(usertask_dc, daytask_dc, urgenttask_dc, plottask_dc, achievement, warehouse, scan, chip)
end

function exit(...)
end

---设置当前任务
function response.settasking(data)
   return assignmenthandler:settasking(data)
end

---对话结束
function response.talkend(data)
    return assignmenthandler:talkend(data)
end

---获取任务
function response.gettask(data)
    return assignmenthandler:gettask(data)
end

---观察者事件
---@param taskarr table 成就id和类型集合
---@param reset boolean true表示直接赋值nil表示累计false表示要比大小
---@param type boolean reset为false时此参数才会有效 false保存小的默认为true
function response.pusheach(uid, achid, number, taskarr, reset, type, sponsorid)
    if not taskarr or not next(taskarr) then
        return
    end
    for _, value in pairs(taskarr) do
        assignmenthandler:pusheach(uid, achid, value.taskid, value.tasktype, number, reset, type, sponsorid)
    end
end

---初始化任务
local function init_task(uid)
    local plottask, daytask, urgenttask, tasking = {}, {}, {}, {}
    --剧情任务
    local data = sharedata.deepcopy("take_task")
    for key, value in pairs(data) do
        if value.If_Display == 1 then
            local progress = {}
            local Task_Object = value.Task_Object
            local nextid = plottask_dc.req.get_nextid()
            for i = 1, #Task_Object do
                local object = sharedata.deepcopy("task_object", Task_Object[i])
                table.insert(progress, {achid = object.Achevement_ID, objectid = Task_Object[i], number = 0})
            end
            plottask_dc.req.add({id = nextid, cfgid = key, type = assignmentdefine.indextype.numing, progress = json.encode(progress)})
            table.insert(plottask, nextid)
            if value.Task_Type == assignmentdefine.typelist.main then
                tasking = nextid
            end
        end
    end
    --紧急任务
    data = sharedata.deepcopy("urgent_task")
    for key, value in pairs(data) do
        if value.If_Display == 1 then
            local progress = {}
            local Task_Object = value.Task_Object
            local nextid = urgenttask_dc.req.get_nextid()
            for i = 1, #Task_Object do
                local object = sharedata.deepcopy("task_object", Task_Object[i])
                table.insert(progress, {achid = object.Achevement_ID, objectid = Task_Object[i], number = 0})
            end
            urgenttask_dc.req.add({id = nextid, cfgid = key, type = assignmentdefine.indextype.numing, progress = json.encode(progress), 
                starttime = zerotime() + value.Start_Time, endtime = zerotime() + value.End_Time})
            table.insert(urgenttask, nextid)
        end
    end
    --每日任务
    data = sharedata.deepcopy("date_task")
    for key, value in pairs(data) do
        if value.If_Display == 1 then
            local progress = {}
            local Task_Object = value.Task_Object
            local nextid = daytask_dc.req.get_nextid()
            for i = 1, #Task_Object do
                local object = sharedata.deepcopy("task_object", Task_Object[i])
                table.insert(progress, {achid = object.Achevement_ID, objectid = Task_Object[i], number = 0})
            end
            daytask_dc.req.add({id = nextid, cfgid = key, type = assignmentdefine.indextype.numing, progress = json.encode(progress)})
            table.insert(daytask, nextid)
        end
    end
    usertask_dc.req.add({id = uid, daytask = string.join(daytask), urgenttask = string.join(urgenttask), plottask = string.join(plottask), tasking = tasking})
end

---添加观察者
local function add_observer(uid)
    local usertaskdc = usertask_dc.req.get(uid)
    if not usertaskdc or not next(usertaskdc) then
        skynet.error("addobserver error~~~~~~~~~~~~~~~~~~~~~")
        return
    end
    local daytask = string.split(usertaskdc.daytask)
    local urgenttask = string.split(usertaskdc.urgenttask)
    local plottask = string.split(usertaskdc.plottask)
    --添加观察者
    for key, value in pairs(daytask) do
        value = tonumber(value)
        local data = daytask_dc.req.get(value)
        local progress = json.decode(data.progress) 
        for _, v in pairs(progress) do
            achievement.req.addobserver(uid, v.achid, value, assignmentdefine.tasktype.day)
        end
    end

    for key, value in pairs(urgenttask) do
        value = tonumber(value)
        local data = urgenttask_dc.req.get(tonumber(value))
        local progress = json.decode(data.progress) 
        for _, v in pairs(progress) do
            achievement.req.addobserver(uid, v.achid, value, assignmentdefine.tasktype.urgent)
        end
    end

    for key, value in pairs(plottask) do
        value = tonumber(value)
        local data = plottask_dc.req.get(tonumber(value))
        local progress = json.decode(data.progress) 
        for _, v in pairs(progress) do
            achievement.req.addobserver(uid, v.achid, value, assignmentdefine.tasktype.plot)
        end
    end
end

function response.online(uid, fd)
    local usertaskdc = usertask_dc.req.get(uid)
    if not next(usertaskdc) then
        init_task(uid)
    end
    add_observer(uid)
    local needtalk = json.decode(usertaskdc.needtalk or "{}")
    if next(needtalk) then
        for _, value in pairs(needtalk) do
            send_request(fd, {cfgid = value.cfgid, id = value.id, type = value.type}, "assignment_finishtask")
        end
    end
end

function response.offline(uid)
end