local skynet = require "skynet"
local snax = require "skynet.snax"
local sharedata = require "skynet.sharedata"
local errCodeDef = require "errcodedef"
local json = require "cjson"
local chiphandler = require "game.chip.chiphandler"

local equipment_dc
local hangar_dc
local chip_dc
local skill_dc
local machineinfo_dc
local machinecfg_dc
local chipattribute_dc
local materials_dc
local warehouse

---装备芯片属性更新
function response.changeequip(uid, part, curcfgindex, oldid, uniqueid)
    chiphandler:changeequip(uid, part, curcfgindex, oldid, uniqueid)
end

--装备芯片
function response.add(data)
    return chiphandler:add(data)
end

--卸下芯片
function response.remove(data)
    return chiphandler:remove(data)
end

--使用反应堆
function response.double(data)
    return chiphandler:double(data)
end

--槽位极化
function response.slotpola(data)
    return chiphandler:slotpola(data)
end

--芯片升级
function response.upgrade(data)
    return chiphandler:upgrade(data)
end

--芯片出售
function response.sell(data)
    return chiphandler:sellchip(data)
end

--芯片分解
function response.decompose(data)
    return chiphandler:decompose(data)
end

--芯片合成
function response.composition(data)
    return chiphandler:composition(data)
end

--锁定芯片
function response.setlockchip(data)
    return chiphandler:setlockchip(data)
end

--增加芯片
function response.addchip(uid, id, level, number)
    return chiphandler:addchip(uid, id, level, number)
end

--只允许移除（出售/分解）未装备芯片
function response.removechip(uid, id, level, number)
    return chiphandler:removechip(uid, id, level, number)
end

--获取部件槽位信息
function response.getslotinfo(data)
    return chiphandler:getslotinfo(data)
end

--获取部件的所有信息
function response.equipinfo(data)
    return chiphandler:equipinfo(data)
end

function response.getequipchip(data)
    return chiphandler:getequipchip(data)
end

function init(...)
    chip_dc = snax.queryservice("chipinfodc")
    equipment_dc = snax.queryservice("equipmentdc")
    hangar_dc = snax.queryservice("hangardc")
    skill_dc = snax.uniqueservice("skilldc")
    machineinfo_dc = snax.queryservice("machineinfodc")
    machinecfg_dc = snax.queryservice("machinecfgdc")
    chipattribute_dc = snax.queryservice("chipattributedc")
    materials_dc = snax.queryservice("materialsdc")
    warehouse = snax.queryservice("warehouse")
    chiphandler:initchiphandler(chip_dc, equipment_dc, hangar_dc, skill_dc, machineinfo_dc, machinecfg_dc, chipattribute_dc, materials_dc, warehouse)
end

function exit(...)
end

function response.online(uid, fd)
end

function response.offline(uid)
end
