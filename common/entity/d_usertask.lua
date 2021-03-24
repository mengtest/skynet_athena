local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_usertask", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_usertask"
end

return EntityType.new()