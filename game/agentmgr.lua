local skynet = require "skynet"
require "skynet.manager"
local snax = require "snax"

local _uid_fd = {}
local CMD = {}

function CMD.setfd(uid, fd)
    _uid_fd[uid] = fd
end

function CMD.getfd(uid)
    if _uid_fd[uid] ~= nil then
        return _uid_fd[uid]
    else
        return nil
    end
end

skynet.start(function()
	skynet.dispatch("lua", function(session, source, cmd, ...)
		local f = assert(CMD[cmd], cmd .. "not found")
		skynet.retpack(f(...))
	end)

	skynet.register(SERVICE_NAME)
end)
