--[[

 @file:       weapon_attribute.lua
 @source xls: excel_3D\Machine_Attribute.xlsx
 @sheet name: WEAPON_ATTRIBUTE
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local WEAPON_ATTRIBUTE = {
	["Weapon_Type"] = {Attribute_Name= "武器类型", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_16.athena_attribute_UI_icon_16'", },
	["Base_Damage"] = {Attribute_Name= "武器伤害", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_17.athena_attribute_UI_icon_17'", },
	["Damage_Rad"] = {Attribute_Name= "伤害半径", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_13.athena_attribute_UI_icon_13'", },
	["Damage_Reduce_Max"] = {Attribute_Name= "伤害递减", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_14.athena_attribute_UI_icon_14'", },
	["Power_Consume"] = {Attribute_Name= "能量消耗", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_10.athena_attribute_UI_icon_10'", },
	["InitialSpeedMax"] = {Attribute_Name= "射程参数", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_15.athena_attribute_UI_icon_15'", },
	["Explosion_Delay"] = {Attribute_Name= "爆炸延迟", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_08.athena_attribute_UI_icon_08'", },
};return WEAPON_ATTRIBUTE