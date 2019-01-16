local RemoteFunctionMock = {}

function RemoteFunctionMock.new(rf)
    rf = rf or {}
    rf.OnServerInvoke = nil
    rf.InvokeClientReturnValue = nil
    setmetatable(rf, RemoteFunctionMock)

    return rf
end

function RemoteFunctionMock:InvokeClient(player, ...)
    return self.InvokeClientReturnValue
end

function RemoteFunctionMock:InvokeServer(player, ...)
    return self.OnServerInvoke(player, ...)
end

RemoteFunctionMock.__index = RemoteFunctionMock
return RemoteFunctionMock