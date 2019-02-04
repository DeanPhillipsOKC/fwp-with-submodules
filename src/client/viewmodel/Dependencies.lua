local vmDependencies = {}

local injected = nil

function vmDependencies.Inject(newDependencies)
    injected = newDependencies
end

function vmDependencies.Get()
    return injected or {
        Rodux = require(game.ReplicatedStorage.lib.Rodux),
        TotalCoinsReducer = require(script.TotalCoins.TotalCoinsReducer),
        IsfishingReducer = require(script.IsFishingReducer),
        WaitingForFishReducer = require(script.WaitingForFishReducer),
        FishBagReducer = require(script.FishBagReducer),
        FishBagDispatcherInstance = script.FishBagDispatcher
    }
end

return vmDependencies