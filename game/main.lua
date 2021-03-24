local skynet = require "skynet"
local snax = require "snax"
local cluster = require "cluster"
local sharedata = require "skynet.sharedata"

--公共的，用户登录退出不会清空，服务器启动时会加载
--只有读，没有写数据在数据库建表时已进行初始化
local config = {
	{name = "s_config", key = "id" },
	{name = "s_roleinit", key = "id" },
}

--公共的，后台管理员可以随时更改的，所以不能存储到内存，直接在redis中找没有去数据库找
local update = {
	{name = "s_materials", key = "id"},
	{name = "s_blueprints", key = "id"},
	{name = "s_market", key = "id"},
	{name = "s_bag", key = "id"},
	{name = "s_sale", key = "id"},
	{name = "s_special", key = "id"},
}

--用户信息表， 用户登陆时进行数据读取保存到内存，退出后清空。
--加载方式： 根据用户id，去数据库中查找，进行本地字段保存，并添加到redis
--redis数据库中没有清空
local user = {
	{name = "d_user", key = "id" },
	{name = "d_body", key = "id"},
	{name = "d_chassis", key = "id"},
	{name = "d_weapons", key = "id"},
	{name = "d_firecontroller", key = "id"},
	{name = "d_hangar", key = "id"},
	{name = "d_playerattribute", key = "id"},
	{name = "d_machineinfo", key = "id"},
	{name = "d_chipinfo", key = "id"},
	{name = "d_blueprint", key = "id"},
	{name = "d_skill", key = "id"},
	{name = "d_collection", key = "id"},
	{name = "d_show", key = "id"},
	{name = "d_gold", key = "id"},
	{name = "d_prop", key = "id"},
	{name = "d_materials", key = "id"},
	{name = "d_khorium", key = "id"},
	{name = "d_overview", key = "id"},
	{name = "d_userset", key = "id"},
	{name = "d_shopiteminfo", key = "id"},
	{name = "d_usertask", key = "id"},
}

--公共的，用户登录退出不会清空，服务器启动时会加载
--由于plot\challenge\athletics表的主键不是用户id，所以不能根据用户id进行加载。
--再次加载用户表，是为了查找全部用户
local common = {
	{name = "d_user", key = "id"},
	{name = "d_score", key = "id"},
	-- { name = "d_user", key = "name", columns = "name" },
	{name = "d_athletics", key = "id"},
	{name = "d_plot", key = "id"},
	{name = "d_challenge", key = "id"},
	{name = "d_queueinfo", key = "id"},
	{name = "d_awardinfo", key = "id"},
	{name = "d_businessqueue", key = "id"},
	{name = "d_tmpbqinfo", key = "id"},
	{name = "d_putaway", key = "id"},
	{name = "d_putawaygold", key = "id"},
	{name = "d_shopitem", key = "id"},
	{name = "d_putawayinfo", key = "id"},
	{name = "d_stayputaway", key = "id"},
	{name = "d_machinecfg", key = "id"},
	{name = "d_chipattribute", key = "id"},
	{name = "d_daytask", key = "id"},
	{name = "d_urgenttask", key = "id"},
	{name = "d_plottask", key = "id"},
	{name = "s_chips", key = "id"},
	{name = "s_props", key = "id"},
	{name = "s_bags", key = "id"},
	{name = "s_info", key = "id"},
}
--将数据加载到redis

skynet.start(function()
	local log = skynet.uniqueservice("log")
	skynet.call(log, "lua", "start")
	
	skynet.newservice("debug_console", tonumber(skynet.getenv("debug_port")))
	
	local dbmgr = skynet.uniqueservice("dbmgr")
	skynet.call(dbmgr, "lua", "start", config, user, common, update)

	local dcmgr = skynet.uniqueservice("dcmgr")
	skynet.call(dcmgr, "lua", "start")

	skynet.newservice("share")
	skynet.newservice("initdata")
	--local hero = sharedata.deepcopy( "mkdata_hero",101101276)
	skynet.newservice("console")

	skynet.uniqueservice("online")
	skynet.uniqueservice("agentmgr")
	local gate = skynet.uniqueservice("gated")		-- 启动游戏服务器
	skynet.call(gate, "lua", "init")				-- 初始化，预先分配若干agent
	skynet.call(gate, "lua", "open" , {
		port = tonumber(skynet.getenv("port")) or 8888,
		maxclient = tonumber(skynet.getenv("maxclient")) or 1024,
		servername = NODE_NAME,
	})
	cluster.open(NODE_NAME)
end)

