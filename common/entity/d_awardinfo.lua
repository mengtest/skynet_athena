local CommonEntity = require "CommonEntity"

local EntityType = class("d_awardinfo", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_awardinfo"
end

return EntityType.new()