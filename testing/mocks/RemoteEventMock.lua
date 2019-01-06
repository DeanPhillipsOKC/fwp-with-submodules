local RemoteEventMock = {}

function RemoteEventMock.new(e)
    e = e or {}
    e.handleClientCallback = function() end
    e.handleServerCallback = function() end

    e.OnServerEvent = {
        Connect = function (cb)
            e.handleServerCallback = cb
        end
    }

    setmetatable(e, RemoteEventMock)
    return e
end

function RemoteEventMock:HandleClient(cb)
    self.handleClientCallback = cb
end

function RemoteEventMock:FireClient(...)
    self.handleClientCallback(...)
end

RemoteEventMock.__index = RemoteEventMock
return RemoteEventMock