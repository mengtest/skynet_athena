local UpdateEntity = require "UpdateEntity"

local EntityType = class("s_sale", UpdateEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "s_sale"
end

return EntityType.new()
