local skynet = require "skynet"
local snax = require "skynet.snax"
local sharedata = require "skynet.sharedata"
local errCodeDef = require "errcodedef"
local json = require"cjson"
local timext = require "timext"

local user_dc
local score_dc
local collection_dc
local show_dc
local gold_dc
local khorium_dc

function init(...)
    user_dc = snax.queryservice("userdc")
    score_dc = snax.queryservice("scoredc")
    collection_dc = snax.queryservice("collectiondc")
    show_dc = snax.queryservice("showdc")
    gold_dc = snax.uniqueservice("golddc")
    khorium_dc = snax.uniqueservice("khoriumdc")
end

---获取排行榜
function response.getladder(data)
    local ret = {}
    local uid = data.uid
    local beginindex = data.msg.beginindex - 1
    local endindex = data.msg.endindex - 1

    ret.code = errCodeDef.eEC_success
    ret.data = {}
    if beginindex == nil or endindex == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local result = do_redis({ "zrevrange", "ladder", beginindex, endindex , "withscores"}, uid)
    for i = 1, #result, 2 do
        table.insert(ret.data,{uid = tonumber(result[i]), score = math.floor(result[i+1]), name = user_dc.req.getvalue(tonumber(result[i]), "name")})
    end
    return ret
end

---获取玩家排行
function response.getplayerladder(data)
    local ret = {}
    local uid = data.uid

    ret.code = errCodeDef.eEC_success
    local result = do_redis({ "zrevrank", "ladder", uid}, uid) + 1
    if result == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.index = result
    return ret
end

---设置分数
function response.setscore(uid, number)
    local surrscore = math.clamp(math.floor(score_dc.req.getvalue(uid, "score")) + number, 0, 2100000000)

    local score = tonumber(surrscore ..".".. (9999999999 - tonumber(string.sub(timext.current_time(), 1, 10))))
    local result = do_redis({ "zadd", "ladder", score, uid}, uid)
    if result == nil then
        return false
    end
    score_dc.req.setvalue(uid, "score", score)
    send_request(get_user_fd(uid), {score = math.floor(score)}, "warehouse_updatescore")
    return true
end

---个人资料
function response.personaldata(data)
    local ret = {}
    local uid = data.msg.uid
    if uid == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = errCodeDef.eEC_success
    local res = user_dc.req.get(uid)
    if res == nil then
        ret.code = errCodeDef.eEC_no_create_role
        return ret
    end
    local ladder = do_redis({ "zrevrank", "ladder", uid}, uid)
    if ladder == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local showname = nil
    if res.showid then
        showname = show_dc.req.getvalue(uid, "name")
    end
    ret.userinfo = {uid = res.id, name = res.name, level = res.level, imgcfgid = res.imgcfgid, ladder = ladder + 1, 
        description = res.description, showid = res.showid, showname = showname}
    return ret
end

---战绩
function response.record(data)
    local ret = {}
    local uid = data.msg.uid
    if uid == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end 
    ret.code = errCodeDef.eEC_success
    local scoreinfo = score_dc.req.get(uid)
    local user = user_dc.req.get(uid)
    if not next(scoreinfo) or not next(user) then
        ret.code = errCodeDef.eEC_no_create_role
        return ret
    end
    local achievement = snax.queryservice("achievement")
    local pvpmax = achievement.req.getachieveinfo(uid, achievementdefine.achievetype.maxnumber_pvp, achievementdefine.typelist.athletics, "count") or 1
    local pvpwin = achievement.req.getachieveinfo(uid, achievementdefine.achievetype.winnumber_pvp, achievementdefine.typelist.athletics, "count") or 0
    local supportnum = achievement.req.getachieveinfo(uid, achievementdefine.achievetype.supportnum, achievementdefine.typelist.athletics, "count") or 0
    ret.userinfo = {winrate = math.ceil(pvpwin / pvpmax * 100),
                supportnum = supportnum, checkpoint = 3, score = math.floor(scoreinfo.score), 
                rtime = user.rtime, onlinetime = user.onlinetime}
    return ret
end

---返回装备最多种类数量
local function maxcount(arr)
    local num = 0
    table.sort(arr, function(a,b) return a>b end)
    for i = 1, #arr do
        if arr[i] < 90000 then
            break
        else 
            num = num + 1
        end
    end
    return #arr - num
end

---图鉴
function response.fieldguide(data)
    local ret = {}
    local uid = data.msg.uid
    if uid == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.code = errCodeDef.eEC_success
   
    local collection = collection_dc.req.get(uid)
    
    local maxbody = maxcount(table.keys(sharedata.deepcopy("machinebody")))
    local maxchassis = maxcount(table.keys(sharedata.deepcopy("machinechassis")))
    local maxfirecontrol = maxcount(table.keys(sharedata.deepcopy("firecontrol")))
    local maxweapon = maxcount(table.keys(sharedata.deepcopy("weapontable")))

    ret.userinfo = {{part = 1, currentnum = #json.decode(collection.chassis), maxnumber = maxchassis},
        {part = 2, currentnum = #json.decodestring.split(collection.body), maxnumber = maxbody},
        {part = 3, currentnum = #json.decode(collection.firecontroller), maxnumber = maxfirecontrol},
        {part = 4, currentnum = #json.decode(collection.weapon), maxnumber = maxweapon},
    }
    return ret
end

---成就
function response.achievement(data)
end

---展示机甲
function response.getshow(data)
    local showid = data.msg.showid

    local ret, weap = {}, {}
    if not showid then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local datainfo = show_dc.req.get(showid)
    if not next(datainfo) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.userinfo = {name = datainfo.name, body = json.decode(datainfo.body), chassis = json.decode(datainfo.chassis),
    firecontroller = json.decode(datainfo.firecontroller), weapons = json.decode(datainfo.weapon)}
    ret.code = errCodeDef.eEC_success
    return ret
end

function exit(...)
end

function response.online(uid, fd)
    if uid == 1 then
		return
	end
    if not user_dc.req.check_role_exists(uid) then
        return
    end
    local data = {}
    local res = user_dc.req.get(uid)
    local gold = gold_dc.req.getvalue(uid, "goldnumber")
    local khorium = khorium_dc.req.getvalue(uid, "khorium")
    data.userinfo = {uid = res.id, name = res.name, level = res.level, exp = res.exp, imgcfgid = res.imgcfgid, age = res.age,
    khorium = khorium, gold = gold, daytime = res.daytime, score = math.floor(score_dc.req.getvalue(uid, "score") or 0)}
    send_request(fd, data, "player_userinfo")
end

function response.offline(uid)
end