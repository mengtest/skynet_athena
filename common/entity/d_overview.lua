local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_overview", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_overview"
end

return EntityType.new()
