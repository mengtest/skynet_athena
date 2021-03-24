local CommonEntity = require "CommonEntity"

local EntityType = class("d_castinginfo", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_castinginfo"
end

return EntityType.new()