--[[

 @file:       drop_list.lua
 @source xls: excel_3D\Drop_List.xlsx
 @sheet name: DROP_LIST
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local DROP_LIST = {
	[10001] = {Material_ID= {10001, 7, 22, 6, 10008, 7, 0, 1, 10014, 7, 2, 1, 10015, 7, 0, 1, 10016, 7, 1, 1, 10020, 7, 1, 1, 10023, 7, 1, 1, 10024, 7, 1, 1, }, Material_ID_D = {}, Gold=3413, Gold_D=1706, EXP=5600, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=10, Gold_permin=341, List= {10001, 7, 10008, 7, 10014, 7, 10015, 7, 10016, 7, 10020, 7, 10023, 7, 10024, 7, }, },
	[10002] = {Material_ID= {10001, 7, 22, 6, 10008, 7, 0, 1, 10014, 7, 2, 1, 10015, 7, 0, 1, 10016, 7, 1, 1, 10020, 7, 1, 1, 10023, 7, 1, 1, 10024, 7, 1, 1, }, Material_ID_D = {}, Gold=3413, Gold_D=1706, EXP=5600, EXP_D=0, Drop_package= {10001, 1, }, Roll_Times=1, Stage_time=10, Gold_permin=341, List= {10001, 7, 10008, 7, 10014, 7, 10015, 7, 10016, 7, 10020, 7, 10023, 7, 10024, 7, }, },
	[10003] = {Material_ID= {10001, 7, 22, 6, 10003, 7, 0, 1, }, Material_ID_D = {}, Gold=1024, Gold_D=512, EXP=1680, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=3, Gold_permin=341, List= {10001, 7, 10008, 7, 10014, 7, 10015, 7, 10016, 7, 10020, 7, 10023, 7, 10024, 7, }, },
	[10004] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10005] = {Material_ID= {10001, 7, 22, 6, 10003, 7, 0, 1, }, Material_ID_D = {}, Gold=1706, Gold_D=853, EXP=2800, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=5, Gold_permin=341, List = {}, },
	[10006] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10007] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10008] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10009] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10010] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10011] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10012] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10013] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10014] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10015] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10016] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10017] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10018] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10019] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10020] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[10021] = {Material_ID = {}, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=0, Gold_permin=341, List = {}, },
	[50001] = {Material_ID= {10004, 7, 1, 0, 10002, 3, 7, 0, 10003, 7, 1, 0, }, Material_ID_D = {}, Gold=0, Gold_D=0, EXP=0, EXP_D=0, Drop_package = {}, Roll_Times=0, Stage_time=3, Gold_permin=1, List = {}, },
	[90001] = {Material_ID= {10001, 7, 45, 11, }, Material_ID_D= {10001, 1, 15, 3, }, Gold=15360, Gold_D=5120, EXP=826006, EXP_D=1706, Drop_package = {}, Roll_Times=0, Stage_time=10, Gold_permin=1024, List = {}, },
};return DROP_LIST