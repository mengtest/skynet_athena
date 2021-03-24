local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_hangar", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_hangar"
end

return EntityType.new()