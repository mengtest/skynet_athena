local addictiondefine = {}

addictiondefine.addictiontype = enum {
    otherLogin = 1,   --异地登陆
    kickout = 2,      --强制退出  
    addiction = 3,    --防沉迷 
}

addictiondefine.addictionstr = enum {
    [addictiondefine.addictiontype.otherLogin] = "账号异地登录，请注意账号安全!!!!!!",
    [addictiondefine.addictiontype.kickout] = "账号被踢，请联系管理员!!!!!!",
    [addictiondefine.addictiontype.addiction] = "账号已进入防沉迷模式!!!!!!", 
}

return addictiondefine