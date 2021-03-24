--[[

 @file:       weapon_material.lua
 @source xls: excel_3D\Weapon_Material.xlsx
 @sheet name: WEAPON_MATERIAL
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local WEAPON_MATERIAL = {
	[10001] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/Athena_Battle_Sword_10001_01.Athena_Battle_Sword_10001_01'", },
	[10002] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_railgun_10004_1_Inst.athena_battle_railgun_10004_1_Inst'", },
	[10003] = {path= "Material'/Game/Temporary/Materials/M_Spiders_Main.M_Spiders_Main'", },
	[10004] = {path= "Material'/Game/Temporary/Materials/M_Spiders_Main.M_Spiders_Main'", },
	[10005] = {path= "Material'/Game/Temporary/Materials/M_Spiders_Main.M_Spiders_Main'", },
	[10006] = {path= "Material'/Game/Temporary/Materials/M_Spiders_Main.M_Spiders_Main'", },
	[10007] = {path= "Material'/Game/Temporary/Materials/M_Spiders_Main.M_Spiders_Main'", },
	[10008] = {path= "Material'/Game/Temporary/Materials/M_Spiders_Main.M_Spiders_Main'", },
	[10009] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_railgun_10009_1_Inst.athena_battle_railgun_10009_1_Inst'", },
	[10010] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_sword_10010_1_Inst.athena_battle_sword_10010_1_Inst'", },
	[10011] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_railgun_10011_1_Inst.athena_battle_railgun_10011_1_Inst'", },
	[10012] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/Athena_Battle_Sword_10012_01.Athena_Battle_Sword_10012_01'", },
	[10013] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cannon_10013_01_Inst.athena_battle_cannon_10013_01_Inst'", },
	[10014] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cups_10014_1_Inst.athena_battle_cups_10014_1_Inst'", },
	[10015] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cups_10015_1_Inst.athena_battle_cups_10015_1_Inst'", },
	[10016] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cups_10016_1_Inst.athena_battle_cups_10016_1_Inst'", },
	[10017] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cups_10017_1_Inst.athena_battle_cups_10017_1_Inst'", },
	[10018] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cups_10018_1_Inst.athena_battle_cups_10018_1_Inst'", },
	[10019] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cups_10019_1_Inst.athena_battle_cups_10019_1_Inst'", },
	[10020] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10020_1_Inst.athena_battle_gun_10020_1_Inst'", },
	[10021] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cups_10021_1_Inst.athena_battle_cups_10021_1_Inst'", },
	[10022] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cups_10022_1_Inst.athena_battle_cups_10022_1_Inst'", },
	[10023] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10023_1_Inst.athena_battle_gun_10023_1_Inst'", },
	[10024] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cups_10024_1_Inst.athena_battle_cups_10024_1_Inst'", },
	[10025] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cups_10025_1_Inst.athena_battle_cups_10025_1_Inst'", },
	[10026] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_cups_10026_1_Inst.athena_battle_cups_10026_1_Inst'", },
	[10027] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_railgun_10027_01Inst.athena_battle_railgun_10027_01Inst'", },
	[10028] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/Athena_Battle_Sword_10028_01.Athena_Battle_Sword_10028_01'", },
	[10029] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/Athena_Battle_Sword_10029_01.Athena_Battle_Sword_10029_01'", },
	[20014] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10014_1_Inst.athena_battle_gun_10016_1_Inst'", },
	[20015] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10015_1_Inst.athena_battle_gun_10017_1_Inst'", },
	[20016] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10016_1_Inst.athena_battle_gun_10016_1_Inst'", },
	[20017] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10017_1_Inst.athena_battle_gun_10017_1_Inst'", },
	[20018] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10018_1_Inst.athena_battle_gun_10018_1_Inst'", },
	[20019] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10019_1_Inst.athena_battle_gun_10019_1_Inst'", },
	[20020] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10020_1_Inst.athena_battle_gun_10020_1_Inst'", },
	[20021] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10021_1_Inst.athena_battle_gun_10021_1_Inst'", },
	[20022] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10022_1_Inst.athena_battle_gun_10022_1_Inst'", },
	[20023] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10023_1_Inst.athena_battle_gun_10023_1_Inst'", },
	[20024] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10024_1_Inst.athena_battle_gun_10024_1_Inst'", },
	[20025] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10025_1_Inst.athena_battle_gun_10025_1_Inst'", },
	[20026] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10026_1_Inst.athena_battle_gun_10026_1_Inst'", },
	[20027] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10027_1_Inst.athena_battle_gun_10027_1_Inst'", },
	[20028] = {path= "MaterialInstanceConstant'/Game/MachineAsset/weapon/skin/Material/athena_battle_gun_10028_1_Inst.athena_battle_gun_10028_1_Inst'", },
};return WEAPON_MATERIAL