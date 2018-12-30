local StatsComponentDependencies = {}

local injected = nil

function StatsComponentDependencies.Inject(newDependencies)
    injected = newDependencies
end

function StatsComponentDependencies:Get()
    return injected or {
        Roact = require(game.ReplicatedStorage.lib.Roact),
        RoactRodux = require(game.ReplicatedStorage.lib.RoactRodux),
        PlayersService = game:GetService("Players"),
        LeftHudStats = require(script.Parent.LeftHudStats),
        VM = require(Game:GetService("Players").LocalPlayer.PlayerScripts.src.viewmodel)
    }
end

return StatsComponentDependencies