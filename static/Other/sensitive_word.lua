--[[

 @file:       sensitive_word.lua
 @source xls: excel_3D\Sensitive_word.xlsx
 @sheet name: SENSITIVE_WORD
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local SENSITIVE_WORD = {
	[1] = {word= "习近平", },
	[2] = {word= "平近习", },
	[3] = {word= "xjp", },
	[4] = {word= "习太子", },
	[5] = {word= "习明泽", },
	[6] = {word= "老习", },
	[7] = {word= "温家宝", },
	[8] = {word= "温加宝", },
	[9] = {word= "温x", },
	[10] = {word= "温jia宝", },
	[11] = {word= "温宝宝", },
	[12] = {word= "温加饱", },
	[13] = {word= "温加保", },
	[14] = {word= "张培莉", },
	[15] = {word= "温云松", },
	[16] = {word= "温如春", },
	[17] = {word= "温jb", },
	[18] = {word= "胡温", },
	[19] = {word= "胡x", },
	[20] = {word= "胡jt", },
	[21] = {word= "胡boss", },
	[22] = {word= "胡总", },
	[23] = {word= "胡王八", },
	[24] = {word= "hujintao", },
	[25] = {word= "胡jintao", },
	[26] = {word= "胡j涛", },
	[27] = {word= "胡惊涛", },
	[28] = {word= "胡景涛", },
	[29] = {word= "胡紧掏", },
	[30] = {word= "湖紧掏", },
	[31] = {word= "胡紧套", },
	[32] = {word= "锦涛", },
	[33] = {word= "hjt", },
	[34] = {word= "胡派", },
	[35] = {word= "胡主席", },
	[36] = {word= "刘永清", },
	[37] = {word= "胡海峰", },
	[38] = {word= "胡海清", },
	[39] = {word= "江泽民", },
	[40] = {word= "民泽江", },
	[41] = {word= "江胡", },
	[42] = {word= "江哥", },
	[43] = {word= "江主席", },
	[44] = {word= "江书记", },
	[45] = {word= "江浙闽", },
	[46] = {word= "江沢民", },
	[47] = {word= "江浙民", },
	[48] = {word= "择民", },
	[49] = {word= "则民", },
	[50] = {word= "茳泽民", },
	[51] = {word= "zemin", },
	[52] = {word= "ze民", },
	[53] = {word= "老江", },
	[54] = {word= "老j", },
	[55] = {word= "江core", },
	[56] = {word= "江x", },
	[57] = {word= "江派", },
	[58] = {word= "江zm", },
	[59] = {word= "jzm", },
	[60] = {word= "江戏子", },
	[61] = {word= "江蛤蟆", },
	[62] = {word= "江某某", },
	[63] = {word= "江贼", },
	[64] = {word= "江猪", },
	[65] = {word= "江氏集团", },
	[66] = {word= "江绵恒", },
	[67] = {word= "江绵康", },
	[68] = {word= "王冶坪", },
	[69] = {word= "江泽慧", },
	[70] = {word= "邓小平", },
	[71] = {word= "平小邓", },
	[72] = {word= "xiao平", },
	[73] = {word= "邓xp", },
	[74] = {word= "邓晓平", },
	[75] = {word= "邓朴方", },
	[76] = {word= "邓榕", },
	[77] = {word= "邓质方", },
	[78] = {word= "毛泽东", },
	[79] = {word= "猫泽东", },
	[80] = {word= "猫则东", },
	[81] = {word= "猫贼洞", },
	[82] = {word= "毛zd", },
	[83] = {word= "毛zx", },
	[84] = {word= "z东", },
	[85] = {word= "ze东", },
	[86] = {word= "泽d", },
	[87] = {word= "zedong", },
	[88] = {word= "毛太祖", },
	[89] = {word= "毛相", },
	[90] = {word= "主席画像", },
	[91] = {word= "改革历程", },
	[92] = {word= "朱镕基", },
	[93] = {word= "朱容基", },
	[94] = {word= "朱镕鸡", },
	[95] = {word= "朱容鸡", },
	[96] = {word= "朱云来", },
	[97] = {word= "李鹏", },
	[98] = {word= "李peng", },
	[99] = {word= "里鹏", },
	[100] = {word= "李月月鸟", },
	[101] = {word= "李小鹏", },
	[102] = {word= "李小琳", },
	[103] = {word= "华主席", },
	[104] = {word= "华国", },
	[105] = {word= "国锋", },
	[106] = {word= "国峰", },
	[107] = {word= "锋同志", },
	[108] = {word= "白春礼", },
	[109] = {word= "薄熙来", },
	[110] = {word= "薄一波", },
	[111] = {word= "蔡赴朝", },
	[112] = {word= "蔡武", },
	[113] = {word= "曹刚川", },
	[114] = {word= "常万全", },
	[115] = {word= "陈炳德", },
	[116] = {word= "陈德铭", },
	[117] = {word= "陈建国", },
	[118] = {word= "陈良宇", },
	[119] = {word= "陈绍基", },
	[120] = {word= "陈同海", },
	[121] = {word= "陈至立", },
	[122] = {word= "戴秉国", },
	[123] = {word= "丁一平", },
	[124] = {word= "董建华", },
	[125] = {word= "杜德印", },
	[126] = {word= "杜世成", },
	[127] = {word= "傅锐", },
	[128] = {word= "郭伯雄", },
	[129] = {word= "郭金龙", },
	[130] = {word= "贺国强", },
	[131] = {word= "胡春华", },
	[132] = {word= "耀邦", },
	[133] = {word= "华建敏", },
	[134] = {word= "黄华华", },
	[135] = {word= "黄丽满", },
	[136] = {word= "黄兴国", },
	[137] = {word= "回良玉", },
	[138] = {word= "贾庆林", },
	[139] = {word= "贾廷安", },
	[140] = {word= "靖志远", },
	[141] = {word= "李长春", },
	[142] = {word= "李春城", },
	[143] = {word= "李建国", },
	[144] = {word= "李克强", },
	[145] = {word= "李岚清", },
	[146] = {word= "李沛瑶", },
	[147] = {word= "李荣融", },
	[148] = {word= "李瑞环", },
	[149] = {word= "李铁映", },
	[150] = {word= "李先念", },
	[151] = {word= "李学举", },
	[152] = {word= "李源潮", },
	[153] = {word= "栗智", },
	[154] = {word= "梁光烈", },
	[155] = {word= "廖锡龙", },
	[156] = {word= "林树森", },
	[157] = {word= "林炎志", },
	[158] = {word= "林左鸣", },
	[159] = {word= "令计划", },
	[160] = {word= "柳斌杰", },
	[161] = {word= "刘奇葆", },
	[162] = {word= "刘少奇", },
	[163] = {word= "刘延东", },
	[164] = {word= "刘云山", },
	[165] = {word= "刘志军", },
	[166] = {word= "龙新民", },
	[167] = {word= "路甬祥", },
	[168] = {word= "罗箭", },
	[169] = {word= "吕祖善", },
	[170] = {word= "马飚", },
	[171] = {word= "马恺", },
	[172] = {word= "孟建柱", },
	[173] = {word= "欧广源", },
	[174] = {word= "强卫", },
	[175] = {word= "沈跃跃", },
	[176] = {word= "宋平顺", },
	[177] = {word= "粟戎生", },
	[178] = {word= "苏树林", },
	[179] = {word= "孙家正", },
	[180] = {word= "铁凝", },
	[181] = {word= "屠光绍", },
	[182] = {word= "王东明", },
	[183] = {word= "汪东兴", },
	[184] = {word= "王鸿举", },
	[185] = {word= "王沪宁", },
	[186] = {word= "王乐泉", },
	[187] = {word= "王洛林", },
	[188] = {word= "王岐山", },
	[189] = {word= "王胜俊", },
	[190] = {word= "王太华", },
	[191] = {word= "王学军", },
	[192] = {word= "王兆国", },
	[193] = {word= "王振华", },
	[194] = {word= "吴邦国", },
	[195] = {word= "吴定富", },
	[196] = {word= "吴官正", },
	[197] = {word= "无官正", },
	[198] = {word= "吴胜利", },
	[199] = {word= "吴仪", },
	[200] = {word= "奚国华", },
	[201] = {word= "习仲勋", },
	[202] = {word= "徐才厚", },
	[203] = {word= "许其亮", },
	[204] = {word= "徐绍史", },
	[205] = {word= "杨洁篪", },
	[206] = {word= "叶剑英", },
	[207] = {word= "由喜贵", },
	[208] = {word= "于幼军", },
	[209] = {word= "俞正声", },
	[210] = {word= "袁纯清", },
	[211] = {word= "曾培炎", },
	[212] = {word= "曾庆红", },
	[213] = {word= "曾宪梓", },
	[214] = {word= "曾荫权", },
	[215] = {word= "张德江", },
	[216] = {word= "张定发", },
	[217] = {word= "张高丽", },
	[218] = {word= "张立昌", },
	[219] = {word= "张荣坤", },
	[220] = {word= "张志国", },
	[221] = {word= "赵洪祝", },
	[222] = {word= "紫阳", },
	[223] = {word= "周生贤", },
	[224] = {word= "周永康", },
	[225] = {word= "朱海仑", },
	[226] = {word= "中南海", },
	[227] = {word= "大陆当局", },
	[228] = {word= "中国当局", },
	[229] = {word= "北京当局", },
	[230] = {word= "共产党", },
	[231] = {word= "党产共", },
	[232] = {word= "共贪党", },
	[233] = {word= "阿共", },
	[234] = {word= "产党共", },
	[235] = {word= "公产党", },
	[236] = {word= "工产党", },
	[237] = {word= "共c党", },
	[238] = {word= "共x党", },
	[239] = {word= "共铲", },
	[240] = {word= "供产", },
	[241] = {word= "共惨", },
	[242] = {word= "供铲党", },
	[243] = {word= "供铲谠", },
	[244] = {word= "供铲裆", },
	[245] = {word= "共残党", },
	[246] = {word= "共残主义", },
	[247] = {word= "共产主义的幽灵", },
	[248] = {word= "拱铲", },
	[249] = {word= "老共", },
	[250] = {word= "中共", },
	[251] = {word= "中珙", },
	[252] = {word= "中gong", },
	[253] = {word= "gc党", },
	[254] = {word= "贡挡", },
	[255] = {word= "gong党", },
	[256] = {word= "g产", },
	[257] = {word= "狗产蛋", },
	[258] = {word= "共残裆", },
	[259] = {word= "恶党", },
	[260] = {word= "邪党", },
	[261] = {word= "共产专制", },
	[262] = {word= "共产王朝", },
	[263] = {word= "裆中央", },
	[264] = {word= "土共", },
	[265] = {word= "土g", },
	[266] = {word= "共狗", },
	[267] = {word= "g匪", },
	[268] = {word= "共匪", },
	[269] = {word= "仇共", },
	[270] = {word= "政府", },
	[271] = {word= "症腐", },
	[272] = {word= "政腐", },
	[273] = {word= "政付", },
	[274] = {word= "正府", },
	[275] = {word= "政俯", },
	[276] = {word= "政f", },
	[277] = {word= "zhengfu", },
	[278] = {word= "政zhi", },
	[279] = {word= "挡中央", },
	[280] = {word= "档中央", },
	[281] = {word= "中央领导", },
	[282] = {word= "中国zf", },
	[283] = {word= "中央zf", },
	[284] = {word= "国wu院", },
	[285] = {word= "中华帝国", },
	[286] = {word= "gong和", },
	[287] = {word= "大陆官方", },
	[288] = {word= "北京政权", },
	[289] = {word= "江泽民", },
	[290] = {word= "胡锦涛", },
	[291] = {word= "温家宝", },
	[292] = {word= "习近平", },
	[293] = {word= "习仲勋", },
	[294] = {word= "贺国强", },
	[295] = {word= "贺子珍", },
	[296] = {word= "周永康", },
	[297] = {word= "李长春", },
	[298] = {word= "李德生", },
	[299] = {word= "王岐山", },
	[300] = {word= "姚依林", },
	[301] = {word= "回良玉", },
	[302] = {word= "李源潮", },
	[303] = {word= "李干成", },
	[304] = {word= "戴秉国", },
	[305] = {word= "黄镇", },
	[306] = {word= "刘延东", },
	[307] = {word= "刘瑞龙", },
	[308] = {word= "俞正声", },
	[309] = {word= "黄敬", },
	[310] = {word= "薄熙", },
	[311] = {word= "薄一波", },
	[312] = {word= "周小川", },
	[313] = {word= "周建南", },
	[314] = {word= "温云松", },
	[315] = {word= "徐明", },
	[316] = {word= "江泽慧", },
	[317] = {word= "江绵恒", },
	[318] = {word= "江绵康", },
	[319] = {word= "李小鹏", },
	[320] = {word= "李鹏", },
	[321] = {word= "李小琳", },
	[322] = {word= "朱云来", },
	[323] = {word= "朱容基", },
	[324] = {word= "法轮功", },
	[325] = {word= "李洪志", },
	[326] = {word= "新疆骚乱", },
	[327] = {word= "供应秦氏弓弩", },
	[328] = {word= "供应弩用麻醉箭", },
	[329] = {word= "供应弩捕狗箭", },
	[330] = {word= "供应麻醉箭三步倒", },
	[331] = {word= "供应麻醉箭批发", },
	[332] = {word= "供应麻醉箭", },
	[333] = {word= "供应军用弩折叠弩", },
	[334] = {word= "供应军用弓弩专卖", },
	[335] = {word= "供应精品弓弩", },
	[336] = {word= "供应弓弩麻醉箭", },
	[337] = {word= "供应弓弩", },
	[338] = {word= "供应钢珠弓弩", },
	[339] = {word= "弓弩商城专卖", },
	[340] = {word= "弓弩商城", },
	[341] = {word= "弓弩亲兄弟货到付款", },
	[342] = {word= "弓弩批发", },
	[343] = {word= "弓弩免定金货到付款", },
	[344] = {word= "弓弩麻醉箭", },
	[345] = {word= "弓弩麻醉镖", },
	[346] = {word= "弓弩论坛", },
	[347] = {word= "钢珠弓弩专卖网", },
	[348] = {word= "钢珠弓弩专卖店", },
	[349] = {word= "打狗弓弩三步倒", },
	[350] = {word= "麻醉弓弩专卖店", },
	[351] = {word= "出售军刀", },
	[352] = {word= "出售军刺", },
	[353] = {word= "出售弹簧刀", },
	[354] = {word= "出售三棱刀", },
	[355] = {word= "出售跳刀", },
	[356] = {word= "军刀网", },
	[357] = {word= "南方军刀网", },
	[358] = {word= "户外军刀网", },
	[359] = {word= "三棱军刺专卖", },
	[360] = {word= "出售开山刀军刺", },
	[361] = {word= "西点军刀网", },
	[362] = {word= "军刀专卖", },
	[363] = {word= "戈博军刀", },
	[364] = {word= "阿兰德龙户外", },
	[365] = {word= "出售军品军刀", },
	[366] = {word= "勃朗宁军刀", },
	[367] = {word= "军刀军品网", },
	[368] = {word= "阿兰得龙野营刀具网", },
	[369] = {word= "出售军刺军刀", },
	[370] = {word= "警用刀具出售", },
	[371] = {word= "折刀专卖网", },
	[372] = {word= "阳江军品军刀网", },
	[373] = {word= "野营刀专卖", },
	[374] = {word= "砍刀精品折刀专卖", },
	[375] = {word= "匕首蝴蝶甩刀专卖", },
	[376] = {word= "军刀专卖军刺", },
	[377] = {word= "军刀专卖刀具批发", },
	[378] = {word= "军刀图片砍刀", },
	[379] = {word= "军刀网军刀专卖", },
	[380] = {word= "军刀价格军用刀具", },
	[381] = {word= "军品军刺网", },
	[382] = {word= "军刀军刺甩棍", },
	[383] = {word= "阳江刀具批发网", },
	[384] = {word= "北方先锋军刀", },
	[385] = {word= "正品军刺出售", },
	[386] = {word= "野营军刀出售", },
	[387] = {word= "开山刀砍刀出售", },
	[388] = {word= "仿品军刺出售", },
	[389] = {word= "军刀直刀专卖", },
	[390] = {word= "手工猎刀专卖", },
	[391] = {word= "自动跳刀专卖", },
	[392] = {word= "军刀电棍销售", },
	[393] = {word= "军刀甩棍销售", },
	[394] = {word= "美国军刀出售", },
	[395] = {word= "极端武力折刀", },
	[396] = {word= "防卫棍刀户外刀具", },
	[397] = {word= "阿兰德龙野营刀", },
	[398] = {word= "仿品军刺网", },
	[399] = {word= "野营砍刀户外军刀", },
	[400] = {word= "手工猎刀户外刀具", },
	[401] = {word= "中国户外刀具网", },
	[402] = {word= "西点军品军刀网", },
	[403] = {word= "野营开山刀军刺", },
	[404] = {word= "三利达弓弩军刀", },
	[405] = {word= "尼泊尔军刀出售", },
	[406] = {word= "防卫野营砍刀出售", },
	[407] = {word= "防卫著名军刀出售", },
	[408] = {word= "防卫棍刀出售", },
	[409] = {word= "防卫甩棍出售", },
	[410] = {word= "防卫电棍出售", },
	[411] = {word= "军刺野营砍刀出售", },
	[412] = {word= "著名精品折刀出售", },
	[413] = {word= "战术军刀出售", },
	[414] = {word= "刺刀专卖网", },
	[415] = {word= "户外军刀出售", },
	[416] = {word= "阳江刀具直销网", },
	[417] = {word= "冷钢刀具直销网", },
	[418] = {word= "防卫刀具直销网", },
	[419] = {word= "极端武力直销网", },
	[420] = {word= "刀具直销网", },
	[421] = {word= "军刀直销网", },
	[422] = {word= "直刀匕首直销网", },
	[423] = {word= "军刀匕首直销网", },
	[424] = {word= "折刀砍刀军品网", },
	[425] = {word= "野营刀具军品网", },
	[426] = {word= "阳江刀具军品网", },
	[427] = {word= "冷钢刀具军品网", },
	[428] = {word= "防卫刀具军品网", },
	[429] = {word= "极端武力军品网", },
	[430] = {word= "军用刀具军品网", },
	[431] = {word= "军刀直刀军品网", },
	[432] = {word= "折刀砍刀专卖", },
	[433] = {word= "野营刀具专卖", },
	[434] = {word= "阳江刀具专卖", },
	[435] = {word= "冷钢刀具专卖", },
	[436] = {word= "防卫刀具专卖", },
	[437] = {word= "出售美军现役军刀", },
	[438] = {word= "兼职", },
	[439] = {word= "招聘", },
	[440] = {word= "网络", },
	[441] = {word= "QQ", },
	[442] = {word= "招聘", },
	[443] = {word= "有意者", },
	[444] = {word= "到货", },
	[445] = {word= "本店", },
	[446] = {word= "代购", },
	[447] = {word= "扣扣", },
	[448] = {word= "客服", },
	[449] = {word= "微店", },
	[450] = {word= "兼职", },
	[451] = {word= "兼值", },
	[452] = {word= "淘宝", },
	[453] = {word= "小姐", },
	[454] = {word= "妓女", },
	[455] = {word= "包夜", },
	[456] = {word= "3P", },
	[457] = {word= "LY", },
	[458] = {word= "JS", },
	[459] = {word= "狼友", },
	[460] = {word= "技师", },
	[461] = {word= "推油", },
	[462] = {word= "胸推", },
	[463] = {word= "BT", },
	[464] = {word= "毒龙", },
	[465] = {word= "口爆", },
	[466] = {word= "兼职", },
	[467] = {word= "楼凤", },
	[468] = {word= "足交", },
	[469] = {word= "口暴", },
	[470] = {word= "口交", },
	[471] = {word= "全套", },
	[472] = {word= "SM", },
	[473] = {word= "桑拿", },
	[474] = {word= "吞精", },
	[475] = {word= "咪咪", },
	[476] = {word= "婊子", },
	[477] = {word= "乳方", },
	[478] = {word= "操逼", },
	[479] = {word= "全职", },
	[480] = {word= "性伴侣", },
	[481] = {word= "网购", },
	[482] = {word= "网络工作", },
	[483] = {word= "代理", },
	[484] = {word= "专业代理", },
	[485] = {word= "帮忙点一下", },
	[486] = {word= "帮忙点下", },
	[487] = {word= "请点击进入", },
	[488] = {word= "详情请进入", },
	[489] = {word= "私人侦探", },
	[490] = {word= "私家侦探", },
	[491] = {word= "针孔摄象", },
	[492] = {word= "调查婚外情", },
	[493] = {word= "信用卡提现", },
	[494] = {word= "无抵押贷款", },
	[495] = {word= "广告代理", },
	[496] = {word= "原音铃声", },
	[497] = {word= "借腹生子", },
	[498] = {word= "找个妈妈", },
	[499] = {word= "找个爸爸", },
	[500] = {word= "代孕妈妈", },
	[501] = {word= "代生孩子", },
	[502] = {word= "代开发票", },
	[503] = {word= "腾讯客服电话", },
	[504] = {word= "销售热线", },
	[505] = {word= "免费订购热线", },
	[506] = {word= "低价出售", },
	[507] = {word= "款到发货", },
	[508] = {word= "回复可见", },
	[509] = {word= "连锁加盟", },
	[510] = {word= "加盟连锁", },
	[511] = {word= "免费二级域名", },
	[512] = {word= "免费使用", },
	[513] = {word= "免费索取", },
	[514] = {word= "蚁力神", },
	[515] = {word= "婴儿汤", },
	[516] = {word= "售肾", },
	[517] = {word= "刻章办", },
	[518] = {word= "买小车", },
	[519] = {word= "套牌车", },
	[520] = {word= "玛雅网", },
	[521] = {word= "电脑传讯", },
	[522] = {word= "视频来源", },
	[523] = {word= "下载速度", },
	[524] = {word= "高清在线", },
	[525] = {word= "全集在线", },
	[526] = {word= "在线播放", },
	[527] = {word= "txt下载", },
	[528] = {word= "六位qq", },
	[529] = {word= "6位qq", },
	[530] = {word= "位的qq", },
	[531] = {word= "个qb", },
	[532] = {word= "送qb", },
	[533] = {word= "用刀横向切腹", },
	[534] = {word= "完全自杀手册", },
	[535] = {word= "四海帮", },
	[536] = {word= "足球投注", },
	[537] = {word= "地下钱庄", },
	[538] = {word= "中国复兴党", },
	[539] = {word= "阿波罗网", },
	[540] = {word= "曾道人", },
	[541] = {word= "六合彩", },
	[542] = {word= "改卷内幕", },
	[543] = {word= "替考试", },
	[544] = {word= "隐形耳机", },
	[545] = {word= "出售答案", },
	[546] = {word= "考中答案", },
	[547] = {word= "答an", },
	[548] = {word= "da案", },
	[549] = {word= "资金周转", },
	[550] = {word= "救市", },
	[551] = {word= "股市圈钱", },
	[552] = {word= "崩盘", },
	[553] = {word= "资金短缺", },
	[554] = {word= "证监会", },
	[555] = {word= "质押贷款", },
	[556] = {word= "小额贷款", },
	[557] = {word= "周小川", },
	[558] = {word= "刘明康", },
	[559] = {word= "尚福林", },
	[560] = {word= "孔丹", },
	[561] = {word= "汽油三分之一白糖混合", },
	[562] = {word= "炸药的制作配方", },
	[563] = {word= "燃烧弹的制作方", },
	[564] = {word= "炸药的配方", },
	[565] = {word= "如何自制燃烧弹", },
	[566] = {word= "标准炸弹教程", },
	[567] = {word= "黑火药和硝酸钾农药混合", },
	[568] = {word= "恐怖分子自己制造炸弹", },
	[569] = {word= "手柄制作炸弹引爆器", },
	[570] = {word= "制作炸弹首先要", },
	[571] = {word= "燃烧瓶制作", },
	[572] = {word= "出售炸药QQ", },
	[573] = {word= "出售气枪", },
	[574] = {word= "出售气枪QQ", },
	[575] = {word= "出售气枪电话", },
	[576] = {word= "出售手枪", },
	[577] = {word= "出售手枪QQ", },
	[578] = {word= "出售手枪电话", },
	[579] = {word= "出售猎枪", },
	[580] = {word= "出售猎枪QQ", },
	[581] = {word= "出售猎枪电话", },
	[582] = {word= "出售汽枪", },
	[583] = {word= "出售步枪", },
	[584] = {word= "出售狙击枪", },
	[585] = {word= "出售手狗", },
	[586] = {word= "出售气狗", },
	[587] = {word= "出售猎狗", },
	[588] = {word= "【手枪出售】联系电话", },
	[589] = {word= "64式手枪出售", },
	[590] = {word= "92式手枪出售", },
	[591] = {word= "出售:高仿真枪", },
	[592] = {word= "出售54式手枪", },
	[593] = {word= "出售M1911", },
	[594] = {word= "出售各类猎狗", },
	[595] = {word= "出售国产军用54手枪", },
	[596] = {word= "出售火枪–游戏", },
	[597] = {word= "出售进口金属枪模", },
	[598] = {word= "出售仿真枪", },
	[599] = {word= "出售麻醉枪免收任何定金", },
	[600] = {word= "出售手枪=货到付款", },
	[601] = {word= "出售外国枪模", },
	[602] = {word= "出售袖珍手枪", },
	[603] = {word= "娥眉气枪出售", },
	[604] = {word= "防身手枪QQ", },
	[605] = {word= "防身武器手枪", },
	[606] = {word= "仿真枪QQ", },
	[607] = {word= "钢珠枪小口径步枪", },
	[608] = {word= "高压狗QQ", },
	[609] = {word= "高压气枪气枪子弹", },
	[610] = {word= "高压气枪|电狗专卖", },
	[611] = {word= "高压气枪|气枪货到付款", },
	[612] = {word= "高压气枪专卖店", },
	[613] = {word= "各类军用枪", },
	[614] = {word= "各类军用枪支", },
	[615] = {word= "各式气枪出售", },
	[616] = {word= "工字牌气枪出售专卖", },
	[617] = {word= "气枪", },
	[618] = {word= "工字汽狗麻醉枪", },
	[619] = {word= "供应军用手枪", },
	[620] = {word= "供应汽枪", },
	[621] = {word= "购买枪支QQ", },
	[622] = {word= "国产汽狗专卖|气枪货", },
	[623] = {word= "集团出售手枪", },
	[624] = {word= "集团出售手枪气枪", },
	[625] = {word= "进口气枪气枪子弹", },
	[626] = {word= "军用54出售", },
	[627] = {word= "军用77出售", },
	[628] = {word= "军用手枪钢珠枪", },
	[629] = {word= "里有汽枪出售", },
	[630] = {word= "猎枪出售/枪", },
	[631] = {word= "猎枪仿真枪QQ", },
	[632] = {word= "猎枪麻醉枪钢珠枪", },
	[633] = {word= "猎枪哪里有卖", },
	[634] = {word= "猎枪手枪买卖", },
	[635] = {word= "猎枪销售手枪销售气枪", },
	[636] = {word= "猎枪专卖店", },
	[637] = {word= "猎枪子弹底火专卖", },
	[638] = {word= "麻醉枪出售可验货", },
	[639] = {word= "麻醉枪猎枪军用", },
	[640] = {word= "买卖54狗", },
	[641] = {word= "买卖64狗", },
	[642] = {word= "买卖警察枪支", },
	[643] = {word= "买卖军狗", },
	[644] = {word= "买卖军用枪支", },
	[645] = {word= "卖64手枪", },
	[646] = {word= "卖92手枪", },
	[647] = {word= "卖钢珠枪QQ", },
	[648] = {word= "哪里能买到自制手枪", },
	[649] = {word= "哪里有钢珠枪", },
	[650] = {word= "哪里有连发猎枪买卖", },
	[651] = {word= "哪里有卖双管猎", },
	[652] = {word= "哪里有气枪卖", },
	[653] = {word= "哪里有枪出售", },
	[654] = {word= "哪里有真枪出售", },
	[655] = {word= "哪里有真枪卖买", },
	[656] = {word= "哪能买到真枪", },
	[657] = {word= "期出售手枪气枪猎", },
	[658] = {word= "气狗高压气枪", },
	[659] = {word= "气狗出售进口气狗", },
	[660] = {word= "气枪专卖网", },
	[661] = {word= "气枪/出售/专卖网", },
	[662] = {word= "气枪/猎枪/钢珠枪", },
	[663] = {word= "气枪仿真枪出售", },
	[664] = {word= "气枪购买|气枪组装", },
	[665] = {word= "气枪货到付款汽狗出售", },
	[666] = {word= "气枪价格仿真气枪", },
	[667] = {word= "气枪价格气枪专卖店", },
	[668] = {word= "气枪看货加QQ", },
	[669] = {word= "气枪联系QQ", },
	[670] = {word= "气枪猎枪麻醉枪", },
	[671] = {word= "气枪迷魂药", },
	[672] = {word= "汽狗高压汽枪", },
	[673] = {word= "铅弹上海工字气枪", },
	[674] = {word= "全金属仿真枪专卖", },
	[675] = {word= "热武器QQ", },
	[676] = {word= "三箭气枪出售", },
	[677] = {word= "手枪气*枪猎", },
	[678] = {word= "手槍买卖自制手枪", },
	[679] = {word= "售枪购买手枪", },
	[680] = {word= "售手枪QQ", },
	[681] = {word= "司马仿真枪模型QQ", },
	[682] = {word= "淘宝气枪货到付款", },
	[683] = {word= "提供气狗专卖店", },
	[684] = {word= "提供专业及时的气狗", },
	[685] = {word= "秃鹰气枪货到付款", },
	[686] = {word= "锡峰气枪出售", },
	[687] = {word= "仙鹤气枪出售", },
	[688] = {word= "销售/专卖/买卖77式手枪", },
	[689] = {word= "销售电手狗", },
	[690] = {word= "销售气手狗", },
	[691] = {word= "销售小口径步枪", },
	[692] = {word= "销售运动步枪", },
	[693] = {word= "小口径秃鹰沙漠", },
	[694] = {word= "有军用枪支出售", },
	[695] = {word= "长期出售手枪", },
	[696] = {word= "折叠狗QQ", },
	[697] = {word= "转让猎枪", },
	[698] = {word= "子弹货到付款", },
	[699] = {word= "自制手枪哪里买", },
	[700] = {word= "自制手枪哪里有卖", },
	[701] = {word= "阻击枪/汽枪/高压气枪", },
	[702] = {word= "组装手枪", },
	[703] = {word= "最新销售汽狗", },
	[704] = {word= "出售警用手铐|仿真枪", },
	[705] = {word= "猎枪|真枪", },
	[706] = {word= "手枪|阻击枪", },
	[707] = {word= "弓弩专营", },
	[708] = {word= "弓弩专卖网货到付款", },
	[709] = {word= "弓弩专卖网", },
	[710] = {word= "弓弩专卖货到付款", },
	[711] = {word= "弓弩专卖店网", },
	[712] = {word= "弓弩专卖店", },
	[713] = {word= "弓弩专卖", },
	[714] = {word= "弓弩制作", },
	[715] = {word= "弓弩直销", },
	[716] = {word= "弓弩有限公司", },
	[717] = {word= "弓弩营销中心", },
	[718] = {word= "弓弩一百专卖店", },
	[719] = {word= "弓弩销售", },
	[720] = {word= "弓弩网", },
	[721] = {word= "弓弩网", },
	[722] = {word= "弓弩图纸", },
	[723] = {word= "弓弩特许经销", },
	[724] = {word= "弓弩狩猎网", },
	[725] = {word= "自制手弩", },
	[726] = {word= "追风弓弩麻醉箭专卖", },
	[727] = {word= "专业弓弩网", },
	[728] = {word= "中国战神军用弓弩", },
	[729] = {word= "中国弩弓专卖", },
	[730] = {word= "中国弓弩专卖网", },
	[731] = {word= "中国弓弩直销", },
	[732] = {word= "中国弓弩网", },
	[733] = {word= "中国弓弩狩猎网", },
	[734] = {word= "中国弓驽网", },
	[735] = {word= "制作简易弓弩", },
	[736] = {word= "郑州弓弩专卖", },
	[737] = {word= "赵氏弓弩专卖网", },
	[738] = {word= "赵氏弓弩专卖店", },
	[739] = {word= "赵氏弓弩专卖", },
	[740] = {word= "赵氏弓弩销售", },
	[741] = {word= "小型弓弩专卖店", },
	[742] = {word= "小猎人弓弩网", },
	[743] = {word= "狩猎器材弓弩专卖", },
	[744] = {word= "狩猎器材弓弩", },
	[745] = {word= "狩猎弓弩专卖网", },
	[746] = {word= "狩猎弓弩专卖", },
	[747] = {word= "狩猎弓弩麻醉箭", },
	[748] = {word= "手枪式折叠三用弩", },
	[749] = {word= "三利达弓弩专卖网", },
	[750] = {word= "三利达弓弩直营", },
	[751] = {word= "三利达弓弩配件", },
	[752] = {word= "三步倒药箭批发", },
	[753] = {word= "三步倒弩箭专卖", },
	[754] = {word= "三步倒麻醉弩箭销售", },
	[755] = {word= "三步倒麻醉箭专卖", },
	[756] = {word= "三步倒麻醉箭", },
	[757] = {word= "三步倒捕狗药", },
	[758] = {word= "军用弓弩专卖网", },
	[759] = {word= "军用弓弩专卖店", },
	[760] = {word= "军用弓弩批发", },
	[761] = {word= "军用弓弩公司", },
	[762] = {word= "供应三利达弓弩麻醉箭", },
	[763] = {word= "供应三步倒麻醉箭", },
	[764] = {word= "出售雷管", },
	[765] = {word= "炸药", },
	[766] = {word= "炸药", },
	[767] = {word= "出售炸药", },
	[768] = {word= "出售炸药电话", },
	[769] = {word= "制作火药配方", },
	[770] = {word= "炸药出售", },
	[771] = {word= "出售雷管炸药", },
	[772] = {word= "火药配方", },
	[773] = {word= "在家里做原子弹", },
	[774] = {word= "硝酸甘油炸弹制作", },
	[775] = {word= "TNT炸弹的制作", },
	[776] = {word= "硝铵炸药配方", },
	[777] = {word= "硝酸甘油制作", },
	[778] = {word= "炸弹配方", },
	[779] = {word= "简易炸药", },
	[780] = {word= "火药制作简易炸弹", },
	[781] = {word= "炸弹制作", },
	[782] = {word= "硝酸甘油", },
	[783] = {word= "硝酸甘油炸弹制作方法", },
	[784] = {word= "手把手教你做炸弹", },
	[785] = {word= "恐怖分子傻瓜手册", },
	[786] = {word= "氢弹手工制作方法", },
	[787] = {word= "起爆器", },
	[788] = {word= "自制燃烧弹", },
	[789] = {word= "燃烧弹", },
	[790] = {word= "弹药制造方法", },
	[791] = {word= "液体炸药配方", },
	[792] = {word= "炸药配方与制作", },
	[793] = {word= "自制炸药配方", },
	[794] = {word= "tnt炸药成分", },
	[795] = {word= "炸药的制作", },
	[796] = {word= "tnt炸药配方", },
	[797] = {word= "各种炸药配方大全", },
	[798] = {word= "炸药的成分", },
	[799] = {word= "燃烧弹的制作方", },
	[800] = {word= "黑火药的配方", },
	[801] = {word= "黑火药的制作", },
	[802] = {word= "黑火药比例", },
	[803] = {word= "燃烧弹制作", },
	[804] = {word= "黑火药配方比例", },
	[805] = {word= "黑火药的成分", },
	[806] = {word= "原子弹配方", },
	[807] = {word= "原子弹DIY教程", },
	[808] = {word= "C4炸药", },
	[809] = {word= "雷管出售", },
	[810] = {word= "制作硝化甘油", },
	[811] = {word= "DIY核弹", },
	[812] = {word= "核弹制作方法", },
	[813] = {word= "原子弹制作手册", },
	[814] = {word= "简易原子弹教程", },
	[815] = {word= "黑火药配方", },
	[816] = {word= "自制炸药方法", },
	[817] = {word= "教你怎么用土办法做武器", },
	[818] = {word= "莫洛托夫鸡尾酒的配方", },
	[819] = {word= "zz炸弹的制作方法", },
	[820] = {word= "C4炸药的成分", },
	[821] = {word= "炸药制造生产工艺", },
	[822] = {word= "原子弹制造完全手册", },
	[823] = {word= "「红烧兔子」大餐", },
	[824] = {word= "汽车炸弹制作", },
	[825] = {word= "人体炸弹制作流程", },
	[826] = {word= "炸弹制作从入门", },
	[827] = {word= "鸡尾酒炸弹制作", },
	[828] = {word= "集束炸弹制作", },
	[829] = {word= "硝酸铵的简便制取方法", },
	[830] = {word= "莫洛托夫燃烧弹", },
	[831] = {word= "塑胶炸弹", },
	[832] = {word= "用火药混合塑料", },
	[833] = {word= "高性能爆炸物质混合", },
	[834] = {word= "原子弹制作方法", },
	[835] = {word= "手教你制作原子弹", },
	[836] = {word= "轻型巡航导弹的制作", },
	[837] = {word= "黑索金的制造过程", },
	[838] = {word= "Zha药制造进程", },
	[839] = {word= "购买自爆材料", },
	[840] = {word= "可塑炸弹制作方法", },
	[841] = {word= "C4塑胶炸药", },
	[842] = {word= "水浴法制TNT", },
	[843] = {word= "简易核弹头的制造", },
	[844] = {word= "高爆炸药的基本配方", },
	[845] = {word= "如何制硝化甘油", },
	[846] = {word= "燃烧剂的简易制备", },
	[847] = {word= "简易大威力炸弹", },
	[848] = {word= "炸弹制作入门", },
	[849] = {word= "硝酸甘油炸药制作", },
	[850] = {word= "基本配方是硝酸甘", },
	[851] = {word= "燃烧剂的简易制作", },
	[852] = {word= "制作性能优良的燃烧弹", },
	[853] = {word= "酸甘油炸药", },
	[854] = {word= "简易导弹制作", },
	[855] = {word= "核弹头的制造", },
	[856] = {word= "可塑炸弹制作", },
	[857] = {word= "炸药硝酸甘油制法", },
	[858] = {word= "原子弹制作方法", },
	[859] = {word= "火药的配方", },
	[860] = {word= "手教你做原子弹", },
	[861] = {word= "怎么用土办法做武器", },
	[862] = {word= "手把手教你制作原子弹", },
	[863] = {word= "燃烧弹的制作方法", },
	[864] = {word= "怎么自制燃烧弹", },
	[865] = {word= "TNT炸弹制作", },
	[866] = {word= "高爆炸药基本配方", },
	[867] = {word= "爆破和杀伤燃烧弹", },
	[868] = {word= "炸弹制作从入门到精", },
	[869] = {word= "写的炸弹制作教程", },
	[870] = {word= "原子弹制作方法", },
	[871] = {word= "教你制作原子弹", },
	[872] = {word= "下硝化甘油的制作方法", },
	[873] = {word= "DIY原子弹", },
	[874] = {word= "原子弹制作", },
	[875] = {word= "炸药及其制造方法", },
	[876] = {word= "ATOM弹制造", },
	[877] = {word= "三分钟教你原子弹", },
	[878] = {word= "火药原理", },
	[879] = {word= "简易炸弹", },
	[880] = {word= "简易燃烧弹", },
	[881] = {word= "土炸药成份", },
	[882] = {word= "你怎么用土办法做武器", },
	[883] = {word= "燃烧弹制作", },
	[884] = {word= "燃烧瓶的制作方法", },
	[885] = {word= "炸弹制作手册硫酸", },
	[886] = {word= "原子弹制作方法DIY", },
	[887] = {word= "摸胸", },
	[888] = {word= "母奸", },
	[889] = {word= "奈美", },
	[890] = {word= "奶子", },
	[891] = {word= "男奴", },
	[892] = {word= "内射", },
	[893] = {word= "嫩逼", },
	[894] = {word= "嫩女", },
	[895] = {word= "嫩穴", },
	[896] = {word= "捏弄", },
	[897] = {word= "女优", },
	[898] = {word= "炮友", },
	[899] = {word= "砲友", },
	[900] = {word= "喷精", },
	[901] = {word= "屁眼", },
	[902] = {word= "前凸后翘", },
	[903] = {word= "强jian", },
	[904] = {word= "强暴", },
	[905] = {word= "强奸处女", },
	[906] = {word= "情趣用品", },
	[907] = {word= "情色", },
	[908] = {word= "拳交", },
	[909] = {word= "全裸", },
	[910] = {word= "群交", },
	[911] = {word= "人妻", },
	[912] = {word= "人兽", },
	[913] = {word= "日逼", },
	[914] = {word= "日烂", },
	[915] = {word= "肉棒", },
	[916] = {word= "肉逼", },
	[917] = {word= "肉唇", },
	[918] = {word= "肉洞", },
	[919] = {word= "肉缝", },
	[920] = {word= "肉棍", },
	[921] = {word= "肉茎", },
	[922] = {word= "肉具", },
	[923] = {word= "揉乳", },
	[924] = {word= "肉穴", },
	[925] = {word= "肉欲", },
	[926] = {word= "乳爆", },
	[927] = {word= "乳房", },
	[928] = {word= "乳沟", },
	[929] = {word= "乳交", },
	[930] = {word= "乳头", },
	[931] = {word= "骚逼", },
	[932] = {word= "骚比", },
	[933] = {word= "骚女", },
	[934] = {word= "骚水", },
	[935] = {word= "骚穴", },
	[936] = {word= "色逼", },
	[937] = {word= "色界", },
	[938] = {word= "色猫", },
	[939] = {word= "色盟", },
	[940] = {word= "色情网站", },
	[941] = {word= "色区", },
	[942] = {word= "色色", },
	[943] = {word= "色诱", },
	[944] = {word= "色欲", },
	[945] = {word= "色b", },
	[946] = {word= "少年阿宾", },
	[947] = {word= "射爽", },
	[948] = {word= "射颜", },
	[949] = {word= "食精", },
	[950] = {word= "释欲", },
	[951] = {word= "兽奸", },
	[952] = {word= "兽交", },
	[953] = {word= "手淫", },
	[954] = {word= "兽欲", },
	[955] = {word= "熟妇", },
	[956] = {word= "熟母", },
	[957] = {word= "熟女", },
	[958] = {word= "爽片", },
	[959] = {word= "双臀", },
	[960] = {word= "死逼", },
	[961] = {word= "丝袜", },
	[962] = {word= "丝诱", },
	[963] = {word= "松岛枫", },
	[964] = {word= "酥痒", },
	[965] = {word= "汤加丽", },
	[966] = {word= "套弄", },
	[967] = {word= "体奸", },
	[968] = {word= "体位", },
	[969] = {word= "舔脚", },
	[970] = {word= "舔阴", },
	[971] = {word= "调教", },
	[972] = {word= "偷欢", },
	[973] = {word= "推油", },
	[974] = {word= "脱内裤", },
	[975] = {word= "文做", },
	[976] = {word= "舞女", },
	[977] = {word= "无修正", },
	[978] = {word= "吸精", },
	[979] = {word= "夏川纯", },
	[980] = {word= "相奸", },
	[981] = {word= "小逼", },
	[982] = {word= "校鸡", },
	[983] = {word= "小穴", },
	[984] = {word= "小xue", },
	[985] = {word= "性感妖娆", },
	[986] = {word= "性感诱惑", },
	[987] = {word= "性虎", },
	[988] = {word= "性饥渴", },
	[989] = {word= "性技巧", },
	[990] = {word= "性交", },
	[991] = {word= "性奴", },
	[992] = {word= "性虐", },
	[993] = {word= "性息", },
	[994] = {word= "性欲", },
	[995] = {word= "胸推", },
	[996] = {word= "穴口", },
	[997] = {word= "穴图", },
	[998] = {word= "亚情", },
	[999] = {word= "颜射", },
	[1000] = {word= "阳具", },
	[1001] = {word= "杨思敏", },
	[1002] = {word= "要射了", },
	[1003] = {word= "夜勤病栋", },
	[1004] = {word= "一本道", },
	[1005] = {word= "一夜欢", },
	[1006] = {word= "一夜情", },
	[1007] = {word= "一ye情", },
	[1008] = {word= "阴部", },
	[1009] = {word= "淫虫", },
	[1010] = {word= "阴唇", },
	[1011] = {word= "淫荡", },
	[1012] = {word= "阴道", },
	[1013] = {word= "淫电影", },
	[1014] = {word= "阴阜", },
	[1015] = {word= "淫妇", },
	[1016] = {word= "淫河", },
	[1017] = {word= "阴核", },
	[1018] = {word= "阴户", },
	[1019] = {word= "淫贱", },
	[1020] = {word= "淫叫", },
	[1021] = {word= "淫教师", },
	[1022] = {word= "阴茎", },
	[1023] = {word= "阴精", },
	[1024] = {word= "淫浪", },
	[1025] = {word= "淫媚", },
	[1026] = {word= "淫糜", },
	[1027] = {word= "淫魔", },
	[1028] = {word= "淫母", },
	[1029] = {word= "淫女", },
	[1030] = {word= "淫虐", },
	[1031] = {word= "淫妻", },
	[1032] = {word= "淫情", },
	[1033] = {word= "淫色", },
	[1034] = {word= "淫声浪语", },
	[1035] = {word= "淫兽学园", },
	[1036] = {word= "淫书", },
	[1037] = {word= "淫术炼金士", },
	[1038] = {word= "淫水", },
	[1039] = {word= "淫娃", },
	[1040] = {word= "淫威", },
	[1041] = {word= "淫亵", },
	[1042] = {word= "淫样", },
	[1043] = {word= "淫液", },
	[1044] = {word= "淫照", },
	[1045] = {word= "阴b", },
	[1046] = {word= "应召", },
	[1047] = {word= "幼交", },
	[1048] = {word= "欲火", },
	[1049] = {word= "欲女", },
	[1050] = {word= "玉乳", },
	[1051] = {word= "玉穴", },
	[1052] = {word= "援交", },
	[1053] = {word= "原味内衣", },
	[1054] = {word= "援助交际", },
	[1055] = {word= "招鸡", },
	[1056] = {word= "招妓", },
	[1057] = {word= "抓胸", },
	[1058] = {word= "自慰", },
	[1059] = {word= "作爱", },
	[1060] = {word= "a片", },
	[1061] = {word= "fuck", },
	[1062] = {word= "gay片", },
	[1063] = {word= "g点", },
	[1064] = {word= "h动画", },
	[1065] = {word= "h动漫", },
	[1066] = {word= "失身粉", },
	[1067] = {word= "淫荡自慰器", },
	[1068] = {word= "爱液", },
	[1069] = {word= "按摩棒", },
	[1070] = {word= "拔出来", },
	[1071] = {word= "爆草", },
	[1072] = {word= "包二奶", },
	[1073] = {word= "暴干", },
	[1074] = {word= "暴奸", },
	[1075] = {word= "暴乳", },
	[1076] = {word= "爆乳", },
	[1077] = {word= "暴淫", },
	[1078] = {word= "被操", },
	[1079] = {word= "被插", },
	[1080] = {word= "被干", },
	[1081] = {word= "逼奸", },
	[1082] = {word= "仓井空", },
	[1083] = {word= "插暴", },
	[1084] = {word= "操逼", },
	[1085] = {word= "操黑", },
	[1086] = {word= "操烂", },
	[1087] = {word= "肏你", },
	[1088] = {word= "肏死", },
	[1089] = {word= "操死", },
	[1090] = {word= "操我", },
	[1091] = {word= "厕奴", },
	[1092] = {word= "插比", },
	[1093] = {word= "插b", },
	[1094] = {word= "插逼", },
	[1095] = {word= "插进", },
	[1096] = {word= "插你", },
	[1097] = {word= "插我", },
	[1098] = {word= "插阴", },
	[1099] = {word= "潮吹", },
	[1100] = {word= "潮喷", },
	[1101] = {word= "成人电影", },
	[1102] = {word= "成人论坛", },
	[1103] = {word= "成人色情", },
	[1104] = {word= "成人网站", },
	[1105] = {word= "成人文学", },
	[1106] = {word= "成人小说", },
	[1107] = {word= "艳情小说", },
	[1108] = {word= "成人游戏", },
	[1109] = {word= "吃精", },
	[1110] = {word= "抽插", },
	[1111] = {word= "春药", },
	[1112] = {word= "大波", },
	[1113] = {word= "大力抽送", },
	[1114] = {word= "大乳", },
	[1115] = {word= "荡妇", },
	[1116] = {word= "荡女", },
	[1117] = {word= "盗撮", },
	[1118] = {word= "发浪", },
	[1119] = {word= "放尿", },
	[1120] = {word= "肥逼", },
	[1121] = {word= "粉穴", },
	[1122] = {word= "风月大陆", },
	[1123] = {word= "干死你", },
	[1124] = {word= "干穴", },
	[1125] = {word= "肛交", },
	[1126] = {word= "肛门", },
	[1127] = {word= "龟头", },
	[1128] = {word= "裹本", },
	[1129] = {word= "国产av", },
	[1130] = {word= "好嫩", },
	[1131] = {word= "豪乳", },
	[1132] = {word= "黑逼", },
	[1133] = {word= "后庭", },
	[1134] = {word= "后穴", },
	[1135] = {word= "虎骑", },
	[1136] = {word= "换妻俱乐部", },
	[1137] = {word= "黄片", },
	[1138] = {word= "几吧", },
	[1139] = {word= "鸡吧", },
	[1140] = {word= "鸡巴", },
	[1141] = {word= "鸡奸", },
	[1142] = {word= "妓女", },
	[1143] = {word= "奸情", },
	[1144] = {word= "叫床", },
	[1145] = {word= "脚交", },
	[1146] = {word= "精液", },
	[1147] = {word= "就去日", },
	[1148] = {word= "巨屌", },
	[1149] = {word= "菊花洞", },
	[1150] = {word= "菊门", },
	[1151] = {word= "巨奶", },
	[1152] = {word= "巨乳", },
	[1153] = {word= "菊穴", },
	[1154] = {word= "开苞", },
	[1155] = {word= "口爆", },
	[1156] = {word= "口活", },
	[1157] = {word= "口交", },
	[1158] = {word= "口射", },
	[1159] = {word= "口淫", },
	[1160] = {word= "裤袜", },
	[1161] = {word= "狂操", },
	[1162] = {word= "狂插", },
	[1163] = {word= "浪逼", },
	[1164] = {word= "浪妇", },
	[1165] = {word= "浪叫", },
	[1166] = {word= "浪女", },
	[1167] = {word= "狼友", },
	[1168] = {word= "聊性", },
	[1169] = {word= "凌辱", },
	[1170] = {word= "漏乳", },
	[1171] = {word= "露b", },
	[1172] = {word= "乱交", },
	[1173] = {word= "乱伦", },
	[1174] = {word= "轮暴", },
	[1175] = {word= "轮操", },
	[1176] = {word= "轮奸", },
	[1177] = {word= "裸陪", },
	[1178] = {word= "买春", },
	[1179] = {word= "美逼", },
	[1180] = {word= "美少妇", },
	[1181] = {word= "美乳", },
	[1182] = {word= "美腿", },
	[1183] = {word= "美穴", },
	[1184] = {word= "美幼", },
	[1185] = {word= "秘唇", },
	[1186] = {word= "迷奸", },
	[1187] = {word= "密穴", },
	[1188] = {word= "蜜穴", },
	[1189] = {word= "蜜液", },
	[1190] = {word= "摸奶", },
};return SENSITIVE_WORD