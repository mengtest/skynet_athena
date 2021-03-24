local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_userset", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_userset"
end

return EntityType.new()
