local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_weapons", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_weapons"
end

return EntityType.new()