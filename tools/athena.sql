-- 导出  表 Athena.d_account 结构
DROP TABLE IF EXISTS `d_account`;
CREATE TABLE `d_account` (
  `id` INT(11) unsigned NOT NULL COMMENT '系统编号，对应d_user表的uid',
  `pid` varchar(50) NOT NULL COMMENT '玩家登录名',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `sdkid` INT(11) unsigned NOT NULL COMMENT '分区号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pid_sdkid` (`pid`,`sdkid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='帐号表';

-- 导出  表 Athena.d_user 结构
DROP TABLE IF EXISTS `s_admin`;
CREATE TABLE `s_admin` (
  `id` INT(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `password` varchar(50) NOT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员';

-- 导出  表 Athena.d_user 结构
DROP TABLE IF EXISTS `d_user`;
CREATE TABLE `d_user` (
  `id` INT(11) unsigned NOT NULL COMMENT '玩家ID',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `level` INT(11) unsigned NOT NULL DEFAULT '0' COMMENT '段位',
  `exp` INT(11) unsigned NOT NULL DEFAULT '0' COMMENT '经验',
  `imgcfgid` INT(11) unsigned NOT NULL DEFAULT '0' COMMENT '头像配置表id',
  `description` varchar(100) COMMENT '介绍',
  `showid` INT(11) unsigned COMMENT '展示机甲id',
  `rtime` INT(10) unsigned NOT NULL COMMENT '注册时间',
  `ltime` INT(10) unsigned NOT NULL COMMENT '最后一次登陆时间',
  `etime` INT(10) unsigned NOT NULL COMMENT '最后一次退出时间',
  `onlinetime` INT(10) unsigned NOT NULL COMMENT '游戏时长',
  `daytime` INT(10) unsigned NOT NULL COMMENT '一天中游戏时长',
  `addictiontime` INT(10) unsigned COMMENT '结束防沉迷时间',
  `age` INT(3) unsigned NOT NULL COMMENT '年龄',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家角色表';

-- 导出  表 Athena.d_playerattribute 结构
DROP TABLE IF EXISTS `d_playerattribute`;
CREATE TABLE `d_playerattribute` (
  `id` INT(11) unsigned NOT NULL COMMENT '玩家ID',
  `life` INT(11) NOT NULL DEFAULT '0' COMMENT '生命',
  `speed` INT(11) NOT NULL DEFAULT '0' COMMENT '速度',
  `energy` INT(11) NOT NULL DEFAULT '0' COMMENT '能量',
  `shield` INT(11) NOT NULL DEFAULT '0' COMMENT '护盾值',
  `elevation` INT(11) NOT NULL DEFAULT '0' COMMENT '仰角',
  `overhang` INT(11) NOT NULL DEFAULT '0' COMMENT '俯角',
  `enefficiency` float NOT NULL DEFAULT '0' COMMENT '能量效率',
  `efficiency` float NOT NULL DEFAULT '0' COMMENT '引擎效率',
  `climbingangle` INT(11) NOT NULL DEFAULT '0' COMMENT '底盘爬角',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家属性';

-- 导出  表 Athena.d_chipattribute 结构
DROP TABLE IF EXISTS `d_chipattribute`;
CREATE TABLE `d_chipattribute` (
  `id` INT(11) unsigned NOT NULL COMMENT '机体ID',
  `life` float NOT NULL DEFAULT '0' COMMENT '生命',
  `speed` float NOT NULL DEFAULT '0' COMMENT '速度',
  `energy` float NOT NULL DEFAULT '0' COMMENT '能量',
  `shield` float NOT NULL DEFAULT '0' COMMENT '护盾值',
  `scopeskill` float NOT NULL DEFAULT '0' COMMENT '技能范围',
  `intensityskill` float NOT NULL DEFAULT '0' COMMENT '技能强度',
  `persistskill` float NOT NULL DEFAULT '0' COMMENT '技能持续',
  `atk` float NOT NULL DEFAULT '0' COMMENT '攻击力',
  `scopeatk` float NOT NULL DEFAULT '0' COMMENT '伤害范围',
  `distance` float NOT NULL DEFAULT '0' COMMENT '攻击距离参数修改',
  `elevation` float NOT NULL DEFAULT '0' COMMENT '仰角',
  `overhang` float NOT NULL DEFAULT '0' COMMENT '俯角',
  `enefficiency` float NOT NULL DEFAULT '0' COMMENT '能量效率',
  `efficiency` float NOT NULL DEFAULT '0' COMMENT '引擎效率',
  `climbingangle` float NOT NULL DEFAULT '0' COMMENT '底盘爬角',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='芯片属性';

-- 导出  表 Athena.d_hangar 结构
DROP TABLE IF EXISTS `d_hangar`;
CREATE TABLE `d_hangar` (
  `id` INT(11) unsigned NOT NULL COMMENT '玩家id',
  `body` text NOT NULL COMMENT '机体uniqueid集合',
  `chassis` text NOT NULL COMMENT '底盘uniqueid集合',
  `firecontroller` text NOT NULL COMMENT '火控uniqueid集合',
  `weapons` text NOT NULL COMMENT '武器uniqueid集合',
  `newbody` text NOT NULL COMMENT '新机体uniqueid集合',
  `newchassis` text NOT NULL COMMENT '新底盘uniqueid集合',
  `newfirecontroller` text NOT NULL COMMENT '新火控uniqueid集合',
  `newweapons` text NOT NULL COMMENT '新武器uniqueid集合',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家机库';

-- 导出  表 Athena.d_body 结构
DROP TABLE IF EXISTS `d_body`;
CREATE TABLE `d_body` (
  `id` INT(11) unsigned NOT NULL COMMENT '机体uniqueID',
  `cfgid` INT(11) unsigned NOT NULL COMMENT '配置表中的机体ID',
  `playerid` INT(11) unsigned NOT NULL COMMENT '所属玩家ID',
  `lv` INT(11) unsigned NOT NULL COMMENT '该机体的等级',
  `exp` INT(11) unsigned NOT NULL COMMENT '该机体的经验',
  `slotarray` text NOT NULL COMMENT '槽位信息',
  `isdouble` tinyint(1) DEFAULT b'0' COMMENT '是否使用反应堆',
  `volume` INT(11) unsigned DEFAULT '2' COMMENT '容量',
  `currentvolume` INT(11) unsigned DEFAULT '0' COMMENT '当前已使用容量',
  `count` INT(11) unsigned DEFAULT '0' COMMENT '极化次数',
  `islock` tinyint(1) DEFAULT b'0' COMMENT '是否锁定',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家机体';

-- 导出  表 Athena.d_chassis 结构
DROP TABLE IF EXISTS `d_chassis`;
CREATE TABLE `d_chassis` (
  `id` INT(11) unsigned NOT NULL COMMENT '底盘uniqueID',
  `cfgid` INT(11) unsigned NOT NULL COMMENT '配置表中的底盘ID',
  `playerid` INT(11) unsigned NOT NULL COMMENT '所属玩家ID',
  `lv` INT(11) unsigned NOT NULL COMMENT '该底盘的等级',
  `exp` INT(11) unsigned NOT NULL COMMENT '该底盘的经验',
  `slotarray` text NOT NULL COMMENT '槽位信息',
  `isdouble` tinyint(1) DEFAULT b'0' COMMENT '是否使用反应堆',
  `volume` INT(11) unsigned DEFAULT '2' COMMENT '容量',
  `currentvolume` INT(11) unsigned DEFAULT '0' COMMENT '当前已使用容量',
  `count` INT(11) unsigned DEFAULT '0' COMMENT '极化次数',
  `islock` tinyint(1) DEFAULT b'0' COMMENT '是否锁定',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家底盘';

-- 导出  表 Athena.d_firecontroller 结构
DROP TABLE IF EXISTS `d_firecontroller`;
CREATE TABLE `d_firecontroller` (
  `id` INT(11) unsigned NOT NULL COMMENT '火控uniqueID',
  `cfgid` INT(11) unsigned NOT NULL COMMENT '配置表中的火控ID',
  `playerid` INT(11) unsigned NOT NULL COMMENT '所属玩家ID',
  `lv` INT(11) unsigned NOT NULL COMMENT '该火控的等级',
  `exp` INT(11) unsigned NOT NULL COMMENT '该火控的经验',
  `slotarray` text NOT NULL COMMENT '槽位信息',
  `isdouble` tinyint(1) DEFAULT b'0' COMMENT '是否使用反应堆',
  `volume` INT(11) unsigned DEFAULT '2' COMMENT '容量',
  `currentvolume` INT(11) unsigned DEFAULT '0' COMMENT '当前已使用容量',
  `count` INT(11) unsigned DEFAULT '0' COMMENT '极化次数',
  `islock` tinyint(1) DEFAULT b'0' COMMENT '是否锁定',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家火控';

-- 导出  表 Athena.d_weapons 结构
DROP TABLE IF EXISTS `d_weapons`;
CREATE TABLE `d_weapons` (
  `id` INT(11) unsigned NOT NULL COMMENT '武器uniqueID',
  `cfgid` INT(11) unsigned NOT NULL COMMENT '配置表中的武器ID',
  `playerid` INT(11) unsigned NOT NULL COMMENT '所属玩家ID',
  `lv` INT(11) unsigned NOT NULL COMMENT '该武器的等级',
  `exp` INT(11) unsigned NOT NULL COMMENT '该武器的经验',
  `slotarray` text NOT NULL COMMENT '槽位信息',
  `isdouble` tinyint(1) DEFAULT b'0' COMMENT '是否使用反应堆',
  `volume` INT(11) unsigned DEFAULT '2' COMMENT '容量',
  `currentvolume` INT(11) unsigned DEFAULT '0' COMMENT '当前已使用容量',
  `count` INT(11) unsigned DEFAULT '0' COMMENT '极化次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家武器';

-- 导出  表 Athena.d_machineinfo 结构
DROP TABLE IF EXISTS `d_machineinfo`;
CREATE TABLE `d_machineinfo` (
  `id` INT(11) unsigned NOT NULL COMMENT '玩家ID',
  `defaultindex` INT(11) NOT NULL DEFAULT '1' COMMENT '当前选中哪一套',
  `machinecfgid` text NOT NULL COMMENT '玩家所属的机甲配置id列表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家机甲信息';

-- 导出  表 Athena.d_machinecfg 结构
DROP TABLE IF EXISTS `d_machinecfg`;
CREATE TABLE `d_machinecfg` (
  `id` INT(11) unsigned NOT NULL COMMENT '机甲配置ID',
  `playerid` INT(11) unsigned NOT NULL COMMENT '所属玩家ID',
  `userindex` INT(11) unsigned NOT NULL COMMENT '机甲库里的第几套配置', 
  `machineid` text NOT NULL COMMENT '机甲id',
  `machinebody` text NOT NULL  COMMENT '机体信息',
  `machinechassis` text NOT NULL  COMMENT '底盘信息',
  `firecontroller` text NOT NULL  COMMENT '火控信息',
  `name` text NOT NULL  COMMENT '机甲名字',
  `weapons` text NOT NULL  COMMENT '武器信息',
  `isweld` tinyint(1) DEFAULT b'0' COMMENT '是否焊死',
  `begintime` INT(10) unsigned DEFAULT '0' COMMENT '开始时间',
  `endtime` INT(10) unsigned DEFAULT '0' COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='机甲配置表';


-- 导出  表 Athena.s_config 结构
DROP TABLE IF EXISTS `s_config`;
CREATE TABLE `s_config` (
  `id` INT(11) unsigned NOT NULL,
  `data1` INT(11) unsigned NOT NULL DEFAULT '0',
  `data2` INT(11) unsigned NOT NULL DEFAULT '0',
  `data3` INT(11) unsigned NOT NULL DEFAULT '0',
  `data4` INT(11) unsigned NOT NULL DEFAULT '0',
  `data5` INT(11) unsigned NOT NULL DEFAULT '0',
  `str1` text NOT NULL,
  `str2` text NOT NULL,
  `str3` text NOT NULL,
  `str4` text NOT NULL,
  `str5` text NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='配置表';

-- 导出  表 Athena.s_roleinit 结构
DROP TABLE IF EXISTS `s_roleinit`;
CREATE TABLE `s_roleinit` (
  `id` INT(11) unsigned NOT NULL,
  `data1` INT(11) unsigned NOT NULL,
  `data2` INT(11) unsigned NOT NULL,
  `str1` text NOT NULL,
  `str2` text NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色初始化';

-- 导出表 Athena.d_chipinfo 结构
DROP TABLE IF EXISTS `d_chipinfo`;
CREATE TABLE `d_chipinfo` (
  `id` INT(11)  unsigned NOT NULL COMMENT '玩家id',
  `newchipinfo` text NOT NULL COMMENT '新芯片信息集合',
  `chipinfoarr` text NOT NULL COMMENT '玩家芯片信息集合',
  `inchipinfoarr` text COMMENT  '玩家已装备芯片集合',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家芯片信息';

-- 导出表 Athena.d_awardinfo 结构
DROP TABLE IF EXISTS `d_awardinfo`;
CREATE TABLE `d_awardinfo` (
  `id` INT(11)  unsigned NOT NULL COMMENT 'id',
  `bprewardlist` text NOT NULL COMMENT '蓝图奖励信息',
  `proprewardlist` text NOT NULL COMMENT '材料奖励信息',
  `equiplist` text NOT NULL COMMENT '装备奖励信息',
  `sponsorid` varchar(100) NOT NULL COMMENT '发起请求的id，0表示无',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='奖励信息';

-- 导出表 Athena.d_blueprint 结构
DROP TABLE IF EXISTS `d_blueprint`;
CREATE TABLE `d_blueprint` (
  `id` INT(11)  unsigned NOT NULL COMMENT '玩家id',
  `newblueprint` text COMMENT '新蓝图信息',
  `blueprintinfo` text COMMENT '蓝图信息',
  `blueprinting` text COMMENT '正在铸造蓝图信息',
  `blueprintend` text COMMENT '铸造完成蓝图信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='蓝图信息';

-- 导出表 Athena.d_queueinfo 结构
DROP TABLE IF EXISTS `d_queueinfo`;
CREATE TABLE `d_queueinfo` (
  `id` INT(11)  unsigned NOT NULL COMMENT '玩家id',
  `ingcasting` text NOT NULL COMMENT '正在铸造id集合',
  `endcasting` text NOT NULL COMMENT '铸造完成id集合',
  `ingscan` text NOT NULL COMMENT '正在扫描id集合',
  `endscan` text NOT NULL COMMENT '扫描完成id集合',
  `airfreighter1` text NOT NULL COMMENT '运输机id集合1',
  `airfreighter2` text NOT NULL COMMENT '运输机id集合2',
  `airfreighter3` text NOT NULL COMMENT '运输机id集合3',
  `maxairfreighter` INT(11) unsigned NOT NULL DEFAULT '1' COMMENT '最大运输机数量',
  `maxperairfreighter` INT(11) unsigned NOT NULL DEFAULT '1' COMMENT '每条运输机队列的最大排队数量',
  `maxcasting` INT(11) unsigned NOT NULL DEFAULT '1' COMMENT '最大铸造数量',
  `tmpbqinfos` text NOT NULL COMMENT '缓存的队列信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='队列信息';

-- 导出表 Athena.d_skill 结构
DROP TABLE IF EXISTS `d_skill`;
CREATE TABLE `d_skill` (
  `id` INT(11)  unsigned NOT NULL COMMENT '机体ID',
  `skillarray` text NOT NULL COMMENT '部位和主动技能集合',
  `passkillarray` text NOT NULL COMMENT '部位和被动技能集合',
  `selectskill` varchar(50) NOT NULL COMMENT '战斗携带的主动技能的部位和id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能信息';

-- 导出表 Athena.d_score 结构
DROP TABLE IF EXISTS `d_score`;
CREATE TABLE `d_score` (
  `id` INT(11)  unsigned NOT NULL COMMENT '玩家id',
  `score` double NOT NULL DEFAULT '1000' COMMENT '玩家分数',
  `maxnumber` INT(11) unsigned NOT NULL DEFAULT '0' COMMENT '场数',
  `winnumber` INT(11) unsigned NOT NULL DEFAULT '0' COMMENT '胜利场数',
  `supportnum` INT(11) unsigned NOT NULL DEFAULT '0' COMMENT '队友点赞数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分数信息';

-- 导出表 Athena.d_collection 结构
DROP TABLE IF EXISTS `d_collection`;
CREATE TABLE `d_collection` (
  `id` INT(11)  unsigned NOT NULL COMMENT '玩家id',
  `body` text NOT NULL  COMMENT '机体信息',
  `chassis` text NOT NULL  COMMENT '底盘信息',
  `firecontroller` text NOT NULL  COMMENT '火控信息',
  `weapon` text NOT NULL  COMMENT '武器信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收集信息';

-- 导出表 Athena.d_show 结构
DROP TABLE IF EXISTS `d_show`;
CREATE TABLE `d_show` (
  `id` INT(11)  unsigned NOT NULL COMMENT '玩家id',
  `name` varchar(100) NOT NULL  COMMENT '机甲名字',
  `body` text COMMENT '机体信息',
  `chassis` text COMMENT '底盘信息',
  `firecontroller` text COMMENT '火控信息',
  `weapon` text COMMENT '武器信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='展示机甲信息';

-- 导出表 Athena.d_businessqueue 结构
DROP TABLE IF EXISTS `d_businessqueue`;
CREATE TABLE `d_businessqueue` (
  `id` bigint(20) unsigned NOT NULL COMMENT '自增长id',
  `playerid` bigint(20) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0 COMMENT '事务类型',
  `subtype` int(11) NOT NULL DEFAULT 0 COMMENT '事务子类型',
  `starttime` bigint(20) NOT NULL DEFAULT 0 COMMENT '开始时间',
  `endtime` bigint(20) NOT NULL DEFAULT 0 COMMENT '结束时间',
  `initendtime` bigint(20) NOT NULL DEFAULT 0 COMMENT '初始结束时间',
  `bprewardlist` text NOT NULL COMMENT '蓝图奖励信息',
  `proprewardlist` text NOT NULL COMMENT '材料奖励信息',
  `equiplist` text NOT NULL COMMENT '装备奖励信息',
  `sponsorid` varchar(100) NOT NULL COMMENT '发起请求的id，0表示无',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='事务';

-- 导出表 Athena.d_tmpbqinfo 结构
DROP TABLE IF EXISTS `d_tmpbqinfo`;
CREATE TABLE `d_tmpbqinfo` (
  `id` bigint(20) unsigned NOT NULL COMMENT '自增长id',
  `rawid` bigint(20) unsigned NOT NULL COMMENT '队列表中的id',
  `subtype` int(11) NOT NULL DEFAULT 0 COMMENT '第几个队列',
  `bprewardlist` text NOT NULL COMMENT '蓝图奖励信息',
  `proprewardlist` text NOT NULL COMMENT '材料奖励信息',
  `equiplist` text NOT NULL COMMENT '装备奖励信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='离线缓存的队列奖励信息';

-- 导出表 Athena.d_gold 结构
DROP TABLE IF EXISTS `d_gold`;
CREATE TABLE `d_gold` (
  `id` INT(11)  unsigned NOT NULL COMMENT '玩家id',
  `goldnumber` INT(11)  unsigned NOT NULL DEFAULT 0 COMMENT '金币数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='金币信息';

-- 导出表 Athena.d_khorium 结构
DROP TABLE IF EXISTS `d_khorium`;
CREATE TABLE `d_khorium` (
  `id` INT(11)  unsigned NOT NULL COMMENT '玩家id',
  `khorium` INT(11)  unsigned NOT NULL DEFAULT 0 COMMENT '氪金数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='氪金信息';

-- 导出表 Athena.d_materials 结构
DROP TABLE IF EXISTS `d_materials`;
CREATE TABLE `d_materials` (
  `id` INT(11)  unsigned NOT NULL COMMENT '玩家id',
  `newmaterials` text COMMENT '新材料信息',
  `materials` text COMMENT '材料信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='材料信息';

-- 导出表 Athena.d_prop 结构
DROP TABLE IF EXISTS `d_prop`;
CREATE TABLE `d_prop` (
  `id` INT(11)  unsigned NOT NULL COMMENT '玩家id',
  `newprops` text COMMENT '新道具信息',
  `props` text COMMENT '道具信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='道具信息';

-- 导出表 Athena.d_athletics 结构
DROP TABLE IF EXISTS `d_athletics`;
CREATE TABLE `d_athletics` (
  `id` INT(11)  unsigned NOT NULL COMMENT '成就类别id',
  `athleticslist` text NOT NULL COMMENT '竞技信息',
  `count` INT(11)  unsigned NOT NULL DEFAULT '0' COMMENT '当前值',
  `uid` INT(11)  unsigned NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='竞技';

-- 导出表 Athena.d_challenge 结构
DROP TABLE IF EXISTS `d_challenge`;
CREATE TABLE `d_challenge` (
  `id` INT(11)  unsigned NOT NULL COMMENT '成就类别id',
  `challengelist` text NOT NULL COMMENT '挑战信息',
  `count` INT(11)  unsigned NOT NULL DEFAULT '0' COMMENT '当前值',
  `uid` INT(11)  unsigned NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='挑战';

-- 导出表 Athena.d_plot 结构
DROP TABLE IF EXISTS `d_plot`;
CREATE TABLE `d_plot` (
  `id` INT(11)  unsigned NOT NULL COMMENT '剧情类别id',
  `plotlist` text NOT NULL COMMENT '剧情信息',
  `count` INT(11)  unsigned NOT NULL DEFAULT '0' COMMENT '当前剧情进度',
  `uid` INT(11)  unsigned NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='剧情';

-- 导出表 Athena.d_overview 结构
DROP TABLE IF EXISTS `d_overview`;
CREATE TABLE `d_overview` (
  `id` INT(11)  unsigned NOT NULL COMMENT '用户id',
  `plotnum` INT(11) unsigned DEFAULT b'0' COMMENT '已完成剧情数量',
  `athleticsnum` INT(11) unsigned DEFAULT b'0' COMMENT '已完成竞技数量',
  `challengenum` INT(11) unsigned DEFAULT b'0' COMMENT '已完成挑战数量',
  `plot` varchar(255) NOT NULL COMMENT '剧情id类型集合',
  `athletics` varchar(255) NOT NULL COMMENT '竞技id类型集合',
  `challenge` varchar(255) NOT NULL COMMENT '挑战id类型集合',
  `current` INT(11) unsigned DEFAULT b'0' COMMENT '要被覆盖的编号',
  `achievelist` text NOT NULL COMMENT '成就信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='总览';

-- 导出表 Athena.d_putaway 结构
DROP TABLE IF EXISTS `d_putaway`;
CREATE TABLE `d_putaway` (
  `id` INT(11)  unsigned NOT NULL COMMENT 'id',
  `cfgid` varchar(20) NOT NULL COMMENT '配置id',
  `number` INT(11) unsigned DEFAULT b'0' COMMENT '数量',
  `price` INT(11) unsigned DEFAULT b'0' COMMENT '价格',
  `type` INT(2)  unsigned NOT NULL COMMENT '类别',
  `puttime` INT(11) unsigned NOT NULL COMMENT '上架时间',
  `downtime` INT(11) unsigned NOT NULL COMMENT '下架时间',
  `uid` INT(11)  unsigned NOT NULL COMMENT '用户id', 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='蓝图上架物品信息';

-- 导出表 Athena.d_putawaygold 结构
DROP TABLE IF EXISTS `d_putawaygold`;
CREATE TABLE `d_putawaygold` (
  `id` INT(11)  unsigned NOT NULL COMMENT 'id',
  `cfgid` INT(11)  unsigned NOT NULL COMMENT '配置id',
  `number` INT(11) unsigned DEFAULT b'0' COMMENT '数量',
  `price` INT(11) unsigned DEFAULT b'0' COMMENT '价格',
  `type` INT(2)  unsigned NOT NULL COMMENT '类别',
  `puttime` INT(11) unsigned NOT NULL COMMENT '上架时间',
  `downtime` INT(11) unsigned NOT NULL COMMENT '下架时间',
  `uid` INT(11)  unsigned NOT NULL COMMENT '用户id', 
  `ismarket` INT(2)  unsigned NOT NULL COMMENT '是否和系统交易为0表示交易', 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='金币上架物品信息';

-- 导出表 Athena.d_stayputaway 结构
DROP TABLE IF EXISTS `d_stayputaway`;
CREATE TABLE `d_stayputaway` (
  `id` INT(11)  unsigned NOT NULL COMMENT 'id',
  `cfgid` varchar(20) NOT NULL COMMENT '配置id',
  `number` INT(11) unsigned DEFAULT b'0' COMMENT '数量',
  `iskh`  tinyint(1) NOT NULL DEFAULT b'0'  COMMENT '是否氪金',
  `price` INT(11) unsigned DEFAULT b'0' COMMENT '价格',
  `type` INT(2)  unsigned NOT NULL COMMENT '类别',
  `puttime` INT(11) unsigned NOT NULL COMMENT '上架时间',
  `downtime` INT(11) unsigned NOT NULL COMMENT '下架时间',
  `uid` INT(11)  unsigned NOT NULL COMMENT '用户id', 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='待上架物品信息';

-- 导出表 Athena.d_putawayinfo 结构
DROP TABLE IF EXISTS `d_putawayinfo`;
CREATE TABLE `d_putawayinfo` (
  `id` INT(11)  unsigned NOT NULL COMMENT '用户id',
  `goldarr` varchar(255) COMMENT '金币已上架商品集合',
  `khoriumarr` varchar(255) COMMENT '氪金已上架商品集合',
  `staygoldarr` varchar(255) COMMENT '金币待上架商品集合',
  `staykhoriumarr` varchar(255) COMMENT '氪金待上架商品集合',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='上架信息集合';

-- 导出表 Athena.s_blueprints 结构
DROP TABLE IF EXISTS `s_blueprints`;
CREATE TABLE `s_blueprints` (
  `id` varchar(20) NOT NULL COMMENT '蓝图id',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `arr` text NOT NULL COMMENT '24小时价格集合',
  `arrday` text NOT NULL COMMENT '30天价格集合',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='蓝图价格走势表';

-- 导出表 Athena.s_materials 结构
DROP TABLE IF EXISTS `s_materials`;
CREATE TABLE `s_materials` (
  `id` INT(11)  unsigned NOT NULL COMMENT '材料id',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `arr` text NOT NULL COMMENT '24小时价格集合',
  `arrday` text NOT NULL COMMENT '30天价格集合',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='材料价格走势表';

-- 导出表 Athena.s_market 结构
DROP TABLE IF EXISTS `s_market`;
CREATE TABLE `s_market` (
  `id` INT(11)  unsigned NOT NULL COMMENT 'id',
  `marketinfo` text NOT NULL COMMENT '加权平均数价格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='材料总的行情';

-- 导出表 Athena.d_shopiteminfo 结构
DROP TABLE IF EXISTS `d_shopiteminfo`;
CREATE TABLE `d_shopiteminfo` (
  `id` INT(11)  unsigned NOT NULL COMMENT '用户id',
  `shopiteminfo` varchar(255) COMMENT '购买物品id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购买物品id集合';

-- 导出表 Athena.d_shopitem 结构
DROP TABLE IF EXISTS `d_shopitem`;
CREATE TABLE `d_shopitem` (
  `id` INT(11)  unsigned NOT NULL COMMENT 'id',
  `cfgid` varchar(20) NOT NULL COMMENT '配置id',
  `number` INT(11) unsigned DEFAULT b'0' COMMENT '数量',
  `price` INT(11) unsigned DEFAULT b'0' COMMENT '价格',
  `type` INT(2)  unsigned NOT NULL COMMENT '类别',
  `shoptime` INT(11) unsigned NOT NULL COMMENT '购买时间',
  `iskh`  tinyint(1) NOT NULL DEFAULT b'0'  COMMENT '是否氪金',
  `uid` INT(11)  unsigned NOT NULL COMMENT 'uid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购买物品';

-- 导出表 Athena.s_sale 结构
DROP TABLE IF EXISTS `s_sale`;
CREATE TABLE `s_sale` (
  `id` INT(11) unsigned NOT NULL COMMENT 'id',
  `cfgid` INT(11) NOT NULL COMMENT '配置id',
  `type` INT(2) unsigned NOT NULL COMMENT '类别',
  `price` INT(11) unsigned DEFAULT b'0' COMMENT '价格',
  `saleprice` INT(11) unsigned DEFAULT b'0' COMMENT '优惠价格',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `iskh`  tinyint(1) NOT NULL DEFAULT b'0'  COMMENT '是否氪金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='超值礼包';

-- 导出表 Athena.s_special 结构
DROP TABLE IF EXISTS `s_special`;
CREATE TABLE `s_special` (
  `id` INT(11) unsigned NOT NULL COMMENT 'id',
  `cfgid` INT(11) NOT NULL COMMENT '配置id',
  `type` INT(2) unsigned NOT NULL COMMENT '类别',
  `price` INT(11) unsigned DEFAULT b'0' COMMENT '价格',
  `saleprice` INT(11) unsigned DEFAULT b'0' COMMENT '优惠价格',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `downtime` INT(11) unsigned NOT NULL COMMENT '下架时间',
  `iskh`  tinyint(1) NOT NULL DEFAULT b'0'  COMMENT '是否氪金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='限时特价';

-- 导出表 Athena.s_bag 结构
DROP TABLE IF EXISTS `s_bag`;
CREATE TABLE `s_bag` (
  `id` INT(11)  unsigned NOT NULL COMMENT 'id',
  `cfgid` INT(11) NOT NULL COMMENT '配置id',
  `type` INT(2) unsigned NOT NULL COMMENT '类别',
  `price` INT(11) unsigned DEFAULT b'0' COMMENT '价格',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `iskh`  tinyint(1) NOT NULL DEFAULT b'0'  COMMENT '是否氪金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='礼包';

-- 导出表 Athena.s_props 结构
DROP TABLE IF EXISTS `s_props`;
CREATE TABLE `s_props` (
  `id` INT(11) NOT NULL COMMENT '配置id',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `price` INT(11) unsigned DEFAULT b'0' COMMENT '价格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='后台道具表';

-- 导出表 Athena.s_chips 结构
DROP TABLE IF EXISTS `s_chips`;
CREATE TABLE `s_chips` (
  `id` INT(11) NOT NULL COMMENT '配置id',
  `name` varchar(30) NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='后台芯片表';

-- 导出表 Athena.s_bags 结构
DROP TABLE IF EXISTS `s_bags`;
CREATE TABLE `s_bags` (
  `id` INT(11) NOT NULL COMMENT '配置id',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `price` INT(11) unsigned DEFAULT b'0' COMMENT '价格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='后台礼包表';

-- 导出表 Athena.d_daytask 结构
DROP TABLE IF EXISTS `d_daytask`;
CREATE TABLE `d_daytask` (
  `id` INT(11) unsigned NOT NULL COMMENT 'id',
  `cfgid` INT(11) unsigned NOT NULL COMMENT '每日任务id',
  `type` INT(2) unsigned NOT NULL COMMENT '状态',
  `progress` varchar(255) NOT NULL COMMENT '进度',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='每日任务';

-- 导出表 Athena.d_urgenttask 结构
DROP TABLE IF EXISTS `d_urgenttask`;
CREATE TABLE `d_urgenttask` (
  `id` INT(11) unsigned NOT NULL COMMENT 'id',
  `cfgid` INT(11) unsigned NOT NULL COMMENT '紧急任务id',
  `type` INT(2) unsigned NOT NULL COMMENT '状态',
  `progress` varchar(255) NOT NULL COMMENT '进度',
  `starttime` INT(11) NOT NULL COMMENT '开始时间',
  `endtime` INT(11) NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='紧急任务';

-- 导出表 Athena.d_plottask 结构
DROP TABLE IF EXISTS `d_plottask`;
CREATE TABLE `d_plottask` (
  `id` INT(11) unsigned NOT NULL COMMENT 'id',
  `cfgid` INT(11) unsigned NOT NULL COMMENT '剧情任务id',
  `type` INT(2) unsigned NOT NULL COMMENT '状态',
  `progress` varchar(255) NOT NULL COMMENT '进度',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='剧情任务';

-- 导出表 Athena.d_usertask 结构
DROP TABLE IF EXISTS `d_usertask`;
CREATE TABLE `d_usertask` (
  `id` INT(11)  unsigned NOT NULL COMMENT '用户id',
  `daytask` varchar(255) COMMENT '每日任务',
  `urgenttask` varchar(255) COMMENT '紧急任务',
  `plottask` varchar(255) COMMENT '剧情任务',
  `tasking` INT(11) unsigned COMMENT '激活剧情任务id',
  `needtalk` varchar(255) COMMENT '已完成需对话任务',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户任务表';

-- 导出表 Athena.d_userset 结构
DROP TABLE IF EXISTS `d_userset`;
CREATE TABLE `d_userset` (
  `id` INT(11)  unsigned NOT NULL COMMENT '用户id',
  `max_material` INT(11) unsigned DEFAULT '200' COMMENT '材料容量',
  `max_weapon` INT(11) unsigned DEFAULT '50' COMMENT '武器容量',
  `max_body` INT(11) unsigned DEFAULT '50' COMMENT '机体容量',
  `max_chassis` INT(11) unsigned DEFAULT '50' COMMENT '底盘容量',
  `max_fire` INT(11) unsigned DEFAULT '50' COMMENT '火控容量',
  `max_chip` INT(11) unsigned DEFAULT '200' COMMENT '芯片容量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户设置表';

-- ----------------------------
-- Table structure for s_info
-- ----------------------------
DROP TABLE IF EXISTS `s_info`;
CREATE TABLE `s_info` (
  `id` int NOT NULL COMMENT '每天0点时间戳',
  `pvpsum` int DEFAULT '0' COMMENT 'pvp总数',
  `pvpnum_1` int DEFAULT '0',
  `pvpnum_2` int DEFAULT '0',
  `pvpnum_3` int DEFAULT '0',
  `pvesum` int DEFAULT '0' COMMENT 'pve总数',
  `pvenum_1` int DEFAULT '0',
  `pvenum_2` int DEFAULT '0',
  `pvenum_3` int DEFAULT '0',
  `roomsum` int DEFAULT '0' COMMENT '当前房间数量',
  `ipsum` int DEFAULT '0' COMMENT 'ip地址总数',
  `playingsum` int DEFAULT '0' COMMENT '在线玩家数量',
  `battlenum` int DEFAULT '0' COMMENT '当前战斗人数',
  PRIMARY KEY (`id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='游戏记录表';





-- 正在导出表  metoo.s_roleinit 的数据：~1 rows (大约)
INSERT INTO `s_roleinit` VALUES ('1', '0', '0', '100,200,300,100', '', '初始属性');
INSERT INTO `s_roleinit` VALUES ('2', '0', '0', '1000110001,10001,10001,10001,10001,10012,10013', '', '初始机甲信息(海姆达尔)');
INSERT INTO `s_roleinit` VALUES ('3', '0', '0', '1000110001,10002,10002,10002,10018,10027', '', '初始机甲信息(冷蛛)');
INSERT INTO `s_roleinit` VALUES ('4', '0', '0', '1000110001,10003,10003,10003,10028,10029', '', '初始机甲信息(兰斯洛特)');

INSERT INTO `s_admin` (`name`, `password`) VALUES ('admin', 'admin');

-- ----------------------------
-- Records of d_user
-- ----------------------------
INSERT INTO `d_user` VALUES ('1', 'UE战斗管理器', '1', '0', '10001', 'ue战斗服务管理器', null, '1610440991', '0', '0', '0', '0', null, '100');
INSERT INTO `d_user` VALUES ('2', 'bili01', '1', '0', '10001', '自定义介绍', null, '1610440991', '1610440992', '1610441002', '10', '10', null, '18');
INSERT INTO `d_user` VALUES ('3', 'bili02', '1', '0', '10001', '自定义介绍', null, '1610441058', '1610441060', '1610441062', '2', '2', null, '18');
INSERT INTO `d_user` VALUES ('4', 'bili03', '1', '0', '10001', '自定义介绍', null, '1610441067', '1610441068', '1610441070', '2', '2', null, '18');
INSERT INTO `d_user` VALUES ('5', 'bili04', '1', '0', '10001', '自定义介绍', null, '1610441075', '1610441076', '1610441078', '2', '2', null, '18');
INSERT INTO `d_user` VALUES ('6', 'bili05', '1', '0', '10001', '自定义介绍', null, '1610441083', '1610441084', '1610441085', '1', '1', null, '18');
INSERT INTO `d_user` VALUES ('7', 'bili06', '1', '0', '10001', '自定义介绍', null, '1610441092', '1610441094', '1610441095', '1', '1', null, '18');

-- ----------------------------
-- Records of d_userset
-- ----------------------------
INSERT INTO `d_userset` VALUES ('2', '200', '50', '50', '50', '50', '200');
INSERT INTO `d_userset` VALUES ('3', '200', '50', '50', '50', '50', '200');
INSERT INTO `d_userset` VALUES ('4', '200', '50', '50', '50', '50', '200');
INSERT INTO `d_userset` VALUES ('5', '200', '50', '50', '50', '50', '200');
INSERT INTO `d_userset` VALUES ('6', '200', '50', '50', '50', '50', '200');
INSERT INTO `d_userset` VALUES ('7', '200', '50', '50', '50', '50', '200');

INSERT INTO `s_bag` VALUES ('1', '10001', '7', '10000', '数码聚合体', '1');
INSERT INTO `s_bag` VALUES ('2', '10002', '7', '10000', '金属粘融剂', '1');
INSERT INTO `s_bag` VALUES ('3', '10003', '7', '10000', '共振涂料', '1');
INSERT INTO `s_bag` VALUES ('4', '10003', '7', '10', '共振涂料', '0');
INSERT INTO `s_bag` VALUES ('5', '10002', '7', '10', '金属粘融剂', '0');
INSERT INTO `s_bag` VALUES ('6', '10001', '7', '10', '数码聚合体', '0');
INSERT INTO `s_bag` VALUES ('7', '10022', '7', '10000', '金', '1');
INSERT INTO `s_bag` VALUES ('8', '10003', '7', '10000', '共振涂料', '1');
INSERT INTO `s_bag` VALUES ('9', '10022', '7', '10000', '金', '1');
INSERT INTO `s_bag` VALUES ('10', '10025', '7', '10000', '铅', '1');
INSERT INTO `s_bag` VALUES ('11', '10014', '7', '10000', '银', '1');
INSERT INTO `s_bag` VALUES ('12', '10012', '7', '10000', '钴', '1');
INSERT INTO `s_bag` VALUES ('13', '10015', '7', '10000', '镍', '1');

INSERT INTO `s_sale` VALUES ('1', '10001', '13', '10000', '10000', '10分钟加速器', '1');
INSERT INTO `s_sale` VALUES ('2', '10026', '13', '10000', '10000', '260小时加速器', '1');
INSERT INTO `s_sale` VALUES ('3', '10025', '13', '10000', '10000', '250小时加速器', '1');
INSERT INTO `s_sale` VALUES ('4', '10024', '13', '10000', '10000', '240小时加速器', '1');
INSERT INTO `s_sale` VALUES ('5', '10023', '13', '10000', '10000', '230小时加速器', '1');
INSERT INTO `s_sale` VALUES ('6', '10019', '13', '10000', '10000', '190小时加速器', '1');
INSERT INTO `s_sale` VALUES ('7', '10004', '13', '10000', '10000', '40小时加速器', '1');
INSERT INTO `s_sale` VALUES ('8', '10003', '13', '10000', '490', '6小时加速器', '1');
INSERT INTO `s_sale` VALUES ('9', '10009', '13', '10000', '990', '90小时加速器', '1');
INSERT INTO `s_sale` VALUES ('10', '10015', '13', '10000', '10000', '150小时加速器', '1');
INSERT INTO `s_sale` VALUES ('11', '10001', '13', '10000', '100', '10分钟加速器', '1');
INSERT INTO `s_sale` VALUES ('12', '10001', '13', '10000', '10000', '10分钟加速器', '1');
INSERT INTO `s_sale` VALUES ('13', '10018', '13', '10000', '10000', '180小时加速器', '1');

INSERT INTO `s_special` VALUES ('2', '10001', '8', '1000000', '1000000', '塑性器', '1634798940', '1');
INSERT INTO `s_special` VALUES ('3', '10002', '8', '1000000', '1000000', '反应堆', '1634798940', '1');
INSERT INTO `s_special` VALUES ('4', '10002', '8', '10000', '10000', '反应堆', '1634798940', '1');
INSERT INTO `s_special` VALUES ('5', '10022', '8', '10000', '10000', '220小时加速器', '1634798940', '1');
INSERT INTO `s_special` VALUES ('6', '10018', '8', '10000', '10000', '180小时加速器', '1634798940', '1');
INSERT INTO `s_special` VALUES ('7', '10006', '8', '10000', '10000', '60小时加速器', '1634798940', '1');
INSERT INTO `s_special` VALUES ('8', '10024', '8', '10000', '10000', '240小时加速器', '1634798940', '1');
INSERT INTO `s_special` VALUES ('10', '10001', '8', '10000', '10000', '塑性器', '1634798940', '1');
INSERT INTO `s_special` VALUES ('11', '10025', '8', '10000', '10000', '250小时加速器', '1634798940', '1');
INSERT INTO `s_special` VALUES ('12', '10022', '8', '10000', '10000', '220小时加速器', '1634798940', '1');
INSERT INTO `s_special` VALUES ('13', '10025', '8', '10000', '10000', '250小时加速器', '1634798940', '1');
INSERT INTO `s_special` VALUES ('14', '10009', '8', '10000', '10000', '90小时加速器', '1634798940', '1');



-- ----------------------------
-- Records of d_account
-- ----------------------------
INSERT INTO `d_account` VALUES ('1', 'UE_#$%<412>GHjDG', 'www123456', '1');
INSERT INTO `d_account` VALUES ('2', 'bilibili01', 'www123456', '2');
INSERT INTO `d_account` VALUES ('3', 'bilibili02', 'www123456', '2');
INSERT INTO `d_account` VALUES ('4', 'bilibili03', 'www123456', '2');
INSERT INTO `d_account` VALUES ('5', 'bilibili04', 'www123456', '2');
INSERT INTO `d_account` VALUES ('6', 'bilibili05', 'www123456', '2');
INSERT INTO `d_account` VALUES ('7', 'bilibili06', 'www123456', '2');
INSERT INTO `d_account` VALUES ('8', 'HuoFei10001', 'www123456', '2');
INSERT INTO `d_account` VALUES ('9', 'HuoFei10002', 'www123456', '2');
INSERT INTO `d_account` VALUES ('10', 'HuoFei10003', 'www123456', '2');
INSERT INTO `d_account` VALUES ('11', 'HuoFei10004', 'www123456', '2');
INSERT INTO `d_account` VALUES ('12', 'HuoFei10005', 'www123456', '2');
INSERT INTO `d_account` VALUES ('13', 'HuoFei10006', 'www123456', '2');
INSERT INTO `d_account` VALUES ('14', 'HuoFei10007', 'www123456', '2');
INSERT INTO `d_account` VALUES ('15', 'HuoFei10008', 'www123456', '2');
INSERT INTO `d_account` VALUES ('16', 'HuoFei10009', 'www123456', '2');
INSERT INTO `d_account` VALUES ('17', 'HuoFei10010', 'www123456', '2');
INSERT INTO `d_account` VALUES ('18', 'HuoFei10011', 'www123456', '2');
INSERT INTO `d_account` VALUES ('19', 'HuoFei10012', 'www123456', '2');
INSERT INTO `d_account` VALUES ('20', 'HuoFei10013', 'www123456', '2');
INSERT INTO `d_account` VALUES ('21', 'HuoFei10014', 'www123456', '2');
INSERT INTO `d_account` VALUES ('22', 'HuoFei10015', 'www123456', '2');
INSERT INTO `d_account` VALUES ('23', 'HuoFei10016', 'www123456', '2');

-- ----------------------------
-- Records of d_blueprint
-- ----------------------------
INSERT INTO `d_blueprint` VALUES ('2', '[{\"number\":10,\"id\":\"610004\"},{\"number\":10,\"id\":\"410012\"},{\"number\":10,\"id\":\"210002\"},{\"number\":10,\"id\":\"610012\"},{\"number\":10,\"id\":\"210003\"},{\"number\":10,\"id\":\"610002\"},{\"number\":10,\"id\":\"410013\"},{\"number\":10,\"id\":\"610013\"},{\"number\":10,\"id\":\"410029\"},{\"number\":10,\"id\":\"310008\"}]', '{}', '{}', '{}');
INSERT INTO `d_blueprint` VALUES ('3', '[{\"number\":10,\"id\":\"610004\"},{\"number\":10,\"id\":\"410012\"},{\"number\":10,\"id\":\"210002\"},{\"number\":10,\"id\":\"610012\"},{\"number\":10,\"id\":\"210003\"},{\"number\":10,\"id\":\"610002\"},{\"number\":10,\"id\":\"410013\"},{\"number\":10,\"id\":\"610013\"},{\"number\":10,\"id\":\"410029\"},{\"number\":10,\"id\":\"310008\"}]', '{}', '{}', '{}');
INSERT INTO `d_blueprint` VALUES ('4', '[{\"number\":10,\"id\":\"610004\"},{\"number\":10,\"id\":\"410012\"},{\"number\":10,\"id\":\"210002\"},{\"number\":10,\"id\":\"610012\"},{\"number\":10,\"id\":\"210003\"},{\"number\":10,\"id\":\"610002\"},{\"number\":10,\"id\":\"410013\"},{\"number\":10,\"id\":\"610013\"},{\"number\":10,\"id\":\"410029\"},{\"number\":10,\"id\":\"310008\"}]', '{}', '{}', '{}');
INSERT INTO `d_blueprint` VALUES ('5', '[{\"number\":10,\"id\":\"610004\"},{\"number\":10,\"id\":\"410012\"},{\"number\":10,\"id\":\"210002\"},{\"number\":10,\"id\":\"610012\"},{\"number\":10,\"id\":\"210003\"},{\"number\":10,\"id\":\"610002\"},{\"number\":10,\"id\":\"410013\"},{\"number\":10,\"id\":\"610013\"},{\"number\":10,\"id\":\"410029\"},{\"number\":10,\"id\":\"310008\"}]', '{}', '{}', '{}');
INSERT INTO `d_blueprint` VALUES ('6', '[{\"number\":10,\"id\":\"610004\"},{\"number\":10,\"id\":\"410012\"},{\"number\":10,\"id\":\"210002\"},{\"number\":10,\"id\":\"610012\"},{\"number\":10,\"id\":\"210003\"},{\"number\":10,\"id\":\"610002\"},{\"number\":10,\"id\":\"410013\"},{\"number\":10,\"id\":\"610013\"},{\"number\":10,\"id\":\"410029\"},{\"number\":10,\"id\":\"310008\"}]', '{}', '{}', '{}');
INSERT INTO `d_blueprint` VALUES ('7', '[{\"number\":10,\"id\":\"610004\"},{\"number\":10,\"id\":\"410012\"},{\"number\":10,\"id\":\"210002\"},{\"number\":10,\"id\":\"610012\"},{\"number\":10,\"id\":\"210003\"},{\"number\":10,\"id\":\"610002\"},{\"number\":10,\"id\":\"410013\"},{\"number\":10,\"id\":\"610013\"},{\"number\":10,\"id\":\"410029\"},{\"number\":10,\"id\":\"310008\"}]', '{}', '{}', '{}');

-- ----------------------------
-- Records of d_body
-- ----------------------------
INSERT INTO `d_body` VALUES ('1', '10008', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('2', '10001', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('3', '10002', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('4', '10003', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('5', '10008', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('6', '10001', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('7', '10002', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('8', '10003', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('9', '10008', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('10', '10001', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('11', '10002', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('12', '10003', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('13', '10008', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('14', '10001', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('15', '10002', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('16', '10003', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('17', '10008', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('18', '10001', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('19', '10002', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('20', '10003', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('21', '10008', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('22', '10001', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('23', '10002', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_body` VALUES ('24', '10003', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');

-- ----------------------------
-- Records of d_weapons
-- ----------------------------
INSERT INTO `d_weapons` VALUES ('1', '10018', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('2', '10027', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('3', '10012', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('4', '10013', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('5', '10029', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('6', '10028', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('7', '10018', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('8', '10027', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('9', '10012', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('10', '10013', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('11', '10029', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('12', '10028', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('13', '10018', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('14', '10027', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('15', '10012', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('16', '10013', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('17', '10029', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('18', '10028', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('19', '10018', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('20', '10027', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('21', '10012', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('22', '10013', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('23', '10029', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('24', '10028', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('25', '10018', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('26', '10027', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('27', '10012', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('28', '10013', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('29', '10029', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('30', '10028', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('31', '10018', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('32', '10027', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('33', '10012', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('34', '10013', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('35', '10029', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');
INSERT INTO `d_weapons` VALUES ('36', '10028', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0');

-- ----------------------------
-- Records of d_challenge
-- ----------------------------
INSERT INTO `d_challenge` VALUES ('3002', '[{\"id\":2002,\"isget\":false}]', '6', '2');
INSERT INTO `d_challenge` VALUES ('3003', '[{\"id\":2003,\"isget\":false}]', '4', '2');
INSERT INTO `d_challenge` VALUES ('3004', '[{\"id\":2004,\"isget\":false}]', '3', '2');
INSERT INTO `d_challenge` VALUES ('3005', '[{\"id\":2005,\"isget\":false}]', '4', '2');
INSERT INTO `d_challenge` VALUES ('3006', '[{\"id\":2006,\"isget\":false}]', '6', '2');
INSERT INTO `d_challenge` VALUES ('3007', '[{\"id\":2007,\"isget\":false}]', '4', '2');
INSERT INTO `d_challenge` VALUES ('3008', '[{\"id\":2008,\"isget\":false}]', '3', '2');
INSERT INTO `d_challenge` VALUES ('3009', '[{\"id\":2009,\"isget\":false}]', '4', '2');
INSERT INTO `d_challenge` VALUES ('3014', '[{\"id\":2014,\"isget\":false}]', '3', '2');
INSERT INTO `d_challenge` VALUES ('3016', '[{\"id\":2016,\"isget\":false}]', '0', '2');
INSERT INTO `d_challenge` VALUES ('4002', '[{\"id\":2002,\"isget\":false}]', '6', '3');
INSERT INTO `d_challenge` VALUES ('4003', '[{\"id\":2003,\"isget\":false}]', '4', '3');
INSERT INTO `d_challenge` VALUES ('4004', '[{\"id\":2004,\"isget\":false}]', '3', '3');
INSERT INTO `d_challenge` VALUES ('4005', '[{\"id\":2005,\"isget\":false}]', '4', '3');
INSERT INTO `d_challenge` VALUES ('4006', '[{\"id\":2006,\"isget\":false}]', '6', '3');
INSERT INTO `d_challenge` VALUES ('4007', '[{\"id\":2007,\"isget\":false}]', '4', '3');
INSERT INTO `d_challenge` VALUES ('4008', '[{\"id\":2008,\"isget\":false}]', '3', '3');
INSERT INTO `d_challenge` VALUES ('4009', '[{\"id\":2009,\"isget\":false}]', '4', '3');
INSERT INTO `d_challenge` VALUES ('4014', '[{\"id\":2014,\"isget\":false}]', '3', '3');
INSERT INTO `d_challenge` VALUES ('4016', '[{\"id\":2016,\"isget\":false}]', '0', '3');
INSERT INTO `d_challenge` VALUES ('5002', '[{\"id\":2002,\"isget\":false}]', '6', '4');
INSERT INTO `d_challenge` VALUES ('5003', '[{\"id\":2003,\"isget\":false}]', '4', '4');
INSERT INTO `d_challenge` VALUES ('5004', '[{\"id\":2004,\"isget\":false}]', '3', '4');
INSERT INTO `d_challenge` VALUES ('5005', '[{\"id\":2005,\"isget\":false}]', '4', '4');
INSERT INTO `d_challenge` VALUES ('5006', '[{\"id\":2006,\"isget\":false}]', '6', '4');
INSERT INTO `d_challenge` VALUES ('5007', '[{\"id\":2007,\"isget\":false}]', '4', '4');
INSERT INTO `d_challenge` VALUES ('5008', '[{\"id\":2008,\"isget\":false}]', '3', '4');
INSERT INTO `d_challenge` VALUES ('5009', '[{\"id\":2009,\"isget\":false}]', '4', '4');
INSERT INTO `d_challenge` VALUES ('5014', '[{\"id\":2014,\"isget\":false}]', '3', '4');
INSERT INTO `d_challenge` VALUES ('5016', '[{\"id\":2016,\"isget\":false}]', '0', '4');
INSERT INTO `d_challenge` VALUES ('6002', '[{\"id\":2002,\"isget\":false}]', '6', '5');
INSERT INTO `d_challenge` VALUES ('6003', '[{\"id\":2003,\"isget\":false}]', '4', '5');
INSERT INTO `d_challenge` VALUES ('6004', '[{\"id\":2004,\"isget\":false}]', '3', '5');
INSERT INTO `d_challenge` VALUES ('6005', '[{\"id\":2005,\"isget\":false}]', '4', '5');
INSERT INTO `d_challenge` VALUES ('6006', '[{\"id\":2006,\"isget\":false}]', '6', '5');
INSERT INTO `d_challenge` VALUES ('6007', '[{\"id\":2007,\"isget\":false}]', '4', '5');
INSERT INTO `d_challenge` VALUES ('6008', '[{\"id\":2008,\"isget\":false}]', '3', '5');
INSERT INTO `d_challenge` VALUES ('6009', '[{\"id\":2009,\"isget\":false}]', '4', '5');
INSERT INTO `d_challenge` VALUES ('6014', '[{\"id\":2014,\"isget\":false}]', '3', '5');
INSERT INTO `d_challenge` VALUES ('6016', '[{\"id\":2016,\"isget\":false}]', '0', '5');
INSERT INTO `d_challenge` VALUES ('7002', '[{\"id\":2002,\"isget\":false}]', '6', '6');
INSERT INTO `d_challenge` VALUES ('7003', '[{\"id\":2003,\"isget\":false}]', '4', '6');
INSERT INTO `d_challenge` VALUES ('7004', '[{\"id\":2004,\"isget\":false}]', '3', '6');
INSERT INTO `d_challenge` VALUES ('7005', '[{\"id\":2005,\"isget\":false}]', '4', '6');
INSERT INTO `d_challenge` VALUES ('7006', '[{\"id\":2006,\"isget\":false}]', '6', '6');
INSERT INTO `d_challenge` VALUES ('7007', '[{\"id\":2007,\"isget\":false}]', '4', '6');
INSERT INTO `d_challenge` VALUES ('7008', '[{\"id\":2008,\"isget\":false}]', '3', '6');
INSERT INTO `d_challenge` VALUES ('7009', '[{\"id\":2009,\"isget\":false}]', '4', '6');
INSERT INTO `d_challenge` VALUES ('7014', '[{\"id\":2014,\"isget\":false}]', '3', '6');
INSERT INTO `d_challenge` VALUES ('7016', '[{\"id\":2016,\"isget\":false}]', '0', '6');
INSERT INTO `d_challenge` VALUES ('8002', '[{\"id\":2002,\"isget\":false}]', '6', '7');
INSERT INTO `d_challenge` VALUES ('8003', '[{\"id\":2003,\"isget\":false}]', '4', '7');
INSERT INTO `d_challenge` VALUES ('8004', '[{\"id\":2004,\"isget\":false}]', '3', '7');
INSERT INTO `d_challenge` VALUES ('8005', '[{\"id\":2005,\"isget\":false}]', '4', '7');
INSERT INTO `d_challenge` VALUES ('8006', '[{\"id\":2006,\"isget\":false}]', '6', '7');
INSERT INTO `d_challenge` VALUES ('8007', '[{\"id\":2007,\"isget\":false}]', '4', '7');
INSERT INTO `d_challenge` VALUES ('8008', '[{\"id\":2008,\"isget\":false}]', '3', '7');
INSERT INTO `d_challenge` VALUES ('8009', '[{\"id\":2009,\"isget\":false}]', '4', '7');
INSERT INTO `d_challenge` VALUES ('8014', '[{\"id\":2014,\"isget\":false}]', '3', '7');
INSERT INTO `d_challenge` VALUES ('8016', '[{\"id\":2016,\"isget\":false}]', '0', '7');

-- ----------------------------
-- Records of d_chassis
-- ----------------------------
INSERT INTO `d_chassis` VALUES ('1', '10001', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('2', '10002', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('3', '10003', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('4', '10001', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('5', '10002', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('6', '10003', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('7', '10001', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('8', '10002', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('9', '10003', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('10', '10001', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('11', '10002', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('12', '10003', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('13', '10001', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('14', '10002', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('15', '10003', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('16', '10001', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('17', '10002', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_chassis` VALUES ('18', '10003', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');

-- ----------------------------
-- Records of d_chipattribute
-- ----------------------------
INSERT INTO `d_chipattribute` VALUES ('1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('4', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('5', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('6', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('8', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('9', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('10', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('11', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('12', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('13', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('14', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('15', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('16', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('17', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `d_chipattribute` VALUES ('18', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Records of d_chipinfo
-- ----------------------------
INSERT INTO `d_chipinfo` VALUES ('2', '[{\"number\":1,\"id\":10013,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10014,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10015,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10016,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10017,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10018,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10019,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10020,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10021,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10022,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10023,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10024,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10025,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10026,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10027,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10028,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10029,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10030,\"islock\":0,\"level\":1}]', '{}', '{}');
INSERT INTO `d_chipinfo` VALUES ('3', '[{\"number\":1,\"id\":10013,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10014,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10015,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10016,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10017,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10018,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10019,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10020,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10021,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10022,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10023,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10024,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10025,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10026,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10027,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10028,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10029,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10030,\"islock\":0,\"level\":1}]', '{}', '{}');
INSERT INTO `d_chipinfo` VALUES ('4', '[{\"number\":1,\"id\":10013,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10014,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10015,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10016,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10017,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10018,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10019,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10020,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10021,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10022,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10023,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10024,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10025,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10026,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10027,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10028,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10029,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10030,\"islock\":0,\"level\":1}]', '{}', '{}');
INSERT INTO `d_chipinfo` VALUES ('5', '[{\"number\":1,\"id\":10013,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10014,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10015,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10016,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10017,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10018,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10019,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10020,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10021,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10022,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10023,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10024,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10025,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10026,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10027,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10028,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10029,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10030,\"islock\":0,\"level\":1}]', '{}', '{}');
INSERT INTO `d_chipinfo` VALUES ('6', '[{\"number\":1,\"id\":10013,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10014,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10015,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10016,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10017,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10018,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10019,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10020,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10021,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10022,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10023,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10024,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10025,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10026,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10027,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10028,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10029,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10030,\"islock\":0,\"level\":1}]', '{}', '{}');
INSERT INTO `d_chipinfo` VALUES ('7', '[{\"number\":1,\"id\":10013,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10014,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10015,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10016,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10017,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10018,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10019,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10020,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10021,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10022,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10023,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10024,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10025,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10026,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10027,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10028,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10029,\"islock\":0,\"level\":1},{\"number\":1,\"id\":10030,\"islock\":0,\"level\":1}]', '{}', '{}');

-- ----------------------------
-- Records of d_collection
-- ----------------------------
INSERT INTO `d_collection` VALUES ('2', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10018},{\"maxlv\":1,\"cfgid\":10027},{\"maxlv\":1,\"cfgid\":10012},{\"maxlv\":1,\"cfgid\":10013},{\"maxlv\":1,\"cfgid\":10029},{\"maxlv\":1,\"cfgid\":10028}]');
INSERT INTO `d_collection` VALUES ('3', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10018},{\"maxlv\":1,\"cfgid\":10027},{\"maxlv\":1,\"cfgid\":10012},{\"maxlv\":1,\"cfgid\":10013},{\"maxlv\":1,\"cfgid\":10029},{\"maxlv\":1,\"cfgid\":10028}]');
INSERT INTO `d_collection` VALUES ('1', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10018},{\"maxlv\":1,\"cfgid\":10027},{\"maxlv\":1,\"cfgid\":10012},{\"maxlv\":1,\"cfgid\":10013},{\"maxlv\":1,\"cfgid\":10029},{\"maxlv\":1,\"cfgid\":10028}]');
INSERT INTO `d_collection` VALUES ('5', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10018},{\"maxlv\":1,\"cfgid\":10027},{\"maxlv\":1,\"cfgid\":10012},{\"maxlv\":1,\"cfgid\":10013},{\"maxlv\":1,\"cfgid\":10029},{\"maxlv\":1,\"cfgid\":10028}]');
INSERT INTO `d_collection` VALUES ('6', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10018},{\"maxlv\":1,\"cfgid\":10027},{\"maxlv\":1,\"cfgid\":10012},{\"maxlv\":1,\"cfgid\":10013},{\"maxlv\":1,\"cfgid\":10029},{\"maxlv\":1,\"cfgid\":10028}]');
INSERT INTO `d_collection` VALUES ('7', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10008},{\"maxlv\":1,\"cfgid\":10001},{\"maxlv\":1,\"cfgid\":10002},{\"maxlv\":1,\"cfgid\":10003}]', '[{\"maxlv\":1,\"cfgid\":10018},{\"maxlv\":1,\"cfgid\":10027},{\"maxlv\":1,\"cfgid\":10012},{\"maxlv\":1,\"cfgid\":10013},{\"maxlv\":1,\"cfgid\":10029},{\"maxlv\":1,\"cfgid\":10028}]');

-- ----------------------------
-- Records of d_daytask
-- ----------------------------
INSERT INTO `d_daytask` VALUES ('1', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_daytask` VALUES ('2', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_daytask` VALUES ('3', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_daytask` VALUES ('4', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_daytask` VALUES ('5', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_daytask` VALUES ('6', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_daytask` VALUES ('7', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_daytask` VALUES ('8', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_daytask` VALUES ('9', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_daytask` VALUES ('10', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_daytask` VALUES ('11', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_daytask` VALUES ('12', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');

-- ----------------------------
-- Records of d_firecontroller
-- ----------------------------
INSERT INTO `d_firecontroller` VALUES ('1', '10008', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('2', '10001', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('3', '10002', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('4', '10003', '2', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('5', '10008', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('6', '10001', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('7', '10002', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('8', '10003', '3', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('9', '10008', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('10', '10001', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('11', '10002', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('12', '10003', '4', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('13', '10008', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('14', '10001', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('15', '10002', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('16', '10003', '5', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('17', '10008', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('18', '10001', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('19', '10002', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('20', '10003', '6', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('21', '10008', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('22', '10001', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('23', '10002', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');
INSERT INTO `d_firecontroller` VALUES ('24', '10003', '7', '30', '0', '[{},{},{},{},{}]', '0', '30', '0', '0', '0');

-- ----------------------------
-- Records of d_gold
-- ----------------------------
INSERT INTO `d_gold` VALUES ('2', '10000');
INSERT INTO `d_gold` VALUES ('3', '10000');
INSERT INTO `d_gold` VALUES ('4', '10000');
INSERT INTO `d_gold` VALUES ('5', '10000');
INSERT INTO `d_gold` VALUES ('6', '10000');
INSERT INTO `d_gold` VALUES ('7', '10000');

-- ----------------------------
-- Records of d_khorium
-- ----------------------------
INSERT INTO `d_khorium` VALUES ('2', '10000000');
INSERT INTO `d_khorium` VALUES ('3', '10000000');
INSERT INTO `d_khorium` VALUES ('4', '10000000');
INSERT INTO `d_khorium` VALUES ('5', '10000000');
INSERT INTO `d_khorium` VALUES ('6', '10000000');
INSERT INTO `d_khorium` VALUES ('7', '10000000');

-- ----------------------------
-- Records of d_hangar
-- ----------------------------
INSERT INTO `d_hangar` VALUES ('2', '', '', '', '', '1,2,3,4', '1,2,3', '1,2,3,4', '1,2,3,4,5,6');
INSERT INTO `d_hangar` VALUES ('3', '', '', '', '', '5,6,7,8', '4,5,6', '5,6,7,8', '7,8,9,10,11,12');
INSERT INTO `d_hangar` VALUES ('4', '', '', '', '', '9,10,11,12', '7,8,9', '9,10,11,12', '13,14,15,16,17,18');
INSERT INTO `d_hangar` VALUES ('5', '', '', '', '', '13,14,15,16', '10,11,12', '13,14,15,16', '19,20,21,22,23,24');
INSERT INTO `d_hangar` VALUES ('6', '', '', '', '', '17,18,19,20', '13,14,15', '17,18,19,20', '25,26,27,28,29,30');
INSERT INTO `d_hangar` VALUES ('7', '', '', '', '', '21,22,23,24', '16,17,18', '21,22,23,24', '31,32,33,34,35,36');

-- ----------------------------
-- Records of d_machinecfg
-- ----------------------------
INSERT INTO `d_machinecfg` VALUES ('1', '2', '1', '1000110001', '2', '1', '2', '维京灵袭冰羽士', '0,0,0,3,0,0,4,0,', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('2', '2', '2', '1000110001', '3', '2', '3', '猎手推进D20', '1,0,0,2,0,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('3', '2', '3', '1000110001', '4', '3', '4', '战灵灵长W54', '6,0,0,5,0,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('4', '3', '1', '1000110001', '6', '4', '6', '维京灵袭冰羽士', '0,0,0,9,0,0,10,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('5', '3', '2', '1000110001', '7', '5', '7', '猎手推进D20', '7,0,0,8,0,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('6', '3', '3', '1000110001', '8', '6', '8', '战灵灵长W54', '12,0,0,11,0,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('7', '4', '1', '1000110001', '10', '7', '10', '维京灵袭冰羽士', '0,0,0,15,0,0,16,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('8', '4', '2', '1000110001', '11', '8', '11', '猎手推进D20', '13,0,0,14,0,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('9', '4', '3', '1000110001', '12', '9', '12', '战灵灵长W54', '18,0,0,17,0,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('10', '5', '1', '1000110001', '14', '10', '14', '维京灵袭冰羽士', '0,0,0,21,0,0,22,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('11', '5', '2', '1000110001', '15', '11', '15', '猎手推进D20', '19,0,0,20,0,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('12', '5', '3', '1000110001', '16', '12', '16', '战灵灵长W54', '24,0,0,23,0,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('13', '6', '1', '1000110001', '18', '13', '18', '维京灵袭冰羽士', '0,0,0,27,0,0,28,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('14', '6', '2', '1000110001', '19', '14', '19', '猎手推进D20', '25,0,0,26,0,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('15', '6', '3', '1000110001', '20', '15', '20', '战灵灵长W54', '30,0,0,29,0,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('16', '7', '1', '1000110001', '22', '16', '22', '维京灵袭冰羽士', '0,0,0,33,0,0,34,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('17', '7', '2', '1000110001', '23', '17', '23', '猎手推进D20', '31,0,0,32,0,0', '0', '0', '0');
INSERT INTO `d_machinecfg` VALUES ('18', '7', '3', '1000110001', '24', '18', '24', '战灵灵长W54', '36,0,0,35,0,0', '0', '0', '0');

-- ----------------------------
-- Records of d_machineinfo
-- ----------------------------
INSERT INTO `d_machineinfo` VALUES ('2', '1', '1,2,3');
INSERT INTO `d_machineinfo` VALUES ('3', '1', '4,5,6');
INSERT INTO `d_machineinfo` VALUES ('4', '1', '7,8,9');
INSERT INTO `d_machineinfo` VALUES ('5', '1', '10,11,12');
INSERT INTO `d_machineinfo` VALUES ('6', '1', '13,14,15');
INSERT INTO `d_machineinfo` VALUES ('7', '1', '16,17,18');

-- ----------------------------
-- Records of d_materials
-- ----------------------------
INSERT INTO `d_materials` VALUES ('2', '10016,3000,10017,3000,10018,3000,10019,3000,10020,3000,10021,3000,10022,3000,10023,3000,10024,3000,10025,3000,10001,3000,10002,3000,10003,3000,10004,3000,10005,3000,10006,3000,10007,3000,10008,3000,10009,3000,10010,3000,10011,3000,10012,3000,10013,3000,10014,3000,10015,3000', '');
INSERT INTO `d_materials` VALUES ('3', '10016,3000,10017,3000,10018,3000,10019,3000,10020,3000,10021,3000,10022,3000,10023,3000,10024,3000,10025,3000,10001,3000,10002,3000,10003,3000,10004,3000,10005,3000,10006,3000,10007,3000,10008,3000,10009,3000,10010,3000,10011,3000,10012,3000,10013,3000,10014,3000,10015,3000', '');
INSERT INTO `d_materials` VALUES ('4', '10016,3000,10017,3000,10018,3000,10019,3000,10020,3000,10021,3000,10022,3000,10023,3000,10024,3000,10025,3000,10001,3000,10002,3000,10003,3000,10004,3000,10005,3000,10006,3000,10007,3000,10008,3000,10009,3000,10010,3000,10011,3000,10012,3000,10013,3000,10014,3000,10015,3000', '');
INSERT INTO `d_materials` VALUES ('5', '10016,3000,10017,3000,10018,3000,10019,3000,10020,3000,10021,3000,10022,3000,10023,3000,10024,3000,10025,3000,10001,3000,10002,3000,10003,3000,10004,3000,10005,3000,10006,3000,10007,3000,10008,3000,10009,3000,10010,3000,10011,3000,10012,3000,10013,3000,10014,3000,10015,3000', '');
INSERT INTO `d_materials` VALUES ('6', '10016,3000,10017,3000,10018,3000,10019,3000,10020,3000,10021,3000,10022,3000,10023,3000,10024,3000,10025,3000,10001,3000,10002,3000,10003,3000,10004,3000,10005,3000,10006,3000,10007,3000,10008,3000,10009,3000,10010,3000,10011,3000,10012,3000,10013,3000,10014,3000,10015,3000', '');
INSERT INTO `d_materials` VALUES ('7', '10016,3000,10017,3000,10018,3000,10019,3000,10020,3000,10021,3000,10022,3000,10023,3000,10024,3000,10025,3000,10001,3000,10002,3000,10003,3000,10004,3000,10005,3000,10006,3000,10007,3000,10008,3000,10009,3000,10010,3000,10011,3000,10012,3000,10013,3000,10014,3000,10015,3000', '');


-- ----------------------------
-- Records of d_overview
-- ----------------------------
INSERT INTO `d_overview` VALUES ('2', '0', '0', '0', '1001,1002,1003,1004,1005,1006', '', '3008,3009,3007,3002,3004,3005,3003,3014,3016', '1', '{}');
INSERT INTO `d_overview` VALUES ('3', '0', '0', '0', '2001,2002,2003,2004,2005,2006', '', '4008,4009,4007,4002,4004,4005,4003,4014,4016', '1', '{}');
INSERT INTO `d_overview` VALUES ('4', '0', '0', '0', '3001,3002,3003,3004,3005,3006', '', '5008,5009,5007,5002,5004,5005,5003,5014,5016', '1', '{}');
INSERT INTO `d_overview` VALUES ('5', '0', '0', '0', '4001,4002,4003,4004,4005,4006', '', '6008,6009,6007,6002,6004,6005,6003,6014,6016', '1', '{}');
INSERT INTO `d_overview` VALUES ('6', '0', '0', '0', '5001,5002,5003,5004,5005,5006', '', '7008,7009,7007,7002,7004,7005,7003,7014,7016', '1', '{}');
INSERT INTO `d_overview` VALUES ('7', '0', '0', '0', '6001,6002,6003,6004,6005,6006', '', '8008,8009,8007,8002,8004,8005,8003,8014,8016', '1', '{}');


-- ----------------------------
-- Records of d_playerattribute
-- ----------------------------
INSERT INTO `d_playerattribute` VALUES ('2', '300', '200', '200', '0', '30', '80', '0.5', '0.015', '60');
INSERT INTO `d_playerattribute` VALUES ('3', '300', '200', '200', '0', '30', '80', '0.5', '0.015', '60');
INSERT INTO `d_playerattribute` VALUES ('4', '300', '200', '200', '0', '30', '80', '0.5', '0.015', '60');
INSERT INTO `d_playerattribute` VALUES ('5', '300', '200', '200', '0', '30', '80', '0.5', '0.015', '60');
INSERT INTO `d_playerattribute` VALUES ('6', '300', '200', '200', '0', '30', '80', '0.5', '0.015', '60');
INSERT INTO `d_playerattribute` VALUES ('7', '300', '200', '200', '0', '30', '80', '0.5', '0.015', '60');

-- ----------------------------
-- Records of d_plot
-- ----------------------------
INSERT INTO `d_plot` VALUES ('1001', '[{\"id\":1,\"isget\":false}]', '1', '2');
INSERT INTO `d_plot` VALUES ('1002', '[{\"id\":2,\"isget\":false}]', '1', '2');
INSERT INTO `d_plot` VALUES ('1003', '[{\"id\":3,\"isget\":false}]', '1', '2');
INSERT INTO `d_plot` VALUES ('1004', '[{\"id\":4,\"isget\":false}]', '1', '2');
INSERT INTO `d_plot` VALUES ('1005', '[{\"id\":5,\"isget\":false}]', '1', '2');
INSERT INTO `d_plot` VALUES ('1006', '[{\"id\":6,\"isget\":false}]', '1', '2');
INSERT INTO `d_plot` VALUES ('2001', '[{\"id\":1,\"isget\":false}]', '1', '3');
INSERT INTO `d_plot` VALUES ('2002', '[{\"id\":2,\"isget\":false}]', '1', '3');
INSERT INTO `d_plot` VALUES ('2003', '[{\"id\":3,\"isget\":false}]', '1', '3');
INSERT INTO `d_plot` VALUES ('2004', '[{\"id\":4,\"isget\":false}]', '1', '3');
INSERT INTO `d_plot` VALUES ('2005', '[{\"id\":5,\"isget\":false}]', '1', '3');
INSERT INTO `d_plot` VALUES ('2006', '[{\"id\":6,\"isget\":false}]', '1', '3');
INSERT INTO `d_plot` VALUES ('3001', '[{\"id\":1,\"isget\":false}]', '1', '4');
INSERT INTO `d_plot` VALUES ('3002', '[{\"id\":2,\"isget\":false}]', '1', '4');
INSERT INTO `d_plot` VALUES ('3003', '[{\"id\":3,\"isget\":false}]', '1', '4');
INSERT INTO `d_plot` VALUES ('3004', '[{\"id\":4,\"isget\":false}]', '1', '4');
INSERT INTO `d_plot` VALUES ('3005', '[{\"id\":5,\"isget\":false}]', '1', '4');
INSERT INTO `d_plot` VALUES ('3006', '[{\"id\":6,\"isget\":false}]', '1', '4');
INSERT INTO `d_plot` VALUES ('4001', '[{\"id\":1,\"isget\":false}]', '1', '5');
INSERT INTO `d_plot` VALUES ('4002', '[{\"id\":2,\"isget\":false}]', '1', '5');
INSERT INTO `d_plot` VALUES ('4003', '[{\"id\":3,\"isget\":false}]', '1', '5');
INSERT INTO `d_plot` VALUES ('4004', '[{\"id\":4,\"isget\":false}]', '1', '5');
INSERT INTO `d_plot` VALUES ('4005', '[{\"id\":5,\"isget\":false}]', '1', '5');
INSERT INTO `d_plot` VALUES ('4006', '[{\"id\":6,\"isget\":false}]', '1', '5');
INSERT INTO `d_plot` VALUES ('5001', '[{\"id\":1,\"isget\":false}]', '1', '6');
INSERT INTO `d_plot` VALUES ('5002', '[{\"id\":2,\"isget\":false}]', '1', '6');
INSERT INTO `d_plot` VALUES ('5003', '[{\"id\":3,\"isget\":false}]', '1', '6');
INSERT INTO `d_plot` VALUES ('5004', '[{\"id\":4,\"isget\":false}]', '1', '6');
INSERT INTO `d_plot` VALUES ('5005', '[{\"id\":5,\"isget\":false}]', '1', '6');
INSERT INTO `d_plot` VALUES ('5006', '[{\"id\":6,\"isget\":false}]', '1', '6');
INSERT INTO `d_plot` VALUES ('6001', '[{\"id\":1,\"isget\":false}]', '1', '7');
INSERT INTO `d_plot` VALUES ('6002', '[{\"id\":2,\"isget\":false}]', '1', '7');
INSERT INTO `d_plot` VALUES ('6003', '[{\"id\":3,\"isget\":false}]', '1', '7');
INSERT INTO `d_plot` VALUES ('6004', '[{\"id\":4,\"isget\":false}]', '1', '7');
INSERT INTO `d_plot` VALUES ('6005', '[{\"id\":5,\"isget\":false}]', '1', '7');
INSERT INTO `d_plot` VALUES ('6006', '[{\"id\":6,\"isget\":false}]', '1', '7');

-- ----------------------------
-- Records of d_plottask
-- ----------------------------
INSERT INTO `d_plottask` VALUES ('1', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_plottask` VALUES ('2', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_plottask` VALUES ('3', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_plottask` VALUES ('4', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_plottask` VALUES ('5', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_plottask` VALUES ('6', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_plottask` VALUES ('7', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_plottask` VALUES ('8', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_plottask` VALUES ('9', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_plottask` VALUES ('10', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_plottask` VALUES ('11', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');
INSERT INTO `d_plottask` VALUES ('12', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]');

-- ----------------------------
-- Records of d_prop
-- ----------------------------
INSERT INTO `d_prop` VALUES ('2', '10016,10,10017,10,10018,10,10019,10,10020,10,10021,10,10022,10,10023,10,10024,10,10025,10,10026,10,10001,10,10002,10,10003,10,10004,10,10005,10,10006,10,10007,10,10008,10,10009,10,10010,10,10011,10,10012,10,10013,10,10014,10,10015,10', '');
INSERT INTO `d_prop` VALUES ('3', '10016,10,10017,10,10018,10,10019,10,10020,10,10021,10,10022,10,10023,10,10024,10,10025,10,10026,10,10001,10,10002,10,10003,10,10004,10,10005,10,10006,10,10007,10,10008,10,10009,10,10010,10,10011,10,10012,10,10013,10,10014,10,10015,10', '');
INSERT INTO `d_prop` VALUES ('4', '10016,10,10017,10,10018,10,10019,10,10020,10,10021,10,10022,10,10023,10,10024,10,10025,10,10026,10,10001,10,10002,10,10003,10,10004,10,10005,10,10006,10,10007,10,10008,10,10009,10,10010,10,10011,10,10012,10,10013,10,10014,10,10015,10', '');
INSERT INTO `d_prop` VALUES ('5', '10016,10,10017,10,10018,10,10019,10,10020,10,10021,10,10022,10,10023,10,10024,10,10025,10,10026,10,10001,10,10002,10,10003,10,10004,10,10005,10,10006,10,10007,10,10008,10,10009,10,10010,10,10011,10,10012,10,10013,10,10014,10,10015,10', '');
INSERT INTO `d_prop` VALUES ('6', '10016,10,10017,10,10018,10,10019,10,10020,10,10021,10,10022,10,10023,10,10024,10,10025,10,10026,10,10001,10,10002,10,10003,10,10004,10,10005,10,10006,10,10007,10,10008,10,10009,10,10010,10,10011,10,10012,10,10013,10,10014,10,10015,10', '');
INSERT INTO `d_prop` VALUES ('7', '10016,10,10017,10,10018,10,10019,10,10020,10,10021,10,10022,10,10023,10,10024,10,10025,10,10026,10,10001,10,10002,10,10003,10,10004,10,10005,10,10006,10,10007,10,10008,10,10009,10,10010,10,10011,10,10012,10,10013,10,10014,10,10015,10', '');

-- ----------------------------
-- Records of d_queueinfo
-- ----------------------------
INSERT INTO `d_queueinfo` VALUES ('2', '', '', '', '', '', '', '', '3', '10', '5', '');
INSERT INTO `d_queueinfo` VALUES ('3', '', '', '', '', '', '', '', '3', '10', '5', '');
INSERT INTO `d_queueinfo` VALUES ('4', '', '', '', '', '', '', '', '3', '10', '5', '');
INSERT INTO `d_queueinfo` VALUES ('5', '', '', '', '', '', '', '', '3', '10', '5', '');
INSERT INTO `d_queueinfo` VALUES ('6', '', '', '', '', '', '', '', '3', '10', '5', '');
INSERT INTO `d_queueinfo` VALUES ('7', '', '', '', '', '', '', '', '3', '10', '5', '');

-- ----------------------------
-- Records of d_score
-- ----------------------------
INSERT INTO `d_score` VALUES ('2', '1000.8389559008', '0', '0', '0');
INSERT INTO `d_score` VALUES ('3', '1000.8389558941', '0', '0', '0');
INSERT INTO `d_score` VALUES ('4', '1000.8389558932', '0', '0', '0');
INSERT INTO `d_score` VALUES ('5', '1000.8389558924', '0', '0', '0');
INSERT INTO `d_score` VALUES ('6', '1000.8389558916', '0', '0', '0');
INSERT INTO `d_score` VALUES ('7', '1000.8389558906', '0', '0', '0');

-- ----------------------------
-- Records of d_shopiteminfo
-- ----------------------------
INSERT INTO `d_shopiteminfo` VALUES ('2', '');
INSERT INTO `d_shopiteminfo` VALUES ('3', '');
INSERT INTO `d_shopiteminfo` VALUES ('4', '');
INSERT INTO `d_shopiteminfo` VALUES ('5', '');
INSERT INTO `d_shopiteminfo` VALUES ('6', '');
INSERT INTO `d_shopiteminfo` VALUES ('7', '');

-- ----------------------------
-- Records of d_skill
-- ----------------------------
INSERT INTO `d_skill` VALUES ('1', '', '', '');
INSERT INTO `d_skill` VALUES ('2', '', '', '');
INSERT INTO `d_skill` VALUES ('3', '', '', '');
INSERT INTO `d_skill` VALUES ('4', '', '', '');
INSERT INTO `d_skill` VALUES ('5', '', '', '');
INSERT INTO `d_skill` VALUES ('6', '', '', '');
INSERT INTO `d_skill` VALUES ('7', '', '', '');
INSERT INTO `d_skill` VALUES ('8', '', '', '');
INSERT INTO `d_skill` VALUES ('9', '', '', '');
INSERT INTO `d_skill` VALUES ('10', '', '', '');
INSERT INTO `d_skill` VALUES ('11', '', '', '');
INSERT INTO `d_skill` VALUES ('12', '', '', '');
INSERT INTO `d_skill` VALUES ('13', '', '', '');
INSERT INTO `d_skill` VALUES ('14', '', '', '');
INSERT INTO `d_skill` VALUES ('15', '', '', '');
INSERT INTO `d_skill` VALUES ('16', '', '', '');
INSERT INTO `d_skill` VALUES ('17', '', '', '');
INSERT INTO `d_skill` VALUES ('18', '', '', '');

-- ----------------------------
-- Records of d_urgenttask
-- ----------------------------
INSERT INTO `d_urgenttask` VALUES ('1', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610440230', '1610447430');
INSERT INTO `d_urgenttask` VALUES ('2', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610443830', '1610447430');
INSERT INTO `d_urgenttask` VALUES ('3', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610440230', '1610447430');
INSERT INTO `d_urgenttask` VALUES ('4', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610443830', '1610447430');
INSERT INTO `d_urgenttask` VALUES ('5', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610440230', '1610447430');
INSERT INTO `d_urgenttask` VALUES ('6', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610443830', '1610447430');
INSERT INTO `d_urgenttask` VALUES ('7', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610440230', '1610447430');
INSERT INTO `d_urgenttask` VALUES ('8', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610443830', '1610447430');
INSERT INTO `d_urgenttask` VALUES ('9', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610440230', '1610447430');
INSERT INTO `d_urgenttask` VALUES ('10', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610443830', '1610447430');
INSERT INTO `d_urgenttask` VALUES ('11', '1', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610440230', '1610447430');
INSERT INTO `d_urgenttask` VALUES ('12', '10', '1', '[{\"achid\":1010,\"number\":0,\"objectid\":1},{\"achid\":1036,\"number\":0,\"objectid\":2}]', '1610443830', '1610447430');


-- ----------------------------
-- Records of d_putawayinfo
-- ----------------------------
INSERT INTO `d_putawayinfo` VALUES ('2', '', '', '', '');
INSERT INTO `d_putawayinfo` VALUES ('3', '', '', '', '');
INSERT INTO `d_putawayinfo` VALUES ('4', '', '', '', '');
INSERT INTO `d_putawayinfo` VALUES ('5', '', '', '', '');
INSERT INTO `d_putawayinfo` VALUES ('6', '', '', '', '');
INSERT INTO `d_putawayinfo` VALUES ('7', '', '', '', '');