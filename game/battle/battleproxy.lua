local skynet = require "skynet"
local snax = require "skynet.snax"
local errCodeDef = require "errcodedef"
local sharedata = require "skynet.sharedata"

local queue = require "skynet.queue"
local _checkQueue
local achievement

local waitingroom = {}    -- {["10001_3"] = {room, room, ....}} ,key为stageid_roomtype

local playerroomtype = {}   -- { uid = stageid .. "_" .. roomnum }       记录玩家房间类型
local battlehandle = {}      -- {handle.handle = handle }
local _handle_uid = {}       -- {handle.handle = {uid, uid, uid}}

local battleinfos = {}      --战斗数据 {uid = {kill = {uid, uid}, harm = 1500, defense = 1500}


--- 根据房间id得到uid
local function uid_by_roomkey(roomkey)
	local _, uid = roomkey:match "([^.]*)_(.*)"
	if uid then
		return tonumber(uid)
	end
	return nil
end

--- 根据房间id得到stageid
local function stageid_by_roomkey(roomkey)
	local stageid, _ = roomkey:match "([^.]*)_(.*)"
	if stageid then
		return tonumber(stageid)
	end
	return nil
end

--- 寻找旗鼓相当的对手
local function findsuitrival(target_room_key)
    if waitingroom[target_room_key] == nil then
        return nil
    end

    if table.size(waitingroom[target_room_key]) == 0 then
        return nil
    end



    local roomindex = math.random(1, #waitingroom[target_room_key])    --todo 目前使用随机
    return roomindex, waitingroom[target_room_key][roomindex]
end

--- 根据stageid得到mapid
local function getmapid(stageid)
    local stage = sharedata.deepcopy( "stage", stageid)
    return stage.Map_Id
end

--- 根据stageid得到关卡类型
local function get_task_type(stageid)
    local stage = sharedata.deepcopy( "stage", stageid)
    return stage.Task_Type
end

-- local function getstageid()
--     local stageids = table.keys(sharedata.deepcopy( "stage"))
--     -- todo 暂时写死第一个
--     return stageids[1]
-- end

--- 将玩家所在的房间从等待匹配的列表中移除
local function removefromwaiting(uid)
    local target_room_key = playerroomtype[uid]

    if target_room_key == nil then
        return 
    end
    
    local rooms = waitingroom[target_room_key]
    if not rooms then
        return 
    end
    local isremove = false
    for k, v in pairs(rooms) do
        local room = rooms[k]
        for i = 1, table.size(room) do
            if room[i].playerid == uid then
                isremove = true
                break 
            end
        end
        if isremove then
            table.remove(rooms, k)
            return
        end
    end
end

--- 根据uid得到对应的战斗服务句柄
local function getbattlehandle(uid)
    for k, v in pairs(_handle_uid) do
        for i = 1, #v do
            if v[i] == uid then
                return battlehandle[k]
            end
        end
    end
    return nil
end

function init(...)
    _checkQueue = queue()
    achievement = snax.queryservice("achievement")
end

function exit(...)
end

--匹配中有玩家退出
function response.remwaiting(uid)
    local target_room_key = playerroomtype[uid]

    if target_room_key == nil then
        return 
    end
    
    local rooms = waitingroom[target_room_key]
    if not rooms then
        return 
    end
    local isremove = false
    for k, v in pairs(rooms) do
        local room = rooms[k]
        for i = 1, table.size(room) do
            if room[i].playerid == uid then
                isremove = true
                break 
            end
        end
        if isremove then
            for i = 1, #room do
                playerroomtype[room[i].playerid] = nil
            end
            table.remove(rooms, k)
            break
        end
    end
end

function response.cancelbattle(roomkey, room, roomnum)
    local stageid = stageid_by_roomkey(roomkey)
    local target_room_key = tostring(stageid) .. "_" .. tostring(roomnum)

    local uid = uid_by_roomkey(roomkey)
    local rooms = waitingroom[target_room_key]
    if rooms == nil or not next(rooms) then
        return
    end
    local isremove = false
    local temp2send = {}
    for k, v in pairs(rooms) do
        local room = rooms[k]
        for i = 1, table.size(room) do
            if room[i].playerid == uid then
                temp2send = table.clone(room)
                isremove = true
                break 
            end
        end
        if isremove then
            for i = 1, table.size(room) do
                playerroomtype[room[i].playerid] = nil
            end
            table.remove(rooms, k)
            break
        end
    end
    skynet.error("取消之后", tostring(waitingroom))
    for i = 1, table.size(temp2send) do
        send_request(get_user_fd(temp2send[i].playerid), { ismatching = false}, "teammatch_matching")
    end
end

function response.gobattle(roomkey, room, roomnum)
    local uid = uid_by_roomkey(roomkey)
    local stageid = stageid_by_roomkey(roomkey)
    local target_room_key = tostring(stageid) .. "_" .. tostring(roomnum)
    local stage = sharedata.deepcopy("stage", stageid)


    local tasktype = get_task_type(stageid)
    for i = 1, #room do
        if playerroomtype[room[i].playerid] ~= nil then
            return errCodeDef.eEC_match_matching
        end
    end

    -- pve模式
    if stage.Task_Type  ~= teammatchdefine.missiontype.pvp or roomnum >= 100 then
        skynet.error("goto pve!!!!!!!!!!!!!!!!!!!!!!")

        if check_user_online(1) then
            local battlesvr = snax.newservice("battlesvr")
            battlesvr.req.setroomtype(roomnum)
            battlesvr.req.setstagetype(tasktype)
            local fighters = {}
            for i = 1, #room do
                table.insert(fighters, room[i].playerid)
                playerroomtype[room[i].playerid] = target_room_key
            end
            -- 将玩家数据传到战斗服务中
            battlesvr.req.playerinfoinit(fighters, stageid)
            battlehandle[battlesvr.handle] = battlesvr
            _handle_uid[battlesvr.handle] = fighters
            send_request(get_user_fd(1), {uid = uid}, "battleproxy_getroomnum")
            send_request(get_user_fd(1), {}, "battleproxy_createroom")	
            skynet.error("===============send to battlemanage massage==============")
            LOG_INFO("===============send to battlemanage massage==============")
            return errCodeDef.eEC_success
        else
            skynet.error("================battle service is offline=================")
            return errCodeDef.eEC_unknow
        end
    end

    local index, rival = findsuitrival(target_room_key)
    if index == nil then
        if waitingroom[target_room_key] == nil then
            waitingroom[target_room_key] = {}
        end

        table.insert(waitingroom[target_room_key], room)

        for i = 1, table.size(room) do
            send_request(get_user_fd(room[i].playerid), { ismatching = true }, "teammatch_matching")
            playerroomtype[room[i].playerid] = target_room_key
        end
        LOG_INFO("is waiting!! : %s", tostring(waitingroom))
    else
        skynet.error("goto pvp!!!!!!!!!!!!!!!!!!!!!!")
        
        if check_user_online(1) then
            local battlesvr = snax.newservice("battlesvr")
            battlesvr.req.setroomtype(roomnum)
            battlesvr.req.setstagetype(tasktype)
            local fighters = {}
            for i = 1, #room do
                table.insert(fighters, room[i].playerid)
                playerroomtype[room[i].playerid] = target_room_key
            end
            for i = 1, #rival do
                table.insert(fighters, rival[i].playerid)
            end
            -- table.insert(waitingroom[target_room_key], room)
            
            -- 将玩家数据传到战斗服务中
            battlesvr.req.playerinfoinit(fighters, stageid)
            battlehandle[battlesvr.handle] = battlesvr
            _handle_uid[battlesvr.handle] = fighters
            send_request(get_user_fd(1), {uid = uid}, "battleproxy_getroomnum")
            send_request(get_user_fd(1), {}, "battleproxy_createroom")
            skynet.error("===============send to battlemanage massage==============")
            LOG_INFO("===============send to battlemanage massage==============")
    
            removefromwaiting(rival[1].playerid)
        else
            skynet.error("================battle service is offline=================")
            return errCodeDef.eEC_unknow
        end
    end
    return errCodeDef.eEC_success
end

function response.mapinit(data)
	local ret = {}
	local uid = data.uid
    local msg = {}
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end
    local chipattr = battlesvr.req.getchipattr(uid)
    local battle_machine_infos = battlesvr.req.getbattleinfo()
    local battle_attri_infos = battlesvr.req.getattriinfo()
    local areainfos = battlesvr.req.getareainfo()

    local target_room_key = playerroomtype[uid]
    local stageid = stageid_by_roomkey(target_room_key)
    local stage = sharedata.deepcopy( "stage", stageid)

    --todo 临时写死
    msg.leftrightlocation =  stage.Left_Right_Limit
    msg.topdownlocation = stage.Top_Down_Limit
    msg.mapid = getmapid(stageid)
    msg.stageid = stageid
    msg.playerlistinfo = battle_machine_infos
    msg.playerattribute = battle_attri_infos 
    msg.gravity = stage.Gravity_Parameter
    msg.temperature = 2                     --复活次数
    msg.amplitude =  10 * 60                 --战斗时间(秒)
    msg.areainfos = areainfos

    playerroomtype[uid] = nil
    LOG_INFO("mapinit: %s, %s", tostring(chipattr), tostring(msg))
    -- skynet.error("HHHHHHHHHHHHH", tostring(msg.playerattribute), tostring(battle_attri_infos))
    send_request(get_user_fd(uid), chipattr, "battleproxy_chipattribute")

    -- local battlesvr = getbattlehandle(uid)
    -- local userarr = _handle_uid[battlesvr]
    -- for _, value in pairs(userarr) do   
    --     for k, v in pairs(battle_machine_infos) do
    --         if v.playerid == value then
    --             send_request(get_user_fd(uid), {index = k}, "battleproxy_index")
    --         end
    --     end
    -- end
    return msg
end

function response.move(data)
    local uid = data.uid    
    LOG_INFO("move-------------from client: %s", tostring(data))

    if data.msg == {} then
        return
    end

    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end

    battlesvr.req.move(data)
end

function response.fire(data)
    local uid = data.uid 
    LOG_INFO("fire-------------from client: %s", tostring(data.msg))
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end

    battlesvr.req.fire(data)   
end

--准备
function response.readycheck(data)
	local ret = {}
	local uid = data.uid
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end

    battlesvr.req.updateready(uid)
end

function response.turnend(data)
    local ret = {}
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end

    LOG_INFO("turnend-------------from client: %s", tostring(data.msg))
    _checkQueue(battlesvr.req.turnend, data)
end

-- 使用技能
function response.skillspell(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end
    battlesvr.req.skillspell(data)
end

function response.explode(data)
    local ret = {}
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end
    -- todo 待测试阻塞对效率性能体感的影响
    _checkQueue(battlesvr.req.explode, data)
end

function response.aim(data)
    local ret = {}
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end
    battlesvr.req.aim(data)
end

-- 点赞
function response.support(data)
    local ret = {}
    local uid = data.uid                    
    local sourceid = data.msg.sourceid      --被赞人id
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil or sourceid == nil then
        return
    end

    achievement.req.updateathletics(uid, achievementdefine.achievetype.supportnum)
    send_request(get_user_fd(sourceid), {uid = uid}, "battleproxy_passsupport")
end

-- 记录破坏地形成就
function response.desterrain(data)
    local uid = data.uid
    local count = data.msg.count
    if not count or count <= 0 or count > 100 then
        return
    end
    achievement.req.updateathletics(uid, achievementdefine.achievetype.desterrain, count)
end

-- 自杀
function response.death(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end
    _checkQueue(battlesvr.req.murder, data)
end

function response.sendsocket(data)
    local uid = data.msg.uid
    local battlesvr = getbattlehandle(uid)
    if battlesvr == nil or data.msg.socket == nil or data.uid ~= 1 then
        return errCodeDef.eEC_err_param
    end
    return battlesvr.req.sendsocket(data)
end

function response.sendroomnum(data)
    local uid = data.msg.uid
    local battlesvr = getbattlehandle(uid)
    if battlesvr == nil or data.msg.count == nil or data.uid ~= 1 then
        return errCodeDef.eEC_err_param
    end
    return battlesvr.req.sendroomnum(data)
end

function response.switchweapon(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)
    if battlesvr == nil then
        return
    end
    return battlesvr.req.switchweapon(data)
end

function response.battlefinish(battlesvr, battledata)
    battlehandle[battlesvr] = nil
    _handle_uid[battlesvr] = nil
    battleinfos = battledata
    skynet.error("战斗数据", tostring(battleinfos))
end

function response.aimupdate(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)
    if battlesvr == nil then
        return
    end
    battlesvr.req.aimupdate(data)
end

function response.skillactive(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)
    if battlesvr == nil then
        return
    end
    battlesvr.req.skillactive(data)
end

function response.skipdialogue(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)
    if battlesvr == nil then
        return
    end
    battlesvr.req.skipdialogue(data)
end

function response.triggerarea(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)
    if battlesvr == nil then
        return
    end
    battlesvr.req.triggerarea(data)
end

function response.npcstatesync(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)
    if battlesvr == nil then
        return
    end
    battlesvr.req.npcstatesync(data)
end

function response.directdamage(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)
    if battlesvr == nil then
        return
    end
    battlesvr.req.directdamage(data)
end

-- 使用技能
function response.buffactive(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end
    battlesvr.req.buffactive(data)
end

-- 跳跃
function response.jump(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end
    battlesvr.req.jump(data)
end

-- 跳跃结束
function response.jumpend(data)
    local uid = data.uid
    local battlesvr = getbattlehandle(uid)

    if battlesvr == nil then
        return
    end
    battlesvr.req.jumpend(data)
end

function response.online(uid, fd)
end

---移除信息
local function remove_item(uid)
    for k, v in pairs(_handle_uid) do
        for i = 1, #v do
            if v[i] == uid then
                table.remove(_handle_uid[k], i)
                break
            end
        end
    end
end

local function closebattlesvr(uid)
    local ret = {}
    ret.code = errCodeDef.eEC_success
    local battlesvr = getbattlehandle(uid)
    if battlesvr == nil then
        return ret
    end
    if battlesvr.req.offline(uid) then
        snax.kill(battlesvr)
    else
        remove_item(uid)
    end
    return ret
end

function response.offline(data)
    local uid
    if type(data) == "number" then
        uid = data
    elseif type(data) == "table" then
        uid = data.uid
    end
    removefromwaiting(uid)
    playerroomtype[uid] = nil

    return _checkQueue(closebattlesvr, uid)
end