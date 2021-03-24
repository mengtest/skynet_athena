local skynet = require "skynet"
local snax = require "skynet.snax"
local sharedata = require "skynet.sharedata"
local errCodeDef = require "errcodedef"
local json = require"cjson"
local timext = require "timext"

local user_dc
local userset_dc
local player_dc
local machinecfg_dc
local machineinfo_dc
local equipment_dc
local hangar_dc
local chip_dc
local blueprint_dc
local score_dc
local chipattribute_dc
local collection_dc
local show_dc
local gold_dc
local materials_dc
local bq_dc
local queueinfo_dc
local khorium_dc
local awardinfo_dc
local prop_dc
local tmpbqinfo_dc
local skill_dc
local athletics_dc
local plot_dc
local overview_dc
local challenge_dc
local achievement
local putaway_dc
local market_dc
local putawaygold_dc
local stayputaway_dc
local putawayinfo_dc
local shopiteminfo_dc
local info_dc

function init(...)
	user_dc = snax.uniqueservice("userdc")
	userset_dc = snax.uniqueservice("usersetdc")
	player_dc = snax.uniqueservice("playerattributedc")
	machinecfg_dc = snax.uniqueservice("machinecfgdc")
	machineinfo_dc = snax.uniqueservice("machineinfodc")
	equipment_dc = snax.uniqueservice("equipmentdc")
	hangar_dc = snax.uniqueservice("hangardc")
	chip_dc = snax.uniqueservice("chipinfodc")
	blueprint_dc = snax.uniqueservice("blueprintdc")
	score_dc = snax.uniqueservice("scoredc")
	chipattribute_dc = snax.uniqueservice("chipattributedc")
	collection_dc = snax.uniqueservice("collectiondc")
	show_dc = snax.uniqueservice("showdc")
	bq_dc = snax.uniqueservice("businessqueuedc")
	gold_dc = snax.uniqueservice("golddc")
	materials_dc = snax.uniqueservice("materialsdc")
	queueinfo_dc = snax.uniqueservice("queueinfodc")
	khorium_dc = snax.uniqueservice("khoriumdc")
	awardinfo_dc = snax.uniqueservice("awardinfodc")
	prop_dc = snax.uniqueservice("propdc")
	tmpbqinfo_dc = snax.uniqueservice("tmpbqinfodc")
	skill_dc = snax.uniqueservice("skilldc")
	athletics_dc = snax.uniqueservice("athleticsdc")
	plot_dc = snax.uniqueservice("plotdc")
	challenge_dc = snax.uniqueservice("challengedc")
	overview_dc = snax.uniqueservice("overviewdc")
	putaway_dc = snax.uniqueservice("putawaydc")
	market_dc = snax.uniqueservice("marketdc")
	putawaygold_dc = snax.uniqueservice("putawaygolddc")
	putawayinfo_dc = snax.uniqueservice("putawayinfodc")
	stayputaway_dc = snax.uniqueservice("stayputawaydc")
	shopiteminfo_dc = snax.uniqueservice("shopiteminfodc")
	info_dc = snax.uniqueservice("infodc")
end

function exit(...)
end

--------------------------------------------
------命名规则
local function name_match(name)
	local oldname = name
	---敏感字符
	local sen = sharedata.deepcopy("sensitive_word")
	for _, v in pairs(sen) do
		if  string.find(name , v["word"]) then
			return errCodeDef.eEC_role_name_sensitive 
		end
	end
	-- if string.match(name, "[^\u4E00-\u9FFF]*[^0-9]*[^a-zA-Z]*") then
	-- 	return errCodeDef.eEC_role_name_macth
	-- end
	---特殊字符
	local newname = string.filterspecchars(name)
	if  string.utf8len(oldname) ~= string.utf8len(newname) then
		return errCodeDef.eEC_role_name_macth
	end
	return nil
end

function response.changename(data)
	local re = {}
	local uid = data.uid
	local name = data.msg.name
	if not name then
		re.code = errCodeDef.eEC_err_param
		return re
	end
    --用户是否存在
	if not user_dc.req.check_role_exists(uid) then
		re.code = errCodeDef.eEC_role_not_exists
	--是否相同
	elseif user_dc.req.getvalue(uid,"name") == name then
		re.code = errCodeDef.eEC_role_name_repetition
	--名称被占用
	elseif user_dc.req.check_rolename_exists(name) then
		re.code = errCodeDef.eEC_used_name
	--名称规范
	else
		re.code = name_match(name)
	end
	if string.utf8len(name) < 3 or string.utf8len(name) > 7 then
		re.code = errCodeDef.eEC_role_name_length
		return re
	end
	if re.code ~= nil then
		return re
	end
	local res = user_dc.req.setvalue(uid,"name", name)
	if not res then
		re.code = errCodeDef.eEC_db_error
	else 
		re.code = errCodeDef.eEC_success
	end
	return re
end
---------------------------------------------

---修改图片
function response.changeimg(data)
	local re = {}
	local uid = data.uid
	local imgcfgid = data.msg.imgcfgid

	if imgcfgid == nil then
		re.code = errCodeDef.eEC_err_param
		return re
	end
	
	--查找是否存在配置id
	local imginfo = sharedata.deepcopy("avatar", imgcfgid)
	if not imginfo then
		re.code = errCodeDef.eEC_err_param
		return re
	end
	local res = user_dc.req.setvalue(uid, "imgcfgid", imgcfgid)
	if not res then
		re.code = errCodeDef.eEC_db_error
	else 
		re.code = errCodeDef.eEC_success
	end
	return re
end

---修改介绍
function response.changedes(data)
	local re = {}
	local uid = data.uid
	local des = data.msg.des

	--敏感词检测
	local sen = sharedata.deepcopy("sensitive_word")
	for _, v in pairs(sen) do
		if string.find(des , v["word"]) then
			re.code = errCodeDef.eEC_role_name_sensitive 
		end
	end
	--长度检测
	if string.utf8len(des) < 0 or string.utf8len(des) > 20 then
		re.code = errCodeDef.eEC_role_name_length
	end

	if re.code ~= nil then
		return re
	end
	local res = user_dc.req.setvalue(uid, "description", des)
	if not res then
		re.code = errCodeDef.eEC_db_error
	else 
		re.code = errCodeDef.eEC_success
	end
	return re
end

---经验段位变化
function response.updateexp(uid, exp)
	-- local re = {}
	if not uid or not exp or type(uid) ~= "number" or type(exp) ~= "number" then
		-- re.code = errCodeDef.eEC_err_param
		-- return re
		return false
	end

	local userinfo = user_dc.req.get(uid)
	if not next(userinfo) then
		-- re.code = errCodeDef.eEC_err_param
		-- return re
		return false
	end
	-- re.code = errCodeDef.eEC_success
	local expinfos = sharedata.deepcopy("player_exp")
	userinfo.exp = userinfo.exp + exp
	local curtotal_exp = expinfos[userinfo.level].EXP_Total + userinfo.exp
	for i = userinfo.level + 1, #expinfos do
		if expinfos[i].EXP_Total > curtotal_exp then
			userinfo.level = i - 1
			userinfo.exp = curtotal_exp - expinfos[i-1].EXP_Total
			break
		end
	end
	user_dc.req.setvalue(uid, "exp", userinfo.exp)
	user_dc.req.setvalue(uid, "level", userinfo.level)
	send_request(get_user_fd(uid), {level = userinfo.level, exp = userinfo.exp}, "user_updateexp")
	achievement = snax.queryservice("achievement")
	achievement.req.updatechallenge(uid, achievementdefine.achievetype.level, nil, userinfo.level, true)
	return true
end

function response.gettime(data)
	local ret = {}
	ret.curtime = timext.current_time()
	return ret
end

local function find_part(part, uid, cfgid)
	local partids
	
	if part == warehousedefine.warehousetype.body then
		local bodyids = string.split(hangar_dc.req.getvalue(uid, "newbody"))
		partids = bodyids
	elseif part == warehousedefine.warehousetype.chassis then
		local chassisids = string.split(hangar_dc.req.getvalue(uid, "newchassis"))
		partids = chassisids
	elseif  part == warehousedefine.warehousetype.firecontroller then
		local firecontrolids = string.split(hangar_dc.req.getvalue(uid, "newfirecontroller"))
		partids = firecontrolids
	elseif part == warehousedefine.warehousetype.weapon then
		local weaponids = string.split(hangar_dc.req.getvalue(uid, "newweapons"))
		partids = weaponids
	end

	for i = 1, #partids do
		local partcfgid = equipment_dc.req.getcfgid(part, partids[i])
		if tonumber(cfgid) == partcfgid  then
			return tostring(partids[i])
		end
	end
	return 0
end

local function get_machine_name(body, chassis, firecontrol)
	return sharedata.deepcopy("machinebody", body).Display .. 
		sharedata.deepcopy("machinechassis", chassis).Display ..
		sharedata.deepcopy("firecontrol", firecontrol).Display
end

local function init_playerinfo(uid)
	-- 拿默认机甲配置
	local defaultindex = tonumber(machineinfo_dc.req.getvalue(uid, "defaultindex"))
	local rawcfgids = machineinfo_dc.req.getvalue(uid, "machinecfgid")
	local cfgids = string.split(tostring(rawcfgids), ",")
	local cfgdata = machinecfg_dc.req.get(cfgids[defaultindex])
	-- 根据默认机甲配置，读静态表算属性
	local body = equipment_dc.req.getcfgid(warehousedefine.warehousetype.body, tonumber(string.split(cfgdata.machinebody)[1]))
	local chassis = equipment_dc.req.getcfgid(warehousedefine.warehousetype.chassis, tonumber(string.split(cfgdata.machinechassis)[1]))
	local firecontroller = equipment_dc.req.getcfgid(warehousedefine.warehousetype.firecontroller, tonumber(string.split(cfgdata.firecontroller)[1]))
	-- local weapons = equipment_dc.req.getcfgid(warehousedefine.warehousetype.weapon, tonumber(string.split(cfgdata.weapons)[1]))

	local sdmachinebody = sharedata.deepcopy("machinebody", tonumber(body))
	local sdmachinechassis = sharedata.deepcopy("machinechassis", tonumber(chassis))
	local sdfirecontrol = sharedata.deepcopy("firecontrol", tonumber(firecontroller))
	-- local sdweapon = sharedata.deepcopy("weapontable", tonumber())

	local row = { id = tonumber(uid), life = tonumber(sdmachinebody.Hp), 
				speed = tonumber(sdmachinechassis.Round_Speed), energy = tonumber(sdmachinebody.Power_Value),
				shield = tonumber(sdmachinebody.Sheld_Value), elevation = sdfirecontrol.Attack_Angle_Max, overhang = sdfirecontrol.Attack_Angle_Min,
				enefficiency = math.ceil(sdfirecontrol.Power_Efficiency * 1000) * 0.001, efficiency = math.ceil(sdmachinechassis.engine_efficiency * 1000) * 0.001, 
				climbingangle = sdmachinechassis.Chassis_Creeping_Angle
			} 
	player_dc.req.add(row)
	LOG_INFO("init_playerinfo ok, uid %d", uid)

	return true
end

-- todo 取每张部位表的第一行为默认值
local function init_machinecfg(uid, cfgid, userindex)
	local bodyids = string.split(hangar_dc.req.getvalue(uid, "newbody"))
	local chassisids = string.split(hangar_dc.req.getvalue(uid, "newchassis"))
	local firecontrolids = string.split(hangar_dc.req.getvalue(uid, "newfirecontroller"))
	local weaponids = string.split(hangar_dc.req.getvalue(uid, "newweapons"))

	-----------------------------------------
	local init_data = user_dc.req.get_roleinit(tostring(userindex+1))
	if init_data.str1 ~= nil then
		local machineinfo = string.split(init_data.str1, ";")
		for _, v in pairs(machineinfo) do
			local info = string.split(v, ",")
			-- machinecfgid 累加 getmaxmachinecfgid
			local row = { id = tonumber(cfgid), 
						playerid = tonumber(uid), 
						-- todo machineid没用
						machineid = info[1],
						machinebody = find_part(warehousedefine.warehousetype.body, uid, info[2]), 
						machinechassis = find_part(warehousedefine.warehousetype.chassis, uid, info[3]), 
						firecontroller = find_part(warehousedefine.warehousetype.firecontroller, uid, info[4]),
						name = get_machine_name(tonumber(info[2]), tonumber(info[3]), tonumber(info[4])),
						weapons = find_part(warehousedefine.warehousetype.weapon, uid, info[5]) .. ",0,0,"
						 ..  find_part(warehousedefine.warehousetype.weapon, uid, info[6]) .. ",0,0",
						userindex = userindex,
						isweld = 0,
						begintime = 0,
						endtime = 0,
						}
			-- 海姆达尔 
			if userindex == 1 then
				row.weapons = row.weapons .. "," .. find_part(warehousedefine.warehousetype.weapon, uid, info[7]) .. ",0"
			end
			machinecfg_dc.req.add(row)
			achievement.req.updatechallenge(uid, achievementdefine.achievetype.machine)
			local row = { id = tonumber(cfgid), life = 0, speed = 0, energy = 0,
				shield = 0, scopeskill = 0, intensityskill = 0, persistskill = 0, 
				atk = 0, scopeatk = 0, distance = 0, elevation = 0, overhang = 0,
				enefficiency = 0, efficiency = 0, climbingangle = 0
			} 
			chipattribute_dc.req.add(row)
			skill_dc.req.add({id = tonumber(cfgid), skillarray = "", passkillarray = "", selectskill = ""})
		end
	else

	end
	LOG_INFO("init_playerinfo ok, uid %d", uid)

	return true
end

local function init_machineinfo(uid)
	local init_data = user_dc.req.get_roleinit("2")
	if init_data.str1 ~= nil then
		local machineinfo = string.split(init_data.str1, ";")
		for _, v in pairs(machineinfo) do
			local info = string.split(v, ",")
			local machinecfgid = ""
			for i = 1, 3 do
				local nextcfgid = machinecfg_dc.req.get_nextid()
				init_machinecfg(uid, nextcfgid, i)
				if i ~= 1 then
					machinecfgid = machinecfgid .. "," .. nextcfgid
				else
					machinecfgid = nextcfgid
				end
			end
			
			local row = {id = tonumber(uid), defaultindex = 1, machinecfgid = machinecfgid}
			machineinfo_dc.req.add(row)
		end
	end
	LOG_INFO("init_machineinfo ok, uid %d", uid)
	return true
end

--装备信息初始化
local function setinfo(uid, data, equiptype)
	local expcfg = {}
	local temp = ""
	local cfgid = ""
	for i = 1, #data do
		--武器10001不发
		if equiptype == warehousedefine.warehousetype.weapon and data[i] == 10001 then
		else	
			if data[i] < 90000 then
				local tempid = tonumber(equipment_dc.req.get_nextid(equiptype))
				local row = { id = tempid, cfgid = data[i],  playerid = tonumber(uid), lv = 1, exp = 0,
				slotarray = json.encode({{},{},{},{},{}}), isdouble = 0, volume = 4, currentvolume = 0, count = 0}
				if equiptype ~= warehousedefine.warehousetype.weapon then
					row.islock = 0
				end
				equipment_dc.req.add(equiptype, row)
				table.insert(expcfg, {cfgid = data[i], maxlv = 1})
				if temp ~= "" then
					temp = temp .. "," .. tempid
					cfgid = cfgid .. "," .. data[i]
				else
					temp = tempid
					cfgid = data[i]
				end
			end
		end
	end
	return temp, cfgid, expcfg
end

-- 初始化装备表
local function init_equipinfo(uid)
	local tempbody, cfgbody = "" , ""
	local tempchassis, cfgchassis = "", ""
	local tempfirecontrol, cfgfirecontrol = "", ""
	local tempweapon, cfgweapon = "", ""
	local expbody, expchassis, expfirecontroller, expweapon = {},{},{},{}

	-- todo 阿尔法版本装备全开
	-- 机体表
	local body = table.keys(sharedata.deepcopy("machinebody"))
	tempbody, cfgbody, expbody = setinfo(uid, body, warehousedefine.warehousetype.body)

	-- 底盘表
	local chassis = table.keys(sharedata.deepcopy("machinechassis"))
	tempchassis, cfgchassis, expchassis = setinfo(uid, chassis, warehousedefine.warehousetype.chassis)

	-- 火控表
	local firecontrol = table.keys(sharedata.deepcopy("firecontrol"))
	tempfirecontrol, cfgfirecontrol, expfirecontroller = setinfo(uid, firecontrol, warehousedefine.warehousetype.firecontroller)

	-- 武器表
	local weapon = table.keys(sharedata.deepcopy("weapontable"))
	tempweapon, cfgweapon, expweapon = setinfo(uid, weapon, warehousedefine.warehousetype.weapon)

	-- 插入机库索引表
	local row = {id = uid, newbody=tempbody, newchassis=tempchassis, newfirecontroller=tempfirecontrol, newweapons=tempweapon,
		body="", chassis="", firecontroller="", weapons=""}
	hangar_dc.req.add(row)
	row = {id = uid, body = json.encode(expbody),
				 chassis = json.encode(expchassis),
				 firecontroller = json.encode(expfirecontroller),
				 weapon = json.encode(expweapon)}
	collection_dc.req.add(row)
	achievement = snax.uniqueservice("achievement")
	achievement.req.updatechallenge(uid, achievementdefine.achievetype.weapon_a, nil, table.size(expweapon))
	achievement.req.updatechallenge(uid, achievementdefine.achievetype.chassis_a, nil, table.size(expchassis))
	achievement.req.updatechallenge(uid, achievementdefine.achievetype.fire_a, nil, table.size(expfirecontroller))
	achievement.req.updatechallenge(uid, achievementdefine.achievetype.body_a, nil, table.size(expbody))
	achievement.req.updatechallenge(uid, achievementdefine.achievetype.weapon_g, nil, table.size(expweapon))
	achievement.req.updatechallenge(uid, achievementdefine.achievetype.chassis_g, nil, table.size(expchassis))
	achievement.req.updatechallenge(uid, achievementdefine.achievetype.fire_g, nil, table.size(expfirecontroller))
	achievement.req.updatechallenge(uid, achievementdefine.achievetype.body_g, nil, table.size(expbody))
end

local function init_chipinfo(uid)	
	local chip = table.keys(sharedata.deepcopy("mod"))
	table.sort(chip)
	local chipdata = {}
	for i = 13, math.min(100, #chip) do
		table.insert(chipdata, {id = chip[i], number = 4, level = 1, islock = 0})
	end
	local row = {id = tonumber(uid), newchipinfo = json.encode(chipdata), chipinfoarr = json.encode({}), inchipinfoarr = json.encode({})}
	chip_dc.req.add(row)
end

local function init_scoreinfo(uid)
	local score = tonumber(1000  ..".".. (9999999999 - tonumber(string.sub(timext.current_time(), 1, 10))))
	score_dc.req.add({id = tonumber(uid), score = score})
	do_redis({ "zadd", "ladder", score, uid}, uid)
end

local function init_materialsinfo(uid)
	local data = table.keys(sharedata.deepcopy("blueprint"))
	local num, i= 10, 0
	local materials = {}
	-- table.insert(materials, {id = "110001210001310001", number = 2, name = "扫描而来，灭霸"})
	for k, v in pairs(data) do
		if i >= math.min(10, #data) then
			break
		end
		i = i + 1
		table.insert(materials, {id = string.sub(data[i], 2, -1), number = 10})
	end
	blueprint_dc.req.add({id = uid, newblueprint = json.encode(materials), blueprintinfo = json.encode({}), blueprinting = json.encode({}), blueprintend = json.encode({})})

	data = table.keys(sharedata.deepcopy("material_list"))
	materials = ""
    for i = 1, #data do
        if materials == "" then
            materials = data[i] .. "," .. num
        else
            materials = materials .. "," .. data[i] .. "," .. num
        end
    end
	materials_dc.req.add({id = tonumber(uid), newmaterials = materials, materials = ""})
	
	data = table.keys(sharedata.deepcopy("store"))
	materials = ""
    for i = 1, #data do
        if materials == "" then
            materials = data[i] .. "," .. num
        else
            materials = materials .. "," .. data[i] .. "," .. num
        end
    end
	prop_dc.req.add({id = uid, newprops = materials, props = ""})
end

local function init_achieve(uid)
	-- local athletics = table.keys(sharedata.deepcopy("npc"))
	-- local data = {}
	-- for i = 1, #athletics do
	-- 	local achieves = sharedata.deepcopy("npc", tonumber(athletics[i])).Weapon
	-- 	data = {id = (uid - 1) * 100 + athletics[i], athleticslist = json.encode({id = achieves[1], isget = false, finishtime = nil}), number = 0， uid = uid}
	-- 	athletics_dc.req.add(data)
	-- 	data = {id = (uid - 1) * 100 + athletics[i], challengelist = json.encode({id = achieves[1], isget = false, finishtime = nil}), number = 0,  uid = uid}
	-- 	challenge_dc.req.add(data)
	-- 	data = {id = (uid - 1) * 100 + athletics[i], challengelist = json.encode({id = achieves[1], isget = false, finishtime = nil}), number = 0,  uid = uid}
	-- 	plot_dc.req.add(data)
	-- end
	achievement.req.updateplot(uid, achievementdefine.achievetype.plot_s1)
	achievement.req.updateplot(uid, achievementdefine.achievetype.plot_d1)
	achievement.req.updateplot(uid, achievementdefine.achievetype.plot_s2)
	achievement.req.updateplot(uid, achievementdefine.achievetype.plot_d2)
	achievement.req.updateplot(uid, achievementdefine.achievetype.plot_s3)
	achievement.req.updateplot(uid, achievementdefine.achievetype.plot_d3)

	overview_dc.req.add({id = uid, plotnum = 0, athleticsnum = 0, challengenum = 0, plot = "", athletics = "", challenge = ""
	, current = 1, achievelist = json.encode({})})
end

local function init_putaway(uid)
	putawayinfo_dc.req.add({id = uid, goldarr = "", khoriumarr = ""})
end

local function init_queueinfo(uid)
	local data = {
		id = tonumber(uid),
		ingcasting = "",
		endcasting = "",
		ingscan = "",
		endscan = "",
		airfreighter1 = "",
		airfreighter2 = "",
		airfreighter3 = "",
		maxcasting = 5,
		maxairfreighter = 3,
		maxperairfreighter = 10,
		tmpbqinfos = ""
	}
	queueinfo_dc.req.add(data)	
end

function response.load(uid)
	if not uid then return end
	EntUser:load(uid)
end

function response.unload(uid)
	if not uid then return end
	EntUser:unload(uid)
end

---当前天的零点
local function zerotime()
    local time = os.date("*t")
    time.min = 0
    time.sec = 0
    time.hour = 0
    return os.time(time)
end

function response.roleinit(uid)
	if uid == 1 then
		return
	end
	--设置IP数量
	local zerotime, ipsum_gate, playingnum = zerotime(), get_ipsum(), get_user_fds()
	local ipsum = info_dc.req.getvalue(zerotime, "ipsum")
	skynet.error("数据库数量", ipsum, "当前数量", ipsum_gate)
	if ipsum < ipsum_gate then
		info_dc.req.setvalue(zerotime, "ipsum", ipsum_gate)
	end
	info_dc.req.setvalue(zerotime, "playingsum", table.size(playingnum))
	---

	if user_dc.req.check_role_exists(uid) then
		user_dc.req.setvalue(uid, "ltime", timext.current_time())
		return
	end

	local row = {
		id = uid,
		name = "游客"..tostring(uid),
		level = 1,
		exp = 0,
		imgcfgid = 10001,
		description = "自定义介绍",
		showid = nil,
		rtime = timext.current_time(),
		ltime = timext.current_time(),
		etime = 0,
		onlinetime = 0,
		daytime = 0,
		addictiontime = nil,
		age = 17
	}

	local ret = user_dc.req.add(row)
	gold_dc.req.add({id = uid, goldnumber = 1000000})
	khorium_dc.req.add({id = uid, khorium = 1000000000})
	shopiteminfo_dc.req.add({id = uid, shopiteminfo = ""})
	putawayinfo_dc.req.add({id = uid, goldarr = "", khoriumarr = "", staygoldarr = "", staykhoriumarr = ""})
	userset_dc.req.add({id = uid, max_material = 200, max_weapon = 50, max_body = 50, max_fire = 50, max_chassis = 50, max_chip = 200})
	-- 按顺序来初始化
	init_scoreinfo(uid)
	init_equipinfo(uid)
	init_machineinfo(uid)
	init_playerinfo(uid)
	init_queueinfo(uid)
	init_chipinfo(uid)
	init_materialsinfo(uid)
	init_achieve(uid)
	init_putaway(uid)
end
