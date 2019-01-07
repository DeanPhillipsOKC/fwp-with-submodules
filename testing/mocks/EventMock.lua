local Event = {}

function Event.new(e)
    e = e or {}
    e.callback = function() end
    setmetatable(e, Event)
    return e
end

function Event:Connect(cb)
    self.callback = cb

    return {
        Disconnect = function()
            self.callback = nil
        end
    }
end

function Event:Fire(...)
    local cb = self.callback or function() end
    cb(...)
end

Event.__index = Event
return Event