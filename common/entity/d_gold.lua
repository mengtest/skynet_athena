local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_gold", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_gold"
end

return EntityType.new()