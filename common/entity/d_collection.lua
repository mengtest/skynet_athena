local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_collection", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_collection"
end

return EntityType.new()