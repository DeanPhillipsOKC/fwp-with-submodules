local Event = {}

function Event.new(e)
    e = e or {}
    e.callback = function() end
    setmetatable(e, Event)
    return e
end

function Event:Connect(cb)
    self.callback = cb
end

function Event:Fire(...)
    self.callback(...)
end

Event.__index = Event
return Event