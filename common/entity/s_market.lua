local UpdateEntity = require "UpdateEntity"

local EntityType = class("s_market", UpdateEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "s_market"
end

return EntityType.new()
