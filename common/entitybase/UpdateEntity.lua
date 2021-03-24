local skynet = require "skynet"
local Entity = require "Entity"

-- UpdateEntity
local UpdateEntity = class("UpdateEntity", Entity)

function UpdateEntity:ctor()
	UpdateEntity.super.ctor(self)
	self.type = 4
end

-- 加载整张表数据
function UpdateEntity:load()
end

--[[
-- 将内存中的数据先同步回redis,再从redis加载到内存（该方法要不要待定）
function UpdateEntity:reLoad()

end

-- 卸载整张表数据
function UpdateEntity:unLoad()

end
--]]

-- row中包含pk字段,row为k,v形式table
function UpdateEntity:add(row, nosync)
	local ret = skynet.call("dbmgr", "lua", "add", self.tbname, row, self.type, nosync)
	return true
end

-- row中包含pk字段,row为k,v形式table
function UpdateEntity:delete(row, nosync)
	local ret = skynet.call("dbmgr", "lua", "delete", self.tbname, row, self.type, nosync)
	return true
end

-- row为k,v形式table
function UpdateEntity:update(row, nosync)
	local ret = skynet.call("dbmgr", "lua", "update", self.tbname, row, self.type, nosync)
	return true
end

function UpdateEntity:get(cfgid)
	local rs = skynet.call("dbmgr", "lua", "get_update", self.tbname, tostring(cfgid))
	if rs == nil then
		rs = skynet.call("dbmgr", "lua", "get_update", self.tbname, tonumber(cfgid))
	end
	rs = rs[tonumber(cfgid)] 
	if rs ~= nil and not next(rs) then
		rs = rs[tostring(cfgid)]
	end 
	return rs or nil
end

function UpdateEntity:getValue(id, field)
	local record = self:get(id)
	if type(record) == "table" then
		if record[field] == nil then
			record = self:get(tostring(id))
		end
	end
	if record then
		return record[field]
	else
		return nil
	end
end

function UpdateEntity:setValue(id, field, data)
	local record = {}
	record[self.pk] = id
	record[field] = data
	self:update(record)
end

function UpdateEntity:getKey(row)
	local fields = string.split(self.key, ",")
	local key
	for i=1, #fields do
		if i == 1 then
			key = row[fields[i]]
		else
			key = key .. ":" .. row[fields[i]]
		end
	end
	return tonumber(key) or key
end

function UpdateEntity:getAll()
	local rs = skynet.call("dbmgr", "lua", "get_update", self.tbname)
	return rs or nil
end

return UpdateEntity
