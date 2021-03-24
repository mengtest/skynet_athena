local skynet = require "skynet"
local snax = require "skynet.snax"
local EntityFactory = require "EntityFactory"

local entPlayer

function init(...)
	entPlayer = EntityFactory.get("s_materials")
	entPlayer:init()
end

function exit(...)
end

function response.getvalue(cfgid, key)
	return entPlayer:getValue(cfgid, key)
end

function response.setvalue(cfgid, key, value)
	return entPlayer:setValue(cfgid, key, value)
end

function response.add(row)
	return entPlayer:add(row)
end

function response.delete(row)
	return entPlayer:delete(row)
end

function response.get(cfgid)
	return entPlayer:get(cfgid)
end

function response.getAll()
	return entPlayer:getAll()
end

function response.update(row)
	return entPlayer:update(row)
end

function response.get_nextid()
	return entPlayer:getNextId()
end