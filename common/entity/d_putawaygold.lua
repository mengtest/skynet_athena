local CommonEntity = require "CommonEntity"

local EntityType = class("d_putawaygold", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_putawaygold"
end

return EntityType.new()
