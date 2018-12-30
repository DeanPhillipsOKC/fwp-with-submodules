local UiAcrossFolderDependencies = {}

local injected = nil

function UiAcrossFolderDependencies.Inject(newDependencies)
    injected = newDependencies
end

function UiAcrossFolderDependencies.Get()
    return injected or {
        Roact = require(game.ReplicatedStorage.lib.Roact),
        LeftHudStatContainer = require(script.Parent.LeftHudStat)
    }
end

return UiAcrossFolderDependencies