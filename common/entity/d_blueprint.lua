local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_blueprint", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_blueprint"
end

return EntityType.new()