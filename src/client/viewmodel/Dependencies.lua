local vmDependencies = {}

local injected = nil

function vmDependencies.Inject(newDependencies)
    injected = newDependencies
end

function vmDependencies.Get()
    return injected or {
        Rodux = require(game.ReplicatedStorage.lib.Rodux)
    }
end

return vmDependencies