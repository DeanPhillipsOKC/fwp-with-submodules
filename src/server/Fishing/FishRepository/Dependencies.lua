local FishRepositoryDependencies = {}

local injected = nil

function FishRepositoryDependencies.Inject(newDependencies)
    injected = newDependencies
end

function FishRepositoryDependencies.Get()
    return injected or {
        
    }
end

return FishRepositoryDependencies