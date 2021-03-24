local battledefine = {}

battledefine.npcfreshtype = enum{
    perturn = 1,            -- 每回合
    perroll = 2,              -- 每轮转
    areatrigger = 3,             -- 区域触发
    once = 4,                  -- 一次性
    linkedlist = 5     -- 链式
}

battledefine.areacreatetype = enum{
    immediately = 1,          -- 触发后立即销毁
    last = 2                  -- 触发后持续存在
}

return battledefine