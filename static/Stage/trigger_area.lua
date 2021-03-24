--[[

 @file:       trigger_area.lua
 @source xls: excel_3D\Trigger_Area.xlsx
 @sheet name: TRIGGER_AREA
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local TRIGGER_AREA = {
	[10001] = {Area_Name= "群星认为你们还有所欠缺", Width=2000, Height=2000, AI_Group = {}, Creat_Type=2, During=300, Trigger_Object=1, Special_Effcets= "", BUFF_ID=0, Area_Suffer=4999999, },
	[10005] = {Area_Name= "1-3第一组挖掘机", Width=2000, Height=2000, AI_Group= {10005, }, Creat_Type=2, During=0, Trigger_Object=2, Special_Effcets= "", BUFF_ID=0, Area_Suffer=4999999, },
	[10006] = {Area_Name= "1-3第二组挖掘机", Width=2000, Height=2000, AI_Group= {10006, }, Creat_Type=2, During=0, Trigger_Object=2, Special_Effcets= "", BUFF_ID=0, Area_Suffer=4999999, },
	[10007] = {Area_Name= "1-3第三组挖掘机", Width=2000, Height=2000, AI_Group= {10007, }, Creat_Type=2, During=0, Trigger_Object=2, Special_Effcets= "", BUFF_ID=0, Area_Suffer=4999999, },
	[20001] = {Area_Name= "燃烧弹", Width=2000, Height=2000, AI_Group = {}, Creat_Type=2, During=300, Trigger_Object=3, Special_Effcets= "", BUFF_ID=20001, Area_Suffer=4999999, },
};return TRIGGER_AREA