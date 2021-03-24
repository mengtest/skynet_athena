local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_shopiteminfo", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_shopiteminfo"
end

return EntityType.new()
