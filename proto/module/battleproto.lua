local battleproto = {}

--[30-89)

battleproto.struct = [[
    .playerattribute {
        playerid 0:integer  #玩家id
        hp 1:integer   #血量
        shield 2:integer     # 护盾值
        energy 3:integer     # 能量
        elevation 4:integer              # 仰角
        overhang 5:integer               # 俯角
        enefficiency 6:integer(3)        # 能量效率
        efficiency 7:integer(3)          # 引擎效率
        climbingangle 8:integer          # 底盘爬角
        npccfgid 9:integer               # npc表中的配置id，玩家为-1
    }
    .damageinfo {
        playerid 0:integer  #玩家id
        hp 1:integer   #血量  
        shield 2:integer     #护盾
    }
    .fvector {
        x 0: integer
        y 1: integer
        z 2: integer           
    }

    .frotator {
        roll 0: integer(5)
        pitch 1: integer(5)
        yaw 2: integer(5)
    }

    .machineinfo {
        playerid 0:integer   #玩家id
        name 1: string       #昵称
        body 2: *integer   # 机体信息
        chassis 3: *integer   #底盘信息
        firecontroller  4: *integer  #火控信息
        weapons 5: *integer    #武器信息
        pos 6: fvector            #  位置
        npccfgid 7:integer       # npc表中的配置id，玩家为-1
        groupid 8:integer        # 群组id
    }

    .turninfo {
        playerid 0:integer   # 玩家id
        turnlong 1:integer(3)   # 占用回合长度
        groupid 2:integer
        energy 3:integer          # 能量值
    }

    .areainfo {
        pos 0: fvector      # 碰撞体位置
        index 1: integer       # 碰撞体辨识索引
        cfgid 2: integer       # 在trigger_area表中的id
        length 3: integer      # 经过计算后显示用的进度，搭配表中的max值食用（非当前回合长度
    }

    .weaponattri {                          # 芯片增幅 可能为空
        buffid 0:integer                    # 属性id
        val 1:integer(3)                    # 百分比        10000 被动 10001 主动
    }
    .weaponattris {
        weaponattri 0: *weaponattri         # 增幅属性信息  可能为空表示当前武器没有属性加成
    }

    .battleinfo {
        uid 0: integer                      
        kill 1: string                      # 击杀
        harm 2: integer                     # 伤害
        defense 3: integer                  # 防御
    }
]]

battleproto.c2s = battleproto.struct .. [[
    battleproxy_mapinit 30 {
        request {
        }
		response {
            mapid 0: integer    # 地图id
            stageid 1: integer     # 关卡id
            leftrightlocation 2: *integer     # 左右位置
            topdownlocation 3: *integer       # 上下位置
            playerlistinfo 4: *machineinfo      # 此局玩家信息
            playerattribute 5: *playerattribute   # 此局玩家属性信息
            gravity 6: integer(2)      # 重力
            temperature 7: integer(2)    # 温度
            amplitude 8: integer(2)   # 风力振幅
            areainfos 9: *areainfo      # 可触发区域信息
		}    
    }
    battleproxy_readycheck 31 {
        request {}            
    }
    battleproxy_move 32 {
        request {
            npcid  0: integer     # 仅房主的npc有效
            movestate 1: integer   # 移动状态值， -1, 0, 1   ...
            location 2: fvector     # 位置
            isleft 3: boolean      # 是否朝左，主要ai移动同步使用
            remainenergy 4: integer     # 剩余能量值
        }    
    }
    battleproxy_aim 33 {
        request {
            npcid  0: integer     # 仅房主的npc有效
            faceto 1: integer   # 瞄准时的朝向 -1, 0, 1   ...
            angle 2: integer      # 炮管角度
        }    
    }
    battleproxy_switchweapon 34 {
        request {
            npcid  0: integer
            weaponindex 1: integer   
        }
        response {
            playerattribute 0: playerattribute   # 玩家属性信息
        }    
    }
    battleproxy_fire 35 {
        request {
            npcid  0: integer
            weaponid 1: integer  
            firepoint 2: fvector    # 炮火点
            angle 3: frotator      # 发射角度
            power 4: integer(5)        #  初速度
            critical 5: boolean        # 是否暴击
        }    
        response {
            code 0: integer
        }
    }
    battleproxy_turnend 36 {
        request {
            npcid  0: integer
            location 1: fvector     # 位置
            remainenergy 2: integer        # 剩余能量值
        }    
    }
    battleproxy_explode 37 {
        request {
            npcid 0:integer    
            location 1: fvector     # 炮弹落点位置
            hitplayer 2: integer    # 全额伤害对象的uid，没有的话传0
            rubplayer 3: *integer       # 摩擦伤害对象的uid列表，没有传{}
            weaponid 4: integer         # 武器id
            hittype 5: integer   
        }    
    }
    battleproxy_aimupdate 38 {
        request {
            npcid 0: integer     
            isaiming 1: boolean    # 是否为瞄准状态
        }    
    }
    battleproxy_death 39 {
        request {
            npcid 0:integer          # 如果是npc且是房主的话用这个id，否则让发这个包的人死
        }
    }
    battleproxy_skillspell 40 {
        request {
            npcid 0: integer
            skillid 1: integer          # 技能id
            params 2: string            # 技能使用参数
            spellpos 3: fvector         # 位置
        }
        response {
            code 0: integer
        }
    }
    battleproxy_skillactive 41 {
        request {
            npcid 0: integer
            skillid 1: integer          # 技能id
            isactive 2: boolean            # 激活还是取消，true为激活
        }
    }  
    battleproxy_skipdialogue 42 {       # 跳过对话
        request {
        }
    }

    battleproxy_triggerarea 43 {
        request {
            npcid 0: integer
            areaindex 1: integer     # 触发哪一块区域
        }
    }
    battleproxy_offline 44 {
        request {
        }
		response {
            code 0: integer
		} 
    }    
    battleproxy_npcstatesync 63 {
        request {
            npcid 0: integer      # npcid
            isactive 1: boolean   # 如为挖掘机，true则挖掘中
        }
    } 
    battleproxy_support 65 {
        request {
            sourceid 0: integer                      # 被赞玩家id
        }
    }
    battleproxy_buffactive 68 {
        request {
            npcid 0: integer             # 由buff被施加者发包，非npc填0
            buffid 1: integer          # buffid
            isactive 2: boolean            # 激活还是取消，true为激活
        }
    }
    battleproxy_jump 74 {
        request {
            npcid 0: integer             # 由buff被施加者发包，非npc填0
            jumppower 1: integer(2)     
            pos 2: fvector               # 位置
            force 3: integer             # 力
            energy 4: integer            # 能量
        }
    }
    battleproxy_jumpend 76 {
        request {
            npcid 0: integer             # 由buff被施加者发包，非npc填0
            pos 1: fvector               # 位置
            energy 2: integer            # 能量
        }
    }
    battleproxy_battledatas 78 {         # 战斗数据
        request {            
        }
        response {
            battledatas 0: *battleinfo
        }
    }
    battleproxy_desterrain 79 {
        request {
            count 0: integer             # 破坏地形数量
        }
    }
    battleproxy_sendsocket 80 {          # 战斗管理器发过来的
        request {
            socket 0: string    
            uid 1: integer              
        }
        response {
            code 0: integer
        }
    }
    battleproxy_sendroomnum 84 {         # 战斗管理器发过来的      
        request {
            count 0: integer    
            uid 1: integer
        }
    }
]]

battleproto.s2c = battleproto.struct .. [[
    battleproxy_chipattribute 45 {              # 芯片加成
		request {                              # 增幅多个同类型buff，先求和（百分比），之后乘以基础值为最终变化量
            machineattris 0: *weaponattri        # 机甲芯片增幅   buff对应的val值 是增幅百分比 buffid可能为技能（val值为0为技能）
            weaponattris 1: *weaponattris       # 武器芯片增幅   buff对应的val值 是增幅百分比 buffid可能为技能（val值为0为技能）
		}    
    }
	battleproxy_battlestart 46 {
		request { }                     #通知开始战斗，播动画。。
    }
	battleproxy_playerattribute 47 {
		request {
            playerid 0: integer                  
            playerattribute 1: playerattribute   #玩家属性变化，hp,速度等。。
		}
    }
    battleproxy_turninfo 48 {     
        request {
            turninfo 0: *turninfo     # 轮转顺序列表
        }
    }
    battleproxy_aim 49 {
        request {
            playerid 0: integer
            faceto 1: integer     # 瞄准时的朝向  -1， 1
            angle 2: integer      # 炮管角度
        }    
    }
	battleproxy_onmove 50 {
		request {
            playerid 0: integer
            movestate 1: integer   # 移动状态值， -1, 0, 1   ...
            location 2: fvector     # 位置
            isleft 3: boolean      # 是否朝左，主要ai移动同步使用
            remainenergy 4: integer     # 剩余能量值
		}
    }
    battleproxy_onswitchweapon 51 {
		request {
            playerid 0: integer
            weaponindex 1: integer
		}
    }
    battleproxy_onskilldamage 52 {
        request {
            damagearr 0: *damageinfo   # 哪些玩家收到了多少伤害
        }
    }
    battleproxy_winner 53 {
        request {
            playerid 0: *integer      # 哪些玩家获得了胜利
            lastdeath 1: integer          # 最后一个死掉的人
		}        
    }

    battleproxy_turnchange 54 {
        request {
            curturn 0: integer      # 接下来是第几回合
            wind 1: integer(2)    # 该回合的风力
		}        
    }
    battleproxy_onfire 55 {
        request {
            playerid 0: integer     # 谁发射的
            weaponid 1: integer
            firepoint 2: fvector    # 炮火点
            angle 3: frotator       # 发射角度
            speed 4: integer        #  初速度
            critical 5: boolean        # 是否暴击
            remainenergy 6: integer      # 使用后剩余能量
		}        
    }
    battleproxy_turnend 56 {
        request {
            playerid 0: integer   
            location 1: fvector     # 位置
            remainenergy 2: integer        # 剩余能量值
        }        
    }
    battleproxy_explode 57 {
        request {  
            hitresult 0: *playerattribute   # 被击中的玩家信息，血量，护盾
            location 1: fvector     # 炮弹落点位置
            strength 2: integer   # 打在地形造成的破坏强度
            radius 3: integer     # 打在地形造成的破坏半径
            weaponid 4: integer         # 武器id
            trigger 5: integer           # 触发爆炸者playerid
            hittype 6: integer            
        }        
    }
    battleproxy_aimupdate 58 {
        request {   
            playerid 0: integer
            isaiming 1: boolean     # 是否为瞄准状态
        }        
    }
    battleproxy_ondeath 59 {              
        request {
            playerid 0: integer             # 某人死亡
            killid 1: integer               # 击杀者
        }                   
    }
    battleproxy_onskillspell 60 {              
        request {
            playerid 0: integer          
            skillid 1: integer          # 技能id
            spellpos 2: fvector          # 使用位置
            params 3: string            # 技能使用参数
            remainenergy 4: integer      # 使用后剩余能量
        }
    }
    battleproxy_onskillactive 61 {
        request {
            playerid 0: integer
            skillid 1: integer          # 技能id
            isactive 2: boolean            # 激活还是取消，true为激活
        }
    }  
    battleproxy_spawnnpc 62 {
        request {
            playerlistinfo 0: machineinfo      # 新生成角色机甲信息
            playerattribute 1: playerattribute   # 新生成角色属性信息
        }
    }  
    battleproxy_npcstatesync 64 {
        request {
            npcid 0: integer      # npcid
            isactive 1: boolean   # 如为挖掘机，true则挖掘中
        }
    } 
    battleproxy_passsupport 66 {                     # 被点赞
        request {
            uid 0: integer                           # 点赞玩家id
        }
    }
    battleproxy_reward 67 {
        request {
            businessqueueinfo 2: businessqueueinfo    # 战利品信息, 金币和经验的消息会在这条之前到达
        }
    }
    battleproxy_buffactive 69 {
        request {
            playerid 0: integer
            buffid 1: integer          # buffid
            isactive 2: boolean            # 激活还是取消，true为激活
            level 3: integer            # buff层数
        }
    }
    battleproxy_buffdamage 70 {
        request {
            damageinfo 0: damageinfo   # 玩家收到了多少伤害
        }
    }
    battleproxy_addarea 71 {
        request {
            areainfo 0: areainfo      # 新生成的可触发区域信息
        }
    }  
    battleproxy_delarea 72 {
        request {
            areaindex 0: integer      # 销毁的可触发区域的index
        }
    } 
    battleproxy_bqfulled 73 {
        request {
            shortesttime 0: integer      # 最短的队列时间
        }
    } 
    battleproxy_jump 75 {
        request {
            playerid 0: integer             # 由buff被施加者发包，非npc填0
            jumppower 1: integer(2)    
            pos 2: fvector               # 位置
            force 3: integer             # 力
            energy 4: integer             # 能量
        }
    }
    battleproxy_jumpend 77 {
        request {
            playerid 0: integer           
            pos 1: fvector               # 位置
            energy 2: integer             # 能量
        }
    }
    battleproxy_sendsocket 81 {                          # 向客户端发送
        request {
            socket 0: string       
        }
    }
    battleproxy_getroomnum 82 {            
        request {
            uid 0: integer
        }
    }
    battleproxy_offline 83 {
        request {
            socket 0: string
        }
    }
    battleproxy_createroom 85 {
        request {
        }
    }
]]

return battleproto