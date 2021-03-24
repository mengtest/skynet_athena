local assignmentproto = {}

assignmentproto.struct = [[
    .progress {
        objectid 0: integer                         # task_object配置id
        number 1: integer                           # 当前值
    }
    .taskinfo {
        id 0: integer                               # 任务id
        cfgid 1: integer                            # 任务配置id
        profress 2: *progress                       # 当前进度集合
        state 3: integer                            # 当前状态              1:计数中  2:计数完成  3:完成 (最好枚举)
        istasking 4: boolean                        # 是否为当前任务        可能为nil 只有剧情任务才需要此字段
        countdown 5: integer                        # 结束倒计时            可能为nil
    }
]]

 -- 450 - 479		-- 30条	

assignmentproto.c2s = assignmentproto.struct .. [[
    assignment_gettask 460 {                                            # 获取列表数据
        request {
            type 0: integer                                             # 任务类型    1:每日任务  2:紧急任务  3:剧情任务 (最好枚举)
        }
        response {
            code 0: integer
            taskinfos 1: *taskinfo
        }
    }
    assignment_settasking 461 {                                         # 设置当前剧情任务
        request {
            id 0: integer                                               # 任务id
        }
        response {
            code 0: integer
        }
    }
    assignment_talkend 462 {                                            # 对话结束
        request {
            id 0: integer                                               # 任务id
            type 1: integer                                             # 任务类型
        }
        response {
            code 0: integer
        }
    }
]]


assignmentproto.s2c = assignmentproto.struct .. [[
    assignment_finishtask 450 {                                         # 任务完成    
        request {
            id 0: integer                                               # 任务id
            cfgid 1: integer                                            # 任务配置id
            type 2: integer                                             # 任务类型
        }
    }
    assignment_addplottask 451 {                                        # 新剧情任务（即为当前剧情任务）
        request {
            id 0: integer                                               # 任务id
            cfgid 1: integer                                            # 任务配置id
        }
    }
]]


return assignmentproto
