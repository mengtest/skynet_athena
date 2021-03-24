local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_chassis", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_chassis"
end

return EntityType.new()