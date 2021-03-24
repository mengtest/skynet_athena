local skynet = require "skynet"
require "skynet.manager"

local queue = {}

local CMD = {}

function CMD.start()
end

function CMD.stop()
end

-- function CMD.transaction()
--     table.insert(queue, "START TRANSACTION")
-- end

-- function CMD.rollback()
--     table.insert(queue, "ROLLBACK")
-- end

-- function CMD.commit()
--     table.insert(queue, "COMMIT")
-- end

-- function CMD.sync(sql, sync)
--     table.insert(queue, sql)
-- end

-- local function sync_impl()
--     while true do
--         -- skynet.error(tostring(queue))
--         for key, value in ipairs(queue) do
--             skynet.call("mysqlpool", "lua", "execute", value, true)
--             queue[key] = nil
--         end
--         skynet.sleep(500)
--     end
-- end

--不使用队列
function CMD.transaction()
    skynet.call("mysqlpool", "lua", "execute", "START TRANSACTION", true)
end

function CMD.rollback()
    skynet.call("mysqlpool", "lua", "execute", "ROLLBACK", true)
end

function CMD.commit()
    skynet.call("mysqlpool", "lua", "execute", "COMMIT", true)
end

function CMD.sync(sql, sync)
    skynet.call("mysqlpool", "lua", "execute", sql, true)
end

skynet.start(function()
    skynet.dispatch("lua", function(session, source, cmd, ...)
        local f = assert(CMD[cmd], cmd .. "not found")
        skynet.retpack(f(...))
    end)
    -- skynet.fork(sync_impl)
    skynet.register(SERVICE_NAME)
end)

