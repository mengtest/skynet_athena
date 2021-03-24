local UpdateEntity = require "UpdateEntity"

local EntityType = class("s_blueprints", UpdateEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "s_blueprints"
end

return EntityType.new()
