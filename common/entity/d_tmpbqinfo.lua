local CommonEntity = require "CommonEntity"

local EntityType = class("d_tmpbqinfo", CommonEntity)

function EntityType:ctor()
	EntityType.super.ctor(self)
	self.tbname = "d_tmpbqinfo"
end

return EntityType.new()