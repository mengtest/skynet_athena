local UpdateEntity = require "UpdateEntity"

local EntityType = class("s_bag", UpdateEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "s_bag"
end

return EntityType.new()
