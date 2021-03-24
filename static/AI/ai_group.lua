--[[

 @file:       ai_group.lua
 @source xls: excel_3D\AI_group.xlsx
 @sheet name: AI_GROUP
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local AI_GROUP = {
	[10001] = {X=1650, ID_YZ= {10001, 16666, 17777, 10002, 16666, 17777, 10001, 16666, 17777, 10002, 16666, 17777, 10001, 16666, 17777, 10002, 16666, 17777, 10001, 16666, 17777, 10002, 16666, 17777, 10001, 16666, 17777, 10002, 16666, 17777, 10001, 16666, 17777, 10002, 16666, 17777, 10002, 17772, 18882, 10001, 17772, 18882, 10002, 17772, 18882, }, With_GroupID=0, },
	[10002] = {X=1650, ID_YZ= {90010, -6810, -1850, 90011, -11600, -3780, }, With_GroupID=0, },
	[10003] = {X=-300, ID_YZ= {90010, -90838, 15011, 90010, -93038, 15011, 90010, -95238, 15011, 90010, -97438, 15011, 90010, -107072, 15011, }, With_GroupID=0, },
	[10004] = {X=2150, ID_YZ= {90011, 1950, -3032, 90011, 2950, -3032, 90010, 11801, -3312, 90013, -17188, -3032, 90013, -18188, -3032, }, With_GroupID=0, },
	[10005] = {X=2150, ID_YZ= {90001, 1950, -3845, }, With_GroupID=10008, },
	[10006] = {X=2150, ID_YZ= {90001, 5950, -3845, }, With_GroupID=10009, },
	[10007] = {X=2150, ID_YZ= {90001, 11801, -3845, }, With_GroupID=10010, },
	[10008] = {X=2150, ID_YZ= {90011, 950, -3032, 90011, 850, -3032, 90011, 750, -3032, }, With_GroupID=0, },
	[10009] = {X=-205160, ID_YZ= {90010, -145140, 92300, 90010, -147100, 92300, 90011, -150020, 92300, }, With_GroupID=0, },
	[10010] = {X=2150, ID_YZ= {90011, 12801, -3312, 90011, 13801, -3312, 90011, 14801, -3312, }, With_GroupID=0, },
	[10011] = {X=2150, ID_YZ= {90012, -3200, -3312, }, With_GroupID=0, },
	[10012] = {X=2150, ID_YZ= {90012, -6500, -3312, }, With_GroupID=0, },
	[10013] = {X=2150, ID_YZ= {90012, -9800, -3312, }, With_GroupID=0, },
	[10014] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10015] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10016] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10017] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10018] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10019] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10020] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10021] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10022] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10023] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10024] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10025] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10026] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10027] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
	[10028] = {X=1650, ID_YZ= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }, With_GroupID=0, },
};return AI_GROUP