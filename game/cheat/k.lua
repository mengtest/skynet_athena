
local skynet = require "skynet"
local snax = require "skynet.snax"

local tab = {...}
local cmd = {}

function cmd.a()
    skynet.error(tostring(get_uids_names()))
end

--踢普通玩家,如果全踢直接关服
function cmd.k(tab)
    tab = table.concat(tab, ",")
    tab = string.sub(tab, 3, -1)
    tab = string.split(tab)
    get_kick_outs(tab)
end

--踢战斗管理器
function cmd.kk()
    get_kick_out()
end

skynet.info_func(function(str)
    if str == "a" then
        return tostring(get_uids_names())
    elseif str == "k" then
        get_kick_outs({})
    end
end)

skynet.start(function ()
    local f = cmd[tab[1]]
    if f then
        f(tab)
    else
        skynet.error("error command!!!!!!!!!") 
    end
    -- skynet.exit()
end)