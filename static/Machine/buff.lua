--[[

 @file:       buff.lua
 @source xls: excel_3D\BUFF.xlsx
 @sheet name: BUFF
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local BUFF = {
	[10005] = {BUFF_Name= "技能范围", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10006] = {BUFF_Name= "技能强度", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10007] = {BUFF_Name= "技能持续", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10008] = {BUFF_Name= "耐久", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10009] = {BUFF_Name= "护盾容量", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10010] = {BUFF_Name= "能量", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10011] = {BUFF_Name= "武器伤害", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10012] = {BUFF_Name= "伤害半径", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10013] = {BUFF_Name= "射程参数", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10014] = {BUFF_Name= "仰角", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10015] = {BUFF_Name= "俯角", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10016] = {BUFF_Name= "能量效率", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10017] = {BUFF_Name= "预加载性能", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10018] = {BUFF_Name= "引擎效率", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[10019] = {BUFF_Name= "底盘爬角", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20001] = {BUFF_Name= "灼烧", Per_Damage=5, BUFF_Type=4, Round_Speed=400, During=300, If_Desperse=1, If_Cancel=0, Stack_Max=3, Aim_Object=1, Image1= "Texture2D'/Game/Texture/UI/buff/burning.burning'", Special_Effects1= "ParticleSystem'/Game/Particles/status/Fire/Dot_Fire.Dot_Fire'", BUFF_Discribe= "持续受到火焰伤害", },
	[20002] = {BUFF_Name= "传送", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20003] = {BUFF_Name= "弹跳", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20004] = {BUFF_Name= "多发弹头", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20005] = {BUFF_Name= "散射", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20006] = {BUFF_Name= "冲刺", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20007] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20008] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20009] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20010] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20011] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20012] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20013] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20014] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20015] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20016] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20017] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
	[20018] = {BUFF_Name= "", Per_Damage=0, BUFF_Type=0, Round_Speed=0, During=0, If_Desperse=0, If_Cancel=0, Stack_Max=0, Aim_Object=0, Image1= "", Special_Effects1= "", BUFF_Discribe= "", },
};return BUFF