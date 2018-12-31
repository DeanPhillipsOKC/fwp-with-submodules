local RemoteFunctionMock = {}

function RemoteFunctionMock.new(rf)
    rf = rf or {}
    rf.OnServerInvoke = nil
    setmetatable(rf, RemoteFunctionMock)

    return rf
end

function RemoteFunctionMock:InvokeServer(player, ...)
    return self.OnServerInvoke(player, ...)
end

RemoteFunctionMock.__index = RemoteFunctionMock
return RemoteFunctionMock