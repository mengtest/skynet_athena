local CommonEntity = require "CommonEntity"

local EntityType = class("s_bags", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "s_bags"
end

return EntityType.new()