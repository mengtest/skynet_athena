local CommonEntity = require "CommonEntity"

local EntityType = class("d_daytask", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_daytask"
end

return EntityType.new()