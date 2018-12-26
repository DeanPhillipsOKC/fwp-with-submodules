local Dependencies = { }

local injected = nil

function Dependencies.Get()
    return injected or {
        DataStore = require (game.ServerScriptService.lib.datastore2)
    }
end

function Dependencies.Inject(newDependencies)
    injected = newDependencies
end

return Dependencies