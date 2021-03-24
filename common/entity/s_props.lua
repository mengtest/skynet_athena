local CommonEntity = require "CommonEntity"

local EntityType = class("s_props", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "s_props"
end

return EntityType.new()