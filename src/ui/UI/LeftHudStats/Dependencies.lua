local UiAcrossFoldeRDependencies = {}

local injected = nil

function UiAcrossFoldeRDependencies.Inject(newDependencies)
    injected = newDependencies
end

function UiAcrossFoldeRDependencies.Get()
    return injected or {
        Roact = require(game.ReplicatedStorage.lib.roact.lib)
    }
end

return UiAcrossFoldeRDependencies