local UserSingleEntity = require "UserSingleEntity"

local EntityType = class("d_khorium", UserSingleEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_khorium"
end

return EntityType.new()