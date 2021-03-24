local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_prop", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_prop"
end

return EntityType.new()
