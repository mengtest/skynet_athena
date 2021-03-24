local CommonEntity = require "CommonEntity"

local EntityType = class("d_chipattribute", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_chipattribute"
end

return EntityType.new()