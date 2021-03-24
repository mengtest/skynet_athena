local CommonEntity = require "CommonEntity"

local EntityType = class("d_putawayinfo", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_putawayinfo"
end

return EntityType.new()
