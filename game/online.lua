local skynet = require "skynet"
require "skynet.manager"
local snax = require "snax"

local CMD = {}
local _uid_fd = {}

local servicename = {
	"addiction",
	"player",
	"warehouse",
	"teammatch",
	"hangar",
	"chip",
	"scan",
	"bqproxy",
	"achievement",
	"battleproxy",
	"shop",
	-- "cheat",
	"assignment"
	-- "building",
}

local function send_beginservice(uid, fd)
	for i = 1, table.size(servicename) do
		local ok, obj = pcall(snax.uniqueservice, servicename[i])
		if not ok then
			LOG_ERROR(string.format("unknown module %s", servicename[i]))
		else
			obj.req.online(uid, fd)
		end
	end
end

function CMD.init()
end

function CMD.online(uid, fd)
	-- loginctrl
	send_beginservice(uid, fd)
	_uid_fd[uid] = fd
end

function CMD.GetServiceName()
	return servicename
end

skynet.start(function()
	skynet.dispatch("lua", function(session, source, cmd, ...)
		local f = assert(CMD[cmd], cmd .. "not found")
		skynet.retpack(f(...))
	end)

	skynet.register(SERVICE_NAME)
end)

