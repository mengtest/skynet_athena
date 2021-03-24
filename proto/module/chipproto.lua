local chipproto = {}

chipproto.struct = [[
    .chipinfo {                      # 芯片信息
        id 0: integer                # 芯片id
        number 1: integer            # 芯片数量
        level 2: integer             # 芯片等级
        isnew 3: boolean
    }
    .inchipinfo {
        id 0: integer                # 芯片id
        level 1: integer             # 芯片等级
        record 2: integer            # 装备位置 个位：部位类型，其他位：装备id
    }
    .slotinfo {                      # 槽位信息   
        id 0: integer                # 装备的芯片id  可能为nil表示此槽位没有芯片
        ispola 1: boolean            # 是否已极化   可能为nil表示未极化
        typepola 2: integer          # 极化类型   可能为nil
        index 3: integer             # 槽位编号
        level 4: integer             # 等级         可能为nil
    }
    .equipinfo {
        lv 0: integer                # 等级
        isweld 1: boolean            # 是否焊死  true表示焊死
        isdouble 2: boolean          # 是否已使用反应堆  
        volume 3: integer            # 容量
        currentvolume 4: integer     # 已使用容量
        count 5: integer             # 极化次数
        cfgid 6: integer             # 配置表中id
    }
    .decompose {
        id 0: integer                # 芯片id
        level 1: integer             # 当前等级
        isequip 2: boolean           # 是否已装备 true表示已装备 如果未装备后面字段可不用传递
        record 3: integer            # 装备独一无二的id + 部位类型（已装备的部位信息）
        number 4: integer            # 数量 不传默认为1
        isnew 5: boolean
        islock 6: boolean
    }
]]

-- 210 - 239 

chipproto.c2s = chipproto.struct .. [[
    chip_remove 211 {                                # 卸下芯片
        request {
            id 0: integer                            # 芯片id
            uniqueidpart 1: integer                  # 装备独一无二的id + 部位类型
            islock 2: boolean
        }
        response {
            code 0: integer
        }
    }
    chip_add 212 {                                   # 装备芯片
        request {
            id 0: integer                            # 芯片id
            uniqueidpart 1: integer                  # 装备独一无二的id + 部位类型（装备部位信息）
            index 2: integer                         # 槽位编号
            level 3: integer                         # 芯片等级
            state 4: boolean                         # 芯片状态 true表示未装备 则后面参数写0或不传递
            record 5: integer                        # 装备独一无二的id + 部位类型（已装备的部位信息）
            isnew 6: boolean
            islock 7: boolean
        }
        response {
            code 0: integer
        }
    }
    chip_double 213 {                                # 使用反应堆
        request {   
            uniqueid 0: integer                      # 装备独一无二的id
            part 1: integer                          # 部位类型
        }
        response {
            code 0: integer         
        }
    }
    chip_slotpola 214 {                              # 槽位极化
        request {
            uniqueid 0: integer                      # 装备独一无二的id
            part 1: integer                          # 部位类型
            index 2: integer                         # 槽位编号
            typepola 3: integer                      # 极化类型
        }
        response {
            code 0: integer                 
        }
    }
    chip_upgrade 215 {                               # 芯片升级
        request {
            id 0: integer                            # 芯片id
            level 1: integer                         # 当前等级
            isequip 2: boolean                       # 是否已装备 true表示已装备 如果未装备后面字段可不用传递
            record 3: integer                        # 装备独一无二的id + 部位类型（已装备的部位信息）
            number 4: integer                        # 升级数量 不传默认为1
            isnew 5: boolean
            islock 6: boolean
        }
        response {
            code 0: integer                          
        }
    }
    chip_equipinfo 218 {                             # 获取部件详细信息
        request {
            uniqueidpart 0: integer                  # 装备独一无二的id + 部位类型
        }
        response {
            code 0: integer 
            equipinfo 1: equipinfo                   # 部件详细信息
        }
    }
    chip_getequipchip 219 {                          # 获取可装备芯片信息
        request {
            uniqueidpart 0: integer                  # 装备独一无二的id + 部位类型
        }
        response {
            code 0: integer 
            chiparray 1: *chipinfo                   # 可装备芯片集合
            inchipinfo 2: *inchipinfo                # 已装备芯片集合
        }
    }
    chip_getslotinfo 220 {                           # 获取部件的槽位信息
        request {
            uniqueidpart 0: integer                  # 装备独一无二的id + 部位类型
        }
        response {
            code 0: integer
            inchipinfo 1: *slotinfo                  # 槽位集合
        }
    }
    chip_decompose 221 {                             # 分解芯片
        request {
            chipinfo 0: *decompose                   # 分解的芯片信息集合
        }
        response {
            code 0: integer
            number 1: integer                        # 获得的内融核心数量
        }
    }
    chip_composition 210 {                           # 合成芯片
        request {
            chipinfo 0: *decompose                   # 要合成的芯片信息集合
        }
        response {
            code 0: integer
            chipid 1: integer                        # 合成的芯片id 
        }
    }
    chip_sell 216 {                                  # 出售芯片
        request {
            chipinfo 0: *decompose                   # 出售的芯片信息集合
        }
        response {
            code 0: integer
            number 1: integer                        # 获得的金币数量
        }
    }
    chip_setlockchip 217 {                           # 锁定芯片
        request {
            cfgid 0: integer                         # 配置id
            islock 1: boolean                        # 原始状态是否为锁定【不是要改变的状态】
            isnew 2: boolean                         # 是否为新
            record 3: integer                        # 装备位置   不是已装备则为nil
        }
        response {
            code 0: integer
        }
    }
]]

chipproto.s2c = chipproto.struct .. [[
]]

return chipproto
