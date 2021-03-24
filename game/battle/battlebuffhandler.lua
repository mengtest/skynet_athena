local battlebuffhandler = class("battlebuffhandler")
local snax = require "skynet.snax"
local skynet = require "skynet"
local sharedata = require "skynet.sharedata"

local tmpplayer = {}
local battlebuffinfos = {}    -- 战斗buff信息
-- local buffinfo = {
--     buffid=2,
--     curturnlong=3,
--     level=4,
--     caster=5,
--     recver=6,
--     jumpnum=7
-- }

local function getbufftype(buffid)
    local buffcfg = sharedata.deepcopy("buff", buffid)
    return buffcfg.BUFF_Type
end

local function getroundspeed(buffid)
    local buffcfg = sharedata.deepcopy("buff", buffid)
    return buffcfg.Round_Speed
end

local function getbuffduring(buffid)
    local buffcfg = sharedata.deepcopy("buff", buffid)
    return buffcfg.During
end

local function getlevellimit(buffid)
    local buffcfg = sharedata.deepcopy("buff", buffid)
    return buffcfg.Stack_Max
end

local function getbuffdamage(buffid)
    local buffcfg = sharedata.deepcopy("buff", buffid)
    return buffcfg.Per_Damage
end

local function getbuffinfo(buffid, recver)
    if #battlebuffinfos == 0 then
        return
    end

    for i = 1, #battlebuffinfos do
        if battlebuffinfos[i].buffid == buffid and battlebuffinfos[i].recver == recver then
            return i
        end
    end
    return
end

local function newbuffinfo(curturnlong, buffid, caster, recver)
    local buffinfo = {}
    buffinfo.curturnlong = curturnlong
    buffinfo.buffid = buffid
    buffinfo.level = 1
    buffinfo.caster = caster
    buffinfo.recver = recver
    buffinfo.jumpnum = math.floor(getbuffduring(buffid) * getroundspeed(buffid) / 10000)
    return buffinfo
end

-- 统计分开计算的同一buff的层数
local function getoverlaymult_level(buffid, recver)
    local count = 0
    for i = 1, #battlebuffinfos do
        if battlebuffinfos[i].buffid == buffid and battlebuffinfos[i].recver == recver then
            count = count + 1
        end
    end
    return count
end

local function buffsync(playerid, buffid, isactive, level)
    local buffmsg = {}
    buffmsg.playerid = playerid
    buffmsg.buffid = buffid
    buffmsg.isactive = isactive
    buffmsg.level = level

    for i = 1, #tmpplayer do
        send_request(get_user_fd(tmpplayer[i]), buffmsg, "battleproxy_buffactive")
    end
end

function battlebuffhandler:getbuffdamage(buffid)
    return getbuffdamage(buffid)
end

--- 哪些buff需要结算伤害
function battlebuffhandler:get_damaging_buff(curturnlong)
    if #battlebuffinfos == 0 then
        return {}
    end

    local damagingbuff_indexs = {}
    for i = 1, #battlebuffinfos do
        if battlebuffinfos[i].curturnlong < curturnlong then
            table.insert(damagingbuff_indexs, i)
        end
    end

    return damagingbuff_indexs
end

-- battlesvr结算buff之后调的，减少跳数（跳数为0则删掉）并增加相应的回合长度
function battlebuffhandler:onsettledbuff(damagingbuff_indexs)
    if #damagingbuff_indexs == 0 then
        return
    end

    for i = 1, #damagingbuff_indexs do
        battlebuffinfos[damagingbuff_indexs[i]].jumpnum = battlebuffinfos[damagingbuff_indexs[i]].jumpnum - 1
        battlebuffinfos[damagingbuff_indexs[i]].curturnlong = 
            battlebuffinfos[damagingbuff_indexs[i]].curturnlong + (10000 / getroundspeed(battlebuffinfos[damagingbuff_indexs[i]].buffid))
    end

    for i = #battlebuffinfos, 1, -1 do
        if battlebuffinfos[i].jumpnum <= 0 then
            if getbufftype(battlebuffinfos[i].buffid) ~= buffdefine.battlebufftype.overlaymult then
                buffsync(battlebuffinfos[i].recver, battlebuffinfos[i].buffid, false, 0)
            else
                local bufflevel = getoverlaymult_level(battlebuffinfos[i].buffid, battlebuffinfos[i].recver)
    
                if bufflevel <= 1 then
                    buffsync(battlebuffinfos[i].recver, battlebuffinfos[i].buffid, false, 0)
                else
                    buffsync(battlebuffinfos[i].recver, battlebuffinfos[i].buffid, true, bufflevel - 1)
                end
            end
            table.remove(battlebuffinfos, i)
        end
    end

    LOG_INFO("结算后的buffinfo: %s", tostring(battlebuffinfos))
end

-- 设置缓存参战玩家
function battlebuffhandler:settempplayer(tempfighters)
    tmpplayer = table.clone(tempfighters)
end

function battlebuffhandler:getbattlebuffinfos()
    return battlebuffinfos
end

function battlebuffhandler:ctor()
end

---@param curturnlong integer 当前回合长度
---@param buffid integer buffid
---@param caster integer 释放者id
---@param recver integer 接受者id
function battlebuffhandler:addbuffinfo(curturnlong, buffid, caster, recver)
    skynet.error("addbuf!!!!!!!!!!!!!!!!!:", curturnlong, buffid, caster, recver)
    local buffindex = getbuffinfo(buffid, recver)
    local buffinfo = {}
    -- 新增
    if not buffindex then
        buffinfo = newbuffinfo(curturnlong, buffid, caster, recver)
        table.insert(battlebuffinfos, buffinfo)
        buffsync(recver, buffid, true, 1)
        return 
    end

    -- 叠加
    buffinfo = battlebuffinfos[buffindex]
    local bufftype = getbufftype(buffid)
    if bufftype == buffdefine.battlebufftype.unoverlay then
        return
    elseif bufftype == buffdefine.battlebufftype.extend then
        local newjumpnum = math.floor(getbuffduring(buffid) * getroundspeed(buffid) / 10000)
        buffinfo.jumpnum = buffinfo.jumpnum + newjumpnum
    elseif bufftype == buffdefine.battlebufftype.overlaymult then
        -- 每一个伤害单独计算，但给客户端的消息是叠加的
        -- 如果到了上限就不再增加了
        if getoverlaymult_level(buffid, recver) >= getlevellimit(buffid) then
            return
        end
        buffinfo = newbuffinfo(curturnlong, buffid, caster, recver)
        table.insert(battlebuffinfos, buffinfo)
        local curlevel = getoverlaymult_level(buffid, recver)
        buffsync(recver, buffid, true, curlevel)
    elseif bufftype == buffdefine.battlebufftype.overlaysingle then
        -- 叠加
        local newjumpnum = math.floor(getbuffduring(buffid) * getroundspeed(buffid) / 10000)
        buffinfo.jumpnum = buffinfo.jumpnum + newjumpnum

        if buffinfo.level < getlevellimit(buffid) then
            buffinfo.level = buffinfo.level + 1
        end

        buffsync(recver, buffid, true, buffinfo.level)
    elseif bufftype == buffdefine.battlebufftype.switch then
        self:delbuffinfo(buffid, recver)
        buffsync(recver, buffid, false, 0)
    end
end

---@param buffid integer buffid
---@param recver integer 施放者
function battlebuffhandler:delbuffinfo(buffid, recver)
    local buffindex = getbuffinfo(buffid, recver)
    if buffindex then
        table.remove(battlebuffinfos, buffindex)
    end
end

return battlebuffhandler.new()