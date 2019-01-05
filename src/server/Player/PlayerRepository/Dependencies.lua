local PlayerRepositoryDependencies = {}

local injected = nil

function PlayerRepositoryDependencies.Inject(newDependencies)
    injected = newDependencies
end

function PlayerRepositoryDependencies.Get()
    return injected or {    
        PlayersService = game:GetService("Players"),
        PlayerFactory = require(script.Parent.Parent.PlayerEntity),
        PlayerInstantiatedEvent = game.ReplicatedStorage.src.Player.PlayerInstantiatedRE,
        GetTotalCoinsRF = game.ReplicatedStorage.src.Player.Stats.GetTotalCoinsRF,
    }
end

return PlayerRepositoryDependencies