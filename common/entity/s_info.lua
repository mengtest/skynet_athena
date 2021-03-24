local CommonEntity = require "CommonEntity"

local EntityType = class("s_info", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "s_info"
end

return EntityType.new()