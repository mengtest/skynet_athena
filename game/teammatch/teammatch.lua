local skynet = require "skynet"
local snax = require "skynet.snax"

local errCodeDef = require "errcodedef"
local sharedata = require "skynet.sharedata"
local queue = require "skynet.queue"
local cs


local machineinfo_dc
local machinecfg_dc
local equipment_dc
local user_dc
local info_dc

function init(...)
	cs = queue()
	user_dc = snax.queryservice("userdc")
	machineinfo_dc = snax.queryservice("machineinfodc")
    machinecfg_dc = snax.queryservice("machinecfgdc")
	equipment_dc = snax.queryservice("equipmentdc")
	info_dc = snax.queryservice("infodc")
end

function exit(...)
end


---进入战斗之后，清理数据
local onerooms = {}
local tworooms = {}
local threerooms = {}
local tenrooms = {}

local onerooms_pve = {}
local tworooms_pve = {}
local threerooms_pve = {}
local tenrooms_pve = {}

local fiftyomrooms_1 = {}

--记录游戏开始时间
local beginbattle_time = {}     --{roomkey == 1000000000时间戳,}

-- 记录每个玩家当前的房间类型和人数
local userroomtype = {}
-- 记录每个玩家准备状态
local userreadystatus = {}



local function getreadystatus(uid)
	return userreadystatus[uid]
end

local function getroom(roomtype, type)
	local retroom = {}
	if roomtype == teammatchdefine.eroomtype.one then
		if type ~= teammatchdefine.missiontype.pvp then
			retroom = onerooms_pve
		else
			retroom = onerooms
		end
	elseif roomtype == teammatchdefine.eroomtype.two then
		if type ~= teammatchdefine.missiontype.pvp then
			retroom = tworooms_pve
		else
			retroom = tworooms
		end
	elseif roomtype == teammatchdefine.eroomtype.three then
		if type ~= teammatchdefine.missiontype.pvp then
			retroom = threerooms_pve
		else
			retroom = threerooms
		end
	elseif roomtype == teammatchdefine.eroomtype.ten then
		if type ~= teammatchdefine.missiontype.pvp then
			retroom = tenrooms_pve
		else
			retroom = tenrooms
		end
	elseif roomtype == teammatchdefine.eroomtype.hundred then
		retroom = fiftyomrooms_1
	end
	return retroom
end

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
	local stageid, uid = roomkey:match "([^.]*)_(.*)"
	if stageid then
		return tonumber(stageid)
	end
	return nil
end

--- 根据房主uid得到房间id
local function roomkey_by_uid(uid, roomtype, type)
	if uid == nil then
		return nil
	end
	local roomtosearch = getroom(roomtype, type)
	for k, _ in pairs(roomtosearch) do
		local _, roomuid = k:match "([^.]*)_(.*)"
		if tonumber(roomuid) == uid then
			return k
		end
	end
	return nil
end

--- 获取房主id
local function roomowner(uid, roomtype, type)
	local roomtosearch = getroom(roomtype, type)
	for k, v in pairs(roomtosearch) do
		if uid_by_roomkey(k) == uid then
			return uid
		end
		for i = 1, #v do
			if v[i].playerid == uid then
				return uid_by_roomkey(k)
			end
		end
	end

	return nil
end

-- 返回一个table {10000, 1, 10002, 1,....}
local function get_part_info(part, uniqueids)
    local partinfo = {}
    for i = 1, #uniqueids do
		local cfgid = equipment_dc.req.getcfgid(part, uniqueids[i])
        table.insert(partinfo, cfgid)      
        local lv = equipment_dc.req.getvalue(part, uniqueids[i], "lv") 
		table.insert(partinfo, lv) 

		if cfgid == nil and lv == nil then
			table.insert(partinfo, 0)
			table.insert(partinfo, 0)
		end
    end
    return partinfo
end

local function get_machineinfo(uid)
	local tempdata = {}
	local defaultindex = tonumber(machineinfo_dc.req.getvalue(uid, "defaultindex"))
	local rawcfgids = machineinfo_dc.req.getvalue(uid, "machinecfgid")
	local cfgids = string.split(tostring(rawcfgids), ",")
	local cfgdata = machinecfg_dc.req.get(cfgids[defaultindex])
	-- 字符串转数组

	tempdata.body = get_part_info(warehousedefine.warehousetype.body, string.split(cfgdata.machinebody))     
	tempdata.chassis = get_part_info(warehousedefine.warehousetype.chassis, string.split(cfgdata.machinechassis))
	tempdata.firecontroller = get_part_info(warehousedefine.warehousetype.firecontroller, string.split(cfgdata.firecontroller))
	tempdata.weapons = get_part_info(warehousedefine.warehousetype.weapon, string.split(cfgdata.weapons))
	tempdata.name = cfgdata.name
	tempdata.playerid = cfgdata.playerid
	tempdata.pos = {}
	return tempdata
end

---当前天的零点
local function zerotime()
    local time = os.date("*t")
    time.min = 0
    time.sec = 0
    time.hour = 0
    return os.time(time)
end

local function createroom(stageid, uid, rooms)
	local roomkey = tostring(stageid) .. "_" ..  tostring(uid)

	if rooms[roomkey] ~= nil then
		skynet.error(roomkey, "is already create rooms!")
	end
	rooms[roomkey] = {{playerid = uid, machineinfo = get_machineinfo(uid),playername = user_dc.req.getvalue(uid, "name")}}

	-- rooms[roomkey] = {}
	-- for i = 1, 10 do
	-- 	table.insert(rooms[roomkey], {playerid=uid, machineinfo = get_machineinfo(uid),playername = user_dc.req.getvalue(uid, "name") .. i})
	-- end

	-- 房主默认准备好
	userreadystatus[uid] = true

	--设置当前房间数量
	local zerotime = zerotime()
	local curroom = info_dc.req.getvalue(zerotime, "roomsum")
	info_dc.req.setvalue(zerotime, "roomsum", curroom + 1)

	return roomkey, rooms[roomkey]
end

local function joinroom(stageid, uid, roomid, rooms, roomnum)
	local roominfo = rooms[roomid]
	table.insert(roominfo, {playerid=uid, machineinfo = get_machineinfo(uid),playername = user_dc.req.getvalue(uid, "name")})

	userreadystatus[uid] = false
	if roomnum ~= teammatchdefine.eroomtype.hundred then
		local msg = {}
		msg.teammatesinfos = roominfo
		msg.readystatus = {}
	
		for i = 1, #roominfo do
			local roommateid = roominfo[i].playerid
			msg.readystatus[i] = {playerid = roommateid,
								isready = getreadystatus(roommateid)}
		end	
		--给当前房间玩家同步信息
		for i = 1, #roominfo do
			local roommateid = roominfo[i].playerid
			if roommateid ~= uid then
				send_request(get_user_fd(roommateid), msg, "teammatch_tminfosupdate")	
			end
		end
	end
	return roomid, rooms[roomid]
end

local function exitroom(uid)
	local roomtype = userroomtype[uid]
	local rooms = getroom(roomtype.roomnum, roomtype.roomtype)

	local roomuid = roomowner(uid, roomtype.roomnum, roomtype.roomtype)

	if roomuid == nil then
		return false
	end

	local roomid = roomkey_by_uid(roomuid, roomtype.roomnum, roomtype.roomtype)
	local room = rooms[roomid]

	for i = 1, #room do
		if room[i].playerid == uid then
			table.remove(room, i)
			userroomtype[uid] = nil
			userreadystatus[uid] = nil
			break
		end
	end
	if roomtype.roomnum ~= teammatchdefine.eroomtype.hundred then
		local msg = {}
		msg.readystatus ={}
		msg.teammatesinfos = room
		for i = 1, #room do
			local roommateid = room[i].playerid
			msg.readystatus[i] = {playerid = roommateid,
								isready = getreadystatus(roommateid)}
		end	
	
		for i = 1, #room do
			local roommateid = room[i].playerid
			if roommateid ~= uid then
				send_request(get_user_fd(roommateid), msg, "teammatch_tminfosupdate")	
			end
		end
	end

	return true
end

local function destroyroom(uid)
	local roomtype = userroomtype[uid]
	local rooms = getroom(roomtype.roomnum, roomtype.roomtype)
	local roomid = roomkey_by_uid(uid, roomtype.roomnum, roomtype.roomtype)

	if rooms[roomid] == nil then
		return false
	end

	local msg = {}
	msg.playerid = uid
	msg.kickofftype = teammatchdefine.kickofftype.dissolve

	for i = 1, #rooms[roomid] do
		local roommateid = rooms[roomid][i].playerid
		if uid ~= roommateid then
			send_request(get_user_fd(roommateid), msg, "teammatch_kickoff")	
		end
		userroomtype[roommateid] = nil
		userreadystatus[roommateid] = false
	end
	rooms[roomid] = nil
	beginbattle_time[roomid] = nil

	--设置当前房间数量
	local zerotime = zerotime()
	local curroom = info_dc.req.getvalue(zerotime, "roomsum")
	info_dc.req.setvalue(zerotime, "roomsum", curroom - 1)

	return true
end

-- 找到合适的房间塞进去
local function findfitroom(rooms, targetnum, stageid, uid)
	local findroomret = -1
	for roomkey, roominfo in pairs(rooms) do
		if stageid_by_roomkey(roomkey) == stageid then
			--如果已经在房间，移除
			for key, value in pairs(roominfo) do
				if value.playerid == uid then
					table.remove(roominfo, key)
					break
				end
			end
			if table.size(roominfo) < targetnum then
				findroomret = roomkey
				break
			end
		end
	end
	return findroomret
end

--创建或加入房间
---@param roomtype number 房间人数
---@param type number 房间类型
local function createorjoinroom(stageid, uid, roomnum, type)
	local findroomret,rooms
	local roomid = -1
	local room = {}
	if roomnum == teammatchdefine.eroomtype.one then
		if type ~= teammatchdefine.missiontype.pvp then
			findroomret = findfitroom(onerooms_pve, teammatchdefine.eroomtype.one, stageid, uid)
			rooms = onerooms_pve
		else
			findroomret = findfitroom(onerooms, teammatchdefine.eroomtype.one, stageid, uid)
			rooms = onerooms
		end
	elseif roomnum == teammatchdefine.eroomtype.two then
		if type ~= teammatchdefine.missiontype.pvp then
			findroomret = findfitroom(tworooms_pve, teammatchdefine.eroomtype.two, stageid, uid)
			rooms = tworooms_pve
		else
			findroomret = findfitroom(tworooms, teammatchdefine.eroomtype.two, stageid, uid)
			rooms = tworooms
		end
	elseif roomnum == teammatchdefine.eroomtype.three then
		if type ~= teammatchdefine.missiontype.pvp then
			findroomret = findfitroom(threerooms_pve, teammatchdefine.eroomtype.three, stageid, uid)
			rooms = threerooms_pve
		else
			findroomret = findfitroom(threerooms, teammatchdefine.eroomtype.three, stageid, uid)
			rooms = threerooms
		end
	elseif roomnum == teammatchdefine.eroomtype.ten then
		if type ~= teammatchdefine.missiontype.pvp then
			findroomret = findfitroom(tenrooms_pve, teammatchdefine.eroomtype.ten, stageid, uid)
			rooms = tenrooms_pve
		else
			findroomret = findfitroom(tenrooms, teammatchdefine.eroomtype.ten, stageid, uid)
			rooms = tenrooms
		end
	elseif roomnum == teammatchdefine.eroomtype.hundred then
		findroomret = findfitroom(fiftyomrooms_1, roomnum, stageid, uid)
		rooms = fiftyomrooms_1
	end

	--没有找到则创建否则加入
	if findroomret == -1 then
		roomid, room = createroom(stageid, uid, rooms)
		if roomnum == teammatchdefine.eroomtype.hundred then
			beginbattle_time[roomid] = tonumber(os.time()) + 1 * 30
			skynet.timeout(3000, function ()
				-- 游戏强制开始
				local roomtype = userroomtype[uid]
				if roomtype then
					local rooms = getroom(roomtype.roomnum, roomtype.roomtype)
					local roomkey = roomkey_by_uid(roomowner(uid, roomtype.roomnum, roomtype.roomtype), roomtype.roomnum, roomtype.roomtype)
					if not roomkey or not next(rooms[roomkey]) then
						return
					end
					local room =  rooms[roomkey]
					local _, obj = pcall(snax.queryservice, "battleproxy")
					local ok, data = pcall(obj.req["gobattle"], roomkey, room, roomnum)
					beginbattle_time[roomkey] = nil
				end
			end)
		end
	else
		roomid, room = joinroom(stageid, uid, findroomret, rooms, roomnum)
	end
	if roomid ~= -1 then
		userroomtype[uid] = {roomnum = roomnum, roomtype = type}
	end

	return roomid, room
end

-- 申请战斗数据校验
local function battlebegincheck(uid, room, roomtype)
	if not next(room) or roomtype == nil then
		return errCodeDef.eEC_err_param
	end

	if #room ~= roomtype then
		return errCodeDef.eEC_match_wrongnum
	end

	for i = 1, #room do
		local roommateid = room[i].playerid
		if getreadystatus(roommateid) ~= true then
			return errCodeDef.eEC_match_unallready
		end
	end
	return errCodeDef.eEC_success
end

---从匹配中移除并销毁房间
function response.gobattlefinish(uid)
	local roomtype = userroomtype[uid]
	if roomtype == nil or not next(roomtype) then
		return
	end
	if roomowner(uid, roomtype.roomnum, roomtype.roomtype) == uid then
		destroyroom(uid)
	elseif roomowner(uid, roomtype.roomnum, roomtype.roomtype) == nil then
		return
	else
		exitroom(uid)
	end

	userreadystatus[uid] = nil
end

function response.getmachineinfo(uid)
	local roomtype = userroomtype[uid]
	local rooms = getroom(roomtype.roomnum, roomtype.roomtype)
	local roomkey = roomkey_by_uid(roomowner(uid, roomtype.roomnum, roomtype.roomtype), roomtype.roomnum, roomtype.roomtype)
	local room =  rooms[roomkey]
	for i = 1, #room do
		if room[i].playerid == uid then
			room[i].machineinfo = get_machineinfo(uid)
			return room[i].machineinfo
		end
	end
end

-- 获取组队房间内所有人id，包含自己
function response.getroommateid(uid)
	local ret = {}
	local roomtype = userroomtype[uid]
	local rooms = getroom(roomtype.roomnum, roomtype.roomtype)
	local room =  rooms[roomkey_by_uid(roomowner(uid, roomtype.roomnum, roomtype.roomtype), roomtype.roomnum, roomtype.roomtype)]

	if room == nil then
		return nil
	end

	for i = 1, #room do
		local roommateid = room[i].playerid
		table.insert(ret, roommateid)
	end
	return ret
end

--进入房间
function response.maketeam(data)
	local ret = {}
	local uid = data.uid
	local fd = data.fd
	local teammatesnum = data.msg.teammatesnum
	local stageid = data.msg.stageid
	local msg = {}
	local roomid = -1
	local roomtype = -1
	local room, teammatesinfos, readystatus = {}, {}, {}
	
	teammatesnum = 100
	
	msg.code = errCodeDef.eEC_success
	local stage = sharedata.deepcopy( "stage", stageid)
	

	if teammatesnum == nil or stageid == nil or stage == nil then
		msg.code = errCodeDef.eEC_err_param
		return msg
	end

	if teammatesnum < 1 or teammatesnum > 200 then
		msg.code = errCodeDef.eEC_err_param
		return msg
	--看似多余，实则对客户端参数进行判断
	elseif teammatesnum == teammatchdefine.eroomtype.one then
		roomtype = teammatchdefine.eroomtype.one
	elseif teammatesnum == teammatchdefine.eroomtype.two then
		roomtype = teammatchdefine.eroomtype.two
	elseif teammatesnum == teammatchdefine.eroomtype.three then
		roomtype = teammatchdefine.eroomtype.three
	elseif teammatesnum == teammatchdefine.eroomtype.ten then
		roomtype = teammatchdefine.eroomtype.ten
	elseif teammatesnum == teammatchdefine.eroomtype.hundred  then
		roomtype = teammatchdefine.eroomtype.hundred
	else
		msg.code = errCodeDef.eEC_err_param
		return msg
	end

	roomid, room = cs(createorjoinroom, stageid, uid, roomtype, stage.Task_Type)
	--暂时使用人数判断战斗模式
	if teammatesnum == teammatchdefine.eroomtype.hundred then
		msg.countdown = beginbattle_time[roomid] and math.max(0, beginbattle_time[roomid] - os.time()) or nil
		msg.teammatesinfos = {{playerid = uid, machineinfo = get_machineinfo(uid),playername = user_dc.req.getvalue(uid, "name")}}
		msg.readystatus =  {{playerid = uid, isready = true}}
		return msg
	end

	for i = 1, #room do
		readystatus[i] = {playerid = room[i].playerid, isready = getreadystatus(room[i].playerid)}
	end
	
	msg.countdown = beginbattle_time[roomid] and math.max(0, beginbattle_time[roomid] - os.time()) or nil
	msg.teammatesinfos = room
	msg.readystatus = readystatus
	return msg
end

---状态变化 不是房主调用
function response.doready(data)
	local uid = data.uid
	local msg = {}

	userreadystatus[uid] = not getreadystatus(uid)

	msg.code = errCodeDef.eEC_success
	msg.isready = getreadystatus(uid)

	--在房间也可以变换机甲，所以在此更改机甲信息
	local roomtype = userroomtype[uid]
	local rooms = getroom(roomtype.roomnum, roomtype.roomtype)
	local roomkey = roomkey_by_uid(roomowner(uid, roomtype.roomnum, roomtype.roomtype), roomtype.roomnum, roomtype.roomtype)
	local room =  rooms[roomkey]

	assert(next(room))
	for i = 1, #room do
		room[i].machineinfo = get_machineinfo(room[i].playerid)
	end
	local tmmsg = {}
	tmmsg.teammatesinfos = room

	tmmsg.readystatus = {}	
	-- 通知队友准备状态变更
	for i = 1, #room do
		local roommateid = room[i].playerid
		tmmsg.readystatus[i] = {playerid = roommateid,
							isready = getreadystatus(roommateid)}
	end

	for i = 1, #room do
		local roommateid = room[i].playerid
		if uid ~= roommateid then
			send_request(get_user_fd(roommateid), tmmsg, "teammatch_tminfosupdate")
		end
	end
	return msg	
end

function response.teamexit(data)
	local ret = {}
	local uid = data.uid
	local msg = {}
	msg.code = errCodeDef.eEC_success

	if userroomtype[uid] == nil then
		msg.code = errCodeDef.eEC_err_param
		return msg
	end

	local roomtype = userroomtype[uid]
	local ret = nil
	if roomowner(uid, roomtype.roomnum, roomtype.roomtype) == uid then
		ret = destroyroom(uid)
	elseif roomowner(uid, roomtype.roomnum, roomtype.roomtype) == nil then
		skynet.error(uid, " not in room want exit!")
	else 
		ret = exitroom(uid)
	end
	--如果在匹配队列，移除
	local _, obj = pcall(snax.queryservice, "battleproxy")
	local ok = pcall(obj.req["remwaiting"], uid)

	if ret == nil then
		msg.code = errCodeDef.eEC_match_exitfail
	end
	return msg
end

--单人pve
function response.gopvebattle(data)
	local ret = {}
	local uid = data.uid
	local stageid = data.msg.stageid
	
	if stageid == nil then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end

	local roomkey = tostring(stageid) .. "_" .. tostring(uid)
	local room = {}
	table.insert(room, {playerid = uid, machineinfo = get_machineinfo(uid)})

	local stage = sharedata.deepcopy("stage", stageid)
	if stage.Task_Type == teammatchdefine.missiontype.pvp then
		ret.code = errCodeDef.eEC_match_exitfail
		return ret
	end
	local _, obj = pcall(snax.queryservice, "battleproxy")
	local ok, data = pcall(obj.req["gobattle"], roomkey, room, teammatchdefine.eroomtype.one)
	ret.code = errCodeDef.eEC_success
	return ret
end

---房主调用，开始匹配
function response.battleapply(data)
	local uid = data.uid
	local iscancel = data.msg.iscancel
	
	local msg = {}
	local roomtype = userroomtype[uid]
	--判断是不是房主
	if roomtype == nil or roomowner(uid, roomtype.roomnum, roomtype.roomtype) ~= uid then
		msg.code = errCodeDef.eEC_err_param
		return msg
	end
	local rooms = getroom(roomtype.roomnum, roomtype.roomtype)
	local roomkey = roomkey_by_uid(roomowner(uid, roomtype.roomnum, roomtype.roomtype), roomtype.roomnum, roomtype.roomtype)
	local room =  rooms[roomkey]
	-- todo 取消匹配的参数校验
	assert(next(room))

	if iscancel then
		msg.code = errCodeDef.eEC_success
		local _, obj = pcall(snax.queryservice, "battleproxy")
		local ok, data = pcall(obj.req["cancelbattle"], roomkey, room, roomtype.roomnum)
		return msg
	end

	skynet.error("before battlebegincheck! roomkey:", roomkey, "roomtype:", tostring(roomtype))
	msg.code = battlebegincheck(uid, room, roomtype.roomnum)
	
	if msg.code == errCodeDef.eEC_success then
		-- 发车！
		local _, obj = pcall(snax.queryservice, "battleproxy")
		-- 战斗模式可以根据关卡类型进行判断， roomtype.roomtype保存只是为了方便，所以此处不参与参数传递
		local ok, data = pcall(obj.req["gobattle"], roomkey, room, roomtype.roomnum)
		msg.code = data
	end
	return msg
end

function response.offline(uid)
	--如果在匹配队列，移除
	local _, obj = pcall(snax.queryservice, "battleproxy")
	local ok = pcall(obj.req["remwaiting"], uid)
	snax.self().req.gobattlefinish(uid)
end

function response.online(uid, fd)
	-- body
end