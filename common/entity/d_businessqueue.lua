local CommonEntity = require "CommonEntity"

local EntityType = class("d_businessqueue", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_businessqueue"
end

return EntityType.new()