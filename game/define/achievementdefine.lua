local achievementdefine = {}

achievementdefine.typelist = enum {
  plot = 1,
  athletics = 2,
  challenge = 3,
  overview = 4,
  other = 5,
}

achievementdefine.indextype = enum {
  numing = 1,                               -- 计数中
  numover = 2,                              -- 计数完成
  finish = 3,                               -- 完成
}

achievementdefine.tasktype = enum {
  day = 1,                                  -- 每日任务
  urgent = 2,                               -- 紧急任务
  plot = 3,                                 -- 剧情任务
}

--后缀说明
--_a 表示获得
--_g 表示收集
--_c 表示消耗/使用
--_s 表示简单
--_d 表示困难
achievementdefine.achievetype = enum {
  plot_s1 = 1,                               -- 简单剧情1      ----------plot begin---------
  plot_d1 = 2,                               -- 困难剧情1
  plot_s2 = 3,                               -- 简单剧情2
  plot_d2 = 4,                               -- 困难剧情2
  plot_s3 = 5,                               -- 简单剧情3
  plot_d3 = 6,                               -- 困难剧情3
  maxnumber_pvp = 1001,                      -- 完整场数pvp    ----------athletics begin---------
  maxnumber_pve = 1002,                      -- 完整场数pve
  winnumber_pvp = 1003,                      -- 胜利场数pvp
  winnumber_pve = 1004,                      -- 胜利场数pve
  serieswin_pvp = 1005,                      -- 连胜数量pvp
  serieswin_pve = 1006,                      -- 连胜数量pve
  pvp1 = 1007,                               -- 单人组队pvp
  pvp2 = 1008,                               -- 双人组队pvp
  pvp3 = 1009,                               -- 三人组队pvp
  kill_pvp1 = 1010,                          -- 单人组队pvp击杀
  kill_pvp2 = 1011,                          -- 双人组队pvp击杀
  kill_pvp3 = 1012,                          -- 三人组队pvp击杀
  kill_pve1 = 1013,                          -- 单人组队pve击杀
  kill_pve2 = 1014,                          -- 双人组队pve击杀
  kill_pve3 = 1015,                          -- 三人组队pve击杀
  death_pvp1 = 1016,                         -- 单人组队pvp死亡
  death_pvp2 = 1017,                         -- 双人组队pvp死亡
  death_pvp3 = 1018,                         -- 三人组队pvp死亡
  death_pve1 = 1019,                         -- 单人组队pve死亡
  death_pve2 = 1020,                         -- 双人组队pve死亡
  death_pve3 = 1021,                         -- 三人组队pve死亡
  supportnum = 1022,                         -- pvp队友点赞
  season = 1023,                             -- 赛季                             【待完成】
  killnpc = 1024,                            -- pve击杀特定npc                            【待完成】
  killdes = 1025,                            -- pvp击杀距离
  hitenemy = 1026,                           -- 命中敌人
  killhp = 1027,                             -- pvp击杀血量
  towkill = 1028,                            -- pvp一次性击杀两人
  killall_pvp2 = 1029,                       -- 双人组队pvp单人杀死全部
  first_pvp2 = 1030,                         -- 双人组队pvp首杀
  life_pvp2 = 1031,                          -- 双人组队pvp两人都活
  killall_pvp3 = 1032,                       -- 三人组队pvp单人杀死全部
  first_pvp3 = 1033,                         -- 三人组队pvp首杀
  double_pvp3 = 1034,                        -- 三人组队pvp双杀
  life_pvp3 = 1035,                          -- 三人组队pvp三人都活
  desterrain = 1036,                         -- 破坏地形
  intomap = 1037,                            -- 进入特定关卡                        【待完成】
  postionmap = 1038,                         -- 到达特定位置                          【待完成】
  casting = 2001,                           -- 铸造次数        ----------challenge begin---------
  weapon_g = 2002,                          -- 收集武器
  body_g = 2003,                            -- 收集机体
  chassis_g = 2004,                         -- 收集底盘
  fire_g = 2005,                            -- 收集火控
  weapon_a = 2006,                          -- 获得武器         
  body_a = 2007,                            -- 获得机体
  chassis_a = 2008,                         -- 获得底盘
  fire_a = 2009,                            -- 获得火控
  chip_c = 2010,                            -- 消耗芯片                            【待完成】
  level = 2011,                             -- 等级
  gold_a = 2012,                            -- 获得金币
  gold_c = 2013,                            -- 消耗金币
  machine = 2014,                           -- 机甲数量
  exp = 2015,                               -- 经验                            【无需求】
  gametime = 2016,                          -- 游戏时长
  equiplv = 2017,                           -- 部件等级
}

return achievementdefine