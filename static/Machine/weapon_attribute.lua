--[[

 @file:       weapon_attribute.lua
 @source xls: excel_3D\Machine_Attribute.xlsx
 @sheet name: WEAPON_ATTRIBUTE
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local WEAPON_ATTRIBUTE = {
	["Weapon_Type"] = {Attribute_Name= "武器类型", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_castingsystem_UI_attack_01.athena_castingsystem_UI_attack_01'", },
	["Base_Damage"] = {Attribute_Name= "武器伤害", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_castingsystem_UI_hurt_01.athena_castingsystem_UI_hurt_01'", },
	["Damage_Rad"] = {Attribute_Name= "伤害半径", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_castingsystem_UI_radius_01.athena_castingsystem_UI_radius_01'", },
	["Damage_Reduce_Max"] = {Attribute_Name= "伤害递减", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_castingsystem_UI_attenuation_01.athena_castingsystem_UI_attenuation_01'", },
	["Power_Consume"] = {Attribute_Name= "能量消耗", Image1= "", },
	["InitialSpeedMax"] = {Attribute_Name= "射程参数", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_castingsystem_UI_speed_01.athena_castingsystem_UI_speed_01'", },
	["Explosion_Delay"] = {Attribute_Name= "爆炸延迟", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_castingsystem_UI_blast_01.athena_castingsystem_UI_blast_01'", },
};return WEAPON_ATTRIBUTE