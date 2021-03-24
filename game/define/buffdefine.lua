local buffdefine = {}

buffdefine.bufftype = enum {
    scopeskill = 10005,             --技能范围
    intensityskill = 10006,         --技能强度
    persistskill = 10007,           --技能持续
    life = 10008,                   --生命值
    shield = 10009,                 --护盾容量
    energy = 10010,                 --能量                 
    atk = 10011,                    --攻击力                 变   武器变化影响属性下同
    scopeatk = 10012,               --伤害范围               变   
    distance = 10013,               --攻击距离参数修改        变  
    elevation = 10014,              --仰角                   变
    overhang = 10015,               --俯角                   变
    enefficiency = 10016,           --能量效率               变
    speed = 10017,                  --回合速度参数            
    efficiency = 10018,             --引擎效率            移动
    climbingangle = 10019,          --底盘爬角              
}

buffdefine.bufftypekey = enum {
    [buffdefine.bufftype.scopeskill] = "scopeskill",             --技能范围
    [buffdefine.bufftype.intensityskill] = "intensityskill",         --技能强度
    [buffdefine.bufftype.persistskill] = "persistskill",           --技能持续
    [buffdefine.bufftype.life] = "life",                   --生命值
    [buffdefine.bufftype.shield] = "shield",                 --护盾容量
    [buffdefine.bufftype.energy] = "energy",                 --能量
    [buffdefine.bufftype.atk] = "atk",                    --攻击力
    [buffdefine.bufftype.scopeatk] = "scopeatk",               --伤害范围
    [buffdefine.bufftype.distance] = "distance",               --攻击距离参数修改
    [buffdefine.bufftype.elevation] = "elevation",              --仰角
    [buffdefine.bufftype.overhang] = "overhang",               --俯角
    [buffdefine.bufftype.enefficiency] = "enefficiency",           --能量效率
    [buffdefine.bufftype.speed] = "speed",                  --回合速度参数
    [buffdefine.bufftype.efficiency] = "efficiency",             --引擎效率
    [buffdefine.bufftype.climbingangle] = "climbingangle",          --底盘爬角
}

buffdefine.battlebufftype = enum {
    unoverlay = 1,  -- 不可叠加，再次对拥有状态机甲释放状态无效；
    extend = 2,   -- 不可叠加，再次对拥有状态机甲重置状态总持续回合长度；
    overlaymult = 3,    -- 可叠加，每一层状态伤害与轮转分别计算；
    overlaysingle = 4,    -- 可叠加，每次对拥有状态机甲释放相同状态，层数增加1，重置总持续回合长度；
    switch = 5    -- 开关类状态
}

return buffdefine