-- --------------------------------------
-- Create Date:2018-07-13 10:51:50
-- Author  : Happy Su
-- Version : 1.0
-- Filename: baseattributeid.lua
-- Introduce  : 类介绍
-- --------------------------------------

-- 各种属性计算的基础值，一般来源于建筑
local baseAttributeID = enum {
    march_queue_num = 1,-- 行军队列增加（定值）
    puppet_capacity = 2, -- 傀儡容量（定值）
    embassy_capacity = 3, -- 大使馆容量(防御集结量)
    res_transport_volume = 4, -- 306	资源运输量
    res_transport_tax = 5, -- 307	运输税收
    marchingnum = 6, -- 出征部队数量
    train_num = 7, -- 训练量
    warhall_capacity = 8, -- 集结部队数量(攻击集结量)
    medical_tent_capacity = 9, -- 伤兵容量
    store_normalres_capacity = 10, -- 仓库保护量
    store_gold_capacity = 11, -- 仓库金币保护量
    citywall_life = 12, -- 城墙耐久
    puppet_produce = 13, -- 傀儡单次制造数量
    alliance_help_count = 14, -- 联盟帮助次数
    prison_att = 15, -- 监狱是否有属性加层
    elite_capacity = 16, -- 精锐兵容量
}
return baseAttributeID