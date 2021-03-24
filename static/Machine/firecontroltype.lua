--[[

 @file:       firecontroltype.lua
 @source xls: excel_3D\FireControl.xlsx
 @sheet name: FIRECONTROLTYPE
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local FIRECONTROLTYPE = {
	[10001] = {Fire_Contro_Type_Name= "突击", Weapon_Type= {10001, 10006, 10008, 10009, }, },
	[10002] = {Fire_Contro_Type_Name= "速攻", Weapon_Type= {10001, 10006, 10008, 10009, }, },
	[10003] = {Fire_Contro_Type_Name= "远攻", Weapon_Type= {10001, 10006, 10008, 10009, }, },
	[10004] = {Fire_Contro_Type_Name= "抛射", Weapon_Type= {10001, 10005, }, },
	[10005] = {Fire_Contro_Type_Name= "狙击", Weapon_Type = {}, },
	[10006] = {Fire_Contro_Type_Name= "雷达", Weapon_Type = {}, },
	[10007] = {Fire_Contro_Type_Name= "远攻", Weapon_Type = {}, },
	[10008] = {Fire_Contro_Type_Name= "近战", Weapon_Type= {10001, 10006, 10008, 10009, }, },
	[90002] = {Fire_Contro_Type_Name= "", Weapon_Type= {10001, }, },
};return FIRECONTROLTYPE