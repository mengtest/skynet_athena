--[[

 @file:       starmap.lua
 @source xls: excel_3D\StarMap.xlsx
 @sheet name: STARMAP
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local STARMAP = {
	[0] = {Star_Name= "世界中心", Turn = {}, Angle_Speed1=0, Angle1=0, Revolution_Target=-1, Angle_Speed2=0, Angle2=0, Coordinat = {}, },
	[10001] = {Star_Name= "太阳", Turn = {}, Angle_Speed1=0, Angle1=0, Revolution_Target=0, Angle_Speed2=0, Angle2=0, Coordinat = {}, },
	[10002] = {Star_Name= "水星", Turn = {}, Angle_Speed1=0, Angle1=1800, Revolution_Target=0, Angle_Speed2=12, Angle2=6, Coordinat = {}, },
	[10003] = {Star_Name= "金星", Turn = {}, Angle_Speed1=0, Angle1=-1080, Revolution_Target=0, Angle_Speed2=6, Angle2=5, Coordinat = {}, },
	[10004] = {Star_Name= "地球", Turn = {}, Angle_Speed1=0, Angle1=1260, Revolution_Target=0, Angle_Speed2=36, Angle2=150, Coordinat = {}, },
	[10005] = {Star_Name= "火星", Turn = {}, Angle_Speed1=0, Angle1=720, Revolution_Target=0, Angle_Speed2=24, Angle2=72, Coordinat = {}, },
	[10006] = {Star_Name= "木星", Turn = {}, Angle_Speed1=0, Angle1=480, Revolution_Target=0, Angle_Speed2=156, Angle2=180, Coordinat = {}, },
	[10007] = {Star_Name= "土星", Turn = {}, Angle_Speed1=0, Angle1=360, Revolution_Target=0, Angle_Speed2=144, Angle2=180, Coordinat = {}, },
	[10008] = {Star_Name= "天王星", Turn = {}, Angle_Speed1=0, Angle1=270, Revolution_Target=0, Angle_Speed2=72, Angle2=141, Coordinat = {}, },
	[10009] = {Star_Name= "海王星", Turn = {}, Angle_Speed1=0, Angle1=180, Revolution_Target=0, Angle_Speed2=84, Angle2=129, Coordinat = {}, },
	[10010] = {Star_Name= "月球", Turn = {}, Angle_Speed1=0, Angle1=360, Revolution_Target=10004, Angle_Speed2=4, Angle2=0, Coordinat = {}, },
	[10011] = {Star_Name= "火卫一", Turn = {}, Angle_Speed1=0, Angle1=2250, Revolution_Target=10005, Angle_Speed2=108, Angle2=0, Coordinat = {}, },
	[10012] = {Star_Name= "火卫二", Turn = {}, Angle_Speed1=0, Angle1=600, Revolution_Target=10005, Angle_Speed2=108, Angle2=0, Coordinat = {}, },
	[10013] = {Star_Name= "木卫一", Turn = {}, Angle_Speed1=0, Angle1=1800, Revolution_Target=10006, Angle_Speed2=24, Angle2=0, Coordinat = {}, },
	[10014] = {Star_Name= "木卫二", Turn = {}, Angle_Speed1=0, Angle1=840, Revolution_Target=10006, Angle_Speed2=24, Angle2=0, Coordinat = {}, },
	[10015] = {Star_Name= "木卫三", Turn = {}, Angle_Speed1=0, Angle1=420, Revolution_Target=10006, Angle_Speed2=24, Angle2=0, Coordinat = {}, },
	[10016] = {Star_Name= "木卫四", Turn = {}, Angle_Speed1=0, Angle1=210, Revolution_Target=10006, Angle_Speed2=24, Angle2=0, Coordinat = {}, },
	[10017] = {Star_Name= "土卫六", Turn = {}, Angle_Speed1=0, Angle1=90, Revolution_Target=10007, Angle_Speed2=9, Angle2=0, Coordinat = {}, },
	[10018] = {Star_Name= "土星环", Turn = {}, Angle_Speed1=0, Angle1=90, Revolution_Target=10007, Angle_Speed2=9, Angle2=0, Coordinat = {}, },
	[10019] = {Star_Name= "柯伊博行星带", Turn = {}, Angle_Speed1=0, Angle1=0, Revolution_Target=0, Angle_Speed2=0, Angle2=0, Coordinat = {}, },
	[10020] = {Star_Name= "地月小行星带", Turn = {}, Angle_Speed1=0, Angle1=0, Revolution_Target=10004, Angle_Speed2=0, Angle2=0, Coordinat = {}, },
};return STARMAP