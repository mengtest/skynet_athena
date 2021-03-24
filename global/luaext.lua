-- lua扩展

-- table扩展

-- 返回table大小
table.size = function(t)
	local count = 0
	for _ in pairs(t) do
		count = count + 1
	end
	return count
end

-- 判断table是否为空
table.empty = function(t)
    return not next(t)
end

-- 返回table键列表
table.keys = function(hashtable)
    local keys = {}
    for k, v in pairs(hashtable) do
        keys[#keys + 1] = k
    end
    return keys
end

-- 返回table值列表
table.values = function(t)
    local result = {}
    for k, v in pairs(t) do
        table.insert(result, v)
    end
    return result
end

-- 返回索引
table.indexof = function(array, value, begin)
    for i = begin or 1, #array do
        if array[i] == value then return i end
    end
	return -1
end

table.equal = function (a, b)
    if type(a)~="table" or type(b)~="table" then
        return false
    end
    if #a ~= #b then
        return false
    end
    
    for k, v in pairs(a) do
        if b[k] == nil then
            return false
        end
        if type(a[k]) == "table" then
            if not table.equal(a[k], b[k]) then
                return false
            end
        end
        if a[k] ~= b[k] then
            return false
        end
    end
    return true
end

-- 浅拷贝
table.clone = function(t, nometa)
    local result = {}
    if not nometa then
        setmetatable(result, getmetatable(t))
    end
    for k, v in pairs (t) do
        result[k] = v
    end
    return result
end

-- 深拷贝
table.copy = function(t, nometa)   
    local result = {}

    if not nometa then
        setmetatable(result, getmetatable(t))
    end

    for k, v in pairs(t) do
        if type(v) == "table" then
            result[k] = copy(v)
        else
            result[k] = v
        end
    end
    return result
end

table.merge = function(dest, src)
    for k, v in pairs(src) do
        dest[k] = v
    end
end

table.shuffle = function(t)
    if type(t)~="table" then
        return
    end
    local tab={}
    local index=1
    while #t~=0 do
        local n=math.random(0,#t)
        if t[n]~=nil then
            tab[index]=t[n]
            table.remove(t,n)
            index=index+1
        end
    end
    return tab
end

table.find = function (tab, value)
    if not value then
        return 0
    end
    for k,v in ipairs(tab) do
        if v == value then
            return k
        end
    end
    return nil
end

table.finds  = function (tab, str, value)
    for i = 1, #tab do
        if tab[i].str == value then
            return i
        end
    end
    return nil
end

-- string扩展

-- 下标运算
do
    local mt = getmetatable("")
    local _index = mt.__index

    mt.__index = function (s, ...)
        local k = ...
        if "number" == type(k) then
            return _index.sub(s, k, k)
        else
            return _index[k]
        end
    end
end

string.split = function(s, delim)
    if delim == nil then
        delim = ","
    end
    local split = {}
    if s == nil then
        return split
    end
    s = string.gsub(s,"%s+","")
    local pattern = "[^" .. delim .. "]+"
    string.gsub(s, pattern, function(v) table.insert(split, v) end)
    return split
end

string.join = function(arr, str)
    local res= ""
    if arr == nil then
        return res
    end
    str = str or ","
    for i = 1, #arr do
        if i ~= 1 then
            res = res .. str .. arr[i]
        else
            res = arr[i]
        end
    end
    return tostring(res)
end

string.ltrim = function(s, c)
    local pattern = "^" .. (c or "%s") .. "+"
    return (string.gsub(s, pattern, ""))
end

string.rtrim = function(s, c)
    local pattern = (c or "%s") .. "+" .. "$"
    return (string.gsub(s, pattern, ""))
end

string.trim = function(s, c)
    return string.rtrim(string.ltrim(s, c), c)
end


--[[--

计算 UTF8 字符串的长度，每一个中文算一个字符

~~~ lua

local input = "你好World"
print(string.utf8len(input))
-- 输出 7

~~~

@param string input 输入字符串

@return integer 长度

]]
string.utf8len = function(input)
    local len  = string.len(input)
    local left = len
    local cnt  = 0
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left ~= 0 do
        local tmp = string.byte(input, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
    end
    return cnt
end

----过滤出规范字符 只保留汉字、数字、字符
string.filterspecchars = function(s)   
	local ss = {}    
	local k = 1    
	while true do        
		if k > #s then break end        
		local c = string.byte(s,k)        
		if not c then break end        
		if c<192 then            
			if (c>=48 and c<=57) or (c>= 65 and c<=90) or (c>=97 and c<=122) then                
				table.insert(ss, string.char(c))            
			end            
			k = k + 1        
		elseif c<224 then            
			k = k + 2        
		elseif c<240 then            
			if c>=228 and c<=233 then                
				local c1 = string.byte(s,k+1)                
				local c2 = string.byte(s,k+2)               
				if c1 and c2 then                    
					local a1,a2,a3,a4 = 128,191,128,191                    
					if c == 228 then a1 = 184                    
					elseif c == 233 then 
						a2,a4 = 190,c1 ~= 190 and 191 or 165                    
					end                    
					if c1>=a1 and c1<=a2 and c2>=a3 and c2<=a4 then                        
						table.insert(ss, string.char(c,c1,c2))                    
					end                
				end            
			end            
			k = k + 3        
		elseif c<248 then            
			k = k + 4        
		elseif c<252 then            
			k = k + 5        
		elseif c<254 then            
			k = k + 6       
		end    
	end    
	return table.concat(ss)
end
---------------

local function dump(obj)
    local getIndent, quoteStr, wrapKey, wrapVal, dumpObj
    getIndent = function(level)
        return string.rep("\t", level)
    end
    quoteStr = function(str)
        return '"' .. string.gsub(str, '"', '\\"') .. '"'
    end
    wrapKey = function(val)
        if type(val) == "number" then
            return "[" .. val .. "]"
        elseif type(val) == "string" then
            return "[" .. quoteStr(val) .. "]"
        else
            return "[" .. tostring(val) .. "]"
        end
    end
    wrapVal = function(val, level)
        if type(val) == "table" then
            return dumpObj(val, level)
        elseif type(val) == "number" then
            return val
        elseif type(val) == "string" then
            return quoteStr(val)
        else
            return tostring(val)
        end
    end
    dumpObj = function(obj, level)
        if type(obj) ~= "table" then
            return wrapVal(obj)
        end
        level = level + 1
        local tokens = {}
        tokens[#tokens + 1] = "{"
        for k, v in pairs(obj) do
            tokens[#tokens + 1] = getIndent(level) .. wrapKey(k) .. " = " .. wrapVal(v, level) .. ","
        end
        tokens[#tokens + 1] = getIndent(level - 1) .. "}"
        return table.concat(tokens, "\n")
    end
    return dumpObj(obj, 0)
end

do
    local _tostring = tostring
    tostring = function(v)
        if type(v) == 'table' then
            return dump(v)
        else
            return _tostring(v)
        end
    end
end

-- math扩展
do
	local _floor = math.floor
	math.floor = function(n, p)
		if p and p ~= 0 then
			local e = 10 ^ p
			return _floor(n * e) / e
		else
			return _floor(n)
		end
	end
end

math.round = function(n, p)
        local e = 10 ^ (p or 0)
        return math.floor(n * e + 0.5) / e
end


-- 最小数值和最大数值指定返回值的范围。
-- @function [parent=#math] clamp
math.clamp = function(v, minValue, maxValue)  
    if v < minValue then
        return minValue
    end
    if( v > maxValue) then
        return maxValue
    end
    return v 
end

math.pow = function(a, b)
    return a^b
end

-- lua面向对象扩展
function class(classname, super)
    local superType = type(super)
    local cls

    if superType ~= "function" and superType ~= "table" then
        superType = nil
        super = nil
    end

    if superType == "function" or (super and super.__ctype == 1) then
        -- inherited from native C++ Object
        cls = {}

        if superType == "table" then
            -- copy fields from super
            for k,v in pairs(super) do cls[k] = v end
            cls.__create = super.__create
            cls.super    = super
        else
            cls.__create = super
            cls.ctor = function() end
        end

        cls.__cname = classname
        cls.__ctype = 1

        function cls.new(...)
            local instance = cls.__create(...)
            -- copy fields from class to native object
            for k,v in pairs(cls) do instance[k] = v end
            instance.class = cls
            instance:ctor(...)
            return instance
        end

    else
        -- inherited from Lua Object
        if super then
            cls = {}
            setmetatable(cls, {__index = super})
            cls.super = super
        else
            cls = {ctor = function() end}
        end

        cls.__cname = classname
        cls.__ctype = 2 -- lua
        cls.__index = cls

        function cls.new(...)
            local instance = setmetatable({}, cls)
            instance.class = cls
            instance:ctor(...)
            return instance
        end
    end

    return cls
end

function iskindof(obj, classname)
    local t = type(obj)
    local mt
    if t == "table" then
        mt = getmetatable(obj)
    elseif t == "userdata" then
        mt = tolua.getpeer(obj)
    end

    while mt do
        if mt.__cname == classname then
            return true
        end
        mt = mt.super
    end

    return false
end
