local FishingPole = {}

function FishingPole.new(data)
    assert(data ~= nil, "Cannot instantiate a fishing pole without providing data.")
    assert(data.CatchDelay ~= nil, "Cannot instantiate a fishing pole without providing a catch delay.")

    local newPole = {
        CatchDelay = data.CatchDelay    -- Seconds / Fish
    }
    setmetatable(newPole, FishingPole)
    return newPole
end

FishingPole.__index = FishingPole
return FishingPole