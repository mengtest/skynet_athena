local UpdateEntity = require "UpdateEntity"

local EntityType = class("s_materials", UpdateEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "s_materials"
end

return EntityType.new()
