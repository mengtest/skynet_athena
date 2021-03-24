local skynet = require "skynet"
local snax = require "skynet.snax"
local cluster = require "cluster"

local config = {
}

local update = {

}

local user = {
}

local common = {
	{ name = "d_account", key = "sdkid,pid", indexkey = "id" },
}

skynet.start(function()
	local log = skynet.uniqueservice("log")
	skynet.call(log, "lua", "start")
	
	local dbmgr = skynet.uniqueservice("dbmgr")
	skynet.call(dbmgr, "lua", "start", config, user, common, update)

	skynet.uniqueservice("logind")		-- 启动登录服务器
	cluster.open("login")
end)

