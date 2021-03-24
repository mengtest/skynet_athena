local businessdefine = {}


-- 队列类型
businessdefine.businessType = enum{
    airfreighter = 1,  -- 运输机
    scan = 2,          -- 扫描 
    cast = 3           -- 铸造
}


businessdefine.indextype = enum {
    battle = 1,                                        -- 战斗奖励
    transfer = 2,                                      -- 中转站运输
}

return businessdefine