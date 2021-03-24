--[[

 @file:       task.lua
 @source xls: excel_3D\Achievement.xlsx
 @sheet name: TASK
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local TASK = {
	[1] = {Task_Name= "进入10001关卡并且击杀10个敌人", If_Display=1, Task_Discribe= "英雄，愿你拥有一份不悔的爱情", Talk_ID=10001, Next_Task=2, Task_Object= {1, 2, }, Task_Type=1, },
	[2] = {Task_Name= "主线2", If_Display=0, Task_Discribe= "", Talk_ID=10002, Next_Task=3, Task_Object= {1, 2, }, Task_Type=1, },
	[3] = {Task_Name= "主线3", If_Display=0, Task_Discribe= "", Talk_ID=10003, Next_Task=4, Task_Object= {1, 2, }, Task_Type=1, },
	[4] = {Task_Name= "主线4", If_Display=0, Task_Discribe= "", Talk_ID=10004, Next_Task=5, Task_Object= {1, 2, }, Task_Type=1, },
	[5] = {Task_Name= "主线5", If_Display=0, Task_Discribe= "", Talk_ID=10005, Next_Task=6, Task_Object= {1, 2, }, Task_Type=1, },
	[6] = {Task_Name= "主线6", If_Display=0, Task_Discribe= "", Talk_ID=10006, Next_Task=7, Task_Object= {1, 2, }, Task_Type=1, },
	[7] = {Task_Name= "主线7", If_Display=0, Task_Discribe= "", Talk_ID=10007, Next_Task=8, Task_Object= {1, 2, }, Task_Type=1, },
	[8] = {Task_Name= "主线8", If_Display=0, Task_Discribe= "", Talk_ID=10008, Next_Task=9, Task_Object= {1, 2, }, Task_Type=1, },
	[9] = {Task_Name= "主线9", If_Display=0, Task_Discribe= "", Talk_ID=10009, Next_Task=0, Task_Object= {1, 2, }, Task_Type=1, },
	[10] = {Task_Name= "主线10", If_Display=1, Task_Discribe= "英雄，愿你拥有一份不悔的爱情", Talk_ID=10001, Next_Task=11, Task_Object= {1, 2, }, Task_Type=2, },
	[11] = {Task_Name= "主线11", If_Display=0, Task_Discribe= "", Talk_ID=10002, Next_Task=12, Task_Object= {1, 2, }, Task_Type=2, },
	[12] = {Task_Name= "主线12", If_Display=0, Task_Discribe= "", Talk_ID=10003, Next_Task=13, Task_Object= {1, 2, }, Task_Type=2, },
	[13] = {Task_Name= "主线13", If_Display=0, Task_Discribe= "", Talk_ID=10004, Next_Task=14, Task_Object= {1, 2, }, Task_Type=2, },
	[14] = {Task_Name= "主线14", If_Display=0, Task_Discribe= "", Talk_ID=10005, Next_Task=15, Task_Object= {1, 2, }, Task_Type=2, },
	[15] = {Task_Name= "主线15", If_Display=0, Task_Discribe= "", Talk_ID=10006, Next_Task=16, Task_Object= {1, 2, }, Task_Type=2, },
	[16] = {Task_Name= "主线16", If_Display=0, Task_Discribe= "", Talk_ID=10007, Next_Task=17, Task_Object= {1, 2, }, Task_Type=2, },
	[17] = {Task_Name= "主线17", If_Display=0, Task_Discribe= "", Talk_ID=10008, Next_Task=18, Task_Object= {1, 2, }, Task_Type=2, },
	[18] = {Task_Name= "主线18", If_Display=0, Task_Discribe= "", Talk_ID=10009, Next_Task=0, Task_Object= {1, 2, }, Task_Type=2, },
	[19] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[20] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[21] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[22] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[23] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[24] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[25] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[26] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[27] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[28] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[29] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[30] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[31] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[32] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[33] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
	[34] = {Task_Name= "", If_Display=0, Task_Discribe= "", Talk_ID=0, Next_Task=0, Task_Object = {}, Task_Type=0, },
};return TASK