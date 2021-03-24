local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_firecontroller", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_firecontroller"
end

return EntityType.new()