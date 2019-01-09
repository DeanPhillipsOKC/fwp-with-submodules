local FishingPoleControllerDependencies = {}

local injected = nil

function FishingPoleControllerDependencies.Inject(newDependencies)
    injected = newDependencies
end

function FishingPoleControllerDependencies.Get()
    return injected or {
        LocalPlayer = game.Players.LocalPlayer,
        StartFishingRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StartFishingRE,
        StopFishingRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StopFishingRE,
        UserInputService = game:GetService("UserInputService"),
        Input2dToWorld3dService = require(script.Parent.Parent.Parent.Parent.Input.Input2dToWorld3dService)
    }
end

return FishingPoleControllerDependencies