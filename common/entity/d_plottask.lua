local CommonEntity = require "CommonEntity"

local EntityType = class("d_plottask", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_plottask"
end

return EntityType.new()