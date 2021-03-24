local CommonEntity = require "CommonEntity"

local EntityType = class("d_shopitem", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_shopitem"
end

return EntityType.new()
