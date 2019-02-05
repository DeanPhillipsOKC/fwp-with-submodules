local FishInBagListComponentDependencies = {}

local injected = nil

function FishInBagListComponentDependencies.Inject(newDependencies)
    injected = newDependencies
end

function FishInBagListComponentDependencies.Get()
    return injected or {
        Roact = require(game.ReplicatedStorage.lib.Roact),
        RoactRodux = require(game.ReplicatedStorage.lib.RoactRodux),
        CaughtFishComponent = require(script.Parent.CaughtFish)
    }
end

return FishInBagListComponentDependencies