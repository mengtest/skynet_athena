local UpdateEntity = require "UpdateEntity"

local EntityType = class("s_special", UpdateEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "s_special"
end

return EntityType.new()
