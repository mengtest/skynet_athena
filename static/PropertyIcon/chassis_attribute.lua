--[[

 @file:       chassis_attribute.lua
 @source xls: excel_3D\Machine_Attribute.xlsx
 @sheet name: CHASSIS_ATTRIBUTE
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local CHASSIS_ATTRIBUTE = {
	["Speed_X"] = {Attribute_Name= "移动速度", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_19.athena_attribute_UI_icon_19'", },
	["Round_Speed"] = {Attribute_Name= "预加载性能", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_21.athena_attribute_UI_icon_21'", },
	["Chassis_Creeping_Angle"] = {Attribute_Name= "底盘爬角", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_03.athena_attribute_UI_icon_03'", },
	["Chassis_Correction"] = {Attribute_Name= "底盘矫正", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_02.athena_attribute_UI_icon_02'", },
	["engine_efficiency"] = {Attribute_Name= "引擎效率", Image1= "Texture2D'/Game/Texture/UI/hall/Casting1/Casting_right/athena_attribute_UI_icon_20.athena_attribute_UI_icon_20'", },
};return CHASSIS_ATTRIBUTE