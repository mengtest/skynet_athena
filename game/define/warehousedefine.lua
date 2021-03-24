local warehousedefine = {}

warehousedefine.warehousetype = enum {
    chassis = 1,
    body = 2,
    firecontroller = 3,
    weapon = 4,                 
    chip = 5,                         --芯片
    blueprint = 6,                    --蓝图
    material = 7,                     --材料
    prop = 8,                         --道具
    gold = 11,                        --金币
    bag = 13,                         --礼包
    package = 14,                     --包裹
}

warehousedefine.statetype = enum {
    equiping = 1,                    --装备中   
    locking = 2,                     --锁定中
    scaning = 3,                     --扫描中
    casting = 4,                     --铸造中
    ending = 5,                      --已完成
    welding = 6,                     --焊死
}

warehousedefine.shopindex = enum {
    oneday = 1,
    sevenday = 2,
    thirtyday = 3,
}

warehousedefine.storeindex = enum {
    sale = 1,
    special = 2,
    bag = 3,
}

warehousedefine.synctype = enum {
    gold = 1,
    khorium = 2
}
return warehousedefine