/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 80020
Source Host           : localhost:3306
Source Database       : athena

Target Server Type    : MYSQL
Target Server Version : 80020
File Encoding         : 65001

Date: 2021-01-12 16:49:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for d_account
-- ----------------------------
DROP TABLE IF EXISTS `d_account`;
CREATE TABLE `d_account` (
  `id` int unsigned NOT NULL COMMENT '系统编号，对应d_user表的uid',
  `pid` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '平台下发的id',
  `sdkid` int unsigned NOT NULL COMMENT 'sdkid',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pid_sdkid` (`pid`,`sdkid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='帐号表';

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
-- Table structure for d_athletics
-- ----------------------------
DROP TABLE IF EXISTS `d_athletics`;
CREATE TABLE `d_athletics` (
  `id` int unsigned NOT NULL COMMENT '成就类别id',
  `athleticslist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '竞技信息',
  `count` int unsigned NOT NULL DEFAULT '0' COMMENT '当前值',
  `uid` int unsigned NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='竞技';

-- ----------------------------
-- Records of d_athletics
-- ----------------------------

-- ----------------------------
-- Table structure for d_awardinfo
-- ----------------------------
DROP TABLE IF EXISTS `d_awardinfo`;
CREATE TABLE `d_awardinfo` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `bprewardlist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '蓝图奖励信息',
  `proprewardlist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '材料奖励信息',
  `equiplist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '装备奖励信息',
  `sponsorid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发起请求的id，0表示无',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='奖励信息';

-- ----------------------------
-- Records of d_awardinfo
-- ----------------------------

-- ----------------------------
-- Table structure for d_blueprint
-- ----------------------------
DROP TABLE IF EXISTS `d_blueprint`;
CREATE TABLE `d_blueprint` (
  `id` int unsigned NOT NULL COMMENT '玩家id',
  `newblueprint` text COLLATE utf8mb4_unicode_ci COMMENT '新蓝图信息',
  `blueprintinfo` text COLLATE utf8mb4_unicode_ci COMMENT '蓝图信息',
  `blueprinting` text COLLATE utf8mb4_unicode_ci COMMENT '正在铸造蓝图信息',
  `blueprintend` text COLLATE utf8mb4_unicode_ci COMMENT '铸造完成蓝图信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='蓝图信息';

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
-- Table structure for d_body
-- ----------------------------
DROP TABLE IF EXISTS `d_body`;
CREATE TABLE `d_body` (
  `id` int unsigned NOT NULL COMMENT '机体uniqueID',
  `cfgid` int unsigned NOT NULL COMMENT '配置表中的机体ID',
  `playerid` int unsigned NOT NULL COMMENT '所属玩家ID',
  `lv` int unsigned NOT NULL COMMENT '该机体的等级',
  `exp` int unsigned NOT NULL COMMENT '该机体的经验',
  `slotarray` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '槽位信息',
  `isdouble` tinyint(1) DEFAULT '0' COMMENT '是否使用反应堆',
  `volume` int unsigned DEFAULT '2' COMMENT '容量',
  `currentvolume` int unsigned DEFAULT '0' COMMENT '当前已使用容量',
  `count` int unsigned DEFAULT '0' COMMENT '极化次数',
  `islock` tinyint(1) DEFAULT '0' COMMENT '是否锁定',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家机体';

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
-- Table structure for d_businessqueue
-- ----------------------------
DROP TABLE IF EXISTS `d_businessqueue`;
CREATE TABLE `d_businessqueue` (
  `id` bigint unsigned NOT NULL COMMENT '自增长id',
  `playerid` bigint NOT NULL,
  `type` int NOT NULL DEFAULT '0' COMMENT '事务类型',
  `subtype` int NOT NULL DEFAULT '0' COMMENT '事务子类型',
  `starttime` bigint NOT NULL DEFAULT '0' COMMENT '开始时间',
  `endtime` bigint NOT NULL DEFAULT '0' COMMENT '结束时间',
  `initendtime` bigint NOT NULL DEFAULT '0' COMMENT '初始结束时间',
  `bprewardlist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '蓝图奖励信息',
  `proprewardlist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '材料奖励信息',
  `equiplist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '装备奖励信息',
  `sponsorid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发起请求的id，0表示无',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='事务';

-- ----------------------------
-- Records of d_businessqueue
-- ----------------------------

-- ----------------------------
-- Table structure for d_challenge
-- ----------------------------
DROP TABLE IF EXISTS `d_challenge`;
CREATE TABLE `d_challenge` (
  `id` int unsigned NOT NULL COMMENT '成就类别id',
  `challengelist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '挑战信息',
  `count` int unsigned NOT NULL DEFAULT '0' COMMENT '当前值',
  `uid` int unsigned NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='挑战';

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
-- Table structure for d_chassis
-- ----------------------------
DROP TABLE IF EXISTS `d_chassis`;
CREATE TABLE `d_chassis` (
  `id` int unsigned NOT NULL COMMENT '底盘uniqueID',
  `cfgid` int unsigned NOT NULL COMMENT '配置表中的底盘ID',
  `playerid` int unsigned NOT NULL COMMENT '所属玩家ID',
  `lv` int unsigned NOT NULL COMMENT '该底盘的等级',
  `exp` int unsigned NOT NULL COMMENT '该底盘的经验',
  `slotarray` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '槽位信息',
  `isdouble` tinyint(1) DEFAULT '0' COMMENT '是否使用反应堆',
  `volume` int unsigned DEFAULT '2' COMMENT '容量',
  `currentvolume` int unsigned DEFAULT '0' COMMENT '当前已使用容量',
  `count` int unsigned DEFAULT '0' COMMENT '极化次数',
  `islock` tinyint(1) DEFAULT '0' COMMENT '是否锁定',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家底盘';

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
-- Table structure for d_chipattribute
-- ----------------------------
DROP TABLE IF EXISTS `d_chipattribute`;
CREATE TABLE `d_chipattribute` (
  `id` int unsigned NOT NULL COMMENT '机体ID',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='芯片属性';

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
-- Table structure for d_chipinfo
-- ----------------------------
DROP TABLE IF EXISTS `d_chipinfo`;
CREATE TABLE `d_chipinfo` (
  `id` int unsigned NOT NULL COMMENT '玩家id',
  `newchipinfo` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '新芯片信息集合',
  `chipinfoarr` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '玩家芯片信息集合',
  `inchipinfoarr` text COLLATE utf8mb4_unicode_ci COMMENT '玩家已装备芯片集合',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家芯片信息';

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
-- Table structure for d_collection
-- ----------------------------
DROP TABLE IF EXISTS `d_collection`;
CREATE TABLE `d_collection` (
  `id` int unsigned NOT NULL COMMENT '玩家id',
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '机体信息',
  `chassis` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '底盘信息',
  `firecontroller` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '火控信息',
  `weapon` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '武器信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收集信息';

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
-- Table structure for d_daytask
-- ----------------------------
DROP TABLE IF EXISTS `d_daytask`;
CREATE TABLE `d_daytask` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `cfgid` int unsigned NOT NULL COMMENT '每日任务id',
  `type` int unsigned NOT NULL COMMENT '状态',
  `progress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '进度',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='每日任务';

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
-- Table structure for d_firecontroller
-- ----------------------------
DROP TABLE IF EXISTS `d_firecontroller`;
CREATE TABLE `d_firecontroller` (
  `id` int unsigned NOT NULL COMMENT '火控uniqueID',
  `cfgid` int unsigned NOT NULL COMMENT '配置表中的火控ID',
  `playerid` int unsigned NOT NULL COMMENT '所属玩家ID',
  `lv` int unsigned NOT NULL COMMENT '该火控的等级',
  `exp` int unsigned NOT NULL COMMENT '该火控的经验',
  `slotarray` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '槽位信息',
  `isdouble` tinyint(1) DEFAULT '0' COMMENT '是否使用反应堆',
  `volume` int unsigned DEFAULT '2' COMMENT '容量',
  `currentvolume` int unsigned DEFAULT '0' COMMENT '当前已使用容量',
  `count` int unsigned DEFAULT '0' COMMENT '极化次数',
  `islock` tinyint(1) DEFAULT '0' COMMENT '是否锁定',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家火控';

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
-- Table structure for d_gold
-- ----------------------------
DROP TABLE IF EXISTS `d_gold`;
CREATE TABLE `d_gold` (
  `id` int unsigned NOT NULL COMMENT '玩家id',
  `goldnumber` int unsigned NOT NULL DEFAULT '0' COMMENT '金币数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='金币信息';

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
-- Table structure for d_hangar
-- ----------------------------
DROP TABLE IF EXISTS `d_hangar`;
CREATE TABLE `d_hangar` (
  `id` int unsigned NOT NULL COMMENT '玩家id',
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '机体uniqueid集合',
  `chassis` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '底盘uniqueid集合',
  `firecontroller` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '火控uniqueid集合',
  `weapons` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '武器uniqueid集合',
  `newbody` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '新机体uniqueid集合',
  `newchassis` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '新底盘uniqueid集合',
  `newfirecontroller` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '新火控uniqueid集合',
  `newweapons` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '新武器uniqueid集合',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家机库';

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
-- Table structure for d_khorium
-- ----------------------------
DROP TABLE IF EXISTS `d_khorium`;
CREATE TABLE `d_khorium` (
  `id` int unsigned NOT NULL COMMENT '玩家id',
  `khorium` int unsigned NOT NULL DEFAULT '0' COMMENT '氪金数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='氪金信息';

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
-- Table structure for d_machinecfg
-- ----------------------------
DROP TABLE IF EXISTS `d_machinecfg`;
CREATE TABLE `d_machinecfg` (
  `id` int unsigned NOT NULL COMMENT '机甲配置ID',
  `playerid` int unsigned NOT NULL COMMENT '所属玩家ID',
  `userindex` int unsigned NOT NULL COMMENT '机甲库里的第几套配置',
  `machineid` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '机甲id',
  `machinebody` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '机体信息',
  `machinechassis` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '底盘信息',
  `firecontroller` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '火控信息',
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '机甲名字',
  `weapons` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '武器信息',
  `isweld` tinyint(1) DEFAULT '0' COMMENT '是否焊死',
  `begintime` int unsigned DEFAULT '0' COMMENT '开始时间',
  `endtime` int unsigned DEFAULT '0' COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='机甲配置表';

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
-- Table structure for d_machineinfo
-- ----------------------------
DROP TABLE IF EXISTS `d_machineinfo`;
CREATE TABLE `d_machineinfo` (
  `id` int unsigned NOT NULL COMMENT '玩家ID',
  `defaultindex` int NOT NULL DEFAULT '1' COMMENT '当前选中哪一套',
  `machinecfgid` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '玩家所属的机甲配置id列表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家机甲信息';

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
-- Table structure for d_materials
-- ----------------------------
DROP TABLE IF EXISTS `d_materials`;
CREATE TABLE `d_materials` (
  `id` int unsigned NOT NULL COMMENT '玩家id',
  `newmaterials` text COLLATE utf8mb4_unicode_ci COMMENT '新材料信息',
  `materials` text COLLATE utf8mb4_unicode_ci COMMENT '材料信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='材料信息';

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
-- Table structure for d_overview
-- ----------------------------
DROP TABLE IF EXISTS `d_overview`;
CREATE TABLE `d_overview` (
  `id` int unsigned NOT NULL COMMENT '用户id',
  `plotnum` int unsigned DEFAULT '0' COMMENT '已完成剧情数量',
  `athleticsnum` int unsigned DEFAULT '0' COMMENT '已完成竞技数量',
  `challengenum` int unsigned DEFAULT '0' COMMENT '已完成挑战数量',
  `plot` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '剧情id类型集合',
  `athletics` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '竞技id类型集合',
  `challenge` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '挑战id类型集合',
  `current` int unsigned DEFAULT '0' COMMENT '要被覆盖的编号',
  `achievelist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '成就信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='总览';

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
-- Table structure for d_playerattribute
-- ----------------------------
DROP TABLE IF EXISTS `d_playerattribute`;
CREATE TABLE `d_playerattribute` (
  `id` int unsigned NOT NULL COMMENT '玩家ID',
  `life` int NOT NULL DEFAULT '0' COMMENT '生命',
  `speed` int NOT NULL DEFAULT '0' COMMENT '速度',
  `energy` int NOT NULL DEFAULT '0' COMMENT '能量',
  `shield` int NOT NULL DEFAULT '0' COMMENT '护盾值',
  `elevation` int NOT NULL DEFAULT '0' COMMENT '仰角',
  `overhang` int NOT NULL DEFAULT '0' COMMENT '俯角',
  `enefficiency` float NOT NULL DEFAULT '0' COMMENT '能量效率',
  `efficiency` float NOT NULL DEFAULT '0' COMMENT '引擎效率',
  `climbingangle` int NOT NULL DEFAULT '0' COMMENT '底盘爬角',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家属性';

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
-- Table structure for d_plot
-- ----------------------------
DROP TABLE IF EXISTS `d_plot`;
CREATE TABLE `d_plot` (
  `id` int unsigned NOT NULL COMMENT '剧情类别id',
  `plotlist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '剧情信息',
  `count` int unsigned NOT NULL DEFAULT '0' COMMENT '当前剧情进度',
  `uid` int unsigned NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='剧情';

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
-- Table structure for d_plottask
-- ----------------------------
DROP TABLE IF EXISTS `d_plottask`;
CREATE TABLE `d_plottask` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `cfgid` int unsigned NOT NULL COMMENT '剧情任务id',
  `type` int unsigned NOT NULL COMMENT '状态',
  `progress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '进度',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='剧情任务';

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
-- Table structure for d_prop
-- ----------------------------
DROP TABLE IF EXISTS `d_prop`;
CREATE TABLE `d_prop` (
  `id` int unsigned NOT NULL COMMENT '玩家id',
  `newprops` text COLLATE utf8mb4_unicode_ci COMMENT '新道具信息',
  `props` text COLLATE utf8mb4_unicode_ci COMMENT '道具信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='道具信息';

-- ----------------------------
-- Records of d_prop
-- ----------------------------
INSERT INTO `d_prop` VALUES ('2', '', '');
INSERT INTO `d_prop` VALUES ('3', '', '');
INSERT INTO `d_prop` VALUES ('4', '', '');
INSERT INTO `d_prop` VALUES ('5', '', '');
INSERT INTO `d_prop` VALUES ('6', '', '');
INSERT INTO `d_prop` VALUES ('7', '', '');

-- ----------------------------
-- Table structure for d_putaway
-- ----------------------------
DROP TABLE IF EXISTS `d_putaway`;
CREATE TABLE `d_putaway` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `cfgid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置id',
  `number` int unsigned DEFAULT '0' COMMENT '数量',
  `price` int unsigned DEFAULT '0' COMMENT '价格',
  `type` int unsigned NOT NULL COMMENT '类别',
  `puttime` int unsigned NOT NULL COMMENT '上架时间',
  `downtime` int unsigned NOT NULL COMMENT '下架时间',
  `uid` int unsigned NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='蓝图上架物品信息';

-- ----------------------------
-- Records of d_putaway
-- ----------------------------

-- ----------------------------
-- Table structure for d_putawaygold
-- ----------------------------
DROP TABLE IF EXISTS `d_putawaygold`;
CREATE TABLE `d_putawaygold` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `cfgid` int unsigned NOT NULL COMMENT '配置id',
  `number` int unsigned DEFAULT '0' COMMENT '数量',
  `price` int unsigned DEFAULT '0' COMMENT '价格',
  `type` int unsigned NOT NULL COMMENT '类别',
  `puttime` int unsigned NOT NULL COMMENT '上架时间',
  `downtime` int unsigned NOT NULL COMMENT '下架时间',
  `uid` int unsigned NOT NULL COMMENT '用户id',
  `ismarket` int unsigned NOT NULL COMMENT '是否和系统交易为0表示交易',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='金币上架物品信息';

-- ----------------------------
-- Records of d_putawaygold
-- ----------------------------

-- ----------------------------
-- Table structure for d_putawayinfo
-- ----------------------------
DROP TABLE IF EXISTS `d_putawayinfo`;
CREATE TABLE `d_putawayinfo` (
  `id` int unsigned NOT NULL COMMENT '用户id',
  `goldarr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '金币已上架商品集合',
  `khoriumarr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '氪金已上架商品集合',
  `staygoldarr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '金币待上架商品集合',
  `staykhoriumarr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '氪金待上架商品集合',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='上架信息集合';

-- ----------------------------
-- Records of d_putawayinfo
-- ----------------------------
INSERT INTO `d_putawayinfo` VALUES ('2', '', '', '', '');
INSERT INTO `d_putawayinfo` VALUES ('3', '', '', '', '');
INSERT INTO `d_putawayinfo` VALUES ('4', '', '', '', '');
INSERT INTO `d_putawayinfo` VALUES ('5', '', '', '', '');
INSERT INTO `d_putawayinfo` VALUES ('6', '', '', '', '');
INSERT INTO `d_putawayinfo` VALUES ('7', '', '', '', '');

-- ----------------------------
-- Table structure for d_queueinfo
-- ----------------------------
DROP TABLE IF EXISTS `d_queueinfo`;
CREATE TABLE `d_queueinfo` (
  `id` int unsigned NOT NULL COMMENT '玩家id',
  `ingcasting` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '正在铸造id集合',
  `endcasting` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '铸造完成id集合',
  `ingscan` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '正在扫描id集合',
  `endscan` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '扫描完成id集合',
  `airfreighter1` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '运输机id集合1',
  `airfreighter2` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '运输机id集合2',
  `airfreighter3` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '运输机id集合3',
  `maxairfreighter` int unsigned NOT NULL DEFAULT '1' COMMENT '最大运输机数量',
  `maxperairfreighter` int unsigned NOT NULL DEFAULT '1' COMMENT '每条运输机队列的最大排队数量',
  `maxcasting` int unsigned NOT NULL DEFAULT '1' COMMENT '最大铸造数量',
  `tmpbqinfos` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '缓存的队列信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='队列信息';

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
-- Table structure for d_score
-- ----------------------------
DROP TABLE IF EXISTS `d_score`;
CREATE TABLE `d_score` (
  `id` int unsigned NOT NULL COMMENT '玩家id',
  `score` double NOT NULL DEFAULT '1000' COMMENT '玩家分数',
  `maxnumber` int unsigned NOT NULL DEFAULT '0' COMMENT '场数',
  `winnumber` int unsigned NOT NULL DEFAULT '0' COMMENT '胜利场数',
  `supportnum` int unsigned NOT NULL DEFAULT '0' COMMENT '队友点赞数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分数信息';

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
-- Table structure for d_shopitem
-- ----------------------------
DROP TABLE IF EXISTS `d_shopitem`;
CREATE TABLE `d_shopitem` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `cfgid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置id',
  `number` int unsigned DEFAULT '0' COMMENT '数量',
  `price` int unsigned DEFAULT '0' COMMENT '价格',
  `type` int unsigned NOT NULL COMMENT '类别',
  `shoptime` int unsigned NOT NULL COMMENT '购买时间',
  `iskh` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否氪金',
  `uid` int unsigned NOT NULL COMMENT 'uid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购买物品';

-- ----------------------------
-- Records of d_shopitem
-- ----------------------------

-- ----------------------------
-- Table structure for d_shopiteminfo
-- ----------------------------
DROP TABLE IF EXISTS `d_shopiteminfo`;
CREATE TABLE `d_shopiteminfo` (
  `id` int unsigned NOT NULL COMMENT '用户id',
  `shopiteminfo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '购买物品id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购买物品id集合';

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
-- Table structure for d_show
-- ----------------------------
DROP TABLE IF EXISTS `d_show`;
CREATE TABLE `d_show` (
  `id` int unsigned NOT NULL COMMENT '玩家id',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '机甲名字',
  `body` text COLLATE utf8mb4_unicode_ci COMMENT '机体信息',
  `chassis` text COLLATE utf8mb4_unicode_ci COMMENT '底盘信息',
  `firecontroller` text COLLATE utf8mb4_unicode_ci COMMENT '火控信息',
  `weapon` text COLLATE utf8mb4_unicode_ci COMMENT '武器信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='展示机甲信息';

-- ----------------------------
-- Records of d_show
-- ----------------------------

-- ----------------------------
-- Table structure for d_skill
-- ----------------------------
DROP TABLE IF EXISTS `d_skill`;
CREATE TABLE `d_skill` (
  `id` int unsigned NOT NULL COMMENT '机体ID',
  `skillarray` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '部位和主动技能集合',
  `passkillarray` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '部位和被动技能集合',
  `selectskill` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '战斗携带的主动技能的部位和id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能信息';

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
-- Table structure for d_stayputaway
-- ----------------------------
DROP TABLE IF EXISTS `d_stayputaway`;
CREATE TABLE `d_stayputaway` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `cfgid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置id',
  `number` int unsigned DEFAULT '0' COMMENT '数量',
  `iskh` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否氪金',
  `price` int unsigned DEFAULT '0' COMMENT '价格',
  `type` int unsigned NOT NULL COMMENT '类别',
  `puttime` int unsigned NOT NULL COMMENT '上架时间',
  `downtime` int unsigned NOT NULL COMMENT '下架时间',
  `uid` int unsigned NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='待上架物品信息';

-- ----------------------------
-- Records of d_stayputaway
-- ----------------------------

-- ----------------------------
-- Table structure for d_tmpbqinfo
-- ----------------------------
DROP TABLE IF EXISTS `d_tmpbqinfo`;
CREATE TABLE `d_tmpbqinfo` (
  `id` bigint unsigned NOT NULL COMMENT '自增长id',
  `rawid` bigint unsigned NOT NULL COMMENT '队列表中的id',
  `subtype` int NOT NULL DEFAULT '0' COMMENT '第几个队列',
  `bprewardlist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '蓝图奖励信息',
  `proprewardlist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '材料奖励信息',
  `equiplist` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '装备奖励信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='离线缓存的队列奖励信息';

-- ----------------------------
-- Records of d_tmpbqinfo
-- ----------------------------

-- ----------------------------
-- Table structure for d_urgenttask
-- ----------------------------
DROP TABLE IF EXISTS `d_urgenttask`;
CREATE TABLE `d_urgenttask` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `cfgid` int unsigned NOT NULL COMMENT '紧急任务id',
  `type` int unsigned NOT NULL COMMENT '状态',
  `progress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '进度',
  `starttime` int NOT NULL COMMENT '开始时间',
  `endtime` int NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='紧急任务';

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
-- Table structure for d_user
-- ----------------------------
DROP TABLE IF EXISTS `d_user`;
CREATE TABLE `d_user` (
  `id` int unsigned NOT NULL COMMENT '玩家ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `level` int unsigned NOT NULL DEFAULT '0' COMMENT '段位',
  `exp` int unsigned NOT NULL DEFAULT '0' COMMENT '经验',
  `imgcfgid` int unsigned NOT NULL DEFAULT '0' COMMENT '头像配置表id',
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '介绍',
  `showid` int unsigned DEFAULT NULL COMMENT '展示机甲id',
  `rtime` int unsigned NOT NULL COMMENT '注册时间',
  `ltime` int unsigned NOT NULL COMMENT '最后一次登陆时间',
  `etime` int unsigned NOT NULL COMMENT '最后一次退出时间',
  `onlinetime` int unsigned NOT NULL COMMENT '游戏时长',
  `daytime` int unsigned NOT NULL COMMENT '一天中游戏时长',
  `addictiontime` int unsigned DEFAULT NULL COMMENT '结束防沉迷时间',
  `age` int unsigned NOT NULL COMMENT '年龄',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家角色表';

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
-- Table structure for d_userset
-- ----------------------------
DROP TABLE IF EXISTS `d_userset`;
CREATE TABLE `d_userset` (
  `id` int unsigned NOT NULL COMMENT '用户id',
  `max_material` int unsigned DEFAULT '200' COMMENT '材料容量',
  `max_weapon` int unsigned DEFAULT '50' COMMENT '武器容量',
  `max_body` int unsigned DEFAULT '50' COMMENT '机体容量',
  `max_chassis` int unsigned DEFAULT '50' COMMENT '底盘容量',
  `max_fire` int unsigned DEFAULT '50' COMMENT '火控容量',
  `max_chip` int unsigned DEFAULT '200' COMMENT '芯片容量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户设置表';

-- ----------------------------
-- Records of d_userset
-- ----------------------------
INSERT INTO `d_userset` VALUES ('2', '200', '50', '50', '50', '50', '200');
INSERT INTO `d_userset` VALUES ('3', '200', '50', '50', '50', '50', '200');
INSERT INTO `d_userset` VALUES ('4', '200', '50', '50', '50', '50', '200');
INSERT INTO `d_userset` VALUES ('5', '200', '50', '50', '50', '50', '200');
INSERT INTO `d_userset` VALUES ('6', '200', '50', '50', '50', '50', '200');
INSERT INTO `d_userset` VALUES ('7', '200', '50', '50', '50', '50', '200');

-- ----------------------------
-- Table structure for d_usertask
-- ----------------------------
DROP TABLE IF EXISTS `d_usertask`;
CREATE TABLE `d_usertask` (
  `id` int unsigned NOT NULL COMMENT '用户id',
  `daytask` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '每日任务',
  `urgenttask` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '紧急任务',
  `plottask` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '剧情任务',
  `tasking` int unsigned DEFAULT NULL COMMENT '激活剧情任务id',
  `needtalk` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '已完成需对话任务',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户任务表';

-- ----------------------------
-- Records of d_usertask
-- ----------------------------
INSERT INTO `d_usertask` VALUES ('2', '1,2', '1,2', '1,2', '1', null);
INSERT INTO `d_usertask` VALUES ('3', '3,4', '3,4', '3,4', '3', null);
INSERT INTO `d_usertask` VALUES ('4', '5,6', '5,6', '5,6', '5', null);
INSERT INTO `d_usertask` VALUES ('5', '7,8', '7,8', '7,8', '7', null);
INSERT INTO `d_usertask` VALUES ('6', '9,10', '9,10', '9,10', '9', null);
INSERT INTO `d_usertask` VALUES ('7', '11,12', '11,12', '11,12', '11', null);

-- ----------------------------
-- Table structure for d_weapons
-- ----------------------------
DROP TABLE IF EXISTS `d_weapons`;
CREATE TABLE `d_weapons` (
  `id` int unsigned NOT NULL COMMENT '武器uniqueID',
  `cfgid` int unsigned NOT NULL COMMENT '配置表中的武器ID',
  `playerid` int unsigned NOT NULL COMMENT '所属玩家ID',
  `lv` int unsigned NOT NULL COMMENT '该武器的等级',
  `exp` int unsigned NOT NULL COMMENT '该武器的经验',
  `slotarray` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '槽位信息',
  `isdouble` tinyint(1) DEFAULT '0' COMMENT '是否使用反应堆',
  `volume` int unsigned DEFAULT '2' COMMENT '容量',
  `currentvolume` int unsigned DEFAULT '0' COMMENT '当前已使用容量',
  `count` int unsigned DEFAULT '0' COMMENT '极化次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='玩家武器';

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
-- Table structure for s_admin
-- ----------------------------
DROP TABLE IF EXISTS `s_admin`;
CREATE TABLE `s_admin` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员';

-- ----------------------------
-- Records of s_admin
-- ----------------------------
INSERT INTO `s_admin` VALUES ('1', 'admin', 'admin');

-- ----------------------------
-- Table structure for s_bag
-- ----------------------------
DROP TABLE IF EXISTS `s_bag`;
CREATE TABLE `s_bag` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `cfgid` int NOT NULL COMMENT '配置id',
  `type` int unsigned NOT NULL COMMENT '类别',
  `price` int unsigned DEFAULT '0' COMMENT '价格',
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `iskh` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否氪金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='礼包';

-- ----------------------------
-- Records of s_bag
-- ----------------------------
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

-- ----------------------------
-- Table structure for s_bags
-- ----------------------------
DROP TABLE IF EXISTS `s_bags`;
CREATE TABLE `s_bags` (
  `id` int NOT NULL COMMENT '配置id',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `price` int unsigned DEFAULT '0' COMMENT '价格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='后台礼包表';

-- ----------------------------
-- Records of s_bags
-- ----------------------------
INSERT INTO `s_bags` VALUES ('10001', '加速器礼包1', '10');
INSERT INTO `s_bags` VALUES ('10002', '加速器礼包2', '10');
INSERT INTO `s_bags` VALUES ('10003', '加速器礼包3', '10');
INSERT INTO `s_bags` VALUES ('10004', '加速器礼包4', '10');
INSERT INTO `s_bags` VALUES ('10005', '加速器礼包5', '10');
INSERT INTO `s_bags` VALUES ('10006', '加速器礼包6', '10');
INSERT INTO `s_bags` VALUES ('10007', '加速器礼包7', '10');
INSERT INTO `s_bags` VALUES ('10008', '加速器礼包8', '10');
INSERT INTO `s_bags` VALUES ('10009', '加速器礼包9', '10');
INSERT INTO `s_bags` VALUES ('10010', '加速器礼包10', '10');
INSERT INTO `s_bags` VALUES ('10011', '加速器礼包11', '10');
INSERT INTO `s_bags` VALUES ('10012', '加速器礼包12', '10');
INSERT INTO `s_bags` VALUES ('10013', '加速器礼包13', '10');
INSERT INTO `s_bags` VALUES ('10014', '加速器礼包14', '10');
INSERT INTO `s_bags` VALUES ('10015', '加速器礼包15', '10');
INSERT INTO `s_bags` VALUES ('10016', '加速器礼包16', '10');
INSERT INTO `s_bags` VALUES ('10017', '加速器礼包17', '10');
INSERT INTO `s_bags` VALUES ('10018', '加速器礼包18', '10');
INSERT INTO `s_bags` VALUES ('10019', '加速器礼包19', '10');
INSERT INTO `s_bags` VALUES ('10020', '加速器礼包20', '10');
INSERT INTO `s_bags` VALUES ('10021', '加速器礼包21', '10');
INSERT INTO `s_bags` VALUES ('10022', '加速器礼包22', '10');
INSERT INTO `s_bags` VALUES ('10023', '加速器礼包23', '10');
INSERT INTO `s_bags` VALUES ('10024', '加速器礼包24', '10');
INSERT INTO `s_bags` VALUES ('10025', '加速器礼包25', '10');
INSERT INTO `s_bags` VALUES ('10026', '加速器礼包26', '10');

-- ----------------------------
-- Table structure for s_blueprints
-- ----------------------------
DROP TABLE IF EXISTS `s_blueprints`;
CREATE TABLE `s_blueprints` (
  `id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '蓝图id',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `arr` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '24小时价格集合',
  `arrday` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '30天价格集合',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='蓝图价格走势表';

-- ----------------------------
-- Records of s_blueprints
-- ----------------------------
INSERT INTO `s_blueprints` VALUES ('110001', '蜂6动力底盘', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('110002', 'T21疾雷传动装置', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('110003', '尘暴-I机动底盘', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('210001', 'VK-4U强相互体', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('210002', 'Mark9复合身甲', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('210003', '圣子7型复合身甲', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('210008', 'K-3复合身甲', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('310001', '猛禽-1约束定标器', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('310002', '迅灵相控阵系统', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('310003', '智天使火控系统', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('310008', 'K1骑士相控阵系统', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('410012', '刚古斯突', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('410013', '陨落', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('410018', '火舌', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('410027', '昆古尼尔', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('410028', '暴乱泰坦', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('410029', '弧光剑', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610001', '数码聚合体', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610002', '金属粘融剂', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610003', '共振涂料', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610004', '核心冷却液', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610005', '机巧核心', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610006', '能量稳定液', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610007', '抗冲击胶质', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610008', '高密保温膜', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610009', '工质稳定剂', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610010', '铜', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610011', '天然碳60', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610012', '钴', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610013', '铁', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610014', '银', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610015', '镍', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610016', '镁', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610017', '锂', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610018', '铬', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610019', '铕', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610020', '钙', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610021', '铝', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610022', '金', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610023', '锰', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610024', '锡', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');
INSERT INTO `s_blueprints` VALUES ('610025', '铅', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":0},{\"M1610323200\":0},{\"M1610352000\":0},{\"M1610208000\":0},{\"M1610236800\":0},{\"M1610265600\":0},{\"M1610121600\":0},{\"M1610150400\":0},{\"M1610179200\":0},{\"M1610035200\":0},{\"M1610064000\":0},{\"M1610092800\":0},{\"M1609948800\":0},{\"M1609977600\":0},{\"M1610006400\":0},{\"M1609862400\":0},{\"M1609891200\":0},{\"M1609920000\":0},{\"M1609776000\":0},{\"M1609804800\":0},{\"M1609833600\":0},{\"M1609689600\":0},{\"M1609718400\":0},{\"M1609747200\":0},{\"M1609603200\":0},{\"M1609632000\":0},{\"M1609660800\":0},{\"M1609516800\":0},{\"M1609545600\":0},{\"M1609574400\":0},{\"M1609430400\":0},{\"M1609459200\":0},{\"M1609488000\":0},{\"M1609344000\":0},{\"M1609372800\":0},{\"M1609401600\":0},{\"M1609257600\":0},{\"M1609286400\":0},{\"M1609315200\":0},{\"M1609171200\":0},{\"M1609200000\":0},{\"M1609228800\":0},{\"M1609084800\":0},{\"M1609113600\":0},{\"M1609142400\":0},{\"M1608998400\":0},{\"M1609027200\":0},{\"M1609056000\":0},{\"M1608912000\":0},{\"M1608940800\":0},{\"M1608969600\":0},{\"M1608825600\":0},{\"M1608854400\":0},{\"M1608883200\":0},{\"M1608739200\":0},{\"M1608768000\":0},{\"M1608796800\":0},{\"M1608652800\":0},{\"M1608681600\":0},{\"M1608710400\":0},{\"M1608566400\":0},{\"M1608595200\":0},{\"M1608624000\":0},{\"M1608480000\":0},{\"M1608508800\":0},{\"M1608537600\":0},{\"M1608393600\":0},{\"M1608422400\":0},{\"M1608451200\":0},{\"M1608307200\":0},{\"M1608336000\":0},{\"M1608364800\":0},{\"M1608220800\":0},{\"M1608249600\":0},{\"M1608278400\":0},{\"M1608134400\":0},{\"M1608163200\":0},{\"M1608192000\":0},{\"M1608048000\":0},{\"M1608076800\":0},{\"M1608105600\":0},{\"M1607961600\":0},{\"M1607990400\":0},{\"M1608019200\":0},{\"M1607875200\":0},{\"M1607904000\":0},{\"M1607932800\":0}]');

-- ----------------------------
-- Table structure for s_chips
-- ----------------------------
DROP TABLE IF EXISTS `s_chips`;
CREATE TABLE `s_chips` (
  `id` int NOT NULL COMMENT '配置id',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='后台芯片表';

-- ----------------------------
-- Records of s_chips
-- ----------------------------
INSERT INTO `s_chips` VALUES ('10001', '结构固化');
INSERT INTO `s_chips` VALUES ('10002', '超阻电场');
INSERT INTO `s_chips` VALUES ('10003', '动力催化');
INSERT INTO `s_chips` VALUES ('10004', '过充能');
INSERT INTO `s_chips` VALUES ('10005', '增积充能');
INSERT INTO `s_chips` VALUES ('10006', '锐化充能');
INSERT INTO `s_chips` VALUES ('10007', '对空增强');
INSERT INTO `s_chips` VALUES ('10008', '对地增强');
INSERT INTO `s_chips` VALUES ('10009', '充分转化');
INSERT INTO `s_chips` VALUES ('10010', '对撞反馈');
INSERT INTO `s_chips` VALUES ('10011', '疾速');
INSERT INTO `s_chips` VALUES ('10012', '全地形适应');
INSERT INTO `s_chips` VALUES ('10013', '威慑力');
INSERT INTO `s_chips` VALUES ('10014', '破坏力');
INSERT INTO `s_chips` VALUES ('10015', '持续激活');
INSERT INTO `s_chips` VALUES ('10016', '兽化');
INSERT INTO `s_chips` VALUES ('10017', '械化');
INSERT INTO `s_chips` VALUES ('10018', '能量化');
INSERT INTO `s_chips` VALUES ('10019', '延时重击');
INSERT INTO `s_chips` VALUES ('10020', '范围打击');
INSERT INTO `s_chips` VALUES ('10021', '轻量化');
INSERT INTO `s_chips` VALUES ('10022', '对空偏移');
INSERT INTO `s_chips` VALUES ('10023', '对地偏移');
INSERT INTO `s_chips` VALUES ('10024', '蛰伏');
INSERT INTO `s_chips` VALUES ('10025', '超限反馈');
INSERT INTO `s_chips` VALUES ('10026', ' 贴地飞行');
INSERT INTO `s_chips` VALUES ('10027', '粘着力');
INSERT INTO `s_chips` VALUES ('10028', '广域镇压');
INSERT INTO `s_chips` VALUES ('10029', '瞬间破坏');
INSERT INTO `s_chips` VALUES ('10030', '定点激活');
INSERT INTO `s_chips` VALUES ('10031', '信标传送');
INSERT INTO `s_chips` VALUES ('10032', '弹跳');
INSERT INTO `s_chips` VALUES ('10033', '连射');
INSERT INTO `s_chips` VALUES ('10034', '散射');

-- ----------------------------
-- Table structure for s_config
-- ----------------------------
DROP TABLE IF EXISTS `s_config`;
CREATE TABLE `s_config` (
  `id` int unsigned NOT NULL,
  `data1` int unsigned NOT NULL DEFAULT '0',
  `data2` int unsigned NOT NULL DEFAULT '0',
  `data3` int unsigned NOT NULL DEFAULT '0',
  `data4` int unsigned NOT NULL DEFAULT '0',
  `data5` int unsigned NOT NULL DEFAULT '0',
  `str1` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `str2` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `str3` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `str4` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `str5` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='配置表';

-- ----------------------------
-- Records of s_config
-- ----------------------------

-- ----------------------------
-- Table structure for s_market
-- ----------------------------
DROP TABLE IF EXISTS `s_market`;
CREATE TABLE `s_market` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `marketinfo` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '加权平均数价格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='材料总的行情';

-- ----------------------------
-- Records of s_market
-- ----------------------------
INSERT INTO `s_market` VALUES ('1', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":332.26},{\"M1610323200\":313.66},{\"M1610352000\":325.1},{\"M1610208000\":331.49},{\"M1610236800\":347.56},{\"M1610265600\":342.95},{\"M1610121600\":333.27},{\"M1610150400\":311.85},{\"M1610179200\":315.6},{\"M1610035200\":315.24},{\"M1610064000\":338.55},{\"M1610092800\":345.2},{\"M1609948800\":329.86},{\"M1609977600\":319.05},{\"M1610006400\":313.83},{\"M1609862400\":318.98},{\"M1609891200\":339.96},{\"M1609920000\":338.54},{\"M1609776000\":346.39},{\"M1609804800\":327.43},{\"M1609833600\":302.94}]');

-- ----------------------------
-- Table structure for s_materials
-- ----------------------------
DROP TABLE IF EXISTS `s_materials`;
CREATE TABLE `s_materials` (
  `id` int unsigned NOT NULL COMMENT '材料id',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `arr` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '24小时价格集合',
  `arrday` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '30天价格集合',
  `isputaway` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否上架',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='材料价格走势表';

-- ----------------------------
-- Records of s_materials
-- ----------------------------
INSERT INTO `s_materials` VALUES ('10001', '数码聚合体', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":41},{\"M1610323200\":37},{\"M1610352000\":38},{\"M1610208000\":42},{\"M1610236800\":42},{\"M1610265600\":43},{\"M1610121600\":41},{\"M1610150400\":39},{\"M1610179200\":38},{\"M1610035200\":40},{\"M1610064000\":43},{\"M1610092800\":44},{\"M1609948800\":42},{\"M1609977600\":39},{\"M1610006400\":40},{\"M1609862400\":38},{\"M1609891200\":41},{\"M1609920000\":40},{\"M1609776000\":45},{\"M1609804800\":38},{\"M1609833600\":38},{\"M1609689600\":40},{\"M1609718400\":37},{\"M1609747200\":42},{\"M1609603200\":43},{\"M1609632000\":39},{\"M1609660800\":39},{\"M1609516800\":37},{\"M1609545600\":39},{\"M1609574400\":42},{\"M1609430400\":43},{\"M1609459200\":44},{\"M1609488000\":41},{\"M1609344000\":40},{\"M1609372800\":42},{\"M1609401600\":40},{\"M1609257600\":46},{\"M1609286400\":42},{\"M1609315200\":42},{\"M1609171200\":41},{\"M1609200000\":40},{\"M1609228800\":43},{\"M1609084800\":43},{\"M1609113600\":44},{\"M1609142400\":47},{\"M1608998400\":41},{\"M1609027200\":45},{\"M1609056000\":42},{\"M1608912000\":44},{\"M1608940800\":49},{\"M1608969600\":42},{\"M1608825600\":47},{\"M1608854400\":39},{\"M1608883200\":41},{\"M1608739200\":43},{\"M1608768000\":41},{\"M1608796800\":46},{\"M1608652800\":43},{\"M1608681600\":41},{\"M1608710400\":45},{\"M1608566400\":42},{\"M1608595200\":50},{\"M1608624000\":46},{\"M1608480000\":46},{\"M1608508800\":47},{\"M1608537600\":39},{\"M1608393600\":44},{\"M1608422400\":43},{\"M1608451200\":44},{\"M1608307200\":46},{\"M1608336000\":40},{\"M1608364800\":41},{\"M1608220800\":38},{\"M1608249600\":42},{\"M1608278400\":47},{\"M1608134400\":43},{\"M1608163200\":47},{\"M1608192000\":44},{\"M1608048000\":41},{\"M1608076800\":46},{\"M1608105600\":42},{\"M1607961600\":48},{\"M1607990400\":45},{\"M1608019200\":39},{\"M1607875200\":42},{\"M1607904000\":36},{\"M1607932800\":42}]', '\0');
INSERT INTO `s_materials` VALUES ('10002', '金属粘融剂', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":1042},{\"M1610323200\":981},{\"M1610352000\":1017},{\"M1610208000\":1048},{\"M1610236800\":1094},{\"M1610265600\":1037},{\"M1610121600\":1033},{\"M1610150400\":1000},{\"M1610179200\":1003},{\"M1610035200\":1013},{\"M1610064000\":1025},{\"M1610092800\":1064},{\"M1609948800\":962},{\"M1609977600\":1005},{\"M1610006400\":981},{\"M1609862400\":997},{\"M1609891200\":1051},{\"M1609920000\":1086},{\"M1609776000\":1047},{\"M1609804800\":1031},{\"M1609833600\":939},{\"M1609689600\":1031},{\"M1609718400\":970},{\"M1609747200\":1012},{\"M1609603200\":1019},{\"M1609632000\":979},{\"M1609660800\":965},{\"M1609516800\":963},{\"M1609545600\":1014},{\"M1609574400\":1098},{\"M1609430400\":1066},{\"M1609459200\":1119},{\"M1609488000\":979},{\"M1609344000\":1048},{\"M1609372800\":987},{\"M1609401600\":1029},{\"M1609257600\":1097},{\"M1609286400\":1014},{\"M1609315200\":1020},{\"M1609171200\":1013},{\"M1609200000\":935},{\"M1609228800\":1063},{\"M1609084800\":1012},{\"M1609113600\":1108},{\"M1609142400\":1132},{\"M1608998400\":1036},{\"M1609027200\":1091},{\"M1609056000\":1082},{\"M1608912000\":1192},{\"M1608940800\":1211},{\"M1608969600\":1099},{\"M1608825600\":1171},{\"M1608854400\":1008},{\"M1608883200\":974},{\"M1608739200\":1111},{\"M1608768000\":1107},{\"M1608796800\":1138},{\"M1608652800\":1070},{\"M1608681600\":1069},{\"M1608710400\":1181},{\"M1608566400\":986},{\"M1608595200\":1235},{\"M1608624000\":1135},{\"M1608480000\":1206},{\"M1608508800\":1118},{\"M1608537600\":944},{\"M1608393600\":1121},{\"M1608422400\":1117},{\"M1608451200\":1033},{\"M1608307200\":1169},{\"M1608336000\":1045},{\"M1608364800\":1046},{\"M1608220800\":990},{\"M1608249600\":992},{\"M1608278400\":1171},{\"M1608134400\":1050},{\"M1608163200\":1124},{\"M1608192000\":1062},{\"M1608048000\":1044},{\"M1608076800\":1125},{\"M1608105600\":1017},{\"M1607961600\":1193},{\"M1607990400\":1128},{\"M1608019200\":937},{\"M1607875200\":1058},{\"M1607904000\":876},{\"M1607932800\":1075}]', '\0');
INSERT INTO `s_materials` VALUES ('10003', '共振涂料', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":1005},{\"M1610323200\":965},{\"M1610352000\":1016},{\"M1610208000\":989},{\"M1610236800\":1099},{\"M1610265600\":1021},{\"M1610121600\":1029},{\"M1610150400\":940},{\"M1610179200\":925},{\"M1610035200\":972},{\"M1610064000\":1050},{\"M1610092800\":1104},{\"M1609948800\":981},{\"M1609977600\":995},{\"M1610006400\":945},{\"M1609862400\":1018},{\"M1609891200\":1006},{\"M1609920000\":1065},{\"M1609776000\":1104},{\"M1609804800\":1019},{\"M1609833600\":906},{\"M1609689600\":967},{\"M1609718400\":995},{\"M1609747200\":1033},{\"M1609603200\":1005},{\"M1609632000\":1020},{\"M1609660800\":996},{\"M1609516800\":912},{\"M1609545600\":967},{\"M1609574400\":1105},{\"M1609430400\":1110},{\"M1609459200\":1132},{\"M1609488000\":1025},{\"M1609344000\":1042},{\"M1609372800\":994},{\"M1609401600\":954},{\"M1609257600\":1148},{\"M1609286400\":1081},{\"M1609315200\":1054},{\"M1609171200\":1006},{\"M1609200000\":977},{\"M1609228800\":1127},{\"M1609084800\":989},{\"M1609113600\":1133},{\"M1609142400\":1137},{\"M1608998400\":1043},{\"M1609027200\":1103},{\"M1609056000\":1076},{\"M1608912000\":1146},{\"M1608940800\":1144},{\"M1608969600\":1098},{\"M1608825600\":1184},{\"M1608854400\":1011},{\"M1608883200\":944},{\"M1608739200\":1132},{\"M1608768000\":1025},{\"M1608796800\":1157},{\"M1608652800\":1064},{\"M1608681600\":1082},{\"M1608710400\":1136},{\"M1608566400\":1004},{\"M1608595200\":1152},{\"M1608624000\":1186},{\"M1608480000\":1174},{\"M1608508800\":1182},{\"M1608537600\":956},{\"M1608393600\":1125},{\"M1608422400\":1036},{\"M1608451200\":1109},{\"M1608307200\":1129},{\"M1608336000\":979},{\"M1608364800\":1024},{\"M1608220800\":937},{\"M1608249600\":1012},{\"M1608278400\":1181},{\"M1608134400\":1034},{\"M1608163200\":1147},{\"M1608192000\":1134},{\"M1608048000\":1020},{\"M1608076800\":1164},{\"M1608105600\":1020},{\"M1607961600\":1165},{\"M1607990400\":1064},{\"M1608019200\":968},{\"M1607875200\":1046},{\"M1607904000\":919},{\"M1607932800\":1030}]', '\0');
INSERT INTO `s_materials` VALUES ('10004', '核心冷却液', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":963},{\"M1610323200\":951},{\"M1610352000\":1041},{\"M1610208000\":969},{\"M1610236800\":1024},{\"M1610265600\":1064},{\"M1610121600\":1027},{\"M1610150400\":924},{\"M1610179200\":1009},{\"M1610035200\":944},{\"M1610064000\":1066},{\"M1610092800\":1019},{\"M1609948800\":1038},{\"M1609977600\":1007},{\"M1610006400\":959},{\"M1609862400\":951},{\"M1609891200\":1017},{\"M1609920000\":1064},{\"M1609776000\":1044},{\"M1609804800\":969},{\"M1609833600\":920},{\"M1609689600\":985},{\"M1609718400\":1025},{\"M1609747200\":1034},{\"M1609603200\":1016},{\"M1609632000\":950},{\"M1609660800\":960},{\"M1609516800\":906},{\"M1609545600\":991},{\"M1609574400\":1086},{\"M1609430400\":1081},{\"M1609459200\":1076},{\"M1609488000\":995},{\"M1609344000\":1019},{\"M1609372800\":1027},{\"M1609401600\":1000},{\"M1609257600\":1112},{\"M1609286400\":1080},{\"M1609315200\":1009},{\"M1609171200\":1031},{\"M1609200000\":987},{\"M1609228800\":1123},{\"M1609084800\":1027},{\"M1609113600\":1101},{\"M1609142400\":1157},{\"M1608998400\":1018},{\"M1609027200\":1114},{\"M1609056000\":1111},{\"M1608912000\":1203},{\"M1608940800\":1190},{\"M1608969600\":1084},{\"M1608825600\":1196},{\"M1608854400\":1012},{\"M1608883200\":1018},{\"M1608739200\":1073},{\"M1608768000\":1030},{\"M1608796800\":1123},{\"M1608652800\":1069},{\"M1608681600\":1101},{\"M1608710400\":1181},{\"M1608566400\":1067},{\"M1608595200\":1249},{\"M1608624000\":1172},{\"M1608480000\":1162},{\"M1608508800\":1115},{\"M1608537600\":974},{\"M1608393600\":1158},{\"M1608422400\":1033},{\"M1608451200\":1085},{\"M1608307200\":1186},{\"M1608336000\":1020},{\"M1608364800\":1057},{\"M1608220800\":900},{\"M1608249600\":1074},{\"M1608278400\":1181},{\"M1608134400\":994},{\"M1608163200\":1157},{\"M1608192000\":1144},{\"M1608048000\":1036},{\"M1608076800\":1116},{\"M1608105600\":1070},{\"M1607961600\":1214},{\"M1607990400\":1038},{\"M1608019200\":930},{\"M1607875200\":1021},{\"M1607904000\":863},{\"M1607932800\":1043}]', '\0');
INSERT INTO `s_materials` VALUES ('10005', '机巧核心', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":1023},{\"M1610323200\":1000},{\"M1610352000\":954},{\"M1610208000\":1027},{\"M1610236800\":1023},{\"M1610265600\":1003},{\"M1610121600\":1007},{\"M1610150400\":953},{\"M1610179200\":924},{\"M1610035200\":932},{\"M1610064000\":1030},{\"M1610092800\":1090},{\"M1609948800\":1046},{\"M1609977600\":945},{\"M1610006400\":921},{\"M1609862400\":920},{\"M1609891200\":1086},{\"M1609920000\":998},{\"M1609776000\":1025},{\"M1609804800\":989},{\"M1609833600\":898},{\"M1609689600\":991},{\"M1609718400\":979},{\"M1609747200\":1066},{\"M1609603200\":1022},{\"M1609632000\":996},{\"M1609660800\":1030},{\"M1609516800\":907},{\"M1609545600\":1014},{\"M1609574400\":1138},{\"M1609430400\":1072},{\"M1609459200\":1101},{\"M1609488000\":1023},{\"M1609344000\":1038},{\"M1609372800\":1000},{\"M1609401600\":990},{\"M1609257600\":1100},{\"M1609286400\":1063},{\"M1609315200\":1060},{\"M1609171200\":1033},{\"M1609200000\":960},{\"M1609228800\":1072},{\"M1609084800\":1030},{\"M1609113600\":1168},{\"M1609142400\":1165},{\"M1608998400\":1022},{\"M1609027200\":1079},{\"M1609056000\":1027},{\"M1608912000\":1118},{\"M1608940800\":1213},{\"M1608969600\":1050},{\"M1608825600\":1210},{\"M1608854400\":996},{\"M1608883200\":1027},{\"M1608739200\":1049},{\"M1608768000\":1101},{\"M1608796800\":1189},{\"M1608652800\":1021},{\"M1608681600\":1058},{\"M1608710400\":1129},{\"M1608566400\":972},{\"M1608595200\":1153},{\"M1608624000\":1160},{\"M1608480000\":1151},{\"M1608508800\":1188},{\"M1608537600\":1032},{\"M1608393600\":1158},{\"M1608422400\":1100},{\"M1608451200\":1043},{\"M1608307200\":1132},{\"M1608336000\":1022},{\"M1608364800\":1072},{\"M1608220800\":896},{\"M1608249600\":1019},{\"M1608278400\":1254},{\"M1608134400\":1068},{\"M1608163200\":1202},{\"M1608192000\":1124},{\"M1608048000\":1036},{\"M1608076800\":1133},{\"M1608105600\":991},{\"M1607961600\":1204},{\"M1607990400\":1082},{\"M1608019200\":953},{\"M1607875200\":1084},{\"M1607904000\":944},{\"M1607932800\":1012}]', '\0');
INSERT INTO `s_materials` VALUES ('10006', '能量稳定液', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":1034},{\"M1610323200\":971},{\"M1610352000\":964},{\"M1610208000\":1016},{\"M1610236800\":1099},{\"M1610265600\":1101},{\"M1610121600\":1043},{\"M1610150400\":986},{\"M1610179200\":997},{\"M1610035200\":958},{\"M1610064000\":989},{\"M1610092800\":1021},{\"M1609948800\":1029},{\"M1609977600\":950},{\"M1610006400\":987},{\"M1609862400\":998},{\"M1609891200\":1026},{\"M1609920000\":1016},{\"M1609776000\":1032},{\"M1609804800\":1014},{\"M1609833600\":930},{\"M1609689600\":948},{\"M1609718400\":970},{\"M1609747200\":998},{\"M1609603200\":1027},{\"M1609632000\":955},{\"M1609660800\":996},{\"M1609516800\":938},{\"M1609545600\":1050},{\"M1609574400\":1065},{\"M1609430400\":1095},{\"M1609459200\":1102},{\"M1609488000\":968},{\"M1609344000\":1024},{\"M1609372800\":1029},{\"M1609401600\":1032},{\"M1609257600\":1138},{\"M1609286400\":1021},{\"M1609315200\":1057},{\"M1609171200\":1022},{\"M1609200000\":962},{\"M1609228800\":1062},{\"M1609084800\":1041},{\"M1609113600\":1099},{\"M1609142400\":1182},{\"M1608998400\":1040},{\"M1609027200\":1075},{\"M1609056000\":1094},{\"M1608912000\":1195},{\"M1608940800\":1163},{\"M1608969600\":1086},{\"M1608825600\":1187},{\"M1608854400\":1032},{\"M1608883200\":1040},{\"M1608739200\":1096},{\"M1608768000\":1008},{\"M1608796800\":1174},{\"M1608652800\":1002},{\"M1608681600\":1075},{\"M1608710400\":1168},{\"M1608566400\":1043},{\"M1608595200\":1166},{\"M1608624000\":1189},{\"M1608480000\":1203},{\"M1608508800\":1126},{\"M1608537600\":1008},{\"M1608393600\":1191},{\"M1608422400\":1052},{\"M1608451200\":1054},{\"M1608307200\":1139},{\"M1608336000\":1019},{\"M1608364800\":1078},{\"M1608220800\":988},{\"M1608249600\":1026},{\"M1608278400\":1190},{\"M1608134400\":997},{\"M1608163200\":1125},{\"M1608192000\":1145},{\"M1608048000\":1041},{\"M1608076800\":1138},{\"M1608105600\":1026},{\"M1607961600\":1198},{\"M1607990400\":1112},{\"M1608019200\":898},{\"M1607875200\":1044},{\"M1607904000\":944},{\"M1607932800\":1039}]', '\0');
INSERT INTO `s_materials` VALUES ('10007', '抗冲击胶质', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":1016},{\"M1610323200\":920},{\"M1610352000\":996},{\"M1610208000\":1044},{\"M1610236800\":1058},{\"M1610265600\":1036},{\"M1610121600\":997},{\"M1610150400\":928},{\"M1610179200\":990},{\"M1610035200\":925},{\"M1610064000\":1069},{\"M1610092800\":1025},{\"M1609948800\":999},{\"M1609977600\":934},{\"M1610006400\":938},{\"M1609862400\":951},{\"M1609891200\":1026},{\"M1609920000\":1018},{\"M1609776000\":1048},{\"M1609804800\":1002},{\"M1609833600\":945},{\"M1609689600\":963},{\"M1609718400\":1016},{\"M1609747200\":1026},{\"M1609603200\":1017},{\"M1609632000\":1018},{\"M1609660800\":1026},{\"M1609516800\":957},{\"M1609545600\":1021},{\"M1609574400\":1091},{\"M1609430400\":1050},{\"M1609459200\":1067},{\"M1609488000\":1029},{\"M1609344000\":1046},{\"M1609372800\":1052},{\"M1609401600\":1023},{\"M1609257600\":1129},{\"M1609286400\":1038},{\"M1609315200\":1037},{\"M1609171200\":1007},{\"M1609200000\":918},{\"M1609228800\":1057},{\"M1609084800\":1009},{\"M1609113600\":1108},{\"M1609142400\":1179},{\"M1608998400\":997},{\"M1609027200\":1092},{\"M1609056000\":1106},{\"M1608912000\":1125},{\"M1608940800\":1205},{\"M1608969600\":1070},{\"M1608825600\":1121},{\"M1608854400\":1042},{\"M1608883200\":979},{\"M1608739200\":1102},{\"M1608768000\":1023},{\"M1608796800\":1152},{\"M1608652800\":991},{\"M1608681600\":1016},{\"M1608710400\":1102},{\"M1608566400\":1034},{\"M1608595200\":1214},{\"M1608624000\":1182},{\"M1608480000\":1165},{\"M1608508800\":1171},{\"M1608537600\":985},{\"M1608393600\":1108},{\"M1608422400\":1048},{\"M1608451200\":1031},{\"M1608307200\":1146},{\"M1608336000\":982},{\"M1608364800\":1027},{\"M1608220800\":906},{\"M1608249600\":1070},{\"M1608278400\":1173},{\"M1608134400\":1064},{\"M1608163200\":1156},{\"M1608192000\":1118},{\"M1608048000\":1019},{\"M1608076800\":1111},{\"M1608105600\":1045},{\"M1607961600\":1212},{\"M1607990400\":1101},{\"M1608019200\":943},{\"M1607875200\":1069},{\"M1607904000\":861},{\"M1607932800\":1004}]', '\0');
INSERT INTO `s_materials` VALUES ('10008', '高密保温膜', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":1035},{\"M1610323200\":958},{\"M1610352000\":993},{\"M1610208000\":987},{\"M1610236800\":1023},{\"M1610265600\":1070},{\"M1610121600\":1055},{\"M1610150400\":942},{\"M1610179200\":939},{\"M1610035200\":967},{\"M1610064000\":1051},{\"M1610092800\":1014},{\"M1609948800\":971},{\"M1609977600\":989},{\"M1610006400\":967},{\"M1609862400\":1016},{\"M1609891200\":1035},{\"M1609920000\":1044},{\"M1609776000\":1122},{\"M1609804800\":984},{\"M1609833600\":894},{\"M1609689600\":1033},{\"M1609718400\":978},{\"M1609747200\":1082},{\"M1609603200\":999},{\"M1609632000\":955},{\"M1609660800\":1037},{\"M1609516800\":884},{\"M1609545600\":1024},{\"M1609574400\":1098},{\"M1609430400\":1075},{\"M1609459200\":1073},{\"M1609488000\":1021},{\"M1609344000\":1008},{\"M1609372800\":1031},{\"M1609401600\":953},{\"M1609257600\":1161},{\"M1609286400\":1099},{\"M1609315200\":963},{\"M1609171200\":1035},{\"M1609200000\":917},{\"M1609228800\":1097},{\"M1609084800\":1040},{\"M1609113600\":1106},{\"M1609142400\":1161},{\"M1608998400\":1033},{\"M1609027200\":1120},{\"M1609056000\":1048},{\"M1608912000\":1121},{\"M1608940800\":1164},{\"M1608969600\":1051},{\"M1608825600\":1149},{\"M1608854400\":1010},{\"M1608883200\":998},{\"M1608739200\":1065},{\"M1608768000\":1019},{\"M1608796800\":1193},{\"M1608652800\":1006},{\"M1608681600\":1014},{\"M1608710400\":1156},{\"M1608566400\":989},{\"M1608595200\":1204},{\"M1608624000\":1140},{\"M1608480000\":1167},{\"M1608508800\":1128},{\"M1608537600\":992},{\"M1608393600\":1124},{\"M1608422400\":1054},{\"M1608451200\":1080},{\"M1608307200\":1193},{\"M1608336000\":1024},{\"M1608364800\":1032},{\"M1608220800\":995},{\"M1608249600\":1046},{\"M1608278400\":1233},{\"M1608134400\":1088},{\"M1608163200\":1210},{\"M1608192000\":1100},{\"M1608048000\":1092},{\"M1608076800\":1073},{\"M1608105600\":1061},{\"M1607961600\":1210},{\"M1607990400\":1105},{\"M1608019200\":906},{\"M1607875200\":1086},{\"M1607904000\":940},{\"M1607932800\":1010}]', '\0');
INSERT INTO `s_materials` VALUES ('10009', '工质稳定剂', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":1043},{\"M1610323200\":935},{\"M1610352000\":999},{\"M1610208000\":1007},{\"M1610236800\":1079},{\"M1610265600\":1045},{\"M1610121600\":969},{\"M1610150400\":958},{\"M1610179200\":951},{\"M1610035200\":989},{\"M1610064000\":1004},{\"M1610092800\":1102},{\"M1609948800\":1034},{\"M1609977600\":979},{\"M1610006400\":984},{\"M1609862400\":972},{\"M1609891200\":1063},{\"M1609920000\":1002},{\"M1609776000\":1039},{\"M1609804800\":1014},{\"M1609833600\":976},{\"M1609689600\":1023},{\"M1609718400\":992},{\"M1609747200\":1026},{\"M1609603200\":1065},{\"M1609632000\":1045},{\"M1609660800\":1023},{\"M1609516800\":886},{\"M1609545600\":1063},{\"M1609574400\":1102},{\"M1609430400\":1123},{\"M1609459200\":1141},{\"M1609488000\":1004},{\"M1609344000\":1052},{\"M1609372800\":991},{\"M1609401600\":1013},{\"M1609257600\":1172},{\"M1609286400\":1090},{\"M1609315200\":988},{\"M1609171200\":1014},{\"M1609200000\":989},{\"M1609228800\":1122},{\"M1609084800\":1017},{\"M1609113600\":1107},{\"M1609142400\":1155},{\"M1608998400\":1058},{\"M1609027200\":1070},{\"M1609056000\":1072},{\"M1608912000\":1184},{\"M1608940800\":1147},{\"M1608969600\":1064},{\"M1608825600\":1121},{\"M1608854400\":981},{\"M1608883200\":1042},{\"M1608739200\":1075},{\"M1608768000\":1067},{\"M1608796800\":1210},{\"M1608652800\":1005},{\"M1608681600\":1094},{\"M1608710400\":1142},{\"M1608566400\":1012},{\"M1608595200\":1237},{\"M1608624000\":1203},{\"M1608480000\":1218},{\"M1608508800\":1116},{\"M1608537600\":941},{\"M1608393600\":1095},{\"M1608422400\":1120},{\"M1608451200\":1022},{\"M1608307200\":1182},{\"M1608336000\":995},{\"M1608364800\":1094},{\"M1608220800\":896},{\"M1608249600\":1016},{\"M1608278400\":1229},{\"M1608134400\":1020},{\"M1608163200\":1209},{\"M1608192000\":1129},{\"M1608048000\":1057},{\"M1608076800\":1108},{\"M1608105600\":1070},{\"M1607961600\":1216},{\"M1607990400\":1076},{\"M1608019200\":954},{\"M1607875200\":1021},{\"M1607904000\":861},{\"M1607932800\":1063}]', '\0');
INSERT INTO `s_materials` VALUES ('10010', '铜', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":102},{\"M1610323200\":95},{\"M1610352000\":104},{\"M1610208000\":99},{\"M1610236800\":106},{\"M1610265600\":109},{\"M1610121600\":104},{\"M1610150400\":93},{\"M1610179200\":95},{\"M1610035200\":92},{\"M1610064000\":101},{\"M1610092800\":109},{\"M1609948800\":99},{\"M1609977600\":96},{\"M1610006400\":97},{\"M1609862400\":95},{\"M1609891200\":104},{\"M1609920000\":101},{\"M1609776000\":105},{\"M1609804800\":100},{\"M1609833600\":88},{\"M1609689600\":99},{\"M1609718400\":98},{\"M1609747200\":104},{\"M1609603200\":100},{\"M1609632000\":103},{\"M1609660800\":100},{\"M1609516800\":95},{\"M1609545600\":106},{\"M1609574400\":113},{\"M1609430400\":111},{\"M1609459200\":109},{\"M1609488000\":103},{\"M1609344000\":108},{\"M1609372800\":101},{\"M1609401600\":96},{\"M1609257600\":117},{\"M1609286400\":106},{\"M1609315200\":106},{\"M1609171200\":104},{\"M1609200000\":92},{\"M1609228800\":105},{\"M1609084800\":103},{\"M1609113600\":114},{\"M1609142400\":114},{\"M1608998400\":104},{\"M1609027200\":108},{\"M1609056000\":106},{\"M1608912000\":118},{\"M1608940800\":118},{\"M1608969600\":107},{\"M1608825600\":119},{\"M1608854400\":97},{\"M1608883200\":95},{\"M1608739200\":112},{\"M1608768000\":104},{\"M1608796800\":116},{\"M1608652800\":108},{\"M1608681600\":101},{\"M1608710400\":116},{\"M1608566400\":101},{\"M1608595200\":122},{\"M1608624000\":114},{\"M1608480000\":120},{\"M1608508800\":114},{\"M1608537600\":96},{\"M1608393600\":112},{\"M1608422400\":104},{\"M1608451200\":106},{\"M1608307200\":111},{\"M1608336000\":98},{\"M1608364800\":110},{\"M1608220800\":93},{\"M1608249600\":100},{\"M1608278400\":120},{\"M1608134400\":109},{\"M1608163200\":119},{\"M1608192000\":114},{\"M1608048000\":107},{\"M1608076800\":110},{\"M1608105600\":107},{\"M1607961600\":116},{\"M1607990400\":106},{\"M1608019200\":92},{\"M1607875200\":105},{\"M1607904000\":92},{\"M1607932800\":106}]', '\0');
INSERT INTO `s_materials` VALUES ('10011', '天然碳60', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":198},{\"M1610323200\":186},{\"M1610352000\":191},{\"M1610208000\":199},{\"M1610236800\":220},{\"M1610265600\":209},{\"M1610121600\":197},{\"M1610150400\":194},{\"M1610179200\":191},{\"M1610035200\":199},{\"M1610064000\":214},{\"M1610092800\":202},{\"M1609948800\":212},{\"M1609977600\":188},{\"M1610006400\":189},{\"M1609862400\":192},{\"M1609891200\":213},{\"M1609920000\":207},{\"M1609776000\":213},{\"M1609804800\":204},{\"M1609833600\":178},{\"M1609689600\":198},{\"M1609718400\":196},{\"M1609747200\":202},{\"M1609603200\":209},{\"M1609632000\":194},{\"M1609660800\":201},{\"M1609516800\":192},{\"M1609545600\":205},{\"M1609574400\":209},{\"M1609430400\":221},{\"M1609459200\":223},{\"M1609488000\":192},{\"M1609344000\":203},{\"M1609372800\":196},{\"M1609401600\":207},{\"M1609257600\":231},{\"M1609286400\":204},{\"M1609315200\":193},{\"M1609171200\":204},{\"M1609200000\":182},{\"M1609228800\":210},{\"M1609084800\":197},{\"M1609113600\":224},{\"M1609142400\":224},{\"M1608998400\":208},{\"M1609027200\":210},{\"M1609056000\":211},{\"M1608912000\":232},{\"M1608940800\":243},{\"M1608969600\":214},{\"M1608825600\":228},{\"M1608854400\":198},{\"M1608883200\":205},{\"M1608739200\":211},{\"M1608768000\":214},{\"M1608796800\":235},{\"M1608652800\":217},{\"M1608681600\":204},{\"M1608710400\":225},{\"M1608566400\":198},{\"M1608595200\":246},{\"M1608624000\":232},{\"M1608480000\":244},{\"M1608508800\":240},{\"M1608537600\":188},{\"M1608393600\":226},{\"M1608422400\":208},{\"M1608451200\":211},{\"M1608307200\":236},{\"M1608336000\":204},{\"M1608364800\":210},{\"M1608220800\":189},{\"M1608249600\":215},{\"M1608278400\":251},{\"M1608134400\":203},{\"M1608163200\":237},{\"M1608192000\":228},{\"M1608048000\":211},{\"M1608076800\":230},{\"M1608105600\":213},{\"M1607961600\":240},{\"M1607990400\":222},{\"M1608019200\":190},{\"M1607875200\":216},{\"M1607904000\":171},{\"M1607932800\":210}]', '\0');
INSERT INTO `s_materials` VALUES ('10012', '钴', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":161},{\"M1610323200\":149},{\"M1610352000\":159},{\"M1610208000\":167},{\"M1610236800\":165},{\"M1610265600\":172},{\"M1610121600\":163},{\"M1610150400\":156},{\"M1610179200\":150},{\"M1610035200\":153},{\"M1610064000\":169},{\"M1610092800\":165},{\"M1609948800\":165},{\"M1609977600\":162},{\"M1610006400\":150},{\"M1609862400\":158},{\"M1609891200\":168},{\"M1609920000\":166},{\"M1609776000\":167},{\"M1609804800\":154},{\"M1609833600\":142},{\"M1609689600\":152},{\"M1609718400\":152},{\"M1609747200\":172},{\"M1609603200\":161},{\"M1609632000\":167},{\"M1609660800\":154},{\"M1609516800\":147},{\"M1609545600\":156},{\"M1609574400\":174},{\"M1609430400\":170},{\"M1609459200\":181},{\"M1609488000\":156},{\"M1609344000\":162},{\"M1609372800\":169},{\"M1609401600\":164},{\"M1609257600\":180},{\"M1609286400\":167},{\"M1609315200\":154},{\"M1609171200\":160},{\"M1609200000\":157},{\"M1609228800\":181},{\"M1609084800\":172},{\"M1609113600\":188},{\"M1609142400\":180},{\"M1608998400\":163},{\"M1609027200\":182},{\"M1609056000\":169},{\"M1608912000\":190},{\"M1608940800\":186},{\"M1608969600\":161},{\"M1608825600\":192},{\"M1608854400\":163},{\"M1608883200\":157},{\"M1608739200\":177},{\"M1608768000\":170},{\"M1608796800\":189},{\"M1608652800\":167},{\"M1608681600\":165},{\"M1608710400\":187},{\"M1608566400\":166},{\"M1608595200\":198},{\"M1608624000\":196},{\"M1608480000\":192},{\"M1608508800\":186},{\"M1608537600\":160},{\"M1608393600\":183},{\"M1608422400\":179},{\"M1608451200\":171},{\"M1608307200\":184},{\"M1608336000\":158},{\"M1608364800\":177},{\"M1608220800\":152},{\"M1608249600\":171},{\"M1608278400\":190},{\"M1608134400\":168},{\"M1608163200\":185},{\"M1608192000\":181},{\"M1608048000\":163},{\"M1608076800\":175},{\"M1608105600\":165},{\"M1607961600\":191},{\"M1607990400\":166},{\"M1608019200\":151},{\"M1607875200\":173},{\"M1607904000\":149},{\"M1607932800\":168}]', '\0');
INSERT INTO `s_materials` VALUES ('10013', '铁', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":98},{\"M1610323200\":97},{\"M1610352000\":96},{\"M1610208000\":99},{\"M1610236800\":104},{\"M1610265600\":107},{\"M1610121600\":100},{\"M1610150400\":92},{\"M1610179200\":95},{\"M1610035200\":95},{\"M1610064000\":105},{\"M1610092800\":107},{\"M1609948800\":106},{\"M1609977600\":99},{\"M1610006400\":91},{\"M1609862400\":93},{\"M1609891200\":105},{\"M1609920000\":106},{\"M1609776000\":108},{\"M1609804800\":100},{\"M1609833600\":90},{\"M1609689600\":99},{\"M1609718400\":96},{\"M1609747200\":107},{\"M1609603200\":107},{\"M1609632000\":103},{\"M1609660800\":99},{\"M1609516800\":97},{\"M1609545600\":104},{\"M1609574400\":112},{\"M1609430400\":108},{\"M1609459200\":115},{\"M1609488000\":101},{\"M1609344000\":108},{\"M1609372800\":105},{\"M1609401600\":98},{\"M1609257600\":117},{\"M1609286400\":105},{\"M1609315200\":100},{\"M1609171200\":99},{\"M1609200000\":95},{\"M1609228800\":107},{\"M1609084800\":104},{\"M1609113600\":112},{\"M1609142400\":118},{\"M1608998400\":108},{\"M1609027200\":105},{\"M1609056000\":105},{\"M1608912000\":111},{\"M1608940800\":119},{\"M1608969600\":110},{\"M1608825600\":118},{\"M1608854400\":96},{\"M1608883200\":95},{\"M1608739200\":104},{\"M1608768000\":103},{\"M1608796800\":116},{\"M1608652800\":107},{\"M1608681600\":103},{\"M1608710400\":118},{\"M1608566400\":98},{\"M1608595200\":122},{\"M1608624000\":115},{\"M1608480000\":115},{\"M1608508800\":112},{\"M1608537600\":94},{\"M1608393600\":115},{\"M1608422400\":111},{\"M1608451200\":109},{\"M1608307200\":114},{\"M1608336000\":96},{\"M1608364800\":101},{\"M1608220800\":96},{\"M1608249600\":106},{\"M1608278400\":121},{\"M1608134400\":108},{\"M1608163200\":115},{\"M1608192000\":114},{\"M1608048000\":106},{\"M1608076800\":112},{\"M1608105600\":105},{\"M1607961600\":119},{\"M1607990400\":107},{\"M1608019200\":91},{\"M1607875200\":108},{\"M1607904000\":92},{\"M1607932800\":101}]', '\0');
INSERT INTO `s_materials` VALUES ('10014', '银', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":208},{\"M1610323200\":190},{\"M1610352000\":190},{\"M1610208000\":208},{\"M1610236800\":212},{\"M1610265600\":214},{\"M1610121600\":199},{\"M1610150400\":197},{\"M1610179200\":198},{\"M1610035200\":186},{\"M1610064000\":207},{\"M1610092800\":210},{\"M1609948800\":195},{\"M1609977600\":191},{\"M1610006400\":188},{\"M1609862400\":187},{\"M1609891200\":205},{\"M1609920000\":199},{\"M1609776000\":212},{\"M1609804800\":191},{\"M1609833600\":192},{\"M1609689600\":202},{\"M1609718400\":205},{\"M1609747200\":199},{\"M1609603200\":200},{\"M1609632000\":203},{\"M1609660800\":203},{\"M1609516800\":190},{\"M1609545600\":205},{\"M1609574400\":223},{\"M1609430400\":222},{\"M1609459200\":229},{\"M1609488000\":203},{\"M1609344000\":211},{\"M1609372800\":207},{\"M1609401600\":194},{\"M1609257600\":235},{\"M1609286400\":206},{\"M1609315200\":209},{\"M1609171200\":202},{\"M1609200000\":201},{\"M1609228800\":218},{\"M1609084800\":214},{\"M1609113600\":234},{\"M1609142400\":237},{\"M1608998400\":199},{\"M1609027200\":217},{\"M1609056000\":217},{\"M1608912000\":235},{\"M1608940800\":235},{\"M1608969600\":201},{\"M1608825600\":237},{\"M1608854400\":203},{\"M1608883200\":198},{\"M1608739200\":218},{\"M1608768000\":212},{\"M1608796800\":229},{\"M1608652800\":214},{\"M1608681600\":219},{\"M1608710400\":235},{\"M1608566400\":204},{\"M1608595200\":249},{\"M1608624000\":241},{\"M1608480000\":245},{\"M1608508800\":238},{\"M1608537600\":188},{\"M1608393600\":220},{\"M1608422400\":207},{\"M1608451200\":222},{\"M1608307200\":225},{\"M1608336000\":204},{\"M1608364800\":219},{\"M1608220800\":180},{\"M1608249600\":213},{\"M1608278400\":249},{\"M1608134400\":206},{\"M1608163200\":231},{\"M1608192000\":230},{\"M1608048000\":213},{\"M1608076800\":223},{\"M1608105600\":202},{\"M1607961600\":247},{\"M1607990400\":217},{\"M1608019200\":183},{\"M1607875200\":209},{\"M1607904000\":182},{\"M1607932800\":215}]', '\0');
INSERT INTO `s_materials` VALUES ('10015', '镍', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":153},{\"M1610323200\":153},{\"M1610352000\":159},{\"M1610208000\":169},{\"M1610236800\":164},{\"M1610265600\":173},{\"M1610121600\":165},{\"M1610150400\":148},{\"M1610179200\":156},{\"M1610035200\":154},{\"M1610064000\":170},{\"M1610092800\":172},{\"M1609948800\":160},{\"M1609977600\":151},{\"M1610006400\":153},{\"M1609862400\":157},{\"M1609891200\":171},{\"M1609920000\":159},{\"M1609776000\":173},{\"M1609804800\":168},{\"M1609833600\":148},{\"M1609689600\":158},{\"M1609718400\":155},{\"M1609747200\":160},{\"M1609603200\":162},{\"M1609632000\":157},{\"M1609660800\":161},{\"M1609516800\":143},{\"M1609545600\":166},{\"M1609574400\":179},{\"M1609430400\":165},{\"M1609459200\":171},{\"M1609488000\":158},{\"M1609344000\":161},{\"M1609372800\":163},{\"M1609401600\":156},{\"M1609257600\":185},{\"M1609286400\":165},{\"M1609315200\":156},{\"M1609171200\":163},{\"M1609200000\":161},{\"M1609228800\":175},{\"M1609084800\":158},{\"M1609113600\":181},{\"M1609142400\":184},{\"M1608998400\":161},{\"M1609027200\":175},{\"M1609056000\":173},{\"M1608912000\":186},{\"M1608940800\":185},{\"M1608969600\":168},{\"M1608825600\":188},{\"M1608854400\":156},{\"M1608883200\":163},{\"M1608739200\":176},{\"M1608768000\":172},{\"M1608796800\":183},{\"M1608652800\":172},{\"M1608681600\":162},{\"M1608710400\":187},{\"M1608566400\":171},{\"M1608595200\":189},{\"M1608624000\":189},{\"M1608480000\":191},{\"M1608508800\":190},{\"M1608537600\":163},{\"M1608393600\":176},{\"M1608422400\":171},{\"M1608451200\":168},{\"M1608307200\":179},{\"M1608336000\":164},{\"M1608364800\":174},{\"M1608220800\":145},{\"M1608249600\":157},{\"M1608278400\":190},{\"M1608134400\":166},{\"M1608163200\":186},{\"M1608192000\":180},{\"M1608048000\":162},{\"M1608076800\":182},{\"M1608105600\":173},{\"M1607961600\":198},{\"M1607990400\":177},{\"M1608019200\":159},{\"M1607875200\":161},{\"M1607904000\":140},{\"M1607932800\":168}]', '\0');
INSERT INTO `s_materials` VALUES ('10016', '镁', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":83},{\"M1610323200\":77},{\"M1610352000\":79},{\"M1610208000\":81},{\"M1610236800\":84},{\"M1610265600\":80},{\"M1610121600\":82},{\"M1610150400\":73},{\"M1610179200\":79},{\"M1610035200\":77},{\"M1610064000\":79},{\"M1610092800\":86},{\"M1609948800\":78},{\"M1609977600\":80},{\"M1610006400\":74},{\"M1609862400\":81},{\"M1609891200\":82},{\"M1609920000\":87},{\"M1609776000\":87},{\"M1609804800\":81},{\"M1609833600\":78},{\"M1609689600\":81},{\"M1609718400\":81},{\"M1609747200\":83},{\"M1609603200\":84},{\"M1609632000\":82},{\"M1609660800\":80},{\"M1609516800\":75},{\"M1609545600\":82},{\"M1609574400\":85},{\"M1609430400\":90},{\"M1609459200\":90},{\"M1609488000\":79},{\"M1609344000\":86},{\"M1609372800\":78},{\"M1609401600\":83},{\"M1609257600\":92},{\"M1609286400\":80},{\"M1609315200\":78},{\"M1609171200\":82},{\"M1609200000\":73},{\"M1609228800\":83},{\"M1609084800\":79},{\"M1609113600\":90},{\"M1609142400\":95},{\"M1608998400\":86},{\"M1609027200\":88},{\"M1609056000\":84},{\"M1608912000\":93},{\"M1608940800\":92},{\"M1608969600\":87},{\"M1608825600\":91},{\"M1608854400\":84},{\"M1608883200\":76},{\"M1608739200\":86},{\"M1608768000\":88},{\"M1608796800\":95},{\"M1608652800\":81},{\"M1608681600\":81},{\"M1608710400\":93},{\"M1608566400\":81},{\"M1608595200\":100},{\"M1608624000\":95},{\"M1608480000\":94},{\"M1608508800\":91},{\"M1608537600\":82},{\"M1608393600\":89},{\"M1608422400\":85},{\"M1608451200\":85},{\"M1608307200\":88},{\"M1608336000\":80},{\"M1608364800\":88},{\"M1608220800\":75},{\"M1608249600\":85},{\"M1608278400\":93},{\"M1608134400\":81},{\"M1608163200\":95},{\"M1608192000\":92},{\"M1608048000\":85},{\"M1608076800\":90},{\"M1608105600\":80},{\"M1607961600\":93},{\"M1607990400\":85},{\"M1608019200\":78},{\"M1607875200\":81},{\"M1607904000\":74},{\"M1607932800\":80}]', '\0');
INSERT INTO `s_materials` VALUES ('10017', '锂', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":101},{\"M1610323200\":100},{\"M1610352000\":94},{\"M1610208000\":105},{\"M1610236800\":101},{\"M1610265600\":105},{\"M1610121600\":102},{\"M1610150400\":93},{\"M1610179200\":92},{\"M1610035200\":98},{\"M1610064000\":99},{\"M1610092800\":109},{\"M1609948800\":100},{\"M1609977600\":99},{\"M1610006400\":97},{\"M1609862400\":99},{\"M1609891200\":104},{\"M1609920000\":104},{\"M1609776000\":110},{\"M1609804800\":97},{\"M1609833600\":92},{\"M1609689600\":99},{\"M1609718400\":97},{\"M1609747200\":102},{\"M1609603200\":107},{\"M1609632000\":100},{\"M1609660800\":98},{\"M1609516800\":98},{\"M1609545600\":99},{\"M1609574400\":110},{\"M1609430400\":113},{\"M1609459200\":107},{\"M1609488000\":100},{\"M1609344000\":100},{\"M1609372800\":101},{\"M1609401600\":103},{\"M1609257600\":113},{\"M1609286400\":106},{\"M1609315200\":104},{\"M1609171200\":99},{\"M1609200000\":97},{\"M1609228800\":106},{\"M1609084800\":100},{\"M1609113600\":112},{\"M1609142400\":112},{\"M1608998400\":102},{\"M1609027200\":110},{\"M1609056000\":103},{\"M1608912000\":112},{\"M1608940800\":118},{\"M1608969600\":102},{\"M1608825600\":119},{\"M1608854400\":97},{\"M1608883200\":102},{\"M1608739200\":110},{\"M1608768000\":109},{\"M1608796800\":121},{\"M1608652800\":101},{\"M1608681600\":106},{\"M1608710400\":109},{\"M1608566400\":99},{\"M1608595200\":117},{\"M1608624000\":113},{\"M1608480000\":118},{\"M1608508800\":118},{\"M1608537600\":101},{\"M1608393600\":118},{\"M1608422400\":107},{\"M1608451200\":105},{\"M1608307200\":111},{\"M1608336000\":104},{\"M1608364800\":110},{\"M1608220800\":90},{\"M1608249600\":101},{\"M1608278400\":124},{\"M1608134400\":102},{\"M1608163200\":120},{\"M1608192000\":109},{\"M1608048000\":107},{\"M1608076800\":115},{\"M1608105600\":100},{\"M1607961600\":121},{\"M1607990400\":105},{\"M1608019200\":92},{\"M1607875200\":104},{\"M1607904000\":90},{\"M1607932800\":104}]', '\0');
INSERT INTO `s_materials` VALUES ('10018', '铬', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":163},{\"M1610323200\":150},{\"M1610352000\":157},{\"M1610208000\":169},{\"M1610236800\":174},{\"M1610265600\":172},{\"M1610121600\":167},{\"M1610150400\":159},{\"M1610179200\":149},{\"M1610035200\":161},{\"M1610064000\":165},{\"M1610092800\":168},{\"M1609948800\":158},{\"M1609977600\":161},{\"M1610006400\":161},{\"M1609862400\":157},{\"M1609891200\":164},{\"M1609920000\":171},{\"M1609776000\":169},{\"M1609804800\":159},{\"M1609833600\":147},{\"M1609689600\":162},{\"M1609718400\":160},{\"M1609747200\":170},{\"M1609603200\":171},{\"M1609632000\":159},{\"M1609660800\":153},{\"M1609516800\":157},{\"M1609545600\":158},{\"M1609574400\":178},{\"M1609430400\":170},{\"M1609459200\":180},{\"M1609488000\":160},{\"M1609344000\":169},{\"M1609372800\":158},{\"M1609401600\":165},{\"M1609257600\":177},{\"M1609286400\":163},{\"M1609315200\":166},{\"M1609171200\":167},{\"M1609200000\":154},{\"M1609228800\":179},{\"M1609084800\":166},{\"M1609113600\":181},{\"M1609142400\":179},{\"M1608998400\":169},{\"M1609027200\":178},{\"M1609056000\":168},{\"M1608912000\":187},{\"M1608940800\":191},{\"M1608969600\":163},{\"M1608825600\":190},{\"M1608854400\":162},{\"M1608883200\":156},{\"M1608739200\":180},{\"M1608768000\":174},{\"M1608796800\":188},{\"M1608652800\":167},{\"M1608681600\":170},{\"M1608710400\":188},{\"M1608566400\":171},{\"M1608595200\":191},{\"M1608624000\":190},{\"M1608480000\":188},{\"M1608508800\":187},{\"M1608537600\":150},{\"M1608393600\":182},{\"M1608422400\":172},{\"M1608451200\":171},{\"M1608307200\":188},{\"M1608336000\":159},{\"M1608364800\":170},{\"M1608220800\":148},{\"M1608249600\":164},{\"M1608278400\":191},{\"M1608134400\":165},{\"M1608163200\":183},{\"M1608192000\":177},{\"M1608048000\":161},{\"M1608076800\":173},{\"M1608105600\":170},{\"M1607961600\":195},{\"M1607990400\":175},{\"M1608019200\":149},{\"M1607875200\":168},{\"M1607904000\":141},{\"M1607932800\":160}]', '\0');
INSERT INTO `s_materials` VALUES ('10019', '铕', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":192},{\"M1610323200\":198},{\"M1610352000\":208},{\"M1610208000\":209},{\"M1610236800\":213},{\"M1610265600\":213},{\"M1610121600\":203},{\"M1610150400\":189},{\"M1610179200\":184},{\"M1610035200\":190},{\"M1610064000\":210},{\"M1610092800\":218},{\"M1609948800\":192},{\"M1609977600\":189},{\"M1610006400\":190},{\"M1609862400\":189},{\"M1609891200\":211},{\"M1609920000\":204},{\"M1609776000\":205},{\"M1609804800\":201},{\"M1609833600\":193},{\"M1609689600\":195},{\"M1609718400\":195},{\"M1609747200\":208},{\"M1609603200\":210},{\"M1609632000\":206},{\"M1609660800\":196},{\"M1609516800\":180},{\"M1609545600\":212},{\"M1609574400\":227},{\"M1609430400\":210},{\"M1609459200\":231},{\"M1609488000\":198},{\"M1609344000\":211},{\"M1609372800\":207},{\"M1609401600\":204},{\"M1609257600\":230},{\"M1609286400\":213},{\"M1609315200\":207},{\"M1609171200\":193},{\"M1609200000\":183},{\"M1609228800\":225},{\"M1609084800\":207},{\"M1609113600\":232},{\"M1609142400\":228},{\"M1608998400\":216},{\"M1609027200\":221},{\"M1609056000\":204},{\"M1608912000\":228},{\"M1608940800\":234},{\"M1608969600\":219},{\"M1608825600\":226},{\"M1608854400\":211},{\"M1608883200\":200},{\"M1608739200\":207},{\"M1608768000\":217},{\"M1608796800\":228},{\"M1608652800\":206},{\"M1608681600\":202},{\"M1608710400\":221},{\"M1608566400\":204},{\"M1608595200\":250},{\"M1608624000\":243},{\"M1608480000\":232},{\"M1608508800\":225},{\"M1608537600\":194},{\"M1608393600\":223},{\"M1608422400\":214},{\"M1608451200\":214},{\"M1608307200\":236},{\"M1608336000\":207},{\"M1608364800\":203},{\"M1608220800\":187},{\"M1608249600\":202},{\"M1608278400\":249},{\"M1608134400\":207},{\"M1608163200\":241},{\"M1608192000\":222},{\"M1608048000\":210},{\"M1608076800\":221},{\"M1608105600\":217},{\"M1607961600\":234},{\"M1607990400\":216},{\"M1608019200\":191},{\"M1607875200\":208},{\"M1607904000\":189},{\"M1607932800\":198}]', '\0');
INSERT INTO `s_materials` VALUES ('10020', '钙', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":78},{\"M1610323200\":73},{\"M1610352000\":81},{\"M1610208000\":81},{\"M1610236800\":81},{\"M1610265600\":82},{\"M1610121600\":78},{\"M1610150400\":73},{\"M1610179200\":75},{\"M1610035200\":80},{\"M1610064000\":79},{\"M1610092800\":86},{\"M1609948800\":84},{\"M1609977600\":79},{\"M1610006400\":78},{\"M1609862400\":74},{\"M1609891200\":82},{\"M1609920000\":84},{\"M1609776000\":88},{\"M1609804800\":76},{\"M1609833600\":75},{\"M1609689600\":82},{\"M1609718400\":80},{\"M1609747200\":82},{\"M1609603200\":84},{\"M1609632000\":81},{\"M1609660800\":77},{\"M1609516800\":71},{\"M1609545600\":79},{\"M1609574400\":88},{\"M1609430400\":86},{\"M1609459200\":85},{\"M1609488000\":77},{\"M1609344000\":85},{\"M1609372800\":86},{\"M1609401600\":77},{\"M1609257600\":95},{\"M1609286400\":84},{\"M1609315200\":84},{\"M1609171200\":82},{\"M1609200000\":76},{\"M1609228800\":91},{\"M1609084800\":79},{\"M1609113600\":89},{\"M1609142400\":91},{\"M1608998400\":85},{\"M1609027200\":87},{\"M1609056000\":88},{\"M1608912000\":91},{\"M1608940800\":92},{\"M1608969600\":85},{\"M1608825600\":92},{\"M1608854400\":83},{\"M1608883200\":82},{\"M1608739200\":87},{\"M1608768000\":88},{\"M1608796800\":97},{\"M1608652800\":83},{\"M1608681600\":81},{\"M1608710400\":88},{\"M1608566400\":81},{\"M1608595200\":98},{\"M1608624000\":95},{\"M1608480000\":94},{\"M1608508800\":92},{\"M1608537600\":76},{\"M1608393600\":93},{\"M1608422400\":82},{\"M1608451200\":88},{\"M1608307200\":90},{\"M1608336000\":78},{\"M1608364800\":87},{\"M1608220800\":73},{\"M1608249600\":83},{\"M1608278400\":97},{\"M1608134400\":82},{\"M1608163200\":95},{\"M1608192000\":89},{\"M1608048000\":82},{\"M1608076800\":88},{\"M1608105600\":80},{\"M1607961600\":97},{\"M1607990400\":88},{\"M1608019200\":73},{\"M1607875200\":82},{\"M1607904000\":74},{\"M1607932800\":83}]', '\0');
INSERT INTO `s_materials` VALUES ('10021', '铝', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":102},{\"M1610323200\":97},{\"M1610352000\":103},{\"M1610208000\":101},{\"M1610236800\":109},{\"M1610265600\":102},{\"M1610121600\":104},{\"M1610150400\":93},{\"M1610179200\":98},{\"M1610035200\":95},{\"M1610064000\":99},{\"M1610092800\":109},{\"M1609948800\":101},{\"M1609977600\":94},{\"M1610006400\":92},{\"M1609862400\":92},{\"M1609891200\":104},{\"M1609920000\":106},{\"M1609776000\":112},{\"M1609804800\":100},{\"M1609833600\":92},{\"M1609689600\":102},{\"M1609718400\":94},{\"M1609747200\":100},{\"M1609603200\":107},{\"M1609632000\":100},{\"M1609660800\":101},{\"M1609516800\":89},{\"M1609545600\":103},{\"M1609574400\":111},{\"M1609430400\":110},{\"M1609459200\":107},{\"M1609488000\":97},{\"M1609344000\":108},{\"M1609372800\":103},{\"M1609401600\":98},{\"M1609257600\":117},{\"M1609286400\":103},{\"M1609315200\":98},{\"M1609171200\":101},{\"M1609200000\":94},{\"M1609228800\":113},{\"M1609084800\":108},{\"M1609113600\":109},{\"M1609142400\":111},{\"M1608998400\":100},{\"M1609027200\":115},{\"M1609056000\":108},{\"M1608912000\":118},{\"M1608940800\":116},{\"M1608969600\":106},{\"M1608825600\":114},{\"M1608854400\":103},{\"M1608883200\":97},{\"M1608739200\":104},{\"M1608768000\":101},{\"M1608796800\":115},{\"M1608652800\":106},{\"M1608681600\":102},{\"M1608710400\":113},{\"M1608566400\":100},{\"M1608595200\":120},{\"M1608624000\":122},{\"M1608480000\":121},{\"M1608508800\":114},{\"M1608537600\":94},{\"M1608393600\":112},{\"M1608422400\":103},{\"M1608451200\":104},{\"M1608307200\":116},{\"M1608336000\":104},{\"M1608364800\":107},{\"M1608220800\":91},{\"M1608249600\":105},{\"M1608278400\":118},{\"M1608134400\":100},{\"M1608163200\":114},{\"M1608192000\":111},{\"M1608048000\":106},{\"M1608076800\":116},{\"M1608105600\":108},{\"M1607961600\":115},{\"M1607990400\":107},{\"M1608019200\":94},{\"M1607875200\":108},{\"M1607904000\":86},{\"M1607932800\":100}]', '\0');
INSERT INTO `s_materials` VALUES ('10022', '金', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":198},{\"M1610323200\":196},{\"M1610352000\":190},{\"M1610208000\":199},{\"M1610236800\":221},{\"M1610265600\":202},{\"M1610121600\":198},{\"M1610150400\":192},{\"M1610179200\":198},{\"M1610035200\":200},{\"M1610064000\":204},{\"M1610092800\":206},{\"M1609948800\":208},{\"M1609977600\":204},{\"M1610006400\":191},{\"M1609862400\":199},{\"M1609891200\":200},{\"M1609920000\":202},{\"M1609776000\":210},{\"M1609804800\":196},{\"M1609833600\":187},{\"M1609689600\":200},{\"M1609718400\":187},{\"M1609747200\":206},{\"M1609603200\":201},{\"M1609632000\":206},{\"M1609660800\":209},{\"M1609516800\":179},{\"M1609545600\":203},{\"M1609574400\":209},{\"M1609430400\":212},{\"M1609459200\":230},{\"M1609488000\":207},{\"M1609344000\":202},{\"M1609372800\":210},{\"M1609401600\":205},{\"M1609257600\":230},{\"M1609286400\":201},{\"M1609315200\":200},{\"M1609171200\":210},{\"M1609200000\":186},{\"M1609228800\":226},{\"M1609084800\":210},{\"M1609113600\":224},{\"M1609142400\":226},{\"M1608998400\":199},{\"M1609027200\":220},{\"M1609056000\":213},{\"M1608912000\":234},{\"M1608940800\":228},{\"M1608969600\":214},{\"M1608825600\":236},{\"M1608854400\":201},{\"M1608883200\":202},{\"M1608739200\":212},{\"M1608768000\":217},{\"M1608796800\":243},{\"M1608652800\":215},{\"M1608681600\":213},{\"M1608710400\":229},{\"M1608566400\":205},{\"M1608595200\":243},{\"M1608624000\":240},{\"M1608480000\":231},{\"M1608508800\":231},{\"M1608537600\":203},{\"M1608393600\":221},{\"M1608422400\":222},{\"M1608451200\":203},{\"M1608307200\":225},{\"M1608336000\":191},{\"M1608364800\":210},{\"M1608220800\":192},{\"M1608249600\":210},{\"M1608278400\":236},{\"M1608134400\":212},{\"M1608163200\":240},{\"M1608192000\":230},{\"M1608048000\":204},{\"M1608076800\":218},{\"M1608105600\":209},{\"M1607961600\":238},{\"M1607990400\":209},{\"M1608019200\":194},{\"M1607875200\":207},{\"M1607904000\":184},{\"M1607932800\":215}]', '\0');
INSERT INTO `s_materials` VALUES ('10023', '锰', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":81},{\"M1610323200\":78},{\"M1610352000\":76},{\"M1610208000\":83},{\"M1610236800\":83},{\"M1610265600\":84},{\"M1610121600\":78},{\"M1610150400\":75},{\"M1610179200\":76},{\"M1610035200\":80},{\"M1610064000\":85},{\"M1610092800\":82},{\"M1609948800\":81},{\"M1609977600\":76},{\"M1610006400\":81},{\"M1609862400\":76},{\"M1609891200\":85},{\"M1609920000\":82},{\"M1609776000\":83},{\"M1609804800\":79},{\"M1609833600\":73},{\"M1609689600\":80},{\"M1609718400\":80},{\"M1609747200\":85},{\"M1609603200\":81},{\"M1609632000\":81},{\"M1609660800\":78},{\"M1609516800\":77},{\"M1609545600\":82},{\"M1609574400\":86},{\"M1609430400\":86},{\"M1609459200\":90},{\"M1609488000\":76},{\"M1609344000\":83},{\"M1609372800\":79},{\"M1609401600\":78},{\"M1609257600\":88},{\"M1609286400\":83},{\"M1609315200\":80},{\"M1609171200\":84},{\"M1609200000\":77},{\"M1609228800\":88},{\"M1609084800\":85},{\"M1609113600\":88},{\"M1609142400\":94},{\"M1608998400\":83},{\"M1609027200\":85},{\"M1609056000\":83},{\"M1608912000\":92},{\"M1608940800\":93},{\"M1608969600\":81},{\"M1608825600\":92},{\"M1608854400\":84},{\"M1608883200\":79},{\"M1608739200\":83},{\"M1608768000\":87},{\"M1608796800\":92},{\"M1608652800\":82},{\"M1608681600\":81},{\"M1608710400\":95},{\"M1608566400\":80},{\"M1608595200\":95},{\"M1608624000\":95},{\"M1608480000\":93},{\"M1608508800\":95},{\"M1608537600\":75},{\"M1608393600\":94},{\"M1608422400\":87},{\"M1608451200\":87},{\"M1608307200\":89},{\"M1608336000\":79},{\"M1608364800\":82},{\"M1608220800\":72},{\"M1608249600\":81},{\"M1608278400\":100},{\"M1608134400\":81},{\"M1608163200\":90},{\"M1608192000\":92},{\"M1608048000\":83},{\"M1608076800\":90},{\"M1608105600\":85},{\"M1607961600\":92},{\"M1607990400\":88},{\"M1608019200\":79},{\"M1607875200\":82},{\"M1607904000\":72},{\"M1607932800\":82}]', '\0');
INSERT INTO `s_materials` VALUES ('10024', '锡', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":83},{\"M1610323200\":76},{\"M1610352000\":77},{\"M1610208000\":80},{\"M1610236800\":88},{\"M1610265600\":82},{\"M1610121600\":83},{\"M1610150400\":73},{\"M1610179200\":80},{\"M1610035200\":79},{\"M1610064000\":81},{\"M1610092800\":85},{\"M1609948800\":80},{\"M1609977600\":79},{\"M1610006400\":78},{\"M1609862400\":75},{\"M1609891200\":86},{\"M1609920000\":83},{\"M1609776000\":88},{\"M1609804800\":83},{\"M1609833600\":75},{\"M1609689600\":78},{\"M1609718400\":80},{\"M1609747200\":80},{\"M1609603200\":83},{\"M1609632000\":81},{\"M1609660800\":84},{\"M1609516800\":75},{\"M1609545600\":82},{\"M1609574400\":89},{\"M1609430400\":88},{\"M1609459200\":92},{\"M1609488000\":81},{\"M1609344000\":86},{\"M1609372800\":78},{\"M1609401600\":81},{\"M1609257600\":95},{\"M1609286400\":87},{\"M1609315200\":81},{\"M1609171200\":81},{\"M1609200000\":80},{\"M1609228800\":91},{\"M1609084800\":80},{\"M1609113600\":87},{\"M1609142400\":89},{\"M1608998400\":82},{\"M1609027200\":92},{\"M1609056000\":86},{\"M1608912000\":89},{\"M1608940800\":91},{\"M1608969600\":86},{\"M1608825600\":96},{\"M1608854400\":80},{\"M1608883200\":80},{\"M1608739200\":88},{\"M1608768000\":86},{\"M1608796800\":91},{\"M1608652800\":83},{\"M1608681600\":84},{\"M1608710400\":90},{\"M1608566400\":85},{\"M1608595200\":98},{\"M1608624000\":98},{\"M1608480000\":92},{\"M1608508800\":92},{\"M1608537600\":80},{\"M1608393600\":94},{\"M1608422400\":82},{\"M1608451200\":85},{\"M1608307200\":90},{\"M1608336000\":76},{\"M1608364800\":87},{\"M1608220800\":79},{\"M1608249600\":86},{\"M1608278400\":95},{\"M1608134400\":80},{\"M1608163200\":96},{\"M1608192000\":91},{\"M1608048000\":80},{\"M1608076800\":89},{\"M1608105600\":85},{\"M1607961600\":94},{\"M1607990400\":84},{\"M1608019200\":73},{\"M1607875200\":80},{\"M1607904000\":70},{\"M1607932800\":86}]', '\0');
INSERT INTO `s_materials` VALUES ('10025', '铅', '[{\"M1610380800\":0},{\"M1610382600\":0},{\"M1610384400\":0},{\"M1610386200\":0},{\"M1610388000\":0},{\"M1610389800\":0},{\"M1610391600\":0},{\"M1610393400\":0},{\"M1610395200\":0},{\"M1610397000\":0},{\"M1610398800\":0},{\"M1610400600\":0},{\"M1610402400\":0},{\"M1610404200\":0},{\"M1610406000\":0},{\"M1610407800\":0},{\"M1610409600\":0},{\"M1610411400\":0},{\"M1610413200\":0},{\"M1610415000\":0},{\"M1610416800\":0},{\"M1610418600\":0},{\"M1610420400\":0},{\"M1610422200\":0},{\"M1610424000\":0},{\"M1610425800\":0},{\"M1610427600\":0},{\"M1610429400\":0},{\"M1610431200\":0},{\"M1610433000\":0},{\"M1610434800\":0},{\"M1610436600\":0},{\"M1610438400\":0},{\"M1610440200\":0},{\"M1610442000\":0},{\"M1610443800\":0},{\"M1610445600\":0},{\"M1610447400\":0},{\"M1610449200\":0},{\"M1610451000\":0},{\"M1610452800\":0},{\"M1610454600\":0},{\"M1610456400\":0},{\"M1610458200\":0},{\"M1610460000\":0},{\"M1610461800\":0},{\"M1610463600\":0},{\"M1610465400\":0}]', '[{\"M1610380800\":0},{\"M1610409600\":0},{\"M1610438400\":0},{\"M1610294400\":97},{\"M1610323200\":92},{\"M1610352000\":98},{\"M1610208000\":97},{\"M1610236800\":108},{\"M1610265600\":106},{\"M1610121600\":106},{\"M1610150400\":97},{\"M1610179200\":92},{\"M1610035200\":93},{\"M1610064000\":102},{\"M1610092800\":105},{\"M1609948800\":105},{\"M1609977600\":99},{\"M1610006400\":95},{\"M1609862400\":102},{\"M1609891200\":104},{\"M1609920000\":102},{\"M1609776000\":104},{\"M1609804800\":104},{\"M1609833600\":98},{\"M1609689600\":96},{\"M1609718400\":93},{\"M1609747200\":105},{\"M1609603200\":106},{\"M1609632000\":99},{\"M1609660800\":96},{\"M1609516800\":91},{\"M1609545600\":102},{\"M1609574400\":108},{\"M1609430400\":106},{\"M1609459200\":113},{\"M1609488000\":105},{\"M1609344000\":109},{\"M1609372800\":106},{\"M1609401600\":98},{\"M1609257600\":113},{\"M1609286400\":104},{\"M1609315200\":105},{\"M1609171200\":106},{\"M1609200000\":101},{\"M1609228800\":105},{\"M1609084800\":101},{\"M1609113600\":116},{\"M1609142400\":114},{\"M1608998400\":100},{\"M1609027200\":113},{\"M1609056000\":108},{\"M1608912000\":114},{\"M1608940800\":116},{\"M1608969600\":102},{\"M1608825600\":113},{\"M1608854400\":104},{\"M1608883200\":102},{\"M1608739200\":111},{\"M1608768000\":102},{\"M1608796800\":118},{\"M1608652800\":106},{\"M1608681600\":104},{\"M1608710400\":110},{\"M1608566400\":101},{\"M1608595200\":115},{\"M1608624000\":116},{\"M1608480000\":115},{\"M1608508800\":117},{\"M1608537600\":100},{\"M1608393600\":118},{\"M1608422400\":102},{\"M1608451200\":103},{\"M1608307200\":114},{\"M1608336000\":103},{\"M1608364800\":109},{\"M1608220800\":98},{\"M1608249600\":105},{\"M1608278400\":126},{\"M1608134400\":105},{\"M1608163200\":122},{\"M1608192000\":109},{\"M1608048000\":107},{\"M1608076800\":109},{\"M1608105600\":101},{\"M1607961600\":115},{\"M1607990400\":110},{\"M1608019200\":91},{\"M1607875200\":103},{\"M1607904000\":87},{\"M1607932800\":103}]', '\0');

-- ----------------------------
-- Table structure for s_props
-- ----------------------------
DROP TABLE IF EXISTS `s_props`;
CREATE TABLE `s_props` (
  `id` int NOT NULL COMMENT '配置id',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `price` int unsigned DEFAULT '0' COMMENT '价格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='后台道具表';

-- ----------------------------
-- Records of s_props
-- ----------------------------
INSERT INTO `s_props` VALUES ('10001', '塑性器', '10');
INSERT INTO `s_props` VALUES ('10002', '反应堆', '10');
INSERT INTO `s_props` VALUES ('10003', '铝硅钎剂粉', '10');
INSERT INTO `s_props` VALUES ('10004', '晶间腐蚀剂', '10');
INSERT INTO `s_props` VALUES ('10005', '50小时加速器', '10');
INSERT INTO `s_props` VALUES ('10006', '60小时加速器', '10');
INSERT INTO `s_props` VALUES ('10007', '70小时加速器', '10');
INSERT INTO `s_props` VALUES ('10008', '80小时加速器', '10');
INSERT INTO `s_props` VALUES ('10009', '90小时加速器', '10');
INSERT INTO `s_props` VALUES ('10010', '100小时加速器', '10');
INSERT INTO `s_props` VALUES ('10011', '110小时加速器', '10');
INSERT INTO `s_props` VALUES ('10012', '120小时加速器', '10');
INSERT INTO `s_props` VALUES ('10013', '130小时加速器', '10');
INSERT INTO `s_props` VALUES ('10014', '140小时加速器', '10');
INSERT INTO `s_props` VALUES ('10015', '150小时加速器', '10');
INSERT INTO `s_props` VALUES ('10016', '160小时加速器', '10');
INSERT INTO `s_props` VALUES ('10017', '170小时加速器', '10');
INSERT INTO `s_props` VALUES ('10018', '180小时加速器', '10');
INSERT INTO `s_props` VALUES ('10019', '190小时加速器', '10');
INSERT INTO `s_props` VALUES ('10020', '200小时加速器', '10');
INSERT INTO `s_props` VALUES ('10021', '210小时加速器', '10');
INSERT INTO `s_props` VALUES ('10022', '220小时加速器', '10');
INSERT INTO `s_props` VALUES ('10023', '230小时加速器', '10');
INSERT INTO `s_props` VALUES ('10024', '240小时加速器', '10');
INSERT INTO `s_props` VALUES ('10025', '250小时加速器', '10');
INSERT INTO `s_props` VALUES ('10026', '260小时加速器', '10');

-- ----------------------------
-- Table structure for s_roleinit
-- ----------------------------
DROP TABLE IF EXISTS `s_roleinit`;
CREATE TABLE `s_roleinit` (
  `id` int unsigned NOT NULL,
  `data1` int unsigned NOT NULL,
  `data2` int unsigned NOT NULL,
  `str1` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `str2` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色初始化';

-- ----------------------------
-- Records of s_roleinit
-- ----------------------------
INSERT INTO `s_roleinit` VALUES ('1', '0', '0', '100,200,300,100', '', '初始属性');
INSERT INTO `s_roleinit` VALUES ('2', '0', '0', '1000110001,10001,10001,10001,10001,10012,10013', '', '初始机甲信息(海姆达尔)');
INSERT INTO `s_roleinit` VALUES ('3', '0', '0', '1000110001,10002,10002,10002,10018,10027', '', '初始机甲信息(冷蛛)');
INSERT INTO `s_roleinit` VALUES ('4', '0', '0', '1000110001,10003,10003,10003,10028,10029', '', '初始机甲信息(兰斯洛特)');

-- ----------------------------
-- Table structure for s_sale
-- ----------------------------
DROP TABLE IF EXISTS `s_sale`;
CREATE TABLE `s_sale` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `cfgid` int NOT NULL COMMENT '配置id',
  `type` int unsigned NOT NULL COMMENT '类别',
  `price` int unsigned DEFAULT '0' COMMENT '价格',
  `saleprice` int unsigned DEFAULT '0' COMMENT '优惠价格',
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `iskh` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否氪金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='超值礼包';

-- ----------------------------
-- Records of s_sale
-- ----------------------------
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

-- ----------------------------
-- Table structure for s_special
-- ----------------------------
DROP TABLE IF EXISTS `s_special`;
CREATE TABLE `s_special` (
  `id` int unsigned NOT NULL COMMENT 'id',
  `cfgid` int NOT NULL COMMENT '配置id',
  `type` int unsigned NOT NULL COMMENT '类别',
  `price` int unsigned DEFAULT '0' COMMENT '价格',
  `saleprice` int unsigned DEFAULT '0' COMMENT '优惠价格',
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `downtime` int unsigned NOT NULL COMMENT '下架时间',
  `iskh` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否氪金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='限时特价';

-- ----------------------------
-- Records of s_special
-- ----------------------------
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
-- Procedure structure for lr_time
-- ----------------------------
DROP PROCEDURE IF EXISTS `lr_time`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lr_time`()
begin
    declare n int default 100000;
    declare MAX int default 100001;
    while n < MAX do
        INSERT INTO `d_machineinfo` (`id`, `defaultindex`, `machinecfgid`) VALUES (n ,4, "0");
        set n = n + 1;
    end while;
end
;;
DELIMITER ;


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