local CommonEntity = require "CommonEntity"

local EntityType = class("d_putaway", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_putaway"
end

return EntityType.new()
