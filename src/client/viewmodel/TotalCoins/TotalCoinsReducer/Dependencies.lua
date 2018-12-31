local TotalCoinsReducerDependencies = {}

local injected = nil

function TotalCoinsReducerDependencies.Inject(newDependencies)
    injected = newDependencies
end

function TotalCoinsReducerDependencies.Get()
    return injected or {
        GetTotalCoinsRF = game.ReplicatedStorage.src.Player.Stats.GetTotalCoinsRF
    }
end

return TotalCoinsReducerDependencies