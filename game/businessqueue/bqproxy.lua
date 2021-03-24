local skynet = require "skynet"
local snax = require "skynet.snax"
local sharedata = require "skynet.sharedata"
local errCodeDef = require "errcodedef"
local bqmgr = require("game.businessqueue.bqmgr")
local rewardhandler = require("game.businessqueue.rewardhandler")
local json = require"cjson"


local bq_dc
local queue_dc
local awardinfo_dc
local tmpbq_dc

function init(...)
    bq_dc = snax.queryservice("businessqueuedc")
    queue_dc = snax.queryservice("queueinfodc")
    awardinfo_dc = snax.queryservice("awardinfodc")
    tmpbq_dc = snax.queryservice("tmpbqinfodc")
    bqmgr:update_bqdc(bq_dc, queue_dc, awardinfo_dc, tmpbq_dc)
    -- rewardhandler:init()
    bqmgr:reflagallbq()
end

-- .businessqueueinfo {
--     id 0 : integer	#流水id
--     type 1 : integer #类型
--     subtype 2 : integer #子类型
--     starttime 3 : integer #开始时间
--     endtime 4 : integer #当前结束时间
--     initendtime 5 : integer #结束时间(初始)
--     bprewardlist 6 : *bpreward # 奖励蓝图列表
--     proprewardlist 7 : *propreward # 奖励材料列表
--     equiplist 8 : *equipreward # 奖励装备列表
--     sponsorid 9 ： integer    # 发起请求的id 0表示无
-- }id

-- 下发战斗奖励
function response.sendbattle_reward(uid, stageid, iswinner)
    local queuemsg = {}
    local rewardinfo_battle = rewardhandler:getrewardinfo_battle(stageid, iswinner)
    local chip = snax.queryservice("chip")
    local hangarsvr = snax.queryservice("hangar")
    if not rewardinfo_battle then
        skynet.error("no find rewardhandler:getrewardinfo_battle info in [drop_list]!!!!!!!!!!")
        return
    end

    hangarsvr.req.add_curmachine_exp(uid, rewardinfo_battle.exp)

    local warehousesvr = snax.queryservice("warehouse")
    warehousesvr.req.addgold(uid, rewardinfo_battle.gold)
    
    -- 为空直接退出
    if not next(rewardinfo_battle.bprewardlist) and not next(rewardinfo_battle.proprewardlist) then
        return
    end
    
    -- 检出芯片，不走队列
    for i = #rewardinfo_battle.proprewardlist, 1, -1 do
        local propreward = rewardinfo_battle.proprewardlist[i]
        if propreward.type == warehousedefine.warehousetype.chip then
            chip.req.addchip(uid, propreward.cfgid, propreward.lv, propreward.number)
            table.remove(rewardinfo_battle.proprewardlist, i)
        end
    end

    -- 运输机的subtype表示第几行队列
    local subtype = bqmgr:get_shortest_airfreighter(uid)

    if not subtype then
        -- 运输机队列满了给这人发个最短的时间
        local time = bqmgr:get_shortest_atime(uid)
        send_request(get_user_fd(uid), {shortesttime = time}, "battleproxy_bqfulled")
        return
    end

    local newqueueid = bqmgr:newbusinessqueue(businessdefine.businessType.airfreighter, subtype, 
            rewardinfo_battle.bprewardlist, rewardinfo_battle.proprewardlist, nil, 
            rewardinfo_battle.transporttime, uid, 0)
            
    local queueinfo = bqmgr:getbusinessqueue(newqueueid)
    queueinfo.equiplist = json.decode(queueinfo.equiplist)
    queueinfo.proprewardlist = json.decode(queueinfo.proprewardlist)
    queueinfo.bprewardlist = json.decode(queueinfo.bprewardlist)
    queueinfo.index = businessdefine.indextype.battle
    queuemsg.businessqueueinfo = queueinfo
    send_request(get_user_fd(uid), queuemsg, "battleproxy_reward")
end

-- 铸造
function response.sendcasting(uid, bpid, number)
    local castinginfo = rewardhandler:getcastring_info(bpid, number)

    local newqueueid = bqmgr:newbusinessqueue(businessdefine.businessType.cast, nil, 
                        castinginfo.bprewardlist, castinginfo.proprewardlist, castinginfo.equiplist, 
                        castinginfo.transporttime, uid, bpid)
    local queueinfo = bqmgr:getbusinessqueue(newqueueid)
    return newqueueid, queueinfo.starttime, queueinfo.endtime
end

-- 扫描
function response.sendscan(uid, machineid)
    local castinginfo = rewardhandler:getscan_info(machineid)
    local newqueueid = bqmgr:newbusinessqueue(businessdefine.businessType.scan, nil, 
                        castinginfo.bprewardlist, castinginfo.proprewardlist, castinginfo.equiplist, 
                        castinginfo.transporttime, uid, machineid)
    local queueinfo = bqmgr:getbusinessqueue(newqueueid)

    local machinecfg_dc = snax.queryservice("machinecfgdc")
    machinecfg_dc.req.setvalue(machineid, "begintime", queueinfo.starttime)
    machinecfg_dc.req.setvalue(machineid, "endtime", queueinfo.endtime)

    return newqueueid, queueinfo.starttime, queueinfo.endtime
end

---中转站运输机
function response.sendshopmarke(uid, data)
    local queuemsg = {}
    if data == nil then
        return false
    end
    local shopinfo = rewardhandler:getshopmarket_info(data)

    -- 运输机的subtype表示第几行队列
    local subtype = bqmgr:get_shortest_airfreighter(uid)
    if not subtype then
        -- 运输机队列满了给这人发个最短的时间
        local time = bqmgr:get_shortest_atime(uid)
        send_request(get_user_fd(uid), {shortesttime = time}, "battleproxy_bqfulled")
        return false
    end
    local newqueueid = bqmgr:newbusinessqueue(businessdefine.businessType.airfreighter, subtype, 
        shopinfo.bprewardlist, shopinfo.proprewardlist, shopinfo.equiplist, 
        shopinfo.transporttime, uid, 0)
    local queueinfo = bqmgr:getbusinessqueue(newqueueid)
    queueinfo.equiplist = json.decode(queueinfo.equiplist)
    queueinfo.proprewardlist = json.decode(queueinfo.proprewardlist)
    queueinfo.bprewardlist = json.decode(queueinfo.bprewardlist)
    queueinfo.index = businessdefine.indextype.transfer
    queuemsg.businessqueueinfo = queueinfo
    send_request(get_user_fd(uid), queuemsg, "battleproxy_reward")
    return true
end

-- 加速
function response.sendspeed(id, difftime)
    return bqmgr:addspeed(id, difftime)
end

function response.getbqinfo(data)
    local msg = {}
    msg.businessqueueinfo = {}
    msg.code = errCodeDef.eEC_success
    local queuedata = bqmgr:getbusinessqueue(data.msg.bqid)
    
    if not next(queuedata) then
        msg.code = errCodeDef.eEC_cfgid_nofind
        return msg
    end
    msg.businessqueueinfo.id = queuedata.id
    msg.businessqueueinfo.type = queuedata.type
    msg.businessqueueinfo.subtype = queuedata.subtype
    msg.businessqueueinfo.starttime = queuedata.starttime
    msg.businessqueueinfo.endtime = queuedata.endtime
    msg.businessqueueinfo.initendtime = queuedata.initendtime
    msg.businessqueueinfo.bprewardlist = json.decode(queuedata.bprewardlist)
    msg.businessqueueinfo.proprewardlist = json.decode(queuedata.proprewardlist)
    msg.businessqueueinfo.equiplist = json.decode(queuedata.equiplist)
    return msg
end

---取消
function response.removebq(data)
    local msg = {}
    msg.businessqueueinfo = {}

    local queuedata = bqmgr:getbusinessqueue(data.msg.bqid)

    if queuedata and queuedata.playerid == data.uid then
        local shop = snax.queryservice("shop")
        local bprewardlist = json.decode(queuedata.bprewardlist)
        local proprewardlist = json.decode(queuedata.proprewardlist)
        -- local equiplist = json.decode(queuedata.equiplist)

        for key, value in pairs(bprewardlist) do
            shop.req.trancancel(data.uid, warehousedefine.warehousetype.blueprint, value.cfgid, value.iskh, value.number, value.price)
        end
        for key, value in pairs(proprewardlist) do
            shop.req.trancancel(data.uid, value.type, value.cfgid, value.iskh, value.number)
        end
        bqmgr:delbusinessqueue(data.msg.bqid)
        msg.code = errCodeDef.eEC_success
        return msg
    end

    msg.code = errCodeDef.eEC_err_param
    return msg
end


function response.initbqinfo(data)
    -- local msg = {}
    -- msg = bqmgr:get_all_airfreighter_sinfo(data.uid)
    -- return msg
end

function response.onlined(data)
    --下发当前在跑的队列信息 
    bqmgr:onlined(data.uid)
end

function response.online(uid, fd)
    if uid == 1 then
		return
	end
    --下发当前在跑的队列信息 
    local msg = {}
    msg.airfreighterinfo = bqmgr:get_all_airfreighter_sinfo(uid)
    if next(msg.airfreighterinfo) then
        send_request(fd, msg, "bqproxy_initbqinfo")
    end
end

function response.offline(uid)
end