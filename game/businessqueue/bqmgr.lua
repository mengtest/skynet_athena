local bqmgr = class("bqmgr")
local snax = require "skynet.snax"
local skynet = require "skynet"
local sharedata = require "skynet.sharedata"
local queue = require "skynet.queue"
local timext = require "timext"
local json = require"cjson"
local bq_dc
local queue_dc
local awardinfo_dc
local tmpbq_dc
local cs = queue()

function bqmgr:ctor()
    
end

function bqmgr:get()

end

---@return table
local function get_airfreighter(uid, index)
    local curqinfo = queue_dc.req.get(uid)
    local cur_airfreighter = string.split(curqinfo["airfreighter"..tostring(index)], ",")
    return cur_airfreighter
end

--- 获取该行运输机队末的队列id
local function getlast_bqid_byindex(uid, index)
    if not index then
        return nil
    end
    local curqinfo = queue_dc.req.get(uid)
    local cur_airfreighter = string.split(curqinfo["airfreighter"..tostring(index)], ",")
    if #cur_airfreighter > 0 then
        return cur_airfreighter[#cur_airfreighter]
    else
        return nil
    end
end

--- 运输机数量是否已满
local function isfullbq(uid, index)
    local curqinfo = queue_dc.req.get(uid)

    local cur_airfreighter = string.split(curqinfo["airfreighter"..tostring(index)], ",")
    local maxperairfreighter  = curqinfo.maxperairfreighter
    if #cur_airfreighter < maxperairfreighter then
        return false
    end

    return true
end

-- 返回最后一个队列的时间
local function get_shortest_time_per_airfreighter(uid, index)
    local shortest_time = -1
    local airfreighters = string.split(queue_dc.req.getvalue(uid, "airfreighter"..tostring(index)))
    if #airfreighters == 0 then
        -- 空槽位直接冲
        return 0
    end

    -- 返回最末尾时间
    return bq_dc.req.getvalue(airfreighters[#airfreighters], "endtime")
end

---@param isargtime boolean true返回时间，false返回index
local function get_shortest(uid, isargtime)
    local maxairfreighter = queue_dc.req.get(uid).maxairfreighter
    local short_timelist = {}
    local tmplist = {}
    for i = 1, maxairfreighter do
        local timeinfo = {}
        timeinfo.time = get_shortest_time_per_airfreighter(uid, i)
        timeinfo.index = i
        if not isfullbq(uid, i) then
            table.insert(short_timelist, timeinfo)
        else
            table.insert(tmplist, timeinfo)
        end 
    end

    -- 表单排序
    table.sort(short_timelist, function(a,b)
        return a.time<b.time 
    end )

    table.sort(tmplist, function(a,b)
        return a.time<b.time 
    end )

    if isargtime then
        if #short_timelist == 0 and #tmplist == maxairfreighter then
            return tmplist[1].time 
        end
        return short_timelist[1].time      
    else
        if #short_timelist == 0 and #tmplist == maxairfreighter then
            return nil 
        end
        return short_timelist[1].index
    end
end

local function get_shortest_atime(uid)
    return get_shortest(uid, true)
end

local function get_shortest_airfreighter(uid)
    return get_shortest(uid, false)
end

local function getbusinessqueue(bqid)
    return bq_dc.req.get(bqid)
end

-- request {
--     airfreighterinfo 0: *airfreighterinfo
-- }

-- .bqsimpleinfo {
--     bqid 0: integer    #队列id
--     endtime 1: integer    #结束时间
-- }

-- .airfreighterinfo {
--     bqinfos 0: *bqsimpleinfo   #该运输机队列的所有队列包
-- }

function bqmgr:get_all_airfreighter_sinfo(uid)
    local curqinfo = queue_dc.req.get(uid)
    local maxairfreighter = tonumber(curqinfo.maxairfreighter)
    local ret = {}
    for i = 1, maxairfreighter do
        local per_airfreighter = {}
        per_airfreighter.bqinfos = {}
        local cur_airfreighter = string.split(curqinfo["airfreighter"..tostring(i)], ",")
        
        for j = 1, #cur_airfreighter do
            local perbq = {}
            perbq.bqid = tonumber(cur_airfreighter[j])
            perbq.endtime = bq_dc.req.getvalue(cur_airfreighter[j], "endtime")
            
            table.insert(per_airfreighter.bqinfos, perbq)
        end
        table.insert(ret, per_airfreighter)
    end
    return ret
end

-- bq_dc = snax.queryservice("businessqueuedc")
-- queue_dc = snax.queryservice("queueinfodc")
-- awardinfo_dc = snax.queryservice("awardinfodc")
-- tmpbq_dc = snax.queryservice("tmpbqinfodc")
-- bqmgr:update_bqdc(bq_dc, queue_dc, awardinfo_dc, tmpbq_dc)
-- 以对象函数得方式传数据库服务过来调用
function bqmgr:update_bqdc(bqdc, queuedc, awardinfodc, tmpbqdc)
    if bqdc.type ~= "businessqueuedc" then
        return
    end
    bq_dc = bqdc
    queue_dc = queuedc
    awardinfo_dc = awardinfodc
    tmpbq_dc = tmpbqdc
end

-- .businessqueueinfo {
--     id 0 : integer	#流水id
--     type 1 : integer #类型 
--     subtype 2 : integer #子类型
--     starttime 3 : integer #开始时间
--     endtime 4 : integer #当前结束时间
--     initendtime 5 : integer #结束时间(初始)
--     bprewardlist 6 : *blueprintinfo # 奖励蓝图列表
--     proprewardlist 7 : *propinfo # 奖励材料列表
--     sponsorid 9 ： string    # 发起请求的id "0"表示无
-- }

-- time单位为秒哦，
function bqmgr:newbusinessqueue(type, subtype, bprewardlist, proprewardlist, equiplist, time, uid, sponsorid)
    -- 入库
    local row = {}
    local nextid = bq_dc.req.get_nextid()
    row.id = nextid
    row.playerid = uid
    row.type = type
    row.subtype = subtype
    row.bprewardlist = json.encode(bprewardlist or {})
    row.proprewardlist = json.encode(proprewardlist or {})
    row.equiplist = json.encode(equiplist or {})
    row.sponsorid = tostring(sponsorid)
    local bqtail_index = getlast_bqid_byindex(uid, subtype)
    
    -- 运输机排队
    if type == businessdefine.businessType.airfreighter and bqtail_index then
        local bqtial_endtime = bq_dc.req.getvalue(bqtail_index, "endtime")
        row.starttime = tonumber(bqtial_endtime)
        row.endtime = row.starttime + time
        row.initendtime = row.endtime
    else
        row.starttime = timext.current_time()
        row.endtime = row.starttime + time
        row.initendtime = row.endtime
    end
    
    bq_dc.req.add(row)
    local queueinfo = queue_dc.req.get(uid)
    if type == businessdefine.businessType.airfreighter then
        queue_dc.req.setvalue(uid, "airfreighter"..tostring(subtype), 
            queueinfo["airfreighter"..tostring(subtype)] == "" and nextid or (queueinfo["airfreighter"..tostring(subtype)] .. "," .. nextid))
    elseif type == businessdefine.businessType.scan then
        queue_dc.req.setvalue(uid, "ingscan", queueinfo.ingscan == "" and nextid or (queueinfo.ingscan .. "," .. nextid))
    elseif type == businessdefine.businessType.cast then
        queue_dc.req.setvalue(uid, "ingcasting", queueinfo.ingcasting == "" and nextid or (queueinfo.ingcasting .. "," .. nextid))
    end

    skynet.timeout((row.endtime - timext.current_time()) * 100, function()
        cs(self.onbq_completed, self, row.id)
    end)

    return row.id
end

-- 是否当前队列已满
function bqmgr:isfullbq(uid, index)
    return isfullbq(uid, index)
end

function bqmgr:getbusinessqueue(bqid)
    return getbusinessqueue(bqid)
end

-- 返回一个index
function bqmgr:get_shortest_airfreighter(uid)
    return get_shortest_airfreighter(uid)
end

-- 返回一个时间
function bqmgr:get_shortest_atime(uid)
    return get_shortest_atime(uid)
end

-- 从数据库重新拉起所有队列
function bqmgr:reflagallbq()
    local allqueueinfo = bq_dc.req.get_all_members()

    for i = 1, #allqueueinfo do
        local _, queueid = allqueueinfo[i]:match "([^.]*):(.*)"

        if queueid == "id" then
            goto continue
        end

        local perqueue = self:getbusinessqueue(queueid)

        -- 队列时间已到则下发奖励，未到则开始计时
        if timext.current_time() > perqueue.endtime then
            cs(self.onbq_completed, self, tonumber(queueid))
        else
            skynet.timeout((perqueue.endtime - timext.current_time()) * 100, function() 
                cs(self.onbq_completed, self, tonumber(queueid))
            end)
        end
        ::continue::
    end
end

--- 移除表中数据
local function remove_array(arr, id)
    for i = 1, #arr do
        if tostring(arr[i]) == tostring(id) then
            table.remove(arr, i)
            return arr
        end
    end
end

-- ["proprewardlist"] = "[{\"lv\": 0, \"type\": 7, \"cfgid\": 10001, \"number\": 25}, {\"lv\": 0, \"type\": 7, \"cfgid\": 10003, \"number\": 1}]",
--         ["playerid"] = 18,
--         ["initendtime"] = 1596096997,
--         ["endtime"] = 1596096997,
--         ["subtype"] = 0,
--         ["equiplist"] = "{}",
--         ["id"] = 11,
--         ["bprewardlist"] = "{}",
--         ["starttime"] = 1596095557,
--         ["type"] = 1,

-- 队列完成，入库，下发奖励
function bqmgr:onbq_completed(bqid)
    --加速处理队列不可取消 扫描/铸造需用户请求领取
    local businessqueue = getbusinessqueue(bqid)
    if not next(businessqueue) then
        return
    end
    skynet.error("businessqueue end", bqid)

    local scan = snax.queryservice("scan")
    local warehouse = snax.queryservice("warehouse")
    local chip = snax.queryservice("chip")
    if businessqueue.type == businessdefine.businessType.cast or businessqueue.type == businessdefine.businessType.scan then
        local nextid = awardinfo_dc.req.get_nextid()
        if businessqueue.type == businessdefine.businessType.cast then
            scan.req.removeto_end(businessqueue.playerid, tostring(businessqueue.sponsorid), bqid, nextid)
            send_request(get_user_fd(businessqueue.playerid), {id = businessqueue.sponsorid, awardid = nextid, bqid = bqid}, "scan_finishcasting")  
        else
            send_request(get_user_fd(businessqueue.playerid), {id = businessqueue.sponsorid, awardid = nextid, bqid = bqid}, "scan_finishscan")  
        end 
        cs(self.delbusinessqueue, self, bqid, nextid)
        return
    end

    -- 侧边栏通知。离线期间缓存好的队列信息，队列跑完的时候应该缓存到表中
    local isonline = check_user_online(businessqueue.playerid)
    if not isonline then
        local row = {}
        local nextid = tmpbq_dc.req.get_nextid()
        row.id = nextid
        row.rawid = bqid
        row.subtype = businessqueue.subtype
        row.bprewardlist = businessqueue.bprewardlist
        row.proprewardlist = businessqueue.proprewardlist
        row.equiplist = businessqueue.equiplist

        tmpbq_dc.req.add(row)
        local curtmpbqinfos = queue_dc.req.getvalue(businessqueue.playerid, "tmpbqinfos")
        if curtmpbqinfos == "" then
            curtmpbqinfos = curtmpbqinfos .. nextid
        else
            curtmpbqinfos = curtmpbqinfos .. "," .. nextid
        end
        queue_dc.req.setvalue(businessqueue.playerid, "tmpbqinfos", curtmpbqinfos)
    else
        send_request(get_user_fd(businessqueue.playerid), {bqindex = businessqueue.subtype,
                                        rawid = bqid,
                                        bprewardlist = json.decode(businessqueue.bprewardlist), 
                                        proprewardlist = json.decode(businessqueue.proprewardlist), 
                                        equiplist = json.decode(businessqueue.equiplist)}, "bqproxy_onbqfinished")  
    end


    -- 蓝图奖励
    if businessqueue.bprewardlist then
        local bprewardlist = json.decode(businessqueue.bprewardlist)
        for i = 1, #bprewardlist do
            scan.req.addblueprint(businessqueue.playerid, bprewardlist[i].cfgid, bprewardlist[i].number)
        end
    end

    -- 材料/芯片奖励
    if businessqueue.proprewardlist then
        local proprewardlist = json.decode(businessqueue.proprewardlist)
        for i = 1, #proprewardlist do
            -- 加材料
            if proprewardlist[i].type == warehousedefine.warehousetype.material then
                warehouse.req.addmaterials(businessqueue.playerid, proprewardlist[i].cfgid, proprewardlist[i].number)
            elseif proprewardlist[i].type == warehousedefine.warehousetype.chip then
                chip.req.addchip(businessqueue.playerid, proprewardlist[i].cfgid, proprewardlist[i].lv, proprewardlist[i].number)
            end
        end
    end

    -- 装备部位奖励
    if businessqueue.equiplist then
        local equiplist = json.decode(businessqueue.equiplist)

        -- for i = 1, #equiplist do
        --     -- body
        -- end
    end
    cs(self.delbusinessqueue, self, bqid)
end

function bqmgr:delbusinessqueue(bqid, nextid)
    local businessqueue = getbusinessqueue(bqid)
    if businessqueue then
        local queueinfo = queue_dc.req.get(businessqueue.playerid)
        if businessqueue.type == businessdefine.businessType.cast or businessqueue.type == businessdefine.businessType.scan then
            awardinfo_dc.req.add({id = nextid, bprewardlist = businessqueue.bprewardlist, proprewardlist = businessqueue.proprewardlist,
                                    equiplist = businessqueue.equiplist, sponsorid = businessqueue.sponsorid})
            if businessqueue.type == businessdefine.businessType.cast then
                queue_dc.req.setvalue(businessqueue.playerid, "ingcasting", string.join(remove_array(string.split(queueinfo.ingcasting), bqid)))
                queue_dc.req.setvalue(businessqueue.playerid, "endcasting", queueinfo.endcasting == "" and nextid or (queueinfo.endcasting .. "," .. nextid))
            else
                queue_dc.req.setvalue(businessqueue.playerid, "ingscan", string.join(remove_array(string.split(queueinfo.scan), bqid)))
                queue_dc.req.setvalue(businessqueue.playerid, "endscan", queueinfo.endscan == "" and nextid or (queueinfo.endscan .. "," .. nextid))
            end 
        else
            local curbqinfos = remove_array(string.split(queueinfo["airfreighter"..tostring(businessqueue.subtype)]), bqid)
            queue_dc.req.setvalue(businessqueue.playerid, "airfreighter"..tostring(businessqueue.subtype), 
                        string.join(curbqinfos))
        end
        bq_dc.req.delete(businessqueue)
    end
end

function bqmgr:addspeed(bqid, difftime)
    local bqinfo = self:getbusinessqueue(bqid)
    bqinfo.endtime = bqinfo.endtime - difftime

    bq_dc.req.setvalue(bqid, "endtime", bqinfo.endtime)

    if timext.current_time() >= bqinfo.endtime then
        cs(self.onbq_completed, self, bqid)
    else
        skynet.timeout((bqinfo.endtime - timext.current_time()) * 100, function() 
            cs(self.onbq_completed, self, bqid)
        end)
    end
    return bqinfo.starttime, bqinfo.endtime
end

function bqmgr:onlined(uid)
    -- 下发缓存信息后删除, 暂时只有玩家离线后才进缓存
    local tmpbqinfos = string.split(queue_dc.req.getvalue(uid, "tmpbqinfos"))
    if #tmpbqinfos == 0 then
        return
    end

    for i = #tmpbqinfos, 1, -1 do
        local tmpbqinfo = tmpbq_dc.req.get(tmpbqinfos[i])
        send_request(get_user_fd(uid), {bqindex = tmpbqinfo.subtype,
                                        rawid = tmpbqinfo.rawid,
                                        bprewardlist = json.decode(tmpbqinfo.bprewardlist or {}), 
                                        proprewardlist = json.decode(tmpbqinfo.proprewardlist or {}), 
                                        equiplist = json.decode(tmpbqinfo.equiplist or {})}, "bqproxy_onbqfinished")
        tmpbq_dc.req.delete({id = tmpbqinfo.id})
    end

    -- 已下发，清空！
    queue_dc.req.setvalue(uid, "tmpbqinfos", "")
    
end

function bqmgr:updatebusinessqueue(bqid, newbusinessqueueinfo)
end

return bqmgr.new()