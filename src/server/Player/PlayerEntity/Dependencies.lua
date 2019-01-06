local Dependencies = { }

local injected = nil

function Dependencies.Get()
    return injected or {
        DataStore = require (game.ServerScriptService.lib.datastore2),
        PlayerBackpack = require (script.Parent.Parent.PlayerBackpack),
        PlayerAnimationController = require(script.Parent.Parent.PlayerAnimationController)
    }
end

function Dependencies.Inject(newDependencies)
    injected = newDependencies
end

return Dependencies