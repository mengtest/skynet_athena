local skynet = require "skynet"
local queue = require "skynet.queue"
local snax = require "snax"
local netpack = require "netpack"
-- local protobuf = require "protobuf"
local sproto = require "sproto"
local protoloader = require "protoloader"
local game_proto = require "game_proto"

local FD

local sproto, host, request

local cs = queue()
local UID
local SUB_ID
local SECRET

local afktime = 0

local gate		-- 游戏服务器gate地址
local CMD = {}

local worker_co
local running = false

local timer_list = {}

local function add_timer(id, interval, f)
	local timer_node = {}
	timer_node.id = id
	timer_node.interval = interval
	timer_node.callback = f
	timer_node.trigger_time = skynet.now() + interval
	timer_list[id] = timer_node
end

local function del_timer(id)
	timer_list[id] = nil
end

local function clear_timer()
	timer_list = {}
end

local function dispatch_timertask()
	local now = skynet.now()
	for k, v in pairs(timer_list) do
		if now >= v.trigger_time then
			v.callback()
			v.trigger_time = now + v.interval
		end
	end
end

local function worker()
	local t = skynet.now()
	while running do
		dispatch_timertask()
		local n = 100 + t - skynet.now()
		skynet.sleep(n)
		t = t + 100
	end
end

local function logout(name)
	local msg = {}
	if name ~= nil and name == addictiondefine.addictiontype.otherLogin then
		msg.code = addictiondefine.addictiontype.otherLogin
	elseif name ~= nil and name == addictiondefine.addictiontype.kickout then
		msg.code = addictiondefine.addictiontype.kickout
	elseif name ~= nil and name == addictiondefine.addictiontype.addiction then
		msg.code = addictiondefine.addictiontype.addiction
	end
	if name ~= nil then
		send_request(get_user_fd(UID), msg, "user_kick")
	end

	local ServiceName = skynet.call("online", "lua", "GetServiceName") 

	for i = 1, #ServiceName do
		local ok, obj = pcall(snax.uniqueservice, ServiceName[i])
		if obj ~= nil then
			pcall(obj.req["offline"], UID)
		end
		skynet.error(ServiceName[i], "is nil!")
	end
	------------------------------------------------------------
	if running then
		running = false
		skynet.wakeup(worker_co)	-- 通知协程退出
	end

	if gate then
		skynet.call(gate, "lua", "logout", UID, SUB_ID)
	end

	
	skynet.call("dcmgr", "lua", "unload", UID)	-- 卸载玩家数据
	gate = nil
	UID = nil
	SUB_ID = nil
	SECRET = nil

	afktime = 0
	--这里不退出agent服务，以便agent能复用
	--skynet.exit()
end

-- 空闲登出
local function idle()
	if afktime > 0 then
		if skynet.time() - afktime >= 60 then		-- 玩家断开连接后一分钟强制登出
			logout()
		end
	end
end

local function reg_timers()
	add_timer(1, 500, idle)
end

local function msg_dispatch(fd, name, args, response)
	skynet.call("agentmgr", "lua", "setfd", UID, FD)     -- 记录FD
	if name == "user_logout" then
		return logout()
	end

	local name = name
	local module, method = name:match "([^.]*)_(.*)"
	-- skynet.trace()
	local data = nil
	local ret = nil
	local ok, obj = pcall(snax.uniqueservice, module)

	if not ok then
		skynet.error(string.format("unknown module %s", module))
		return
	else
		ok, data = pcall(obj.req[method], {
				name = name,
				msg = args,
				uid = UID,
				fd = fd
			}
		)
	--  多线程问题简单处理
	-- 	ok, data = cs(obj.req[method], {
	-- 		name = name,
	-- 		msg = args,
	-- 		uid = UID,
	-- 		fd = fd
	-- 	}
	-- )
	end
	if ok then
		ret = data
	end
	if response and ret then
		send_client(FD, response(ret), name)
		-- send_request(FD, {msg = "happy!!!!!!"}, "handshake_handshake")
	end
	if name ~= "user_gettime" then
		LOG_INFO(string.format("used: %d, command: %s", UID, name))
		skynet.error(string.format("used: %d, command: %s", UID, name))
	end
end

-- 玩家登录游服后调用
function CMD.login(source, uid, subid, secret)
	-- you may use secret to make a encrypted data stream
	LOG_INFO(string.format("%d is login", uid))
	gate = source
	UID = uid
	SUB_ID = subid
	SECRET = secret
	afktime = 0
end

-- 玩家登录游服，握手成功后调用
function CMD.auth(source, uid, client_fd)
	FD = client_fd
	LOG_INFO(string.format("%d is real login", uid))
	LOG_INFO("call dcmgr to load user data uid=%d", uid)
	skynet.call("dcmgr", "lua", "load", uid)	-- 加载玩家数据，重复加载是无害的
	skynet.call("agentmgr", "lua", "setfd", uid, FD)     -- 记录FD
	if not running then
		running = true
		reg_timers()
		worker_co = skynet.fork(worker)
	end
	local ok, obj = pcall(snax.uniqueservice, "user")
	if not ok then
		LOG_ERROR("user module not found")
		return
	else
		obj.req.roleinit(uid)
	end
end

function CMD.online(source, uid, client_fd)
	skynet.call("online", "lua", "online", uid, client_fd)
end

function CMD.logout(source, name)
	-- NOTICE: The logout MAY be reentry
	-- skynet.call("agentmgr", "lua", "setfd", UID, nil)     -- 清除FD
	skynet.error(string.format("%s is logout", UID))
	logout(name)
end

function CMD.afk(source)
	-- the connection is broken, but the user may back
	skynet.error("someone offline!")
	skynet.call("agentmgr", "lua", "setfd", UID, nil)     -- 清除FD
	-- skynet.call("teammatch", "lua", "offline", UID)
	local ServiceName = skynet.call("online", "lua", "GetServiceName") 

	for i = 1, #ServiceName do
		local ok, obj = pcall(snax.uniqueservice, ServiceName[i])
		pcall(obj.req["offline"], UID)
	end

	afktime = skynet.time()
	skynet.error(string.format("AFK"))
end

function CMD.GetFD()
	if FD ~= nil then
		return FD
	end
end


skynet.register_protocol {
	name = "client",
	id = skynet.PTYPE_CLIENT,
	unpack = function (...)
		return host:dispatch(...)
	end,
	dispatch = function (fd, _, type, ...)
		skynet.ignoreret()
		if type == "REQUEST" then
			msg_dispatch(fd, ...)
		end
		-- 约定不用客户端response的协议
	end
}

skynet.start(function()
	-- If you want to fork a work thread , you MUST do it in CMD.login
	skynet.dispatch("lua", function(session, source, command, ...)
		local f = assert(CMD[command])
		skynet.retpack(cs(f, source, ...))
	end)
	protoloader.init()
	-- define.sharedata = sharedata;
	sproto, host, request = protoloader.load(1)
end)
