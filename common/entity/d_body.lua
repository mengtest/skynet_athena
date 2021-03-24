local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_body", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_body"
end

return EntityType.new()