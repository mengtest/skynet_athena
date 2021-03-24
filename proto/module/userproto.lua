local userproto = {}

userproto.struct = [[
]]

--190 - 209

userproto.c2s = userproto.struct .. [[
    user_changename 190 {                   # 修改名称
        request {
            name 0: string                
        }
		response {
            code 0: integer
		}    
    }
    user_changeimg 191 {                    # 修改头像
        request {
            imgcfgid 0: integer             # 头像配置表id
        }
		response {
            code 0: integer
		}    
    }
    user_changedes 192 {                    # 修改介绍
        request {
            des 0: string                   # 介绍
        }
		response {
            code 0: integer
		}    
    }
    user_logout 194 {
        request {
        }     
    }
    user_gettime 196 {
        request {
        } 
        response {
            curtime 0: integer              # 当前时间戳
        }
    }
]]
userproto.s2c = userproto.struct .. [[
    user_updateexp 193 {                    # 更新经验
        request {
            level 0: integer
            exp 1: integer
        }
    }
    user_kick 195 {                         # 账号退出信息
        request {
            code 0: integer
        }     
    }
]]
return userproto