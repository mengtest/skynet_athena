local achievehandler = class("achievehandler")
local skynet = require "skynet"
local sharedata = require "skynet.sharedata"
local json = require "cjson"
local timext = require "timext"


local plot_dc
local overview_dc
local challenge_dc
local collection_dc
local athletics_dc


function achievehandler:ctor()
end

function achievehandler:initachievehandler(plot, over, chall, coll, athl)
    plot_dc, overview_dc, challenge_dc, collection_dc, athletics_dc = plot, over, chall, coll, athl
end

---更新竞技
---@param id number 表示成就类别id
---@param reset boolean 表示直接赋值不累计nil表示累计false表示要比大小
---@param type boolean false保存小的默认为true
---@return boolean false表示参数错误
function achievehandler:updateathletics(uid, id, number, reset, type)
    local uniqueid = (uid - 1) * 1000 + id
    local athleticsinfo = athletics_dc.req.get(uniqueid)
    if next(athleticsinfo) then
        if athleticsinfo.uid ~= uid then
            skynet.error(string.format("error user: %d not athletics %d", uid, uniqueid))
            LOG_INFO(string.format("error user: %d not athletics %d", uid, uniqueid))
            return false
        end
        if reset then
            athleticsinfo.count = number
        elseif reset == nil then
            athleticsinfo.count = athleticsinfo.count + number
        else
            if type then
                athleticsinfo.count = athleticsinfo.count >= number and athleticsinfo.count or number
            else
                athleticsinfo.count = athleticsinfo.count <= number and athleticsinfo.count or number
            end
        end
        local athleticslist = json.decode(athleticsinfo.athleticslist)
        -- while true do
        --     local cfginfo = sharedata.deepcopy("", tonumber(athleticslist[#athleticslist].id))   --成就表中查找条件
        --     if cfginfo.count > athleticsinfo.count then
        --         break
        --     else
        --         athleticslist[#athleticslist].finishtime = timext.current_time()
        --         if cfginfo.nextid == nil or cfginfo.nextid == 0 then
        --             break
        --         end
        --         achievehandler:updateoverview(uid, "athleticsnum")
        --         achievehandler:updateoverview(uid, "achievelist", tonumber(athleticslist[#athleticslist]))
        --         table.insert(athleticslist, {id = cfginfo.nextid, isget = false})
        --     end
        -- end
        athleticsinfo.athleticslist = json.encode(athleticslist)
        athletics_dc.req.update(athleticsinfo)
    else
        local overviewinfo = overview_dc.req.get(uid)
        local athletics = string.split(overviewinfo.athletics)
        -- local cfginfo = sharedata.deepcopy("", tonumber(id))   --成就类别表中查找条件
        -- local achieveid = cfginfo.achievelist[1]               --获取第一个成就
        -- --【注意】将下列id改为achieveid
        local data = {id = uniqueid, athleticslist = json.encode({{id = id, isget = false, finishtime = nil}}), count = number, uid = uid}
        athletics_dc.req.add(data)
        table.insert(athletics, uniqueid)
        achievehandler:updateoverview(uid, "athletics", string.join(athletics))
    end
    -- send_request(get_user_fd(uid), {index = warehousedefine.synctype.khorium, curnum = khorium}, "warehouse_sync")
    return true
end

---更新挑战
---@param id number 表示成就类别id
---@param reset boolean 表示直接赋值不累计nil表示累计false表示要比大小
---@return boolean false表示参数错误
function achievehandler:updatechallenge(uid, id, number, reset)
    local uniqueid = (uid - 1) * 1000 + id
    local challengeinfo = challenge_dc.req.get(uniqueid)
    if next(challengeinfo) then
        if challengeinfo.uid ~= uid then
            skynet.error(string.format("error user: %d not challenge %d", uid, uniqueid))
            LOG_INFO(string.format("error user: %d not challenge %d", uid, uniqueid))
            return false
        end
        if reset == true then
            challengeinfo.count = number
        elseif reset == nil then
            challengeinfo.count = challengeinfo.count + number
        else
            challengeinfo.count = challengeinfo.count >= number and challengeinfo.count or number
        end
        local challengelist = json.decode(challengeinfo.challengelist)
        -- while true do
        --     local cfginfo = sharedata.deepcopy("", tonumber(challengelist[#challengelist].id))   --成就表中查找条件
        --     if cfginfo.count > challengeinfo.count then
        --         break
        --     else
        --         challengelist[#challengelist].finishtime = timext.current_time()
        --         if cfginfo.nextid == nil or cfginfo.nextid == 0 then
        --             break
        --         end
        --         achievehandler:updateoverview(uid, "challengenum")
        --         achievehandler:updateoverview(uid, "achievelist", tonumber(challengelist[#challengelist]))
        --         table.insert(challengelist, {id = cfginfo.nextid, isget = false})
        --     end
        -- end
        challengeinfo.challengelist = json.encode(challengelist)
        challenge_dc.req.update(challengeinfo)
    else
        local overviewinfo = overview_dc.req.get(uid)
        local challenge = string.split(overviewinfo.challenge)
        -- local cfginfo = sharedata.deepcopy("", tonumber(id))   --成就类别表中查找条件
        -- local achieveid = cfginfo.achievelist[1]               --获取第一个成就
        -- --【注意】将下列id改为achieveid
        local data = {id = uniqueid, challengelist = json.encode({{id = id, isget = false, finishtime = nil}}), count = number, uid = uid}
        challenge_dc.req.add(data)
        table.insert(challenge, uniqueid)
        achievehandler:updateoverview(uid, "challenge", string.join(challenge))
    end
    -- send_request(get_user_fd(uid), {index = warehousedefine.synctype.khorium, curnum = khorium}, "warehouse_sync")
    return true
end

---更新剧情【未实现】
---@param id number 表示成就类别id
---@return boolean false表示参数错误
function achievehandler:updateplot(uid, id, number)
    local uniqueid = (uid - 1) * 1000 + id
    local plotinfo = plot_dc.req.get(uniqueid)
    if next(plotinfo) then
        if plotinfo.uid ~= uid then
            skynet.error(string.format("error user: %d not plot %d", uid, uniqueid))
            LOG_INFO(string.format("error user: %d not plot %d", uid, uniqueid))
            return false
        end
        plotinfo.count = plotinfo.count + number
        local plotlist = json.decode(plotinfo.plotlist)
        -- while true do
        --     local cfginfo = sharedata.deepcopy("", tonumber(plotlist[#plotlist].id))   --成就表中查找条件
        --     if cfginfo.count > athleticsinfo.count then
        --         break
        --     else
        --         plotlist[#plotlist].finishtime = timext.current_time()
        --         if cfginfo.nextid == nil or cfginfo.nextid == 0 then
        --             break
        --         end
        --         achievehandler:updateoverview(uid, "athleticsnum")
        --         achievehandler:updateoverview(uid, "achievelist", tonumber(plotlist[#plotlist]))
        --         table.insert(plotlist, {id = cfginfo.nextid, isget = false})
        --     end
        -- end
        plotinfo.plotlist = json.encode(plotlist)
        athletics_dc.req.update(plotinfo)
    else
        local overviewinfo = overview_dc.req.get(uid)
        local plot = string.split(overviewinfo.plot)
        -- local cfginfo = sharedata.deepcopy("", tonumber(id))   --成就类别表中查找条件
        -- local achieveid = cfginfo.achievelist[1]               --获取第一个成就
        -- --【注意】将下列id改为achieveid
        local data = {id = uniqueid, plotlist = json.encode({{id = id, isget = false, finishtime = nil}}), count = number, uid = uid}
        plot_dc.req.add(data)
        table.insert(plot, uniqueid)
        achievehandler:updateoverview(uid, "plot", string.join(plot))
    end
    -- send_request(get_user_fd(uid), {index = warehousedefine.synctype.khorium, curnum = khorium}, "warehouse_sync")
    return true
end

---更新总览如果更改的不是记录，则只传一个数值
---@param str string 表示要修改的字段
---@param param number 表示参数
---@return boolean false表示参数错误
function achievehandler:updateoverview(uid, str, param)
    if param == nil or uid == nil or str == nil then
        return false
    end

    local overviewinfo = overview_dc.req.get(uid)
    if next(overviewinfo) then
        if str == "achievelist" then
            local achievelist = json.decode(overviewinfo.achievelist)
            achievelist[overviewinfo.current + 1] = {id = param, finishtime = timext.current_time()}
            overviewinfo.current = (overviewinfo.current + 1) % 5
            overview_dc.req.setvalue(uid, "current", overviewinfo.current)
            overview_dc.req.setvalue(uid, "achievelist", json.encode(achievelist))
        else
            overview_dc.req.setvalue(uid, str, param)
        end
    else
        overview_dc.req.add({id = uid, plotnum = 0, athleticsnum = 0, challengenum = 0, plot = "", athletics = "", challenge = "", current = 1, achievelist = json.encode({})})
    end
    -- send_request(get_user_fd(uid), {index = warehousedefine.synctype.khorium, curnum = khorium}, "warehouse_sync")
    return true
end

---根据id获取一条成就记录
---@param id number 表示成就id
---@param ty number 表示成就类型为枚举类型
---@param key number 表示获取此字段数值为空表示整个数据
---@return table nil表示为空或失败
function achievehandler:getachieveinfoid(id, ty, key)
    if id == nil or ty == nil then
        return nil
    end
    id = tonumber(id)
    local datedc = {}
    if ty == achievementdefine.typelist.athletics then
        datedc = athletics_dc
    elseif ty == achievementdefine.typelist.challenge then
        datedc = challenge_dc
    elseif ty == achievementdefine.typelist.plot then
        datedc = plot_dc
    elseif ty == achievementdefine.typelist.other then
        return nil   ---【暂时未完成】
    end
    
    return key == nil and datedc.req.get(id) or datedc.req.getvalue(id, key)
end

---自动组合id获取一条成就记录
---@param uid number 表示用户id
---@param id number 表示成就类型id
---@param ty number 表示成就类型为枚举类型
---@param key number 表示获取此字段数值为空表示整个数据
---@return table nil表示为空或失败
function achievehandler:getachieveinfo(uid, id, ty, key)
    if id == nil or uid == nil or ty == nil then
        return nil
    end
    --因为数据库设计时，挑战、竞技、剧情都是1000个。
    local keyid = (uid - 1) * 1000 + id
    local datedc = {}
    if ty == achievementdefine.typelist.athletics then
        datedc = athletics_dc
    elseif ty == achievementdefine.typelist.challenge then
        datedc = challenge_dc
    elseif ty == achievementdefine.typelist.plot then
        datedc = plot_dc
    elseif ty == achievementdefine.typelist.other then
        return nil   ---【暂时未完成】
    end
    return key == nil and datedc.req.get(keyid) or datedc.req.getvalue(keyid, key)
end

---获取一条总览信息
---@param uid number 表示用户id
---@param key number 表示获取此字段数值为空表示整个数据
---@return table nil表示为空或失败
function achievehandler:getoverview(uid, key)
    if uid == nil then
        return nil
    end
    if key == nil then
        return overview_dc.req.get(uid)
    else
        return overview_dc.req.getvalue(uid, key)
    end
end

return achievehandler.new()