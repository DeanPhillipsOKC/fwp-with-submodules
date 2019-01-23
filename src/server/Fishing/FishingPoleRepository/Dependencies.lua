local FishingPoleRepositoryDependencies = {}

local injected = nil

function FishingPoleRepositoryDependencies.Inject(newDependencies)
    injected = newDependencies
end

function FishingPoleRepositoryDependencies.Get()
    return inject or {
        FishingPoleFactory = require(script.Parent.Parent.FishingPole)
    }
end

return FishingPoleRepositoryDependencies