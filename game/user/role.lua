local skynet = require "skynet"
local snax = require "skynet.snax"

local user_dc

function init(...)
	user_dc = snax.uniqueservice("userdc")
end

function exit(...)
end

function response.roleinit(uid, name)
	local errno = E_SUCCESS
	if user_dc.req.check_role_exists(uid) then
		LOG_ERROR("uid %d has role, role init failed", uid)
		return ErrorCode.E_ROLE_EXISTS
	end

	local data = {
		uid = uid,
		name = name,
		level = 1,
		exp = 0,
		rtime = os.time(),
		ltime = os.time()
	}

	local ret = user_dc.req.add(data)

	if ret then
		local userinfo = user_dc.req.get(args.uid)
		local name, resp = pb_encode("user.UserInfoResponse", userinfo)
	end
	
	-- 初始化角色其他数据

	if not ret then
		errno = ErrorCode.E_DB_ERROR
	end
	return errno
end

function response.rolerename(uid, name)
	local errno = E_SUCCESS
	if not user_dc.req.check_role_exists(uid) then
		LOG_ERROR("uid %d has not a role, role rename failed", uid)
		return ErrorCode.E_ROLE_NOT_EXISTS
	end

	local ret = user_dc.req.setvalue(uid, "name", name)
	
	if not ret then
		return ErrorCode.E_DB_ERROR
	end
	return errno
end
