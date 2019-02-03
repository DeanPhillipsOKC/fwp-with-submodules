local FishBagReducerDependencies = {}

local injected = nil

function FishBagReducerDependencies.Inject(newDependencies)
    injected = newDependencies
end

function FishBagReducerDependencies.Get()
    return injected or {
        FishImageService = require(game.Players[game.Players.LocalPlayer].src.Fish.FishImageService)
    }
end

return FishBagReducerDependencies