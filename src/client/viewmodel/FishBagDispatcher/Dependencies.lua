local FishBagDispatcherDependencies = {}

local injected = nil

function FishBagDispatcherDependencies.Inject(newDependencies)
    injected = newDependencies
end

function FishBagDispatcherDependencies.Get()
    return injected or {
        VM = require(Game:GetService("Players").LocalPlayer.PlayerScripts.src.viewmodel),
        FishBagContentsChangedRE = game.ReplicatedStorage.src.Player.Actions.Fishing.FishBagContentsChangedRE,
        GetTotalFishCaughtRF = game.ReplicatedStorage.src.Player.Stats.GetTotalFishCaughtRF,
        GetFishBagContentsRF = game.ReplicatedStorage.src.Player.Actions.Fishing.GetFishBagContentsRF
    }
end

return FishBagDispatcherDependencies