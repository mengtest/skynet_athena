local skynet = require "skynet"
local snax = require "skynet.snax"
local sharedata = require "skynet.sharedata"
local errCodeDef = require "errcodedef"
local json = require "cjson"
local timext = require "timext"

local user_dc
local player
local chip
local scan
local warehouse
local equipment_dc
local hangar_dc
local chip_dc
local blueprint_dc
local collection_dc
local score_dc
local materials_dc

function init(...)
    user_dc = snax.queryservice("userdc")
    player = snax.queryservice("player")
    chip = snax.queryservice("chip")
    warehouse = snax.queryservice("warehouse")
    scan = snax.queryservice("scan")
    equipment_dc = snax.queryservice("equipmentdc")
    hangar_dc = snax.queryservice("hangardc")
    chip_dc = snax.queryservice("chipinfodc")
    blueprint_dc = snax.queryservice("blueprintdc")
    score_dc = snax.queryservice("scoredc")
    collection_dc = snax.uniqueservice("collectiondc")
    materials_dc = snax.queryservice("materialsdc")
end

---增加装备
function response.addequip(data)
    local ret = {}
    local cfgid = data.msg.cfgid
    local number = data.msg.number
    local part = data.msg.part
    if not cfgid or not number or not part then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = warehouse.req.addequip(data.uid, part, cfgid, 1, number) and errCodeDef.eEC_success or errCodeDef.eEC_err_param
    return ret
end

---增加芯片
function response.addchip(data)
    local ret = {}
    local id = data.msg.id
    local level = data.msg.level
    local number = data.msg.number
    if not id or not level or not number then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = chip.req.addchip(data.uid, id, level, number) and errCodeDef.eEC_success or errCodeDef.eEC_err_param
    return ret
end

---增加分数
function response.setscore(data)
    local ret = {}
    local id = data.msg.id
    local number = data.msg.number
    if not id or not number then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = player.req.setscore(data.uid, id, number) and errCodeDef.eEC_success or errCodeDef.eEC_err_param
    return ret
end

---增加蓝图
function response.addblueprint(data)
    local ret = {}
    local id = data.msg.id
    local number = data.msg.number
    if not id or not number then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = scan.req.addblueprint(data.uid, id, number) and errCodeDef.eEC_success or errCodeDef.eEC_err_param
    return ret
end

---增加材料
function response.addmaterial(data)
    local ret = {}
    local id = data.msg.id
    local number = data.msg.number
    if not id or not number then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = warehouse.req.addmaterials(data.uid, id, number) and errCodeDef.eEC_success or errCodeDef.eEC_err_param
    return ret
end

---检测是否已拥有同类型装备
---@param cfgid number 配置表id
---@param part number 部位编号
local function incollection(uid, cfgid, part)
    cfgid = tostring(cfgid)
    local collection = collection_dc.req.get(uid)
    if not collection then
        return
    end
    if part == warehousedefine.warehousetype.body then
        local data = string.split(collection.body)
        if not table.finds(data, "cfgid", cfgid) then
            table.insert(data, {cfgid = cfgid, maxlv = 1})
            collection_dc.req.setvalue(uid, "body", json.encode(data))
        end
    elseif part == warehousedefine.warehousetype.chassis then
        local data = string.split(collection.chassis)
        if not table.finds(data, "cfgid", cfgid) then
            table.insert(data, {cfgid = cfgid, maxlv = 1})
            collection_dc.req.setvalue(uid, "chassis", json.encode(data))
        end
    elseif part == warehousedefine.warehousetype.firecontroller then
        local data = string.split(collection.firecontroller)
        if not table.finds(data, "cfgid", cfgid) then
            table.insert(data, {cfgid = cfgid, maxlv = 1})
            collection_dc.req.setvalue(uid, "firecontroller", json.encode(data))
        end
    elseif part == warehousedefine.warehousetype.weapon then
        local data = string.split(collection.weapon)
        if not table.finds(data, "cfgid", cfgid) then
            table.insert(data, {cfgid = cfgid, maxlv = 1})
            collection_dc.req.setvalue(uid, "weapon", json.encode(data))
        end
    end
end

---新增全部装备
local function setinfo(uid, data, equiptype, temp)
    temp = temp or ""
    local ret, index = {}, nil
    ret.propinfo = {}
    if equipindexpe == warehousedefine.warehousetype.body then
        index = warehousedefine.warehousetype.body
    elseif equiptype == warehousedefine.warehousetype.chassis then
        index = warehousedefine.warehousetype.chassis
    elseif equiptype == warehousedefine.warehousetype.firecontroller then
        index = warehousedefine.warehousetype.firecontroller
    elseif equiptype == warehousedefine.warehousetype.weapon then
        index = warehousedefine.warehousetype.weapon
    end
    for i = 1, #data do
        if data[i] < 90000 then
            local tempid = tonumber(equipment_dc.req.get_nextid(tonumber(equiptype)))
            local row = {
                id = tempid,
                cfgid = data[i],
                playerid = tonumber(uid),
                lv = 1,
                exp = 0,
                slotarray = json.encode({{}, {}, {}, {}, {}}),
                isdouble = 0,
                volume = 4,
                currentvolume = 0,
                count = 0
            }
            equipment_dc.req.add(equiptype, row)
            table.insert(ret.propinfo, {id = tempid, number = 1, lv = 1, index = index, cfgid = data[i]})
            if temp ~= "" then
                temp = temp .. "," .. tempid
            else
                temp = tempid
            end
            incollection(uid, data[i], equiptype)
        end
    end
    send_request(get_user_fd(uid), ret, "warehouse_addmessage")
    return temp
end

local function get_chip(id, arry, level)
    for k, _ in pairs(arry) do
        if tonumber(arry[k]["id"]) == id and tonumber(arry[k]["level"]) == level then
            return k
        end
    end
    return nil
end

--- 加入芯片
local function add_chip(id, arry, level, number)
    local number = number or 1

    local key = get_chip(id, arry, level)
    if key == nil then
        table.insert(arry, {id = id, number = number, level = level})
    else
        arry[key].number = arry[key].number + number
    end
end

---增加全部芯片
---每种芯片5个15级
local function setchip(uid, data)
    local ret = {}
    local num = 5
    local level = 15
    ret.propinfo = {}
    local chipinfoarr = json.decode(chip_dc.req.getvalue(uid, "newchipinfo"))
    for i = 1, #data do
        ---每个芯片满级并且增加5个
        add_chip(data[i], chipinfoarr, level, num)
        chip_dc.req.setvalue(uid, "newchipinfo", json.encode(chipinfoarr))
        table.insert(ret.propinfo, {id = 0, number = num, lv = level, type = warehousedefine.warehousetype.chip, cfgid = data[i]})
    end
    send_request(get_user_fd(uid), ret, "warehouse_addmessage")
end

---查找特定状态蓝图
---@return boolean 返回第一个满足项下标
local function get_blueprint(id, arry)
    for i = 1, #arry do
        if arry[i].id == id then
            return i
        end
    end
    return nil
end

---添加蓝图
local function add_blueprint(uid, id, number)
    local cfgid = id
    local tab = {}
    if not blueprint_dc.req.getvalue(uid, "id") then
        table.insert(tab, {id = cfgid, number = number})
        local data = {id = uid, newblueprint = json.encode(tab), blueprintinfo = json.encode({}), blueprinting = json.encode({}), blueprintend = json.encode({})}
        blueprint_dc.req.add(data)
    else
        local info = json.decode(blueprint_dc.req.getvalue(uid, "newblueprint"))
        local blueprint = get_blueprint(cfgid, info)
        if blueprint then
            info[blueprint].number = info[blueprint].number + number
        else
            table.insert(info, {id = cfgid, number = number})
        end
        blueprint_dc.req.setvalue(uid, "newblueprint", json.encode(info))
    end
end

---增加全部蓝图
local function setblueprint(uid, data)
    local ret = {}
    ret.propinfo = {}
    for i = 1, #data do
        ---每个蓝图增加1个
        add_blueprint(uid, string.sub(data[i], 2, -1), 1)
        table.insert(ret.propinfo, {id = string.sub(data[i], 2, -1), number = 1, state = 0})
    end
    send_request(get_user_fd(uid), ret, "warehouse_addbp")
end

---设置分数
local function setscore(uid)
    local score = tonumber(math.floor(do_redis({ "zscore", "ladder", uid}, uid)) + 1000 ..".".. (9999999999 - tonumber(string.sub(timext.current_time(), 1, 10))))
    do_redis({ "zadd", "ladder", score, uid}, uid)
    score_dc.req.setvalue(uid, "score", score)
    send_request(get_user_fd(uid), {score = math.floor(score)}, "warehouse_updatescore")
end

---增加全部材料
---以前新材料清空
local function setmaterial(uid, data)
    local ret = {}
    local num = 100
    ret.propinfo = {}
    local materialsinfo = materials_dc.req.get(uid)
    local materials = ""
    for i = 1, #data do
        if materials == "" then
            materials = data[i] .. "," .. num
        else
            materials = materials .. "," .. data[i] .. "," .. num
        end
        table.insert(ret.propinfo, {id = 0, number = num, lv = 0, type = warehousedefine.warehousetype.material, cfgid = data[i]})
    end
    materials_dc.req.update({id = tonumber(uid), newmaterials = materials, materials = materialsinfo.materials})
    send_request(get_user_fd(uid), ret, "warehouse_addmessage")
end

function response.cheatinterface(data)
    local ret = {}
    local uid = data.uid
    local strcode = data.msg.strcode
    local temp = ""
    ret.code = errCodeDef.eEC_success
    if strcode == "e_bo" then
        local body = table.keys(sharedata.deepcopy("machinebody"))
        temp = setinfo(uid, body, warehousedefine.warehousetype.body, hangar_dc.req.getvalue(uid, "newbody"))
        hangar_dc.req.setvalue(uid, "newbody", temp)
    elseif strcode == "e_ch" then
        local chassis = table.keys(sharedata.deepcopy("machinechassis"))
        temp = setinfo(uid, chassis, warehousedefine.warehousetype.chassis, hangar_dc.req.getvalue(uid, "newchassis"))
        hangar_dc.req.setvalue(uid, "newchassis", temp)
    elseif strcode == "e_fi" then
        local firecontrol = table.keys(sharedata.deepcopy("firecontrol"))
        temp = setinfo(uid, firecontrol, warehousedefine.warehousetype.firecontroller, hangar_dc.req.getvalue(uid, "newfirecontroller"))
        hangar_dc.req.setvalue(uid, "newfirecontroller", temp)
    elseif strcode == "e_we" then
        local weapon = table.keys(sharedata.deepcopy("weapontable"))
        temp = setinfo(uid, weapon, warehousedefine.warehousetype.weapon, hangar_dc.req.getvalue(uid, "newweapons"))
        hangar_dc.req.setvalue(uid, "newweapons", temp)
    elseif strcode == "c_ch" then
        local mod = table.keys(sharedata.deepcopy("mod"))
        setchip(uid, mod)
    elseif strcode == "b_bl" then
        local mod = table.keys(sharedata.deepcopy("blueprint"))
        setblueprint(uid, mod)
    elseif strcode == "s_sc" then
        setscore(uid)
    elseif strcode == "m_ma" then
        local mod = table.keys(sharedata.deepcopy("material_list"))
        setmaterial(uid, mod)
    elseif strcode == "a_kh" then
        warehouse.req.addkhorium(uid, 10000000)
    elseif strcode == "a_go" then
        warehouse.req.addgold(uid, 1000000)
    else
        ret.code = errCodeDef.eEC_err_param
    end
    return ret
end

function exit(...)
end

function response.online(uid, fd)
    ---[[ 测试代码
    -- skynet.error(tostring(player.req.setscore(uid, 1000)))
    -- skynet.error(tostring(player.req.setscore(uid, -500)))

    -- skynet.error(tostring(chip.req.addchip(uid, 10033, 10, 1000)))
    -- skynet.error(tostring(chip.req.removechip(uid, 10033, 10, 1)))

    -- skynet.error(tostring(warehouse.req.addequip(uid, 1, 10001, 1, 2)))

    -- skynet.error(tostring(scan.req.addblueprint(uid, "110001210001310001", 2, "顾国成")))
    -- skynet.error(tostring(scan.req.remblueprint(uid, "310001", 2, nil, 3)))
    -- skynet.error(tostring(scan.req.remblueprint(uid, "310001", 1, nil, 3)))

    -- skynet.error(tostring(warehouse.req.addmaterials(uid, 10001, 2)))
    -- skynet.error(tostring(warehouse.req.remmaterials(uid, 10001, 2)))

    -- skynet.error(tostring(warehouse.req.addgold(uid, 2000)))
    -- skynet.error(tostring(warehouse.req.remgold(uid, 1000)))
    -- --]]
end

function response.offline(uid)
end