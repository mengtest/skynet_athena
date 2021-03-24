--[[

 @file:       weapontype.lua
 @source xls: excel_3D\Weapontable.xlsx
 @sheet name: WEAPONTYPE
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local WEAPONTYPE = {
	[10001] = {Weapon_Name= "railgun", Weapon_Type= "轨道炮", if_melee=0, },
	[10002] = {Weapon_Name= "firebomb", Weapon_Type= "燃烧弹", if_melee=0, },
	[10003] = {Weapon_Name= "sniper", Weapon_Type= "狙击", if_melee=0, },
	[10004] = {Weapon_Name= "satellitegun", Weapon_Type= "卫星炮", if_melee=0, },
	[10005] = {Weapon_Name= "cannon", Weapon_Type= "激光炮", if_melee=0, },
	[10006] = {Weapon_Name= "melee", Weapon_Type= "近战", if_melee=1, },
	[10007] = {Weapon_Name= "skill", Weapon_Type= "技能", if_melee=0, },
	[10008] = {Weapon_Name= "flamethrower", Weapon_Type= "喷火器", if_melee=0, },
	[10009] = {Weapon_Name= "", Weapon_Type= "钻头", if_melee=1, },
	[10010] = {Weapon_Name= "", Weapon_Type= "机枪", if_melee=0, },
};return WEAPONTYPE