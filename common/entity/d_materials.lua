local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_materials", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_materials"
end

return EntityType.new()
