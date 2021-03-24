local proto = {}

proto.struct = [[

]]

proto.c2s = proto.struct .. [[
	handshake_handshake 1 {
		request {
			msg 0  : string
		}
		response {
			code 0  : string
		}
	}
]]

-- handshake 1 {
-- 	request {
-- 		msg 0  : string
-- 	}
-- 	response {
-- 		code 0  : string
-- 	}
-- }

proto.s2c = proto.struct .. [[
	handshake_handshake 1 {
		request {
			msg 0  : string
		}
		response {
			msg 0  : string
		}
	}
]]

	-- handshake 1 {
	-- 	request {
	-- 		msg 0  : string
	-- 	}
	-- 	response {
	-- 		msg 0  : string
	-- 	}
	-- }

return proto
