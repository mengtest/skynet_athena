local CommonEntity = require "CommonEntity"

local EntityType = class("d_queueinfo", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_queueinfo"
end

return EntityType.new()