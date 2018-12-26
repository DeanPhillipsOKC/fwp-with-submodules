local Event = {}

function Event.new(e)
    e = e or {}
    setmetatable(e, Event)
    return e
end

local callback = function() end

function Event:Connect(cb)
    callback = cb
end

function Event:Fire(...)
    cb(...)
end

Event.__index = Event
return Event