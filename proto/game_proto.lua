local game_proto = {}
local sprotoRootPath =""
-- 通用的基础数据结构文件列表
local baseTypes = {
	"base.prototype"
}

-- 协议文件列表
local allSprotoFilePath = {
	-- system
	-- "system.loginproto",
	-- module
	"module.proto",                           -- 1
	"module.teammatchproto",                  -- 11 - 29
	"module.battleproto",                     -- 30 - 89
	"module.hangarproto",                     -- 90 - 119
	"module.playerproto",                     -- 170 - 189      -- 20条
	"module.userproto",                       -- 190 - 209      -- 20条
	"module.chipproto",                       -- 210 - 239      -- 30条
	"module.scanproto",                       -- 240 - 269      -- 30条
	"module.warehouseproto",                  -- 270 - 299      -- 30条
	"module.cheatproto",                      -- 300 - 349      -- 50条
	"module.businessproto",                   -- 350 - 389      -- 40条
	"module.achieveproto",					  -- 390 - 419		-- 30条
	"module.shopproto",					  	  -- 420 - 449		-- 30条
	"module.assignmentproto", 				  -- 450 - 479		-- 30条
}

do
	local typesInfos = ""
	for _, v in ipairs(baseTypes) do
		local tempPath = sprotoRootPath .. v
		-- print("=========" .. tempPath)
		local tempStruct = require (tempPath)
		if not tempStruct then
			print("========= tempStruct is nil")
		end
		typesInfos = tempStruct
	end
	game_proto.types = typesInfos

	local allSprotoInfos_c2s = ""
	local allSprotoInfos_s2c = ""
	for _, v in ipairs(allSprotoFilePath) do
		local tempPath = sprotoRootPath .. v
		local tempStruct = require (tempPath)
		allSprotoInfos_c2s = allSprotoInfos_c2s .. tempStruct.c2s
		allSprotoInfos_s2c = allSprotoInfos_s2c .. tempStruct.s2c
	end

	game_proto.c2s = typesInfos .. allSprotoInfos_c2s
	game_proto.s2c = typesInfos .. allSprotoInfos_s2c

end

return game_proto