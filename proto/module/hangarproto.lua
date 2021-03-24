local hangarproto = {}

hangarproto.struct = [[
    .equipmentinfo {
        uniqueid 0:integer                  # 装备独一无二的id
        cfgid 1:integer                     # 配置表里的id
        lv 2: integer                       # 等级
        exp 3: integer                      # 经验
        islock 4: boolean                   # 是否锁定
        isnew 5: boolean                    # 是否为新
        state 6: integer                    # 状态 可能为nil 同仓库状态
    }
    .machineinitinfo {
        body 0: *equipmentinfo              # 机体信息
        chassis 1: *equipmentinfo           # 底盘信息
        firecontroller  2: *equipmentinfo   # 火控信息
        weapons 3: *equipmentinfo           # 武器信息
        isweld 4: boolean                   # 是否焊死
    }
    .showskillinfo {
        part 0: integer                     # 部位编号
        skillid 1: integer                  # 技能id
    }
]]

--机库[90-120)

hangarproto.c2s = hangarproto.struct .. [[
    hangar_changecfgindex 90 {
        request {
            defaultindex 0:integer                      # 希望改变的默认配置index
        }  
        response {
            code 0:integer
            machineinfo 1: machineinitinfo              # 改变的默认配置信息
        }
    }
    hangar_changeequip 91 {
        request {
            part 0:integer                              # 部位类型
            uniqueid 1: integer                         # 装备独一无二的id
            index 2: integer                            # 该部位的第几个
            isnew 3: boolean
        }  
        response {
            code 0: integer
            weapons 1: *integer                         # 返回最新的武器列表
        } 
    }
    hangar_returnteammatch 92 {
        request {
        }
    }
    hangar_setshow 96 {                                 # 设置展示
        request {
            defaultindex 0: integer                     # 当前默认配置
        }
        response {
            code 0: integer             
        }
    }
    hangar_clearshow 97 {                               # 取消展示
        request {
        }
        response {
            code 0: integer             
        }
    }
    hangar_changename 99 {
        request {
            name 0: string                              # 名称
        }  
        response {
            code 0: integer
        } 
    }
    hangar_selectskill 100 {                            # 选择技能
        request {
            part 0: integer                             # 部位编号
            skillid 1: integer                          # 技能id
        }
        response {
            code 0: integer
        }
    }
    hangar_showskill 101 {                              # 展示主动技能
        request {
        }
        response {
            showskillinfo 0: *showskillinfo             # 所有主动技能
            selectskill 1: showskillinfo                # 选择的主动技能
        }
    }
    hangar_setwelding 102 {                             # 焊死或解焊
        request {
            index 0: integer                            # 机体序号
        }
        response {
            code 0: integer
        }
    }
    hangar_setlockequip 103 {                           # 锁定部件
        request {
            part 0: integer                             # 编号
            uniqueid 1: integer                         # 唯一id
            isnew 2: boolean
        }
        response {
            code 0: integer
        }
    }
]]

hangarproto.s2c = hangarproto.struct .. [[
    hangar_machineinfo 93 {                             # 当前选中的机甲配置信息
        request {
            machineinfos 0:*machineinitinfo
            defaultindex 1:integer                      # 当前默认配置--当前选择的机甲
        }    
    }
    hangar_equipmentinfo 94 {                           # 当前已有的所有部位的装备
        request {
            part 0: integer                             # 部位类型
            equipmentinfo 1: *equipmentinfo             # 装备的具体信息
        }
    }
    hangar_ontmreturn 95 {
        request {
            playerid 0:integer                           # 玩家id
            machineinfo 1:machineinfo                    # 玩家更新后的机甲信息
        }
    }
    hargar_syncmachineinfo 98 {
        request {
            machineinfo 0: machineinitinfo               # 当前机甲升级情况, 同步经验用
        }
    }
]]

return hangarproto