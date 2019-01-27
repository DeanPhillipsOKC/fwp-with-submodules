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
        GetTotalFishCaughtRF = game.ReplicatedStorage.src.Player.Stats.GetTotalFishCaughtRF,
        StartFishingRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StartFishingRE,
        StopFishingRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StopFishingRE,
        WaitForFishRE = game.ReplicatedStorage.src.Player.Actions.Fishing.WaitForFishRE,
        CaughtFishRE = game.ReplicatedStorage.src.Player.Actions.Fishing.CaughtFishRE
    }
end

return PlayerRepositoryDependencies