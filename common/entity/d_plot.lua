local CommonEntity = require "CommonEntity"

local EntityType = class("d_plot", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_plot"
end

return EntityType.new()
