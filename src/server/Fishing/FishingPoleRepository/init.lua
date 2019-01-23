local FishingPoleRepository = {}

local dependencies = require(script.Dependencies).Get()

local poles = {
    BasicPole = dependencies.FishingPoleFactory.new({
        Name = "BasicPole",
        CatchDelay = 5
    })
}

function FishingPoleRepository.Get(poleName)
    assert(poles[poleName] ~= nil, "Could not find a fishing pole in the repository named ", poleName)
    return poles[poleName]
end

return FishingPoleRepository