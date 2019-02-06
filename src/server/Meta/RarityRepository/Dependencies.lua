local RarityRepositoryDependencies = {}

local injected = nil

function RarityRepositoryDependencies.Inject(newDependencies)
    injected = newDependencies
end

function RarityRepositoryDependencies.Get()
    return injected or {
        GetRandomInteger = math.random
    }
end

return RarityRepositoryDependencies