local chiphandler = class("chiphandler")
local skynet = require "skynet"
local errCodeDef = require "errcodedef"
local sharedata = require "skynet.sharedata"
local json = require "cjson"
local timext = require "timext"

local equipment_dc
local hangar_dc
local chip_dc
local skill_dc
local machineinfo_dc
local machinecfg_dc
local chipattribute_dc
local materials_dc
local warehouse

local chipinfo_rarity = {}

local function chipinfo_init()
    local chipcfg = sharedata.deepcopy("mod")
    chipinfo_rarity[chipdefine.chiprarity.white] = {}
    chipinfo_rarity[chipdefine.chiprarity.green] = {}
    chipinfo_rarity[chipdefine.chiprarity.yellow] = {}
    for key, value in pairs(chipcfg) do
        if value.Mod_Rarity == chipdefine.chiprarity.white then
            table.insert(chipinfo_rarity[value.Mod_Rarity], key)
        elseif value.Mod_Rarity == chipdefine.chiprarity.green then
            table.insert(chipinfo_rarity[value.Mod_Rarity], key)
        elseif value.Mod_Rarity == chipdefine.chiprarity.yellow then
            table.insert(chipinfo_rarity[value.Mod_Rarity], key)
        end
    end
    LOG_INFO("chipinfo_rarity! : %s", tostring(chipinfo_rarity))
end

function chiphandler:ctor()
end

function chiphandler:initchiphandler(chip, equip, hang, skill, machine, machinecfg, chipattribute, mater, wareh)
    chip_dc, equipment_dc, hangar_dc, skill_dc, machineinfo_dc, machinecfg_dc, chipattribute_dc, materials_dc, warehouse =
        chip,
        equip,
        hang,
        skill,
        machine,
        machinecfg,
        chipattribute,
        mater,
        wareh
    --chipinfo_init()
end

---判断是否为技能芯片
---@return boolean true表示是技能芯片
local function is_skill(id)
    local chip = sharedata.deepcopy("mod", tonumber(id))
    return (chip.Mod_Type == chipdefine.chiptype.skill or chip.Mod_Type == chipdefine.chiptype.passkill)
end

---更新技能表
---@param ty boolean true表示添加
local function update_skill(machinecfg, id, part, ty)
    --武器所带技能不加入机体技能表中
    if part == warehousedefine.warehousetype.weapon then
        return
    end
    local skillinfo = skill_dc.req.get(machinecfg)
    local skill = string.split(skillinfo.skillarray)
    local passkill = string.split(skillinfo.passkillarray)
    local selectskill = string.split(skillinfo.selectskill)
    local chip = sharedata.deepcopy("mod", tonumber(id))
    local skillid = chip.Sikll_ID
    if ty then
        if chip.Mod_Type == chipdefine.chiptype.skill and not table.find(skill, tostring(part)) then
            table.insert(skill, part)
            table.insert(skill, skillid)
            skill_dc.req.setvalue(machinecfg, "skillarray", string.join(skill))
            if not next(selectskill) then
                skill_dc.req.setvalue(machinecfg, "selectskill", part .. "," .. skillid)
            end
        elseif chip.Mod_Type == chipdefine.chiptype.passkill then
            table.insert(passkill, part)
            table.insert(passkill, skillid)
            skill_dc.req.setvalue(machinecfg, "passkillarray", string.join(passkill))
        end
    else
        assert(skill)
        if chip.Mod_Type == chipdefine.chiptype.skill then
            for j = 1, #skill, 2 do
                if skill[j + 1] == tostring(skillid) and part == tonumber(skill[j]) then
                    table.remove(skill, j + 1)
                    table.remove(skill, j)
                    break
                end
            end
            skill_dc.req.setvalue(machinecfg, "skillarray", string.join(skill))
            if next(selectskill) and part == tonumber(selectskill[1]) and skillid == tonumber(selectskill[2]) then
                if next(skill) then
                    skill_dc.req.setvalue(machinecfg, "selectskill", skill[1] .. "," .. skill[2])
                else
                    skill_dc.req.setvalue(machinecfg, "selectskill", "")
                end
            end
        else
            for j = 1, #passkill, 2 do
                if passkill[j + 1] == tostring(skillid) then
                    table.remove(passkill, j + 1)
                    table.remove(passkill, j)
                end
            end
            skill_dc.req.setvalue(machinecfg, "passkillarray", string.join(passkill))
        end
    end
end

local function update_attr(player, id, num)
    if num >= 0 then
        num = math.ceil(num * 1000) * 0.001
    else
        num = math.floor(num * 1000) * 0.001
    end
    local res = buffdefine.bufftypekey[id]
    if res == nil then
        return
    end
    player[res] = player[res] + num
end

---根据芯片属性更新玩家属性
---@param id number 芯片id
---@param machinecfgid number 部件所在的机体id
---@param index number 槽位编号
---@param ty boolean true表示装备芯片
local function update_player_attr(uid, id, level, part, machinecfgid, index, ty)
    --武器增幅属性，不存储。/部件未装备不计算
    if part == warehousedefine.warehousetype.weapon or not machinecfgid or index == 5 then
        return
    end
    if is_skill(id) then
        update_skill(machinecfgid, id, part, ty)
        --此处返回，是因为技能芯片只可能有技能属性，对其他属性无影响
        return
    end
    local chipcfg = sharedata.deepcopy("mod", tonumber(id))
    local chipattribute = chipattribute_dc.req.get(machinecfgid)
    local buffidarr = chipcfg.Buff_ID
    for i = 1, #buffidarr, 3 do
        local buffid = tonumber(buffidarr[i])
        local num = tonumber(buffidarr[i + 1]) + tonumber(buffidarr[i + 2] * level)
        update_attr(chipattribute, buffid, ty and num or -num)
    end
    chipattribute_dc.req.update(chipattribute)
end

---装备芯片属性更新
---oldid为nil表示装备，uniqueid为nil表示卸下，都不为nil表示更换
---@param curcfgindex number 操作的机甲id
---@param oldid number 装备之前的部件id
---@param uniqueid number 装备的部件id
function chiphandler:changeequip(uid, part, curcfgindex, oldid, uniqueid)
    local olddata, newdata

    if not oldid then
        olddata = {}
    else
        olddata = json.decode(equipment_dc.req.getvalue(part, oldid, "slotarray"))
    end
    if not uniqueid then
        newdata = {}
    else
        newdata = json.decode(equipment_dc.req.getvalue(part, uniqueid, "slotarray"))
    end
    for i = 1, #olddata do
        if next(olddata[i]) and olddata[i].chipid then
            update_player_attr(uid, olddata[i].chipid, olddata[i].level, part, curcfgindex, i, false)
        end
    end
    for i = 1, #newdata do
        if next(newdata[i]) and newdata[i].chipid then
            update_player_attr(uid, newdata[i].chipid, newdata[i].level, part, curcfgindex, i, true)
        end
    end
end

---查询芯片返回第一个满足项下标
---@param isinarr boolean true表示在已装备列表中 如果为true依次传递参数：唯一武器id、部位类型
---@return number 索引下标nil表示无
local function get_chip(id, arry, level, islock, isinarr, ...)
    local res = 0
    local tab = {...}
    if isinarr then
        for i = 1, 2 do
            res = res * 10 + tab[i]
        end
    end
    for k, _ in pairs(arry) do
        if isinarr and arry[k]["record"] == res and islock == arry[k]["islock"] and id == arry[k]["id"] then
            return k
        elseif not isinarr and arry[k]["id"] == id and arry[k]["level"] == level and islock == arry[k]["islock"] then
            return k
        end
    end
    return nil
end

---已装备表中查找芯片返回第一个满足项下标
---@param arry table 已装备芯片集合
---@param record number 唯一装备id和部位合成项
local function get_chip_inchip(id, arry, record, islock)
    for k, _ in pairs(arry) do
        if arry[k]["id"] == id and arry[k]["record"] == record and islock == arry[k]["islock"] then
            return k
        end
    end
    return nil
end

---获取部件装备的位置
---@return number 返回机甲表id
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

local function find_part(str, part)
    for i = 1, #str, 2 do
        if tonumber(str[i]) == part then
            return true
        end
    end
    return false
end

---加入芯片
---@param isinarr boolean true表示加入已装备列表中 如果为true依次传递参数：  唯一武器id、部位类型
local function add_chip(id, arry, level, number, islock, isinarr, ...)
    local res = 0
    local number = number or 1
    local tab = {...}
    if isinarr then
        for i = 1, 2 do
            res = res * 10 + tab[i]
        end
    end
    local key = get_chip(id, arry, level, islock, isinarr, ...)
    if key == nil then
        if isinarr then
            table.insert(arry, {id = id, level = level, record = res, islock = islock})
        else
            table.insert(arry, {id = id, number = number, level = level, islock = islock})
        end
    else
        arry[key].number = (arry[key].number or 0) + number
    end
end

---移除芯片到另外集合
---@param arry table 芯片集合
---@param toarry table 目标集合
---@param isinarr boolean true表示目标集合是已装备列表 如果为true依次传递参数：  唯一武器id、部位类型
local function removeto_chip(key, arry, toarry, isinarr, ...)
    add_chip(arry[key].id, toarry, arry[key].level, 1, arry[key].islock, isinarr, ...)
    if arry[key].number ~= nil and arry[key].number >= 2 then
        arry[key].number = arry[key].number -1
    else
        table.remove(arry, key)
    end
end

---查询是否已装备技能芯片
---@param slotarr table 槽位集合
---@return number 表示已装备技能芯片id
local function is_part_skill(slotarr)
    for i = 1, #slotarr do
        if next(slotarr[i]) and is_skill(slotarr[i].chipid) then
            return slotarr[i].chipid
        end
    end
    return nil
end

---检测是否已装备同id芯片
---@param id number 芯片id
---@return boolean true表示已装备
local function chip_isrepeat(part, uniqueid, id)
    local equipdata = equipment_dc.req.get(part, uniqueid)
    local slotarr = json.decode(equipdata.slotarray)
    for i = 1, #slotarr do
        if next(slotarr[i]) and slotarr[i].chipid ~= nil and slotarr[i].chipid == id then
            return true
        end
    end
    return false
end

local function get_part_index(uid, part)
    local partindexs = {}
    if part == warehousedefine.warehousetype.chassis then
        partindexs = string.split(hangar_dc.req.getvalue(uid, "chassis"))
    elseif part == warehousedefine.warehousetype.body then
        partindexs = string.split(hangar_dc.req.getvalue(uid, "body"))
    elseif part == warehousedefine.warehousetype.firecontroller then
        partindexs = string.split(hangar_dc.req.getvalue(uid, "firecontroller"))
    elseif part == warehousedefine.warehousetype.weapon then
        partindexs = string.split(hangar_dc.req.getvalue(uid, "weapons"))
    end
    return partindexs
end

local function get_newpart_index(uid, part)
    local partindexs = {}
    if part == warehousedefine.warehousetype.chassis then
        partindexs = string.split(hangar_dc.req.getvalue(uid, "newchassis"))
    elseif part == warehousedefine.warehousetype.body then
        partindexs = string.split(hangar_dc.req.getvalue(uid, "newbody"))
    elseif part == warehousedefine.warehousetype.firecontroller then
        partindexs = string.split(hangar_dc.req.getvalue(uid, "newfirecontroller"))
    elseif part == warehousedefine.warehousetype.weapon then
        partindexs = string.split(hangar_dc.req.getvalue(uid, "newweapons"))
    end
    return partindexs
end

---检测武器是否是该用户
local function is_match(uid, part, uniqueid)
    if part == nil or part < 1 or part > 4 then
        return false
    end
    --uniqueid是否是自己拥有的
    local partindexs = get_part_index(uid, part)
    local newpartindexs = get_newpart_index(uid, part)
    if table.find(partindexs, tostring(uniqueid)) or table.find(newpartindexs, tostring(uniqueid)) then
        return true
    end
    return false
end

---移除表中数据
local function remove_number(arr, key, number)
    if arr and arr[key] ~= nil then
        if not arr[key].number then
            table.remove(arr, key)
        elseif arr[key].number and arr[key].number > number then
            arr[key].number = arr[key].number -number
        elseif arr[key].number and arr[key].number == number then
            table.remove(arr, key)
        else
            return false
        end
    end
end

---根据装备等级返回对应的mod容量
local function get_mod_volume(lv)
	local expinfo = sharedata.deepcopy("machine_exp", lv)
	return expinfo.Mod_Volume
end

---装备芯片
function chiphandler:add(data)
    local ret = {}
    local uid = data.uid
    local id = data.msg.id
    local uniqueidpart = data.msg.uniqueidpart
    local index = data.msg.index
    local level = data.msg.level
    local state = data.msg.state     --true表示未装备
    local record = data.msg.record
    local isnew = data.msg.isnew
    local islock = data.msg.islock

    islock = 0
    
    local part = uniqueidpart % 10
    local uniqueid = math.floor(uniqueidpart / 10)
    --判断武器是否为此用户 以及参数校验
    if
    isnew == nil or part == nil or uniqueid == nil or id == nil or index == nil or index < 1 or index > 4 or level == nil or
    state == nil or
    not is_match(uid, part, uniqueid)
    then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    if not state and record == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = errCodeDef.eEC_success
    
    --芯片信息集合
    local chipdc = chip_dc.req.get(uid)
    local newchipinfo = json.decode(chipdc.newchipinfo)
    local chiparray = json.decode(chipdc.chipinfoarr)
    local inchiparray = json.decode(chipdc.inchipinfoarr)
    local chipcfg = sharedata.deepcopy("mod", id)
    --查找芯片
    local key
    if isnew then
        key = get_chip(id, newchipinfo, level, islock, false)
    elseif state then
        key = get_chip(id, chiparray, level, islock, false)
    else
        key = get_chip_inchip(id, inchiparray, record, islock)
    end
    --skynet.error("芯片下标索引：", key, " 装备", state and " 未装备芯片" or "已装备芯片")
    if key == nil then
        ret.code = errCodeDef.eEC_chip_nofind
        return ret
    end
    if
        (index == 5 and chipcfg.Mod_Type ~= chipdefine.chiptype.additional) or
            (index ~= 5 and chipcfg.Mod_Type == chipdefine.chiptype.additional)
     then
        ret.code = errCodeDef.eEC_chip_type
        return ret
    end

    --获取当前部件所在的机id
    local machinecfgid = find_equip_index(uid, part, uniqueid)
    --获取槽位
    local equipdata = equipment_dc.req.get(part, uniqueid)

    ---检测装备条件,是否可装备
    local loadpisiton = chipcfg.Load_Pisiton
    if not find_part(loadpisiton, part) then
        ret.code = errCodeDef.eEC_chip_type
        return ret
    end
    local num = 0
    for i = 1, #loadpisiton, 2 do
        num = num + tonumber(loadpisiton[i + 1])
        if tonumber(loadpisiton[i]) == part then
            if tonumber(loadpisiton[i + 1]) == 0 then
                break
            end
            for j = num, num + loadpisiton[i + 1] -1 do
                if chipcfg.Load_Limit[j] == equipdata.cfgid then
                    break
                end
            end
            ret.code = errCodeDef.eEC_chip_type
            return ret
        end
    end
    -------------

    local slotarr = json.decode(equipdata.slotarray)
    local slot = slotarr[index]
    num = 1
    --已经极化槽位
    if slot.ispola ~= nil and slot.ispola and slot.typepola ~= 10000 then
        --非对应芯片加倍，对应芯片减半（容量）
        num = slot.typepola == chipcfg.Pole_Type and 0.5 or 1.5
    end

    --当前槽位已经装备,则先卸载
    if slot.chipid ~= nil and slot.level ~= nil then
        local chipcfginfo = sharedata.deepcopy("mod", tonumber(slot.chipid))
        local curnum = 1
        local curkey = get_chip_inchip(slot.chipid, inchiparray, uniqueidpart, slot.islock)
        --已经极化槽位
        if slot.ispola ~= nil and slot.ispola and slot.typepola ~= 10000 then
            --非对应芯片加倍，对应芯片减半（容量）
            curnum = slot.typepola == chipcfginfo.Pole_Type and 0.5 or 1.5
        end
        removeto_chip(curkey, inchiparray, chiparray, false)
        update_player_attr(uid, slot.chipid, slot.level, part, machinecfgid, index, false)
        if index == 5 then
            if curnum == 0.5 then
                equipdata.volume = equipdata.volume -math.floor(chipcfginfo.Mod_Capacity * slot.level + 0.5) * 2
            elseif curnum == 1.5 then
                equipdata.volume = equipdata.volume -math.floor(chipcfginfo.Mod_Capacity * slot.level + 0.5) * 0.5
            else
                equipdata.volume = equipdata.volume -math.floor(chipcfginfo.Mod_Capacity * slot.level + 0.5)
            end
        else
            equipdata.currentvolume =
                equipdata.currentvolume -math.floor(chipcfginfo.Mod_Capacity * slot.level + 0.5) * curnum
        end
        slot.chipid = nil
        slot.level = nil
        slot.islock = nil
    end

    if state then
        --减少数量并移动芯片到已装备集合
        --容量是否足够
        if index ~= 5 and (equipdata.volume -equipdata.currentvolume) < math.floor(chipcfg.Mod_Capacity * level + 0.5) * num
        then
            ret.code = errCodeDef.eEc_slot_volume
            return ret
        end
        --判断是否已装备技能芯片
        if index ~= 5 and is_part_skill(slotarr) and is_skill(id) then
            ret.code = errCodeDef.eEC_chip_skill
            return ret
        end
        if index ~= 5 and chip_isrepeat(part, uniqueid, id) then
            ret.code = errCodeDef.eEC_chip_repeat
            return ret
        end
        if isnew then
            removeto_chip(key, newchipinfo, inchiparray, true, uniqueid, part)
        else
            removeto_chip(key, chiparray, inchiparray, true, uniqueid, part)
        end
        update_player_attr(uid, id, level, part, machinecfgid, index, true)
    else
        --已经装备 则更改原槽位为空,并且更新芯片装备位置
        local par = record % 10
        local uni = math.floor(record / 10)

        local machine_cfgid = find_equip_index(uid, par, uni)
        local equip_data = equipment_dc.req.get(par, uni)
        local slotarray = json.decode(equip_data.slotarray)
        --保证部位相同时对同一数据操作
        if par == part and uniqueid == uni then
            equip_data = equipdata
            slotarray = slotarr
        end
        --源槽位修改
        for i = 1, #slotarray do
            if next(slotarray[i]) and slotarray[i].chipid ~= nil and slotarray[i].chipid == id then
                local n = 1
                if slotarray[i].ispola ~= nil and slotarray[i].ispola then
                    --非对应芯片加倍，对应芯片所需容量减半
                    n = slotarray[i].typepola == chipcfg.Pole_Type and 0.5 or 1.5
                end
                --判断是否已装备技能芯片
                local ind = is_part_skill(slotarr)
                if ind and is_skill(id) and ind ~= id then
                    ret.code = errCodeDef.eEC_chip_skill
                    return ret
                end
                --容量是否足够
                if par == part and uniqueid == uni then
                    --表示在同一装备上面将一个已装备芯片装备到别的槽位
                    if
                        (equip_data.volume -equip_data.currentvolume) <
                            math.floor(chipcfg.Mod_Capacity * level + 0.5) * (num -n)
                     then
                        --num -n表示先将芯片卸载之后判断容量
                        ret.code = errCodeDef.eEc_slot_volume
                        return ret
                    end
                else
                    --此处判断是： 同一芯片装备之后允许更换装备的槽位位置
                    if index ~= 5 and chip_isrepeat(part, uniqueid, id) then
                        ret.code = errCodeDef.eEC_chip_repeat
                        return ret
                    end
                    if
                        index ~= 5 and
                            (equipdata.volume -equipdata.currentvolume) <
                                math.floor(chipcfg.Mod_Capacity * level + 0.5) * num
                     then
                        ret.code = errCodeDef.eEc_slot_volume
                        return ret
                    end
                end
                --源槽位修该
                if index == 5 then
                    if n == 0.5 then
                        equip_data.volume = equip_data.volume -math.floor(chipcfg.Mod_Capacity * level + 0.5) * 2
                    elseif n == 1.5 then
                        equip_data.volume = equip_data.volume -math.floor(chipcfg.Mod_Capacity * level + 0.5) * 0.5
                    else
                        equip_data.volume = equip_data.volume -math.floor(chipcfg.Mod_Capacity * level + 0.5)
                    end
                else
                    equip_data.currentvolume =
                        equip_data.currentvolume -math.floor(chipcfg.Mod_Capacity * level + 0.5) * n
                end
                slotarray[i].chipid = nil
                slotarray[i].level = nil
                slotarray[i].islock = nil
                break
            end
        end
        --更新芯片装备位置
        key = get_chip_inchip(id, inchiparray, record, islock)
        if key then
            removeto_chip(key, inchiparray, chiparray, false)
        end
        key = get_chip(id, chiparray, level, islock, false)
        if key then
            removeto_chip(key, chiparray, inchiparray, true, uniqueid, part)
        end
        --更新芯片属性加成
        update_player_attr(uid, id, level, par, machine_cfgid, index, false)
        update_player_attr(uid, id, level, part, machinecfgid, index, true)
        equipment_dc.req.setvalue(par, uni, "slotarray", json.encode(slotarray))
        equipment_dc.req.setvalue(par, uni, "volume", math.floor(equip_data.volume))
        equipment_dc.req.setvalue(par, uni, "currentvolume", math.floor(equip_data.currentvolume))
    end
    slot.chipid = id
    slot.level = level
    slot.islock = islock
    if index == 5 then
        if num == 0.5 then
            equipdata.volume = equipdata.volume + math.floor(chipcfg.Mod_Capacity * level + 0.5) * 2
        elseif num == 1.5 then
            equipdata.volume = equipdata.volume + math.floor(chipcfg.Mod_Capacity * level + 0.5) * 0.5
        else
            equipdata.volume = equipdata.volume + math.floor(chipcfg.Mod_Capacity * level + 0.5)
        end
    else
        equipdata.currentvolume = equipdata.currentvolume + math.floor(chipcfg.Mod_Capacity * level + 0.5) * num
    end

    chip_dc.req.update({id = uid, newchipinfo = json.encode(newchipinfo), chipinfoarr = json.encode(chiparray), inchipinfoarr = json.encode(inchiparray)})
    equipment_dc.req.setvalue(part, uniqueid, "slotarray", json.encode(slotarr))
    equipment_dc.req.setvalue(part, uniqueid, "currentvolume", math.floor(equipdata.currentvolume))
    equipment_dc.req.setvalue(part, uniqueid, "volume", math.floor(equipdata.volume))
    --skynet.error("^^^^^^^^^^^^^^^^^^",tostring(ret))
    return ret
end

---卸下芯片
function chiphandler:remove(data)
    local ret = {}
    local uid = data.uid
    local uniqueidpart = data.msg.uniqueidpart
    local id = data.msg.id
    local islock = data.msg.islock

    islock = 0

    local part = uniqueidpart % 10
    local uniqueid = math.floor(uniqueidpart / 10)

    if uniqueidpart == nil or id == nil or uniqueid <= 0 then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    --判断武器是否为此用户
    if not is_match(uid, part, uniqueid) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    --芯片信息集合
    local chipdc = chip_dc.req.get(uid)
    local chiparray = json.decode(chipdc.chipinfoarr)
    local inchiparray = json.decode(chipdc.inchipinfoarr)
    local chipcfg = sharedata.deepcopy("mod", tonumber(id))
    --查找芯片
    local key = get_chip_inchip(id, inchiparray, uniqueidpart, islock)

    --skynet.error("芯片下标索引：", key, " 卸下")
    if key == nil then
        ret.code = errCodeDef.eEC_chip_nofind
        return ret
    end
    ret.code = errCodeDef.eEC_success
    --获取机体id
    local machinecfgid = find_equip_index(uid, part, uniqueid)
    --获取槽位
    local equipdata = equipment_dc.req.get(part, uniqueid)
    if not next(equipdata) then
        ret.code = errCodeDef.eEC_cfgid_nofind
        return ret
    end
    local slotarr = json.decode(equipdata.slotarray)
    for i = 1, #slotarr do
        if next(slotarr[i]) and slotarr[i].chipid ~= nil and slotarr[i].chipid == id then
            local num = 1
            --已经极化槽位
            if slotarr[i].ispola ~= nil and slotarr[i].ispola and slotarr[i].typepola ~= 10000 then
                --非对应芯片加倍，对应芯片减半（容量）
                num = slotarr[i].typepola == chipcfg.Pole_Type and 0.5 or 1.5
            end
            removeto_chip(key, inchiparray, chiparray, false)
            update_player_attr(uid, id, slotarr[i].level, part, machinecfgid, i, false)
            if i == 5 then
                if num == 0.5 then
                    equipdata.volume = equipdata.volume -math.floor(chipcfg.Mod_Capacity * slotarr[i].level + 0.5) * 2
                elseif num == 1.5 then
                    equipdata.volume =
                        equipdata.volume -math.floor(chipcfg.Mod_Capacity * slotarr[i].level + 0.5) * 0.5
                else
                    equipdata.volume = equipdata.volume -math.floor(chipcfg.Mod_Capacity * slotarr[i].level + 0.5)
                end
                equipment_dc.req.setvalue(part, uniqueid, "volume", tonumber(equipdata.volume))
            else
                equipdata.currentvolume = equipdata.currentvolume -math.floor(chipcfg.Mod_Capacity * slotarr[i].level + 0.5) * num
                equipment_dc.req.setvalue(part, uniqueid, "currentvolume", tonumber(equipdata.currentvolume))
            end
            slotarr[i].chipid = nil
            slotarr[i].level = nil
            slotarr[i].islock = nil

            chip_dc.req.update(
                {id = uid, newchipinfo = chipdc.newchipinfo, chipinfoarr = json.encode(chiparray), inchipinfoarr = json.encode(inchiparray)}
            )
            equipment_dc.req.setvalue(part, uniqueid, "slotarray", json.encode(slotarr))
            --skynet.error("^^^^^^^^^^^^^^^^^^",tostring(ret))
            return ret
        end
    end
    return ret
end

---使用反应堆
function chiphandler:double(data)
    local ret = {}
    local uid = data.uid
    local part = data.msg.part
    local uniqueid = data.msg.uniqueid

    ret.code = errCodeDef.eEC_success
    if part == nil or part < 1 or part > 4 or not uniqueid then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    --材料余量判断【注意 反应堆消耗道具id临时写死】
	if not warehouse.req.matchprop(uid, 10002, 1) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    --判断武器是否为此用户
    if not is_match(uid, part, uniqueid) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local equipdata = equipment_dc.req.get(part, uniqueid)
    if not next(equipdata) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    if equipdata.isdouble ~= 0 then
        ret.code = errCodeDef.eEc_slot_isdouble
        return ret
    end

    local slotarr = json.decode(equipdata.slotarray)
    local slot5 = slotarr[5]
    --计算容量增加槽位的芯片增加容量值
    local addnum = 0
    if slot5.chipid then
        local chipcfg = sharedata.deepcopy("mod", slot5.chipid)
        if slot5.ispola ~= nil and slot5.ispola and slot5.typepola ~= 10000 then
            --非对应芯片加倍，对应芯片减半（容量）
            addnum = math.floor(chipcfg.Mod_Capacity * (slot5.typepola == chipcfg.Pole_Type and 1.5 or 0.5))
        else
            addnum = chipcfg.Mod_Capacity
        end
    end
    equipdata.isdouble = 1
    equipdata.volume = (equipdata.volume -addnum) * 2 + addnum
    --材料消耗 【注意 反应堆消耗道具id临时写死】
	warehouse.req.remprop(uid, 10002, 1)
    equipment_dc.req.setvalue(part, uniqueid, "isdouble", equipdata.isdouble)
    equipment_dc.req.setvalue(part, uniqueid, "volume", tonumber(equipdata.volume))
    return ret
end

---槽位极化
function chiphandler:slotpola(data)
    local ret = {}
    local uid = data.uid
    local part = data.msg.part
    local uniqueid = data.msg.uniqueid
    local typepola = data.msg.typepola
    local index = data.msg.index

    if index == nil or index < 1 or index > 4 then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    
    --判断武器是否为此用户
    if not is_match(uid, part, uniqueid) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    --材料余量判断【注意 极化消耗道具id临时写死】
    if not warehouse.req.matchprop(uid, 10001, 1) then
        ret.code = errCodeDef.eEC_res_notEnough
        return ret
    end
	
    --槽位信息
    local equipdata = equipment_dc.req.get(part, uniqueid)
    --if equipdata.lv ~= 30 then
    --    ret.code = errCodeDef.eEC_lv_nofull
    --    return ret
    --end
    local slotarr = json.decode(equipdata.slotarray)
    local slot = slotarr[index]
    
    if equipdata.count <= 99 then
        local chipdc = chip_dc.req.get(uid)
        local chiparray = json.decode(chipdc.chipinfoarr)
        local inchiparray = json.decode(chipdc.inchipinfoarr)
        local record  = uniqueid * 10 + part
        local slot5 = slotarr[5]
        --计算容量增加槽位的芯片增加容量值
        local addnum = 0
        if slot5.chipid then
            local chipcfg = sharedata.deepcopy("mod", slot5.chipid)
            if slot5.ispola ~= nil and slot5.ispola ~= 10000 then
                --非对应芯片加倍，对应芯片减半（容量）
                addnum = math.floor(chipcfg.Mod_Capacity * (slot5.typepola == chipcfg.Pole_Type and 1.5 or 0.5))
            else
                addnum = chipcfg.Mod_Capacity
            end
        end
        --芯片卸下
        for i = 1, 4 do
            if slotarr[i] and slotarr[i].chipid then
                local id = slotarr[i].chipid
                local chipcfg = sharedata.deepcopy("mod", id)
                local key = get_chip_inchip(id, inchiparray, record, slotarr[i].islock)
                local machinecfgid = find_equip_index(uid, part, uniqueid)
                removeto_chip(key, inchiparray, chiparray, false)
                --芯片属性更新
                update_player_attr(uid, id, slotarr[i].level, part, machinecfgid, i, false)
                
                slotarr[i].chipid = nil
                slotarr[i].level = nil
            end
        end
        chip_dc.req.update(
            {id = uid, newchipinfo = chipdc.newchipinfo, chipinfoarr = json.encode(chiparray), inchipinfoarr = json.encode(inchiparray)}
        )
        equipdata.volume = get_mod_volume(1) + addnum
        equipment_dc.req.setvalue(part, uniqueid, "lv", 1)
        equipment_dc.req.setvalue(part, uniqueid, "exp", 0)
        equipment_dc.req.setvalue(part, uniqueid, "volume", equipdata.volume)
        equipment_dc.req.setvalue(part, uniqueid, "currentvolume", 0)
    end
    --材料消耗【注意 极化消耗道具id临时写死】
    warehouse.req.remprop(uid, 10001, 1)
    --极化次数可进行限制
    equipdata.count = equipdata.count + 1
    slot.ispola = true
    slot.typepola = typepola
    equipment_dc.req.setvalue(part, uniqueid, "slotarray", json.encode(slotarr))
    equipment_dc.req.setvalue(part, uniqueid, "count", equipdata.count)
    ret.code = errCodeDef.eEC_success
    return ret
end

---芯片升级
function chiphandler:upgrade(data)
    local ret = {}
    local uid = data.uid
    local id = data.msg.id
    local level = data.msg.level
    local isequip = data.msg.isequip
    local record = data.msg.record
    local isnew = data.msg.isnew
    local number = data.msg.number or 1
    local islock = data.msg.islock

    islock = 0

    ret.code = errCodeDef.eEC_success
    if id == nil or level == nil or isequip == nil or isnew == nil or (isequip and record == nil) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    
    if level >= 15 then
        ret.code = errCodeDef.eEC_chip_fulllv
        return ret
    end
    local chipcfg = sharedata.deepcopy("mod", tonumber(id))
    local modeup = sharedata.deepcopy("mod_levelup", chipcfg.Mod_Level_Up)
    local neednum = 0
    for i = level + 1, level + number do
        neednum = neednum + modeup["LV_" .. i]
    end
    --【注意 升级消耗材料id临时写死】
    if not warehouse.req.matchmaterial(uid, 10001, neednum) then
        ret.code = errCodeDef.eEC_res_notEnough
        return ret
    end

    --芯片是否存在
    local chipdc = chip_dc.req.get(uid)
    local newchiparray = json.decode(chipdc.newchipinfo)
    local chiparray = json.decode(chipdc.chipinfoarr)
    local inchiparray = json.decode(chipdc.inchipinfoarr)
    local key
    if isnew then
        key = get_chip(id, newchiparray, level, islock, false)
    elseif not isequip then
        key = get_chip(id, chiparray, level, islock, false)
    else
        key = get_chip_inchip(id, inchiparray, record, islock)
    end
    if key == nil then
        ret.code = errCodeDef.eEC_chip_nofind
        return ret
    end

    if isequip then
        local par = record % 10
        local uni = math.floor(record / 10)
        --如果已装备，检测装备是否是该用户所有
        if not is_match(uid, par, uni) then
            ret.code = errCodeDef.eEC_err_param
            return ret
        end
        --机甲id
        local machinecfgid = find_equip_index(uid, par, uni)
        local equipdata = equipment_dc.req.get(par, uni)
        local slotarr = json.decode(equipdata.slotarray)
        local slot = {}
        local numslot = 0
        for i = 1, #slotarr do
            if next(slotarr[i]) and slotarr[i].chipid ~= nil and slotarr[i].chipid == id then
                slot = slotarr[i]
                numslot = i
                break
            end
        end
        if not next(slot) then
            ret.code = errCodeDef.eEC_err_param
            return ret
        end
        local num = 1
        --已经极化槽位
        if slot.ispola ~= nil and slot.ispola and slot.typepola ~= 10000 then
            --非对应芯片加倍，对应芯片减半（容量）
            num = slot.typepola == chipcfg.Pole_Type and 0.5 or 1.5
        end
        --检测容量是否超出
        if
            numslot ~= 5 and
                equipdata.currentvolume + math.floor(chipcfg.Mod_Capacity * number + 0.5) * num > equipdata.volume
         then
            ret.code = errCodeDef.eEC_slot_upchipandremove
            --卸下芯片
            slot.chipid = nil
            slot.level = nil
            slot.islock = nil
            inchiparray[key].level = math.min(15, level + number)
            equipdata.currentvolume = equipdata.currentvolume -math.floor(chipcfg.Mod_Capacity * level + 0.5) * num
            removeto_chip(key, inchiparray, chiparray, false)
            --芯片属性更新
            update_player_attr(uid, id, level, par, machinecfgid, numslot, false)

            equipment_dc.req.setvalue(par, uni, "currentvolume", equipdata.currentvolume)
            equipment_dc.req.setvalue(par, uni, "slotarray", json.encode(slotarr))
            chip_dc.req.update(
                {id = uid, newchipinfo = json.encode(newchiparray), chipinfoarr = json.encode(chiparray), inchipinfoarr = json.encode(inchiparray)}
            )
            return ret
        end
        slot.level = math.min(15, slot.level + number)
        inchiparray[key].level = math.min(15, level + number)
        if numslot == 5 then
            if num == 0.5 then
                equipdata.volume = equipdata.volume + math.floor(chipcfg.Mod_Capacity * number + 0.5) * 2
            elseif num == 1.5 then
                equipdata.volume = equipdata.volume + math.floor(chipcfg.Mod_Capacity * number + 0.5) * 0.5
            else
                equipdata.volume = equipdata.volume + math.floor(chipcfg.Mod_Capacity * number + 0.5)
            end
        else
            equipdata.currentvolume = equipdata.currentvolume + math.floor(chipcfg.Mod_Capacity * number + 0.5) * num
        end
        --芯片属性更新  只需传递增值等级 之前的已经计算过
        update_player_attr(uid, id, number, par, machinecfgid, numslot, true)

        equipment_dc.req.setvalue(par, uni, "volume", math.floor(equipdata.volume))
        equipment_dc.req.setvalue(par, uni, "currentvolume", math.floor(equipdata.currentvolume))
        equipment_dc.req.setvalue(par, uni, "slotarray", json.encode(slotarr))
        chip_dc.req.setvalue(uid, "inchipinfoarr", json.encode(inchiparray))
    elseif isnew then
        remove_number(newchiparray, key, 1)
        add_chip(id, chiparray, math.min(15, level + number), 1, islock, false)
        chip_dc.req.setvalue(uid, "chipinfoarr", json.encode(chiparray))
        chip_dc.req.setvalue(uid, "newchipinfo", json.encode(newchiparray))
    else
        remove_number(chiparray, key, 1)
        add_chip(id, chiparray, math.min(15, level + number), 1, islock, false)
        chip_dc.req.setvalue(uid, "chipinfoarr", json.encode(chiparray))
    end
    --【注意 升级消耗材料id临时写死】
    warehouse.req.remmaterials(uid, 10001, neednum)
    return ret
end

---合成、分解、出售参数校验
---@param data table 客户端传递的参数
local function param_match(uid, data, newchipinfo, chiparray, inchiparray, num)
    if type(data.msg.chipinfo) ~= "table" then
        return errCodeDef.eEC_err_param
    end
    local numberm = 0
    for i = 1, #data.msg.chipinfo do
        numberm = numberm + data.msg.chipinfo[i].number
        local chipdara = data.msg.chipinfo[i]
        if chipdara.id == nil or chipdara.level == nil or chipdara.isequip == nil or (chipdara.isequip and chipdara.record == nil) then
            return errCodeDef.eEC_err_param
        end
        if chipdara.islock then
            return errCodeDef.eEC_err_islock
        end
        --芯片是否存在
        local key
        if chipdara.isnew then
            key = get_chip(chipdara.id, newchipinfo, chipdara.level, chipdara.islock and 1 or 0, false)
        elseif not chipdara.isequip then
            key = get_chip(chipdara.id, chiparray, chipdara.level, chipdara.islock and 1 or 0, false)
        else
            key = get_chip_inchip(chipdara.id, inchiparray, chipdara.record, chipdara.islock and 1 or 0)
        end
        if key == nil then
            return errCodeDef.eEC_chip_nofind
        end
        if chipdara.isequip then
            local par = chipdara.record % 10
            local uni = math.floor(chipdara.record / 10)
            --如果已装备，检测装备是否是该用户所有
            if not is_match(uid, par, uni) then
                return errCodeDef.eEC_err_param
            end
            --机甲id
            local equipdata = equipment_dc.req.get(par, uni)
            local slotarr = json.decode(equipdata.slotarray)
            local slot = {}
            for i = 1, #slotarr do
                if next(slotarr[i]) and slotarr[i].chipid ~= nil and slotarr[i].chipid == chipdara.id then
                    slot = slotarr[i]
                    break
                end
            end
            if not next(slot) then
                return errCodeDef.eEC_err_param
            end
        end
    end
    if num ~= nil and numberm ~= num or false then
        return errCodeDef.eEC_err_param
    end
    return errCodeDef.eEC_success
end

---芯片出售
function chiphandler:sellchip(data)
    local ret = {}
    local uid = data.uid
    ret.number = 0

    local newchiparray = json.decode(chip_dc.req.getvalue(uid, "newchipinfo"))
    local chiparray = json.decode(chip_dc.req.getvalue(uid, "chipinfoarr"))
    local inchiparray = json.decode(chip_dc.req.getvalue(uid, "inchipinfoarr"))

    ret.code = param_match(uid, data, newchiparray, chiparray, inchiparray)
    if ret.code ~= errCodeDef.eEC_success then
        return ret
    end

    for i = 1, #data.msg.chipinfo do
        local id = data.msg.chipinfo[i].id
        local level = data.msg.chipinfo[i].level
        local isequip = data.msg.chipinfo[i].isequip
        local record = data.msg.chipinfo[i].record
        local isnew = data.msg.chipinfo[i].isnew
        local number = data.msg.chipinfo[i].number or 1
        
        local chipcfg = sharedata.deepcopy("mod", tonumber(id))
        local modeup = sharedata.deepcopy("mod_sale", chipcfg.Material_Sale)
        local neednum = modeup["LV_" .. level]
        local key
        if isnew then
            key = get_chip(id, newchiparray, level, 0, false)
        elseif not isequip then
            key = get_chip(id, chiparray, level, 0, false)
        else
            key = get_chip_inchip(id, inchiparray, record, 0)
        end
        
        if isequip then
            local par = record % 10
            local uni = math.floor(record / 10)

            --机甲id
            local machinecfgid = find_equip_index(uid, par, uni)
            local equipdata = equipment_dc.req.get(par, uni)
            local slotarr = json.decode(equipdata.slotarray)
            local slot = {}
            local numslot = 0
            for i = 1, #slotarr do
                if next(slotarr[i]) and slotarr[i].chipid ~= nil and slotarr[i].chipid == id then
                    slot = slotarr[i]
                    numslot = i
                    break
                end
            end
            local num = 1
            --已经极化槽位
            if slot.ispola ~= nil and slot.ispola and slot.typepola ~= 10000 then
                --非对应芯片加倍，对应芯片减半（容量）
                num = slot.typepola == chipcfg.Pole_Type and 0.5 or 1.5
            end
            --卸下芯片
            slot.chipid = nil
            slot.level = nil
            slot.islock = nil
            if numslot == 5 then
                if num == 0.5 then
                    equipdata.volume = equipdata.volume -math.floor(chipcfg.Mod_Capacity * level + 0.5) * 2
                elseif num == 1.5 then
                    equipdata.volume = equipdata.volume -math.floor(chipcfg.Mod_Capacity * level + 0.5) * 0.5
                else
                    equipdata.volume = equipdata.volume -math.floor(chipcfg.Mod_Capacity * level + 0.5)
                end
            else
                equipdata.currentvolume = equipdata.currentvolume -math.floor(chipcfg.Mod_Capacity * level + 0.5) * num
            end
            remove_number(inchiparray, key, number)
            --芯片属性更新
            update_player_attr(uid, id, level, par, machinecfgid, numslot, false)

            --[[
                ret.number = ret.number + chipcfg.
                获取金币
            --]]
            equipment_dc.req.setvalue(par, uni, "volume", math.floor(equipdata.volume))
            equipment_dc.req.setvalue(par, uni, "currentvolume", math.floor(equipdata.currentvolume))
            equipment_dc.req.setvalue(par, uni, "slotarray", json.encode(slotarr))
        elseif isnew then
            remove_number(newchiparray, key, number)
        else
            remove_number(chiparray, key, number)
        end
        ret.number = ret.number + neednum * number
    end
    warehouse.req.addgold(uid, ret.number)
    chip_dc.req.update({id = uid, newchipinfo = json.encode(newchiparray), chipinfoarr = json.encode(chiparray), inchipinfoarr = json.encode(inchiparray)})
    return ret
end

---芯片分解
function chiphandler:decompose(data)
    local ret = {}
    local uid = data.uid
    ret.number = 0

    local newchiparray = json.decode(chip_dc.req.getvalue(uid, "newchipinfo"))
    local chiparray = json.decode(chip_dc.req.getvalue(uid, "chipinfoarr"))
    local inchiparray = json.decode(chip_dc.req.getvalue(uid, "inchipinfoarr"))

    ret.code = param_match(uid, data, newchiparray, chiparray, inchiparray)
    if ret.code ~= errCodeDef.eEC_success then
        return ret
    end

    for i = 1, #data.msg.chipinfo do
        local id = data.msg.chipinfo[i].id
        local level = data.msg.chipinfo[i].level
        local isequip = data.msg.chipinfo[i].isequip
        local record = data.msg.chipinfo[i].record
        local isnew = data.msg.chipinfo[i].isnew
        local number = data.msg.chipinfo[i].number or 1
        
        local chipcfg = sharedata.deepcopy("mod", tonumber(id))
        local modeup = sharedata.deepcopy("mod_resolve", chipcfg.Material_Sale)
        local neednum = modeup["LV_" .. level] * (is_skill(id) and 0 or 1)
        local key
        if isnew then
            key = get_chip(id, newchiparray, level, 0, false)
        elseif not isequip then
            key = get_chip(id, chiparray, level, 0, false)
        else
            key = get_chip_inchip(id, inchiparray, record, 0)
        end
        
        if isequip then
            local par = record % 10
            local uni = math.floor(record / 10)

            --机甲id
            local machinecfgid = find_equip_index(uid, par, uni)
            local equipdata = equipment_dc.req.get(par, uni)
            local slotarr = json.decode(equipdata.slotarray)
            local slot = {}
            local numslot = 0
            for i = 1, #slotarr do
                if next(slotarr[i]) and slotarr[i].chipid ~= nil and slotarr[i].chipid == id then
                    slot = slotarr[i]
                    numslot = i
                    break
                end
            end
            local num = 1
            --已经极化槽位
            if slot.ispola ~= nil and slot.ispola and slot.typepola ~= 10000 then
                --非对应芯片加倍，对应芯片减半（容量）
                num = slot.typepola == chipcfg.Pole_Type and 0.5 or 1.5
            end
            --卸下芯片
            slot.chipid = nil
            slot.level = nil
            slot.islock = nil
            if numslot == 5 then
                if num == 0.5 then
                    equipdata.volume = equipdata.volume - math.floor(chipcfg.Mod_Capacity * level + 0.5) * 2
                elseif num == 1.5 then
                    equipdata.volume = equipdata.volume - math.floor(chipcfg.Mod_Capacity * level + 0.5) * 0.5
                else
                    equipdata.volume = equipdata.volume - math.floor(chipcfg.Mod_Capacity * level + 0.5)
                end
            else
                equipdata.currentvolume = equipdata.currentvolume - math.floor(chipcfg.Mod_Capacity * level + 0.5) * num
            end
            remove_number(inchiparray, key, number)
            --芯片属性更新
            update_player_attr(uid, id, level, par, machinecfgid, numslot, false)

            --[[
                ret.number = ret.number + chipcfg.
                获取内融核心--技能芯片没有
            --]]
            equipment_dc.req.setvalue(par, uni, "volume", math.floor(equipdata.volume))
            equipment_dc.req.setvalue(par, uni, "currentvolume", math.floor(equipdata.currentvolume))
            equipment_dc.req.setvalue(par, uni, "slotarray", json.encode(slotarr))
        elseif isnew then
            remove_number(newchiparray, key, number)
        else
            remove_number(chiparray, key, number)
            --[[
                ret.number = ret.number + chipcfg.
                获取内融核心
            --]]
        end
        ret.number = ret.number + neednum * number
    end
    warehouse.req.addmaterials(uid, 10001, ret.number)
    chip_dc.req.update({id = uid, newchipinfo = json.encode(newchiparray), chipinfoarr = json.encode(chiparray), inchipinfoarr = json.encode(inchiparray)})
    return ret
end

---芯片合成
function chiphandler:composition(data)
    local ret = {}
    local uid = data.uid

    local newchiparray = json.decode(chip_dc.req.getvalue(uid, "newchipinfo"))
    local chiparray = json.decode(chip_dc.req.getvalue(uid, "chipinfoarr"))
    local inchiparray = json.decode(chip_dc.req.getvalue(uid, "inchipinfoarr"))

    ret.code = param_match(uid, data, newchiparray, chiparray, inchiparray, 3)
    if ret.code ~= errCodeDef.eEC_success then
        return ret
    end

    for i = 1, #data.msg.chipinfo do
        local id = data.msg.chipinfo[i].id
        local level = data.msg.chipinfo[i].level
        local isequip = data.msg.chipinfo[i].isequip
        local record = data.msg.chipinfo[i].record
        local isnew = data.msg.chipinfo[i].isnew
        local number = data.msg.chipinfo[i].number or 1
        
        local chipcfg = sharedata.deepcopy("mod", tonumber(id))
        local key
        if isnew then
            key = get_chip(id, newchiparray, level, 0, false)
        elseif not isequip then
            key = get_chip(id, chiparray, level, 0, false)
        else
            key = get_chip_inchip(id, inchiparray, record, 0)
        end
        
        if isequip then
            local par = record % 10
            local uni = math.floor(record / 10)

            --机甲id
            local machinecfgid = find_equip_index(uid, par, uni)
            local equipdata = equipment_dc.req.get(par, uni)
            local slotarr = json.decode(equipdata.slotarray)
            local slot = {}
            local numslot = 0
            for i = 1, #slotarr do
                if next(slotarr[i]) and slotarr[i].chipid ~= nil and slotarr[i].chipid == id then
                    slot = slotarr[i]
                    numslot = i
                    break
                end
            end
            local num = 1
            --已经极化槽位
            if slot.ispola ~= nil and slot.ispola and slot.typepola ~= 10000 then
                --非对应芯片加倍，对应芯片减半（容量）
                num = slot.typepola == chipcfg.Pole_Type and 0.5 or 1.5
            end
            --卸下芯片
            slot.chipid = nil
            slot.level = nil
            slot.islock = nil
            if numslot == 5 then
                if num == 0.5 then
                    equipdata.volume = equipdata.volume -math.floor(chipcfg.Mod_Capacity * level + 0.5) * 2
                elseif num == 1.5 then
                    equipdata.volume = equipdata.volume -math.floor(chipcfg.Mod_Capacity * level + 0.5) * 0.5
                else
                    equipdata.volume = equipdata.volume -math.floor(chipcfg.Mod_Capacity * level + 0.5)
                end
            else
                equipdata.currentvolume = equipdata.currentvolume -math.floor(chipcfg.Mod_Capacity * level + 0.5) * num
            end
            remove_number(inchiparray, key, number)
            --芯片属性更新
            update_player_attr(uid, id, level, par, machinecfgid, numslot, false)

            equipment_dc.req.setvalue(par, uni, "volume", math.floor(equipdata.volume))
            equipment_dc.req.setvalue(par, uni, "currentvolume", math.floor(equipdata.currentvolume))
            equipment_dc.req.setvalue(par, uni, "slotarray", json.encode(slotarr))
        elseif isnew then
            remove_number(newchiparray, key, number)
        else
            remove_number(chiparray, key, number)
        end
    end
    --【注意】顺序和下面不能调换必须先保存后增加
    chip_dc.req.update({id = uid, newchipinfo = json.encode(newchiparray), chipinfoarr = json.encode(chiparray), inchipinfoarr = json.encode(inchiparray)})
    ---[[芯片随机合成
    local chipinfokey = table.keys(sharedata.deepcopy("mod"))
    local i = math.random(1, #chipinfokey)
    chiphandler:addchip(uid, chipinfokey[i], 1, 1)
    ret.chipid = chipinfokey[i]
    --]]
    return ret
end

---增加芯片
---@param id number 芯片id
function chiphandler:addchip(uid, id, level, number, islock)
    if uid == nil or id == nil or level == nil or number == nil then
        return false
    end
    if islock == nil then
        islock = 0
    end
    --检测芯片是否存在
    local chipcfg = sharedata.deepcopy("mod", id)
    if not chipcfg then
        return false
    end
    local chipinfo = chip_dc.req.get(uid)
    local newchipinfo = json.decode(chipinfo.newchipinfo)
    local chipinfoarr = json.decode(chipinfo.chipinfoarr)
    local key = get_chip(id, chipinfoarr, level, islock, false)
    if key then
       chipinfoarr[key].number = chipinfoarr[key].number + 1 
       chip_dc.req.setvalue(uid, "chipinfoarr", json.encode(chipinfoarr))
    else
       add_chip(id, newchipinfo, level, number, islock, false)
       chip_dc.req.setvalue(uid, "newchipinfo", json.encode(newchipinfo))
    end
    local a = {}
    a.propinfo = {}
    table.insert(
        a.propinfo,
        {id = 0, number = number, lv = level, index = warehousedefine.warehousetype.chip, cfgid = id}
    )
    send_request(get_user_fd(uid), a, "warehouse_addmessage")
    return true
end

---只允许移除（出售/分解）未装备芯片
function chiphandler:removechip(uid, id, level, number, islock)
    if uid == nil or id == nil or level == nil or number == nil then
        return false
    end
    if islock == nil then
        islock = 0
    end
    --检测芯片是否存在
    local chipinfoarr = json.decode(chip_dc.req.getvalue(uid, "chipinfoarr"))
    local chipcfg = sharedata.deepcopy("mod", tonumber(id))
    local key = get_chip(id, chipinfoarr, level, islock, false)
    if key == nil or chipinfoarr[key].number < number then
        return false
    end
    --[[
        加入移除获得资源
    --]]
    remove_number(chipinfoarr, key, number)
    chip_dc.req.setvalue(uid, "chipinfoarr", json.encode(chipinfoarr))
    local a = {}
    a.propinfo = {}
    table.insert(
        a.propinfo,
        {id = 0, number = number, lv = level, index = warehousedefine.warehousetype.chip, cfgid = id}
    )
    send_request(get_user_fd(uid), a, "warehouse_remmessage")
    return true
end

---获取部件的所有信息
function chiphandler:equipinfo(data)
    local ret = {}
    local uid = data.uid
    local uniqueidpart = data.msg.uniqueidpart

    if uniqueidpart == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local part = uniqueidpart % 10
    local uniqueid = math.floor(uniqueidpart / 10)
    if part == nil or uniqueid == nil or part <= 0 or uniqueid <= 0 then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    --判断武器是否为此用户
    if not is_match(uid, part, uniqueid) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    --获取当前部件所在的机id
    local machinecfgid = find_equip_index(uid, part, uniqueid)
    local isweld = false
    if machinecfgid then
        local machine_isweld = machinecfg_dc.req.getvalue(machinecfgid, "isweld")
        isweld = machine_isweld == 1 and true or false
    end
    local equipdata = equipment_dc.req.get(part, uniqueid)
    ret.equipinfo = {
        lv = equipdata.lv,
        isdouble = equipdata.isdouble ~= 0,
        currentvolume = equipdata.currentvolume,
        volume = equipdata.volume,
        count = equipdata.count,
        cfgid = equipdata.cfgid,
        isweld = isweld
    }
    --skynet.error(tostring(ret))
    ret.code = errCodeDef.eEC_success
    return ret
end

---获取部件槽位信息
function chiphandler:getslotinfo(data)
    local ret = {}
    local uid = data.uid
    local uniqueidpart = data.msg.uniqueidpart

    if not uniqueidpart then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    
    local part = uniqueidpart % 10
    local uniqueid = math.floor(uniqueidpart / 10)
    if part == nil or uniqueid == nil or part <= 0 or uniqueid <= 0 then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local equipinfo = equipment_dc.req.get(part, uniqueid)
    if not next(equipinfo) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local slotarray = json.decode(equipinfo.slotarray)
    ret.inchipinfo = {}
    for i = 1, #slotarray do
        table.insert(ret.inchipinfo, {id = slotarray[i].chipid, level = slotarray[i].level, index = i, typepola = slotarray[i].typepola, ispola = slotarray[i].ispola})
    end
    ret.code = errCodeDef.eEC_success
    return ret
end

---获取部件可装备的所以芯片
function chiphandler:getequipchip(data)
    local ret = {}
    local uid = data.uid
    local uniqueidpart = data.msg.uniqueidpart
    
    if uniqueidpart == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local part = uniqueidpart % 10
    local uniqueid = math.floor(uniqueidpart / 10)
    if part == nil or uniqueid == nil or part <= 0 or uniqueid <= 0 then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    --判断武器是否为此用户
    if not is_match(uid, part, uniqueid) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.chiparray = {}
    ret.inchipinfo = {}
    local equipinfo = equipment_dc.req.get(part, uniqueid)
    if not next(equipinfo) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local slotarray = json.decode(equipinfo.slotarray)
    local newchip = json.decode(chip_dc.req.getvalue(uid, "newchipinfo"))
    local chiparray = json.decode(chip_dc.req.getvalue(uid, "chipinfoarr"))
    local inchiparray = json.decode(chip_dc.req.getvalue(uid, "inchipinfoarr"))
    local chipcfg
    for i = 1, #newchip do
        chipcfg = sharedata.deepcopy("mod", tonumber(newchip[i].id))
        local loadpisiton = chipcfg.Load_Pisiton
        local num = 0
        for j = 1, #loadpisiton, 2 do
            num = num + tonumber(loadpisiton[j + 1])
            if tonumber(loadpisiton[j]) == part then
                if tonumber(loadpisiton[j + 1]) == 0 then
                    newchip[i].isnew = true
                    table.insert(ret.chiparray, newchip[i])
                else
                    for k = num, num + loadpisiton[j + 1] -1 do
                        if chipcfg.Load_Limit[k] == equipinfo.cfgid then
                            newchip[i].isnew = true
                            table.insert(ret.chiparray, newchip[i])
                        end
                    end
                end
            end
        end
    end
    for i = 1, #chiparray do
        chipcfg = sharedata.deepcopy("mod", tonumber(chiparray[i].id))
        local loadpisiton = chipcfg.Load_Pisiton
        local num = 0
        for j = 1, #loadpisiton, 2 do
            num = num + tonumber(loadpisiton[j + 1])
            if tonumber(loadpisiton[j]) == part then
                if tonumber(loadpisiton[j + 1]) == 0 then
                    chiparray[i].isnew = false
                    table.insert(ret.chiparray, chiparray[i])
                else
                    for k = num, num + loadpisiton[j + 1] -1 do
                        if chipcfg.Load_Limit[k] == equipinfo.cfgid then
                            chiparray[i].isnew = false
                            table.insert(ret.chiparray, chiparray[i])
                        end
                    end
                end
            end
        end
    end
    for i = 1, #slotarray do
        if next(slotarray[i]) and slotarray[i].chipid then
            table.insert(ret.inchipinfo, {id = slotarray[i].chipid, level = slotarray[i].level, record = uniqueidpart})
        end
    end
    ret.code = errCodeDef.eEC_success
    return ret
end

---锁定芯片
function chiphandler:setlockchip(data)
    local ret = {}
    local uid = data.uid
    local cfgid = data.msg.cfgid
    local record = data.msg.record
    local isnew = data.msg.isnew
    local islock = data.msg.islock

    if not cfgid or not islock or isnew == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    islock = islock and 1 or 0
    local chipinfo = chip_dc.req.get(uid)
    if record then
        local part = record % 10
        local uniqueid = math.floor(record / 10)
        local inchipinfoarr = json.decode(chipinfo.inchipinfoarr)
        local key = get_chip(cfgid, inchipinfoarr, nil, islock, true, uniqueid, part)
        if not key then
            ret.code = errCodeDef.eEC_chip_nofind
            return ret
        end
        inchipinfoarr[key].islock = islock == 0 and 1 or 0
        chip_dc.req.setvalue(uid, "inchipinfoarr", json.encode(inchipinfoarr))
    elseif isnew then
        local newinchipinfo = json.decode(chipinfo.newinchipinfo)
        local key = get_chip(cfgid, newinchipinfo, nil, islock, false)
        if not key then
            ret.code = errCodeDef.eEC_chip_nofind
            return ret
        end
        add_chip(newinchipinfo[key].id, newinchipinfo, newinchipinfo[key].level, 1, islock == 0 and 1 or 0, false)
        remove_number(newinchipinfo, key, 1)
        chip_dc.req.setvalue(uid, "newinchipinfo", json.encode(newinchipinfo))
    else
        local chipinfoarr = json.decode(chipinfo.chipinfoarr)
        local key = get_chip(cfgid, chipinfoarr, nil, islock, false)
        if not key then
            ret.code = errCodeDef.eEC_chip_nofind
            return ret
        end
        add_chip(chipinfoarr[key].id, chipinfoarr, chipinfoarr[key].level, 1, islock == 0 and 1 or 0, false)
        remove_number(chipinfoarr, key, 1)
        chip_dc.req.setvalue(uid, "chipinfoarr", json.encode(chipinfoarr))
    end
    ret.code = errCodeDef.eEC_success
    return ret
end

return chiphandler.new()
