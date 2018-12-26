local DataStore2Mock = {}

local valueReturnedByGet = nil

function DataStore2Mock.SetGet(valueToReturn)
    valueReturnedByGet = valueToReturn
end

function DataStore2Mock.new(s)
    s = s or {}
    setmetatable(s, DataStore2Mock)
    return s
end

function DataStore2Mock:__call(storeName, player)
    return DataStore2Mock.new(player)
end

function DataStore2Mock:Get(default)
    return valueReturnedByGet or default
end

function DataStore2Mock:Set(newAmount)
    valueReturnedByGet = newAmount
end

setmetatable(DataStore2Mock, DataStore2Mock)
DataStore2Mock.__index = DataStore2Mock

return DataStore2Mock