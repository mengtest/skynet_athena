--[[

 @file:       firecontrol.lua
 @source xls: excel_3D\FireControl.xlsx
 @sheet name: FIRECONTROL
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local FIRECONTROL = {
	[10001] = {Fire_Control_Name= "猛禽-1约束定标器", Fire_Control_type=10001, Attack_Angle_Max=30, Attack_Angle_Min=80, Angular_Acceleration=0.2, Power_Efficiency=0.7, Weapons_Slot_Total=2, Hanging_Point_Type1=1, Hanging_Point_Type2=1, Hanging_Point_Type3=1, Chip_Capacity=30, Chip_Id= {10001, 10002, 10003, 10004, }, Skill_Id=10001, Weight=60, Img1= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10001_01.athena_hangar_firecontrol_10001_01'", Img2= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10001_02.athena_hangar_firecontrol_10001_02'", modelID=10001, describe= "欧联在鼎盛时期制作的火控系统，虽然听上去老旧，但它的火力与精准永不过时。", battle_describe= "在战斗中，“猛禽-1”会提供宽阔的仰角和俯角，同时中幅度提升技能的使用效率。", Display= "壹型", Battle_Position= {290, 0, 10, 70, }, Set_Position= {-37, 113, -50, 0, -6, -168, }, Set_Position_L_L= {-230, 124, -58, 0, -29, -152, }, Set_Position_R_L= {-224, -90, -77, 0, 0, -30, }, Set_Position_L_H= {-230, 124, -58, 0, -29, -152, }, Set_Position_R_H= {-224, -90, -77, 0, 0, -30, }, Scan_Time=43200, },
	[10002] = {Fire_Control_Name= "迅灵相控阵系统", Fire_Control_type=10002, Attack_Angle_Max=60, Attack_Angle_Min=30, Angular_Acceleration=0.2, Power_Efficiency=0.7, Weapons_Slot_Total=2, Hanging_Point_Type1=1, Hanging_Point_Type2=1, Hanging_Point_Type3=1, Chip_Capacity=30, Chip_Id= {10001, 10002, 10003, 10004, }, Skill_Id=10002, Weight=60, Img1= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10002_01.athena_hangar_firecontrol_10002_01'", Img2= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10002_02.athena_hangar_firecontrol_10002_02'", modelID=10002, describe= "在战线的最前沿，拥有这种火控就相当于生存的保障。", battle_describe= "在战斗中，“迅灵”会提供较宽松的仰角和俯角，同时大幅度提升技能的使用效率。", Display= "贰型", Battle_Position= {290, 0, 10, 70, }, Set_Position= {-37, 113, -50, 0, -6, -168, }, Set_Position_L_L= {-155, 98, -26, 0, -11, -145, }, Set_Position_R_L= {-166, -74, -49, 0, -15, -33, }, Set_Position_L_H= {-155, 98, -26, 0, -11, -145, }, Set_Position_R_H= {-166, -74, -49, 0, -15, -33, }, Scan_Time=43200, },
	[10003] = {Fire_Control_Name= "智天使火控系统", Fire_Control_type=10003, Attack_Angle_Max=40, Attack_Angle_Min=50, Angular_Acceleration=0.2, Power_Efficiency=0.6, Weapons_Slot_Total=2, Hanging_Point_Type1=1, Hanging_Point_Type2=1, Hanging_Point_Type3=1, Chip_Capacity=30, Chip_Id= {10001, 10002, 10003, 10004, }, Skill_Id=10003, Weight=60, Img1= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10003_01.athena_hangar_firecontrol_10003_01'", Img2= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10003_02.athena_hangar_firecontrol_10003_02'", modelID=10003, describe= "枪口永远指向主的敌人，而士兵们负责执行神的意志。", battle_describe= "在战斗中，“智天使”会提供较大的仰角和俯角，同时中幅度提升技能的使用效率。", Display= "叁型", Battle_Position= {290, 0, 10, 70, }, Set_Position= {-37, 113, -50, 0, -6, -168, }, Set_Position_L_L= {-184, 105, -7, 0, -7, -148, }, Set_Position_R_L= {-180, -135, 30, 0, -7, -22, }, Set_Position_L_H= {-184, 105, -7, 0, -7, -148, }, Set_Position_R_H= {-180, -135, 30, 0, -7, -22, }, Scan_Time=43200, },
	[10008] = {Fire_Control_Name= "K1骑士相控阵系统", Fire_Control_type=10008, Attack_Angle_Max=30, Attack_Angle_Min=30, Angular_Acceleration=0.2, Power_Efficiency=0.5, Weapons_Slot_Total=2, Hanging_Point_Type1=6, Hanging_Point_Type2=6, Hanging_Point_Type3=6, Chip_Capacity=30, Chip_Id= {10001, 10002, 10003, 10004, }, Skill_Id=10008, Weight=60, Img1= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10008_01.athena_hangar_firecontrol_10008_01'", Img2= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10008_02.athena_hangar_firecontrol_10008_02'", modelID=10008, describe= "亚美利加皇家工艺中关于火控系统的精华全部体现在了“骑士”相控阵系统当中。", battle_describe= "在战斗中，“骑士”会提供较小的仰角和俯角，同时大幅度提升技能的使用效率。", Display= "捌型", Battle_Position= {290, 0, 10, 70, }, Set_Position= {-37, 113, -50, 0, -6, -168, }, Set_Position_L_L= {-23, 101, -151, 0, -15, 173, }, Set_Position_R_L= {-60, -100, -152, 0, 0, -30, }, Set_Position_L_H= {-23, 101, -151, 0, -15, 173, }, Set_Position_R_H= {-60, -100, -152, 0, 0, -30, }, Scan_Time=43200, },
	[90002] = {Fire_Control_Name= "猛禽-1约束定标器", Fire_Control_type=90001, Attack_Angle_Max=30, Attack_Angle_Min=30, Angular_Acceleration=0.2, Power_Efficiency=0.5, Weapons_Slot_Total=2, Hanging_Point_Type1=1, Hanging_Point_Type2=1, Hanging_Point_Type3=1, Chip_Capacity=30, Chip_Id= {10001, 10002, 10003, 10004, }, Skill_Id=10001, Weight=60, Img1= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10001_01.athena_hangar_firecontrol_10001_01'", Img2= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10001_02.athena_hangar_firecontrol_10001_02'", modelID=10001, describe= "欧联在鼎盛时期制作的火控系统，虽然听上去老旧，但它的火力与精准永不过时。", battle_describe= "在战斗中，“猛禽-1”会提供宽阔的仰角和俯角，同时中幅度提升技能的使用效率。", Display= "壹型", Battle_Position= {290, 0, 10, 70, }, Set_Position= {-37, 113, -50, 0, -6, -168, }, Set_Position_L_L= {-23, 101, -151, 0, -15, 173, }, Set_Position_R_L= {-60, -100, -152, 0, 0, -30, }, Set_Position_L_H= {-23, 101, -151, 0, -15, 173, }, Set_Position_R_H= {-60, -100, -152, 0, 0, -30, }, Scan_Time=43200, },
};return FIRECONTROL