local FishingPoleDependencies = {}

local injected = nil

function FishingPoleDependencies.Inject(newDependencies)
    injected = newDependencies
end

function FishingPoleDependencies.Get()
    return injected or {
        
    }
end

return FishingPoleDependencies