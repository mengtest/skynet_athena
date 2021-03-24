local sprotoloader = require "sprotoloader"
local sparser = require "sprotoparser"

local loader = {
	GAME_TYPES = 0,

	GAME = 1,
	GAME_C2S = 1,
	GAME_S2C = 2,
}

function loader.init ()
	local gameproto = require "game_proto"
	sprotoloader.save (sparser.parse(gameproto.types), loader.GAME_TYPES)
	local spb_c2s = sparser.parse(gameproto.c2s)
	sprotoloader.save (spb_c2s, loader.GAME_C2S)
	local spb_s2c = sparser.parse(gameproto.s2c)
	sprotoloader.save (spb_s2c, loader.GAME_S2C)
	-- local file_c2s = io.open('./c2s.spb',"w+")
	-- file_c2s:write(spb_c2s)
	-- file_c2s:close()
	-- local file_s2c = io.open('./s2c.spb',"w+")
	-- file_s2c:write(spb_s2c)
	-- file_s2c:close()
	
	local sproto = sprotoloader.load (loader.GAME_S2C)
	local host = sproto:host("package")
	local request = host:attach (sprotoloader.load (loader.GAME))

	loader._sproto = sproto
	loader._host = host
	loader._request = request

end

function loader.load (index)
    local sproto = sprotoloader.load (index)
	local host = sproto:host "package"
	local request = host:attach (sprotoloader.load (index + 1))
	return sproto, host, request
end


function loader.pack(name, args, session)
	return loader._request(name, args, session)
end

function loader.unpack(content)
	print("-----------loaderunpack, content:", content)
	return loader._host:dispatch(content)
end

return loader
