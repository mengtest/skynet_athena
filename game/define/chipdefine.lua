local chipdefine = {}

chipdefine.chiptype = enum {
    additional = 1,         --额外装配芯片
    attribute = 2,          --属性芯片
    twok = 3,               --2k芯片
    suit = 4,               --套装芯片
    skill = 5,              --主动技能芯片
    passkill = 6            --被动技能芯片
}
chipdefine.chiprarity = enum {
    white = 1,
    green = 2,
    yellow = 3
}

return chipdefine