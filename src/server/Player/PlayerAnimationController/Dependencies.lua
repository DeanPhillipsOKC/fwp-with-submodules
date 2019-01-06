local PlayerAnimationControllerDependencies = {}

local injected = nil

function PlayerAnimationControllerDependencies.Inject(newDependencies)
    injected = newDependencies
end

function PlayerAnimationControllerDependencies.Get()
    return injected or {
        ReplicatedStorage = game.ReplicatedStorage,
        PlayersService = game:GetService("Players")
    }
end

return PlayerAnimationControllerDependencies