local PlayerFishingControllerDependencies = {}

local injected = nil

function PlayerFishingControllerDependencies.Inject(newDependencies)
    injected = newDependencies
end

function PlayerFishingControllerDependencies.Get()
    return injected or {
        StartFishingRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StartFishingRE,
        StopFishingRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StopFishingRE,
        WaitForFishRE = game.ReplicatedStorage.src.Player.Actions.Fishing.WaitForFishRE,
        FishRepository = require(game.ServerScriptService.src.Fishing.FishRepository)
    }
end

return PlayerFishingControllerDependencies