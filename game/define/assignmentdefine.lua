local assignmentdefine = {}

assignmentdefine.typelist = enum {
  main = 1,                                -- 主线
  branch = 2,                              -- 支线
}

assignmentdefine.indextype = enum {
  numing = 1,                               -- 计数中
  numover = 2,                              -- 计数完成
  finish = 3,                               -- 完成
}

assignmentdefine.tasktype = enum {
  day = 1,                                  -- 每日任务
  urgent = 2,                               -- 紧急任务
  plot = 3,                                 -- 剧情任务
}


return assignmentdefine