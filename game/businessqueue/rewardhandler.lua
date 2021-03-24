-- 奖励处理类

local rewardhandler = class("rewardhandler")
local snax = require "skynet.snax"
local skynet = require "skynet"
local sharedata = require "skynet.sharedata"
local timext = require "timext"

-- 传单件道具信息过来
-- {["number"] = 3,
-- ["cfgid"] = 10014,
-- ["lv"] = 0,
-- ["type"] = 7,}
local function caculate_gold_per_prop(propreward)
    local material = sharedata.deepcopy("material_list", propreward.cfgid)
    local retgold = 0
    for i = 1, propreward.number do
        retgold = retgold + material.rate
    end
    skynet.error( propreward.number, "个", propreward.cfgid, "值", retgold, "钱")
    return retgold
end

-- 只有材料和芯片需要扣除等效金币，蓝图没有
local function getreward_gold(expectgold, proprewardlist)
    local matgold = 0
    for i = 1, #proprewardlist do
        local pergold = caculate_gold_per_prop(proprewardlist[i])
        matgold = matgold + pergold
    end
    local retgold = expectgold - matgold

    return math.clamp(retgold, 0, expectgold)
end

local function rollcheck(packageid, numarr)
    local tmpnum = 0
    for i = 1, #numarr do
        tmpnum = tmpnum + numarr[i]
    end

    if tmpnum > 1000 then
        skynet.error("找数值策划，这个包裹权值大于1000了", packageid)
    end
end

-- 从包裹数据中随机一个index出来，nil则无
local function randindex_bypackage(packageid)
    local drop_package = sharedata.deepcopy("drop_package", packageid)
    local drop_rate = drop_package.Drop_rate
    -- local fullrate = 1000
    local radindex = math.random(1, 1000)
    local numarray = {0}
    local ret = nil

    for i = 1, #drop_rate, 3 do
        local normalmatId = drop_rate[i]
        local droptype = drop_rate[i + 1]
        local rollrate = drop_rate[i + 2]
        table.insert(numarray, tonumber(rollrate))
    end

    rollcheck(packageid, numarray)
    for i = 2, #numarray do
        if numarray[i - 1] <= radindex and radindex <= numarray[i] then
            ret = i - 1
        end
    end
    return ret
end

-- 根据包裹获取掉落材料，roll次数， 内含蓝图，芯片，材料等，返回*blueprintinfo, *proprewardlist
local function getmat_bypackage(packageid, rolltimes)
    local drop_package = sharedata.deepcopy("drop_package", packageid)
    local drop_rate = drop_package.Drop_rate
    local proprewardlist = {}
    local bprewardlist = {}
    local radindex_arr = {}

    for i = 1, rolltimes do
        local randindex = randindex_bypackage(packageid)
        if (not table.find(radindex_arr, randindex)) and randindex then
            table.insert(radindex_arr, randindex)
        end
    end
    for i = 1, #radindex_arr do
        local propreward = {}
        local index = radindex_arr[i]
        local normalmatId = drop_rate[1 + (index - 1)*3]
        local droptype = drop_rate[2 + (index - 1)*3]
        if droptype == warehousedefine.warehousetype.material then
            propreward.type = droptype
            propreward.number = 1
            propreward.lv = 0
            propreward.cfgid = tonumber(normalmatId)
            table.insert(proprewardlist, propreward)
        elseif droptype == warehousedefine.warehousetype.package then
            local tmpbplist, tmpproplist = getmat_bypackage(normalmatId, 1)
            for i = 1, #tmpbplist do
                table.insert(bprewardlist, tmpbplist[i])
            end

            for i = 1, #tmpproplist do
                table.insert(proprewardlist, tmpproplist[i])
            end
        elseif droptype == warehousedefine.warehousetype.chip then
            propreward.type = droptype
            propreward.number = 1
            propreward.lv = 0
            propreward.cfgid = tonumber(normalmatId)
            table.insert(proprewardlist, propreward)

        elseif tonumber(droptype) == warehousedefine.warehousetype.blueprint then
            local bpreward = {}
            -- 蓝图配置表里第一位是B
            bpreward.cfgid = string.sub(normalmatId, 2, -1) 
            bpreward.number = 1
            table.insert(bprewardlist, bpreward)
        end
    end
    return bprewardlist, proprewardlist
end

local function getreward_mat(droplist)
    local proprewardlist = {}
    local bprewardlist = {}
    
    for i = 1, #droplist, 4 do
        local propreward = {}
        local normalmatId = droplist[i]
        local droptype = droplist[i + 1]
        local min = droplist[i + 2]
        local max = droplist[i + 3]
        -- 普通材料
        if droptype == warehousedefine.warehousetype.material then
            propreward.type = droptype
            propreward.number = min + math.random(0, max)
            propreward.lv = 0
            propreward.cfgid = normalmatId

            if propreward.number ~= 0 then
                table.insert(proprewardlist, propreward)
            end

        elseif droptype == warehousedefine.warehousetype.package then
            -- 注意!这里包裹后面的数字不管填多少都只roll一次
            local tmpbplist, tmpproplist = getmat_bypackage(normalmatId, 1)
            for i = 1, #tmpbplist do
                table.insert(bprewardlist, tmpbplist[i])
            end

            for i = 1, #tmpproplist do
                table.insert(proprewardlist, tmpproplist[i])
            end

        elseif droptype == warehousedefine.warehousetype.chip then
            propreward.type = droptype
            propreward.number = min + math.random(0, max)
            propreward.lv = 0
            propreward.cfgid = normalmatId

            if propreward.number ~= 0 then
                table.insert(proprewardlist, propreward)
            end
        elseif droptype == warehousedefine.warehousetype.blueprint then
            propreward.cfgid = "B" .. droplist[i]
            propreward.number = min + math.random(0, max)
            table.insert(bprewardlist, propreward)
        end
    end
    LOG_INFO("现在的蓝图列表: %s", tostring(bprewardlist))
    LOG_INFO("现在的材料列表：%s", tostring(proprewardlist))
    return bprewardlist, proprewardlist
end

local function getreward_exp()
    
end

function rewardhandler:ctor()
end

function rewardhandler:init()
    -- local dropmsg = self:getrewardinfo_battle(10001, true, 2)
end

function rewardhandler:getrewardinfo_battle(stageid, iswinner)
    local dropinfo = sharedata.deepcopy("drop_list", stageid)
    local dropmsg = {}    
    local droplist = {}
    local expectgold = 0
    local exp = 0

    --防止未找到配置数据报错
    if not dropinfo then
        return nil
    end
    if iswinner then
        droplist = dropinfo.Material_ID
        expectgold = dropinfo.Gold
        exp = dropinfo.EXP
    else
        droplist = dropinfo.Material_ID_D
        expectgold = dropinfo.Gold_D
        exp = dropinfo.EXP_D
    end
    
    local bprewardlist, proprewardlist = getreward_mat(droplist)
    local gold = getreward_gold(expectgold, proprewardlist)

    dropmsg.gold = math.floor(gold)
    dropmsg.exp = math.floor(exp)
    dropmsg.bprewardlist = bprewardlist
    dropmsg.proprewardlist = proprewardlist

    -- 运输机运输关卡获得材料用时(min)为:关卡等效金币*8/关卡收益
    dropmsg.transporttime = math.floor(dropinfo.Gold * 8 / dropinfo.Gold_permin) * 60

    dropmsg.transporttime = 30  --【测试使用】
    return dropmsg
end


---@return table 返回表数据
local function strtoarr(str)
    local blueprintarr = {}
    if #str % 6 == 0 then
        for i = 1, #str, 6 do
            table.insert(blueprintarr, "B" .. string.sub(str, i, i + 5))
        end
    else
        table.insert(blueprintarr, string.sub(str, 1, 7))
    end
    return blueprintarr
end

local function get_machine_name(chassis, body, firecontrol)
    body = tonumber(body)
    chassis = tonumber(chassis)
    firecontrol = tonumber(firecontrol)
	return sharedata.deepcopy("machinebody", body).Display .. 
		sharedata.deepcopy("machinechassis", chassis).Display ..
		sharedata.deepcopy("firecontrol", firecontrol).Display
end

---蓝图信息
function rewardhandler:getcastring_info(bpid, number)
    local blueprintarr = strtoarr(bpid)
    local bprewardlist, proprewardlist, equiplist = {}, {}, {}
    local time = 0

    for i = 1, #blueprintarr do
        local blueprintinfo = sharedata.deepcopy("blueprint", blueprintarr[i])
        local equiptype = tonumber(string.sub(blueprintarr[i], 2, 2))
        local cfgid = tonumber(string.sub(blueprintarr[i], 3, 7))
        
        time = time + blueprintinfo.Cast_Time * number

        if equiptype == blueprintdefine.blueprinttype.material then
            table.insert(proprewardlist, {type = warehousedefine.warehousetype.material, number = number, cfgid = cfgid})
        elseif equiptype == blueprintdefine.blueprinttype.chassis then
            table.insert(equiplist, {type = warehousedefine.warehousetype.chassis, number = number, lv = 1, cfgid = cfgid})
        elseif equiptype == blueprintdefine.blueprinttype.body then
            table.insert(equiplist, {type = warehousedefine.warehousetype.body, number = number, lv = 1, cfgid = cfgid})
        elseif equiptype == blueprintdefine.blueprinttype.firecontroller then
            table.insert(equiplist, {type = warehousedefine.warehousetype.firecontroller, number = number, lv = 1, cfgid = cfgid})
        elseif equiptype == blueprintdefine.blueprinttype.weapon then
            table.insert(equiplist, {type = warehousedefine.warehousetype.weapon, number = number, lv = 1, cfgid = cfgid})
        end
    end
    local dropmsg = {}    
    
    -- time = math.random(10, 100)  --【测试使用】

    dropmsg.bprewardlist = bprewardlist
    dropmsg.proprewardlist = proprewardlist
    dropmsg.equiplist = equiplist
    dropmsg.transporttime = math.floor(time)
    return dropmsg
end

---扫描信息
function rewardhandler:getscan_info(machineid)
    local machinecfg_dc = snax.queryservice("machinecfgdc")
    local equipment_dc = snax.queryservice("equipmentdc")
    -- local blueprintarr = strtoarr(casting_dc.req.getvalue(bpid, "blueprintid"))
    local machine = machinecfg_dc.req.get(machineid)
    local bprewardlist = {}
    local time = 0 

    local body = equipment_dc.req.getvalue(warehousedefine.warehousetype.body, string.split(machine.machinebody)[1], "cfgid")
    local chassis = equipment_dc.req.getvalue(warehousedefine.warehousetype.chassis, string.split(machine.machinechassis)[1], "cfgid")
    local firecontroller = equipment_dc.req.getvalue(warehousedefine.warehousetype.firecontroller, string.split(machine.firecontroller)[1], "cfgid")
    local name = get_machine_name(string.split(machine.machinechassis)[1], string.split(machine.machinebody)[1], string.split(machine.firecontroller)[1])

    local blueprintid = 1 .. chassis .. 2 .. body .. 3 .. firecontroller
    local blueprintarr = strtoarr(blueprintid)
    for i = 1, #blueprintarr do
        local blueprintinfo = sharedata.deepcopy("blueprint", blueprintarr[i])
        local mater = blueprintinfo.Material
        for j = 1, #mater, 3 do
            local material_list = sharedata.deepcopy("material_list", tonumber(mater[j + 2]))
            time = time + material_list.Scan_Time * tonumber(mater[j + 1])
        end
    end
    table.insert(bprewardlist, {type = warehousedefine.warehousetype.blueprint, number = 1, cfgid = blueprintid, name = name})

    time = 30 --【测试使用】

    local dropmsg = {}    

    dropmsg.bprewardlist = bprewardlist
    dropmsg.proprewardlist = {}
    dropmsg.equiplist = {}
    dropmsg.transporttime = math.floor(time)
    return dropmsg
end

---氪金购买需要传递价格
function rewardhandler:getshopmarket_info(data)
    local dropmsg, bprewardlist, proprewardlist = {}, {}, {}
    local time = 0

    for key, value in pairs(data) do
        local number = value.number or 1
        if value.type == warehousedefine.warehousetype.blueprint then
            local cfgidarr = strtoarr(tostring(value.cfgid))
            for i = 1, #cfgidarr do 
                local blueprint = sharedata.deepcopy("blueprint", cfgidarr[i])
                time = time + blueprint.Transport_Time * number
            end
            table.insert(bprewardlist, {number = number, cfgid = value.cfgid, price = value.price, iskh = 1})
        elseif value.type == warehousedefine.warehousetype.material then
            local material = sharedata.deepcopy("material_list", tonumber(value.cfgid))
            time = time + material.Transport_Time * number
            table.insert(proprewardlist, {type = value.type, number = number, cfgid = tonumber(value.cfgid), iskh = 0})
        end
    end
    dropmsg.bprewardlist = bprewardlist
    dropmsg.proprewardlist = proprewardlist
    dropmsg.equiplist = {}
    dropmsg.transporttime = math.floor(time)
    return dropmsg
end

return rewardhandler.new()