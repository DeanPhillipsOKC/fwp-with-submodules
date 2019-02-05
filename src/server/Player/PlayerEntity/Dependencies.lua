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
        FishBagContentsChangedRE = game.ReplicatedStorage.src.Player.Actions.Fishing.FishBagContentsChangedRE
    }
end

function Dependencies.Inject(newDependencies)
    injected = newDependencies
end

return Dependencies