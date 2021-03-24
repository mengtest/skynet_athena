local skynet = require "skynet" 
local snax = require "skynet.snax"

skynet.start(function () 
    local obj = snax.queryservice("")
    snax.hotfix(obj, [[ 
        local skynet
        function cmd.a()
        end
    ]])
    skynet.exit() 
end)