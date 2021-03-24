-- --------------------------------------
-- Author: zhangwei
-- Version: 1.0
-- Filename: timecheckmgr.lua
-- Introduce: 到期检查类
-- --------------------------------------
local timext = require "timext"
local TimeCheckMgr = class("TimeCheckMgr")

--[[
    检查队列的时间配置
    checkCfg = {1,300,3600} -- 1秒、5分钟、1小时三级检查队列
]]

local normal_checkCfg = {1, 300, 3600}

--[[
    checkCfg 检查时间配置
    completeHandler 完成回调
    isAddCover 添加的时候，发现已有对象，是否直接覆盖
]]
function TimeCheckMgr:ctor(checkCfg, completeHandler, isAddCover)
    self._checkCfg = checkCfg or normal_checkCfg
    self._checkList = {}
    self._checkTimer = {}
    self._bInitTimer = false
    self._isAddCover = isAddCover
    -- 默认完成调用的方法
    self._completeHandler = completeHandler
    if not completeHandler then
       LOG_ERROR("TimeCheckMgr create err")
    end
    for index, _ in ipairs(self._checkCfg) do
        self._checkList[index] = {}
    end
end

function TimeCheckMgr:run()
    -- 检查锁队列
    local current_time = timext.current_time()
    -- 遍历队列
    for index = #self._checkCfg, 1, -1 do
        if self._checkTimer[index] and self._checkTimer[index]:expire() then
            self._checkTimer[index]:update(self._checkCfg[index])
            local check_time = current_time
            local array = self._checkList[index]
            -- 如果还有上一级的检查，那判断比较特殊
            if self._checkList[index - 1] then
                check_time = check_time + self._checkCfg[index]
            end
            if not array then
                LOG_ERROR("TimeCheckMgr err array is nil, index:%d", index)
                break
            end
            local keylist = table.indices(array)
            for key_index = 1, #keylist do
                local key = keylist[key_index]
                local data = array[key]
                if data and data.endTime <= check_time then
                    array[key] = nil
                    if self._checkList[index - 1] then
                        self._checkList[index - 1][key] = data
                    else
                        if data.completeHandler then
                            data.completeHandler(key, data.data, data.endTime)
                        else
                            self._completeHandler(key, data.data, data.endTime)
                        end
                    end
                end
            end
        end
    end
end

--[[
    添加检查对象
    key     对象唯一key
    data    中转数据
    endTime 到期时间
    completeHandler 完成调用的方法，如果不传，则调用默认完成方法
]]
function TimeCheckMgr:addCheckItem(key, data, endTime, completeHandler)
    local curTime = timext.current_time()
    -- if curTime >= endTime then
    --     return false
    -- end

    local isAddCover = self._isAddCover
    if isAddCover then
        self:removeCheckItem(key)
    else
        -- 检查下是否已经有这个key了
        for _, arr in pairs(self._checkList) do
            if arr[key] then
                return false
            end
        end
    end

    -- 初始化timer
    if not self._bInitTimer then
        for index, _ in ipairs(self._checkCfg) do
            local check_second = self._checkCfg[index]
            self._checkTimer[index] = timext.create_timer(check_second)
        end
        self._bInitTimer = true
    end

    local remaintime = endTime - curTime
    -- 遍历放进适合的队列中
    for index = #self._checkCfg, 1, -1 do
        local check_second = self._checkCfg[index]
        if check_second <= remaintime then
            self._checkList[index][key] = {
                data = data,
                endTime = endTime,
                completeHandler = completeHandler,
            }
            -- if not self._checkTimer[index] then
            --     self._checkTimer[index] = timext.create_timer(check_second)
            -- end
            -- log.Dump("timecheckmgr", self._checkList, "TimeCheckMgr.addCheckItem._checkList:")
            return true, index
        end
    end

    -- 如果都没有加上，直接放在第一层
    do
        -- local check_second = self._checkCfg[1]
        -- log.Info("timecheckmgr", "TimeCheckMgr.addCheckItem. key:", key, " endtime:", endTime)
        self._checkList[1][key] = {
            data = data,
            endTime = endTime,
            completeHandler = completeHandler,
        }
        -- if not self._checkTimer[1] then
        --     self._checkTimer[1] = timext.create_timer(check_second)
        -- end
        return true, 1
    end
end

function TimeCheckMgr:removeCheckItem(key)
    -- 检查下是否已经有这个key了
    for _, arr in pairs(self._checkList) do
        if arr[key] then
            arr[key] = nil
            return true
        end
    end

    return false
end

-- 更新到期时间
function TimeCheckMgr:updateCheckTime(key, endtime)
    local checkData
    -- 移除老的
    for _, arr in pairs(self._checkList) do
        if arr[key] then
            checkData = arr[key]
            arr[key] = nil
        end
    end
    if checkData then
        -- 重新添加新的
        checkData.endTime = endtime
        self:addCheckItem(key, checkData.data, endtime, checkData.completeHandler)
        return true
    else
        return false
    end
end

-- 清理所有事件
function TimeCheckMgr:clearAllCheckItem()
    local checkList = self._checkList
    for index, _ in ipairs(checkList) do
        checkList[index] = {}
    end
end

return TimeCheckMgr