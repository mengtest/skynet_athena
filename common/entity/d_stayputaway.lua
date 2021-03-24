local CommonEntity = require "CommonEntity"

local EntityType = class("d_stayputaway", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_stayputaway"
end

return EntityType.new()
