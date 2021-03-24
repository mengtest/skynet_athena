local playerproto = {}

playerproto.struct = [[
    .equipment {
        cfgid 0: integer                            # 配置表id
        lv 1: integer                               # 等级
    }
    .show {                                         # 机甲配置表信息
        name 0: string                              # 机甲名称
        body 1: *equipment                          # 机体信息
        chassis 2: *equipment                       # 底盘信息
        firecontroller 3: *equipment                # 火控信息
        weapons 4: *equipment                       # 武器信息
    }
    .userinfo {                                     # 用户信息
        uid 0:integer                               # 用户id
        name 1:string                               # 名称
        level 2:integer                             # 段位
        exp 3:integer                               # 经验
        imgcfgid 4: integer                         # 头像配置表id
        score 5: integer                            # 积分
        gold 6: integer                             # 金币
        khorium 7: integer                          # 氪金 1000表示1元【显示时注意转换】
        daytime 8: integer                          # 一天中已在线时间
        age 9: integer                              # 年龄
    }
    .scoreinfo {                                    # 排名按照下标 例：下标1 表示第一名
        uid 0:integer                               # 用户id
        score 1:integer                             # 用户分数
        name 2:string                               # 用户名
    }
    .personaldata {
        uid 0:integer                               # 用户id
        name 1:string                               # 名称
        level 2:integer                             # 段位
        imgcfgid 3: integer                         # 头像配置表id
        ladder 4: integer                           # 排名
        description 5: string                       # 介绍
        showid 6: integer                           # 展示机甲表id   可能为空
        showname 7: string                          # 展示机甲名称   可能为空
    }
    .record {
        winrate 0: integer                          # 胜率    10  表示为10%
        supportnum 1: integer                       # 队友点赞数
        checkpoint 2: integer                       # 关卡进度
        score 3: integer                            # 积分
        rtime 4:integer                             # 注册时间
        onlinetime 5:integer                        # 在线时间           时间都为时间戳
    }
    .fieldguide {
        part 0: integer                             # 部位编号
        currentnum 1: integer                       # 当前数量
        maxnumber 2: integer                        # 总数
    }
    .achievement {
                                                    # 待完善
    }
]]
--170 - 189 

playerproto.c2s = playerproto.struct .. [[
    player_getplayerladder 171 {                        # 获得玩家排行
        request {
        }
        response {
            code 0:integer
            index 1:integer                             # 玩家当前排名
        }
    }
    player_getladder 172 {                              # 获取某区间排行信息
        request { 
            beginindex 0: integer                       # 开始位置  1 第一名
            endindex 1: integer                         # 结束位置  10 到第10名
        }
        response {
            code 0:integer                              
            data 1:*scoreinfo                           # 玩家排行信息
        }
    }
    player_setscore 173 {
        request {
            number 0:integer                            # 增值
        }
        response {
            code 0:integer
            index 1:integer                             # 玩家当前排名
        }
    }
    player_personaldata 174 {                             # 个人资料
        request {         
            uid 0: integer        
        }
        response {
            code 0: integer
            userinfo 1: personaldata
        }
    }
    player_record 175 {                                   # 战绩信息
        request {                 
            uid 0: integer
        }
        response {
            code 0: integer
            userinfo 1: record
        }
    }
    player_fieldguide 176 {                               # 图鉴信息
        request {               
            uid 0: integer  
        }
        response {
            code 0: integer
            userinfo 1: *fieldguide
        }
    }
    player_achievement 177 {                              # 成就信息
        request {         
            uid 0: integer         
        }
        response {
            code 0: integer
            userinfo 1: achievement
        }
    }
    player_getshow 178 {                              # 获取展示机甲信息
        request {
            showid 0: integer              
        }             
        response {
            code 0: integer
            userinfo 1: show
        }
    }
]]
playerproto.s2c = playerproto.struct .. [[
    player_userinfo 170 {             
        request {
            userinfo 0 : userinfo
        }
    }
]]
return playerproto