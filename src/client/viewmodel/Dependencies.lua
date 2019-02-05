local vmDependencies = {}

local injected = nil

function vmDependencies.Inject(newDependencies)
    injected = newDependencies
end

function vmDependencies.Get()
    return injected or {
        Rodux = require(game.ReplicatedStorage.lib.Rodux),
        TotalCoinsReducer = require(script.Parent.TotalCoins.TotalCoinsReducer),
        IsfishingReducer = require(script.Parent.IsFishingReducer),
        WaitingForFishReducer = require(script.Parent.WaitingForFishReducer),
        FishBagReducer = require(script.Parent.FishBagReducer),
    }
end

return vmDependencies