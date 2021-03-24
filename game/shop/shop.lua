local skynet = require "skynet"
local snax = require "skynet.snax"
local sharedata = require "skynet.sharedata"
local errCodeDef = require "errcodedef"
local json = require "cjson"
local timext = require "timext"
local shophandler = require "game.shop.shophandler"


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


function response.getoverview(data)
end

---上架
function response.putaway(data)
    return shophandler:putaway(data)
end

---出售
function response.sell(data)
    return shophandler:sell(data)
end

---获取通过金币出售当前价格
function response.curprice(data)
    return shophandler:curprice(data)
end

---运输机取消
function response.trancancel(uid, index, cfgid, iskh, number, price)
    return shophandler:trancancel(uid, index, cfgid, iskh, number, price)
end

---商城购买【待完成】
function response.purchase(data)
    return shophandler:purchase(data)
end

---氪金购买
function response.khoriumbuy(data)
    return shophandler:khoriumbuy(data)
end

---金币购买
function response.goldbuy(data)
    return shophandler:goldbuy(data)
end

---中转站
function response.transfer(data)
    return shophandler:transfer(data)
end

---运输
function response.transport(data)
   return shophandler:transport(data) 
end

---上架列表请求
function response.putawayinfo(data)
    return shophandler:putawayinfo(data)
end

---交易市场列表请求
function response.dealinfo(data)
    return shophandler:dealinfo(data)
end

---行情折线图列表请求
function response.marketpic(data)
    return shophandler:marketpic(data)
end

---行情数据列表请求材料
function response.marketdatamate(data)
    return shophandler:marketdatamate(data)
end

---行情数据列表请求蓝图
function response.marketdatablue(data)
    return shophandler:marketdatablue(data)
end

---详情走势图数据
function response.matedetails(data)
    return shophandler:matedetails(data)
end

---详情走势图数据
function response.bluedetails(data)
    return shophandler:bluedetails(data)
end

---商城礼包请求
function response.getstore(data)
    return shophandler:getstore(data)
end

---当前时间离刷新时间的秒数
local function timesec()
    local time = os.date("*t")
    local datetime = os.time(time)
    local min = time.min
    local sec = time.sec
    local sumsec = min * 60 + sec
    if sumsec % 3600 == 0 then
        return 0
    elseif sumsec < 1800 then
        return 1800 - sumsec
    elseif sumsec < 3600 then
        return 3600 - sumsec
    end
end

local function putawayupdate()
    -- skynet.timeout(180 * 100, putawayupdate)       --测试使用
    skynet.timeout(1800 * 100, putawayupdate)
    skynet.error("====================        =================")
    shophandler:putawayupdate()
    shophandler:initmarket()
    skynet.error("====================        =================")
end

--测试后台更改价格redis是否正常
local function putupdate()
    local mm = json.decode(smaterials_dc.req.getvalue(10001, "arr"))
    skynet.timeout(2 * 100, putupdate)
    skynet.error(tostring(mm[23]))
end

function init(...)
    market_dc = snax.queryservice("marketdc")
    putaway_dc = snax.queryservice("putawaydc")
    putawaygold_dc = snax.queryservice("putawaygolddc")
    stayputaway_dc = snax.queryservice("stayputawaydc")
	putawayinfo_dc = snax.queryservice("putawayinfodc")
    smaterials_dc = snax.queryservice("smaterialsdc")
    sblueprint_dc = snax.queryservice("sblueprintsdc")
    shopitem_dc = snax.uniqueservice("shopitemdc")
    shopiteminfo_dc = snax.uniqueservice("shopiteminfodc")
    sale_dc = snax.uniqueservice("saledc")
    special_dc = snax.uniqueservice("specialdc")
    bag_dc = snax.uniqueservice("bagdc")
    bqproxy = snax.queryservice("bqproxy")
    warehouse = snax.queryservice("warehouse")
    scan = snax.queryservice("scan")
    chip = snax.queryservice("chip")
    shophandler:initshophandler(market_dc, sblueprint_dc, putaway_dc, putawaygold_dc, stayputaway_dc, putawayinfo_dc, smaterials_dc, 
        shopitem_dc, shopiteminfo_dc, bqproxy, warehouse, scan, sale_dc, special_dc, bag_dc, chip)
    shophandler:initmarket()
    -- skynet.timeout(180 * 100, putawayupdate)     --测试使用
    skynet.timeout(timesec() * 100, putawayupdate)
end

function exit(...)
end

function response.online(uid, fd)
    -- skynet.error(shopitem_dc.req.get_nextid(), type(shopitem_dc.req.get_nextid()))
    -- skynet.error(tostring(snax.self().req.putaway({uid = uid, msg = {index = 7, cfgid = 10016, number = 1, isnew = true}})))
    -- skynet.error(tostring(snax.self().req.putaway({uid = uid, msg = {index = 6, cfgid = "410025", price = 10000, isnew = true}})))
    -- shophandler:putawayupdate()
    -- skynet.error(tostring(snax.self().req.dealinfo({uid = uid, msg = {cfgid = 610009, type = 3}})))
    -- skynet.error(tostring(snax.self().req.curprice({uid = uid, msg = {index = 7, cfgid = 10016}})))
    -- skynet.error(tostring(snax.self().req.matedetails({uid = uid, msg = {type = 3, cfgid = 10016}})))
    -- skynet.error(tostring(snax.self().req.getstore({uid = uid, msg = { type = 1}})))
    -- skynet.error(tostring(snax.self().req.getstore({uid = uid, msg = { type = 2}})))
    -- skynet.error(tostring(snax.self().req.getstore({uid = uid, msg = { type = 3}})))
    -- 事务测试
    -- transaction()
    -- market_dc.req.add({id = 8, marketinfo = "adasd"})
    -- rollback()
end

function response.offline(uid)
end