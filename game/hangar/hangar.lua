local skynet = require "skynet"
local snax = require "skynet.snax"
local errCodeDef = require "errcodedef"
local sharedata = require "skynet.sharedata"
local json = require"cjson"

local hangardc
local equipment_dc
local machinecfg_dc
local machineinfo_dc
local teammatchsvr
local player_dc
local show_dc
local user_dc
local collection_dc
local skill_dc
local warehouse

---@param ty boolean true用于展示机甲数据
local function get_cfg_machine_by_index(uid, index, ty)
	local rawcfgids = machineinfo_dc.req.getvalue(uid, "machinecfgid")
	local cfgids = string.split(tostring(rawcfgids), ",")
	local cfgdata = machinecfg_dc.req.get(cfgids[index])

	local cfgbody = string.split(cfgdata.machinebody)
	local cfgchassis = string.split(cfgdata.machinechassis)
	local cfgweapons = string.split(cfgdata.weapons)
	local cfgfirecontroller = string.split(cfgdata.firecontroller)

	-- 当前选中的配置信息	
	local machineinitinfo = {}
	machineinitinfo.body = {}
	machineinitinfo.chassis = {}
	machineinitinfo.firecontroller = {}
	machineinitinfo.weapons = {}

	if ty then
		machineinitinfo.name = cfgdata.name
		machineinitinfo.id = uid
	else
		machineinitinfo.isweld = cfgdata.isweld == 1 and true or false
	end

	for i = 1, #cfgbody do
		cfgbody[i] = tonumber(cfgbody[i])
		local equip = equipment_dc.req.get(warehousedefine.warehousetype.body, cfgbody[i])
		if ty then
			table.insert(machineinitinfo.body, {cfgid=equip.cfgid, lv=equip.lv})
		else
			table.insert(machineinitinfo.body, {uniqueid=equip.id, cfgid=equip.cfgid, lv=equip.lv, exp = equip.exp})
		end
	end

	for i = 1, #cfgchassis do
		cfgchassis[i] = tonumber(cfgchassis[i])
		local equip = equipment_dc.req.get(warehousedefine.warehousetype.chassis, cfgchassis[i])
		if ty then
			table.insert(machineinitinfo.chassis, {cfgid=equip.cfgid, lv=equip.lv})
		else
			table.insert(machineinitinfo.chassis, {uniqueid=equip.id, cfgid=equip.cfgid, lv=equip.lv, exp = equip.exp})
		end
	end

	for i = 1, #cfgweapons do
		cfgweapons[i] = tonumber(cfgweapons[i])
		local equip = equipment_dc.req.get(warehousedefine.warehousetype.weapon, cfgweapons[i])
		if ty then
			table.insert(machineinitinfo.weapons, {cfgid=equip.cfgid, lv=equip.lv})
		else
			table.insert(machineinitinfo.weapons, {uniqueid=equip.id, cfgid=equip.cfgid, lv=equip.lv, exp = equip.exp})
		end
	end

	for i = 1, #cfgfirecontroller do
		cfgfirecontroller[i] = tonumber(cfgfirecontroller[i])
		local equip = equipment_dc.req.get(warehousedefine.warehousetype.firecontroller, cfgfirecontroller[i])
		if ty then
			table.insert(machineinitinfo.firecontroller, {cfgid=equip.cfgid, lv=equip.lv})
		else
			table.insert(machineinitinfo.firecontroller, {uniqueid=equip.id, cfgid=equip.cfgid, lv=equip.lv, exp = equip.exp})
		end
	end
	return machineinitinfo
end

local function get_part_index(uid, part)
	local partindexs = {}
	if part == warehousedefine.warehousetype.chassis then
		partindexs = string.split(hangardc.req.getvalue(uid, "chassis"))
	elseif part == warehousedefine.warehousetype.body then
		partindexs = string.split(hangardc.req.getvalue(uid, "body"))
	elseif part == warehousedefine.warehousetype.firecontroller then
		partindexs = string.split(hangardc.req.getvalue(uid, "firecontroller"))
	elseif part == warehousedefine.warehousetype.weapon then
		partindexs = string.split(hangardc.req.getvalue(uid, "weapons"))
	end
	return partindexs
end

local function get_newpart_index(uid, part)
	local partindexs = {}
	if part == warehousedefine.warehousetype.chassis then
		partindexs = string.split(hangardc.req.getvalue(uid, "newchassis"))
	elseif part == warehousedefine.warehousetype.body then
		partindexs = string.split(hangardc.req.getvalue(uid, "newbody"))
	elseif part == warehousedefine.warehousetype.firecontroller then
		partindexs = string.split(hangardc.req.getvalue(uid, "newfirecontroller"))
	elseif part == warehousedefine.warehousetype.weapon then
		partindexs = string.split(hangardc.req.getvalue(uid, "newweapons"))
	end
	return partindexs
end

---获取所有部件
local function get_part_info(uid, part)
	local partinfos = {}
	local partindexs = get_part_index(uid, part)
	for i = 1, #partindexs do
		local equip = equipment_dc.req.get(part, tonumber(partindexs[i]))
		local perinfo = { uniqueid=equip.id, cfgid=equip.cfgid, lv=equip.lv, exp=equip.exp, islock = equip.islock == 1 and true or false, isnew = false}
		table.insert(partinfos, perinfo)
	end
	local partindexs = get_newpart_index(uid, part)
	for i = 1, #partindexs do
		local equip = equipment_dc.req.get(part, tonumber(partindexs[i]))
		local perinfo = { uniqueid=equip.id, cfgid=equip.cfgid, lv=equip.lv, exp=equip.exp, islock = equip.islock == 1 and true or false, isnew = true}
		table.insert(partinfos, perinfo)
	end
	return partinfos
end

-- 某个装备增加经验，判断等级是否增加，用返回的结果写入
local function addexp(uid, perinfo, exp, part)
	warehouse = snax.queryservice("warehouse")
	return warehouse.req.addexp(uid, perinfo, exp, part)
end

local function update_attribute(uid)
	-- 拿默认机甲配置
	local defaultindex = tonumber(machineinfo_dc.req.getvalue(uid, "defaultindex"))
	local rawcfgids = machineinfo_dc.req.getvalue(uid, "machinecfgid")
	local cfgids = string.split(tostring(rawcfgids), ",")
	local cfgdata = machinecfg_dc.req.get(cfgids[defaultindex])

	-- 根据默认机甲配置，读静态表算属性
	local body = equipment_dc.req.getcfgid(warehousedefine.warehousetype.body, tonumber(string.split(cfgdata.machinebody)[1]))
	local chassis = equipment_dc.req.getcfgid(warehousedefine.warehousetype.chassis, tonumber(string.split(cfgdata.machinechassis)[1]))
	local firecontroller = equipment_dc.req.getcfgid(warehousedefine.warehousetype.firecontroller, tonumber(string.split(cfgdata.firecontroller)[1]))
	-- local weapons = equipment_dc.req.getcfgid(warehousedefine.warehousetype.weapon, string.split(cfgdata.weapons))

	local sdmachinebody = sharedata.deepcopy("machinebody", tonumber(body))
	local sdmachinechassis = sharedata.deepcopy("machinechassis", tonumber(chassis))
	local sdfirecontrol = sharedata.deepcopy("firecontrol", tonumber(firecontroller))
	-- local sdweapon = sharedata.deepcopy("weapontable", tonumber())

	-- local shield = 0
	local row = { id = tonumber(uid), life = tonumber(sdmachinebody.Hp), 
				speed = tonumber(sdmachinechassis.Round_Speed), energy = tonumber(sdmachinebody.Power_Valuegy),
				shield = tonumber(sdmachinebody.Sheld_Value), elevation = sdfirecontrol.Attack_Angle_Max, overhang = sdfirecontrol.Attack_Angle_Min,
				enefficiency = math.ceil(sdfirecontrol.Power_Efficiency * 1000) * 0.001, efficiency = math.ceil(sdmachinechassis.engine_efficiency * 1000) * 0.001, 
				climbingangle = sdmachinechassis.Chassis_Creeping_Angle
			} 
	player_dc.req.update(row)
end

function init(...)
    hangardc = snax.queryservice("hangardc")
	equipment_dc = snax.queryservice("equipmentdc")
	machinecfg_dc = snax.uniqueservice("machinecfgdc")
	machineinfo_dc = snax.uniqueservice("machineinfodc")
	player_dc = snax.uniqueservice("playerattributedc")
	show_dc = snax.queryservice("showdc")
	user_dc = snax.queryservice("userdc")
	collection_dc = snax.queryservice("collectiondc")
	skill_dc = snax.uniqueservice("skilldc")
end

function exit(...)
end

-- 给参战机甲增加经验
function response.add_curmachine_exp(uid, exp)
	-- 取出数据
	local curcfgindex = machineinfo_dc.req.getvalue(uid, "defaultindex")
	local machineinitinfo = get_cfg_machine_by_index(uid, curcfgindex, false)
	
	-- 增加经验，根据等级计算芯片容量, 并入库
	for i = 1, #machineinitinfo.body do
		machineinitinfo.body[i] = addexp(uid, machineinitinfo.body[i], exp, warehousedefine.warehousetype.body)
	end
	
	for i = 1, #machineinitinfo.chassis do
		machineinitinfo.chassis[i] = addexp(uid, machineinitinfo.chassis[i], exp, warehousedefine.warehousetype.chassis)
	end
	
	for i = 1, #machineinitinfo.firecontroller do
		machineinitinfo.firecontroller[i] = addexp(uid, machineinitinfo.firecontroller[i], exp, warehousedefine.warehousetype.firecontroller)
	end

	for i = 1, #machineinitinfo.weapons do
		machineinitinfo.weapons[i] = addexp(uid, machineinitinfo.weapons[i], exp, warehousedefine.warehousetype.weapon)
	end

	-- 写入数据
	-- equipment_dc.req.setvalue(warehousedefine.warehousetype.body, uid, key, value)
	local msg = {}
	msg.machineinfo = machineinitinfo
	send_request(get_user_fd(uid), msg, "hargar_syncmachineinfo")
end

function response.changecfgindex(data)
	local ret = {}
	local uid = data.uid
	local defaultindex = data.msg.defaultindex
	ret.code = errCodeDef.eEC_success

	local cfgids = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
	if defaultindex > #cfgids or defaultindex < 1 then
		ret.code = errCodeDef.eEC_err_param
	else
		ret.machineinfo = get_cfg_machine_by_index(uid, defaultindex, false)
		machineinfo_dc.req.setvalue(uid, "defaultindex", defaultindex)
	end
	update_attribute(uid)
	return ret
end

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
	local ret = {}
	local uid = data.uid
	local name = data.msg.name

	--名称规范
	ret.code = name_match(name)
	if string.utf8len(name) < 3 or string.utf8len(name) > 7 then
		ret.code = errCodeDef.eEC_role_name_length
	end
	if ret.code ~= nil then
		return ret
	end
	ret.code = errCodeDef.eEC_success
	local cfgids = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
	local defaultindex = machineinfo_dc.req.getvalue(uid, "defaultindex")
	local machinecfg = machinecfg_dc.req.get(tonumber(cfgids[defaultindex]))
	if defaultindex > #cfgids or defaultindex < 1 or not next(machinecfg) then
		ret.code = errCodeDef.eEC_err_param
	else
		machinecfg_dc.req.setvalue(tonumber(cfgids[defaultindex]), "name", name)
	end
	return ret
end

---获取部件装备的位置
---@return integer 返回机甲表id
local function find_equip_index(uid, part, uniqueid)
	local machineinfo = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
    for i = 1, #machineinfo do
        local machinecfg = machinecfg_dc.req.get(tonumber(machineinfo[i]))
        local equipinfo
        if part == warehousedefine.warehousetype.chassis then
            equipinfo = string.split(machinecfg.machinechassis)
        elseif part == warehousedefine.warehousetype.body then
            equipinfo = string.split(machinecfg.machinebody)
        elseif part == warehousedefine.warehousetype.firecontroller then
            equipinfo = string.split(machinecfg.firecontroller)
        elseif part == warehousedefine.warehousetype.weapon then
            equipinfo = string.split(machinecfg.weapons)
        end
        for j = 1, #equipinfo do
            if uniqueid == tonumber(equipinfo[j]) then
                return tonumber(machineinfo[i])    
            end
        end
    end
    return nil
end

local function get_index(arry, record)
    for k, v in pairs(arry) do
        if tonumber(v) == tonumber(record) then
            return k
        end
    end
    return nil
end

---判断部件是否焊死以及可装备
---@param machinecfg table 机体数据信息
---@return integer 未焊死可装备返回1
local function weldandtype(part, uniqueid, machinecfg, index)
	if part ~= warehousedefine.warehousetype.weapon then
		--判断焊死
		if machinecfg.isweld == 1 then
			return errCodeDef.eEC_equip_welding
		end
	end

	--判断武器类型可否装备
	if part == warehousedefine.warehousetype.weapon and uniqueid ~= 0 then
		local firecid = string.split(machinecfg.firecontroller)[1]
		local firecontrolcfg = equipment_dc.req.getcfgid(warehousedefine.warehousetype.firecontroller, firecid)
		local firecfgtype = sharedata.deepcopy("firecontroltype", tonumber(firecontrolcfg))
		local equipcfg = equipment_dc.req.getcfgid(warehousedefine.warehousetype.weapon, uniqueid)
		local equipcfgtype = sharedata.deepcopy("weapontable", tonumber(equipcfg))
		--近战只能装备到右手即槽位2
		if equipcfgtype.Weapon_Type == 10006 and (4 > index or index > 6) then
			return errCodeDef.eEC_weapon_type
		end
		skynet.error("changeequip: ", tostring(firecfgtype.Weapon_Type), table.find(firecfgtype.Weapon_Type, equipcfgtype.Weapon_Type), equipcfgtype.Weapon_Type)
		if not table.find(firecfgtype.Weapon_Type, equipcfgtype.Weapon_Type) then
			return errCodeDef.eEC_weapon_type
		end
	end
	return errCodeDef.eEC_success
end

function response.changeequip(data)
	local ret = {}
	local uid = data.uid
	local part = data.msg.part
	local uniqueid = data.msg.uniqueid
	local index = data.msg.index
	local isnew = data.msg.isnew


	if part < 1 or part > 4 or (part ~= 4 and uniqueid == 0) or isnew == nil then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end
	-- uniqueid是否是自己拥有的
	local partindexs = {}
	if isnew then
		partindexs = get_newpart_index(uid, part)
	else
		partindexs = get_part_index(uid, part)
	end
	if uniqueid ~= 0 and table.find(partindexs, tostring(uniqueid)) == nil then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end

	-- 装备所属机甲
	local machinecfg = find_equip_index(uid, part, uniqueid)
	-- 获得当前配置的index进行修改
	local curcfgindex = machineinfo_dc.req.getvalue(uid, "defaultindex")
	local cfgids = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
	local realcfgindex = tonumber(cfgids[curcfgindex])
	-- 重复装备
	if machinecfg and machinecfg == realcfgindex then
		ret.code = errCodeDef.eEC_equip_repeat
		return ret
	end
	local cfgdata = machinecfg_dc.req.get(realcfgindex)
	ret.code = weldandtype(part, uniqueid, cfgdata, index)
	if ret.code ~= errCodeDef.eEC_success then
		return ret
	end

	local partkey = ""
	if part == warehousedefine.warehousetype.chassis then
		partkey = "machinechassis"
	elseif part == warehousedefine.warehousetype.body then
		partkey = "machinebody"
	elseif part == warehousedefine.warehousetype.firecontroller then
		partkey = "firecontroller"
	elseif part == warehousedefine.warehousetype.weapon then
		partkey = "weapons"
	end

	local partdata = string.split(cfgdata[partkey])
	if index < 1 or index > #partdata then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end
	
	local olduniqueid = partdata[index]   ---当前装备
	partdata[index] = uniqueid
	local newpart = ""
	local chip = snax.queryservice("chip")

	-- 原机甲更新
	if machinecfg then
		local old_machine = machinecfg_dc.req.get(machinecfg)
		local old_partdata = string.split(old_machine[partkey])
		local old_index = get_index(old_partdata, uniqueid)
		old_partdata[old_index] = olduniqueid

		ret.code = weldandtype(part, olduniqueid, old_machine, old_index)
		if ret.code ~= errCodeDef.eEC_success then
			return ret
		end

		if partkey == "weapons" then
			old_partdata[old_index] = 0
		end
		-- 海姆达尔的临时处理，要换上海姆达尔或卸下海姆达尔机体
		if partkey == "machinebody" then
			local body = equipment_dc.req.getcfgid(warehousedefine.warehousetype.body, olduniqueid)
			local weaponids = string.split(old_machine.weapons)
	
			if body == 10001 and #weaponids < 8 then
				table.insert(weaponids, 0)
				table.insert(weaponids, 0)
			end
			-- 机体从海姆达尔换下，获取武器数据，将最后一把换成0写入数据库
			if body ~= 10001 and #weaponids == 8 then
				table.remove(weaponids, 8)
				table.remove(weaponids, 7)
			end
			machinecfg_dc.req.setvalue(machinecfg, "weapons", string.join(weaponids))
		end
		machinecfg_dc.req.setvalue(machinecfg, partkey, string.join(old_partdata))
		chip.req.changeequip(uid, part, machinecfg, uniqueid, nil)
		chip.req.changeequip(uid, part, machinecfg, nil, old_partdata[old_index] ~= 0 and old_partdata[old_index] or nil)
	end
	
	-- 海姆达尔的临时处理，要换上海姆达尔或卸下海姆达尔机体
	if partkey == "machinebody" then
		local body = equipment_dc.req.getcfgid(warehousedefine.warehousetype.body, uniqueid)
		local weaponids = string.split(machinecfg_dc.req.getvalue(realcfgindex, "weapons"))

		if body == 10001 and #weaponids < 8 then
			table.insert(weaponids, 0)
			table.insert(weaponids, 0)
		end
		-- 机体从海姆达尔换下，获取武器数据，将最后一把换成0写入数据库
		if body ~= 10001 and #weaponids == 8 then
			table.remove(weaponids, 8)
			table.remove(weaponids, 7)
		end
		machinecfg_dc.req.setvalue(realcfgindex, "weapons", string.join(weaponids))
	end

	machinecfg_dc.req.setvalue(realcfgindex, partkey, string.join(partdata))
	chip.req.changeequip(uid, part, realcfgindex, tonumber(olduniqueid) ~= 0 and olduniqueid or nil, uniqueid ~= 0 and uniqueid or nil)
	local newweaponids = string.split(machinecfg_dc.req.getvalue(realcfgindex, "weapons"))
	ret.weapons = newweaponids
	update_attribute(uid)

	ret.code = errCodeDef.eEC_success
	return ret
end

function response.returnteammatch(data)
	local ret = {}
	local uid = data.uid
	if teammatchsvr == nil then
		teammatchsvr = snax.queryservice("teammatch")
	end
	local mateids = teammatchsvr.req.getroommateid(uid)
	
	if not next(mateids or {}) then
		return
	end
	
	ret.machineinfo = teammatchsvr.req.getmachineinfo(uid)
	ret.playerid = uid
	for i = 1, #mateids do
		send_request(get_user_fd(mateids[i]), ret, "hangar_ontmreturn")
	end
end

function response.setshow(data)
	local ret = {}
	local uid = data.uid
	local defaultindex = data.msg.defaultindex
	if defaultindex == nil then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end
	-- 是否是自己拥有的
	local machinecfgid = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
	if defaultindex > table.size(machinecfgid) or defaultindex <= 0 then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end
	local data = get_cfg_machine_by_index(uid, defaultindex, true)
	local showid = show_dc.req.getvalue(uid, "id")
	if showid then
		show_dc.req.update({id = data.id, name = data.name, body = json.encode(data.body), chassis = json.encode(data.chassis),
		firecontroller = json.encode(data.firecontroller), weapon = json.encode(data.weapons)})
	else
		show_dc.req.add({id = data.id, name = data.name, body = json.encode(data.body), chassis = json.encode(data.chassis),
		firecontroller = json.encode(data.firecontroller), weapon = json.encode(data.weapons)})
	end
	user_dc.req.setvalue(uid, "showid", uid)
	ret.code = errCodeDef.eEC_success
	return ret
end

function response.clearshow(data)
	local ret = {}
	local uid = data.uid

	local showid = show_dc.req.get(uid)
	if not next(showid or {}) then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end
	ret.code = errCodeDef.eEC_success
	show_dc.req.delete({id = uid})
	user_dc.req.setvalue(uid, "showid", nil)
	return ret
end

function response.selectskill(data)
	local ret = {}
	local uid = data.uid
	local part = data.msg.part
	local skillid = data.msg.skillid

	if part < 1 or part > 4 or not skillid then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end
	ret.code = errCodeDef.eEC_success
	local curcfgindex = machineinfo_dc.req.getvalue(uid, "defaultindex")
	local cfgids = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
	local skillinfo = skill_dc.req.get(tonumber(cfgids[curcfgindex]))
	local skillarr = string.split(skillinfo.skillarray)
	local selectskill = string.split(skillinfo.selectskill)
	--目前大致可以直接find,因为skillarr中存储的是part,skillid为一组的多组集合，part的值不影响skillid。【注意】
	if not table.find(skillarr, tostring(skillid)) then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end
	skill_dc.req.setvalue(tonumber(cfgids[curcfgindex]), "selectskill", part .. "," .. skillid)
	return ret
end

function response.showskill(data)
	local ret = {}
	ret.showskillinfo = {}
	local uid = data.uid

	-- 获得当前配置的index
	local curcfgindex = machineinfo_dc.req.getvalue(uid, "defaultindex")
	local cfgids = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))

	local skill = skill_dc.req.get(tonumber(cfgids[curcfgindex]))
	local skillarray = string.split(skill.skillarray)
	local selectskill = string.split(skill.selectskill)
	for i = 1, #skillarray, 2 do
		table.insert(ret.showskillinfo, {part = skillarray[i], skillid = skillarray[i + 1]})
	end
	ret.selectskill = {part = selectskill[1], skillid = selectskill[2]}
	-- skynet.error("showskill", tostring(ret))
	return ret
end

---焊死
function response.setwelding(data)
	local ret = {}
	local uid = data.uid
    local index = data.msg.index

	if not index then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end

	local machinecfgid = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
	if index > table.size(machinecfgid) or index <= 0 then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end
	local id = tonumber(machinecfgid[index])
	local machinecfg = machinecfg_dc.req.get(id)
	if not next(machinecfg) then
		ret.code = errCodeDef.eEC_cfgid_nofind
		return ret
	end
	
	local isweld = machinecfg.isweld == 0 and 1 or 0
	if warehouse == nil then
		warehouse = snax.queryservice("warehouse")
	end
	if isweld == 1 then
		-- 材料余量判断【注意 焊死消耗道具id临时写死】
		if not warehouse.req.matchprop(uid, 10003, 1) then
			ret.code = errCodeDef.eEC_res_notEnough
			return ret
		end
		warehouse.req.remprop(uid, 10003, 1)
	else
		-- 材料余量判断【注意 取消焊死消耗道具id临时写死】
		if not warehouse.req.matchprop(uid, 10004, 1) then
			ret.code = errCodeDef.eEC_res_notEnough
			return ret
		end
		warehouse.req.remprop(uid, 10004, 1)
	end
	machinecfg_dc.req.setvalue(id, "isweld", isweld)
	ret.code = errCodeDef.eEC_success
	return ret
end

--锁定部件
function response.setlockequip(data)
	local ret = {}
	local uid = data.uid
	local part = data.msg.part
	local uniqueid = data.msg.uniqueid
	local isnew = data.msg.isnew
	
	if not uniqueid or isnew == nil then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end
	local partindexs = {}
	if isnew then
		partindexs = get_newpart_index(uid, part)
	else
		partindexs = get_part_index(uid, part)
	end
	if uniqueid ~= 0 and table.find(partindexs, tostring(uniqueid)) == nil then
		ret.code = errCodeDef.eEC_err_param
		return ret
	end
	local islock = equipment_dc.req.getvalue(part, uniqueid, "islock")
	equipment_dc.req.setvalue(part, uniqueid, "islock", islock == 1 and 0 or 1)
	ret.code = errCodeDef.eEC_success
	return ret
end

function response.online(uid, fd)
	if uid == 1 then
		return
	end
	-- 按部位顺序下发机库信息
	for i = 1, 4 do
		local msg = {}
		msg.part = i
		msg.equipmentinfo = get_part_info(uid, i)

		send_request(fd, msg, "hangar_equipmentinfo")
	end

	-- local defaultindex = tonumber(machineinfo_dc.req.getvalue(uid, "defaultindex")) 
	
	local cfgids = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
	local machineinitinfos = {}
	machineinitinfos.machineinfos ={}
	machineinitinfos.defaultindex = machineinfo_dc.req.getvalue(uid, "defaultindex")

	for i = 1, #cfgids do
		local machineinitinfo = get_cfg_machine_by_index(uid, i, false)
		table.insert(machineinitinfos.machineinfos, machineinitinfo)
	end
	-- 下发
	send_request(fd, machineinitinfos, "hangar_machineinfo")
end

function response.offline(uid)
end