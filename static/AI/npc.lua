--[[

 @file:       npc.lua
 @source xls: excel_3D\NPC.xlsx
 @sheet name: NPC
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local NPC = {
	[10001] = {AI_ID=10002, Name= "Cygnus", Weapon_modelID=10001, Weapon_Type=10008, Damage_Type=10001, Damage_Rad=500, Break_Rad=500, Break_Strength=0, Base_Damage=12, InitialSpeedMax=10000, MaxSpeed=3000000, Charge_During=0.0, CD=0.4, Overheat=10.0, Effect_Life=0, Body_modelID=10001, Hp=500, Hp_Restore=0.0, Sheld_Type=0, Sheld_Value=0, Shield_Damage_Reduce=0.5, Body_Damage=0.8, Sheld_Restore=0, Power_Value=200, Power_Restore=100, FireConcrol_modelID=10001, Attack_Angle_Max=30, Attack_Angle_Min=80, Angular_Acceleration=0.2, Power_Efficiency=0.7, Speed_X=700, Round_Speed=0, Chassis_Creeping_Angle=60, Chassis_Creeping_Hight=85, Chassis_Correction=10, Attach= "0.0", engine_efficiency=0.015, },
	[90001] = {AI_ID=90001, Name= "测试专用机甲", Weapon_modelID=10001, Weapon_Type=10008, Damage_Type=10001, Damage_Rad=500, Break_Rad=500, Break_Strength=0, Base_Damage=12, InitialSpeedMax=10000, MaxSpeed=3000000, Charge_During=0.0, CD=0.4, Overheat=10.0, Effect_Life=0, Body_modelID=10001, Hp=500, Hp_Restore=0.0, Sheld_Type=0, Sheld_Value=0, Shield_Damage_Reduce=0.5, Body_Damage=0.8, Sheld_Restore=0, Power_Value=200, Power_Restore=100, FireConcrol_modelID=10001, Attack_Angle_Max=30, Attack_Angle_Min=80, Angular_Acceleration=0.2, Power_Efficiency=0.7, Speed_X=700, Round_Speed=0, Chassis_Creeping_Angle=60, Chassis_Creeping_Hight=85, Chassis_Correction=10, Attach= "0.0", engine_efficiency=0.015, },
	[90010] = {AI_ID=10001, Name= "木星机枪手", Weapon_modelID=0, Weapon_Type=0, Damage_Type=0, Damage_Rad=0, Break_Rad=0, Break_Strength=0, Base_Damage=0, InitialSpeedMax=0, MaxSpeed=0, Charge_During=0, CD=0, Overheat=0, Effect_Life=0, Body_modelID=0, Hp=0, Hp_Restore=0, Sheld_Type=0, Sheld_Value=0, Shield_Damage_Reduce=0, Body_Damage=0, Sheld_Restore=0, Power_Value=0, Power_Restore=0, FireConcrol_modelID=0, Attack_Angle_Max=0, Attack_Angle_Min=0, Angular_Acceleration=0, Power_Efficiency=0, Speed_X=0, Round_Speed=0, Chassis_Creeping_Angle=0, Chassis_Creeping_Hight=0, Chassis_Correction=0, Attach= "", engine_efficiency=0, },
	[90011] = {AI_ID=10002, Name= "木星掠夺者", Weapon_modelID=0, Weapon_Type=0, Damage_Type=0, Damage_Rad=0, Break_Rad=0, Break_Strength=0, Base_Damage=0, InitialSpeedMax=0, MaxSpeed=0, Charge_During=0, CD=0, Overheat=0, Effect_Life=0, Body_modelID=0, Hp=0, Hp_Restore=0, Sheld_Type=0, Sheld_Value=0, Shield_Damage_Reduce=0, Body_Damage=0, Sheld_Restore=0, Power_Value=0, Power_Restore=0, FireConcrol_modelID=0, Attack_Angle_Max=0, Attack_Angle_Min=0, Angular_Acceleration=0, Power_Efficiency=0, Speed_X=0, Round_Speed=0, Chassis_Creeping_Angle=0, Chassis_Creeping_Hight=0, Chassis_Correction=0, Attach= "", engine_efficiency=0, },
	[90012] = {AI_ID=10003, Name= "来，往这打", Weapon_modelID=0, Weapon_Type=0, Damage_Type=0, Damage_Rad=0, Break_Rad=0, Break_Strength=0, Base_Damage=0, InitialSpeedMax=0, MaxSpeed=0, Charge_During=0, CD=0, Overheat=0, Effect_Life=0, Body_modelID=0, Hp=0, Hp_Restore=0, Sheld_Type=0, Sheld_Value=0, Shield_Damage_Reduce=0, Body_Damage=0, Sheld_Restore=0, Power_Value=0, Power_Restore=0, FireConcrol_modelID=0, Attack_Angle_Max=0, Attack_Angle_Min=0, Angular_Acceleration=0, Power_Efficiency=0, Speed_X=0, Round_Speed=0, Chassis_Creeping_Angle=0, Chassis_Creeping_Hight=0, Chassis_Correction=0, Attach= "", engine_efficiency=0, },
	[90013] = {AI_ID=10001, Name= "火星机枪手", Weapon_modelID=0, Weapon_Type=0, Damage_Type=0, Damage_Rad=0, Break_Rad=0, Break_Strength=0, Base_Damage=0, InitialSpeedMax=0, MaxSpeed=0, Charge_During=0, CD=0, Overheat=0, Effect_Life=0, Body_modelID=0, Hp=0, Hp_Restore=0, Sheld_Type=0, Sheld_Value=0, Shield_Damage_Reduce=0, Body_Damage=0, Sheld_Restore=0, Power_Value=0, Power_Restore=0, FireConcrol_modelID=0, Attack_Angle_Max=0, Attack_Angle_Min=0, Angular_Acceleration=0, Power_Efficiency=0, Speed_X=0, Round_Speed=0, Chassis_Creeping_Angle=0, Chassis_Creeping_Hight=0, Chassis_Correction=0, Attach= "", engine_efficiency=0, },
};return NPC