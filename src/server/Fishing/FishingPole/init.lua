local FishingPole = {}

local dependencies = require(script.Dependencies).Get()

function FishingPole.new(data)
    assert(data ~= nil, "Cannot instantiate a fishing pole without providing data.")
    assert(data.CatchDelay ~= nil, "Cannot instantiate a fishing pole without providing a catch delay.")
    assert(data.Name ~= nil, "Cannot instantiate a fishing pole without providing a name for it.")
    assert(dependencies.LocationOfPoleModels[data.Name] ~= nil, "Cannot instantiate a fishing pole named " .. data.Name .. ", because there is no model for it.")

    local newPole = {
        Name = data.Name,               -- Matches name of model
        CatchDelay = data.CatchDelay    -- Seconds / Fish
    }
    setmetatable(newPole, FishingPole)
    return newPole
end

FishingPole.__index = FishingPole
return FishingPole