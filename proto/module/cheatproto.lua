local cheatproto = {}

cheatproto.struct = [[
]]

-- 300 - 349

cheatproto.c2s = cheatproto.struct .. [[
    cheat_addequip 300 {                        # 增加武器
        request {
            cfgid 0: integer                    # 配置表id
            number 1: integer                   # 数量
            part 2: integer                     # 部位
        }
        response {
            code 0: integer
        }
    }
    cheat_addchip 301 {                         # 增加芯片
        request {
            id 0: integer                       # 芯片id
            number 1: integer                   # 数量
            level 2: integer                    # 等级
        }
        response {
            code 0: integer
        }
    }
    cheat_setscore 302 {                        # 增加分数
        request {           
            number 0: integer                   # 增加数值
        }
        response {
            code 0:integer
            index 1:integer                     # 玩家当前排名
        }
    }
    cheat_cheatinterface 303 {                  # 增加物品
        request {           
            strcode 0:string                    # "c_ch"全部芯片  "e_ch"全部底盘  "e_bo"全部机体  "e_fi"全部火控 "e_we"全部武器  "b_bl"全部蓝图  "s_sc"增加分数 "a_kh"氪金  "a_go"金币 
        }
        response {
            code 0:integer
        }
    }
    cheat_addblueprint 304 {                    # 增加蓝图
        request {           
            id 0: integer                       # 蓝图id
            number 1: integer                   # 数量
        }
        response {
            code 0:integer
        }
    }
    cheat_addmaterial 305 {                     # 增加材料
        request {           
            id 0: integer                       # 材料id
            number 1: integer                   # 数量
        }
        response {
            code 0:integer
        }
    }
]]
cheatproto.s2c = cheatproto.struct .. [[
]]
return cheatproto