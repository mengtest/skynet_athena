--[[

 @file:       store.lua
 @source xls: excel_3D\Store.xlsx
 @sheet name: STORE
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local STORE = {
	[10001] = {Goods_Name= "塑性器", Goods_Didscribe= "机甲极化的材料", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10001_01.Athena_store_10001_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10001_02.Athena_store_10001_02'", If_Use=0, },
	[10002] = {Goods_Name= "反应堆", Goods_Didscribe= "芯片容量扩张", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10002_01.Athena_store_10002_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10002_02.Athena_store_10002_02'", If_Use=0, },
	[10003] = {Goods_Name= "铝硅钎剂粉", Goods_Didscribe= "焊接机甲的必备材料", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10003_01.Athena_store_10003_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10003_02.Athena_store_10003_02'", If_Use=0, },
	[10004] = {Goods_Name= "晶间腐蚀剂", Goods_Didscribe= "拆解焊缝的材料", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10004_01.Athena_store_10004_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10004_02.Athena_store_10004_02'", If_Use=0, },
	[10005] = {Goods_Name= "50小时加速器", Goods_Didscribe= "加速50小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10006] = {Goods_Name= "60小时加速器", Goods_Didscribe= "加速60小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10007] = {Goods_Name= "70小时加速器", Goods_Didscribe= "加速70小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10008] = {Goods_Name= "80小时加速器", Goods_Didscribe= "加速80小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10009] = {Goods_Name= "90小时加速器", Goods_Didscribe= "加速90小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10010] = {Goods_Name= "100小时加速器", Goods_Didscribe= "加速100小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10011] = {Goods_Name= "110小时加速器", Goods_Didscribe= "加速110小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10012] = {Goods_Name= "120小时加速器", Goods_Didscribe= "加速120小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10013] = {Goods_Name= "130小时加速器", Goods_Didscribe= "加速130小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10014] = {Goods_Name= "140小时加速器", Goods_Didscribe= "加速140小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10015] = {Goods_Name= "150小时加速器", Goods_Didscribe= "加速150小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10016] = {Goods_Name= "160小时加速器", Goods_Didscribe= "加速160小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10017] = {Goods_Name= "170小时加速器", Goods_Didscribe= "加速170小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10018] = {Goods_Name= "180小时加速器", Goods_Didscribe= "加速180小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10019] = {Goods_Name= "190小时加速器", Goods_Didscribe= "加速190小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10020] = {Goods_Name= "200小时加速器", Goods_Didscribe= "加速200小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10021] = {Goods_Name= "210小时加速器", Goods_Didscribe= "加速210小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10022] = {Goods_Name= "220小时加速器", Goods_Didscribe= "加速220小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10023] = {Goods_Name= "230小时加速器", Goods_Didscribe= "加速230小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10024] = {Goods_Name= "240小时加速器", Goods_Didscribe= "加速240小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10025] = {Goods_Name= "250小时加速器", Goods_Didscribe= "加速250小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
	[10026] = {Goods_Name= "260小时加速器", Goods_Didscribe= "加速260小时", Price=10.0, Image_1= "Texture2D'/Game/Texture/Store/Athena_store_10005_01.Athena_store_10005_01'", Image_2= "Texture2D'/Game/Texture/Store/Athena_store_10005_02.Athena_store_10005_02'", If_Use=0, },
};return STORE