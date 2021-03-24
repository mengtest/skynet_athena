local shophandler = class("shophandler")
local skynet = require "skynet"
local errCodeDef = require "errcodedef"
local sharedata = require "skynet.sharedata"
local json = require "cjson"
local timext = require "timext"
local queue = require "skynet.queue"
local cs = queue()

local market_dc
local putaway_dc
local shopitem_dc
local shopiteminfo_dc
local putawaygold_dc
local stayputaway_dc
local putawayinfo_dc
local smaterials_dc
local sblueprint_dc
local sale_dc
local special_dc
local bag_dc
local bqproxy
local warehouse
local scan
local chip

---行情数据保存材料蓝图的0点价格、最新价、最低价、最高价
local marketdata = {blueprint = {}, material = {}}



---当前时间的30分钟整数倍  0:0-0:30返回1 0:30-1:0返回2 
---@param addtime integer 增加时间
---@return  integer 三个返回值 索引、主键、零点时间戳
local function timeindex(addtime)
    local datetime = os.time() + (addtime or 0)
    local time = os.date("*t", datetime)
    local newtime, zerotime = 0, time
    local hour = time.hour
    local min = time.min
    local sec = time.sec
    local sumsec = hour * 60 + min
    ---离当前时间最近的前半小时
    if min * 60 + sec >= 1800 then
        newtime = datetime - min * 60 - sec + 1800 
    else
        newtime = datetime - min * 60 - sec
    end
    ---当前天的零点
    zerotime.min = 0
    zerotime.sec = 0
    zerotime.hour = 0
    return math.max(0, math.ceil((sumsec - 29) / 30)) + 1, "M" .. newtime, os.time(zerotime)
end

function shophandler:ctor()
end

function shophandler:initshophandler(market, sblueprint, putaway, putawaygold, stayputaway, putawayinfo, smater, shopitem, shopiteminfo, bq, ware, sc, sale, special, bag, chi)
    market_dc, sblueprint_dc, putaway_dc, putawaygold_dc, stayputaway_dc, putawayinfo_dc, smaterials_dc, shopitem_dc, shopiteminfo_dc, bqproxy, warehouse, 
    scan, sale_dc, special_dc, bag_dc, chip = 
        market, sblueprint, putaway, putawaygold, stayputaway, putawayinfo, smater, shopitem, shopiteminfo, bq, ware, sc, sale, special, bag, chi
end

---交易市场列表请求
function shophandler:dealinfo(data)
    local ret = {}
    ret.datainfos = {}
    local uid = data.uid
    local beginindex = data.msg.beginindex or 1
    local endindex = data.msg.endindex or 100

    ret.code = errCodeDef.eEC_success
    local putaway = putaway_dc.req.getAll()
    
    local index, key = timeindex()
    --目前写死【所有材料】
    for i = 10001, 10025 do
        local smaterials = smaterials_dc.req.get(i)
        local arr = json.decode(smaterials.arr)
        local arrday = json.decode(smaterials.arrday)
        table.insert(ret.datainfos, {cfgid = tostring(i), number = 999, price = arr[index][key], index = warehousedefine.warehousetype.material})
    end
    for key, value in pairs(putaway) do
        table.insert(ret.datainfos, {id = key, cfgid = tostring(value.cfgid), number = value.number, price = value.price, index = value.type, puttime = value.puttime})
    end
    return ret
end

---行情折线图列表请求
function shophandler:marketpic(data)
    local ret = {}
    ret.datainfos = {}
    local uid = data.uid

    ret.code = errCodeDef.eEC_success
    local market = market_dc.req.get(1)
    if market == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local marketinfo = json.decode(market.marketinfo)

    local indextime, _, zerotime = timeindex()
    for i = 8, 1, -1 do
        local netime = zerotime - (i - 1) * 24 * 3600
        if i == 1 then
            for j = 1, math.ceil(indextime / 16) do
                local time8 = netime + (j - 1) * 8 * 3600
                table.insert(ret.datainfos, {time = time8, price = marketinfo[j]["M" .. time8]})
            end
        elseif i == 8 then
            for j = 2, 3 do
                local time8 = netime + (j - 1) * 8 * 3600
                table.insert(ret.datainfos, {time = time8, price = marketinfo[(i - 1) * 3 + j]["M" .. time8]})
            end
        else
            for j = 1, 3 do
                local time8 = netime + (j - 1) * 8 * 3600
                table.insert(ret.datainfos, {time = time8, price = marketinfo[(i - 1) * 3 + j]["M" .. time8]})
            end
        end
    end
    return ret
end

---行情数据列表请求
function shophandler:marketdatamate(data)
    local ret = {}
    local uid = data.uid
    
    ret.code = errCodeDef.eEC_success
    if not next(marketdata.material) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.datainfos = marketdata.material
    return ret
end

---行情数据列表请求蓝图
function shophandler:marketdatablue(data)
    local ret = {}
    local uid = data.uid
    
    ret.code = errCodeDef.eEC_success
    if not next(marketdata.material) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.datainfos = marketdata.blueprint
    return ret
end

---上架列表请求
function shophandler:putawayinfo(data)
    local ret = {}
    ret.datainfos = {}
    local uid = data.uid

    local putawayinfo = putawayinfo_dc.req.get(uid)
    if putawayinfo == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = errCodeDef.eEC_success
    local goldarr = string.split(putawayinfo.goldarr)
    local khoriumarr = string.split(putawayinfo.khoriumarr)
    local staygoldarr = string.split(putawayinfo.staygoldarr)
    local staykhoriumarr = string.split(putawayinfo.staykhoriumarr)
    local curtime = timext.current_time()

    for i = 1, #goldarr do
        local putaway = putawaygold_dc.req.get(tonumber(goldarr[i]))
        if next(putaway) then
            table.insert(ret.datainfos, {cfgid = tostring(putaway.cfgid), number = putaway.number, price = putaway.price, index = putaway.type,
                countdown = math.max(0, putaway.downtime - curtime), state = true})
        end
    end
    for i = 1, #khoriumarr do
        local putaway = putaway_dc.req.get(tonumber(khoriumarr[i]))
        if next(putaway) then
            table.insert(ret.datainfos, {cfgid = tostring(putaway.cfgid), number = putaway.number, price = putaway.price,  index = putaway.type,
                countdown = math.max(0, putaway.downtime - curtime), state = true})
        end
    end
    for i = 1, #staygoldarr do
        local putaway = stayputaway_dc.req.get(tonumber(staygoldarr[i]))
        if next(putaway) then
            table.insert(ret.datainfos, {cfgid = tostring(putaway.cfgid), number = putaway.number, price = putaway.price,  index = putaway.type,
                countdown = math.max(0, putaway.downtime - curtime), state = false})
        end
    end
    for i = 1, #staykhoriumarr do
        local putaway = stayputaway_dc.req.get(tonumber(staykhoriumarr[i]))
        if next(putaway) then
            table.insert(ret.datainfos, {cfgid = tostring(putaway.cfgid), number = putaway.number, price = putaway.price,  index = putaway.type,
                countdown = math.max(0, putaway.downtime - curtime), state = false})
        end
    end
    return ret
end

---材料详情走势图数据
function shophandler:matedetails(data)
    local ret = {}
    ret.datainfos = {}
    local uid = data.uid
    local type = data.msg.type
    local cfgid = data.msg.cfgid

    if type == nil or cfgid == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    local smaterials = smaterials_dc.req.get(cfgid)
    if smaterials == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    local indextime, _, zerotime = timeindex()
    if type == warehousedefine.shopindex.oneday then
        local arr = json.decode(smaterials.arr)
        for i = 1, indextime do
            local time8 = zerotime + (i - 1) * 1800
            table.insert(ret.datainfos, {time = time8, price = arr[i]["M" .. time8]})
        end
    elseif type == warehousedefine.shopindex.sevenday then
        local arrday = json.decode(smaterials.arrday)
        for i = 7, 1, -1 do
            local netime = zerotime - (i - 1) * 24 * 3600
            if i == 1 then
                for j = 1, math.ceil(indextime / 16) do
                    local time8 = netime + (j - 1) * 8 * 3600
                    table.insert(ret.datainfos, {time = time8, price = arrday[j]["M" .. time8]})
                end
            else
                for j = 1, 3 do
                    local time8 = netime + (j - 1) * 8 * 3600
                    table.insert(ret.datainfos, {time = time8, price = arrday[(i - 1) * 3 + j]["M" .. time8]})
                end
            end
        end
    elseif type == warehousedefine.shopindex.thirtyday then
        local arrday = json.decode(smaterials.arrday)
        for i = 30, 1, -1 do
            local netime = zerotime - (i - 1) * 24 * 3600
            if i == 1 then
                for j = 1, math.ceil(indextime / 16) do
                    local time8 = netime + (j - 1) * 8 * 3600
                    table.insert(ret.datainfos, {time = time8, price = arrday[j]["M" .. time8]})
                end
            else
                for j = 1, 3 do
                    local time8 = netime + (j - 1) * 8 * 3600
                    table.insert(ret.datainfos, {time = time8, price = arrday[(i - 1) * 3 + j]["M" .. time8]})
                end
            end
        end
    else
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = errCodeDef.eEC_success
    return ret
end

---蓝图详情走势图数据
function shophandler:bluedetails(data)
    local ret = {}
    ret.datainfos = {}
    local uid = data.uid
    local type = data.msg.type
    local cfgid = data.msg.cfgid

    if type == nil or cfgid == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    local sblueprint = sblueprint_dc.req.get(cfgid)
    if sblueprint == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    local indextime, _, zerotime = timeindex()
    if type == warehousedefine.shopindex.oneday then
        local arr = json.decode(sblueprint.arr)
        for i = 1, indextime do
            local time8 = zerotime + (i - 1) * 1800
            table.insert(ret.datainfos, {time = time8, price = arr[i]["M" .. time8]})
        end
    elseif type == warehousedefine.shopindex.sevenday then
        local arrday = json.decode(sblueprint.arrday)
        for i = 7, 1, -1 do
            local netime = zerotime - (i - 1) * 24 * 3600
            if i == 1 then
                for j = 1, math.ceil(indextime / 16) do
                    local time8 = netime + (j - 1) * 8 * 3600
                    table.insert(ret.datainfos, {time = time8, price = arrday[j]["M" .. time8]})
                end
            else
                for j = 1, 3 do
                    local time8 = netime + (j - 1) * 8 * 3600
                    table.insert(ret.datainfos, {time = time8, price = arrday[(i - 1) * 3 + j]["M" .. time8]})
                end
            end
        end
    elseif type == warehousedefine.shopindex.thirtyday then
        local arrday = json.decode(sblueprint.arrday)
        for i = 30, 1, -1 do
            local netime = zerotime - (i - 1) * 24 * 3600
            if i == 1 then
                for j = 1, math.ceil(indextime / 16) do
                    local time8 = netime + (j - 1) * 8 * 3600
                    table.insert(ret.datainfos, {time = time8, price = arrday[j]["M" .. time8]})
                end
            else
                for j = 1, 3 do
                    local time8 = netime + (j - 1) * 8 * 3600
                    table.insert(ret.datainfos, {time = time8, price = arrday[(i - 1) * 3 + j]["M" .. time8]})
                end
            end
        end
    else
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = errCodeDef.eEC_success
    return ret
end

---运输机取消
function shophandler:trancancel(uid, index, cfgid, iskh, number, price)
    if not uid or  not index or not cfgid or iskh == nil or (iskh == 1 and not price) then
        return errCodeDef.eEC_err_param
    end

    if price == nil then
        local smaterials = smaterials_dc.req.get(tonumber(cfgid))
        local arr = json.decode(smaterials.arr)
        local index, key = timeindex(30 * 60)
        price = price or (arr[index][key] and arr[index][key] or 0)
    end

    local putawayinfo = putawayinfo_dc.req.get(uid)
    local goldarr = string.split(putawayinfo.staygoldarr)
    local khoriumarr = string.split(putawayinfo.staykhoriumarr)

    local nextid = stayputaway_dc.req.get_nextid()

    stayputaway_dc.req.add({id = nextid, cfgid = cfgid, number = number, iskh = iskh, price = price, type = index,
        puttime = timext.current_time(), downtime = timext.current_time() + (iskh == 0 and 1800 or (3600 * 24)), uid = uid})
    if iskh == 1 then
        table.insert(khoriumarr, nextid)
        putawayinfo_dc.req.setvalue(uid, "staykhoriumarr", string.join(khoriumarr))
    else
        table.insert(goldarr, nextid)
        putawayinfo_dc.req.setvalue(uid, "staygoldarr",  string.join(goldarr))
    end

    return errCodeDef.eEC_success
end

---上架
function shophandler:putaway(data)
    local ret = {}
    local uid = data.uid
    local index = data.msg.index
    local cfgid = data.msg.cfgid
    local number = data.msg.number or 1
    local price = data.msg.price
    local isnew = data.msg.isnew 
    
    local iskh
    if not index or not cfgid or isnew == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    if index == warehousedefine.warehousetype.material then
        iskh = 0
    elseif index == warehousedefine.warehousetype.blueprint then
        iskh = 1
    end
    if iskh == 1 and price == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    cfgid = cfgid:match("(%d*)")

    if price == nil then
        local smaterials = smaterials_dc.req.get(tonumber(cfgid))
        local arr = json.decode(smaterials.arr)
        local index, key = timeindex(30 * 60)
        price = price or (arr[index][key] and arr[index][key] or 0)
    end

    local putawayinfo = putawayinfo_dc.req.get(uid)
    local staygoldarr = string.split(putawayinfo.staygoldarr)
    local staykhoriumarr = string.split(putawayinfo.staykhoriumarr)
    local goldarr = string.split(putawayinfo.goldarr)
    local khoriumarr = string.split(putawayinfo.khoriumarr)

    --上架列表最多10条
    if #staygoldarr + #staykhoriumarr + #goldarr + #khoriumarr >= 10 then
        ret.code = errCodeDef.eEC_shop_full
        return ret
    end

    local nextid = stayputaway_dc.req.get_nextid()

    --物品移除
    local waresult, scresult = true, true
    if index == warehousedefine.warehousetype.material then
        waresult = warehouse.req.remmaterials(uid, tonumber(cfgid), number)
    elseif index == warehousedefine.warehousetype.blueprint then
        if isnew then
            scresult = scan.req.remblueprint(uid, cfgid, number, nil, 3)
        else
            scresult = scan.req.remblueprint(uid, cfgid, number, nil, 2)
        end
    end
    if waresult and scresult then
        stayputaway_dc.req.add({id = nextid, cfgid = cfgid, number = number, iskh = iskh, price = price, type = index,
            puttime = timext.current_time(), downtime = timext.current_time() + (iskh == 0 and 1800 or (3600 * 24)), uid = uid})
        if iskh == 1 then
            table.insert(staykhoriumarr, nextid)
            putawayinfo_dc.req.setvalue(uid, "staykhoriumarr", string.join(staykhoriumarr))
        else
            table.insert(staygoldarr, nextid)
            putawayinfo_dc.req.setvalue(uid, "staygoldarr",  string.join(staygoldarr))
        end
        ret.code = errCodeDef.eEC_success
    else
        ret.code = errCodeDef.eEC_cfgid_nofind
    end
    return ret
end

---出售
function shophandler:sell(data)
    local ret = {}
    local uid = data.uid
    local shopid = data.msg.shopid
    
    local iskh
    if not shopid then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    local shopiteminfo = string.split(shopiteminfo_dc.req.getvalue(uid, "shopiteminfo"))
    if not table.find(shopiteminfo, tostring(shopid)) then
        ret.code = errCodeDef.eEC_cfgid_nofind
        return ret
    end
    local shopitem = shopitem_dc.req.get(shopid)
    if not next(shopitem) then
        ret.code = errCodeDef.eEC_cfgid_nofind
        return ret
    end

    if shopitem.iskh == 0 then
        local smaterials = smaterials_dc.req.get(tonumber(shopitem.cfgid))
        local arr = json.decode(smaterials.arr)
        local index, key = timeindex(30 * 60)
        shopitem.price = arr[index][key] and arr[index][key] or 0
    end

    local putawayinfo = putawayinfo_dc.req.get(uid)
    local staygoldarr = string.split(putawayinfo.staygoldarr)
    local staykhoriumarr = string.split(putawayinfo.staykhoriumarr)
    local goldarr = string.split(putawayinfo.goldarr)
    local khoriumarr = string.split(putawayinfo.khoriumarr)

    --上架列表最多10条
    if #staygoldarr + #staykhoriumarr + #goldarr + #khoriumarr >= 10 then
        ret.code = errCodeDef.eEC_shop_full
        return ret
    end

    transaction()
    local nextid = stayputaway_dc.req.get_nextid()
    stayputaway_dc.req.add({id = nextid, cfgid = shopitem.cfgid, number = shopitem.number, iskh = shopitem.iskh, price = shopitem.price * shopitem.number, 
        type = shopitem.type, puttime = timext.current_time(), downtime = timext.current_time() + (shopitem.iskh == 0 and 1800 or (3600 * 24)), uid = uid})
    if shopitem.iskh == 1 then
        table.insert(staykhoriumarr, nextid)
        putawayinfo_dc.req.setvalue(uid, "staykhoriumarr", string.join(staykhoriumarr))
    else
        table.insert(staygoldarr, nextid)
        putawayinfo_dc.req.setvalue(uid, "staygoldarr",  string.join(staygoldarr))
    end
    shopitem_dc.req.delete({id = shopid})
    table.remove(shopiteminfo, table.find(shopiteminfo, tostring(shopid)))
    shopiteminfo_dc.req.setvalue(uid, "shopiteminfo", string.join(shopiteminfo))
    commit()
    ret.code = errCodeDef.eEC_success
    return ret
end

---获取通过金币出售当前价格
function shophandler:curprice(data)
    local ret = {}
    local uid = data.uid
    local index = data.msg.index
    local cfgid = data.msg.cfgid

    if index == nil or cfgid == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local smaterials = smaterials_dc.req.get(tonumber(cfgid))
    local arr = json.decode(smaterials.arr)
    local index, key = timeindex()
    if arr[index][key] == nil then
        ret.code = errCodeDef.eEC_cfgid_nofind
        return ret
    end
    ret.price = math.floor(arr[index][key])
    ret.code = errCodeDef.eEC_success
    return ret
end

---获取扫描蓝图名称
local function get_machine_name(chassis, body, firecontrol)
    body = tonumber(body)
    chassis = tonumber(chassis)
    firecontrol = tonumber(firecontrol)
	return sharedata.deepcopy("machinebody", body).Display .. 
		sharedata.deepcopy("machinechassis", chassis).Display ..
		sharedata.deepcopy("firecontrol", firecontrol).Display
end

local function addsblueprint(cfgid, price)
    local blues = services["sblueprintsdc"].req.get(cfgid)
    local zerotime = zerotime()
    local data = sharedata.deepcopy("blueprint", "B" .. cfgid)
    local name = data and data.Blueprint_Name or get_machine_name(string.sub(cfgid, 1, 5),string.sub(cfgid, 6, 10),string.sub(cfgid, 11, 15))

    local index = timeindex()
    if not next(blues) then
        local time24, timeday30 = {}, {}
        for i = 1, 48 do
            local netime = zerotime + (i - 1) * 1800
            if i == index then
                table.insert(time24, {["M" .. netime] = price})
            else
                table.insert(time24, {["M" .. netime] = 0})
            end
        end
        for i = 1, 30 do
            local netime = zerotime - (i - 1) * 24 * 3600
            if i == 1 then
                table.insert(timeday30, {["M" .. netime] = price})
            else
                table.insert(timeday30, {["M" .. netime] = 0})
            end
        end
        services["sblueprintsdc"].req.add({id = cfgid, name = name, arr = json.encode(time24), arrday = json.encode(timeday30)})
    end

end

local function khoriumbuy_queue(uid, idandnum, shopiteminfo, oneprice, sumnumber)
    local cfgid, type
    --此处使用事务
    transaction()
    for _, value in pairs(idandnum) do
        local putaway = putaway_dc.req.get(value.id)
        local putawayinfo = putawayinfo_dc.req.get(putaway.uid)
        local khoriumarr = string.split(putawayinfo.khoriumarr)
        
        warehouse.req.addkhorium(putaway.uid, oneprice * value.number)
        if putaway.number == value.number then
            table.remove(khoriumarr, table.find(khoriumarr, tostring(value.id)))
            putawayinfo_dc.req.setvalue(putaway.uid, "khoriumarr", string.join(khoriumarr))
            putaway_dc.req.delete({id = value.id})
        else
            putaway_dc.req.setvalue(value.id, "number", putaway.number - value.number)
        end
        if cfgid == nil then
            cfgid = putaway.cfgid
        end
        if type == nil then
            type = putaway.type
        end
    end
    local nextid = shopitem_dc.req.get_nextid()
    table.insert(shopiteminfo, nextid)
    shopitem_dc.req.add({id = nextid, cfgid = cfgid, number = sumnumber, 
        price = oneprice, type = type, shoptime = timext.current_time(), iskh = 1, uid = uid})
    shopiteminfo_dc.req.setvalue(uid, "shopiteminfo", string.join(shopiteminfo))
    warehouse.req.remkhorium(uid, oneprice * sumnumber)
    commit()
end

---氪金购买
function shophandler:khoriumbuy(data)
    local ret = {}
    local uid = data.uid
    local idandnum = data.msg.idandnum

    if not idandnum or not next(idandnum) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local sumnumber = 0
    local oneprice, cfgid
    for i = 1, #idandnum do
        if idandnum[i].id == nil or  idandnum[i].number == nil then
            ret.code = errCodeDef.eEC_err_param
            return ret 
        end
        sumnumber = sumnumber + idandnum[i].number
        local putaway = putaway_dc.req.get(idandnum[i].id)
        if not next(putaway) or putaway.number < idandnum[i].number then
            ret.code = errCodeDef.eEC_err_param
            return ret
        elseif oneprice == nil and cfgid == nil then
            oneprice = putaway.price
            cfgid = putaway.cfgid
        end
    end
    --氪金是否足够
    if not warehouse.req.matchkhorium(uid, sumnumber * oneprice) then
        ret.code = errCodeDef.eEC_gold_notEnough
        return ret
    end
    --栏位是否足够
    local shopiteminfo = string.split(shopiteminfo_dc.req.getvalue(uid, "shopiteminfo"))
    if #shopiteminfo >= 10 then
        ret.code = errCodeDef.eEC_shop_full
        return ret
    end

    ret.code = errCodeDef.eEC_success
    cs(khoriumbuy_queue, uid, idandnum, shopiteminfo, oneprice, sumnumber)

    --记录数据  此处保存同一种类的物品，每半个小时的第一笔交易。30天中今天的价格在此处理
    local sblueprint = sblueprint_dc.req.get(cfgid)
    local indextime, neartime, zerotime = timeindex()
    if sblueprint == nil then
        local name = get_machine_name(string.sub(cfgid, 1, 5),string.sub(cfgid, 6, 10),string.sub(cfgid, 11, 15))
        local time24, timeday30 = {}, {}
        for i = 1, 48 do
            local netime = zerotime + (i - 1) * 1800
            if i == indextime then
                table.insert(time24, {["M" .. netime] = oneprice})
            else
                table.insert(time24, {["M" .. netime] = 0})
            end
        end
        for i = 1, 30 do
            local netime = zerotime - (i - 1) * 24 * 3600
            if i == 1 then
                --【注意】0点时间价格不统计，因为0点价格是昨天16：00---24：00的价格，所以在价格更新时处理
                for j = 2, 3 do
                    local time8 = netime + (j - 1) * 8 * 3600
                    if math.ceil(indextime / 16) == j then
                        table.insert(timeday30, {["M" .. time8] = oneprice})
                    else
                        table.insert(timeday30, {["M" .. time8] = 0})
                    end
                end
            else
                for j = 1, 3 do
                    local time8 = netime + (j - 1) * 8 * 3600
                    table.insert(timeday30, {["M" .. netime] = 0})
                end
            end
        end
        sblueprint_dc.req.add({id = tostring(cfgid), name = name, arr = json.encode(time24), arrday = json.encode(timeday30)})
    else
        --只保存这一时间段第一个交易的价格
        local arr = json.decode(sblueprint.arr)
        if arr[indextime][neartime] == 0 then
            local arrday = json.decode(sblueprint.arrday)

            arr[indextime][neartime] = oneprice
            if math.ceil(indextime / 16) + 1 <= 3 then
                arrday[math.ceil(indextime / 16) + 1]["M" .. zerotime + (math.ceil(indextime / 16) * 8 * 3600)] = oneprice
            end
            sblueprint_dc.req.update({id = tostring(cfgid), name = sblueprint.name, arr = json.encode(arr), arrday = json.encode(arrday)})
        end
    end
    return ret
end

---金币购买
function shophandler:goldbuy(data)
    local ret = {}
    local uid = data.uid
    local cfgid = data.msg.cfgid
    local index = data.msg.index
    local number = data.msg.number or 1
    local price = data.msg.price

    if not cfgid or not price or not index then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    if not warehouse.req.matchgold(uid, price * number) then
        ret.code = errCodeDef.eEC_gold_notEnough
        return ret
    end
    local shopiteminfo = string.split(shopiteminfo_dc.req.getvalue(uid, "shopiteminfo"))
    if #shopiteminfo >= 10 then
        ret.code = errCodeDef.eEC_shop_full
        return ret
    end

    local indexnum, key = timeindex()

    if index == warehousedefine.warehousetype.material then
        local smaterial = smaterials_dc.req.get(cfgid)
        local arr = json.decode(smaterial.arr)
        local currentprice = tonumber(arr[indexnum][key])
        if currentprice ~= price then
            ret.code = errCodeDef.eEC_shop_price
            return ret 
        end
        local result
        local nextid = shopitem_dc.req.get_nextid()
        table.insert(shopiteminfo, nextid)
        transaction()
        result = shopitem_dc.req.add({id = nextid, cfgid = cfgid, number = number, price = price, type = index, shoptime = timext.current_time(), iskh = 0, uid = uid})
        result = result and shopiteminfo_dc.req.setvalue(uid, "shopiteminfo", string.join(shopiteminfo))

        result = result and warehouse.req.remgold(uid, price * number)
        if result then
            ret.code = errCodeDef.eEC_success
            commit()
        else
            ret.code = errCodeDef.eEC_err_param
            rollback()
        end
    elseif index == warehousedefine.warehousetype.prop then
    end
    return ret
end

---从礼包中添加数据到仓库
---并且移除货币
local function getbaginfo(uid, cfgid, number, type)
    local datainfo
    if type == warehousedefine.storeindex.sale then
        datainfo = sale_dc.req.get(cfgid)
    elseif type == warehousedefine.storeindex.special then
        datainfo = special_dc.req.get(cfgid)
    else
        datainfo = bag_dc.req.get(cfgid)
    end
    local result = false
    transaction()
    if datainfo.type == warehousedefine.warehousetype.bag then
        local storeinfo = sharedata.deepcopy("store_bag", datainfo.cfgid)
        if not next(storeinfo) then
            return errCodeDef.eEC_cfgid_nofind
        end
        local goodsids = storeinfo.Goods_ID
        for i = 1, #goodsids, 2 do
            --包中还有包
            if goodsids[i] == warehousedefine.warehousetype.bag then
                getbaginfo(uid, goodsids[i + 1], number, type)
            elseif goodsids[i] == warehousedefine.warehousetype.prop then
                warehouse.req.addprop(uid, goodsids[i + 1], number)
            elseif goodsids[i] == warehousedefine.warehousetype.material then
                warehouse.req.addmaterials(uid, goodsids[i + 1], number)
            elseif goodsids[i] == warehousedefine.warehousetype.chip then
                chip.req.addchip(uid, goodsids[i + 1], 1, number)
            end
        end
    elseif datainfo.type == warehousedefine.warehousetype.prop then
        warehouse.req.addprop(uid, datainfo.cfgid, number)
    elseif datainfo.type == warehousedefine.warehousetype.material then
        warehouse.req.addmaterials(uid, datainfo.cfgid, number)
    elseif datainfo.type == warehousedefine.warehousetype.chip then
        chip.req.addchip(uid, datainfo.cfgid, 1, number)
    end
    if datainfo.iskh == 1 then
        warehouse.req.remkhorium(uid, (datainfo.saleprice or datainfo.price) * number)
    else
        warehouse.req.remgold(uid, (datainfo.saleprice or datainfo.price) * number)
    end
    commit()
    return errCodeDef.eEC_success
end

---商城购买
function shophandler:purchase(data)
    local ret = {}
    local uid = data.uid
    local id = data.msg.id
    local type = data.msg.type
    local number = data.msg.number or 1

    if not id or not type or type > 3 or type < 1 then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    ret.code = errCodeDef.eEC_success
    if type == warehousedefine.storeindex.sale then
        local datainfo = sale_dc.req.get(id)
        if datainfo == nil then
            ret.code = errCodeDef.eEC_cfgid_nofind
            return ret
        end
        if datainfo.iskh == 1 then
            --氪金是否足够
            if not warehouse.req.matchkhorium(uid, number * datainfo.saleprice) then
                ret.code = errCodeDef.eEC_gold_notEnough
                return ret
            end
        else
            if not warehouse.req.matchgold(uid, number * datainfo.saleprice) then
                ret.code = errCodeDef.eEC_gold_notEnough
                return ret
            end
        end
    elseif type == warehousedefine.storeindex.special then
        local datainfo = special_dc.req.get(id)
        if datainfo == nil then
            ret.code = errCodeDef.eEC_cfgid_nofind
            return ret
        end
        if datainfo.iskh == 1 then
            --氪金是否足够
            if not warehouse.req.matchkhorium(uid, number * datainfo.saleprice) then
                ret.code = errCodeDef.eEC_gold_notEnough
                return ret
            end
        else
            if not warehouse.req.matchgold(uid, number * datainfo.saleprice) then
                ret.code = errCodeDef.eEC_gold_notEnough
                return ret
            end
        end
    elseif type == warehousedefine.storeindex.bag then
        local datainfo = bag_dc.req.get(id)
        if datainfo == nil then
            ret.code = errCodeDef.eEC_cfgid_nofind
            return ret
        end
        if datainfo.iskh == 1 then
            --氪金是否足够
            if not warehouse.req.matchkhorium(uid, number * datainfo.price) then
                ret.code = errCodeDef.eEC_gold_notEnough
                return ret
            end
        else
            if not warehouse.req.matchgold(uid, number * datainfo.price) then
                ret.code = errCodeDef.eEC_gold_notEnough
                return ret
            end
        end
    end
    ret.code = cs(getbaginfo, uid, id, number, type)
    return ret
end

---中转站
function shophandler:transfer(data)
    local ret = {}
    ret.datainfos = {}
    local uid = data.uid

    local shopiteminfo = shopiteminfo_dc.req.get(uid)
    if shopiteminfo == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret    
    end
    ret.code = errCodeDef.eEC_success
    local shoparr = string.split(shopiteminfo.shopiteminfo)

    for i = 1, #shoparr do
        local putaway = shopitem_dc.req.get(tonumber(shoparr[i]))
        if not next(putaway) then
            skynet.error("error 中转站购买商品中未找到:", shoparr[i])
            LOG_ERROR("error 中转站购买商品中未找到:%s", shoparr[i])
        else
            table.insert(ret.datainfos, {cfgid = tostring(putaway.cfgid), number = putaway.number, price = putaway.price, index = putaway.type,
            shoptime = putaway.shoptime, shopid = putaway.id})
        end
    end
    return ret
end

---运输
function shophandler:transport(data)
    local ret = {}
    local uid = data.uid
    local datainfos = data.msg.datainfos

    if not next(datainfos) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local curdata = {}
    local shopiteminfo = string.split(shopiteminfo_dc.req.getvalue(uid, "shopiteminfo"))
    for key, value in pairs(datainfos) do
        local shopitem = shopitem_dc.req.get(value.shopid)
        if value.shopid == nil or not table.find(shopiteminfo, tostring(value.shopid)) or shopitem == nil then
            ret.code = errCodeDef.eEC_err_param
            return ret
        end
        table.insert(curdata, shopitem)
    end

    ret.code = errCodeDef.eEC_success
    local result = bqproxy.req.sendshopmarke(uid, curdata)
    if not result then
        ret.code = errCodeDef.eEC_transport_full
        return ret
    end
    transaction()
    for _, value in pairs(datainfos) do
        table.remove(shopiteminfo, table.find(shopiteminfo, tostring(value.shopid)))
        shopitem_dc.req.delete({id = value.shopid})
    end
    shopiteminfo_dc.req.setvalue(uid, "shopiteminfo", string.join(shopiteminfo))
    commit()
    return ret
end

---数据保存
function shophandler:initmarket()
    local indextime, indexkey, zerotime = timeindex()
    local retdata = {}
    local material = smaterials_dc.req.getAll()
    for key, value in pairs(material) do
        local arr = json.decode(value.arr)
        local mateinfo = {cfgid = key, curprice = 0, maxprice = math.mininteger, minprice = math.maxinteger, zeroprice = arr[1]["M" .. zerotime]}
        
        for i = 1, indextime do
            local price = tonumber(arr[i]["M" .. zerotime + (i - 1) *  1800])
            if price > mateinfo.maxprice then
                mateinfo.maxprice = price
            end
            if price < mateinfo.minprice then
                mateinfo.minprice = price
            end
        end

        mateinfo.curprice = arr[indextime][indexkey]
        table.insert(retdata, mateinfo)
        -- retdata[key] = mateinfo
    end
    marketdata.material = retdata
    retdata = {}
    local blueprint = sblueprint_dc.req.getAll()
    for key, value in pairs(blueprint) do
        local arr = json.decode(value.arr)
        local arrday = json.decode(value.arrday)
        local mateinfo = {cfgid = tostring(key), curprice = arr[indextime][indexkey] or 0, zeroprice = arrday[1]["M" .. zerotime] or 0}

        table.insert(retdata, mateinfo)
        -- retdata[key] = mateinfo
    end
    marketdata.blueprint = retdata
end

---商城请求
function shophandler:getstore(data)
    local ret = {}
    ret.datainfos = {}
    local uid = data.uid
    local type = data.msg.type

    if type == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = errCodeDef.eEC_success
    if type == warehousedefine.storeindex.sale then
        local datainfo = sale_dc.req.getAll()
        for key, value in pairs(datainfo) do
            table.insert(ret.datainfos, {cfgid = value.cfgid, type = value.type, price = value.price, saleprice = value.saleprice, iskh = value.iskh, id = key})
        end
    elseif type == warehousedefine.storeindex.special then
        local datainfo = special_dc.req.getAll()
        for key, value in pairs(datainfo) do
            if value.downtime <= timext.current_time() then
                special_dc.req.delete({id = key})
            else
                table.insert(ret.datainfos, {cfgid = value.cfgid, type = value.type, price = value.price, saleprice = value.saleprice, iskh = value.iskh, 
                countdown = math.max(0, value.downtime - timext.current_time()), id = key})
            end
        end
    elseif type == warehousedefine.storeindex.bag then
        local datainfo = bag_dc.req.getAll()
        for key, value in pairs(datainfo) do
            table.insert(ret.datainfos, {cfgid = value.cfgid, type = value.type, price = value.price, iskh = value.iskh, id = key})
        end
    end
    return ret
end

---计算第几次系统刷新会交易
local function marketnum()
    --金币购买概率
    local jackpot = sharedata.deepcopy("jackpot", 1)
    if jackpot == nil then
        LOG_ERROR("____________________jackpot表没有数据_________________")
        return math.random(0, 20)
    end
    local jackpot_1 = jackpot.Jackpot_1
    local random, curnum = math.random(1, 1000), 0
    for i = 1, #jackpot_1 do
        curnum = curnum + tonumber(jackpot_1[i])
        if curnum >= random then
            return i - 1
        end
    end
    -- 没有则可能表出错【99.9999%】，或者随机数出错【0.0001%】
    return 100
end

function shophandler:putawayupdate()
    skynet.error("====================系统交易=================")
    LOG_INFO("====================系统交易=================")
    local putawaygold = putawaygold_dc.req.getAll()
    --ismarket为0进行交易
    for key, value in pairs(putawaygold) do
        if value.ismarket == 0 then
            local putawayinfo = putawayinfo_dc.req.get(value.uid)
            local goldarr = string.split(putawayinfo.goldarr)
            local result = warehouse.req.addgold(value.uid, value.price * value.number)
            if result then
                table.remove(goldarr, table.find(goldarr, tostring(key)))
                putawayinfo_dc.req.setvalue(value.uid, "goldarr", string.join(goldarr))
                putawaygold_dc.req.delete({id = key})
                skynet.error("用户:", value.uid , "成功交易:", key, "获得金币:", value.number * value.price)
                LOG_INFO(string.format("用户: %d, 成功交易: %d, 获得金币: %d", value.uid, key, value.number * value.price))
            end
        else
            value.ismarket = value.ismarket - 1
            putawaygold_dc.req.setvalue(key, "ismarket", value.ismarket)
        end
    end
    skynet.error("====================交易完成=================")
    LOG_INFO("====================交易完成=================")
    LOG_INFO("====================下    架=================")
    skynet.error("====================下    架=================")
    local putaway = putaway_dc.req.getAll()
    --已经上架的是否下架
    for key, value in pairs(putaway) do
        if value.downtime <= timext.current_time() then
            local putawayinfo = putawayinfo_dc.req.get(value.uid)
            local khoriumarr = string.split(putawayinfo.khoriumarr)
            local scanresult, wareresult = true, true
            if value.type == warehousedefine.warehousetype.blueprint then
                scanresult = scan.req.addblueprint(value.uid, value.cfgid, value.number)
            elseif value.type == warehousedefine.warehousetype.material then
                wareresult = warehouse.req.addmaterials(value.uid, value.cfgid, value.number)
            end
            if scanresult and wareresult then
                table.remove(khoriumarr, table.find(khoriumarr, tostring(key)))
                putawayinfo_dc.req.setvalue(value.uid, "khoriumarr", string.join(khoriumarr))
                putaway_dc.req.delete({id = key})
                LOG_INFO(string.format("用户: %d, 氪金下架: %d", value.uid, key))
            end
        end
    end
    putawaygold = putawaygold_dc.req.getAll()
    --已经上架的是否下架
    for key, value in pairs(putawaygold) do
        if value.downtime <= timext.current_time() then
            local putawayinfo = putawayinfo_dc.req.get(value.uid)
            local goldarr = string.split(putawayinfo.goldarr)
            local scanresult, wareresult = true, true
            if value.type == warehousedefine.warehousetype.blueprint then
                scanresult = scan.req.addblueprint(value.uid, value.cfgid, value.number)
            elseif value.type == warehousedefine.warehousetype.material then
                wareresult = warehouse.req.addmaterials(value.uid, value.cfgid, value.number)
            end
            if scanresult and wareresult then
                table.remove(goldarr, table.find(goldarr, tostring(key)))
                putawayinfo_dc.req.setvalue(value.uid, "goldarr", string.join(goldarr))
                putawaygold_dc.req.delete({id = key})
                LOG_INFO(string.format("用户: %d, 金币下架: %d", value.uid, key))
            end
        end
    end
    skynet.error("====================下架完成=================")
    LOG_INFO("====================下架完成=================")
    LOG_INFO("====================上    架=================")
    skynet.error("====================上    架=================")
    local stayputaway = stayputaway_dc.req.getAll()
    for _, value in pairs(stayputaway) do
        local putawayinfo = putawayinfo_dc.req.get(value.uid)
        local goldarr = string.split(putawayinfo.goldarr)
        local khoriumarr = string.split(putawayinfo.khoriumarr)
        local staygoldarr = string.split(putawayinfo.staygoldarr)
        local staykhoriumarr = string.split(putawayinfo.staykhoriumarr)
        
        if value.iskh == 1 then
            local key = putaway_dc.req.get_nextid()
            table.insert(khoriumarr, key)
            table.remove(staykhoriumarr, table.find(staykhoriumarr ,tostring(value.id)))
            putaway_dc.req.add({id = key, cfgid = value.cfgid, number = value.number, 
                 price = value.price, type = value.type, puttime = value.puttime, downtime = value.downtime, uid = value.uid})
            LOG_INFO("用户： %d, 氪金上架: %d", value.uid, key)
        else
            local ismarket = marketnum()
            if ismarket <= 0 then
                warehouse.req.addgold(value.uid, value.price * value.number)
                skynet.error("用户:", value.uid , "直接交易", " 获得金币:", value.number * value.price)
                LOG_INFO(string.format("用户: %d 直接交易, 获得金币: %d", value.uid, value.number * value.price))
            else
                ismarket = ismarket - 1
                local key = putawaygold_dc.req.get_nextid()
                table.insert(goldarr, key)
                table.remove(staygoldarr, table.find(staygoldarr ,tostring(value.id)))
                putawaygold_dc.req.add({id = key, cfgid = tonumber(value.cfgid), number = value.number, 
                price = value.price, type = value.type, puttime = value.puttime, downtime = value.downtime, uid = value.uid, ismarket = ismarket})
                LOG_INFO("用户： %d, 金币上架: %d", value.uid, key)
            end
        end
        putawayinfo_dc.req.update({id = value.uid, goldarr = string.join(goldarr), khoriumarr = string.join(khoriumarr), 
            staygoldarr = string.join(staygoldarr), staykhoriumarr = string.join(staykhoriumarr)})
        stayputaway_dc.req.delete({id = value.id})
    end
    skynet.error("====================上架完成=================")
    LOG_INFO("====================上架完成=================")
end

return shophandler.new()