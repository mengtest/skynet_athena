local teammatchdefine = {}

-- 房间类型
teammatchdefine.eroomtype = enum
{
 	one = 1,
 	two = 2,
	three = 3,
	ten = 10,
	fifty = 50,
	hundred = 100,
}

teammatchdefine.kickofftype = enum
{
	dissolve = 1,
	kickofff = 2
}

teammatchdefine.missiontype = enum
{
	pvp = 1,
	annihilate = 2,    -- 歼灭, 随机模式一进房间就战斗开始倒计时
	puzzle = 3,         -- 解谜
	climb = 4,        -- 攀爬
	survival = 5,      -- 生存
	excavate = 6,       -- 挖掘
	boss = 7,          -- boss战
	tutorial = 8,        -- 新手引导
	pve = 9
}


return teammatchdefine