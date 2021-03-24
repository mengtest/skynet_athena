--[[

 @file:       blueprint.lua
 @source xls: excel_3D\Blueprint.xlsx
 @sheet name: BLUEPRINT
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local BLUEPRINT = {
	["B110001"] = {Blueprint_Name= "蜂6动力底盘", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.25, Location_Casting= {1, -1, -22, 0, 0, 90, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_110001_01.athena_casting_blueprint_110001_01'", Image2= "Texture2D'/Game/Texture/Config/MACHINECHASSIS/athena_hangar_chassis_10001_02.athena_hangar_chassis_10001_02'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_110001_02.athena_casting_blueprint_110001_02'", },
	["B110002"] = {Blueprint_Name= "T21疾雷传动装置", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.25, Location_Casting= {9, -1, -29, 0, 0, 90, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_110002_01.athena_casting_blueprint_110002_01'", Image2= "Texture2D'/Game/Texture/Config/MACHINECHASSIS/athena_hangar_chassis_10002_02.athena_hangar_chassis_10002_02'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_110002_02.athena_casting_blueprint_110002_02'", },
	["B110003"] = {Blueprint_Name= "尘暴-I机动底盘", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.25, Location_Casting= {-3, -2, -32, 0, 0, 90, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_110003_01.athena_casting_blueprint_110003_01'", Image2= "Texture2D'/Game/Texture/Config/MACHINECHASSIS/athena_hangar_chassis_10003_02.athena_hangar_chassis_10003_02'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_110003_02.athena_casting_blueprint_110003_02'", },
	["B210001"] = {Blueprint_Name= "VK-4U强相互体", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.3, Location_Casting= {1, 1, 13, 0, 0, 135, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_210001_01.athena_casting_blueprint_210001_01'", Image2= "Texture2D'/Game/Texture/Config/MACHINEBODY/athena_hangar_body_10001_02.athena_hangar_body_10001_02'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_210001_02.athena_casting_blueprint_210001_02'", },
	["B210002"] = {Blueprint_Name= "Mark9复合身甲", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.4, Location_Casting= {-4, -8, -4, 0, 0, 120, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_210002_01.athena_casting_blueprint_210002_01'", Image2= "Texture2D'/Game/Texture/Config/MACHINEBODY/athena_hangar_body_10002_02.athena_hangar_body_10002_02'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_210002_02.athena_casting_blueprint_210002_02'", },
	["B210003"] = {Blueprint_Name= "圣子7型复合身甲", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.35, Location_Casting= {-12, -2, -2, 0, 0, 90, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_210003_01.athena_casting_blueprint_210003_01'", Image2= "Texture2D'/Game/Texture/Config/MACHINEBODY/athena_hangar_body_10003_02.athena_hangar_body_10003_02'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_210003_02.athena_casting_blueprint_210003_02'", },
	["B210008"] = {Blueprint_Name= "K-3复合身甲", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.5, Location_Casting= {-4, -1, -3, 0, 0, 90, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_210008_01.athena_casting_blueprint_210008_01'", Image2= "Texture2D'/Game/Texture/Config/MACHINEBODY/athena_hangar_body_10008_02.athena_hangar_body_10008_02'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_210008_02.athena_casting_blueprint_210008_02'", },
	["B310001"] = {Blueprint_Name= "猛禽-1约束定标器", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.25, Location_Casting= {7, 5, 32, 0, 0, 175, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_310001_01.athena_casting_blueprint_310001_01'", Image2= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10001_02.athena_hangar_firecontrol_10001_02'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_310001_02.athena_casting_blueprint_310001_02'", },
	["B310002"] = {Blueprint_Name= "迅灵相控阵系统", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.25, Location_Casting= {7, 2, 27, 0, 0, 160, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_310002_01.athena_casting_blueprint_310002_01'", Image2= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10002_02.athena_hangar_firecontrol_10002_02'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_310002_02.athena_casting_blueprint_310002_02'", },
	["B310003"] = {Blueprint_Name= "智天使火控系统", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.25, Location_Casting= {7, -6, 17, 0, 0, 160, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_310003_01.athena_casting_blueprint_310003_01'", Image2= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10003_02.athena_hangar_firecontrol_10003_02'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_310003_02.athena_casting_blueprint_310003_02'", },
	["B310008"] = {Blueprint_Name= "K1骑士相控阵系统", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.4, Location_Casting= {-5, -16, 32, 0, 0, 90, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_310008_01.athena_casting_blueprint_310008_01'", Image2= "Texture2D'/Game/Texture/Config/FIRECONTROL/athena_hangar_firecontrol_10008_02.athena_hangar_firecontrol_10008_02'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_310008_02.athena_casting_blueprint_310008_02'", },
	["B410001"] = {Blueprint_Name= "颂神号角", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.3, Location_Casting= {-5, -16, 32, 0, 0, 90, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410001_01.athena_casting_blueprint_410001_01'", Image2= "Texture2D'/Game/Texture/Config/WEAPONTABLE/athena_battle_railgun_10001_03.athena_battle_railgun_10001_03'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410001_02.athena_casting_blueprint_410001_02'", },
	["B410012"] = {Blueprint_Name= "刚古斯突", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.3, Location_Casting= {-2, 16, -14, 320, 10, 180, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410012_01.athena_casting_blueprint_410012_01'", Image2= "Texture2D'/Game/Texture/Config/WEAPONTABLE/athena_battle_cannon_10012_03.athena_battle_cannon_10012_03'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410012_02.athena_casting_blueprint_410012_02'", },
	["B410013"] = {Blueprint_Name= "陨落", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.3, Location_Casting= {0, 15, 1, 326, 3, 180, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410013_01.athena_casting_blueprint_410013_01'", Image2= "Texture2D'/Game/Texture/Config/WEAPONTABLE/athena_battle_cannon_10013_03.athena_battle_cannon_10013_03'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410013_02.athena_casting_blueprint_410013_02'", },
	["B410018"] = {Blueprint_Name= "火舌", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.3, Location_Casting= {-1, 21, -10, 320, 10, 180, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410018_01.athena_casting_blueprint_410018_01'", Image2= "Texture2D'/Game/Texture/Config/WEAPONTABLE/athena_battle_cannon_10018_03.athena_battle_cannon_10018_03'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410018_02.athena_casting_blueprint_410018_02'", },
	["B410026"] = {Blueprint_Name= "巴德塔", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.35, Location_Casting= {0, 14, -7, 320, 5, 170, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410026_01.athena_casting_blueprint_410026_01'", Image2= "Texture2D'/Game/Texture/Config/WEAPONTABLE/athena_battle_railgun_10026_03.athena_battle_railgun_10026_03'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410026_02.athena_casting_blueprint_410026_02'", },
	["B410027"] = {Blueprint_Name= "昆古尼尔", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.3, Location_Casting= {-3, 18, -15, 320, 10, 180, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410027_01.athena_casting_blueprint_410027_01'", Image2= "Texture2D'/Game/Texture/Config/WEAPONTABLE/athena_battle_railgun_10027_03.athena_battle_railgun_10027_03'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410027_02.athena_casting_blueprint_410027_02'", },
	["B410028"] = {Blueprint_Name= "暴乱泰坦", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.4, Location_Casting= {2, 10, 5, 320, 10, 180, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410028_01.athena_casting_blueprint_410028_01'", Image2= "Texture2D'/Game/Texture/Config/WEAPONTABLE/athena_battle_railgun_10028_03.athena_battle_railgun_10028_03'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410028_02.athena_casting_blueprint_410028_02'", },
	["B410029"] = {Blueprint_Name= "弧光剑", Material= {6, 1, 10001, 6, 2, 10002, }, Cast_Time=28800, SpeedUp_Consume=30000, Scan_Time=43200, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0.35, Location_Casting= {-5, -18, -16, 326, 3, 180, }, Image1= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410029_01.athena_casting_blueprint_410029_01'", Image2= "Texture2D'/Game/Texture/Config/WEAPONTABLE/Athena_Battle_Sword_10029_03.Athena_Battle_Sword_10029_03'", Image3= "Texture2D'/Game/Texture/Warehouse/BluePrint/athena_casting_blueprint_410029_02.athena_casting_blueprint_410029_02'", },
	["B610001"] = {Blueprint_Name= "数码聚合体", Material= {6, 1, 10001, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10001_02.Athena_10001_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10001_02.Athena_10001_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10001_01.Athena_10001_01'", },
	["B610002"] = {Blueprint_Name= "金属粘融剂", Material= {6, 1, 10002, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10002_02.Athena_10002_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10002_02.Athena_10002_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10002_01.Athena_10002_01'", },
	["B610003"] = {Blueprint_Name= "共振涂料", Material= {6, 1, 10003, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10003_02.Athena_10003_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10003_02.Athena_10003_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10003_01.Athena_10003_01'", },
	["B610004"] = {Blueprint_Name= "核心冷却液", Material= {6, 1, 10004, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10004_02.Athena_10004_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10004_02.Athena_10004_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10004_01.Athena_10004_01'", },
	["B610005"] = {Blueprint_Name= "机巧核心", Material= {6, 1, 10005, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10005_02.Athena_10005_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10005_02.Athena_10005_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10005_01.Athena_10005_01'", },
	["B610006"] = {Blueprint_Name= "能量稳定液", Material= {6, 1, 10006, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10006_02.Athena_10006_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10006_02.Athena_10006_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10006_01.Athena_10006_01'", },
	["B610007"] = {Blueprint_Name= "抗冲击胶质", Material= {6, 1, 10007, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10007_02.Athena_10007_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10007_02.Athena_10007_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10007_01.Athena_10007_01'", },
	["B610008"] = {Blueprint_Name= "高密保温膜", Material= {6, 1, 10008, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10008_02.Athena_10008_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10008_02.Athena_10008_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10008_01.Athena_10008_01'", },
	["B610009"] = {Blueprint_Name= "工质稳定剂", Material= {6, 1, 10009, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=2, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10009_02.Athena_10009_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10009_02.Athena_10009_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10009_01.Athena_10009_01'", },
	["B610010"] = {Blueprint_Name= "铜", Material= {6, 1, 10010, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10010_02.Athena_10010_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10010_02.Athena_10010_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10010_01.Athena_10010_01'", },
	["B610011"] = {Blueprint_Name= "天然碳60", Material= {6, 1, 10011, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10011_02.Athena_10011_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10011_02.Athena_10011_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10011_01.Athena_10011_01'", },
	["B610012"] = {Blueprint_Name= "钴", Material= {6, 1, 10012, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10012_02.Athena_10012_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10012_02.Athena_10012_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10012_01.Athena_10012_01'", },
	["B610013"] = {Blueprint_Name= "铁", Material= {6, 1, 10013, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10013_02.Athena_10013_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10013_02.Athena_10013_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10013_01.Athena_10013_01'", },
	["B610014"] = {Blueprint_Name= "银", Material= {6, 1, 10014, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10014_02.Athena_10014_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10014_02.Athena_10014_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10014_01.Athena_10014_01'", },
	["B610015"] = {Blueprint_Name= "镍", Material= {6, 1, 10015, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10015_02.Athena_10015_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10015_02.Athena_10015_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10015_01.Athena_10015_01'", },
	["B610016"] = {Blueprint_Name= "镁", Material= {6, 1, 10016, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10016_02.Athena_10016_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10016_02.Athena_10016_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10016_01.Athena_10016_01'", },
	["B610017"] = {Blueprint_Name= "锂", Material= {6, 1, 10017, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10017_02.Athena_10017_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10017_02.Athena_10017_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10017_01.Athena_10017_01'", },
	["B610018"] = {Blueprint_Name= "铬", Material= {6, 1, 10018, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10018_02.Athena_10018_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10018_02.Athena_10018_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10018_01.Athena_10018_01'", },
	["B610019"] = {Blueprint_Name= "铕", Material= {6, 1, 10019, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10019_02.Athena_10019_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10019_02.Athena_10019_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10019_01.Athena_10019_01'", },
	["B610020"] = {Blueprint_Name= "钙", Material= {6, 1, 10020, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10020_02.Athena_10020_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10020_02.Athena_10020_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10020_01.Athena_10020_01'", },
	["B610021"] = {Blueprint_Name= "铝", Material= {6, 1, 10021, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10021_02.Athena_10021_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10021_02.Athena_10021_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10021_01.Athena_10021_01'", },
	["B610022"] = {Blueprint_Name= "金", Material= {6, 1, 10022, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10022_02.Athena_10022_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10022_02.Athena_10022_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10022_01.Athena_10022_01'", },
	["B610023"] = {Blueprint_Name= "锰", Material= {6, 1, 10023, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10023_02.Athena_10023_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10023_02.Athena_10023_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10023_01.Athena_10023_01'", },
	["B610024"] = {Blueprint_Name= "锡", Material= {6, 1, 10024, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10024_02.Athena_10024_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10024_02.Athena_10024_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10024_01.Athena_10024_01'", },
	["B610025"] = {Blueprint_Name= "铅", Material= {6, 1, 10025, }, Cast_Time=60, SpeedUp_Consume=0, Scan_Time=60, Transport_Time=10, Bluprint_Rarity=1, Scal_Casting=0, Location_Casting = {}, Image1= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10025_02.Athena_10025_02'", Image2= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10025_02.Athena_10025_02'", Image3= "Texture2D'/Game/Texture/Warehouse/Material/Athena_10025_01.Athena_10025_01'", },
};return BLUEPRINT