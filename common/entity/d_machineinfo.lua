local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_machineinfo", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_machineinfo"
end

return EntityType.new()