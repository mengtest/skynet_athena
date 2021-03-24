local CommonEntity = require "CommonEntity"

local EntityType = class("d_challenge", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_challenge"
end

return EntityType.new()
