local CommonEntity = require "CommonEntity"

local EntityType = class("d_casting", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_casting"
end

return EntityType.new()