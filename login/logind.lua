local login = require "snax.login_server"
local crypt = require "skynet.crypt"
local skynet = require "skynet"
local snax = require "snax"
local cluster = require "cluster"

local server = {
	host = "0.0.0.0",
	port = tonumber(skynet.getenv("port")),
	multilogin = false,	-- disallow multilogin
	name = "login_master",
	instance = 8,
}

local user_online = {}	-- 记录玩家所登录的服务器

local account_dc

local function match_name_password(param)
	return param:match("[%a%d]+") and (#param >= 8 and #param <= 16) and not param:match("[^a-zA-Z0-9%p]+")
end

local function register(token, password, sdkid)
	--local uid = do_redis({ "incr", "d_account:id" })
	local uid = account_dc.req.get_nextid()
	if uid < 1 then
		LOG_ERROR("register account get nextid failed")
		return
	end

	local row = { id = uid, pid = token, password = password, sdkid = sdkid }
	local ret = account_dc.req.add(row)

	if not ret then
		LOG_ERROR("register account failed")
		return
	end

	LOG_INFO("register account succ uid=%d", uid)
	return uid
end

local function auth(token, password, sdkid, param)
	if not account_dc then
		account_dc = snax.uniqueservice("accountdc")
	end

	local account = account_dc.req.get(sdkid, token)

	if param == "Login" then
		if table.empty(account) then
			if sdkid == 2 then
				return nil
			else
				--密码默认
				-- uid = register(token, token .. "_123456", sdkid)
				return nil
			end
		else
			if tostring(account.password) ~= tostring(password) then
				return 0
			end
			return account.id
		end
	else
		if table.empty(account) then
			if not (match_name_password(token) or match_name_password(password)) then
				--返回0表示格式错误
				return 0
			else
				return register(token, password, sdkid)
			end
		else
			return nil
		end
	end
end

function server.auth_handler(args)
	local ret = string.split(args, ":")
	assert(#ret == 5)
	local server = ret[1]
	local token = ret[2]
	local password= ret[3]
	local sdkid = tonumber(ret[4])
	local loginOrRegister = ret[5]
	--0表示密码错误/格式错误，1表示账号不存在/账号重复   前者对应登录后者对应注册
	local result = 1
	skynet.error(string.format("auth_handler is performing server=%s token=%s password=%s sdkid=%d param=%s", server, token, password, sdkid, loginOrRegister))
	LOG_INFO("auth_handler is performing server=%s token=%s password=%s sdkid=%d, param=%s", server, token, password, sdkid, loginOrRegister)
	local uid = auth(token, password, sdkid, loginOrRegister)
	if uid == nil then
		LOG_ERROR("auth failed")
		error("auth failed")
	elseif uid == 0 then
		result = 0
	end
	return result, server, uid
end

-- 认证成功后，回调此函数，登录游戏服务器
function server.login_handler(server, uid, secret)
	LOG_INFO(string.format("%d@%s is login, secret is %s", uid, server, crypt.hexencode(secret)))
	-- only one can login, because disallow multilogin
	local last = user_online[uid]
	-- 如果该用户已经在某个服务器上登录了，先踢下线
	if last then
		LOG_INFO(string.format("call gameserver %s to kick uid=%d subid=%d ...", last.server, uid, last.subid))
		local ok = pcall(cluster.call, last.server, "gated", "kick", uid, last.subid)
		if not ok then
			user_online[uid] = nil
		end
	end

	-- login_handler会被并发，可能同一用户在另一处中又登录了，所以再次确认是否登录
	if user_online[uid] then
		LOG_ERROR("user %d is already online", uid)
		error(string.format("user %d is already online", uid))
	end

	-- 登录游戏服务器
	LOG_INFO(string.format("uid=%d is logging to gameserver %s ...", uid, server))
	local ok, subid = pcall(cluster.call, server, "gated", "login", uid, secret)
	if not ok then
		LOG_ERROR("login gameserver error")
		error("login gameserver error")
	end
	LOG_INFO(string.format("uid=%d logged on gameserver %s subid=%d ...", uid, server, subid))
	user_online[uid] = { subid = subid, server = server }
	return subid
end

local CMD = {}

function CMD.logout(uid, subid)
	local u = user_online[uid]
	if u then
		LOG_INFO(string.format("%d@%s#%d is logout", uid, u.server, subid))
		user_online[uid] = nil
	end
end

function server.command_handler(command, source, ...)
	local f = assert(CMD[command])
	return f(source, ...)
end

login(server)	-- 启动登录服务器
