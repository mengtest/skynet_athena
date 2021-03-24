local CommonEntity = require "CommonEntity"

local EntityType = class("d_athletics", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_athletics"
end

return EntityType.new()
