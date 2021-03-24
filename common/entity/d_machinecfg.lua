local CommonEntity = require "CommonEntity"

local EntityType = class("d_machinecfg", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_machinecfg"
end

return EntityType.new()