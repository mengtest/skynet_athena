local shopproto = {}

shopproto.struct = [[
    .dealinfo {
        cfgid 0: string                     # 配置id        除蓝图外全部为int类型注意转换
        number 1: integer                   # 数量 
        price 2: integer                    # 单价      为氪金时1000表示1氪金   
        id 3: integer                       # 上架id             可能为nil 
        index 4: integer                    # 物品类别          仓库中类别序号
        puttime 5: integer                  # 上架时间          可能为nil
    }
    .putawayinfo {
        cfgid 0: string                     # 配置id        除蓝图外全部为int类型注意转换
        number 1: integer                   # 数量 
        price 2: integer                    # 单价      为氪金时1000表示1氪金   
        countdown 3: integer                # 倒计时           
        index 4: integer                    # 物品类别          仓库中类别序号
        state 5: boolean                    # 上架状态          false未上交易市场 
    }
    .marketpic {
        time 0: integer                     # 时间
        price 1: integer(2)                 # 价格
    }
    .transfer {
        cfgid 0: string                     # 配置id        除蓝图外全部为int类型注意转换
        number 1: integer                   # 数量 
        price 2: integer                    # 单价      为氪金时1000表示1氪金   
        index 3: integer                    # 物品类别          仓库中类别序号
        shoptime 4: integer                 # 购买日期
        shopid 5: integer                   # 购买id 
    }
    .marketdata {
        cfgid 0: integer                    # 配置id
        zeroprice 1: integer                # 零点价格
        minprice 2: integer                 # 最低价格
        maxprice 3: integer                 # 最高价格
        curprice 4: integer                 # 当前价格
    }
    .marketdatablue {
        cfgid 0: string                     # 配置id
        zeroprice 1: integer                # 零点价格
        curprice 2: integer                 # 当前价格
    }
    .transport {
        shopid 0: integer                   # 购买id 
    }
    .khoriumbuy {           
        id 0: integer                       # 上架id
        number 1: integer                   # 数量
    }
    .storedata {
        cfgid 0: integer                    # 配置id
        type 1: integer                     # 类型      仓库中类型
        price 2: integer                    # 原价
        iskh 3: integer                     # 是否氪金
        countdown 4: integer                # 下架倒计时        可能为nil
        saleprice 5: integer                # 特价              可能为nil
        id 6: integer                       # 商品id
    }
]]

-- 420 - 449

shopproto.c2s = shopproto.struct .. [[
    shop_dealinfo 420 {                                 # 交易市场列表请求
        request {
            beginindex 0: integer                       # 开始下标     目前先不传
            endindex 1: integer                         # 结束下标     目前先不传  
        }
		response {
            code 0: integer
            datainfos 1: *dealinfo
		}    
    }
    shop_putaway 421 {                                  # 上架物品
        request {
            index 0: integer                            # 仓库中类别序号
            cfgid 1: string                             # 配置id
            number 2: integer                           # 数量 默认为1
            price 3: integer                            # 单价   如果为氪金 转换成整数 如：1氪金传1000 可以为nil表示出售给系统
            isnew 4: boolean
        }
		response {
            code 0: integer
		} 
    }
    shop_khoriumbuy 422 {                               # 氪金购买物品       
        request {
            idandnum 0: *khoriumbuy
        }
        response {
            code 0: integer
        }
    }
    shop_goldbuy 423 {                                  # 金币购买物品
        request {
            index 0: integer                            # 仓库中类别序号
            cfgid 1: integer                            # 配置id
            number 2: integer                           # 数量 默认为1
            price 3: integer                            # 单价
        }
        response {
            code 0: integer
        }
    }
    shop_putawayinfo 424 {                              # 上架列表请求
        request {
        }
		response {
            code 0: integer
            datainfos 1: *putawayinfo
		}    
    }
    shop_marketpic 425 {                                # 行情折线图请求
        request {
        }
        response {
            code 0: integer
            datainfos 1: *marketpic
        }
    }
    shop_marketdatamate 426 {                           # 行情数据表请求材料
        request {
        }
        response {
            code 0: integer
            datainfos 1: *marketdata
        }
    }
    shop_matedetails 427 {                              # 材料详情折线图
        request {
            cfgid 0: integer                            # 配置id
            type 1: integer                             # 类型分类   1：一天的， 2：7天的每8小时一个数据， 3：30天的每8小时一个数据（最好定义枚举）
        }
        response {
            code 0: integer
            datainfos 1: *marketpic                     
        }
    }
    shop_bluedetails 428 {                              # 蓝图详情折线图
        request {
            cfgid 0: string                             # 配置id
            type 1: integer                             # 类型分类    
        }
        response {
            code 0: integer
            datainfos 1: *marketpic 
        }
    }
    shop_transfer 429 {                                 # 中转站请求
        request {
        }
        response {
            code 0: integer
            datainfos 1: *transfer
        }
    }
    shop_transport 430 {                                # 运输
        request {
            datainfos 0: *transport                     
        }
        response {
            code 0: integer
        }
    }
    shop_sell 431 {                                     # 出售
        request {
            shopid 0: integer                           # 购买id               
        }
        response {
            code 0: integer
        }
    }
    shop_curprice 432 {                                 # 获取通过金币出售物品当前价格
        request {
            index 0: integer                            # 仓库中类别序号
            cfgid 1: integer                            # 配置id
        }
        response {
            code 1: integer
            price 0: integer                            # 当前价格
        }
    }
    shop_marketdatablue 433 {                           # 行情数据表请求蓝图
        request {
        }
        response {
            code 0: integer
            datainfos 1: *marketdatablue
        }
    }
    shop_getstore 434 {                                  # 商城数据请求
        request {
            type 0: integer                              # 类型   1：超值礼包  2：限时特惠  3：礼包（最好定义枚举）
        }
        response {
            code 0: integer
            datainfos 1: *storedata
        }
    }
    shop_purchase 435 {                                  # 商城购买
        request {
            id 0: integer                                # 商品id
            type 1: integer                              # 类型   1：超值礼包  2：限时特惠  3：礼包（最好定义枚举）
            number 2: integer                            # 数量 默认为1
        }
        response {
            code 0: integer
        }
    }
]]
shopproto.s2c = shopproto.struct .. [[
]]
return shopproto