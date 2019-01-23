local FishingPoleDependencies = {}

local injected = nil

function FishingPoleDependencies.Inject(newDependencies)
    injected = newDependencies
end

function FishingPoleDependencies.Get()
    return injected or {
        LocationOfPoleModels = game.ReplicatedStorage.Equipment.Poles
    }
end

return FishingPoleDependencies