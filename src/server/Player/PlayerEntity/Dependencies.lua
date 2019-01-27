local Dependencies = { }

local injected = nil

function Dependencies.Get()
    return injected or {
        DataStore = require (game.ServerScriptService.lib.datastore2),
        PlayerBackpack = require (script.Parent.Parent.PlayerBackpack),
        PlayerAnimationController = require(script.Parent.Parent.PlayerAnimationController),
        Bobber = require (game.ServerScriptService.src.Fishing.FishingBobber),
        FishingController = require(script.Parent.Parent.PlayerFishingController),
        FishingPoleRepository = require(game.ServerScriptService.src.Fishing.FishingPoleRepository),
        EquippedToolLocation = game.Workspace,
        PlayersService = game:GetService("Players"),
        TotalFishCaughtChangedRE = game.ReplicatedStorage.src.Player.Stats.TotalFishCaughtChangedRE
    }
end

function Dependencies.Inject(newDependencies)
    injected = newDependencies
end

return Dependencies