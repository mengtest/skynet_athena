local skynet = require "skynet"
require "skynet.manager"
local snax = require "snax"
local sharedata = require "skynet.sharedata"
local json = require "cjson"

--开服时间， 一年中的第几天
local begintime = 0


-- 服务器启动时需要初始化的数据表
local data_list = {
    "smaterialsdc",
    "sblueprintsdc",
    "marketdc",
    "chipsdc",
    "propsdc",
    "bagsdc",
    "infodc"
}

--- 系统每日更新时需要更新的表
local update_list = {
    "smaterialsdc",
    "sblueprintsdc",
    "marketdc",
    "daytaskdc",
    "infodc"
}

local services = {}
local update = {}

local function mystart()
	for _, name in pairs(data_list) do
		services[name] = snax.uniqueservice(name)
    end
    for _, name in pairs(update_list) do
		update[name] = snax.uniqueservice(name)
	end
end

---离当前时间最近的前半小时
local function neartime()
    local time = os.date("*t")
    local datetime = os.time(time)
    local min = time.min
    local sec = time.sec
    if min * 60 + sec >= 1800 then
        datetime = datetime - min * 60 - sec + 1800 
    else
        datetime = datetime - min * 60 - sec
    end
    return datetime
end

---当前天的零点
local function zerotime()
    local time = os.date("*t")
    time.min = 0
    time.sec = 0
    time.hour = 0
    return os.time(time)
end

---与当前日期间隔天数
local function gaptime(oldtime)
    local time = tonumber(os.date("%j", oldtime))
    return begintime - time
end

---服务器初始化时进行。材料数据直接读表覆盖，蓝图数据
local function initprice()
    local data = sharedata.deepcopy("material_list")
    -- local time = neartime()
    local zerotime = zerotime()
    for key, value in pairs(data) do
        local matedc = services["smaterialsdc"].req.get(key)
        local time24, timeday30 = {}, {}
        for i = 1, 48 do
            local netime = zerotime + (i - 1) * 1800
            local fuction = sharedata.deepcopy("fuction", netime)
            table.insert(time24, {["M" .. netime] = math.floor((fuction and fuction["M"..key] or 0) + 0.5)})
        end
        --30天中，每天保存3个点0：00， 8：00， 16：00
        for i = 1, 30 do
            local netime = zerotime - (i - 1) * 24 * 3600
            for j = 1, 3 do
                local time8 = netime + (j - 1) * 8 * 3600
                local fuction = sharedata.deepcopy("fuction", time8)
                table.insert(timeday30, {["M" .. time8] = math.floor((fuction and fuction["M"..key] or 0) + 0.5)})
            end
        end
        if matedc == nil then
            services["smaterialsdc"].req.add({id = key, name = value.Material_Name, arr = json.encode(time24), arrday = json.encode(timeday30)})
        else
            services["smaterialsdc"].req.update({id = key, name = value.Material_Name, arr = json.encode(time24), arrday = json.encode(timeday30)})
        end
    end

    data = sharedata.deepcopy("blueprint")
    for key, value in pairs(data) do
        local key = tonumber(string.sub(key, 2, -1))
        local blues = services["sblueprintsdc"].req.get(key)
        if blues == nil then
            local time24, timeday30 = {}, {}
            for i = 1, 48 do
                local netime = zerotime + (i - 1) * 1800
                table.insert(time24, {["M" .. netime] = 0})
            end
            --30天中，每天保存3个点0：00， 8：00， 16：00
            for i = 1, 30 do
                local netime = zerotime - (i - 1) * 24 * 3600
                for j = 1, 3 do
                    local time8 = netime + (j - 1) * 8 * 3600
                    table.insert(timeday30, {["M" .. time8] = 0})
                end
            end
            services["sblueprintsdc"].req.add({id = key, name = value.Blueprint_Name, arr = json.encode(time24), arrday = json.encode(timeday30)})
        end
    end

    --对已有数据进行更新（可能服务器隔数日才启动中间记录不存在）
    data = services["sblueprintsdc"].req.getAll()
    local gapnum, oldtimezero
    --获取记录的时间
    for index, value in pairs(data) do
        local arr = json.decode(value.arr)
        for key, value in pairs(arr[1]) do
            oldtimezero = tonumber(string.sub(key, 2, -1))
            gapnum = gaptime(tonumber(string.sub(key, 2, -1)))
            skynet.error("记录的最新时间:", os.date("%c", tonumber(string.sub(key, 2, -1))), " 相隔时间: ", gapnum)
            break
        end
        break
    end
    if gapnum ~= 0 then
        for _, value in pairs(data) do
            local time24 = {}
            local oldtime24 = json.decode(value.arr)
            local timeday30 = json.decode(value.arrday)
            for i = 1, 48 do
                local netime = zerotime + (i - 1) * 1800
                table.insert(time24, {["M" .. netime] = 0})
            end
            for i = gapnum, 1, -1 do
                if i == gapnum then
                    local curzerotime = zerotime - (i - 1) * 24 * 3600
                    --【注意处理每天0点的价格，因为0点价格是昨天16：00---24：00的价格，所以特殊处理】
                    for j = 3, 1, -1 do
                        --处理0点价格
                        if j == 1 then
                            --记录那天的16：00时间
                            local oldtime = curzerotime - 8 * 3600
                            local is = false
                            for k = 1, 16 do
                                local old = oldtime + 1800 * (k - 1)
                                if oldtime24[32 + k]["M" .. old] ~= 0 then
                                    table.insert(timeday30, 1, {["M" .. curzerotime] = oldtime24[32 + k]["M" .. old]})
                                    is = true
                                    break
                                end
                            end
                            if not is then
                                table.insert(timeday30, 1, {["M" .. curzerotime] = 0})
                            end
                        else
                            local time8 = curzerotime + (j - 1) * 8 * 3600
                            table.insert(timeday30, 1, {["M" .. time8] = 0})
                        end
                        table.remove(timeday30, 91)
                    end
                else
                    local netime = zerotime - (i - 1) * 24 * 3600
                    for j = 3, 1, -1 do
                        local time8 = netime + (j - 1) * 8 * 3600
                        table.insert(timeday30, 1, {["M" .. time8] = 0})
                        table.remove(timeday30, 91)
                    end
                end
            end
            services["sblueprintsdc"].req.update({id = value.id, name = value.name, arr = json.encode(time24), arrday = json.encode(timeday30)})
        end
    end

    data = services["marketdc"].req.get(1)
    local timeday = {}
    for i = 1, 8 do
        local netime = zerotime - (i - 1) * 24 * 3600
        for j = 1, 3 do
            local time8 = netime + (j - 1) * 8 * 3600
            local allfuction = sharedata.deepcopy("all_fuction", time8)
            table.insert(timeday, {["M" .. time8] = math.floor((allfuction and allfuction.Index or 0) * 100) * 0.01})
        end
    end
    if data == nil then
        services["marketdc"].req.add({id = 1, marketinfo = json.encode(timeday)})
    else
        services["marketdc"].req.update({id = 1, marketinfo = json.encode(timeday)})
    end


    --初始化游戏记录信息表
    data = services["infodc"].req.get(zerotime)
    if not next(data) then
        services["infodc"].req.add({id = zerotime, pvpsum = 0, pvpnum_1 = 0, pvpnum_2 = 0, pvpnum_3 = 0, pvesum = 0, 
        pvenum_1 = 0, pvenum_2 = 0, pvenum_3 = 0, roomsum = 0, ipsum = 0, playingsum = 0, battlenum = 0})
    else
        services["infodc"].req.setvalue(zerotime, "roomsum", 0)
        services["infodc"].req.setvalue(zerotime, "battlenum", 0)
    end
end

--当前时间离24点时间的秒数
local function timesec()
    local time = os.date("*t")
    local datetime = os.time(time)
    local hour = time.hour
    local min = time.min
    local sec = time.sec
    local sumsec = hour * 3600 + min * 60 + sec
    return 24 * 3600 - sumsec
end

local function updatesys()
    skynet.timeout(24 * 3600 * 100, updatesys)
    skynet.error("====================价格更新=================")
    LOG_INFO("====================价格更新=================")
    local zerotime = zerotime()
    local data = update["smaterialsdc"].req.getAll()
    for _, value in pairs(data) do
        local time24, timeday30 = {}, {}
        for i = 1, 48 do
            local netime = zerotime + (i - 1) * 1800
            local fuction = sharedata.deepcopy("fuction", netime)
            table.insert(time24, {["M" .. netime] = math.floor((fuction and (fuction["M"..value.id] or 0) or 0) + 0.5)})
        end
        for i = 1, 30 do
            local netime = zerotime - (i - 1) * 24 * 3600
            for j = 1, 3 do
                local time8 = netime + (j - 1) * 8 * 3600
                local fuction = sharedata.deepcopy("fuction", time8)
                table.insert(timeday30, {["M" .. time8] = math.floor((fuction and (fuction["M"..value.id] or 0) or 0) + 0.5)})
            end
        end
        update["smaterialsdc"].req.update({id = value.id, name = value.name, arr = json.encode(time24), arrday = json.encode(timeday30)})
    end

    data = update["marketdc"].req.get(1)
    local timeday = {}
    for i = 1, 8 do
        local netime = zerotime - (i - 1) * 24 * 3600
        for j = 1, 3 do
            local time8 = netime + (j - 1) * 8 * 3600
            local allfuction = sharedata.deepcopy("all_fuction", time8)
            table.insert(timeday, {["M" .. time8] = math.floor((allfuction and (allfuction.Index or 0) or 0) * 100) * 0.01 or 0.0})
        end
    end
    update["marketdc"].req.update({id = data.id, marketinfo = json.encode(timeday)})

    data = update["sblueprintsdc"].req.getAll()
    for _, value in pairs(data) do
        local time24 = {}
        local oldtime24 = json.decode(value.arr)
        local timeday30 = json.decode(value.arrday)
        for i = 1, 48 do
            local netime = zerotime + (i - 1) * 1800
            table.insert(time24, {["M" .. netime] = 0})
        end
        for j = 3, 1, -1 do
            --【注意处理每天0点的价格，因为0点价格是昨天16：00---24：00的价格，所以特殊处理】
            if j == 1 then
                --昨天16：00时间
                local oldtime = zerotime - 8 * 3600
                local is = false
                for k = 1, 16 do
                    local old = oldtime + 1800 * (k - 1)
                    if oldtime24[32 + k]["M" .. old] ~= 0 then
                        table.insert(timeday30, 1, {["M" .. zerotime] = oldtime24[32 + k]["M" .. old]})
                        is = true
                        break
                    end
                end
                if not is then
                    table.insert(timeday30, 1, {["M" .. zerotime] = 0})
                end
            else
                local time8 = zerotime + (j - 1) * 8 * 3600
                table.insert(timeday30, 1, {["M" .. time8] = 0})
            end
            table.remove(timeday30, 91)
        end
        update["sblueprintsdc"].req.update({id = value.id, name = value.name, arr = json.encode(time24), arrday = json.encode(timeday30)})
    end
    skynet.error("====================更新完成=================")
    LOG_INFO("====================更新完成=================")

    skynet.error("====================任务更新=================")
    LOG_INFO("====================任务更新=================")
    data = update["daytaskdc"].req.getAll()
    for _, value in pairs(data) do
        local progress = json.decode(value.progress)
        for _, val in pairs(progress) do
            val.number = 0
        end
        update["daytaskdc"].req.setvalue(value.id, "type", achievementdefine.indextype.numing)
        update["daytaskdc"].req.setvalue(value.id, "progress", json.encode(progress))
    end
    skynet.error("====================更新完成=================")
    LOG_INFO("====================更新完成=================")

    services["infodc"].req.add({id = zerotime, pvpsum = 0, pvpnum_1 = 0, pvpnum_2 = 0, pvpnum_3 = 0, pvesum = 0, 
        pvenum_1 = 0, pvenum_2 = 0, pvenum_3 = 0, roomsum = 0, ipsum = 0, playingsum = 0, battlenum = 0})
    skynet.error("====================信息表添加记录完成=================")
    LOG_INFO("====================信息表添加记录完成=================")
end

---初始化后台数据表
local function initdata()
    local data = sharedata.deepcopy("store")
    for key, value in pairs(data) do
        local propinfo = services["propsdc"].req.get(key)
        if not next(propinfo) then
            services["propsdc"].req.add({id = key, name = value.Goods_Name, price = value.Price})
        end
    end
    data = sharedata.deepcopy("mod")
    for key, value in pairs(data) do
        local propinfo = services["chipsdc"].req.get(key)
        if not next(propinfo) then
            services["chipsdc"].req.add({id = key, name = value.Mod_Name})
        end
    end
    data = sharedata.deepcopy("store_bag")
    for key, value in pairs(data) do
        local propinfo = services["bagsdc"].req.get(key)
        if not next(propinfo) then
            services["bagsdc"].req.add({id = key, name = value.Goods_Name, price = value.Price})
        end
    end
end

skynet.start(function()
    begintime = tonumber(os.date("%j"))
    mystart()
    initprice()
    initdata()
    skynet.timeout(timesec() * 100, updatesys)
    skynet.error(string.format("begin service time: %s, in day: %d", os.date("%c"), begintime))
    -- skynet.exit()
end)
