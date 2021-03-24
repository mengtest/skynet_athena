local skynet = require "skynet"
local snax = require "skynet.snax"
local sharedata = require "skynet.sharedata"
local errCodeDef = require "errcodedef"
local json = require "cjson"
local timext = require "timext"

local queueinfo_dc
local machinecfg_dc
local machineinfo_dc
local blueprint_dc
local awardinfo_dc
local bq_dc
local achievement
local warehouse


--- 移除集合中数据
local function remove_array(arr, id)
    for i = 1, #arr do
        if arr[i] == id then
            table.remove(arr, i)
        end
    end
end

--- 移除表中数据
local function remove_number(arr, key, number)
    if arr and arr[key] then
        if not arr[key].number then
            table.remove(arr, key)
        elseif arr[key].number and arr[key].number > number then
            arr[key].number = arr[key].number - number
        elseif arr[key].number and arr[key].number == number then
            table.remove(arr, key)
        else
            return false
        end
    end
end

---查找蓝图
---@param name string 检测条件
---@return boolean 返回第一个满足项下标
local function get_blueprint(id, arry, name, ...)
    local tab = {...}
    for i = 1, #arry do
        if next(tab) and (arry[i].bqid == tab[1] or arry[i].awardid == tab[1]) then
            return i
        elseif not next(tab) and arry[i].id == id and arry[i].name == name then
            return i
        end
    end
    return nil
end

--- @param isinarr boolean true表示移动到铸造完成 false移动到铸造中 nil表示移动到正常队列
--- @param ... true依次传入 awardid  为false依次传入 bqid、begintime、endtime
local function change_blueprint(id, name, arry, number, isinarr, ...)
    local tab = {...}
    local key = get_blueprint(id, arry, name, ...)
    if key == nil then
        if isinarr == nil then
            table.insert(arry, {id = id, number = number, name = name})
        elseif isinarr == true then
            table.insert(arry, {id = id, number = number, awardid = tab[1], name = name})
        else
            table.insert(arry, {id = id, number = number, bqid = tab[1], begintime = tab[2], endtime = tab[3], name = name})
        end
    else
        arry[key].number = arry[key].number + number
    end
end

--- 移除蓝图到另外集合
--- @param arry table 蓝图集合 
--- @param toarry table 目标集合
--- @param isinarr boolean true表示移动到铸造完成 false移动到铸造中 nil表示移动到正常队列
--- @param ... true传入 awardid  为false依次传入 bqid、begintime、endtime
local function removeto_blueprint(key, number, arry, toarry, isinarr, ...)
    change_blueprint(arry[key].id, arry[key].name, toarry, number, isinarr, ...)
    if arry[key].number ~= nil and arry[key].number > number then
        arry[key].number = arry[key].number - number
    elseif arry[key].number ~= nil and arry[key].number == number then
        table.remove(arry, key)
    end
end

--- 蓝图从铸造中移动到已完成集合
---@param id string 蓝图id
---@param bqid number 队列id
function response.removeto_end(uid, id, bqid, awardid)
    local blueprinting = json.decode(blueprint_dc.req.getvalue(uid, "blueprinting"))
    local blueprintend = json.decode(blueprint_dc.req.getvalue(uid, "blueprintend"))
    local key = get_blueprint(id, blueprinting, nil, bqid)
    if not key then
        return false
    end
    table.insert(blueprintend, {id = id, awardid = awardid, name = blueprinting[key].name, number = blueprinting[key].number})
    table.remove(blueprinting, key)
    blueprint_dc.req.setvalue(uid, "blueprinting", json.encode(blueprinting))
    blueprint_dc.req.setvalue(uid, "blueprintend", json.encode(blueprintend))
    return true
end

--- 添加蓝图
---@param id string 蓝图id
local function add_blueprint(uid, id, number, name)
    local cfgid = id
    local tab = {}
    local blueprint = blueprint_dc.req.get(uid)
    if not next(blueprint) then
        table.insert(tab, {id = cfgid, number = number, name = name})
        local data = {id = uid, newblueprint = json.encode(tab), blueprintinfo = json.encode({}), blueprinting = json.encode({}), blueprintend = json.encode({})}
        blueprint_dc.req.add(data)
    else
        local newinfo = json.decode(blueprint.newblueprint)
        local info = json.decode(blueprint.blueprintinfo)
        local blueprint = get_blueprint(cfgid, info, name)
        if blueprint then
            info[blueprint].number = info[blueprint].number + number
            blueprint_dc.req.setvalue(uid, "blueprintinfo", json.encode(info))
        else
            blueprint = get_blueprint(cfgid, newinfo, name)
            if blueprint then
                newinfo[blueprint].number = newinfo[blueprint].number + number
            else
                table.insert(newinfo, {id = cfgid, number = number, name = name})
            end
            blueprint_dc.req.setvalue(uid, "newblueprint", json.encode(newinfo))
        end
    end
end

--- 字符串切割成表加B,蓝图使用
---@return table 返回表数据
local function strtoarr(str)
    local blueprintarr = {}
    if str == nil or #str < 6 then
        return blueprintarr
    end
    if #str % 6 == 0 then
        for i = 1, #str, 6 do
            table.insert(blueprintarr, "B" .. string.sub(str, i, i + 5))
        end
    else
        table.insert(blueprintarr, string.sub(str, 1, 7))
    end
    return blueprintarr
end

--- 领取奖励 number 0.5表示领取一般
---@param data table 奖励数据
---@param number number 表示领取一部分默认为1
local function get_award(uid, data, number)
    local weld = false
    local equiplist = json.decode(data.equiplist)
    local bplist = json.decode(data.bprewardlist)
    local proprewardlist = json.decode(data.proprewardlist)
    local sponsorid = tostring(data.sponsorid)
    --表示通过扫描机甲得到的蓝图，铸造完成后焊死
    number = number or 1
    if #sponsorid >= 18 then
        weld = true
    end

    for i = 1, #equiplist do
        if equiplist[i] and not warehouse.req.addequip(uid, equiplist[i].type, equiplist[i].cfgid, equiplist[i].lv, 1, weld) then
            return false
        end
    end

    for i = 1, #bplist do
        if bplist[i] and not snax.self().req.addblueprint(uid, bplist[i].cfgid, math.floor(bplist[i].number * number), bplist[i].name) then
            return false
        end
    end

    for i = 1, #proprewardlist do
        if proprewardlist[i] and not warehouse.req.addmaterials(uid, proprewardlist[i].cfgid, math.floor(proprewardlist[i].number * number))  then
            return false
        end
    end
    
    if weld then
        if not warehouse.req.add_machine(uid, sponsorid) then
            return false
        end
    end
    return true
end

--- 检测机甲是否是该用户
local function is_match(uid, uniqueid)
    local partindexs = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
    if not table.find(partindexs, tostring(uniqueid)) then
        return false
    end
    return true
end

-- 扫描
function response.scan(data)
    local ret = {}
    local uid = data.uid
    local uniqueid = data.msg.uniqueid

    -- uniqueid = machinecfg_dc.req.get_nextid() - 3 ---测试使用

    if not uniqueid then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    -- 判断机甲是否为此用户
    if not is_match(uid, uniqueid) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    local machine = machinecfg_dc.req.get(uniqueid)
    ret.code = errCodeDef.eEC_success
    if uniqueid == nil or not next(machine) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    if machine.islock == 0 then
        ret.code = errCodeDef.eEC_machine_notlock
        return ret
    end
    
    --[[
        材料检测
    --]]

    local bqproxy = snax.queryservice("bqproxy")
    --[[
        材料变化
	--]]

    ret.bqid, ret.begintime, ret.endtime = bqproxy.req.sendscan(uid, uniqueid)
    ret.countdown = ret.endtime - timext.current_time()
    ret.begintime, ret.endtime = nil, nil 
    return ret
end

-- 铸造
function response.casting(data)
    local ret = {}
    local uid = data.uid
    local cfgid = data.msg.cfgid
    local name = data.msg.name
    local isnew = data.msg.isnew
    local number = data.msg.number or 1
    isnew = false

    name = #tostring(cfgid) == 18 and name or nil

    ret.code = errCodeDef.eEC_success
    if not cfgid or isnew == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local info = json.decode(blueprint_dc.req.getvalue(uid, "blueprintinfo"))
    local newinfo = json.decode(blueprint_dc.req.getvalue(uid, "newblueprint"))
    local blueprinting = json.decode(blueprint_dc.req.getvalue(uid, "blueprinting"))

    local key
    if isnew then
        key = get_blueprint(cfgid, newinfo, name)
    else
        key = get_blueprint(cfgid, info, name)
    end
    if key == nil then
        ret.code = errCodeDef.eEC_cfgid_nofind
        return ret
    end
    if isnew then
        if newinfo[key].number < number then
            ret.code = errCodeDef.eEC_res_notEnough
            return ret
        end
    else
        if info[key].number < number then
            ret.code = errCodeDef.eEC_res_notEnough
            return ret
        end
    end

    local cast = queueinfo_dc.req.get(uid)
    if cast.ingcasting ~= nil and #string.split(cast.ingcasting) >= cast.maxcasting then
        ret.code = errCodeDef.eEC_casting_full
        return ret
    end
    
    --检测蓝图是否存在
    local blueprints = strtoarr(cfgid)
    local mateinfo = {}
    for i = 1, #blueprints do
        local blueprint = sharedata.deepcopy("blueprint", blueprints[i])
        if not next(blueprint) then
            ret.code = errCodeDef.eEC_err_param
            return ret
        end
        local mater = blueprint.Material
        for j = 1, #mater, 3 do
            mateinfo[mater[j + 2]] = number * ((mateinfo[mater[j + 2]] and mateinfo[mater[j + 2]] or 0) + mater[j + 1])
        end
    end
    --材料检测
    for key, value in pairs(mateinfo) do
        if not warehouse.req.matchmaterial(uid, key, value) then
            ret.code = errCodeDef.eEC_res_notEnough
            return ret
        end
    end
    
    local bqproxy = snax.queryservice("bqproxy")
    ---[[ 材料变化
    for key, value in pairs(mateinfo) do
        warehouse.req.remmaterials(uid, key, value)
    end
    --]]
    ret.bqid, ret.begintime, ret.endtime = bqproxy.req.sendcasting(uid, cfgid, number)
    --蓝图状态改变
    if isnew then
        removeto_blueprint(key, number, newinfo, blueprinting, false, ret.bqid, ret.begintime, ret.endtime)
        blueprint_dc.req.setvalue(uid, "newblueprint", json.encode(newinfo))
    else
        removeto_blueprint(key, number, info, blueprinting, false, ret.bqid, ret.begintime, ret.endtime)
        blueprint_dc.req.setvalue(uid, "blueprintinfo", json.encode(info))
    end
    blueprint_dc.req.setvalue(uid, "blueprinting", json.encode(blueprinting))
    ret.countdown = ret.endtime - ret.begintime
    ret.begintime, ret.endtime = nil, nil 
    achievement.req.updatechallenge(uid, achievementdefine.achievetype.casting)
    ret.blueprintid = cfgid
    return ret
end

-- 加速
function response.addspeed(data)
    local ret = {}
    local uid = data.uid
    local id = data.msg.bqid
    local time = data.msg.time
    local propid = data.msg.propid

    ret.code = errCodeDef.eEC_success
    if not id or not propid or not time then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local queue = bq_dc.req.get(id)
    if not next(queue) then
        ret.code = errCodeDef.eEC_cfgid_nofind
        return ret
    end
    local blueprinting = json.decode(blueprint_dc.req.getvalue(uid, "blueprinting"))

    local key = get_blueprint(nil, blueprinting, nil, id)
    if key == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    --[[
        材料检测
	--]]
    local bqproxy = snax.queryservice("bqproxy")
    --[[
        材料变化
	--]]
    ret.begintime, ret.endtime = bqproxy.req.sendspeed(id, time * 60)
    ret.countdown = math.max(0, ret.endtime - timext.current_time())
    blueprinting[key].endtime = ret.endtime
    blueprint_dc.req.setvalue(uid, "blueprinting", json.encode(blueprinting))
    ret.begintime, ret.endtime = nil, nil 
    return ret
end

-- 取消
function response.cancelcasting(data)
    local ret = {}
    local uid = data.uid
    local id = data.msg.bqid

    ret.code = errCodeDef.eEC_success

    if id == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret 
    end
    local bqinfo = bq_dc.req.get(id)
    --检测信息
    if not next(bqinfo) or bqinfo.playerid ~= uid then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    ret.blueprintid = bqinfo.sponsorid

    local queueinfo = string.split(queueinfo_dc.req.getvalue(uid, "ingcasting"))
    local blueprinting = json.decode(blueprint_dc.req.getvalue(uid, "blueprinting"))
    local blueprintinfo = json.decode(blueprint_dc.req.getvalue(uid, "blueprintinfo"))
    local blueprints = strtoarr(tostring(bqinfo.sponsorid))
    local notfinishnum = 0
    local b = get_blueprint(nil, blueprinting, nil, id)

    for i = 1, #queueinfo do
        if tonumber(queueinfo[i]) == tonumber(id) then
            if b then
                local number = blueprinting[b].number
                notfinishnum = math.ceil(math.max(0, (blueprinting[b].endtime - timext.current_time())) /
                    (blueprinting[b].endtime - blueprinting[b].begintime) * blueprinting[b].number)
                --已完成直接领取
                if notfinishnum < number and not get_award(uid, bqinfo, (blueprinting[b].number - notfinishnum) / blueprinting[b].number) then
                    skynet.error("============CCCCCCCCCCCCCCCCCCCCCCCCC=============")
                    ret.code = errCodeDef.eEC_cfgid_nofind
                    return ret
                end
                --未完成的移动
                removeto_blueprint(b, notfinishnum, blueprinting, blueprintinfo, nil)
                --已完成的移除
                remove_number(blueprinting, b, number - notfinishnum)
            else
                ret.code = errCodeDef.eEC_blueprint_nofind
                return ret
            end
            table.remove(queueinfo, i)
            queueinfo_dc.req.setvalue(uid, "ingcasting", string.join(queueinfo))
            bq_dc.req.delete({id = tonumber(id)})
            break
        end
    end
    ---[[ 材料返回，放射性在此判断
    for i = 1, #blueprints do
        local blueprint = sharedata.deepcopy("blueprint", blueprints[i])
        local mater = blueprint.Material
        for j = 1, #mater, 3 do
            warehouse.req.addmaterials(uid, mater[j + 2], mater[j + 1] * notfinishnum)
        end
    end  
    --]]
    blueprint_dc.req.setvalue(uid, "blueprintinfo", json.encode(blueprintinfo))
    blueprint_dc.req.setvalue(uid, "blueprinting", json.encode(blueprinting))
    ret.bqid = id
    ret.nofinish = notfinishnum
    return ret
end

-- 领取扫描
function response.receivescan(data)
    local ret = {}
    local uid = data.uid
    local uniqueid = data.msg.awardid

    ret.code = errCodeDef.eEC_success

    if uniqueid == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end

    local queueinfo = string.split(queueinfo_dc.req.getvalue(uid, "endscan"))
    local award = awardinfo_dc.req.get(uniqueid)
    --检测信息
    if not table.find(queueinfo, tostring(uniqueid)) or not next(award) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local machinecfg = machinecfg_dc.req.get(award.sponsorid)
    if not next(machinecfg) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    if not get_award(uid, award) then
        ret.code = errCodeDef.eEC_cfgid_nofind
        return ret
    end
    machinecfg_dc.req.setvalue(award.sponsorid, "begintime", 0)
    machinecfg_dc.req.setvalue(award.sponsorid, "endtime", 0)

    remove_array(queueinfo, tostring(uniqueid))

    queueinfo_dc.req.setvalue(uid, "endscan", string.join(queueinfo))
    awardinfo_dc.req.delete({id = uniqueid})
    return ret
end

-- 领取铸造
function response.receivecasting(data)
    local ret = {}
    local uid = data.uid
    local id = data.msg.awardid

    
    if id == nil then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local queueinfo = string.split(queueinfo_dc.req.getvalue(uid, "endcasting"))
    local award = awardinfo_dc.req.get(id)
    --检测信息
    if not table.find(queueinfo, tostring(id)) or not next(award) then
        ret.code = errCodeDef.eEC_err_param
        return ret
    end
    local machinenum = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
    if #tostring(award.sponsorid) >= 18 and #machinenum >= 6 then
        ret.code = errCodeDef.eEC_machine_full
        return ret
    end
    --对应部位增加
    if not get_award(uid, award) then
        ret.code = errCodeDef.eEC_cfgid_nofind
        return ret
    end
    snax.self().req.remblueprint(uid, award.sponsorid, 1, nil, 0, id)
    
    remove_array(queueinfo, tostring(id))
    
    queueinfo_dc.req.setvalue(uid, "endcasting", string.join(queueinfo))
    awardinfo_dc.req.delete({id = id})
    ret.awardid = id
    ret.code = errCodeDef.eEC_success
    return ret
end

-- 一键领取铸造
function response.receiveallcast(data)
    local ret = {}
    local uid = data.uid
    ret.number = 0

    ret.code = errCodeDef.eEC_success

    local queueinfo = string.split(queueinfo_dc.req.getvalue(uid, "endcasting"))
    local blueprintend = json.decode(blueprint_dc.req.getvalue(uid, "blueprintend"))
    for i = 1, #blueprintend do
        local award = awardinfo_dc.req.get(tonumber(blueprintend[i].awardid))
        --检测信息
        if not table.find(queueinfo, tostring(blueprintend[i].awardid)) or not next(award) then
            ret.code = errCodeDef.eEC_unknow
            ret.number = ret.number + 1
            goto continue
        end
        --机体最多6套，检测
        local machinenum = string.split(machineinfo_dc.req.getvalue(uid, "machinecfgid"))
        if #tostring(award.sponsorid) >= 18 and #machinenum >= 6 then
            ret.code = errCodeDef.eEC_unknow
            ret.number = ret.number + 1
            goto continue
        end
        --对应部位增加
        if not get_award(uid, award) then
            ret.code = errCodeDef.eEC_unknow
            ret.number = ret.number + 1
            goto continue
        end
        if snax.self().req.remblueprint(uid, award.sponsorid, 1, nil, 0, blueprintend[i].awardid) then
            ret.code = errCodeDef.eEC_unknow
            ret.number = ret.number + 1
            goto continue
        end
    
        remove_array(queueinfo, tostring(blueprintend[i].awardid))
        
        awardinfo_dc.req.delete({id = blueprintend[i].awardid})
        
        ::continue::
    end
    queueinfo_dc.req.setvalue(uid, "endcasting", string.join(queueinfo))
    skynet.error("receiveallcast......", tostring(ret))
    return ret
end

-- 增加铸造位
function response.addcasting(data)
    local ret = {}
    local uid = data.uid
    local num = data.msg.num and data.msg.num or 1
    local maxcasting = queueinfo_dc.req.getvalue(uid, "maxcasting")

    ret.code = errCodeDef.eEC_success
    if maxcasting + num > 10 then
        ret.code = errCodeDef.eEC_casting_max
        return ret
    end
    queueinfo_dc.req.setvalue(uid, "maxcasting", maxcasting + num)
    return ret
end

---增加蓝图
---@param bpid string 蓝图id
---@param name string 除扫描出的蓝图其余名称为nil state不为nil名称可为nil
---@return boolean false表示参数错误或蓝图id不存在
function response.addblueprint(uid, bpid, number, name)
    if not uid or not bpid or not number then
        return false
    end
    bpid = tostring(bpid)
    --检测蓝图是否存在
    local blueprints = strtoarr(bpid)
    for i = 1, #blueprints do
        local blueprint = sharedata.deepcopy("blueprint", blueprints[i])
        if not blueprint then
            return false
        end
    end
    add_blueprint(uid, bpid, number, name)
    local a = {}
    a.propinfo = {}
    table.insert(a.propinfo, {id = bpid, number = number, name = name, state = 0})
    send_request(get_user_fd(uid), a, "warehouse_addbp")
    return true
end

--- 移除蓝图
---@param bpid string 蓝图id
---@param name string 除扫描出的蓝图其余名称为nil state不为nil名称可为nil
---@param state number 为0表示铸造完成1表示铸造中2表示无状态3表示新的 
---@param ... state为0传入 awardid  1传入 bqid
---@return boolean false表示参数错误或余量不足
function response.remblueprint(uid, bpid, number, name, state, ...)
    if not uid or not bpid or not number then
        return false
    end
    bpid = tostring(bpid)
    local info = {}
    local blutype = ""
    if state == 2 then
        blutype = "blueprintinfo"
        info = json.decode(blueprint_dc.req.getvalue(uid, "blueprintinfo"))
    elseif state == 0 then
        blutype = "blueprintend"
        info = json.decode(blueprint_dc.req.getvalue(uid, "blueprintend"))
    elseif state == 1 then            
        blutype = "blueprinting"
        info = json.decode(blueprint_dc.req.getvalue(uid, "blueprinting"))
    elseif state == 3 then            
        blutype = "newblueprint"
        info = json.decode(blueprint_dc.req.getvalue(uid, "newblueprint"))
    end
    local blueprint = get_blueprint(bpid, info, name, ...)
    if blueprint then
        skynet.error("当前蓝图数量：", info[blueprint].number, "; 移除的数量：", number)
        if not info[blueprint].number then
            table.remove(info, blueprint)
        elseif info[blueprint].number and info[blueprint].number > number then
            info[blueprint].number = info[blueprint].number - number
        elseif info[blueprint].number and info[blueprint].number == number then
            table.remove(info, blueprint)
        else
            return false
        end
    else
        return false
    end
    blueprint_dc.req.setvalue(uid, blutype, json.encode(info))

    local a = {}
    a.propinfo = {}
    table.insert(a.propinfo, {id = bpid, number = number, state = state and 4 or 0})
    send_request(get_user_fd(uid), a, "warehouse_rembp")
    return true
end

function init(...)
    machineinfo_dc = snax.queryservice("machineinfodc")
    machinecfg_dc = snax.queryservice("machinecfgdc")
    awardinfo_dc = snax.uniqueservice("awardinfodc")
    queueinfo_dc = snax.uniqueservice("queueinfodc")
    blueprint_dc = snax.uniqueservice("blueprintdc")
    bq_dc = snax.uniqueservice("businessqueuedc")
    warehouse = snax.uniqueservice("warehouse")
    achievement = snax.uniqueservice("achievement")
end

function exit(...)
end

function response.online(uid, fd)
end

function response.offline(uid)
end
