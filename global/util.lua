local skynet = require "skynet"
local protoloader = require "protoloader"
local socketdriver = require "skynet.socketdriver"
-- local queue = require "skynet.queue"

-- cs = queue()

max = 10

function do_redis(args, uid)
	local cmd = assert(args[1])
	args[1] = uid
	return skynet.call("redispool", "lua", cmd, table.unpack(args))
end

function LOG_DEBUG(fmt, ...)
	local msg = string.format(fmt, ...)
	local info = debug.getinfo(2)
	if info then
		msg = string.format("[%s:%d] %s", info.short_src, info.currentline, msg)
	end
	skynet.send("log", "lua", "debug", SERVICE_NAME, msg)
end

function LOG_INFO(fmt, ...)
	local msg = string.format(fmt, ...)
	local info = debug.getinfo(2)
	if info then
		msg = string.format("[%s:%d] %s", info.short_src, info.currentline, msg)
	end
	skynet.send("log", "lua", "info", SERVICE_NAME, msg)
end

function LOG_WARNING(fmt, ...)
	local msg = string.format(fmt, ...)
	local info = debug.getinfo(2)
	if info then
		msg = string.format("[%s:%d] %s", info.short_src, info.currentline, msg)
	end
	skynet.send("log", "lua", "warning", SERVICE_NAME, msg)
end

function LOG_ERROR(fmt, ...)
	local msg = string.format(fmt, ...)
	local info = debug.getinfo(2)
	if info then
		msg = string.format("[%s:%d] %s", info.short_src, info.currentline, msg)
	end
	skynet.send("log", "lua", "error", SERVICE_NAME, msg)
end

function LOG_FATAL(fmt, ...)
	local msg = string.format(fmt, ...)
	local info = debug.getinfo(2)
	if info then
		msg = string.format("[%s:%d] %s", info.short_src, info.currentline, msg)
	end
	skynet.send("log", "lua", "fatal", SERVICE_NAME, msg)
end

function check( ... )
	-- body
end

---用户在线
function check_user_online(uid)
	return skynet.call("gated", "lua", "is_online", uid)
end

function get_user_agent(uid)
	return skynet.call("gated", "lua", "get_agent", uid)
end

function get_user_fd(uid)
	return skynet.call("agentmgr", "lua", "getfd", uid) 
end

function get_user_fds()
	return skynet.call("gated", "lua", "get_uids")
end

function get_uids_names()
	return skynet.call("gated", "lua", "get_uids_names")
end

function get_kick_outs(...)
	return skynet.call("gated", "lua", "kick_outs", ...)
end

--关闭战斗管理器
function get_kick_out()
	return skynet.call("gated", "lua", "kick_out")
end

function send_kick_addiction(uid)
	skynet.send("gated", "lua", "kick_addiction", uid)
end

function get_user_agents()
	return skynet.call("gated", "lua", "get_agents")
end

function get_ipsum()
	return skynet.call("gated", "lua", "get_ipsum")
end

---开启事务
function transaction()
	skynet.call("dbsync", "lua", "transaction")
end

---回滚事务
function rollback()
	skynet.call("dbsync", "lua", "rollback")
end

---提交事务
function commit()
	skynet.call("dbsync", "lua", "commit")
end

function send_client(fd, msg, name)

    local package = string.pack (">s2", msg)
    local msg_size = string.len(package)

	-- msg = string.pack(">s2", msg)
	socketdriver.send(fd, package)
end

function send_request(fd, msg, name)
	if not fd then
		return
	end

	local sproto, host, request = protoloader.load(1) 
	local pack = request(name, msg, 0)
	local package = string.pack(">s2", pack)
	local msg_size = string.len(package)
	socketdriver.send(fd, package)
end