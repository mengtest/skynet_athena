--[[

 @file:       map.lua
 @source xls: excel_3D\Map.xlsx
 @sheet name: MAP
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local MAP = {
	[10001] = {Map_Name= "欧罗巴", Left_Right_Location= {-110556, -60560, }, Top_Down_Location= {25045, 6300, }, Direction= "", Map_Discribe= "冰封万里根本不足以描述欧罗巴的环境，地球的严寒下尚且能够孕育生命和希望，而这颗星球除了冰什么都没有。", image1= "Texture2D'/Game/Texture/Config/MAP/athena_StageSelect_stage_3.athena_StageSelect_stage_3'", AssetsName= "Icesheet_Maps_1", },
	[10002] = {Map_Name= "火星", Left_Right_Location= {-29185, 24155, }, Top_Down_Location= {10473, -9527, }, Direction= "", Map_Discribe= "比起地球来，居住在火星上的贫民们可以得到一个相对较好的生存环境，贵族和沙虫可不会向他们发射导弹", image1= "Texture2D'/Game/Texture/Config/MAP/athena_StageSelect_stage_3.athena_StageSelect_stage_3'", AssetsName= "Mars_Map_01", },
	[10004] = {Map_Name= "欧罗巴", Left_Right_Location= {-168221, -137221, }, Top_Down_Location= {97300, 85677, }, Direction= "", Map_Discribe= "", image1= "Texture2D'/Game/Texture/Config/MAP/athena_StageSelect_stage_3.athena_StageSelect_stage_3'", AssetsName= "Icesheet_maps_3", },
	[10003] = {Map_Name= "海王星", Left_Right_Location= {-29185, 24155, }, Top_Down_Location= {10473, -9527, }, Direction= "", Map_Discribe= "海王星作为人类对太阳系开发的极限，其遗迹中充斥着对于外星文明的思考和探求——当然，还有海量的资源", image1= "Texture2D'/Game/Texture/Config/MAP/athena_StageSelect_stage_3.athena_StageSelect_stage_3'", AssetsName= "Cave_Map", },
	[50001] = {Map_Name= "引导关卡地图", Left_Right_Location= {-29185, 24155, }, Top_Down_Location= {10473, -9527, }, Direction= "", Map_Discribe= "比起地球来，居住在火星上的贫民们可以得到一个相对较好的生存环境，贵族和沙虫可不会向他们发射导弹", image1= "Texture2D'/Game/Texture/Config/MAP/athena_StageSelect_stage_3.athena_StageSelect_stage_3'", AssetsName= "Mars_Map_02", },
	[70001] = {Map_Name= "训练场", Left_Right_Location= {-11360, 18640, }, Top_Down_Location= {-1675, -7365, }, Direction= "", Map_Discribe= "", image1= "Texture2D'/Game/Texture/Config/MAP/athena_StageSelect_stage_3.athena_StageSelect_stage_3'", AssetsName= "Xlc_map", },
};return MAP