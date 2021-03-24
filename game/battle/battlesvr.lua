local skynet = require "skynet"
local snax = require "skynet.snax"
local errCodeDef = require "errcodedef"
local sharedata = require "skynet.sharedata"
local Random = require "random"
local json = require "cjson"
local battledatahandler = require("game.battle.battledatahandler")
local battlebuff = require("game.battle.battlebuffhandler")
local timext = require "timext"

local machineinfo_dc
local machinecfg_dc
local player_dc
local equipment_dc
local user_dc
local skill_dc
local score_dc
local info_dc
local chipattribute_dc
local achievement
local player_pos_y                  -- 记录玩家位置，只用于计算能量。 使用配置表位置可能会不同步

local isfinish = false
local roomtype                    -- 房间类型, pvp：1，2，3
local stagetype                     -- 关卡类型, teammatchdefine.missiontype
local tmpstageid = 0                -- 地图id
local socket_main
local battleroom_num            --当前ue战斗房间数量

local battle_machine_infos = {}    -- 玩家机甲信息   {{}, {}, ...}
local battle_attribute_infos = {}   -- 玩家属性信息  {uid={}, uid={}, ...}
local birthpointinfo = {}           -- 玩家出生点信息
local deathlist = {}              -- 已死亡玩家列表，每死一个加一个 {uid, uid, uid, ...}
local tempfighters = {}
local npcid = -1                    -- NPC辨识id, 累减， 避免与玩家uid重复
local damageparam = 1             -- 伤害乘以的系数，激光炮蓄力用

local playerchipattr = {}            --玩家芯片加成 {uid = {machineattris = {k=v,k=v...}, weaponattris = *weaponattris}}
local playerchipattrret = {}         --保存向客户端发送的芯片属性信息 playerchipattr数据为转换之后方便服务端查询的结构
--[[
["weaponattris"] = {
    [1] = {
        [1] = {
            ["val"] = 10000.0,     --10000为被动技能
            ["buffid"] = 10003,
        }
    }
    [2] = {
    }
    [3] = {
    }
}
["machineattris"] = {
    [1] = {
        ["val"] = 10001.0,          --10001为主动技能
        ["buffid"] = 10001,
    }
}
--]]

local last_roll_energy = {}          -- 上次轮转行动剩余的能量
local curturnlong = 0              -- 当前回合长度，更新buff用

local isbegincheck = false         -- 是否所有人都加载完flag
local isstart = false              -- 是否已开始战斗flag，打断递归
local is_turn_ended = true         -- 是否已主动结束回合

local pausingtime = 0               -- 暂停时间

local turn_check_count = 0             -- 最多轮询 Stage.End_Round/2 次
local curturns = 0                 -- 当前回合数
local maxturns = 0                 -- 回合上限
local curmovers_group = 0             -- 当前行动者的组id
local curgroup_turn = {}                 -- 当前行动组的是否回合结束状态. { uid = true, uid = true, ... }
local groupinfo = {}                -- 群组关系，{waveid={uid, uid, uid...}}
local curweapon = {}                  -- 正在飞行的武器数据，以第一个发过来的数据来更新爆炸点  
                                      --  {weaponid=10001, explodepos={x=1.00,y=1.00,z=1.00}}

local loadingstatus = {}            --{uid = true, uid...}
local isallskiped = false
local skipstatus = {}             -- 是否所有人都跳过对话flag
local wind_amplitude = 0.3            -- 风力振幅

local targetcount = 0                   -- 过关目标值
local cur_mission_progress = 0            -- 当前过关进度计数
local per_turn_birth_npc = {}           -- 每回合刷的npc { 10005: 次数, ... }
local per_roll_birth_npc = {}           -- 每轮转刷的npc
local battle_trigger_areainfos = {}        -- 可触发区域信息
local fresh_npc_queue = {}              -- 链式刷怪队列

local battledata = {}                    -- {uid = {kill = {uid, uid}, harm = 1500, defense = 1500}
local battleparmdata = {}               --战斗中要统计的值，先保存在结算页面进行数据库同步 k.v形式

function init()
	user_dc = snax.queryservice("userdc")
    machineinfo_dc = snax.queryservice("machineinfodc")
    machinecfg_dc = snax.queryservice("machinecfgdc")
    player_dc = snax.queryservice("playerattributedc")
    equipment_dc = snax.queryservice("equipmentdc")
    skill_dc = snax.queryservice("skilldc")
    score_dc = snax.queryservice("scoredc")
    chipattribute_dc = snax.queryservice("chipattributedc")
    achievement = snax.queryservice("achievement")
    info_dc = snax.queryservice("infodc")
end

function exit()
end

--- 读表分配出生点
local function setbirthpoint(fighters)
    -- 位置表以YZ数组表示玩家位置，从左至右共12组位置，标号1至12
    -- 1至6组属于A组随机位置，7至12组为B组随机位置
    -- 1V1时，A组在3-4组随机取1个，B组在9-10组随机取1个
    -- 2V2时，A组在2-5组随机取2个，B组在8-11组随机取2个
    -- 3V3时，A组在1-6组随机取3个，B组在7-12组随机取3个
    local playernum = #fighters
    local interval = playernum/2
    local birthpoint = sharedata.deepcopy( "beginningposition", tmpstageid)   -- todo 地图id先写死
    local a = 3 - ( interval - 1 )
    local b = 3 + interval
    local c = 9 - ( interval - 1 )
    local d = 9 + interval
    local frontbps = {}
    local backbps = {}

    -- 扔硬币决定前后组
    local ranbool = math.random(0, 1)

    if ranbool == 1 then
        a, c = c, a
        b, d = d, b
    end

    for i = a, b do
        local temppos = {}
        temppos.x = birthpoint.X
        temppos.y = birthpoint.Y_Z[ 2*i - 1]
        temppos.z = birthpoint.Y_Z[ 2*i ]
        table.insert(frontbps, temppos)
    end

    for i = c, d do
        local temppos = {}
        temppos.x = birthpoint.X
        temppos.y = birthpoint.Y_Z[ 2*i - 1]
        temppos.z = birthpoint.Y_Z[ 2*i ]
        table.insert(backbps, temppos)
    end

    -- 打乱顺序
    frontbps = table.shuffle(frontbps)
    backbps = table.shuffle(backbps)

    for i = 1, playernum/2 do
        birthpointinfo[fighters[i]] = frontbps[i]
    end

    for i = interval + 1, playernum do
        birthpointinfo[fighters[i]] = backbps[i - playernum/2]
    end
end

-- 编组, 不传groupid的话则新建组
local function add_to_group(playerid, groupid)
    groupid = groupid or (#groupinfo + 1)
    if not groupinfo[groupid] then
        groupinfo[groupid] = {}
    end

    table.insert(groupinfo[groupid], playerid)
end

-- 从组中移除
local function remove_from_group(playerid, groupid)
    table.remove(groupinfo[groupid], table.indexof(groupinfo[groupid], playerid))
    -- if #groupinfo[groupid] == 0 then
    --     table.remove(groupinfo, groupid)
    -- end
end

--- 在组中查询
--- @return integer 返回所在组编号
local function getgroupid(playerid)
    for groupid, groupmembers in pairs(groupinfo) do
        if table.find(groupmembers, playerid) then
            return groupid            
        end
    end
    return 0
end

--- 获取用户名
local function getusername(uid)
    if uid < 0 then
        local npc = sharedata.deepcopy( "npc", battle_attribute_infos[uid].npccfgid)
        return npc.Name
    end
    return user_dc.req.getvalue(uid,"name")
end

--- pve模式下玩家的出生点
local function setbirthpoint_pve(fighters, stageid)
    local birthpoint = sharedata.deepcopy( "beginningposition", stageid)
    local bps = {}

    for i = 1, #fighters do
        local temppos = {}
        temppos.x = birthpoint.X
        temppos.y = birthpoint.Y_Z[ 2*i - 1]
        temppos.z = birthpoint.Y_Z[ 2*i ]
        table.insert(bps, temppos)
    end

    bps = table.shuffle(bps)

    for i = 1, #fighters do
        birthpointinfo[fighters[i]] = bps[i]
    end
end

--- 根据uid返回该玩家当前底盘id,等级
local function getchassis(uid)
    local ret = {}
    for i = 1, #battle_machine_infos do
        if uid == battle_machine_infos[i].playerid then
            ret = table.clone(battle_machine_infos[i].chassis)
        end
    end
    return ret
end

--- 机体
local function getbody(uid)
    local ret = {}
    for i = 1, #battle_machine_infos do
        if uid == battle_machine_infos[i].playerid then
            ret = table.clone(battle_machine_infos[i].body)
        end
    end
    return ret
end

--- 武器
local function getweapons(uid)
    local ret = {}
    for i = 1, #battle_machine_infos do
        if uid == battle_machine_infos[i].playerid then
            ret = table.clone(battle_machine_infos[i].weapons)
        end
    end
    return ret
end

--- 火控
local function getfirecontroller(uid)
    local ret = {}
    for i = 1, #battle_machine_infos do
        if uid == battle_machine_infos[i].playerid then
            ret = table.clone(battle_machine_infos[i].firecontroller)
        end
    end
    return ret
end

--- 获取玩家原始速度值
local function getspeed(uid)
    if uid < 0 then
        local chassis = sharedata.deepcopy( "machinechassis", getchassis(uid)[1])
        return chassis.Round_Speed
    end
    
    return tonumber(player_dc.req.getvalue(uid, "speed"))
end

--- 获取玩家原始引擎效率值
local function getefficiency(uid)
    if uid < 0 then
        local chassis = sharedata.deepcopy( "machinechassis", getchassis(uid)[1])
        return chassis.engine_efficiency
    end
    
    return tonumber(player_dc.req.getvalue(uid, "efficiency"))
end

--- 获取玩家原始底盘爬角值
local function getclimbingangle(uid)
    if uid < 0 then
        local chassis = sharedata.deepcopy( "machinechassis", getchassis(uid)[1])
        return chassis.Chassis_Creeping_Angle
    end
    
    return tonumber(player_dc.req.getvalue(uid, "climbingangle"))
end

--- 获取玩家原始生命值
local function gethp(uid)
    if uid < 0 then
        local body = sharedata.deepcopy( "machinebody", getbody(uid)[1])
        return body.Hp
    end

    return tonumber(player_dc.req.getvalue(uid, "life"))
end

--- 获取玩家原始护盾值
local function getshield(uid)
    if uid < 0 then
        local body = sharedata.deepcopy( "machinebody", getbody(uid)[1])
        return body.Sheld_Value
    end

    return tonumber(player_dc.req.getvalue(uid, "shield"))
end

--- 获取玩家原始能量值
local function getenergy(uid)
    if uid < 0 then
        local body = sharedata.deepcopy( "machinebody", getbody(uid)[1])
        return body.Power_Value
    end

    return tonumber(player_dc.req.getvalue(uid, "energy"))
end

--- 获取玩家原始仰角值
local function getelevation(uid)
    if uid < 0 then
        local body = sharedata.deepcopy( "firecontrol", getfirecontroller(uid)[1])
        return body.Attack_Angle_Max
    end

    return tonumber(player_dc.req.getvalue(uid, "elevation"))
end

--- 获取玩家原始俯角值
local function getoverhang(uid)
    if uid < 0 then
        local body = sharedata.deepcopy( "firecontrol", getfirecontroller(uid)[1])
        return body.Attack_Angle_Min
    end

    return tonumber(player_dc.req.getvalue(uid, "overhang"))
end

--- 获取玩家原始能量效率值
local function getenefficiency(uid)
    if uid < 0 then
        local body = sharedata.deepcopy( "firecontrol", getfirecontroller(uid)[1])
        return body.Power_Efficiency
    end

    return tonumber(player_dc.req.getvalue(uid, "enefficiency"))
end

--- 获取能量回复值
local function get_power_restore(uid)
    local body = sharedata.deepcopy( "machinebody", getbody(uid)[1])
    return body.Power_Restore
end

--- 获取上轮转的能量以计算消耗
---@param energy integer 当前能量值
local function get_enengy_cost(uid, energy)
    if uid < 0 or stagetype == teammatchdefine.missiontype.tutorial then
        return 0
    end

    if not last_roll_energy[uid] then
        last_roll_energy[uid] = energy
        return getenergy(uid) - energy
    end
    -- skynet.error(uid, last_roll_energy[uid], get_power_restore(uid), energy)
    return last_roll_energy[uid] - energy
end

--- 读表获得武器普通开火的能量值消耗
local function get_weapon_fireenergy(weaponid)
    local weapon = sharedata.deepcopy( "weapontable", weaponid)
    return weapon.Power_Consume
end

--- 读表获得使用技能的能量值消耗
local function get_skill_energycost(skillid)
    local skill = sharedata.deepcopy("skill", skillid)
    return skill.Power_Consume
end

--- 传一个差值来更新能量值, 返回扣除后的当前能量值
local function update_energy(uid, addval)
    battle_attribute_infos[uid].energy = math.ceil(math.clamp(battle_attribute_infos[uid].energy + addval, 0, getenergy(uid)))
    return battle_attribute_infos[uid].energy
    -- for k, _ in pairs(battle_attribute_infos) do
    --     if k == uid then
    --         battle_attribute_infos[k].energy = math.clamp(battle_attribute_infos[k].energy + addval, 0, getenergy(uid))
    --         return battle_attribute_infos[k].energy
    --     end
    -- end
end

-- --- 计算行动者顺序
-- local function caculatemover()
--     for k, v in pairs(battle_attribute_infos) do
--         local uid = k
--         if curmovers_group == getgroupid(uid) then
--             -- todo 前回合占用长度+100*（回合长度 /回合速度参数）+能量消耗
            
--             -- skynet.error(uid, "old speed: ", v.speed)
--             local energycost = math.max(0, get_enengy_cost(uid, v.energy)) 
--             local speed = ((10000 / getspeed(uid)) + energycost)
--             v.speed = v.speed + speed
--             -- skynet.error(uid, "new speed: ", v.speed)
--         end
--     end
--     local ret = {}
--     -- 表单模式排序
--     local attilist = table.values(battle_attribute_infos)
--     -- 死者另外算

--     if attilist ~= nil then
--         for i = #attilist, 1, -1 do
--             if attilist[i].hp <= 0.001 then
--                 table.remove(attilist, i)
--             end
--         end
--     end

--     table.sort(attilist, function(a,b)
--         -- 相等时给随机一方加个千分浮点数
--         if a.speed == b.speed then
--             if math.random(0, 1) == 1 then
--                 a.speed = (a.speed + math.random(1, 10)/1000)
--             else
--                 b.speed = (b.speed + math.random(1, 10)/1000)
--             end
--         end
--         return a.speed<b.speed 
--     end )

--     -- 给第一个补充能量
--     if next(attilist) then
--         update_energy(attilist[1].playerid, get_power_restore(attilist[1].playerid))
--     end

--     for i = 1, #attilist do
--         ret[i] = { playerid = attilist[i].playerid, 
--                 turnlong = attilist[i].speed, 
--                 groupid = getgroupid(attilist[i].playerid), 
--                 energy = attilist[i].energy}
--     end

--     -- 死者尾插
--     for i = 1, #deathlist do
--         table.insert(ret, { playerid = deathlist[i], turnlong = -1, groupid = 0 })
--     end

--     return ret
-- end

local function roll_end_stop_move(uid)
    local ret ={}
    ret.playerid = uid

    ret.remainenergy = battle_attribute_infos[uid].energy   
    ret.location = battle_attribute_infos[uid].pos
    ret.movestate = 0

    for i = 1, #tempfighters do
        send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_onmove")
    end
end

-- local function getwind()
--     local wind = wind_amplitude * math.sin(0.75 * math.sqrt(2) * timext.current_time() + 1/8)
--     local ret = wind - wind%0.01
--     return ret
-- end

local function get_weapon_type(weaponid)
    local weapon = sharedata.deepcopy( "weapontable", weaponid)
    return weapon.Weapon_Type
end

--- 传一个组id进来，获取该组的所有成员
local function get_allmover_bygid(groupid)
    if not groupinfo[groupid] then
        return {}
    end

    return table.clone(groupinfo[groupid])
end

-- -- 清空curgroup_turn
-- local function clear_curgroup_turn()
--     curgroup_turn = {}
-- end

---@param istrigger boolean 是否初始化时，不是的话会再告诉客户端该生成了
---@param aigroupid integer 触发者的uid
local function spawnnpc(aigroupid, istrigger)
    local aigroup = sharedata.deepcopy( "ai_group", aigroupid)
    local allnpc = sharedata.deepcopy( "npc")
    local groupid = #groupinfo + 1
    for j = 1, #aigroup.ID_YZ, 3 do
        local tempnpcdata = {}
        local npccfgid = aigroup.ID_YZ[j]
        local npcdata = allnpc[npccfgid]
        tempnpcdata.body = {npcdata.Body, 1}    
        tempnpcdata.chassis = {npcdata.Chassis, 1}
        tempnpcdata.firecontroller = {npcdata.Firecontrol, 1}
        tempnpcdata.weapons = {}

        for i = 1, #npcdata.Weapon do
            table.insert(tempnpcdata.weapons, npcdata.Weapon[i])
            table.insert(tempnpcdata.weapons, 1)
        end

        tempnpcdata.name = npcdata.Name
        tempnpcdata.playerid = npcid
        tempnpcdata.npccfgid = npccfgid

        local temppos = {}
        temppos.x = aigroup.X
        temppos.y = aigroup.ID_YZ[j + 1]
        temppos.z = aigroup.ID_YZ[j + 2]
        tempnpcdata.pos = temppos
        add_to_group(npcid, groupid)
        tempnpcdata.groupid = getgroupid(npcid)

        table.insert(battle_machine_infos, tempnpcdata)
        local weaponcfg = sharedata.deepcopy("weapontable", tempnpcdata.weapons[1])
        if weaponcfg == nil then
            skynet.error("weapontable not find", tempnpcdata.weapons[1])
        end

        -- 根据装备信息计算属性
        battle_attribute_infos[npcid] = {
            playerid = npcid,
            atk = weaponcfg.Base_Damage,                    --攻击力              
            scopeatk = weaponcfg.Damage_Rad,               --伤害范围               
            distance = weaponcfg.InitialSpeedMax,               --攻击距离参数修改  
            hp = gethp(npcid),
            speed = 10000 / getspeed(npcid),
            energy = getenergy(npcid),
            shield = getshield(npcid),
            elevation = getelevation(npcid),              --仰角
            overhang = getoverhang(npcid),               --俯角
            enefficiency = getenefficiency(npcid),           --能量效率
            efficiency = getefficiency(npcid),             --引擎效率
            climbingangle = getclimbingangle(npcid),          --底盘爬角
            pos = temppos,
            npccfgid=npccfgid,
        }

        if istrigger then
            local msg = {}
            battle_attribute_infos[npcid].speed = curturns * 100
            msg.playerattribute = battle_attribute_infos[npcid]
            msg.playerlistinfo = tempnpcdata

            for i = 1, #tempfighters do
                send_request(get_user_fd(tempfighters[i]), msg, "battleproxy_spawnnpc")
            end
        end

        battledata[npcid] = {}
        battledata[npcid].kill = {}
        loadingstatus[npcid] = true
        skipstatus[npcid] = true
        npcid = npcid - 1
    end
end

-- 根据刷怪类型枚举做不同处理
---@param birthtype define
local function addnpc(aigroupid, birthtype)
    if birthtype == battledefine.npcfreshtype.perturn then
        if per_turn_birth_npc[aigroupid] then
            per_turn_birth_npc[aigroupid] = per_turn_birth_npc[aigroupid] + 1
        else
            per_turn_birth_npc[aigroupid] = 1
        end
    elseif birthtype == battledefine.npcfreshtype.perroll then
        if per_roll_birth_npc[aigroupid] then
            per_roll_birth_npc[aigroupid] = per_roll_birth_npc[aigroupid] + 1
        else
            per_roll_birth_npc[aigroupid] = 1
        end
    elseif birthtype == battledefine.npcfreshtype.areatrigger then
        -- todo 暂时废弃
    elseif birthtype == battledefine.npcfreshtype.linkedlist then
        -- 每刷一只就把第一个移除，下次再刷第一个
        table.insert(fresh_npc_queue, aigroupid)
    else
        spawnnpc(aigroupid)
    end
end

-- 生成可触发区域
local function spwanarea(areaid, pos, aigroupid, trigger)
    local temp_areadata = {}
    temp_areadata.pos = pos
    temp_areadata.index = #battle_trigger_areainfos + 1
    temp_areadata.triggered = false
    temp_areadata.cfgid = areaid
    temp_areadata.aigroupid = aigroupid
    temp_areadata.hostuid = 0                 -- 宿主uid，姑且认为宿主只会有一个
    temp_areadata.withnpc = 0                   -- 尼哥npc
    temp_areadata.curturnlong = curturnlong
    temp_areadata.caster = trigger or 0
    table.insert(battle_trigger_areainfos, temp_areadata)

    if trigger then
        local msg = {}
        msg.areainfo = {}
        msg.areainfo.pos = pos
        msg.areainfo.index = temp_areadata.index
        msg.areainfo.cfgid = areaid
        msg.areainfo.length = curturnlong - curturns * 100

        for i = 1, #tempfighters do
            send_request(get_user_fd(tempfighters[i]), msg, "battleproxy_addarea")
        end
    end
end


---@param pos table x=1, y=2, z=3
---@param trigger integer  触发生成这个圈的玩家id，没有则不生成
local function addarea(areaid, pos, trigger)
    local trigger_area_cfgs = sharedata.deepcopy( "trigger_area", areaid)
    local aigroupids = trigger_area_cfgs.AI_Group

    -- buff圈
    if #aigroupids == 0 then
        spwanarea(areaid, pos, 0, trigger)
        return
    end

    for i = 1, #aigroupids do
        local aigroupid = aigroupids[i]
        local aigroup = sharedata.deepcopy( "ai_group", aigroupid)

        for j = 1, #aigroup.ID_YZ, 3 do
            spwanarea(areaid, pos, aigroupid, trigger)
        end  
    end
end


local function shield_cal(damage, shield, shieldparam)
    -- skynet.error("damage: ", damage, shield, shieldparam)
    LOG_INFO(string.format("damage: %s %s %s", damage, shield, shieldparam))
    if shield < 0.001 then
        return false, damage
    end

    if damage*shieldparam < shield  then
        return true, damage*shieldparam
    else
        return false, (damage*shieldparam - shield) / shieldparam
    end
end

-- -- 通用的基础伤害计算
-- ---@param base_damage 基础伤害
-- ---@param body_damage 真实伤害
-- local function get_common_damage(playerid, base_damage, body_damage)
--     local ret = {}
--     local body_damage = body_damage or 0
--     local body = sharedata.deepcopy("machinebody", getbody(playerid)[1])
--     base_damage = base_damage or 0

--     LOG_INFO("0000000000000000000000000: %s", tostring(battle_attribute_infos))

--     local is_shield_alive, damage = shield_cal(base_damage, battle_attribute_infos[playerid].shield, 0.5)
--     if is_shield_alive then
--         battle_attribute_infos[playerid].shield = math.floor(math.clamp(battle_attribute_infos[playerid].shield - damage, 
--                                                             0, battle_attribute_infos[playerid].shield))
            
--     else
--         battle_attribute_infos[playerid].shield = 0
--         body_damage = damage * body.Body_Damage
--     end

--     battle_attribute_infos[playerid].hp = math.floor(math.clamp(battle_attribute_infos[playerid].hp - body_damage, 
--                                                             0, battle_attribute_infos[playerid].hp))
--     ret.playerid = playerid
--     ret.hp = battle_attribute_infos[playerid].hp
--     ret.shield = battle_attribute_infos[playerid].shield
--     ret.energy = battle_attribute_infos[playerid].energy
--     return ret
-- end

-- local function settle_area_info()
--     if #battle_trigger_areainfos == 0 then
--         return {}
--     end

--     local onturn_area_indexs = {}
--     for i = 1, #battle_trigger_areainfos do
--         if battle_trigger_areainfos[i].curturnlong <= curturnlong then
--             table.insert(onturn_area_indexs, i)
--         end
--     end

--     for i = 1, #onturn_area_indexs do
--         battle_trigger_areainfos[onturn_area_indexs[i]].curturnlong = battle_trigger_areainfos[onturn_area_indexs[i]].curturnlong + 100
--     end

--     local trigger_area_cfgs = sharedata.deepcopy( "trigger_area")
--     for i = #battle_trigger_areainfos, 1, -1 do
--         local area_cfgid = battle_trigger_areainfos[i].cfgid

--         if battle_trigger_areainfos[i].curturnlong > trigger_area_cfgs[area_cfgid].During and trigger_area_cfgs[area_cfgid].During ~= 0 then
--             for j = 1, #tempfighters do
--                 send_request(get_user_fd(tempfighters[j]), { areaindex = battle_trigger_areainfos[i].index }, "battleproxy_delarea")
--             end

--             table.remove(battle_trigger_areainfos, i)
--         end
--     end
    
--     -- skynet.error("结算后的areainfo:", tostring(battle_trigger_areainfos))
-- end

--- 更新成就记录
local function updateachieve_pvp(uid, iswin)
    -- if roomtype == teammatchdefine.eroomtype.single then
    -- elseif roomtype == teammatchdefine.eroomtype.double then
    -- elseif roomtype == teammatchdefine.eroomtype.trible then
    -- end
    if iswin then 
        if roomtype == teammatchdefine.eroomtype.single then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.kill_pvp1)
        elseif roomtype == teammatchdefine.eroomtype.double then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.kill_pvp2, nil, 2)
        elseif roomtype == teammatchdefine.eroomtype.trible then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.kill_pvp3, nil, 3)
        end
        achievement.req.updateathletics(uid, achievementdefine.achievetype.winnumber_pvp)
        achievement.req.updateathletics(uid, achievementdefine.achievetype.serieswin_pvp)
    else
        if roomtype == teammatchdefine.eroomtype.single then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.death_pvp1)
        elseif roomtype == teammatchdefine.eroomtype.double then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.death_pvp2, nil, 1)
        elseif roomtype == teammatchdefine.eroomtype.trible then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.death_pvp3, nil, 1)
        end
        achievement.req.updateathletics(uid, achievementdefine.achievetype.serieswin_pvp, nil, 0, true)
    end
    achievement.req.updateathletics(uid, achievementdefine.achievetype.maxnumber_pvp)
end

--- 更新成就记录
local function updateachieve_pve(uid, iswin)
    -- if roomtype == teammatchdefine.eroomtype.single then
    -- elseif roomtype == teammatchdefine.eroomtype.double then
    -- elseif roomtype == teammatchdefine.eroomtype.trible then
    -- end
    if iswin then 
        if roomtype == teammatchdefine.eroomtype.single then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.kill_pve1, nil, targetcount)
        elseif roomtype == teammatchdefine.eroomtype.double then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.kill_pve2, nil, targetcount)
            if battleparmdata[achievementdefine.achievetype.towkill] then
                achievement.req.updateathletics(uid, achievementdefine.achievetype.towkill)
            end
        elseif roomtype == teammatchdefine.eroomtype.trible then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.kill_pve3, nil, targetcount)
        end
        achievement.req.updateathletics(uid, achievementdefine.achievetype.winnumber_pve)
        achievement.req.updateathletics(uid, achievementdefine.achievetype.serieswin_pve)
    else
        if roomtype == teammatchdefine.eroomtype.single then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.death_pve1)
        elseif roomtype == teammatchdefine.eroomtype.double then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.death_pve2, nil, 1)
        elseif roomtype == teammatchdefine.eroomtype.trible then
            achievement.req.updateathletics(uid, achievementdefine.achievetype.death_pve3, nil, 1)
        end
        achievement.req.updateathletics(uid, achievementdefine.achievetype.serieswin_pve, nil, 0, true)
    end
    achievement.req.updateathletics(uid, achievementdefine.achievetype.maxnumber_pve)
end

---玩家数据更新
local function update_score(winidarr)
    if winidarr == nil or not next(winidarr) then
        return
    end
    local score, timescore
    -- pvp模式
    if stagetype == teammatchdefine.missiontype.pvp then
        for i = 1, #tempfighters do
            local userinfo = score_dc.req.get(tempfighters[i])
            score = math.floor(userinfo.score)
            timescore =  (9999999999 - tonumber(string.sub(timext.current_time(), 1, 10)))
            if table.find(winidarr, tempfighters[i]) then
                score_dc.req.setvalue(tempfighters[i], "score", math.max(0, tonumber(score + 100 ..".".. timescore)))
                -- score_dc.req.update({id = tempfighters[i], score = math.max(0, tonumber(score + 100 ..".".. timescore)), 
                --                     maxnumber = userinfo.maxnumber + 1, winnumber = userinfo.winnumber + 1, supportnum = userinfo.supportnum})
                do_redis({"zadd", "ladder", tonumber(score + 100 ..".".. timescore), tempfighters[i]}, tempfighters[i])

                updateachieve_pvp(tempfighters[i], true)
            else
                score_dc.req.setvalue(tempfighters[i], "score", math.max(0, tonumber(score - 100 ..".".. timescore)))
                do_redis({"zadd", "ladder", tonumber(score - 100 ..".".. timescore), tempfighters[i]}, tempfighters[i])
                
                updateachieve_pvp(tempfighters[i], false)
            end
        end
        achievement.req.updateathletics(battleparmdata[achievementdefine.achievetype.killall_pvp2], achievementdefine.achievetype.killall_pvp2)
        achievement.req.updateathletics(battleparmdata[achievementdefine.achievetype.first_pvp2], achievementdefine.achievetype.first_pvp2)

        --[[检测是否全部存活]]
        local isnodie = true
        for i = 1, #winidarr do
            if table.find(deathlist, winidarr[i]) then
                isnodie = false
                return
            end
        end
        if isnodie then
            for i = 1, #winidarr do
                if roomtype == teammatchdefine.eroomtype.double then
                    achievement.req.updateathletics(winidarr[i], achievementdefine.achievetype.killall_pvp2)
                elseif roomtype == teammatchdefine.eroomtype.trible then
                    achievement.req.updateathletics(winidarr[i], achievementdefine.achievetype.killall_pvp3)
                end
            end
        end

        achievement.req.updateathletics(battleparmdata[achievementdefine.achievetype.killall_pvp3], achievementdefine.achievetype.killall_pvp3)
        achievement.req.updateathletics(battleparmdata[achievementdefine.achievetype.first_pvp3], achievementdefine.achievetype.first_pvp3)
        achievement.req.updateathletics(battleparmdata[achievementdefine.achievetype.double_pvp3], achievementdefine.achievetype.double_pvp3)
    elseif stagetype == teammatchdefine.missiontype.annihilate then
        for i = 1, #tempfighters do
            if table.find(winidarr, tempfighters[i]) then
                updateachieve_pve(tempfighters[i], true)
            else
                updateachieve_pve(tempfighters[i], false)
            end
        end
        local isnodie = true
        for i = 1, #winidarr do
            if table.find(deathlist, winidarr[i]) then
                isnodie = false
                return
            end
        end
        if isnodie then
            for i = 1, #winidarr do
                if roomtype == teammatchdefine.eroomtype.double then
                    achievement.req.updateathletics(winidarr[i], achievementdefine.achievetype.killall_pvp2)
                elseif roomtype == teammatchdefine.eroomtype.trible then
                    achievement.req.updateathletics(winidarr[i], achievementdefine.achievetype.killall_pvp3)
                end
            end
        end
    end
end

-- 判断是否死亡
local function deathjudge(damageinfo, uid)
    local issbdead, isdouble = false, false   --用来记录双杀
    for i = 1, #damageinfo do
        if damageinfo[i].hp < 0.01 then
            if table.find(deathlist, damageinfo[i].playerid) == nil then
                table.insert(deathlist, damageinfo[i].playerid)
            else
                goto continue
            end
            table.insert(battledata[uid].kill, damageinfo[i].playerid)

            if stagetype == teammatchdefine.missiontype.pvp then
                if isdouble then
                    battleparmdata[achievementdefine.achievetype.towkill] = 1
                end
                isdouble = true
              
                local des = math.floor(math.sqrt(math.pow((battle_attribute_infos[uid].pos.y - battle_attribute_infos[damageinfo[i].playerid].pos.y), 2)
                + math.pow((battle_attribute_infos[uid].pos.x - battle_attribute_infos[damageinfo[i].playerid].pos.x), 2)))
                
                achievement.req.updateathletics(uid, achievementdefine.achievetype.killdes, nil, des, false)
                achievement.req.updateathletics(uid, achievementdefine.achievetype.killhp, nil, battle_attribute_infos[uid].hp, false, false)
                
                if roomtype == teammatchdefine.eroomtype.single then
                elseif roomtype == teammatchdefine.eroomtype.double then
                    if #battledata[uid].kill == 2 then
                        battleparmdata[achievementdefine.achievetype.killall_pvp2] = uid
                    end
                    if not battleparmdata[achievementdefine.achievetype.first_pvp2] then
                        battleparmdata[achievementdefine.achievetype.first_pvp2] = uid
                    end
                elseif roomtype == teammatchdefine.eroomtype.trible then
                    if #battledata[uid].kill == 3 then
                        battleparmdata[achievementdefine.achievetype.killall_pvp3] = uid
                    elseif #battledata[uid].kill == 2 then
                        battleparmdata[achievementdefine.achievetype.double_pvp3] = uid
                    end
                    if not battleparmdata[achievementdefine.achievetype.first_pvp3] then
                        battleparmdata[achievementdefine.achievetype.first_pvp3] = uid
                    end
                end
            end

            local deathmsg = {}
            deathmsg.playerid = damageinfo[i].playerid
            deathmsg.killid = uid

            if damageinfo[i].playerid > 0 then
                issbdead = true
            end

            for i = 1, #tempfighters do
                send_request(get_user_fd(tempfighters[i]), deathmsg, "battleproxy_ondeath")
            end

            for i = 1, #battle_trigger_areainfos do
                if deathmsg.playerid == battle_trigger_areainfos[i].hostuid then
                    per_turn_birth_npc[battle_trigger_areainfos[i].withnpc] = nil
                    cur_mission_progress = cur_mission_progress + 1
                end
            end

            if getgroupid(damageinfo[i].playerid) ~= 0 then
                remove_from_group(damageinfo[i].playerid, getgroupid(damageinfo[i].playerid))
            end

        end
        ::continue::
    end

    if issbdead then
        pausingtime = 500
    end


    local result, winidarr
    if not isfinish then
        result, winidarr = battledatahandler:judge_battle_end(tempfighters, deathlist, tmpstageid, targetcount, cur_mission_progress) 
    end

    if result then
        update_score(winidarr)
        isfinish = true
    end
end


-- 战斗递归循环
local function battleloop()
    -- --暂停时间
    -- if pausingtime > 0 then
    --     skynet.timeout(50, battleloop)
    --     pausingtime = pausingtime - 50
    --     return
    -- end

    if isfinish then
        local battleproxy = snax.queryservice("battleproxy")
        battleproxy.req.battlefinish(skynet.self(), battledata)
        skynet.exit()
        return
    end

    -- local stage = sharedata.deepcopy( "stage", tmpstageid)
    -- local turn_limit = stage.Round_Timeing / 2

    -- -- 关卡限制为0时则 玩家不结束回合永远不结束
    -- if turn_limit == 0 then
    --     turn_check_count = -1
    -- end
    -- -- 教学关卡
    -- if is_turn_ended == false and turn_check_count < turn_limit then
    --     turn_check_count = turn_check_count + 1
    --     skynet.timeout(200, battleloop)
    --     return
    -- end

    -- --超过最大回合，全部失败
    -- if maxturns > 0 and curturns >= maxturns then
    --     local winmsg = {}
    --     winmsg.playerid = {}
    --     LOG_INFO("----------------------winmsg: %s", tostring(winmsg))
    --     for i = 1, #tempfighters do
    --         send_request(get_user_fd(tempfighters[i]), winmsg, "battleproxy_winner")
    --     end
    --     isfinish = true
    --     battleloop()
    --     return
    -- end

    -- LOG_INFO("battleloop------ %s, %s, %s", is_turn_ended, turn_check_count, tostring(curweapon))
    -- -- roll_end_stop_move(curmover)
    -- local msg = {}
    
    -- -- 计算行动者
    -- msg.turninfo = caculatemover()
    -- local buffinfo = battlebuff:getbattlebuffinfos()

    -- local damagingbuff_indexs = battlebuff:get_damaging_buff(msg.turninfo[1].turnlong)

    -- for i = 1, #damagingbuff_indexs do
    --     local buffid = buffinfo[damagingbuff_indexs[i]].buffid 
    --     local buffdmsg = {}
    --     buffdmsg.damageinfo = {}

    --     buffdmsg.playerid = buffinfo[damagingbuff_indexs[i]].recver
    --     local buffdamage = battlebuff:getbuffdamage(buffid)
    --     local level = buffinfo[damagingbuff_indexs[i]].level
    --     -- 根据层数计算伤害的情况
    --     if level > 1 then
    --         local bufftype = sharedata.deepcopy("buff", buffid).BUFF_Type
    --         if bufftype == buffdefine.battlebufftype.overlaysingle then
    --             buffdamage = level * buffdamage
    --         end
    --     end

    --     local tempattri = get_common_damage(buffdmsg.playerid, buffdamage)
    --     deathjudge({tempattri}, buffdmsg.playerid)
    --     buffdmsg.damageinfo.hp = tempattri.hp
    --     buffdmsg.damageinfo.playerid = tempattri.playerid
    --     buffdmsg.damageinfo.shield = tempattri.shield        
        
    --     for j = 1, #tempfighters do
    --         send_request(get_user_fd(tempfighters[j]), buffdmsg, "battleproxy_buffdamage")
    --     end
    -- end

    -- battlebuff:onsettledbuff(damagingbuff_indexs)
    -- settle_area_info()

    -- curturnlong = msg.turninfo[1].turnlong
    -- local mover = msg.turninfo[1].playerid
    -- clear_curgroup_turn()
    -- curmovers_group = getgroupid(mover)

    -- local allmover = get_allmover_bygid(curmovers_group)
    -- for i = 1, #allmover do
    --     curgroup_turn[allmover[i]] = false
    -- end
    -- -- 当前最小值玩家是否小于等于回合长度
    -- if msg.turninfo[1].turnlong > curturns * 100 then
    --     curturns = curturns + 1
    --     local turnmsg = {}
    --     turnmsg.curturn = curturns
    --     -- 风力计算
    --     turnmsg.wind = getwind()
    --     for i = 1, #tempfighters do
    --         send_request(get_user_fd(tempfighters[i]), turnmsg, "battleproxy_turnchange")
    --     end
    --     -- todo 刷怪
    --     LOG_INFO("per_turn_birth_npc: %s", tostring(per_turn_birth_npc))

    --     for groupid, num in pairs(per_turn_birth_npc) do
    --         for i = 1, num do
    --             spawnnpc(groupid, true)
    --         end
    --     end
    -- end

    -- -- 需要等0.5s
    -- skynet.sleep(100)
    -- LOG_INFO("turn-----@@@-------------------------: %s", tostring(msg))
    -- for i = 1, #tempfighters do
    --     send_request(get_user_fd(tempfighters[i]), msg, "battleproxy_turninfo")
    -- end
    
    -- -- todo 刷怪
    -- LOG_INFO("per_roll_birth_npc: %s" , tostring(per_roll_birth_npc))

    -- for groupid, num in pairs(per_roll_birth_npc) do
    --     for i = 1, num do
    --         spawnnpc(groupid, true)
    --     end
    -- end

    -- -- 如果链式刷怪队列有东西就先刷第一个，刷完摘掉，之后的是等下轮转再刷下一个
    -- if #fresh_npc_queue ~= 0 then
    --     spawnnpc(fresh_npc_queue[1], true)
    --     table.remove(fresh_npc_queue, 1)
    -- end

    -- is_turn_ended = false
    -- turn_check_count = 0
    -- -- curweapon = {}
    -- battleloop()
    -- -- skynet.timeout(1000, battleloop)
end


-- 根据距离计算待消耗的能量值
local function energycostby_distance(distance, efficiency)
    return math.abs(distance) * efficiency
end

---设置伤害
local function set_damage(uid, playerid, damage)
    --记录承伤、玩家伤害
    battledata[playerid].defense = battledata[playerid].defense and (battledata[playerid].defense + damage) or damage
    battledata[uid].harm = battledata[uid].harm and (battledata[uid].harm + damage) or damage
end

-- 摩擦伤害
local function rub_damage(uid, weaponid, rubplayers, base_damage, damagereduce)
    local ret = {}
    for i = 1, #rubplayers do
        local playerid = rubplayers[i]
        if curmovers_group ~= getgroupid(playerid) then
            local body = sharedata.deepcopy("machinebody", getbody(playerid)[1])
            local tempattri = {}

            local body_damage = 0
            local shield_damage = base_damage * damagereduce
            local tempattri = get_common_damage(playerid, shield_damage)
            table.insert(ret, tempattri)
            --记录承伤、玩家伤害
            set_damage(uid, playerid, shield_damage)
        end
    end
    return ret
end

-- 全额伤害计算
local function full_damage(uid, weaponid, base_damage, body_damage, hitplayer)
    local ret = {}
    local tempattri = {}
    if get_weapon_type(weaponid) == weapondefine.weapontypedefine.melee
        and curmovers_group == getgroupid(hitplayer) then
        return tempattri
    end

    if get_weapon_type(weaponid) == weapondefine.weapontypedefine.cannon
        and curmovers_group == getgroupid(hitplayer) then
        return tempattri
    end

    local tempattri = get_common_damage(hitplayer, base_damage, body_damage)
    table.insert(ret, tempattri)
    --记录承伤、玩家伤害
    set_damage(uid, hitplayer, base_damage)
    return ret
end

-- 范围衰减伤害
local function spheroidal_damage(uid, explodepos, damage_rad, base_damage, body_damage, ignoredplayers)
    local ret = {}
    for k, v in pairs(battle_attribute_infos) do
        local playerid = k
        if ignoredplayers == nil or not table.find(ignoredplayers, playerid) then
            local playerpos = v.pos
            local distance = math.sqrt(math.pow((explodepos.x - playerpos.x), 2) + math.pow((explodepos.y - playerpos.y), 2)+ math.pow((explodepos.z - playerpos.z), 2))
            if distance < damage_rad then
                local body = sharedata.deepcopy("machinebody", getbody(playerid)[1])
                local tempattri = {}

                local shield_damage = base_damage - (base_damage - base_damage*0.8) * (distance/damage_rad)

                local tempattri = get_common_damage(playerid, shield_damage, body_damage)
                table.insert(ret, tempattri)
                --记录承伤、玩家伤害
                set_damage(uid, playerid, shield_damage)
            end 
        end
    end
    return ret
end

--- 伤害的计算
local function caculate_damage(uid, weaponid, weaponindex, explodepos, hitplayer, rubplayer)
    local weapon = sharedata.deepcopy( "weapontable", weaponid)
    local battleinfo = battle_attribute_infos[uid]
    local damage_rad = battleinfo.scopeatk
    local base_damage = battleinfo.atk * damageparam 
    local body_damage = 0
    local ret = {}

    -- 摩擦伤害
    if #rubplayer ~= 0 then
        local damagereduce = weapon.Damage_Reduce_Max
        local rubret = rub_damage(uid, weaponid, rubplayer, base_damage, damagereduce)

        for i = 1, #rubret do
            table.insert(ret, rubret[i])
        end
    end

    -- 全额伤害
    if hitplayer ~= 0 then
        local fullret = full_damage(uid, weaponid, base_damage, body_damage, hitplayer)
        for i = 1, #fullret do
            table.insert(ret, fullret[i])
        end
    end
    -- 范围伤害
    if get_weapon_type(weaponid) == weapondefine.weapontypedefine.railgun or
        get_weapon_type(weaponid) == weapondefine.weapontypedefine.cannon then

        local ignoredplayers = {}
        if hitplayer ~= 0 then
            table.insert(ignoredplayers, hitplayer)
        end

        if #rubplayer ~= 0 then
            for i = 1, #rubplayer do
                table.insert(ignoredplayers, rubplayer[i])
            end
        end

        if groupinfo[curmovers_group] == nil then
            return
        end

        for i = 1, #groupinfo[curmovers_group] do
            if groupinfo[curmovers_group][i] < 0 then
                for k, _ in pairs(battle_attribute_infos) do
                    if k < 0 then
                        table.insert(ignoredplayers, k)
                    end
                end
            end
        end

        local aoeret = spheroidal_damage(uid, explodepos, damage_rad, base_damage, body_damage, ignoredplayers)

        for i = 1, #aoeret do
            table.insert(ret, aoeret[i])
        end
    end
    deathjudge(ret, uid)
    if uid > 0 then
        achievement.req.updateathletics(uid, achievementdefine.achievetype.hitenemy, nil, #ret)
    end
    return ret
end

-- 炮弹速度值的计算，根据蓄力值
local function caculate_speed(weaponid, power)
    power = math.clamp(power, 0, 1)
    local weapon = sharedata.deepcopy( "weapontable", weaponid)
    local min_speed = weapon.InitialSpeedMin
    local max_speed = weapon.InitialSpeedMax
    local weapontype = get_weapon_type(weaponid)

    if weapontype == weapondefine.weapontypedefine.railgun then
        return math.floor(min_speed + (max_speed - min_speed) * power)
    elseif weapontype == weapondefine.weapontypedefine.cannon then
        if 0 <= power and power < 0.85 then
            damageparam = math.pow(10, (-0.69+0.8117 * power))
        else
            damageparam = math.pow(10, (0.69-0.8117 * power))
        end
        return math.floor(damageparam)
    end
end


local function movecheck(uid)
    local groupid = getgroupid(uid)
    if groupid == 0 then
        return false
    end

    if curmovers_group ~= groupid then
        return false
    end

    return true
end

-- 返回一个table {10000, 1, 10002, 1,....}
local function get_part_info(part, uniqueids)
    local partinfo = {}
    for i = 1, #uniqueids do
        uniqueids[i] = tonumber(uniqueids[i])
        if uniqueids[i] ~= 0 then 
            local cfgid = equipment_dc.req.getcfgid(part, uniqueids[i])
            table.insert(partinfo, cfgid)      
            local lv = equipment_dc.req.getvalue(part, uniqueids[i], "lv") 
            table.insert(partinfo, lv) 
        else
            table.insert(partinfo, 0)
            table.insert(partinfo, 0)
        end
    end
    return partinfo
end

-- 取消暂停
local function cancelpause()
    pausingtime = 0
end

--- 是否在触发范围内
local function get_area_suffer(pos)
    for i = 1, #battle_trigger_areainfos do
        local areainfo = battle_trigger_areainfos[i]
        local areacfgid = areainfo.cfgid
        local areacfg = sharedata.deepcopy("trigger_area", areacfgid)

        local areawidth = areacfg.Width
        local areaheight = areacfg.Height
        local miny = areainfo.pos.y - areawidth/2
        local maxy = areainfo.pos.y + areawidth/2
        local minz = areainfo.pos.z - areaheight/2
        local maxz = areainfo.pos.z + areaheight/2

        if pos.y >= miny and pos.y <= maxy and pos.z >= minz and pos.z <= maxz then
            return areacfg.Area_Suffer
        end
    end
    return 0
end

---初始化芯片加成
---将数据保存到playerchipattrret和playerchipattr中
local function get_chip_attr(uid)
    local tab, data = {}, {}
    tab.weaponattris = {}
    tab.machineattris = {}
    local defaultindex = tonumber(machineinfo_dc.req.getvalue(uid, "defaultindex"))
    local player = player_dc.req.get(uid)
	local rawcfgids = machineinfo_dc.req.getvalue(uid, "machinecfgid")
	local cfgids = string.split(rawcfgids)
    local weapons = string.split(machinecfg_dc.req.getvalue(tonumber(cfgids[defaultindex]), "weapons"))
    local chipattributedc = chipattribute_dc.req.get(tonumber(cfgids[defaultindex]))
    local slotarr = {}
    for i = 1, #weapons do
        if tonumber(weapons[i]) ~= 0 then
            local record, res = {}, {}
            local num
            local slotarr = json.decode(equipment_dc.req.getvalue(warehousedefine.warehousetype.weapon, weapons[i], "slotarray"))
            for j = 1, #slotarr do
                if next(slotarr[j]) and slotarr[j].chipid then
                    local buffidarr = sharedata.deepcopy("mod", slotarr[j].chipid)
                    if buffidarr.Mod_Type == chipdefine.chiptype.skill then
                        record[buffidarr.Sikll_ID] = 10001
                        goto continue
                    end
                    if buffidarr.Mod_Type == chipdefine.chiptype.passkill then
                        record[buffidarr.Sikll_ID] = 10000
                        goto continue
                    end
                    for i = 1, #buffidarr.Buff_ID, 3 do
                        local buffid = tonumber(buffidarr.Buff_ID[i])
                        num = tonumber(buffidarr.Buff_ID[i + 1]) + tonumber(buffidarr.Buff_ID[i + 2] * slotarr[j].level)
                        if num >= 0 then
                            num = math.ceil(num * 1000) * 0.001
                        else
                            num = math.floor(num * 1000) * 0.001
                        end
                        record[buffid] = (record[buffid] and record[buffid] or 0) + num
                    end
                    ::continue::
                end
            end
            for k, v in pairs(record) do
                table.insert(res, {buffid = k, val = math.floor(v * 1000) * 0.001})
            end
            local cfgid = equipment_dc.req.getvalue(warehousedefine.warehousetype.weapon, weapons[i], "cfgid")
            local lv = equipment_dc.req.getvalue(warehousedefine.warehousetype.weapon, weapons[i], "lv")
            table.insert(data, res)
        else
            table.insert(data, {})
        end
    end
    tab.weaponattris = data

    for k, v in pairs(chipattributedc) do
        if k ~= "id" and v ~= 0 then
           table.insert(tab.machineattris, {buffid = buffdefine.bufftype[k], val = math.floor(v * 1000) * 0.001})
        end
    end 
    local skillinfo = skill_dc.req.get(tonumber(cfgids[defaultindex]))
    local skill = string.split(skillinfo.skillarray)
    local passkill = string.split(skillinfo.passkillarray)
    local selectskill = string.split(skillinfo.selectskill)
    --加入主动技能
    if next(selectskill) then
        table.insert(tab.machineattris, {buffid = tonumber(selectskill[2]), val = 10001})
    elseif next(skill) then
        table.insert(tab.machineattris, {buffid = tonumber(skill[2]), val = 10001})
    end
    --加入被动技能
    for i = 1, #passkill, 2 do
        table.insert(tab.machineattris, {buffid = tonumber(passkill[i + 1]), val = 10000})
    end
    
    --服务器数据保存
    local pl, attr = {}, {}
    pl.machineattris = {}
    pl.weaponattris = {}
    for i = 1, #tab.machineattris do
        if tab.machineattris[i].val < 10000 then
            attr[buffdefine.bufftypekey[tab.machineattris[i].buffid]] = tab.machineattris[i].val
        end
    end
    table.insert(pl.machineattris, attr)
    for i = 1, #tab.weaponattris do
        local attr = {}
        for j = 1, #tab.weaponattris[i] do
            if tab.weaponattris[i][j].val < 10000 then
                attr[buffdefine.bufftypekey[tab.weaponattris[i][j].buffid]] = tab.weaponattris[i][j].val
            end
        end
        table.insert(pl.weaponattris, attr)
    end
    playerchipattr[uid] = pl
    playerchipattrret[uid] = tab
end

function response.getchipattr(uid)
    return playerchipattrret[uid]
end

function response.setroomtype(newroomtype)
    roomtype = newroomtype
end

function response.setstagetype(newstagetype)
    stagetype = newstagetype
end

function response.skillactive(data)
    local ret = {}
    local uid = data.uid

    ret.skillid = data.msg.skillid
    ret.isactive = data.msg.isactive

    if data.msg.npcid == nil then
        return
    end

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    if not movecheck(uid) then
        skynet.error(uid, "is not curmover!")
        return  
    end

    -- todo 技能冷却
    -- local skill = sharedata.deepcopy( "skill", curweapon.skillid)
    ret.playerid = uid
    for i = 1, #tempfighters do
        send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_onskillactive")
    end
end

function response.murder(data)
    local suid = data.uid
    local targetid = data.msg.npcid
    local realdeath

    if battle_machine_infos[1].playerid ~= suid then
        realdeath = suid
    else
        if targetid >= 0 then
            realdeath = suid
        else
            realdeath = targetid
        end
    end

    if table.find(deathlist, realdeath) then
        return
    end

    battle_attribute_infos[realdeath].hp = 0
    battle_attribute_infos[realdeath].shield = 0
    battle_attribute_infos[realdeath].energy = 0


    table.insert(deathlist, realdeath)

    local deathmsg = {}
    deathmsg.playerid = realdeath

    for i = 1, #tempfighters do
        send_request(get_user_fd(tempfighters[i]), deathmsg, "battleproxy_ondeath")
    end

    for i = 1, #battle_trigger_areainfos do
        if deathmsg.playerid == battle_trigger_areainfos[i].hostuid then
            per_turn_birth_npc[battle_trigger_areainfos[i].withnpc] = nil
            cur_mission_progress = cur_mission_progress + 1
        end
    end

    if getgroupid(realdeath) ~= 0 then
        remove_from_group(realdeath, getgroupid(realdeath))
    end

    local result, winidarr = battledatahandler:judge_battle_end(tempfighters, deathlist, tmpstageid, targetcount, cur_mission_progress) 
    if result then
        update_score(winidarr)
        isfinish = true
    end 
end

function response.playerinfoinit(fighters, stageid)
    tmpstageid = stageid
    tempfighters = fighters
    battlebuff:settempplayer(tempfighters) --保存玩家信息
    local stage = sharedata.deepcopy( "stage", stageid)
    wind_amplitude = stage.Wind_Amplitude
    maxturns = stage.End_Round  --设置回合上限
    -- pve模式
    if stage.Task_Type ~= teammatchdefine.missiontype.pvp then
        setbirthpoint_pve(fighters, stageid)
        targetcount = stage.Aim
    else
        --pvp跳过对话
        --setbirthpoint(fighters)
        isallskiped = true   
    end

    for i = 1, #fighters do
        local tempdata = {}
        local defaultindex = tonumber(machineinfo_dc.req.getvalue(fighters[i], "defaultindex"))
        local rawcfgids = machineinfo_dc.req.getvalue(fighters[i], "machinecfgid")
        local cfgids = string.split(tostring(rawcfgids), ",")
        local cfgdata = machinecfg_dc.req.get(cfgids[defaultindex])
        -- 字符串转数组

        tempdata.body = get_part_info(warehousedefine.warehousetype.body, string.split(cfgdata.machinebody))     
        tempdata.chassis = get_part_info(warehousedefine.warehousetype.chassis, string.split(cfgdata.machinechassis))
        tempdata.firecontroller = get_part_info(warehousedefine.warehousetype.firecontroller, string.split(cfgdata.firecontroller))
        tempdata.weapons = get_part_info(warehousedefine.warehousetype.weapon, string.split(cfgdata.weapons))
        
        while #tempdata.weapons < 16 do
            table.insert(tempdata.weapons, 0)
            table.insert(tempdata.weapons, 0)
        end

        -- 教学关卡特殊装备
        if stagetype == teammatchdefine.missiontype.tutorial then
            tempdata.weapons = {10001, 1}
            tempdata.body = {10001, 1}
            tempdata.chassis = {10001, 1}
            tempdata.firecontroller = {10001, 1}
        end

        tempdata.name = getusername(cfgdata.playerid)
        tempdata.playerid = cfgdata.playerid
        tempdata.pos = birthpointinfo[fighters[i]]
        tempdata.npccfgid = -1

        add_to_group(fighters[i])
        tempdata.groupid = getgroupid(fighters[i]) 

        local uid = fighters[i]
        -- todo 定制编组在这里增加逻辑判断

        get_chip_attr(fighters[i])
        local weaponcfg = {}
        for i = 1, #tempdata.weapons, 2 do
            if tempdata.weapons[i] ~= 0 then
                weaponcfg = sharedata.deepcopy("weapontable", tempdata.weapons[i])
            end
        end
        local playerweaponatt = {}     --武器芯片属性加成
        for i = 1, #playerchipattr[fighters[i]] do
            if not next(playerchipattr[fighters[i]].weaponattris[i]) then
                playerweaponatt = playerchipattr[fighters[i]].weaponattris[i]
                break
            end
        end
        local playermachineatt = playerchipattr[fighters[i]].machineattris or {}     --机体芯片属性加成

        battle_machine_infos[i] = tempdata
        battle_attribute_infos[uid] = {
            playerid = uid,
            atk = math.ceil((weaponcfg.Base_Damage or 0) * ((playerweaponatt.atk or 0) + 1)),                    --攻击力              
            scopeatk = math.ceil((weaponcfg.Damage_Rad or 0) * ((playerweaponatt.scopeatk or 0) + 1)),               --伤害范围               
            distance = math.ceil((weaponcfg.InitialSpeedMax or 0) * ((playerweaponatt.distance or 0) + 1)),               --攻击距离参数修改        
            hp = math.ceil(gethp(uid) * ((playermachineatt.life or 0) + 1)),
            speed = 10000 / (getspeed(uid) * ((playermachineatt.speed or 0) + 1)),
            energy = math.ceil(getenergy(uid) * ((playermachineatt.energy or 0) + 1)),
            shield = math.ceil(getshield(uid) * ((playermachineatt.shield or 0) + 1)),
            elevation = math.ceil(getelevation(uid) * ((playermachineatt.elevation or 0) + 1 + (playerweaponatt.elevation or 0))) ,              --仰角
            overhang = math.ceil(getoverhang(uid) * ((playermachineatt.overhang or 0) + 1 + (playerweaponatt.overhang or 0))),               --俯角
            enefficiency = math.ceil(getenefficiency(uid) / ((playermachineatt.enefficiency or 0) + 1 + (playerweaponatt.enefficiency or 0)) * 1000) * 0.001,           --能量效率
            efficiency = math.ceil(getefficiency(uid) / ((playermachineatt.efficiency or 0) + 1) * 1000) * 0.001,             --引擎效率
            climbingangle = math.ceil(getclimbingangle(uid) * ((playermachineatt.climbingangle or 0) + 1)) ,          --底盘爬角
            pos = tempdata.pos,
            npccfgid = -1,
        }
        battledata[uid] = {}
        battledata[uid].kill = {}
        loadingstatus[uid] = false
        skipstatus[uid] = false
    end

    if #stage.Ai_Group_ID == 0 then
        return
    end

    -- -- 读表添加npc信息
    -- for i = 1, #stage.Ai_Group_ID, 2 do
    --     addnpc(stage.Ai_Group_ID[i], stage.Ai_Group_ID[i+1])
    -- end

    -- -- 读表添加可触发区域信息
    -- if #stage.Area_ID_YZ ~= 0 then
    --     for i = 1, #stage.Area_ID_YZ, 3 do
    --         local areapos = {}
    --         areapos.x = stage.Area_X
    --         areapos.y = stage.Area_ID_YZ[i+1]
    --         areapos.z = stage.Area_ID_YZ[i+2]


    --         -- todo test
    --         for j = 1, 6 do
    --             areapos.y = stage.Area_ID_YZ[i+1] + j
    --             addarea(stage.Area_ID_YZ[i], areapos)
    --         end

    --     end 
    -- end
end

-- 发射技能
function response.skillspell(data)
    local ret = {}
    local uid = data.uid

    ret.skillid = data.msg.skillid
    ret.spellpos = data.msg.spellpos
    ret.params = data.msg.params

    if data.msg.npcid == nil then
        return
    end

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    if not movecheck(uid) then
        skynet.error(uid, "is not curmover!")
        return
    end

    -- 会引起位置变化的技能更改下属性
    if ret.skillid == 10002 or ret.skillid == 10001 then
        local params = string.split(ret.params, ",")
        battle_attribute_infos[uid].pos.x = math.floor(params[1])
        battle_attribute_infos[uid].pos.y = math.floor(params[2])
        battle_attribute_infos[uid].pos.z = math.floor(params[3])
    end

    -- -- todo 技能冷却
    -- local skill = sharedata.deepcopy( "skill", curweapon.skillid)
    ret.playerid = uid
    local addval = get_skill_energycost(ret.skillid) * getenefficiency(uid) * (1 / (1 + ((playerchipattr[uid] and playerchipattr[uid].enefficiency) or 0)))

    if battle_attribute_infos[uid].energy < addval then
        local ret = {}
        skynet.error("能量不足")
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    -- ret.spellpos = battle_attribute_infos[uid].pos
    ret.remainenergy = math.max(0, update_energy(uid, addval * -1))
    for i = 1, #tempfighters do
        send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_onskillspell")
    end
end

-- 移动
function response.move(data)
	local ret = {}
	local uid = data.uid
    local fd = data.fd
    local pos_y = 0

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    if movecheck(uid) == false and data.msg.movestate ~= 0 then
        skynet.error(uid, "is not curmover")
        return
    end

    -- skynet.error("client: ", data.msg.remainenergy)
    data.msg.remainenergy = math.max(0, data.msg.remainenergy)
    if data.msg.movestate ~= 0 then
        if uid > 0 then
            player_pos_y = data.msg.location.y
        end
        ret.remainenergy = data.msg.remainenergy
    else
        if uid <= 0 then
            pos_y = battle_attribute_infos[uid].pos.y
        else
            pos_y = player_pos_y
        end
        if player_pos_y == nil then
            battle_attribute_infos[uid].energy = data.msg.remainenergy
        else
            --引导关卡不计算能量
            if stagetype ~= teammatchdefine.missiontype.tutorial then
                local energy = math.floor(
                    math.clamp(battle_attribute_infos[uid].energy - energycostby_distance(math.abs(data.msg.location.y - pos_y), 
                        battle_attribute_infos[uid].efficiency), 0, battle_attribute_infos[uid].energy))
                -- 允许+-5点的误差
                if math.abs(energy - data.msg.remainenergy) > 5 and stagetype ~= teammatchdefine.missiontype.tutorial then
                    battle_attribute_infos[uid].energy = math.min(energy, data.msg.remainenergy)
                else
                    battle_attribute_infos[uid].energy = data.msg.remainenergy
                end
            end 
        end
        player_pos_y = nil
        ret.remainenergy = battle_attribute_infos[uid].energy
        battle_attribute_infos[uid].pos = data.msg.location
    end
    -- skynet.error("service: ", ret.remainenergy)
    ret.playerid = uid
    ret.location = data.msg.location
    ret.movestate = data.msg.movestate

    if data.msg.isleft then
        ret.isleft = data.msg.isleft
    else
        ret.isleft = false   -- 默认为false
    end

    for i = 1, #tempfighters do
        -- if not movecheck(uid) then
        --     goto continue
        -- end
        if tempfighters[i] == battle_machine_infos[1].playerid and uid < 0 then
            goto continue
        end
        send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_onmove")
        ::continue::
    end
end

-- buff激活
function response.buffactive(data)
	local ret = {}
	local uid = data.uid
	local fd = data.fd

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    --todo 参数校验buffactive

end

-- 以第一个发送请求数据的时间为开始时间
function response.getbattleinfo()
    -- if isbegincheck == false then
    --     prebattle()
    -- end

    return battle_machine_infos
end

function response.getattriinfo()
    local ret = {}
    for k, v in pairs(battle_attribute_infos) do
        local temp = {}
        temp.playerid = k
        temp.hp = v.hp
        temp.shield = v.shield
        temp.energy = v.energy
        temp.elevation = v.elevation              --仰角
        temp.overhang = v.overhang              --俯角
        temp.enefficiency = v.enefficiency           --能量效率
        temp.efficiency = v.efficiency             --引擎效率
        temp.climbingangle = v.climbingangle          --底盘爬角
        table.insert(ret, temp)
    end
    return ret
end

function response.getareainfo()
    local ret = {}
    for i = 1, #battle_trigger_areainfos do
        local temp = {}
        temp.pos = battle_trigger_areainfos[i].pos
        temp.index = battle_trigger_areainfos[i].index
        temp.cfgid = battle_trigger_areainfos[i].cfgid
        temp.length = battle_trigger_areainfos[i].curturnlong - curturns
        table.insert(ret, temp)
    end
    return ret
end

function response.fire(data)
	local ret = {}
	local uid = data.uid
    local weaponid = data.msg.weaponid

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    if not movecheck(uid) then
        skynet.error(uid, "is not curmover!")
        return  
    end

    local weaponids = {}

    local weapons = getweapons(uid)
    for i = 1, #weapons, 2 do
        table.insert(weaponids, weapons[i])
    end

    if not table.find(weaponids, weaponid) then
        skynet.error(uid, "don't have this weapon:", weaponid)
        return
    end

    pausingtime = 200

    ret.playerid = uid
    ret.weaponid = weaponid
    ret.firepoint = data.msg.firepoint
    ret.angle = data.msg.angle
    ret.speed = caculate_speed(weaponid, data.msg.power)      -- 根据蓄力值计算炮弹速度
    ret.critical = data.msg.critical or false              -- 是否暴击

    local addval = get_weapon_fireenergy(weaponid) * getenefficiency(uid) * (1 / (1 + ((playerchipattr[uid] and playerchipattr[uid].enefficiency) or 0)))

    if battle_attribute_infos[uid].energy < addval then
        local ret = {}
        skynet.error("能量不足")
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    ret.remainenergy = update_energy(uid, addval * -1)
    curweapon.weaponid = weaponid
    for i = 1, #tempfighters do
        send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_onfire")
    end
end

function response.turnend(data)
	local ret = {}
	local uid = data.uid
    
    ret.location = data.msg.location
    ret.remainenergy = math.clamp(data.msg.remainenergy, 0, getenergy(uid))

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    if (not movecheck(uid)) and getgroupid(uid) ~= 0 then
        skynet.error(uid, "is not curmover!")
        return
    end

    -- 置空
    curweapon = {}
    damageparam = 1
    ret.playerid = uid
    battle_attribute_infos[uid].pos = data.msg.location
    LOG_INFO("turnend-------------to client: %s", tostring(ret))

    -- {
    --     ["movestate"] = 0,
    --     ["isleft"] = false,
    --     ["location"] = {
    --         ["z"] = 15047,
    --         ["x"] = -300,
    --         ["y"] = -65660,
    --     }
    --     ["playerid"] = 3,
    --     ["remainenergy"] = 172,
    -- }    


    for i = 1, #tempfighters do
        send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_turnend")
    end

    curgroup_turn[uid] = true
    local isgroupend = true
    for k, v in pairs(curgroup_turn) do
        if v == false then
            isgroupend = false
            break
        end
    end

    -- 回合正常结束标志位
    if isgroupend then
        is_turn_ended = true
    end
end

function response.skipdialogue(data)
    -- 有人跳就全跳
    -- isallskiped = true
    -- 所有人都跳才跳
    -------------------------------
    local uid = data.uid
    local tempuids = table.keys(skipstatus)
    for i = 1, #tempuids do
        if tempuids[i] == uid then
            skipstatus[uid] = true
        end
    end
    -------------------------------
end

---将玩家状态改为已准备
function response.updateready(uid)
    local tempuids = table.keys(loadingstatus)
    for i = 1, #tempuids do
        if tempuids[i] == uid then
            loadingstatus[uid] = true
        end
    end
end

function response.jump(data)
	local ret = {}
    local uid = data.uid
    local pos_y = 0
    ret.jumppower = data.msg.jumppower

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    if not movecheck(uid)then
        skynet.error(uid, "is not curmover!")
        return
    end
    -- skynet.error("攒", battle_attribute_infos[uid].energy, data.msg.energy, player_pos_y, data.msg.pos.y)
    --跳之前停止停止移动
    if player_pos_y ~= nil then
        if uid <= 0 then
            pos_y = battle_attribute_infos[uid].pos.y
        else
            pos_y = player_pos_y
        end
        local energy = math.floor(
            math.clamp(battle_attribute_infos[uid].energy - energycostby_distance(math.abs(data.msg.pos.y - pos_y), 
                battle_attribute_infos[uid].efficiency), 0, battle_attribute_infos[uid].energy))
    
        -- 允许+-5点的误差
        if math.abs(energy - data.msg.energy) > 5 and stagetype ~= teammatchdefine.missiontype.tutorial then
            battle_attribute_infos[uid].energy = math.min(energy, data.msg.energy)
        else
            battle_attribute_infos[uid].energy = math.max(0, data.msg.energy)
        end
        player_pos_y = nil
    end
    -- skynet.error("前", battle_attribute_infos[uid].energy, data.msg.energy)
    ret.energy = math.max(0, math.abs(data.msg.energy - battle_attribute_infos[uid].energy) > 3 and battle_attribute_infos[uid].energy or data.msg.energy)
    battle_attribute_infos[uid].energy = ret.energy
    ret.playerid = uid
    ret.pos = data.msg.pos
    ret.force = data.msg.force
    for i = 1, #tempfighters do
        send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_jump")
    end
end

function response.jumpend(data)
	local ret = {}
    local uid = data.uid

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    if not movecheck(uid)then
        skynet.error(uid, "is not curmover!")
        return
    end
    --跳跃能量计算【注意目前跳跃技能写死，以后如果有多个跳跃需增加参数】
    local skill = sharedata.deepcopy( "skill", 10002)
    battle_attribute_infos[uid].energy = battle_attribute_infos[uid].energy - skill.Power_Consume
    
    ret.energy = math.max(0, math.abs(data.msg.energy - battle_attribute_infos[uid].energy) > 3 and battle_attribute_infos[uid].energy or data.msg.energy)
    battle_attribute_infos[uid].energy = ret.energy
    player_pos_y = data.msg.pos.y
    ret.playerid = uid
    ret.pos = data.msg.pos
    for i = 1, #tempfighters do
        send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_jumpend")
    end
end

function response.explode(data)
    -- skynet.error("explode!!!!!!!!!!!", tostring(data))
    local ret = {}
    local uid = data.uid

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    local weaponid = data.msg.weaponid
    
    local weapons = getweapons(uid)
    local indexweapon = 0
    for i = 1, #weapons, 2 do
        if weapons[i] == weaponid then
            indexweapon = i
            break
        end
    end
    if indexweapon == 0 then
        return
    end

    curweapon.weaponid = weaponid

    if curweapon.weaponid == nil and data.msg.weaponid ~= 0 then
        curweapon.weaponid = data.msg.weaponid
    end
    curweapon.explodepos =  data.msg.location

    local weapon = sharedata.deepcopy( "weapontable", curweapon.weaponid)

    local rubplayers = data.msg.rubplayer or {}

    ret.strength = weapon.Break_Strength - get_area_suffer(ret.location)    
    
    if stagetype == teammatchdefine.missiontype.tutorial then
        ret.strength = 0
    end
    ret.radius = weapon.Break_Rad         

    ret.hitresult = caculate_damage(uid, weaponid, indexweapon, data.msg.location, data.msg.hitplayer, rubplayers)
    ret.location = data.msg.location
    ret.weaponid = data.msg.weaponid
    ret.hittype = data.msg.hittype
    ret.trigger = uid

    LOG_INFO("explode-------------to client: %s", tostring(ret))
    for i = 1, #tempfighters do
        send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_explode")
    end

    -- 挂buff
    if weapon.BUFF_ID ~= 0 then
        for i = 1, #ret.hitresult do
            local recver = ret.hitresult[i].playerid
            battlebuff:addbuffinfo(curturnlong, weapon.BUFF_ID, uid, recver)
        end
    end
end

function response.brake(uid)
    if not movecheck(uid) then
        return
    end
    roll_end_stop_move(uid)
end

function response.aim(data)
    local ret = {}
    local uid = data.uid

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    if not movecheck(uid) then
        skynet.error(uid, "is not curmover!")
        return
    end

    ret.playerid = uid
    ret.faceto = data.msg.faceto
    ret.angle = data.msg.angle
    for i = 1, #tempfighters do
        if tempfighters[i] ~= uid then
            send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_aim")
        end
    end
end

---当前天的零点
local function zerotime()
    local time = os.date("*t")
    time.min = 0
    time.sec = 0
    time.hour = 0
    return os.time(time)
end

function response.sendsocket(data)
	local ret = {}
	local uid = data.msg.uid
    local socket = data.msg.socket

    --设置战斗数量
    local zerotime, param = zerotime()
    local infodc = info_dc.req.get(zerotime)
    if stagetype == teammatchdefine.missiontype.pve then
        param = "pve"
        info_dc.req.setvalue(zerotime, "pvesum", infodc.pvesum + 1)
    elseif stagetype == teammatchdefine.missiontype.pvp then
        param = "pvp"
        info_dc.req.setvalue(zerotime, "pvpsum", infodc.pvpsum + 1)
    end
    if roomtype == teammatchdefine.eroomtype.single then
        param = param .. "num_1"
    elseif roomtype == teammatchdefine.eroomtype.double then
        param = param .. "num_2"
    elseif roomtype == teammatchdefine.eroomtype.trible then
        param = param .. "num_3"
    else
        param = param .. "num_3"
    end
    info_dc.req.setvalue(zerotime, param, infodc[param] + 1)
    info_dc.req.setvalue(zerotime, "battlenum", infodc.battlenum + table.size(tempfighters))
    ---
    
    ret.code = errCodeDef.eEC_res_notEnough
    if battleroom_num == nil or battleroom_num >= 100 then
        LOG_ERROR("=================battleroom_num is: %s", battleroom_num)
        return ret
    end

    socket_main = socket
	for i = 1, #tempfighters do
        send_request(get_user_fd(tempfighters[i]), {socket = socket_main}, "battleproxy_sendsocket")
    end
    local _, obj = pcall(snax.queryservice, "teammatch")
    for i = 1, #tempfighters do
        local ok = pcall(obj.req["gobattlefinish"], tempfighters[i])
    end

    ret.code = errCodeDef.eEC_success
	return ret
end

function response.sendroomnum(data)
	local ret = {}
    local count = data.msg.count
    if count == nil then
        battleroom_num = 1000
    end
    battleroom_num = count
	return ret
end

function response.switchweapon(data)
	local ret = {}
    local uid = data.uid
    local index = data.msg.weaponindex
    ret.weaponindex = index

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    if not movecheck(uid)then
        skynet.error(uid, "is not curmover!")
        return
    end

    ret.playerid = uid
    -- todo 参数校验

    for i = 1, #tempfighters do
        if tempfighters[i] ~= uid then
            send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_onswitchweapon")
        end
    end
    --计算属性【全算一遍】
    local weaponattri = playerchipattr[uid].weaponattris[index] or {}
    local chipattributedc = playerchipattr[uid].machineattris or {}

    local defaultindex = tonumber(machineinfo_dc.req.getvalue(uid, "defaultindex"))
    local rawcfgids = machineinfo_dc.req.getvalue(uid, "machinecfgid")
    local cfgids = string.split(rawcfgids)
    local playerchip = player_dc.req.get(uid)
    local weponpsma = getweapons(uid)
    local weaponcfg = sharedata.deepcopy("weapontable", weponpsma[2 * ret.weaponindex - 1])
    
    local res = {}                                  
    local temp = {
        playerid = uid, 
        hp = battle_attribute_infos[uid].hp,
        shield = battle_attribute_infos[uid].shield,
        energy = battle_attribute_infos[uid].energy,
        npccfgid = -1,
        climbingangle = battle_attribute_infos[uid].climbingangle,              --底盘爬角
    }
    -- temp.atk = math.ceil(weaponcfg.Base_Damage * (((playerchipattr[uid].weaponattris[index] and playerchipattr[uid].weaponattris[index].atk) or 0) + 1))                 --攻击力              
    -- temp.scopeatk = math.ceil(weaponcfg.Damage_Rad * (((playerchipattr[uid].weaponattris[index] and playerchipattr[uid].weaponattris[index].scopeatk) or 0) + 1))              --伤害范围               
    -- temp.distance = math.ceil(weaponcfg.InitialSpeedMax * (((playerchipattr[uid].weaponattris[index] and playerchipattr[uid].weaponattris[index].distance) or 0) + 1))               --攻击距离参数修改    
    temp.elevation = math.ceil(playerchip.elevation * (((weaponattri and weaponattri.elevation) or 0) + 1 + (chipattributedc.elevation or 0)))                     --仰角
    temp.overhang = math.ceil(playerchip.overhang * (((weaponattri and weaponattri.overhang) or 0) + 1 + (chipattributedc.overhang or 0)))                        --俯角
    temp.enefficiency = math.ceil(playerchip.enefficiency / (((weaponattri and weaponattri.enefficiency) or 0) + 1 + (chipattributedc.enefficiency or 0)) * 1000) * 0.001          --能量效率
    temp.efficiency = math.ceil(playerchip.efficiency / ((chipattributedc.efficiency or 0) + 1) * 1000) * 0.001             --引擎效率
    if index  == 3 then
        --【注意】临时写死 10001特殊机甲带有火控 俯仰角基础值不同
        local body = sharedata.deepcopy("machinebody", 10001)
        local fireController = sharedata.deepcopy("firecontrol", body.FireControllerId)
        local chipattribute = chipattribute_dc.req.get(uid)
        temp.elevation = math.ceil(fireController.Attack_Angle_Max * (((weaponattri and weaponattri.elevation) or 0) + 1 + (chipattributedc.elevation or 0)))
        temp.overhang = math.ceil(fireController.Attack_Angle_Min * (((weaponattri and weaponattri.overhang) or 0) + 1 + (chipattributedc.overhang or 0)))
    end
    res.playerattribute = temp
    -- skynet.error("switchweapon", tostring(res))
    return res
end

function response.aimupdate(data)
	local ret = {}
    local uid = data.uid

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    if not movecheck(uid) then
        skynet.error(uid, "is not curmover!")
        return
    end

    ret.isaiming = data.msg.isaiming
    ret.playerid = uid
    for i = 1, #tempfighters do
        send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_aimupdate")
    end
end

function response.triggerarea(data)
    local index = data.msg.areaindex

    local uid = data.uid

    if uid == battle_machine_infos[1].playerid and data.msg.npcid < 0 then
        uid = data.msg.npcid
    end

    local ret = {}
    local allaigroup = sharedata.deepcopy( "ai_group")

    for k, v in pairs(battle_trigger_areainfos) do
        if v.index == index then
            -- and v.triggered == false
            v.triggered = true
            if v.aigroupid ~= 0 then
                spawnnpc(v.aigroupid, true)
                local aigroup = allaigroup[v.aigroupid]
    
                -- 宿主，宿主死光才停止刷新
                local hostnum = 0
                for i = 1, #aigroup.ID_YZ, 3 do
                    hostnum = hostnum + 1
                end
    
                for i = 0, hostnum - 1 do
                    local hostuid = battle_machine_infos[#battle_machine_infos - i].playerid
                    v.hostuid = hostuid
                end
    
                if aigroup.With_GroupID ~= 0 then
                    addnpc(aigroup.With_GroupID, battledefine.npcfreshtype.perturn)
                    v.withnpc = aigroup.With_GroupID
                end
            end

            local triggerareacfg = sharedata.deepcopy( "trigger_area", v.cfgid)
            -- 施加buff
            if triggerareacfg.BUFF_ID ~= 0 then
                battlebuff:addbuffinfo(curturnlong, triggerareacfg.BUFF_ID, 0, uid)
            end

            if triggerareacfg.Creat_Type == battledefine.areacreatetype.immediately then
                local delmsg = {}
                delmsg.areaindex = index
                table.remove(battle_trigger_areainfos, k)
                for i = 1, #tempfighters do
                    send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_delarea")
                end
            end
        end
    end
    -- skynet.error("battle_trigger_areainfos------1-------: %s", tostring(battle_trigger_areainfos))
end
 
function response.npcstatesync(data)
	local ret = {}
    local uid = data.uid
    
    if uid ~= battle_machine_infos[1].playerid or data.msg.npcid >= 0 then
        return
    end

    ret.npcid = data.msg.npcid
    ret.isactive = data.msg.isactive

    for i = 1, #tempfighters do
        if tempfighters[i] ~= uid then
            send_request(get_user_fd(tempfighters[i]), ret, "battleproxy_npcstatesync")
        end
    end
end

function response.online(uid, fd)
end

-- 掉线处理机制
function response.offline(uid)
    local infodc = info_dc.req.get(zerotime())
    for i = 1, #tempfighters do
        if tempfighters[i] == uid then
            table.remove(tempfighters, i)
            info_dc.req.setvalue(zerotime(), "battlenum", math.max(0, infodc.battlenum - 1))
        end
    end
    -- 掉线，直接认为死亡
    -- table.insert(deathlist, uid)
    -- local result, winidarr = battledatahandler:judge_battle_end(tempfighters, deathlist, tmpstageid, targetcount, cur_mission_progress) 
    -- if result then
    --     update_score(winidarr)
    --     isfinish = true
    -- end 

    if #tempfighters == 0 then
        local battleproxy = snax.queryservice("battleproxy")
        battleproxy.req.battlefinish(skynet.self(), battledata)
        if check_user_online(1) then
            skynet.error("================offline battle service=================")
            send_request(get_user_fd(1), {socket = socket_main}, "battleproxy_offline")
            return true
        else
            skynet.error("================battle service is offline=================")
            return false
        end
    end
    return false
end