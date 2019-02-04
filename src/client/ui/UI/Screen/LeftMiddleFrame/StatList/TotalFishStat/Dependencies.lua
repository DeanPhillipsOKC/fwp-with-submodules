local TotalFishStatDependencies = {}

local injected = nil

function TotalFishStatDependencies.Inject(newDependencies)
    injected = newDependencies
end

function TotalFishStatDependencies.Get()
    return injected or {
        Roact = require(game.ReplicatedStorage.lib.Roact),
        RoactRodux = require(game.ReplicatedStorage.lib.RoactRodux),
        BaseComponent = require(script.Parent.LeftHudStat)
    }
end

return TotalFishStatDependencies