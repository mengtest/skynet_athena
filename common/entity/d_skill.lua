local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_skill", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_skill"
end

return EntityType.new()