local teammatchproto = {}

teammatchproto.struct = [[
    .teammatesinfo {
        playerid 0:integer
        machineinfo 1:machineinfo
        playername 2:string
    }
    .teammatesstatus {
        playerid 0:integer  #玩家id
        isready 1:boolean   #是否准备好
    }
]]

teammatchproto.c2s = teammatchproto.struct .. [[
	teammatch_maketeam 11 {
		request {
            teammatesnum 0  : integer    # 期望人数
            stageid 1 :integer           # 关卡id
		}
		response {
            code 0: integer
            teammatesinfos 1: *teammatesinfo   #玩家信息，机甲信息，id,图片等。。
            readystatus 2: *teammatesstatus    #准备状态
            countdown 3: integer               # 倒计时     可能为nil
		}
    }
    teammatch_doready 12 {
        request {
        }
		response {
            code 0: integer
            isready 1:boolean   #是否准备好
		}
    }
    teammatch_teamexit 13 {
        request {
        }
		response {
            code 0: integer
		}
    }
    teammatch_battleapply 14 {
        request {
            iscancel 0:boolean       # 是否申请取消，是则取消
        }
		response {
            code 0: integer
		}
    }
    teammatch_gopvebattle 19 {
        request {   
            stageid 0: integer     # 单人模式关卡id 
        }    
		response {
            code 0: integer
		}          
    }
]]

teammatchproto.s2c = teammatchproto.struct .. [[
	teammatch_tminfosupdate 15 {
		request {
            teammatesinfos 0: *teammatesinfo   #玩家信息，id,图片等。。
            readystatus 1: *teammatesstatus    #准备状态
		}
    }
    teammatch_kickoff 16 {
        request {
            playerid 0:integer  #踢你的玩家id
            kickofftype 1:integer   # 1:房主解散，2：房主踢人
        }        
    }
    teammatch_matching 17 {
        request {
            ismatching 0:boolean     # 是否匹配中
        }        
    }
    teammatch_battlestart 18 {
        request {
        }
    }
]]

return teammatchproto