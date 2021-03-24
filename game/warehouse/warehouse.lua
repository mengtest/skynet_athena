local skynet = require "skynet"
local snax = require "skynet.snax"
local sharedata = require "skynet.sharedata"
local errCodeDef = require "errcodedef"
local json = require "cjson"
local timext = require "timext"

local user_dc
local userset_dc
local role_obj
local machinecfg_dc
local machineinfo_dc
local equipment_dc
local hangar_dc
local chip_dc
local blueprint_dc
local materials_dc
local gold_dc
local chipattribute_dc
local bq_dc
local prop_dc
local queueinfo_dc
local khorium_dc
local awardinfo_dc
local collection_dc
local achievement

---获取装备信息
---@param hangarstr string hangar表中字段   
---@param machinecfgstr string manchinecfg表中字段
local function get_equip_info(hangarstr, machinecfgstr, uid, beginindex, endindex)
    local machineinfo = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
    
    --装备表和锁定表
    local tab, weld = {}, {}   
    for k, v in pairs(machineinfo) do
        local machinecfg = string.split(machinecfg_dc.req.getvalue(tonumber(v), machinecfgstr))
        local isweld = machinecfg_dc.req.getvalue(tonumber(v), "isweld")
        if isweld == 1 then
            for key, value in pairs(machinecfg) do
                table.insert(weld, value)
            end
        else
            for key, value in pairs(machinecfg) do
                table.insert(tab, value)
            end
        end
    end

    local newequip = string.split(hangar_dc.req.getvalue(uid, "new" .. hangarstr))
    local equip = string.split(hangar_dc.req.getvalue(uid, hangarstr))

    local ret = {}
    local eq = {}
    local be, en = 0, 0

    for i = beginindex, math.min(endindex, #newequip) do
        newequip[i] = tonumber(newequip[i])
        if hangarstr == "body" then
            eq = equipment_dc.req.get(warehousedefine.warehousetype.body, newequip[i])
        elseif hangarstr == "firecontroller" then
            eq = equipment_dc.req.get(warehousedefine.warehousetype.firecontroller, newequip[i])
        elseif hangarstr == "chassis" then
            eq = equipment_dc.req.get(warehousedefine.warehousetype.chassis, newequip[i])
        elseif hangarstr == "weapons" then
            eq = equipment_dc.req.get(warehousedefine.warehousetype.weapon, newequip[i])
        end
        --焊死>装备
        local state
        local islock = eq.islock == 1
        if table.find(weld, tostring(newequip[i])) then
            state = warehousedefine.statetype.welding
        elseif table.find(tab, tostring(newequip[i])) then
            state = warehousedefine.statetype.equiping
        elseif eq.islock ~= nil and eq.islock == true then
            state = warehousedefine.statetype.locking
        else
            state = 0
        end
        table.insert(ret, {id = newequip[i], cfgid = eq.cfgid, number = 1, lv = eq.lv, state = state, isnew = true, islock = islock, exp = eq.exp})
        be = be + 1
    end

    en = be ~= 0 and endindex - beginindex + 1 - be or endindex - #newequip
    be = be ~= 0 and 1 or beginindex - #newequip

    for i = be, math.min(en, #equip) do
        equip[i] = tonumber(equip[i])
        if hangarstr == "body" then
            eq = equipment_dc.req.get(warehousedefine.warehousetype.body, equip[i])
        elseif hangarstr == "firecontroller" then
            eq = equipment_dc.req.get(warehousedefine.warehousetype.firecontroller, equip[i])
        elseif hangarstr == "chassis" then
            eq = equipment_dc.req.get(warehousedefine.warehousetype.chassis, equip[i])
        elseif hangarstr == "weapons" then
            eq = equipment_dc.req.get(warehousedefine.warehousetype.weapon, equip[i])
        end
        --焊死>装备
        local state
        local islock = eq.islock == 1
        if table.find(weld, tostring(equip[i])) then
            state = warehousedefine.statetype.welding
        elseif table.find(tab, tostring(equip[i])) then
            state = warehousedefine.statetype.equiping
        elseif eq.islock ~= nil and eq.islock == true then
            state = warehousedefine.statetype.locking
        else
            state = 0
        end
        table.insert(ret, {id = equip[i], cfgid = eq.cfgid, number = 1, lv = eq.lv, state = state, isnew = false, islock = islock, exp = eq.exp})
    end

    return ret
end

---获取芯片信息
local function get_chip_info(uid, beginindex, endindex)
    local ret = {}
    local be, en, l, r = 0, 0, 0, 0
    local chip = chip_dc.req.get(uid)
    if not next(chip) then
        return
    end
    local chipinfo = json.decode(chip.chipinfoarr)
    local newchipinfo = json.decode(chip.newchipinfo)
    local inchipinfo = json.decode(chip.inchipinfoarr)

    for i = beginindex, math.min(#newchipinfo, endindex) do
        table.insert(ret, {id = 0, cfgid = newchipinfo[i].id, number = newchipinfo[i].number, lv = newchipinfo[i].level, state = 0, isnew = true, islock = newchipinfo[i].islock == 1 and true or false})
        be = be + 1
    end
    en = be ~= 0 and endindex - beginindex + 1 - be or endindex - #newchipinfo
    be = be ~= 0 and 1 or beginindex - #newchipinfo

    for i = be, math.min(#inchipinfo, en) do
        table.insert(ret, {id = 0, cfgid = inchipinfo[i].id, number = 1 , lv = inchipinfo[i].level, state = warehousedefine.statetype.equiping, isnew = false, islock = inchipinfo[i].islock == 1 and true or false,
        record = inchipinfo[i].record})
        l = l + 1
    end
    r = l ~= 0 and en - be + 1 - l or en - #inchipinfo
    l = l ~= 0 and 1 or be - #inchipinfo
    
    for i = l, math.min(#chipinfo, r) do
        table.insert(ret, {id = 0, cfgid = chipinfo[i].id, number = chipinfo[i].number, lv = chipinfo[i].level, state = 0, isnew = false, islock = chipinfo[i].islock == 1 and true or false})
    end
    
    return ret
end

---获取蓝图信息
local function get_blueprint_info(uid, beginindex, endindex)
    local ret, blueprintingbug = {}, {}
    local be, en, l, r, u, d = 0, 0, 0, 0, 0, 0
    local blueprintarr = blueprint_dc.req.get(uid)
    if not next(blueprintarr) then
        return ret 
    end
    local newblueprint = json.decode(blueprint_dc.req.getvalue(uid, "newblueprint"))
    local blueprint = json.decode(blueprint_dc.req.getvalue(uid, "blueprintinfo"))
    local blueprinting = json.decode(blueprint_dc.req.getvalue(uid, "blueprinting"))
    local blueprintend = json.decode(blueprint_dc.req.getvalue(uid, "blueprintend"))


    for i = beginindex, math.min(#newblueprint, endindex) do
        table.insert(ret, {id = newblueprint[i].id, number = newblueprint[i].number, state = 0, name = newblueprint[i].name, isnew = true})
        be = be + 1
    end
    en = be ~= 0 and endindex - beginindex + 1 - be or endindex - #newblueprint
    be = be ~= 0 and 1 or beginindex - #newblueprint

    for i = be, math.min(#blueprintend, en) do
        table.insert(ret, {id = blueprintend[i].id, number = blueprintend[i].number, state = warehousedefine.statetype.ending, bqid = blueprintend[i].awardid, name = blueprintend[i].name, isnew = false})
        l = l + 1
    end
    r = l ~= 0 and en - be + 1 - l or en - #blueprintend
    l = l ~= 0 and 1 or be - #blueprintend

    for i = l, math.min(#blueprinting, r) do
        table.insert(ret, {id = blueprinting[i].id, number = blueprinting[i].number, state = warehousedefine.statetype.casting, bqid = blueprinting[i].bqid, 
            countdown = math.max(0, blueprinting[i].endtime - timext.current_time()), totaltime = math.max(0, blueprinting[i].endtime - blueprinting[i].begintime),
            name = blueprinting[i].name, isnew = false})
        u = u + 1
    end
    d = u ~= 0 and r - l + 1 - u or r - #blueprinting
    u = u ~= 0 and 1 or l - #blueprinting

    for i = u, math.min(#blueprint, d) do
        table.insert(ret, {id = blueprint[i].id, number = blueprint[i].number, state = 0, name = blueprint[i].name, isnew = false})
    end
    return ret
end

---获取蓝图信息不包含铸造中蓝图
local function get_blueprint_noing_info(uid, beginindex, endindex)
    local ret = {}
    local be, en, l, r = 0, 0, 0, 0
    local blueprintarr = blueprint_dc.req.get(uid)
    if not next(blueprintarr) then
        return ret 
    end
    local newblueprint = json.decode(blueprint_dc.req.getvalue(uid, "newblueprint"))
    local blueprint = json.decode(blueprint_dc.req.getvalue(uid, "blueprintinfo"))
    local blueprintend = json.decode(blueprint_dc.req.getvalue(uid, "blueprintend"))


    for i = beginindex, math.min(#newblueprint, endindex) do
        table.insert(ret, {id = newblueprint[i].id, number = newblueprint[i].number, state = 0, name = newblueprint[i].name, isnew = true})
        be = be + 1
    end
    en = be ~= 0 and endindex - beginindex + 1 - be or endindex - #newblueprint
    be = be ~= 0 and 1 or beginindex - #newblueprint

    for i = be, math.min(#blueprintend, en) do
        table.insert(ret, {id = blueprintend[i].id, number = blueprintend[i].number, state = warehousedefine.statetype.ending, bqid = blueprintend[i].awardid, name = blueprintend[i].name, isnew = false})
        l = l + 1
    end
    r = l ~= 0 and en - be + 1 - l or en - #blueprintend
    l = l ~= 0 and 1 or be - #blueprintend

    for i = l, math.min(#blueprint, r) do
        table.insert(ret, {id = blueprint[i].id, number = blueprint[i].number, state = 0, name = blueprint[i].name, isnew = false})
    end
    return ret
end

---获取机甲信息
local function get_mecha_info(uid, beginindex, endindex)
    local ret = {}
    local be, en = 0, 0
    local newmachineidarr = string.split(machineinfo_dc.req.getvalue(uid, "newmachinecfgid"))
    local machineidarr = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))

    for i = beginindex, math.min(endindex, #newmachineidarr) do
        local machineinfo = machinecfg_dc.req.get(tonumber(newmachineidarr[i]))
        --扫描优先级高于焊死
        if machineinfo.begintime ~= 0 and machineinfo.endtime ~= 0 then
            table.insert(ret, {id = tonumber(machineinfo.id), cfgid = 0, number = 1 , lv = 0, state = warehousedefine.statetype.scaning, isnew = true})
        else
            table.insert(ret, {id = tonumber(machineinfo.id), cfgid = 0, number = 1 , lv = 0, state = machineinfo.isweld == 1 and warehousedefine.statetype.locking or 0, isnew = true})
        end
        be = be + 1
    end
    en = be ~= 0 and endindex - beginindex + 1 - be or endindex - #newmachineidarr
    be = be ~= 0 and 1 or beginindex - #newmachineidarr

    for i = be, math.min(en, #machineidarr) do
        local machineinfo = machinecfg_dc.req.get(tonumber(machineidarr[i]))
        --扫描优先级高于焊死
        if machineinfo.begintime ~= 0 and machineinfo.endtime ~= 0 then
            table.insert(ret, {id = tonumber(machineinfo.id), cfgid = 0, number = 1 , lv = 0, state = warehousedefine.statetype.scaning, isnew = false})
        else
            table.insert(ret, {id = tonumber(machineinfo.id), cfgid = 0, number = 1 , lv = 0, state = machineinfo.isweld == 1 and warehousedefine.statetype.locking or 0, isnew = false})
        end
    end
    return ret
end

---获取材料信息
local function get_material_info(uid, beginindex, endindex)
    local ret = {}
    local be, en = 0, 0
    local data = string.split(materials_dc.req.getvalue(uid, "materials"))
    local newdata = string.split(materials_dc.req.getvalue(uid, "newmaterials"))

    for i = 2 * beginindex - 1, math.min(#newdata, endindex * 2), 2 do
        table.insert(ret, {id = 0, number = newdata[i + 1], lv = 0, state = 0, cfgid = newdata[i], isnew = true})
        be = be + 1
    end
    en = be ~= 0 and endindex - beginindex + 1 - be or endindex - #newdata
    be = be ~= 0 and 1 or beginindex - #newdata

    for i = 2 * be - 1, math.min(#data, en * 2), 2 do
        table.insert(ret, {id = 0, number = data[i + 1], lv = 0, state = 0, cfgid = data[i], isnew = false})
    end
    return ret
end

---获取道具信息
local function get_prop_info(uid, beginindex, endindex)
    local ret = {}
    local be, en = 0, 0
    local data = string.split(prop_dc.req.getvalue(uid, "props"))
    local newdata = string.split(prop_dc.req.getvalue(uid, "newprops"))

    for i = 2 * beginindex - 1, math.min(#newdata, endindex * 2), 2 do
        table.insert(ret, {id = 0, number = newdata[i + 1], lv = 0, state = 0, cfgid = newdata[i], isnew = true})
        be = be + 1
    end
    en = be ~= 0 and endindex - beginindex + 1 - be or endindex - #newdata
    be = be ~= 0 and 1 or beginindex - #newdata

    for i = 2 * be - 1, math.min(#data, en * 2), 2 do
        table.insert(ret, {id = 0, number = data[i + 1], lv = 0, state = 0, cfgid = data[i], isnew = false})
    end
    return ret
end

---更新装备信息
---@param hangarstr string hangar表中字段   
---@param machinecfgstr string manchinecfg表中字段
local function update_equip_info(hangarstr, machinecfgstr, uid, beginindex, endindex)
    local newequip = string.split(hangar_dc.req.getvalue(uid, "new" .. hangarstr))
    if not next(newequip) then
        return
    end
    local equip = string.split(hangar_dc.req.getvalue(uid, hangarstr))

    local ret = table.clone(newequip)

    for i = beginindex, math.min(endindex, #newequip) do
        table.insert(equip, newequip[i])
        for j = 1, #ret do
            if ret[j] == newequip[i] then
                table.remove(ret, j)
                break
            end
        end
    end
    hangar_dc.req.setvalue(uid, "new" .. hangarstr, table.concat(ret, ","))
    hangar_dc.req.setvalue(uid, hangarstr, table.concat(equip, ","))
    return ret
end

---查找物品
local function get_data(id, arry, level, islock)
    for k, _ in pairs(arry) do
        if tonumber(arry[k]["id"]) == id and (level and tonumber(arry[k]["level"]) == level or true) and (islock and tonumber(arry[k]["islock"]) == islock or true) then
            return k
        end
    end
    return nil
end

---增加
---@param level number 如果为蓝图传nil
local function add_data(id, arry, level, number, islock)
    local number = number or 1
    local key = get_data(id, arry, level, islock)
    if key == nil then
        if level == nil then
            table.insert(arry, {id = id, number = number, level = level})
        else
            table.insert(arry, {id = id, number = number, level = level, islock = islock})
        end
    else
        arry[key].number = (arry[key].number or 0) + number
    end
end

---更新芯片信息
local function update_chip_info(uid, beginindex, endindex)
    local ret = {}
    local chip = chip_dc.req.get(uid)
    if not next(chip) then
        return
    end
    local newchipinfo = json.decode(chip.newchipinfo)
    if not next(newchipinfo) then
        return
    end
    local chipinfo = json.decode(chip.chipinfoarr)

    local ret = table.clone(newchipinfo)

    for i = beginindex, math.min(endindex, #newchipinfo) do
        for j = 1, #ret do
            if ret[j].id == newchipinfo[i].id and ret[j].level == newchipinfo[i].level and ret[j].islock == newchipinfo[i].islock then
                add_data(ret[j].id, chipinfo, ret[j].level, ret[j].number, ret[j].islock)
                table.remove(ret, j)
                break
            end
        end
    end
    chip_dc.req.setvalue(uid, "chipinfoarr", json.encode(chipinfo))
    chip_dc.req.setvalue(uid, "newchipinfo", json.encode(ret))
end

---更新蓝图信息
local function update_blueprint_info(uid, beginindex, endindex)
    local ret = {}
    local blue = blueprint_dc.req.get(uid)
    if not next(blue) then
        return
    end
    local newblueprint = json.decode(blue.newblueprint)
    if not next(newblueprint) then
        return
    end
    local blueprintinfo = json.decode(blue.blueprintinfo)

    local ret = table.clone(newblueprint)

    for i = beginindex, math.min(endindex, #newblueprint) do
        for j = 1, #ret do
            if ret[j].id == newblueprint[i].id then
                add_data(ret[j].id, blueprintinfo, nil, ret[j].number)
                table.remove(ret, j)
                break
            end
        end
    end
    blueprint_dc.req.setvalue(uid, "blueprintinfo", json.encode(blueprintinfo))
    blueprint_dc.req.setvalue(uid, "newblueprint", json.encode(ret))
end

---更新材料信息
local function update_material_info(uid, beginindex, endindex)
    local ret = {}
    local material = materials_dc.req.get(uid)
    if not next(material) then
        return
    end
    local newmaterials = string.split(material.newmaterials)
    if not next(newmaterials) then
        return
    end
    local materials = string.split(material.materials)

    local ret = table.clone(newmaterials)

    for i = beginindex * 2 - 1, math.min(endindex * 2, #newmaterials), 2 do
        for j = 1, #ret, 2 do
            if ret[j] == newmaterials[i] then
                table.insert(materials, ret[j])
                table.insert(materials, ret[j + 1])
                table.remove(ret, j + 1)
                table.remove(ret, j)
                break
            end
        end
    end
    materials_dc.req.setvalue(uid, "materials", string.join(materials))
    materials_dc.req.setvalue(uid, "newmaterials", string.join(ret))
end

---更新道具信息
local function update_prop_info(uid, beginindex, endindex)
    local ret = {}
    local prop = prop_dc.req.get(uid)
    if not next(prop) then
        return
    end
    local newprops = string.split(prop.newprops)
    if not next(newprops) then
        return
    end
    local props = string.split(prop.props)

    local ret = table.clone(newprops)

    for i = beginindex * 2 - 1, math.min(endindex * 2, #newprops), 2 do
        for j = 1, #ret, 2 do
            if ret[j] == newprops[i] then
                table.insert(props, ret[j])
                table.insert(props, ret[j + 1])
                table.remove(ret, j + 1)
                table.remove(ret, j)
                break
            end
        end
    end
    prop_dc.req.setvalue(uid, "props", string.join(props))
    prop_dc.req.setvalue(uid, "newprops", string.join(ret))
end

---返回数据
local function find_index_define(uid, index, beginindex, endindex)
    local ret = {}
    if index == warehousedefine.warehousetype.body then
        ret = get_equip_info("body", "machinebody", uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.firecontroller then
        ret = get_equip_info("firecontroller", "firecontroller", uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.chassis then
        ret = get_equip_info("chassis", "machinechassis", uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.weapon then
        ret = get_equip_info("weapons", "weapons", uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.chip then
        ret = get_chip_info(uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.blueprint then
        ret = get_blueprint_info(uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.material then
        ret = get_material_info(uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.prop then
        ret = get_prop_info(uid, beginindex, endindex)
    -- elseif index == warehousedefine.warehousetype.mecha then
    --     ret = get_mecha_info(uid)
    end
    return ret
end

---返回数据
local function update_index_define(uid, index, beginindex, endindex)
    local ret = {}
    if index == warehousedefine.warehousetype.body then
        ret = update_equip_info("body", "machinebody", uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.firecontroller then
        ret = update_equip_info("firecontroller", "firecontroller", uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.chassis then
        ret = update_equip_info("chassis", "machinechassis", uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.weapon then
        ret = update_equip_info("weapons", "weapons", uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.chip then
        ret = update_chip_info(uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.blueprint then
        ret = update_blueprint_info(uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.material then
        ret = update_material_info(uid, beginindex, endindex)
    elseif index == warehousedefine.warehousetype.prop then
        ret = update_prop_info(uid, beginindex, endindex)
    end
    return ret
end

--列表请求
function response.clicklist(data)
    local ret = {}
    local uid = data.uid
    local index = data.msg.index
    local beginindex = data.msg.beginindex or 1
    local endindex = data.msg.endindex or 50

    ret.code = errCodeDef.eEC_success
    if index == nil or index <= 0 or index >= 9 or beginindex < 0 or endindex < 0 then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.propinfos = find_index_define(uid, index, beginindex, endindex)
    -- skynet.error(tostring(ret))
    return ret
end

function response.clickblueprint(data)
    local ret = {}
    local uid = data.uid
    local beginindex = data.msg.beginindex or 1
    local endindex = data.msg.endindex or 50

    ret.code = errCodeDef.eEC_success
    ret.propinfos = find_index_define(uid, warehousedefine.warehousetype.blueprint, beginindex, endindex)
    -- skynet.error(tostring(ret))
    return ret
end

---获取除铸造中蓝图
function response.getblueprint(data)
    local ret = {}
    local uid = data.uid
    local beginindex = data.msg.beginindex or 1
    local endindex = data.msg.endindex or 50

    ret.code = errCodeDef.eEC_success
    ret.propinfos = get_blueprint_noing_info(uid, beginindex, endindex)
    return ret
end

function response.updatenew(data)
    local ret = {}
    local uid = data.uid
    local index = data.msg.index
    local beginindex = data.msg.beginindex
    local endindex = data.msg.endindex

    if index == nil or index <= 0 or index >= 9 or not beginindex or not endindex then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = errCodeDef.eEC_success
    if beginindex > endindex then
        endindex = math.maxinteger // 2
    end
    update_index_define(uid, index, beginindex, endindex)
    -- skynet.error(tostring(ret))
    return ret
end

---检测是否已拥有同类型装备
---@param cfgid number 配置表id
---@param part number 部位编号
local function incollection(uid, cfgid, part, lv)
    lv = lv or 1
    local collection = collection_dc.req.get(uid)
    if not next(collection) then
        return
    end
    if part == warehousedefine.warehousetype.body then
        local data = string.split(collection.body)
        if not table.finds(data, "cfgid", cfgid) then
            table.insert(data, {cfgid = cfgid, maxlv = lv})
            collection_dc.req.setvalue(uid, "body", json.encode(data))
            achievement.req.updatechallenge(uid, achievementdefine.achievetype.body_g)
        end
    elseif part == warehousedefine.warehousetype.chassis then
        local data = string.split(collection.chassis)
        if not table.finds(data, "cfgid", cfgid) then
            table.insert(data, {cfgid = cfgid, maxlv = lv})
            collection_dc.req.setvalue(uid, "chassis", json.encode(data))
            achievement.req.updatechallenge(uid, achievementdefine.achievetype.chassis_g)
        end
    elseif part == warehousedefine.warehousetype.firecontroller then
        local data = string.split(collection.firecontroller)
        if not table.finds(data, "cfgid", cfgid) then
            table.insert(data, {cfgid = cfgid, maxlv = lv})
            collection_dc.req.setvalue(uid, "firecontroller", json.encode(data))
            achievement.req.updatechallenge(uid, achievementdefine.achievetype.fire_g)
        end
    elseif part == warehousedefine.warehousetype.weapon then
        local data = string.split(collection.weapon)
        if not table.finds(data, "cfgid", cfgid) then
            table.insert(data, {cfgid = cfgid, maxlv = lv})
            collection_dc.req.setvalue(uid, "weapon", json.encode(data))
            achievement.req.updatechallenge(uid, achievementdefine.achievetype.weapon_g)
        end
    end
end

---@param oldlv number 变化之前段位
---@param newlv number 变化之后段位
local function updatecollection(uid, oldlv, newlv, cfgid, part)
	local expinfos = sharedata.deepcopy("machine_exp")
	local partindexs = {}
	local partkey = ""
	if part == warehousedefine.warehousetype.chassis then
		partindexs = json.decode(collection_dc.req.getvalue(uid, "chassis"))
		partkey = "chassis"
	elseif part == warehousedefine.warehousetype.body then
		partindexs = json.decode(collection_dc.req.getvalue(uid, "body"))
		partkey = "body"
	elseif part == warehousedefine.warehousetype.firecontroller then
		partindexs = json.decode(collection_dc.req.getvalue(uid, "firecontroller"))
		partkey = "firecontroller"
	elseif part == warehousedefine.warehousetype.weapon then
		partindexs = json.decode(collection_dc.req.getvalue(uid, "weapon"))
		partkey = "weapon"
	end
	local exp = 0
	for i = 1, #partindexs do
		if partindexs[i].cfgid == cfgid and partindexs[i].maxlv < newlv then
			exp = expinfos[newlv].EXP_Total - (expinfos[math.max(partindexs[i].maxlv, oldlv)].EXP_Total or 0)
			exp = partkey == "weapons" and math.floor(exp/3) or exp
			--修改记录
			local user = snax.queryservice("user")
			if user.req.updateexp(uid, exp) then
				partindexs[i].maxlv = newlv
				collection_dc.req.setvalue(uid, partkey, json.encode(partindexs))
			end
			break
		end
	end
end

-- 根据装备等级返回对应的mod容量
local function get_mod_volume(lv)
	local expinfo = sharedata.deepcopy("machine_exp", lv)
	return expinfo.Mod_Volume
end

---添加装备经验
function response.addexp(uid, perinfo, exp, part)
	local expinfos = sharedata.deepcopy("machine_exp")

	local curlv = perinfo.lv
	local curexp = perinfo.exp + exp
	local curtotal_exp = expinfos[perinfo.lv].EXP_Total + curexp

    for i = curlv + 1, #expinfos do
        if not expinfos[i].EXP_Total then
            break
        elseif expinfos[i].EXP_Total > curtotal_exp then
			curlv = i - 1
			curexp = curtotal_exp - expinfos[i-1].EXP_Total
			break
		end
    end
    achievement = snax.uniqueservice("achievement")
	updatecollection(uid, perinfo.lv, curlv, perinfo.cfgid, part)
	---

    perinfo.exp = curexp
    if perinfo.lv ~= curlv then
        --【注意 装备最高等级30级】
        perinfo.lv = math.min(30, curlv)
        equipment_dc.req.setvalue(part, perinfo.uniqueid, "lv", perinfo.lv)
        equipment_dc.req.setvalue(part, perinfo.uniqueid, "volume", get_mod_volume(perinfo.lv))
        achievement.req.updatechallenge(uid, achievementdefine.achievetype.equiplv, nil, curlv, false)
    end
	-- 入库
	equipment_dc.req.setvalue(part, perinfo.uniqueid, "exp", perinfo.exp)
	return perinfo
end

---添加装备
---@param lock boolean true表示焊死默认false
---@return boolean false表示参数错误或不存在此cfgid
function response.addequip(uid, part, cfgid, lv, number, lock)
    local data = {}
    data.propinfo = {}
    lock = lock or false

    if not part or not number or not cfgid or not lv then
        return false
    end

    --检测装备是否存在
    local chipcfg, partname
    if part == warehousedefine.warehousetype.body then
        chipcfg = sharedata.deepcopy("machinebody", tonumber(cfgid))
        partname = "newbody"
    elseif part == warehousedefine.warehousetype.chassis then
        chipcfg = sharedata.deepcopy("machinechassis", tonumber(cfgid))
        partname = "newchassis"
    elseif part == warehousedefine.warehousetype.firecontroller then
        chipcfg = sharedata.deepcopy("firecontrol", tonumber(cfgid))
        partname = "newfirecontroller"
    elseif part == warehousedefine.warehousetype.weapon then
        chipcfg = sharedata.deepcopy("weapontable", tonumber(cfgid))
        partname = "newweapons"
    end
    if not chipcfg then
        return false
    end

    local hangardc = hangar_dc.req.get(uid)
    achievement = snax.uniqueservice("achievement")
    for i = 1, number do
        local nextid = tonumber(equipment_dc.req.get_nextid(part))
        local row = {id = nextid, cfgid = cfgid,  playerid = tonumber(uid), lv = tonumber(lv), exp = 0, slotarray = json.encode({{},{},{},{},{}}), 
                isdouble = 0, volume = get_mod_volume(lv), currentvolume = 0, count = 0}
        if part ~= warehousedefine.warehousetype.weapon then
            row.islock = lock and 1 or 0
        end
        equipment_dc.req.add(part, row)
        -- userset_dc.req.setvalue(uid,)
        table.insert(data.propinfo, {id = nextid, number = 1, lv = tonumber(lv), index = part, cfgid = cfgid})
        if part == warehousedefine.warehousetype.body then
            achievement.req.updatechallenge(uid, achievementdefine.achievetype.body_a)
        elseif part == warehousedefine.warehousetype.chassis then
            achievement.req.updatechallenge(uid, achievementdefine.achievetype.chassis_a)
        elseif part == warehousedefine.warehousetype.firecontroller then
            achievement.req.updatechallenge(uid, achievementdefine.achievetype.fire_a)
        elseif part == warehousedefine.warehousetype.weapon then
            achievement.req.updatechallenge(uid, achievementdefine.achievetype.weapon_a)
        end
        local hangardcfgarr = string.split(hangardc[partname])
        table.insert(hangardcfgarr, nextid)
        hangar_dc.req.setvalue(uid, partname, string.join(hangardcfgarr))
    end
    updatecollection(uid, 1, lv, cfgid, part)
    incollection(uid, cfgid, part, lv)
    skynet.error("new component.....", tostring(data))
    send_request(get_user_fd(uid), data, "warehouse_addmessage")
    return true
end

local function get_machinecfginfo(bodyid, chassisid, firecontrolid)
	local machineinitinfo = {}
	machineinitinfo.body = {}
	machineinitinfo.chassis = {}
	machineinitinfo.firecontroller = {}
	machineinitinfo.weapons = {}

	local equip = equipment_dc.req.get(warehousedefine.warehousetype.body, bodyid)
    table.insert(machineinitinfo.body, {uniqueid=equip.id, cfgid=equip.cfgid, lv=equip.lv, exp = equip.exp})
        
	equip = equipment_dc.req.get(warehousedefine.warehousetype.chassis, chassisid)
	table.insert(machineinitinfo.chassis, {uniqueid=equip.id, cfgid=equip.cfgid, lv=equip.lv, exp = equip.exp})

	equip = equipment_dc.req.get(warehousedefine.warehousetype.firecontroller, firecontrolid)
	table.insert(machineinitinfo.firecontroller, {uniqueid=equip.id, cfgid=equip.cfgid, lv=equip.lv, exp = equip.exp})

	return machineinitinfo
end

--获取名称
local function get_machine_name(body, chassis, firecontrol)
	return sharedata.deepcopy("machinebody", tonumber(body)).Display .. 
		sharedata.deepcopy("machinechassis", tonumber(chassis)).Display ..
		sharedata.deepcopy("firecontrol", tonumber(firecontrol)).Display
end

--- 增加机甲
--- @param bpid number 蓝图id格式例"110001210001310001"
function response.add_machine(uid, bpid)
    if not uid or not bpid or #tostring(bpid) ~= 18 then
        return false
    end
    bpid = tostring(bpid)
    local data = {}
    data.propinfo = {}
    achievement = snax.uniqueservice("achievement")
    local machinecfgid = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
    local hangardc = hangar_dc.req.get(uid)
    local body = string.split(hangardc.newbody)
    local chassis = string.split(hangardc.newchassis)
    local fire = string.split(hangardc.newfirecontroller)
    local maxbody = body[#body]        --获取目前最大的部件id,即是最新创建的【注意有可能存在错误】
    local maxchassis = chassis[#chassis]
    local maxfirecontrol = fire[#fire]

    ---设置武器数量
    local weaponids = "0,0"
    local bodycfgid = tonumber(string.sub(bpid, 8, 12))
    if bodycfgid == 10001 then
        weaponids = weaponids .. "," .. "0"
    end
    ---

    local nextid = machinecfg_dc.req.get_nextid()
    local row = {
        id = nextid,
        playerid = tonumber(uid),
        userindex = #machinecfgid + 1,
        machinebody = maxbody, 
        machinechassis = maxchassis,   
        firecontroller = maxfirecontrol,
        name = "蓝图铸造而来" .. get_machine_name(string.sub(bpid, 8, 12), string.sub(bpid, 2, 6), string.sub(bpid, 14, 18)),
        weapons = weaponids,
        machineid = 1000110001,
        isweld = 0,
        begintime = 0,
        endtime = 0
    }
    machinecfg_dc.req.add(row)
    table.insert(machinecfgid, nextid)
    machineinfo_dc.req.setvalue(uid, "machinecfgid", string.join(machinecfgid))
    local machine = get_machinecfginfo(maxbody, maxchassis, maxfirecontrol)
    machine.id = nextid
    machine.name = row.name
    data.propinfo = machine
    local row = { id = tonumber(nextid), life = 0, speed = 0, energy = 0,
				shield = 0, scopeskill = 0, intensityskill = 0, persistskill = 0, 
				atk = 0, scopeatk = 0, distance = 0, elevation = 0, overhang = 0,
				enefficiency = 0, efficiency = 0, climbingangle = 0
			}
    chipattribute_dc.req.add(row)
    send_request(get_user_fd(uid), data, "warehouse_addmachinecfg")
    achievement.req.updatechallenge(uid, achievementdefine.achievetype.machine)
    return true
end

---查询是否有，某个材料
---@param arr table 查询集合
---@return number 返回材料的下标
local function find_materials(cfgid, arr)
    for i = 1, #arr, 2 do
        if arr[i] == tostring(cfgid) then
            return i
        end
    end
    return nil
end

---添加材料
---@param cfgid number
---@param number number
---@return boolean false表示参数错误
function response.addmaterials(uid, cfgid, number)
    if not number or not cfgid or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end
    cfgid = tonumber(cfgid)

    --检测是否存在
    local chipcfg = sharedata.deepcopy("material_list", cfgid)
    if not chipcfg then
        return false
    end

    local material = materials_dc.req.get(uid)
    local materials = string.split(material.materials) 
    local newmaterials = string.split(material.newmaterials)
    local index = find_materials(cfgid, materials)
    if index then
        materials[index + 1] = math.ceil(materials[index + 1] + number)
        materials_dc.req.setvalue(uid, "materials", string.join(materials))
    else
        index = find_materials(cfgid, newmaterials)
        if index then
            newmaterials[index + 1] = math.ceil(newmaterials[index + 1] + number)
        else
            table.insert(newmaterials, cfgid)
            table.insert(newmaterials, number)
        end
        materials_dc.req.setvalue(uid, "newmaterials", string.join(newmaterials))
    end
    local a = {}
    a.propinfo = {}
    table.insert(a.propinfo, {id = 0, number = number, lv = 0, index = warehousedefine.warehousetype.material, cfgid = cfgid})
    send_request(get_user_fd(uid), a, "warehouse_addmessage")
    return true
end

---移除材料
---@param cfgid number
---@param number number
---@return boolean false表示参数错误或余量不足
function response.remmaterials(uid, cfgid, number)
    if not number or not cfgid or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end

    --检测是否存在
    local chipcfg = sharedata.deepcopy("material_list", cfgid)
    if not chipcfg then
        return false
    end

    local materialsinfo = string.split(materials_dc.req.getvalue(uid, "materials"))
    local newmaterialsinfo = string.split(materials_dc.req.getvalue(uid, "newmaterials"))
    local index = find_materials(cfgid, materialsinfo)
    local newindex = find_materials(cfgid, newmaterialsinfo)
    local changenumber = number
    if not index and not newindex then
        return false
    else
        if index then
            changenumber = math.max(0, number - tonumber(materialsinfo[index + 1]))
            materialsinfo[index + 1] = tonumber(materialsinfo[index + 1]) - number
        end
        if newindex then
            newmaterialsinfo[newindex + 1] = tonumber(newmaterialsinfo[newindex + 1]) - changenumber
            if 0 > newmaterialsinfo[newindex + 1] then
                return false
            end
            if tonumber(newmaterialsinfo[newindex + 1]) == 0 then
                table.remove(newmaterialsinfo, newindex + 1)
                table.remove(newmaterialsinfo, newindex)
            end
        else
            if 0 > materialsinfo[index + 1] then
                return false
            end
            if tonumber(materialsinfo[index + 1]) == 0 then
                table.remove(materialsinfo, index + 1)
                table.remove(materialsinfo, index)
            end
        end
    end
    materials_dc.req.setvalue(uid, "materials", string.join(materialsinfo))
    materials_dc.req.setvalue(uid, "newmaterials", string.join(newmaterialsinfo))
    local a = {}
    a.propinfo = {}
    table.insert(a.propinfo, {id = 0, number = number, lv = 0, index = warehousedefine.warehousetype.material, cfgid = cfgid})
    send_request(get_user_fd(uid), a, "warehouse_remmessage")
    return true
end

---添加道具
---@param cfgid number
---@param number number
---@return boolean false表示参数错误
function response.addprop(uid, cfgid, number)
    if not number or not cfgid or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end
    cfgid = tonumber(cfgid)

    --检测是否存在
    local chipcfg = sharedata.deepcopy("store", cfgid)
    if not chipcfg then
        return false
    end

    local prop = prop_dc.req.get(uid)
    local props = string.split(prop.props) 
    local newprops = string.split(prop.newprops)
    local index = find_materials(cfgid, props)
    if index then
        props[index + 1] = math.ceil(props[index + 1] + number)
        prop_dc.req.setvalue(uid, "props", string.join(props))
    else
        index = find_materials(cfgid, newprops)
        if index then
            newprops[index + 1] = math.ceil(newprops[index + 1] + number)
        else
            table.insert(newprops, cfgid)
            table.insert(newprops, number)
        end
        prop_dc.req.setvalue(uid, "newprops", string.join(newprops))
    end
    local a = {}
    a.propinfo = {}
    table.insert(a.propinfo, {id = 0, number = number, lv = 0, index = warehousedefine.warehousetype.prop, cfgid = cfgid})
    send_request(get_user_fd(uid), a, "warehouse_addmessage")
    return true
end

---移除道具
---@param cfgid number
---@param number number
---@return boolean false表示参数错误或余量不足
function response.remprop(uid, cfgid, number)
    if not number or not cfgid or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end

    --检测是否存在
    local chipcfg = sharedata.deepcopy("store", cfgid)
    if not chipcfg then
        return false
    end

    local materialsinfo = string.split(prop_dc.req.getvalue(uid, "props"))
    local newmaterialsinfo = string.split(prop_dc.req.getvalue(uid, "newprops"))
    local index = find_materials(cfgid, materialsinfo)
    local newindex = find_materials(cfgid, newmaterialsinfo)
    local changenumber = number
    if not index and not newindex then
        return false
    else
        if index then
            changenumber = math.max(0, number - tonumber(materialsinfo[index + 1]))
            materialsinfo[index + 1] = tonumber(materialsinfo[index + 1]) - number
        end
        if newindex then
            newmaterialsinfo[newindex + 1] = tonumber(newmaterialsinfo[newindex + 1]) - changenumber
            if 0 > newmaterialsinfo[newindex + 1] then
                return false
            end
            if tonumber(newmaterialsinfo[newindex + 1]) == 0 then
                table.remove(newmaterialsinfo, newindex + 1)
                table.remove(newmaterialsinfo, newindex)
            end
        else
            if 0 > materialsinfo[index + 1] then
                return false
            end
            if tonumber(materialsinfo[index + 1]) == 0 then
                table.remove(materialsinfo, index + 1)
                table.remove(materialsinfo, index)
            end
        end
    end
    prop_dc.req.setvalue(uid, "props", string.join(materialsinfo))
    prop_dc.req.setvalue(uid, "newprops", string.join(newmaterialsinfo))
    local a = {}
    a.propinfo = {}
    table.insert(a.propinfo, {id = 0, number = number, lv = 0, index = warehousedefine.warehousetype.prop, cfgid = cfgid})
    send_request(get_user_fd(uid), a, "warehouse_remmessage")
    return true
end

---添加金币
---@return boolean false表示参数错误
function response.addgold(uid, number)
    if not number or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end
    achievement = snax.uniqueservice("achievement")
    local goldnumber = gold_dc.req.getvalue(uid, "goldnumber") 
    if goldnumber then
        goldnumber = math.floor(goldnumber + number)
    else
        return false
    end
    gold_dc.req.setvalue(uid, "goldnumber", tonumber(goldnumber))
    send_request(get_user_fd(uid), {index = warehousedefine.synctype.gold, curnum= goldnumber}, "warehouse_sync")
    achievement.req.updatechallenge(uid, achievementdefine.achievetype.gold_a, nil, number)
    return true
end

---移除金币
---@return boolean false表示参数错误
function response.remgold(uid, number)
    if not number or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end

    achievement = snax.uniqueservice("achievement")
    local goldnumber = gold_dc.req.getvalue(uid, "goldnumber")
    if goldnumber then
        goldnumber = math.max(0, math.floor(goldnumber - number))
    else
        return false
    end
    gold_dc.req.setvalue(uid, "goldnumber", tonumber(goldnumber))
    send_request(get_user_fd(uid), {index = warehousedefine.synctype.gold, curnum = goldnumber}, "warehouse_sync")
    achievement.req.updatechallenge(uid, achievementdefine.achievetype.gold_c, nil, number)
    return true
end

---添加氪金
---@param number number 数量单位为0.1分即1000表示1元
---@return boolean false表示参数错误
function response.addkhorium(uid, number)
    if not number or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end

    local khorium = khorium_dc.req.getvalue(uid, "khorium") 
    if khorium then
        khorium = math.floor(khorium + number)
    else
        return false
    end
    khorium_dc.req.setvalue(uid, "khorium", tonumber(khorium))
    send_request(get_user_fd(uid), {index = warehousedefine.synctype.khorium, curnum = khorium}, "warehouse_sync")
    return true
end

---移除氪金
---@param number number 数量单位为0.1分即1000表示1元
---@return boolean false表示参数错误
function response.remkhorium(uid, number)
    if not number or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end

    local khorium = khorium_dc.req.getvalue(uid, "khorium")
    if khorium then
        khorium = math.max(0, math.floor(khorium - number))
    else
        return false
    end
    khorium_dc.req.setvalue(uid, "khorium", tonumber(khorium))
    send_request(get_user_fd(uid), {index = warehousedefine.synctype.khorium, curnum = khorium}, "warehouse_sync")
    return true
end

---金币是否充足
---@param number number
---@return boolean false表示参数错误
function response.matchgold(uid, number)
    if not number or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end
    
    local goldnumber = gold_dc.req.getvalue(uid, "goldnumber")
    if goldnumber and tonumber(goldnumber) >= number then
        return true
    else
        return false
    end
end

---氪金是否充足
---@param number number
---@return boolean false表示参数错误
function response.matchkhorium(uid, number)
    if not number or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end
    local number = khorium_dc.req.getvalue(uid, "khorium")
    if number and tonumber(number) >= number then
        return true
    else
        return false
    end
end

---材料是否充足
---@param cfgid number
---@param number number
---@return boolean false表示参数错误
function response.matchmaterial(uid, cfgid, number)
    if not uid or not number or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end
    local sumnumber = 0
    local materialinfo = materials_dc.req.get(uid)
    local materials = string.split(materialinfo.materials)
    local newmaterials = string.split(materialinfo.newmaterials)

    for i = 1, #materials, 2 do
        if tonumber(materials[i]) == cfgid then
            sumnumber = tonumber(materials[i + 1])
            break
        end
    end
    for i = 1, #newmaterials, 2 do
        if tonumber(newmaterials[i]) == cfgid then
            sumnumber = sumnumber + tonumber(newmaterials[i + 1])
            break
        end
    end
    return number <= sumnumber and true or false
end

---道具是否充足
---@param cfgid number
---@param number number
---@return boolean false表示参数错误
function response.matchprop(uid, cfgid, number)
    if not uid or not number or type(number) ~= "number" or number < 0 then
        return false
    end
    if number == 0 then
        return true
    end
    local sumnumber = 0
    local propinfo = prop_dc.req.get(uid)
    local props = string.split(propinfo.props)
    local newprops = string.split(propinfo.newprops)

    for i = 1, #props, 2 do
        if tonumber(props[i]) == cfgid then
            sumnumber = tonumber(props[i + 1])
            break
        end
    end
    for i = 1, #newprops, 2 do
        if tonumber(newprops[i]) == cfgid then
            sumnumber = sumnumber + tonumber(newprops[i + 1])
            break
        end
    end
    return number <= sumnumber and true or false
end

function init(...)
    user_dc = snax.queryservice("userdc")
    userset_dc = snax.queryservice("usersetdc")
    machinecfg_dc = snax.queryservice("machinecfgdc")
    machineinfo_dc = snax.queryservice("machineinfodc")
    chip_dc = snax.queryservice("chipinfodc")
    blueprint_dc = snax.queryservice("blueprintdc")
    equipment_dc = snax.queryservice("equipmentdc")
    hangar_dc = snax.queryservice("hangardc")
    materials_dc = snax.queryservice("materialsdc")
    gold_dc = snax.queryservice("golddc")
    chipattribute_dc = snax.queryservice("chipattributedc")
    khorium_dc = snax.queryservice("khoriumdc")
    bq_dc = snax.uniqueservice("businessqueuedc")
    awardinfo_dc = snax.uniqueservice("awardinfodc")
    queueinfo_dc = snax.queryservice("queueinfodc")
    collection_dc = snax.queryservice("collectiondc")
    prop_dc = snax.queryservice("propdc")
end

function exit(...)
end

function response.online(uid, fd)
end

function response.offline(uid)
end