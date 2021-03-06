local RemoteEventMock = {}

function RemoteEventMock.new(e)
    e = e or {}
    e.handleClientCallback = function() end
    e.handleServerCallback = function() end

    e.OnServerEvent = {

        Connect = function (instance, cb)
            e.handleServerCallback = cb
        end
    }

    e.OnClientEvent = {
        Connect = function (instance, cb)
            e.handleClientCallback = cb
        end
    }

    setmetatable(e, RemoteEventMock)
    return e
end

function RemoteEventMock:HandleClient(cb)
    self.handleClientCallback = cb
end

function RemoteEventMock:FireClient(player, ...)
    self.handleClientCallback(...)
end

function RemoteEventMock:FireServer(...)
    self.handleServerCallback(...)
end

RemoteEventMock.__index = RemoteEventMock
return RemoteEventMock