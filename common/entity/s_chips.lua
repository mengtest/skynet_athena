local CommonEntity = require "CommonEntity"

local EntityType = class("s_chips", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "s_chips"
end

return EntityType.new()