-- --------------------------------------
-- Create Date:2018-07-13 10:51:41
-- Author  : Happy Su
-- Version : 1.0
-- Filename: attributeid.lua
-- Introduce  : 类介绍
-- --------------------------------------

local attributeID = enum {
    marching_speed = 101, -- 101	行军速度提高
    infantry_attack = 102, -- 102	步兵攻击提高
    archer_attack = 103, -- 103	弓兵攻击提高
    cavalry_attack = 104, -- 104	骑兵攻击提高
    elite_attack = 105, -- 105	精锐攻击提高

    infantry_defence = 106, -- 106	步兵防御提高
    archer_defence = 107, -- 107	弓兵防御提高
    cavalry_defence = 108, -- 108	骑兵防御提高
    elite_defence = 109, -- 109	精锐防御提高

    infantry_life = 110, -- 110	步兵生命提高
    archer_life = 111, -- 111	弓兵生命提高
    cavalry_life = 112, -- 112	骑兵生命提高
    elite_life = 113, -- 113	精锐生命提高

    army_attack = 114, -- 114	军团攻击提高
    army_defence = 115, -- 115	军团防御提高
    army_life = 116, -- 116	军团生命提高

    infantry_cost = 117, -- 117	步兵成本降低
    archer_cost = 118, -- 118	弓手成本降低
    cavalry_cost = 119, -- 119	骑兵成本降低
    elite_cost = 120, -- 120	精锐成本降低

    army_weight = 121, -- 121	军团负重量提高
    army_max_soldier_num = 122, -- 122	军团士兵数量上限增加（定值）
    army_max_soldier_rate = 123, -- 123	军团士兵数量上限增加（万分比）
    marching_speed_slow = 124, -- 124	行军速度降低
    army_attack_reduce = 125, -- 125	军团攻击降低
    army_defence_reduce = 126, -- 126	军团防御降低
    army_wounder_transform = 127, -- 127 出征战斗增加伤兵转换万分比
    army_life_reduce = 128, -- 128 军团生命降低
    fanaticism_army_attack = 129, -- 129		战争狂热攻击力增加
    fanaticism_army_defence = 130, -- 130		战争狂热防御增加
    fanaticism_army_life = 131, -- 131		战争狂热生命力增加

    build_speed_add = 201, -- 201	建造速度提高
    research_speed_add = 202, -- 202	研究速度提高

    food_output = 203, -- 203	粮食产量提高
    wood_output = 204, -- 204	木材产量提高
    iron_output = 205, -- 205	铁矿产量提高
    mithril_output = 206, -- 206	秘银产量提高
    gold_output = 207, -- 207	金币产量提高

    food_collection_speed = 208, -- 208	粮食采集速度提高
    wood_collection_speed = 209, -- 209	木材采集速度提高
    iron_collection_speed = 210, -- 210	铁矿采集速度提高
    mithril_collection_speed = 211, -- 211	秘银采集速度提高
    gold_collection_speed = 212, -- 212	金币采集速度提高
    magic_crystal_collection_speed = 213, -- 213	水晶采集速度提高

    food_capacity = 214, -- 214	领地粮食容量提高
    wood_capacity = 215, -- 215	领地木材容量提高
    iron_capacity = 216, -- 216	领地铁矿容量提高
    mithril_capacity = 217, -- 217	领地秘银容量提高
    gold_capacity = 218, -- 218	领地金币容量提高
    res_collect_speed = 219, -- 219	资源采集速度提升
    food_consume_reduce = 220,-- 220	军饷降低
    forge_speed = 221, -- 221	装备锻造速度
    wishpond_res_add = 222,-- 222	宝藏之池寻宝资源数量加成
    build_cost_reduce = 223,-- 223	建造成本降低
    research_cost_reduce = 224,-- 224	研究成本降低
    research_civilization_technology_add = 225,-- 225	文明科技研究加速
    res_output = 228,-- 228	全部资源产量提高
    res_output_reduce = 229,-- 229	全部资源产量降低
    build_speed_reduce = 230, -- 230	建造速度降低
    research_speed_reduce = 231,-- 231	研究速度降低
    food_output_reduce = 232,-- 232	粮食产量降低
    wood_output_reduce = 233,-- 233	木材产量降低
    iron_output_reduce = 234,-- 234	铁矿产量降低
    mithril_output_reduce = 235,-- 235	秘银产量降低
    gold_output_reduce = 236,-- 236	金币产量降低
    food_consume = 237,-- 237	军饷提高
    material_produce_speed = 238,-- 238  材料生产加速
    build_food_cost_reduce = 239, -- 239	（定值）	建造粮食消耗
    build_wood_cost_reduce = 240, -- 240	（定值）	建造木材消耗
    build_iron_cost_reduce = 241, -- 241	（定值）	建造铁消耗
    build_mithril_cost_reduce = 242, -- 242	（定值）	建造白银消耗
    build_food_cost_reduce_rate = 243, -- 243	（万分比）	建造粮食消耗
    build_wood_cost_reduce_rate = 244, -- 244	（万分比）	建造木材消耗
    build_iron_cost_reduce_rate = 245, -- 245	（万分比）	建造铁消耗
    build_mithril_cost_reduce_rate = 246, -- 246	（万分比）	建造白银消耗
    tec_food_cost_reduce = 247, -- 247	（定值）	学院科研粮食消耗
    tec_wood_cost_reduce = 248, -- 248	（定值）	学院科研木材消耗
    tec_iron_cost_reduce = 249, -- 249	（定值）	学院科研铁消耗
    tec_mithril_cost_reduce = 250, -- 250	（定值）	学院科研白银消耗
    tec_gold_cost_reduce = 251, -- 251	（定值）	学院科研金币消耗
    build_time_cost_reduce = 252, -- 252	（定值）	建造时间减少

    lord_skill_save_num = 301, -- 301	天赋记忆组合增加（定值）
    treasure_program_num = 302, -- 302	快速换装组合增加（定值）
    pre_army_group = 303,-- 303	预编军团组合增加（定值）
    march_queue_num = 304,-- 304	行军队列增加（定值）

    collect_march_speed = 305, -- 305	采集行军速度提高
    res_transport_volume = 306, -- 306	资源运输量提高
    res_transport_tax_reduce = 307, -- 307	运输税收减少
    transport_march_speed = 308, -- 308	运输行军速度提高

    -------------------- 废弃 -- 309	狂热防御力提高
    -------------------- 废弃 -- 310	狂热生命力提高
    -------------------- 废弃 -- 311	狂热攻击力提高

    lord_skill_points_add = 312,-- 312	统御点数增加（定值）
    reinforce_march_speed = 313, -- 313	增援行军速度提高
    mass_attack_add = 314, -- 314	集结攻击力提高
    -------------------- 废弃 blackarea_amrch_speed = 315, -- 315	黑土地行军速度提高
    alliance_mem_join_us_speed = 316,   -- 316	盟友加入我方集结行军速度提高
    alliance_help_reduce_time = 317, -- 317	帮助减少时间（万分比）
    alliance_help_count = 318, -- 318 增加帮助加速次数（定值）
    -- 319	增加联盟成员上限（定值）
    -- 320	联盟建筑建造速度提高
    -- 321	领地税收比例提高
    -- 322	联盟超级矿采集速度提高
    -- 323	降低联盟建筑被拆速度
    -- 324	增加联盟仓库每日容量
    -- 325	增加联盟仓库总容量
    -- 326	增加联盟医院容量
    -- 327	联盟医院治疗消耗降低
    -- 328	开放法术等级
    -- 329	增加联盟医院治疗速度
    -- 330	增加联盟仓库每日容量（定值）
    -- 331	增加联盟仓库总容量（定值）
    -- 332	增加联盟医院容量（定值）
    -- 333  联盟旗帜增加


    reign_exp_add = 401,-- 401	统御经验加成
    action_recover_speed = 402,-- 402	行动力恢复速度提高
    action_upperlimit = 403,-- 403	行动力上限增加（定值）
    actionconsume_reduce = 404,-- 404   封印战行动力消耗减低
    continuous_capture_limitnum = 405,-- 405	猎杀连击次数上限提高（定值）

    kill_monster_speed = 406, -- 406	猎杀行军速度提高
    kill_monster_damage = 407, -- 407	猎杀战伤害提高
    kill_monster_hero_hp = 408, -- 408	猎杀战英雄生命提高
    kill_monster_cure = 409, -- 409	猎杀战治疗效果提高
    kill_monster_energy = 410, -- 410	猎杀战初始怒气增加（定值）
    physical_upperlimit = 411,-- 411	体力上限提高
    -- 412 军功上限提高(万分比)
    -- 413 军功上限提高(定值)

    -------------------- 废弃 412	藏兵军团规模增加（定值）
    -------------------- 废弃 413	炼金速度提高

    barbariancamp_marchingnum = 414,-- 414	攻巢行军规模提高（定值）
    join_barbariancamp_marchingspeed = 415,-- 415	参与攻巢集结行军速度提高
    barbariancamp_marchingspeed = 416,-- 416	攻巢行军速度提高
    barbariancamp_crops_attack = 417,-- 417	攻巢军团攻击力提高
    barbariancamp_crops_defense = 418,-- 418	攻巢军团防御力提高
    barbariancamp_crops_life = 419,-- 419	攻巢军团生命力提高

    killnpc_marchingnum = 420,-- 420	打怪行军规模提高（定值）
    killnpc_marchingspeed = 421,-- 421	打怪行军速度提高
    killnpc_crops_attack = 422,-- 422	打怪军团攻击力提高
    killnpc_crops_defense = 423,-- 423	打怪军团防御力提高
    killnpc_crops_life = 424,-- 424	打怪军团生命力提高
    killnpc_exp_add = 425, -- 425	打怪经验

    rebel_infantry_defense = 426, -- 426	步兵在打怪和野蛮人营地时的防御力提高
    rebel_archer_defense = 427, -- 427	弓兵在打怪和野蛮人营地时的防御力提高
    rebel_cavalry_defense = 428, -- 428	骑兵在打怪和野蛮人营地时的防御力提高

    rebel_archer_life = 429, -- 429	弓兵在打怪和野蛮人营地时的生命力提高
    rebel_infantry_life = 430, -- 430	步兵在打怪和野蛮人营地时的生命力提高
    rebel_cavalry_life = 431, -- 431	骑兵在打怪和野蛮人营地时的生命力提高

    rebel_infantry_attack = 432, -- 432	步兵在打怪和野蛮人营地时的攻击力提高
    rebel_cavalry_attack = 433, -- 433	骑兵在打怪和野蛮人营地时的攻击力提高
    rebel_archer_attack = 434, -- 434	弓兵在打怪和野蛮人营地时的攻击力提高

    rebelbattle_double_reward_percent = 435, -- 435	打怪时，有几率获得双倍奖励

    contract_fuse_speed = 436,-- 436	契约书融合速度
    skill_fuse_speed = 437,-- 437	技能之核融合速度
    magicmonster_training_lvexp = 438,-- 438	魔物训练等级经验加成
    magicmonster_skill = 439,-- 439	契约魔物技能提升加成

    capacity_protectednum_add = 501,-- 501	仓库保护资源量提高（万分比）
    capacity_protectednum_int = 502, -- 502	仓库保护资源量提高（定值）

    rescue_res_add = 503, -- 503	救援资源提高
    puppet_buildspeed = 504,-- 504	傀儡制造速度提高
    puppet_attack = 505, -- 505	傀儡攻击增加
    puppet_defend = 506,-- 506	傀儡防御增加
    puppet_life = 507,-- 507	傀儡生命增加
    citywall_life = 508,-- 508	城墙耐久度提高（万分比）
    puppet_recovery = 509,-- 509	傀儡回收量增加
    citywall_defense = 510,-- 510	城墙防御力增加
    citywall_recoverspeed = 511,-- 511	城墙修复速度提高
    citywall_life_int = 512, -- 512	城墙耐久度提高（定值）
    train_speed = 513, -- 513	军营训练速度提高
    curespeed = 514,-- 514	医院治疗速度提高
    cure_cost_reduce = 515,-- 515	医院治疗成本降低

    -------------------- 废弃 516	医疗所容量提高

    altar_time_add = 517, -- 517	祭坛祝福时间提高（定值）

    -------------------- 废弃 518	箭塔攻击提高
    -------------------- 废弃 519	箭塔攻击速度提高
    -------------------- 废弃 520	大使馆容量增加
    -------------------- 废弃 521	战争大厅容量增加

    infantry_train_speed_add = 518, -- 兵营训练士兵速度提高(万分比)
    cavalry_train_speed_add = 519, -- 马厩训练士兵速度提高(万分比)
    archer_train_speed_add = 520, -- 靶场训练士兵速度提高(万分比)

    train_num_per = 522, -- 522	军营训练兵量提高（万分比）
    train_num_int = 523, -- 523	军营训练兵量提高（定值）
    army_defendcity_defend_add = 524,-- 524	守城防御力上升

    -------------------- 废弃 525	契约书融合速度
    -------------------- 废弃 526	技能之核融合速度
    -------------------- 废弃 527	魔物训练等级经验加成
    -------------------- 废弃 528	契约魔物技能提升加成

    infantry_train_num = 525, -- 兵营单次训练士兵数量提高(定值)
    cavalry_train_num = 526, -- 马厩单次训练士兵数量提高(定值)
    archer_train_num = 527, -- 靶场单次训练士兵数量提高(定值)

    -- 529	研发消耗资源减少
    puppet_capacity = 530, -- 530	傀儡容量（定值）
    puppet_curespeed = 531,-- 531	傀儡治疗速度提高
    towers_attacks = 532,-- 532	箭塔攻击力上升
    towers_attack_speed = 533,-- 533	箭塔攻击速度上升
    soilder_cost_reduce = 534,-- 534	士兵训练成本降低
    medical_tent_capacity_int = 535, -- 535	医疗所容量提高（定值）
    medical_tent_capacity_add = 536, -- 536	医疗所容量提高（万分比）
    embassy_capacity_int = 537, -- 537	大使馆容量增加（定值）
    embassy_capacity_add = 538, -- 538	大使馆容量增加（万分比）
    warhall_capacity_int = 539, -- 539	战争大厅容量增加（定值）
    warhall_capacity_add = 540,-- 540	战争大厅容量增加（万分比）
    train_speed_reduce = 541,   -- 541	军营训练速度降低
    capacity_protectednum_reduce = 542, -- 542	仓库保护资源量降低（万分比）
    capacity_protectednum_int_reduce = 543,-- 543	仓库保护资源量降低（定值）

    -------------------- 废弃 和508 重复了 544	城墙耐久度提高（定值）

    -- 550	施放时对敌军造成部队攻击力n%的伤害
    army_defendcity_attack_add = 551, -- 551 守城时守城的士兵攻击提升（万分比）
    soldiercave_corps_add = 552, -- 552	藏兵军团规模增加（定值）
    elf_atkpoint_cost_reduce = 553, -- 降低精灵攻击点数消耗
    elf_defpoint_cost_reduce = 554, -- 降低精灵防御点数消耗
    elf_atkpoint_get_add = 555, -- 获取攻击点数提高（道具除外）
    elf_defpoint_get_add = 556, --获取防御点数（道具除外）
    -- 557		战斗时，精灵造成军团总攻击百分比伤害
    elf_exp_get_add = 558, -- 精灵经验加成

    -- 601	战争守护 一段时间内玩家城市处于和平状态，城市不可被他人侦察和攻击
    war_guardians = 601,
    -- 602	反侦察	一段时间内阻止敌人侦察玩家的城市和部队
    anti_scout = 602,
    -- 603	伪装术	一段时间内让自己的城市驻守部队在受到侦察时显示为双倍兵力
    disguise = 603,
    -- 604	诱敌术	一段时间内让自己的城市驻守部队在受到侦察时显示为一半的兵力
    decoy = 604,
    -- 605	战争狂热	玩家发起军事行为会获得军团攻击、防御、生命相关的加成效果
        -- ，持续一段时间
    war_fanaticism = 605,
    -- 608	采集保护	使用后你的所有采集部队进入保护状态，持续3小时
    collect_protect = 608,
}

return attributeID