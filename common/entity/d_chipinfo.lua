local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_chipinfo", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_chipinfo"
end

return EntityType.new()