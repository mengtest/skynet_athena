local skynet = require "skynet"
local snax = require "skynet.snax"
local EntityFactory = require "EntityFactory"

local entPlayer

function init(...)
	entPlayer = EntityFactory.get("d_chipinfo")
	entPlayer:init()
end

function exit(...)
end

function response.load(uid)
	if not uid then return end
	entPlayer:load(uid)
end

function response.unload(uid)
	if not uid then return end
	entPlayer:unload(uid)
end

function response.getvalue(uid, key)
	return entPlayer:getValue(uid, key)
end

function response.setvalue(uid, key, value)
	return entPlayer:setValue(uid, key, value)
end

function response.add(row)
	return entPlayer:add(row)
end

function response.delete(row)
	return entPlayer:delete(row)
end

function response.get(uid)
	return entPlayer:get(uid)
end

function response.update(row)
	return entPlayer:update(row)
end