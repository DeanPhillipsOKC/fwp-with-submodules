local PlayerRepositoryDependencies = {}

local injected = nil

function PlayerRepositoryDependencies.Inject(newDependencies)
    injected = newDependencies
end

function PlayerRepositoryDependencies.Get()
    return injected or {    
        PlayersService = game:GetService("Players"),
        PlayerFactory = require(game.ServerScriptService.Player.PlayerEntity),
        PlayerInstantiatedEvent = game.ReplicatedStorage.Player.PlayerInstantiated,
        GetCoinsRemoteFunction = game.ReplicatedStorage.Player.GetCoins
    }
end

return PlayerRepositoryDependencies