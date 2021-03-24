local CommonEntity = require "CommonEntity"

local EntityType = class("d_score", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_score"
end

return EntityType.new()
