local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_show", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_show"
end

return EntityType.new()
