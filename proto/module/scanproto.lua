local scanproto = {}

scanproto.struct = [[
    .castinginfo {                   # 铸造信息     可能为空
        id 0: string                 # 蓝图id
        state 1: boolean             # 状态   true表示已完成
        bqid 2: integer              # 队列id/领取奖励id       state为true表示领取奖励id否则为队列id
        begintime 3: integer         # 已完成则为空 下同
        endtime 4: integer
    }
    .scaninfo {                      # 扫描信息     可能为空
        id 0: integer                # 机甲id
        state 1: boolean             # 状态   true表示已完成
        bqid 2: integer              # 队列id/领取奖励id       state为true表示领取奖励id否则为队列id
        begintime 3: integer
        endtime 4: integer
    }
]]

-- 240 - 269

scanproto.c2s = scanproto.struct .. [[
    scan_scan 241 {                                 # 扫描
        request {
            uniqueid 0: integer                     # 机甲id
        }
        response {
            code 0: integer
            bqid 1: integer                         # 扫描队列id    
            countdown 2: integer                    # 倒计时
        }
    }
    scan_casting 242 {                              # 铸造
        request {
            cfgid 0: string                         # 蓝图id
            number 1: integer                       # 数量 不传默认为1
            name 2: string                          # 无则传nil
            isnew 3: boolean
        }
        response {
            code 0: integer      
            bqid 1: integer                         # 铸造队列id                    
            countdown 2: integer                    # 倒计时
            blueprintid 3: integer                  # 蓝图id
        }
    }
    scan_cancelcasting 243 {                        # 取消铸造
        request {
            bqid 0: integer                         # 队列id 
        }
        response {
            code 0: integer
            bqid 1: integer                         # 队列id
            blueprintid 2: integer                  # 蓝图id
            nofinish 3: integer                     # 未完成数量
        }
    }
    scan_receivecasting 244 {                       # 领取铸造
        request {
            awardid 0: integer                      # 领取奖励id
        }
        response {
            code 0: integer
            awardid 1: integer  
        }
    }
    scan_addcasting 246 {                           # 增加铸造位
        request {
            num 0: integer                          # 铸造位增加数量 默认不传为1
        }   
        response {
            code 0: integer 
        }
    }
    scan_addblueprint 247 {                         # 增加蓝图
        request {
            id 0: string                            # 蓝图id
            number 1:integer                        # 数量
        }
        response {
            code 0: integer
        }
    }
    scan_addspeed 248 {                             # 加速
        request {
            bqid 0: integer                         # 队列id
            time 1: integer                         # 以分钟为单位， 1表示加速一分钟， 60表示加速1小时
            propid 2: integer                       # 道具id
        }
        response {
            code 0: integer
            countdown 1: integer                    # 倒计时
        }
    }
    scan_receivescan 249 {                          # 领取扫描
        request {
            awardid 0: integer                      # 领取奖励id
        }
        response {
            code 0: integer 
        }
    }
    scan_receiveallcast 245 {                       # 一键领取铸造  领取所有成功的，失败的统计数量并返回
        request {
        }
        response {
            code 0: integer                         
            number 1 : integer                      # 错误数量  0表示全部正确
        }
    }
]]

scanproto.s2c = scanproto.struct .. [[
    scan_finishcasting 250 {                         # 铸造完成
        request {
            id 0: string                             # 蓝图id
            bqid 1: integer                          # 队列id
            awardid 2: integer                       # 领取奖励id
        }
    }
    scan_finishscan 251 {                            # 扫描完成
        request {
            id 0: integer                            # 机体id
            bqid 1: integer                          # 队列id
            awardid 2: integer                       # 领取奖励id
        }
    }
    scan_scanandcasting 240 {
        request {
            scaninfo 0: *scaninfo                    # 扫描信息 包括扫描完成和扫描中
            castinginfo 1: *castinginfo              # 铸造信息 同上
        }
    }
]]

return scanproto