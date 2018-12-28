local StatsComponentDependencies = {}

local injected = nil

function StatsComponentDependencies.Inject(newDependencies)
    injected = newDependencies
end

function StatsComponentDependencies:Get()
    return injected or {
        Roact = require(game.ReplicatedStorage.lib.roact.lib),
        PlayersService = game:GetService("Players"),
        LeftHudStats = require(script.Parent.LeftHudStats)
    }
end

return StatsComponentDependencies