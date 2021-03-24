local skynet = require "skynet"
local snax = require "skynet.snax"
local EntityFactory = require "EntityFactory"

local entAccount

function init(...)
	entAccount = EntityFactory.get("s_props")
	entAccount:init()
	entAccount:load()
end

function exit(...)
end

function response.load(uid)
	if not uid then return end
	entAccount:load(uid)
end

function response.unload(uid)
	if not uid then return end
	entAccount:unload(uid)
end

function response.add(row)
	return entAccount:add(row)
end

function response.delete(row)
	return entAccount:delete(row)
end

function response.get(sdkid, pid)
	return entAccount:get(sdkid, pid)
end

function response.update(row)
	return entAccount:update(row)
end

function response.get_nextid()
	return entAccount:getNextId()
end