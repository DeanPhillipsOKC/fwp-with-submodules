local leftHudStatDependencies = {}

local injected = nil

function leftHudStatDependencies.Inject(newDependencies)
    injected = newDependencies
end

function leftHudStatDependencies.Get()
    return injected or {
        Roact = require(game.ReplicatedStorage.lib.roact.lib)
    }
end

return leftHudStatDependencies