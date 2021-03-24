local battledatahandler = class("battledatahandler")
local snax = require "skynet.snax"
local skynet = require "skynet"
local sharedata = require "skynet.sharedata"
local queue = require "skynet.queue"
local cs = queue()

function battledatahandler:ctor()
end

-- 根据stageid得到missiontype
local function get_task_type(stageid)
    local stage = sharedata.deepcopy("stage", stageid)
    return stage.Task_Type
end

-- 判断胜负,传入一方在tempfighters的index
local function loserjudge(tempfighters, deathlist, startindex, endindex)
    local isalldied = true

    for i = startindex, endindex do
        if table.find(deathlist, tempfighters[i]) == nil then
            isalldied = false
            break
        end
    end

    return isalldied
end

-- 奖励触发, 在winplayers里的胜者, 否则为负者
local function balance_reward(winplayers, tempfighter, stageid)
    -- 金币/经验/的下发, 材料队列的开启
    local bqproxy = snax.queryservice("bqproxy")
    local iswinner = table.find(winplayers, tempfighter)
    -- 测试的话可以在这里加个for循环增加运输机数量【测试使用】
    -- for i = 1, 10 do
    --     cs(bqproxy.req.sendbattle_reward, tempfighter, stageid, iswinner)
    -- end

    cs(bqproxy.req.sendbattle_reward, tempfighter, stageid, iswinner)
end

---@param tempfighters table 所有人集合
---@param deathlist table 死亡集合
---@param stageid number 关卡类型
---@param targetcount number 目标数
---@param curcount number 当前人数
function battledatahandler:judge_battle_end(tempfighters, deathlist, stageid, targetcount, curcount)
    local winmsg = {}
    local isfinish = false
    
    if #deathlist > 0 then
        winmsg.lastdeath = deathlist[#deathlist]
    end
    targetcount = targetcount or 0
    curcount = curcount or 0
    local winidarr = {}

    local stagetype = get_task_type(stageid)

    if stagetype == teammatchdefine.missiontype.pvp then
        -- 两方对战
        if loserjudge(tempfighters, deathlist, 1, #tempfighters / 2) == true then
            winmsg.playerid = {}
            for i = (#tempfighters / 2) + 1, #tempfighters do
                table.insert(winmsg.playerid, tempfighters[i])
            end
            winidarr = winmsg.playerid
            for i = 1, #tempfighters do
                send_request(get_user_fd(tempfighters[i]), winmsg, "battleproxy_winner")
                balance_reward(winmsg.playerid, tempfighters[i], stageid)
            end
            
            isfinish = true
        end

        if loserjudge(tempfighters, deathlist, (#tempfighters / 2) + 1, #tempfighters) == true then
            winmsg.playerid = {}
            for i = 1, #tempfighters / 2 do
                table.insert(winmsg.playerid, tempfighters[i])
            end
            winidarr = winmsg.playerid
            for i = 1, #tempfighters do
                send_request(get_user_fd(tempfighters[i]), winmsg, "battleproxy_winner")
                balance_reward(winmsg.playerid, tempfighters[i], stageid)
            end

            isfinish = true
        end

    elseif stagetype == teammatchdefine.missiontype.annihilate or stagetype == teammatchdefine.missiontype.tutorial then
        -- 玩家获胜
        local diednpcs = {}

        for i = 1, #deathlist do
            if deathlist[i] < 0 then
                table.insert(diednpcs, deathlist[i])
            end
        end
        curcount = #diednpcs
        if curcount >= targetcount then
            isfinish = true
        end
        skynet.error("当前数量：",curcount, ",", "目标数量:", targetcount, "isfinish:", isfinish)
        if isfinish then
            winmsg.playerid = {}
            for i = 1, #tempfighters do
                table.insert(winmsg.playerid, tempfighters[i])
            end

            for i = 1, #tempfighters do
                send_request(get_user_fd(tempfighters[i]), winmsg, "battleproxy_winner")
                balance_reward(winmsg.playerid, tempfighters[i], stageid)
            end
            return isfinish, winmsg.playerid
        end

        -- npc获胜
        if loserjudge(tempfighters, deathlist, 1, #tempfighters) == true then
            winmsg.playerid = {-1}
            isfinish = true
            for i = 1, #tempfighters do
                send_request(get_user_fd(tempfighters[i]), winmsg, "battleproxy_winner")
                balance_reward(winmsg.playerid, tempfighters[i], stageid)
            end

            return isfinish
        end

    elseif stagetype == teammatchdefine.missiontype.excavate then
        -- 玩家获胜
        if curcount >= targetcount then
            isfinish = true
        end

        if isfinish then
            winmsg.playerid = {}
            for i = 1, #tempfighters do
                table.insert(winmsg.playerid, tempfighters[i])
            end

            for i = 1, #tempfighters do
                send_request(get_user_fd(tempfighters[i]), winmsg, "battleproxy_winner")
                balance_reward(winmsg.playerid, tempfighters[i], stageid)
            end
            return isfinish
        end

        -- npc获胜
        if loserjudge(tempfighters, deathlist, 1, #tempfighters) == true then
            winmsg.playerid = {-1}
            isfinish = true
            for i = 1, #tempfighters do
                send_request(get_user_fd(tempfighters[i]), winmsg, "battleproxy_winner")
                balance_reward(winmsg.playerid, tempfighters[i], stageid)
            end

            return isfinish
        end
    end
    return isfinish, winidarr
end

return battledatahandler.new()