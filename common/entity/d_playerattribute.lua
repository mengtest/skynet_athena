local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_playerattribute", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_playerattribute"
end

return EntityType.new()