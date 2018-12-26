local RemoteEventMock = {}

function RemoteEventMock.new(e)
    e = e or {}
    setmetatable(e, RemoteEventMock)
    return e
end

local handleClientCallback = function () end

function RemoteEventMock:HandleClient(cb)
    handleClientCallback = cb
end

function RemoteEventMock:FireClient(...)
    handleClientCallback(...)
end

RemoteEventMock.__index = RemoteEventMock
return RemoteEventMock