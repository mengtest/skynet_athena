--[[

 @file:       take_task.lua
 @source xls: excel_3D\Achievement.xlsx
 @sheet name: TAKE_TASK
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local TAKE_TASK = {
	[1] = {Task_Name= "进入10001关卡并且击杀10个敌人", If_Display=1, Task_Discribe= "英雄，愿你拥有一份不悔的爱情", Talk_ID=10001, Next_Task=2, Task_Object= {1, 2, }, Task_Type=1, },
	[10] = {Task_Name= "主线10", If_Display=1, Task_Discribe= "英雄，愿你拥有一份不悔的爱情", Talk_ID=10001, Next_Task=2, Task_Object= {1, 2, }, Task_Type=2, },
};return TAKE_TASK