local warehouseproto = {}

warehouseproto.struct = [[
    .propinfo {                                     
        id 0: integer                               # 唯一id        0表示无
        number 1: integer                           # 数量
        lv 2: integer                               # 等级          0表示无
        state 3: integer                            # 状态
        cfgid 4: integer                            # 配置表id      0表示无
        isnew 5: boolean                            # 是否为新      true为新
        islock 6: boolean                           # 是否锁定      可能为nil
        exp 7: integer                              # 经验          可能为nil
        record 8: integer                           # 装备位置      可能为nil    个位：部位类型，其他位：装备id
    }
    .blueprintinfo {
        id 0: string                                # id            长度超过6 表示合成蓝图
        number 1: integer                           # 数量
        state 2: integer                            # 状态               为0 下面3个字段全为nil
        bqid 3: integer                             # 队列id/领取奖励id       state影响
        countdown 4: integer                        # 倒计时        可能为nil   下同
        totaltime 5: integer                        # 总时间
        name 6: string                              # 可能为空
        isnew 7: boolean                            # 是否为新      true为新
    }
    .messageinfo {                                     
        id 0: integer                               # 唯一id        0表示无
        number 1: integer                           # 数量
        lv 2: integer                               # 等级          0表示无
        index 3: integer                            # 列表编号
        cfgid 4: integer                            # 配置表id      0表示无
    }
    .machinecfginfo {                                     
        id 0: integer                               # 唯一id        0表示无
        body 1: *equipmentinfo                      # 机体信息
        chassis 2: *equipmentinfo                   # 底盘信息
        firecontroller 3: *equipmentinfo            # 火控信息
        weapons 4: *equipmentinfo                   # 武器信息
        name 6: string              
    }
]]

 -- 270 - 299

warehouseproto.c2s = warehouseproto.struct .. [[
    warehouse_clicklist 270 {                            # 列表请求数据
        request {
            index 0: integer                             # 列表编号
            beginindex 1: integer                        # 开始位置  1 
            endindex 2: integer                          # 结束位置  10 请求10个数据
        }
        response {
            code 0: integer
            propinfos 1: *propinfo
        }
    }
    warehouse_addequip 271 {
        request {
            cfgid 0:integer                              # 配置表id
            number 1:integer                             # 数量
            part 2:integer                               # 部位编号
        }
        response {
            code 0: integer
        }
    }
    warehouse_clickblueprint 272 {                       # 蓝图列表请求数据
        request {
            beginindex 0: integer                        # 开始位置  1 
            endindex 1: integer                          # 结束位置  10 请求10个数据
        }
        response {
            code 0: integer
            propinfos 1: *blueprintinfo
        }
    }
    warehouse_updatenew 273 {                            # 更新数据(将新数据标为已读)
        request {
            index 0: integer                             # 列表编号
            beginindex 1: integer                        # 开始位置  1 
            endindex 2: integer                          # 结束位置  10 更新10个数据
        }
        response {
            code 0: integer
        }
    }
    warehouse_getblueprint 274 {                         # 仓库蓝图请求 不包括铸造中蓝图
        request {
            beginindex 0: integer                        # 开始位置  1 
            endindex 1: integer                          # 结束位置  10 请求10个数据
        }
        response {
            code 0: integer
            propinfos 1: *blueprintinfo
        }
    }
]]

warehouseproto.s2c = warehouseproto.struct .. [[
    warehouse_sync 275 {                                # 同步金币/氪金
        request {
            index 0: integer                            # 类型
            curnum 1: integer                           # 当前数量 如果为氪金 1000表示1元【显示时注意转换】
        }
    }
    warehouse_addbp 276 {                               # 添加的蓝图信息
        request {
            propinfo 0: *blueprintinfo
        }
    }
    warehouse_rembp 277 {                               # 移除的蓝图信息
        request {
            propinfo 0: *blueprintinfo
        }
    }
    warehouse_addmessage 278 {                          # 添加信息
        request {
            propinfo 0: *messageinfo
        }
    }
    warehouse_remmessage 279 {                          # 移除信息
        request {
            propinfo 0: *messageinfo
        }
    }
    warehouse_updatescore 280 {                         # 积分更新
        request {
            score 0: integer
        }
    }   
    warehouse_addmachinecfg 281 {                       # 添加机体
        request {
            propinfo 0: machinecfginfo
        }
    }
]]

return warehouseproto