local businessproto = {}

businessproto.struct = [[
    .propreward {
        cfgid 0: integer                           # 配置表id  
        lv 1: integer                               # 等级          0表示无
        number 2: integer                            # 数量
        type 3: integer                             # 类型, 材料还是芯片
    }
    .bpreward {
        cfgid 0: string                           # 配置表id  
        number 1: integer                            # 数量
    }

    .rewardsync {
        cfgid 0: integer                           # 配置表id  
        number 1: integer                            # 数量
    }

    .equipreward {
        cfgid 0:integer   # 配置表里的id
        lv 1: integer   # 等级
        exp 2: integer     # 经验
        part 3: integer    # 部位
    }

    .businessqueueinfo {
        id 0 : integer	#流水id
        type 1 : integer #类型
        subtype 2 : integer #子类型
        starttime 3 : integer #开始时间
        endtime 4 : integer #当前结束时间
        initendtime 5 : integer #结束时间(初始)
        bprewardlist 6 : *bpreward # 奖励蓝图列表
        proprewardlist 7 : *propreward # 奖励材料列表
        equiplist 8 : *equipreward # 奖励装备列表
        index 9 :  integer                                              # 类型可能为nil 1：战斗奖励  2：中转站运输 【最好枚举】
    }

    .bqsimpleinfo {
        bqid 0: integer    #队列id
        endtime 1: integer    #结束时间
    }

    .airfreighterinfo {
        bqinfos 0: *bqsimpleinfo   #该运输机队列的所有队列包
    }
]]

businessproto.c2s = businessproto.struct .. [[
    bqproxy_onlined 350 {  # 服务端收到这条时，从数据库拉起队列
        request {
        }
    }

    bqproxy_getbqinfo 353 {
        request {
            bqid 0: integer
        }
        response {
            code 0: integer
            businessqueueinfo 1: businessqueueinfo
        }
    }

    bqproxy_removebq 354 {
        request {
            bqid 0: integer
        }
        response {
            code 0: integer
        }
    }

]]

businessproto.s2c = businessproto.struct .. [[
    bqproxy_initbqinfo 351 {
        request {
            airfreighterinfo 0: *airfreighterinfo
        }
    }

	bqproxy_onbqfinished 352 {           # 侧边栏推送通知用
		request {
            bqindex 0: integer      #第几个队列 123
            rawid 1:integer          # 队列表中的id, 非tmpbqinfo表
            bprewardlist 2: *bpreward  #奖励蓝图列表
            proprewardlist 3: *rewardsync   #奖励材料列表
            equiplist 4: *equipreward    #奖励装备列表
		}
    }
]]

return businessproto

-- bqproxy_bqinit 351 {
--     request {
--         bqindex 0: integer      #第几个队列 123
--         bprewardlist 1: *bpreward  #奖励蓝图列表
--         proprewardlist 2: *rewardsync   #奖励材料列表
--         equiplist 3: *rewardsync    #奖励装备列表
--     }
--     response {
        
--     }
-- }