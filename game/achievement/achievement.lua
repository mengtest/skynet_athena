local skynet = require "skynet"
local snax = require "skynet.snax"
local sharedata = require "skynet.sharedata"
local errCodeDef = require "errcodedef"
local json = require "cjson"
local timext = require "timext"
local achievementhandler = require "game.achievement.achievehandler"

local athletics_dc
local plot_dc
local overview_dc
local challenge_dc
local collection_dc
local warehouse
local assignment


-- observerlist[uid][achid] = {taskid = T, tasktype = T}
local observerlist = {}

function response.getoverview(data)
    local ret = {}
    local uid = data.uid
    local overviewinfo = achievementhandler:getoverview(uid)
    if next(overviewinfo) then
        local achievelist = json.decode(overviewinfo.achievelist)
        local data = {}
        for i = 1, #achievelist do
            table.insert(data, {id = achievelist[i].id, finishtime = achievelist[i].finishtime})
        end
        ret.overviewinfo = {plotnum = overviewinfo.plotnum, athleticsnum = overviewinfo.athleticsnum,
        challengenum = overviewinfo.challengenum, achievelist = data}
        ret.code = errCodeDef.eEC_success
    else
        ret.code = errCodeDef.eEC_err_param
    end
    return ret
end

function response.receiveachieve(data)
    local ret = {}
    local uid = data.uid
    local index = data.msg.index                    --编号  
    local typeid = data.msg.typeid                  --成就类型id
    local id = data.msg.id                          --成就id
    
    if typeid == nil or id == nil or index == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = errCodeDef.eEC_success
    local datas = {}
    if index == achievementdefine.typelist.athletics then
        local getinfo = achievementhandler:getachieveinfo(index, typeid)
        local info = json.decode(getinfo.athleticslist or {})
        for i = 1, #info do
            if info[i].id == id and info[i].finishtime ~= nil then
                info[i].isget = true
            end
        end
        --实例化成就奖励
    elseif index == achievementdefine.typelist.challenge then
    elseif index == achievementdefine.typelist.plot then
    end
    return ret
end

---列表请求
function response.clickachieve(data)
    local ret = {}
    local uid = data.uid
    local index = data.msg.index
    ret.achieveinfos = {}

    if index < achievementdefine.typelist.plot or index > achievementdefine.typelist.other then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local dates, getvalue, achieve = {}, {}, {}
    local subnum = (uid - 1) * 1000
    if index == achievementdefine.typelist.athletics then
        dates = string.split(achievementhandler:getoverview(uid, "athletics"))
        for i = 1, #dates do
            getvalue = achievementhandler:getachieveinfoid(tonumber(dates[i]), index)
            achieve = json.decode(getvalue.athleticslist or {})
            for j = 1, #achieve do
                table.insert(ret.achieveinfos, {typeid = tonumber(dates[i]) - subnum, id = achieve[j].id, isget = achieve[j].isget, finishtime = achieve[j].finishtime, count = getvalue.count})
            end
        end
    elseif index == achievementdefine.typelist.challenge then
        dates = string.split(achievementhandler:getoverview(uid, "challenge"))
        for i = 1, #dates do
            getvalue = achievementhandler:getachieveinfoid(tonumber(dates[i]), index)
            achieve = json.decode(getvalue.challengelist or {})
            for j = 1, #achieve do
                table.insert(ret.achieveinfos, {typeid = tonumber(dates[i]) - subnum, id = achieve[j].id, isget = achieve[j].isget, finishtime = achieve[j].finishtime, count = getvalue.count})
            end
        end
    elseif index == achievementdefine.typelist.plot then
        dates = string.split(achievementhandler:getoverview(uid, "plot"))
        for i = 1, #dates do
            getvalue = achievementhandler:getachieveinfoid(tonumber(dates[i]), index)
            achieve = json.decode(getvalue.plotlist or {})
            for j = 1, #achieve do
                table.insert(ret.achieveinfos, {typeid = tonumber(dates[i]) - subnum, id = achieve[j].id, isget = achieve[j].isget, finishtime = achieve[j].finishtime, count = getvalue.count})
            end
        end
    end
    -- skynet.error(tostring(ret))
    ret.code = errCodeDef.eEC_success
    return ret
end

---更新竞技
function response.updateathletics(uid, id, sponsorid, number, reset, type)
    if id == nil or uid == nil then
        return false
    end
    number = number or 1
    type = type == nil and true or type
    if not assignment then
        assignment = snax.uniqueservice("assignment")
    end
    --通知观察者
    if observerlist[uid] and observerlist[uid][id] then
        assignment.req.pusheach(uid, id, number, observerlist[uid][id], reset, type, sponsorid)
    end
    return achievementhandler:updateathletics(uid, id, number, reset, type)
end

---更新挑战
function response.updatechallenge(uid, id, sponsorid, number, reset)
    if id == nil or uid == nil then
        return false
    end
    number = number or 1
    if not assignment then
        assignment = snax.uniqueservice("assignment")
    end
    --通知观察者
    if observerlist[uid] and observerlist[uid][id] then
        assignment.req.pusheach(uid, id, number, observerlist[uid][id], reset, true, sponsorid)
    end
    return achievementhandler:updatechallenge(uid, id, number, reset)
end

---更新剧情【未实现】
function response.updateplot(uid, id, number)
    if id == nil or uid == nil then
        return false
    end
    number = number or 1
    if not assignment then
        assignment = snax.uniqueservice("assignment")
    end
    --通知观察者
    --if observerlist[uid] and observerlist[uid][id] then
    --     assignment.req.pusheach(uid, id, number, observerlist[uid][id], reset, true, sponsorid)
    -- end
    return achievementhandler:updateplot(uid, id, number)
end

---更新总览如果更改的不是记录，则只传一个数值。
function response.updateoverview(uid, str, param)
    return achievementhandler:updateoverview(uid, str, param)
end

---获取一条成就记录
---@return boolean nil表示为空或失败
function response.getachieveinfo(uid, id, ty, key)
    return achievementhandler:getachieveinfo(uid, id, ty, key)
end

---获取一条成就记录
---@return boolean nil表示为空或失败
function response.getachieveinfoid(id, ty, key)
    return achievementhandler:getachieveinfoid(id, ty, key)
end

---添加观察者
---@param achid number 成就类型id
function response.addobserver(uid, achid, taskid, tasktype)
    if uid == nil or achid == nil or taskid == nil or tasktype == nil then
        LOG_ERROR("param is nil in addobserver uid: %d, achid: %d, taskid: %d, tasktype: %d", uid, achid, taskid, tasktype)
        return
    end
    if not observerlist[uid] then
        observerlist[uid] = {}
    end
    if not observerlist[uid][achid] then
        observerlist[uid][achid] = {}
    end
    table.insert(observerlist[uid][achid], {taskid = taskid, tasktype = tasktype})
end

---移除观察者
---@param achid number 成就类型id
function response.remobserver(uid, achid, taskid, tasktype)
    if uid == nil or achid == nil or taskid == nil or tasktype == nil then
        LOG_ERROR("param is nil in remobserver uid: %d, achid: %d, taskid: %d, tasktype: %d", uid, achid, taskid, tasktype)
        return
    end
    if not observerlist[uid] or not observerlist[uid][achid] then
        return
    end
    for key, value in pairs(observerlist[uid][achid]) do
        if value.taskid == taskid and value.tasktype == tasktype then
            table.remove(observerlist[uid][achid], key)
            break
        end
    end
end

function init(...)
    athletics_dc = snax.queryservice("athleticsdc")
	plot_dc = snax.queryservice("plotdc")
	challenge_dc = snax.queryservice("challengedc")
    overview_dc = snax.queryservice("overviewdc")
    collection_dc = snax.queryservice("collectiondc")
    warehouse = snax.uniqueservice("warehouse")
    achievementhandler:initachievehandler(plot_dc, overview_dc, challenge_dc, collection_dc, athletics_dc)
end

function exit(...)
end

function response.online(uid, fd)
end

function response.offline(uid)
    -- skynet.error("observer:", tostring(observerlist[uid]))
    -- observerlist[uid] = nil
end