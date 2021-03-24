local skynet = require "skynet"
local snax = require "skynet.snax"
local EntityFactory = require "EntityFactory"

local entWeapons
local entbody
local entChassis
local entFirecontroller

local function getent(equip)
    if equip == warehousedefine.warehousetype.weapon then
        return entWeapons
    elseif equip == warehousedefine.warehousetype.body then
        return entbody
    elseif equip == warehousedefine.warehousetype.chassis then
        return entChassis
    elseif equip == warehousedefine.warehousetype.firecontroller then
        return entFirecontroller
    end
end

function init(...)
    entWeapons = EntityFactory.get("d_weapons")
    entWeapons:init()

    entbody = EntityFactory.get("d_body")
    entbody:init()

    entChassis = EntityFactory.get("d_chassis")
    entChassis:init()

    entFirecontroller = EntityFactory.get("d_firecontroller")
    entFirecontroller:init()
end

function exit(...)
end

function response.getcfgid(part, uniqueid)
    local ent = getent(part)
	return ent:getValue(uniqueid, "cfgid")   
end

function response.load(uid)
    if not uid then return end
    entWeapons:load(uid)
    entbody:load(uid)
    entChassis:load(uid)
    entFirecontroller:load(uid)
end

function response.unload(uid)
	if not uid then return end
    entWeapons:unload(uid)
    entbody:unload(uid)   
    entChassis:unload(uid)  
    entFirecontroller:unload(uid)     
end

function response.getvalue(equip, uid, key)
    local ent = getent(equip)
	return ent:getValue(uid, key)
end

function response.setvalue(equip, uid, key, value)
    local ent = getent(equip)
	return ent:setValue(uid, key, value)
end

function response.add(equip, row)
    local ent = getent(equip)
	return ent:add(row)
end

function response.delete(equip, row)
    local ent = getent(equip)
	return ent:delete(row)
end

function response.get(equip, uid)
    local ent = getent(equip)
	return ent:get(uid)
end

function response.get_nextid(equip)
    local ent = getent(equip)
	return ent:getNextId()
end

function response.get_MaxId(equip)
    local ent = getent(equip)
	return ent:getMaxId()
end