local achieveproto = {}

achieveproto.struct = [[
    .achieveinfo {
        id 0: integer                           # 成就id
        isget 1: boolean                        # 是否领取
        finishtime 2: integer                   # 完成时间
        typeid 3: integer                       # 成就类型id
        count 4: integer                        # 当前值
    }
    .achievefinish {
        id 0: integer                           # 成就id
        finishtime 1: integer                   # 完成时间
    }
    .overviewinfo {
        plotnum 0: integer                      # 剧情数量
        athleticsnum 1: integer                 # 竞技数量
        challengenum 2: integer                 # 挑战数量
        achievelist 3: *achievefinish           # 最新完成成就记录
    }
]]

-- 390 - 419		-- 30条	

achieveproto.c2s = achieveproto.struct .. [[
	achievement_getoverview 390 {                               # 获取总览数据
		request {
		}
		response {
            overviewinfo 0: overviewinfo
		}
    }
    achievement_receiveachieve 391 {                            # 领取成就奖励
        request {
            typeid 0: integer                                   # 成就类型id           
            id 1: integer                                       # 成就id
            index 2: integer                                    # 编号
        }
        response {
            code 0: integer
        }
    }
    achievement_clickachieve 392 {                              # 列表请求
        request {
            index 0: integer                                    # 编号
        }
        response {
            code 0: integer
            achieveinfos 1: *achieveinfo
        }
    }
]]


achieveproto.s2c = achieveproto.struct .. [[
]]


return achieveproto
