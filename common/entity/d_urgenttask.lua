local CommonEntity = require "CommonEntity"

local EntityType = class("d_urgenttask", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_urgenttask"
end

return EntityType.new()