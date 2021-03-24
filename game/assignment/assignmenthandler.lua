local assignmenthander = class("assignmenthander")
local skynet = require "skynet"
local sharedata = require "skynet.sharedata"
local errCodeDef = require "errcodedef"
local json = require "cjson"
local timext = require "timext"
local queue = require "skynet.queue"
local cs = queue()


local usertask_dc
local daytask_dc
local urgenttask_dc
local plottask_dc
local achievement
local warehouse
local scan
local chip

local observerlist = {}

function assignmenthander:ctor()
end

function assignmenthander:inithandler(task, day, urgent, plot, athl, ware, sca, chi)
    usertask_dc, daytask_dc, urgenttask_dc, plottask_dc, achievement, warehouse, scan, chip = task, day, urgent, plot, athl, ware, sca, chi
end

---获取两时间差
---@return table 返回相差时间结构 days/hours/mins/secs
local function timediff(begin_time, end_time)
    local begin_time = begin_time and begin_time or os.time()
    local end_time = end_time and end_time or os.time()
    local difftime = math.abs(begin_time - end_time)
    local timeda = {}
    timeda.days = tonumber(difftime // 86400)
    timeda.hours = tonumber(difftime % 86400 // 3600)
    timeda.mins = tonumber(difftime % 3600 // 60)
    timeda.secs = tonumber(difftime % 60 % 60)
    return timeda
end

---发放奖励
---@param data table 奖励数据
local function get_award(uid, data)
    if data == nil or not next(data) then
        return
    end
    for i = 1, #data, 3 do
        if data[i] == warehousedefine.warehousetype.material then
            warehouse.req.addmaterials(uid, data[i + 1], data[i + 2])
        elseif data[i] == warehousedefine.warehousetype.prop then
            warehouse.req.addprop(uid, data[i + 1], data[i + 2])
        elseif data[i] == warehousedefine.warehousetype.gold then
            warehouse.req.addgold(uid, data[i + 1], data[i + 2])
        elseif data[i] == warehousedefine.warehousetype.blueprint then
            scan.req.addblueprint(uid, data[i + 1], data[i + 2])
        elseif data[i] == warehousedefine.warehousetype.chip then
            chip.req.addchip(uid, data[i + 1], 1, data[i + 2])
        else
            warehouse.req.addequip(uid, data[i], data[i + 1], 1, data[i + 2])
        end
    end
end

---判断任务是否完成
---@param progress number 任务完成度集合
---@return boolean true已完成
local function is_finish(progress)
    local result = true
    for key, value in pairs(progress) do
        local task_object = sharedata.deepcopy("task_object", value.objectid)
        local type = task_object.If_Bigger --比大小标识符
        if type == 0 and value.number > task_object.Task_Count then
            result = false
            break
        elseif value.number < task_object.Task_Count then
            result = false
            break
        end
    end
    return result
end

---添加剧情任务
---只添加剧情任务
---@param cfgid number 剧情配置id
---@param id number 剧情唯一id
local function addplot_task(uid, cfgid, id)
    local data = sharedata.deepcopy("task", cfgid)
    for key, value in pairs(data) do
        local progress = {}
        local Task_Object = value.Task_Object
        for i = 1, #Task_Object do
            local object = sharedata.deepcopy("task_object", Task_Object[i])
            table.insert(progress, {achid = object.Achevement_ID, objectid = Task_Object[i], number = 0})
            achievement.req.addobserver(uid, object.Achevement_ID, id, assignmentdefine.tasktype.plot)
        end
        plottask_dc.req.add({id = id, cfgid = key, type = assignmentdefine.indextype.numing, progress = json.encode(progress)})
    end
end

---领取剧情任务
---@param tasktype number 任务类型
---@param taskid number 任务唯一id
local function recieveplot(uid, tasktype, taskid)
    local usertask = usertask_dc.req.get(uid)
    local plottask = plottask_dc.req.get(taskid)
    local plottaskinfo = string.split(usertask.plottask)
    table.remove(plottaskinfo, table.find(plottaskinfo, tostring(taskid)))
    transaction()
    local taskinfo = sharedata.deepcopy("task", plottask.cfgid)
    get_award(uid, taskinfo.Task_Reward)
    --移除观察者
    local Task_Object = taskinfo.Task_Object
    for i = 1, #Task_Object do
        local object = sharedata.deepcopy("task_object", Task_Object[i])
        achievement.req.remobserver(uid, object.Achevement_ID, taskid, tasktype)
    end
    --保存下一个任务
    usertask.tasking = nil
    if taskinfo.Next_Task then
        local nextid = plottask_dc.req.get_nextid()
        addplot_task(uid, taskinfo.Next_Task, nextid)
        usertask.tasking = nextid
        table.insert(plottaskinfo, nextid)
        send_request(get_user_fd(uid), {cfgid = taskinfo.Next_Task, id = nextid}, "assignment_addplottask")
    end
    plottask_dc.req.delete({id = taskid})
    usertask_dc.req.setvalue(uid, "tasking", usertask.tasking)
    usertask_dc.req.setvalue(uid, "plottask", string.join(plottaskinfo))
    commit()
end

---根据参数计算任务进度
---@param number number 增量
---@param oldnumber number 原始进度 
---@return number 返回计算之后的进度
local function countnumber(number, oldnumber, reset, type)
    local value = oldnumber
    if reset then
        value = number
    elseif reset == nil then
        value = value + number
    else
        if type then
            value = value >= number and value or number
        else
            value = value <= number and value or number
        end
    end
    return value
end

---观察者事件
---@param achid number 成就类型id
---@param taskid number 表中唯一id不是配置的
---@param reset boolean true表示直接赋值nil表示累计false表示要比大小
---@param type boolean reset为false时此参数才会有效 false保存小的默认为true
---@param sponsorid number 发起者配置id 比如某一野怪的配置id、地图配置id
function assignmenthander:pusheach(uid, achid, taskid, tasktype, number, reset, type, sponsorid)
    local usertask = usertask_dc.req.get(uid)
    if not next(usertask) then
        LOG_ERROR("观察者事件触发， 但未找到对应玩家: %d", uid)
        return
    end

    --每日、紧急任务完成之后都不删除，也不移除观察者，只是不再记录，在第二天记录清空。
    if tasktype == assignmentdefine.tasktype.day then
        local taskinfo = string.split(usertask.daytask)
        if not table.find(taskinfo, tostring(taskid)) then
            LOG_ERROR("观察者事件触发， 但未找到对应任务: %d", taskid)
            return
        end
        local daytask = daytask_dc.req.get(taskid)
        local progress = json.decode(daytask.progress)
        local isfinish = false
        for key, value in pairs(progress) do
            if isfinish then
                break
            end
            if value.achid == achid then
                if daytask.type ~= assignmentdefine.indextype.numing then
                    break
                end
                local task_object = sharedata.deepcopy("task_object", value.objectid)
                if next(task_object.Contain_ID) and not table.find(task_object.Contain_ID, sponsorid) then
                    break
                end
                value.number = countnumber(number, value.number, reset, type)
                if is_finish(progress) then
                    local date_task = sharedata.deepcopy("date_task", daytask.cfgid)
                    if not date_task.Talk_ID then
                        daytask.type = assignmentdefine.indextype.finish
                        get_award(uid, date_task.Task_Reward)
                        if check_user_online(uid) then
                            send_request(get_user_fd(uid), {cfgid = daytask.cfgid, id = taskid, type = tasktype}, "assignment_finishtask")
                        end
                    else
                        daytask.type = assignmentdefine.indextype.numover
                        local needtalk = json.decode(usertask.needtalk or "{}")
                        table.insert(needtalk, {type = tasktype, id = taskid, cfgid = daytask.cfgid})
                        usertask_dc.req.setvalue(uid, "needtalk", json.encode(needtalk))
                        if check_user_online(uid) then
                            send_request(get_user_fd(uid), {cfgid = daytask.cfgid, id = taskid, type = tasktype}, "assignment_finishtask")
                        end
                    end
                    isfinish = true
                end
                break
            end
        end
        daytask_dc.req.setvalue(taskid, "type", daytask.type)
        daytask_dc.req.setvalue(taskid, "progress", json.encode(progress))
    elseif tasktype == assignmentdefine.tasktype.urgent then
        local taskinfo = string.split(usertask.urgenttask)
        if not table.find(taskinfo, tostring(taskid)) then
            LOG_ERROR("观察者事件触发， 但未找到对应任务: %d", taskid)
            return
        end
        local urgenttask = urgenttask_dc.req.get(taskid)
        
        local progress = json.decode(urgenttask.progress)
        local curtime = timext.current_time()
        --不是同一天全部清空记录,状态变换
        if not timext.IsSameDay(urgenttask.starttime, curtime) then
            for key, value in pairs(progress) do
                value.number = 0
            end
            usertask.type = assignmentdefine.indextype.numing
            local suday = timediff(urgenttask.starttime)
            urgenttask.starttime = urgenttask.starttime + 3600 * 24 * suday.days
            urgenttask.endtime = urgenttask.endtime + 3600 * 24 * suday.days
        end
        if urgenttask.starttime > curtime or urgenttask.endtime < curtime then
            skynet.error("time!!!!!! ", taskid)
            return
        end
        local isfinish = false
        for key, value in pairs(progress) do
            if isfinish then
                break
            end
            if value.achid == achid then
                if urgenttask.type ~= assignmentdefine.indextype.numing then
                    break
                end
                local task_object = sharedata.deepcopy("task_object", value.objectid)
                if next(task_object.Contain_ID) and not table.find(task_object.Contain_ID, sponsorid) then
                    break
                end
                value.number = countnumber(number, value.number, reset, type)
                if is_finish(progress) then
                    local urgent_task = sharedata.deepcopy("urgent_task", urgenttask.cfgid)
                    if not urgent_task.Talk_ID then
                        urgenttask.type = assignmentdefine.indextype.finish
                        get_award(uid, urgent_task.Task_Reward)
                        if check_user_online(uid) then
                            send_request(get_user_fd(uid), {cfgid = urgenttask.cfgid, id = taskid, type = tasktype}, "assignment_finishtask")
                        end
                    else
                        urgenttask.type = assignmentdefine.indextype.numover
                        local needtalk = json.decode(usertask.needtalk or {})
                        table.insert(needtalk, {type = tasktype, id = taskid, cfgid = urgenttask.cfgid})
                        usertask_dc.req.setvalue(uid, "needtalk", json.encode(needtalk))
                        if check_user_online(uid) then
                            send_request(get_user_fd(uid), {cfgid = urgenttask.cfgid, id = taskid, type = tasktype}, "assignment_finishtask")
                        end
                    end
                    isfinish = true
                end
                break
            end
        end
        urgenttask_dc.req.setvalue(taskid, "type", urgenttask.type)
        urgenttask_dc.req.setvalue(taskid, "progress", json.encode(progress))
    elseif tasktype == assignmentdefine.tasktype.plot then
        --是否为当前激活任务
        if usertask.tasking == nil or taskid ~= usertask.tasking then
            skynet.error("not tasking!!!!!!!!!! ", taskid)
            return
        end
        local plottask = plottask_dc.req.get(taskid)
        local plottaskinfo = string.split(usertask.plottask)
        local progress = json.decode(plottask.progress)
        local isfinish = false
        for key, value in pairs(progress) do
            if isfinish then
                break
            end
            if value.achid == achid then
                if plottask.type ~= assignmentdefine.indextype.numing then
                    break
                end
                local task_object = sharedata.deepcopy("task_object", value.objectid)
                if next(task_object.Contain_ID) and not table.find(task_object.Contain_ID, sponsorid) then
                    break
                end
                value.number = countnumber(number, value.number, reset, type)
                if is_finish(progress) then
                    local taskinfo = sharedata.deepcopy("task", plottask.cfgid)
                    if not taskinfo.Talk_ID then
                        --没有对话，直接领取
                        cs(recieveplot, uid, tasktype, taskid)
                        if check_user_online(uid) then
                            send_request(get_user_fd(uid), {cfgid = plottask.cfgid, id = taskid, type = tasktype}, "assignment_finishtask")
                        end
                    else
                        plottask.type = assignmentdefine.indextype.numover
                        local needtalk = json.decode(usertask.needtalk or "{}")
                        table.insert(needtalk, {type = tasktype, id = taskid, cfgid = plottask.cfgid})
                        usertask_dc.req.setvalue(uid, "needtalk", json.encode(needtalk))
                        if check_user_online(uid) then
                            send_request(get_user_fd(uid), {cfgid = plottask.cfgid, id = taskid, type = tasktype}, "assignment_finishtask")
                        end
                    end
                    isfinish = true
                end
                break
            end
        end
        plottask_dc.req.setvalue(taskid, "type", plottask.type)
        plottask_dc.req.setvalue(taskid, "progress", json.encode(progress))
    end
end

---设置当前任务
function assignmenthander:settasking(data)
    local ret = {}
    local uid = data.uid
    local id = data.msg.id

    local usertask = usertask_dc.req.get(uid)
    if not id or not next(usertask) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local plottaskarr = string.split(usertask.plottask)
    if not table.find(plottaskarr, tostring(id)) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = errCodeDef.eEC_success
    usertask_dc.req.setvalue(uid, "tasking", id)
    return ret
end
 
 ---对话结束
function assignmenthander:talkend(data)
    local ret = {}
    local uid = data.uid
    local id = data.msg.id
    local type = data.msg.type

    local usertask = usertask_dc.req.get(uid)
    if not id or not type or not next(usertask) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    
    if type == assignmentdefine.tasktype.day then
        local daytaskarr = string.split(usertask.daytask)
        if not table.find(daytaskarr, tostring(id)) then
            ret.code = errCodeDef.eEC_err_param
            return ret
        end
        local daytask = daytask_dc.req.get(id)
        local date_task = sharedata.deepcopy("date_task", daytask.cfgid)
        daytask.type = assignmentdefine.tasktype.finish
        get_award(uid, date_task.Task_Reward)
        daytask_dc.req.setvalue(id, "type", daytask.type)
    elseif type == assignmentdefine.tasktype.urgent then
        local urgenttaskarr = string.split(usertask.urgenttask)
        if not table.find(urgenttaskarr, tostring(id)) then
            ret.code = errCodeDef.eEC_err_param
            return ret
        end
        local urgenttask = urgenttask_dc.req.get(id)
        local urgent_task = sharedata.deepcopy("urgent_task", urgenttask.cfgid)
        urgenttask.type = assignmentdefine.tasktype.finish
        get_award(uid, urgent_task.Task_Reward)
        urgenttask_dc.req.setvalue(id, "type", urgenttask.type)
    elseif type == assignmentdefine.tasktype.plot then
        local plottaskarr = string.split(usertask.plottask)
        if not table.find(plottaskarr, tostring(id)) then
            ret.code = errCodeDef.eEC_err_param
            return ret
        end
        cs(recieveplot, uid, assignmentdefine.tasktype.plot, id)
    end
    return ret
end
 
 ---获取任务
function assignmenthander:gettask(data)
    local ret = {}
    ret.taskinfos = {}
    local uid = data.uid
    local type = data.msg.type

    local usertask = usertask_dc.req.get(uid)
    if not type or not next(usertask) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    
    if type == assignmentdefine.tasktype.day then
        local daytaskarr = string.split(usertask.daytask)
        for i = 1, #daytaskarr do
            local daytask = daytask_dc.req.get(tonumber(daytaskarr[i]))
           local progress = json.decode(daytask.progerss)
           local progress_arr = {}
           for j = 1, #progress do
            table.insert(progress_arr, {objectid = progress[j].objectid, number = progress[j].number})
        end
        table.insert(ret.taskinfos, {id = daytask.id, cfgid = daytask.cfgid, progress = progress_arr, state = daytask.type})
    end
    elseif type == assignmentdefine.tasktype.urgent then
        local urgenttaskarr = string.split(usertask.urgenttask)
        local curtime = timext.current_time()
        for i = 1, #urgenttaskarr do
            local urgenttask = urgenttask_dc.req.get(tonumber(urgenttaskarr[i]))
            if urgenttask.starttime <= curtime and urgenttask.endtime >= curtime then
                local progress = json.decode(urgenttask.progerss)
                local progress_arr = {}
                for j = 1, #progress do
                    table.insert(progress_arr, {objectid = progress[j].objectid, number = progress[j].number})
                end
                table.insert(ret.taskinfos, {id = urgenttask.id, cfgid = urgenttask.cfgid, progress = progress_arr, state = urgenttask.type, 
                countdown = usertask.endtime - curtime})
            end
        end
    elseif type == assignmentdefine.tasktype.plot then
        local plottaskarr = string.split(usertask.plottask)
        for i = 1, #plottaskarr do
            local plottask = daytask_dc.req.get(tonumber(plottaskarr[i]))
            local progress = json.decode(plottask.progerss)
            local istasking = false
            local progress_arr = {}
            for j = 1, #progress do
                table.insert(progress_arr, {objectid = progress[j].objectid, number = progress[j].number})
            end
            if usertask.tasking == tonumber(plottaskarr[i]) then
                istasking = true
            end
            table.insert(ret.taskinfos, {id = plottask.id, cfgid = plottask.cfgid, progress = progress_arr, state = plottask.type, 
            istasking = istasking})
        end
    end
    ret.code = errCodeDef.eEC_success
    return ret
end

return assignmenthander.new()