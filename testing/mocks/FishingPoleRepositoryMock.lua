local FishingPoleRepositoryMock = {}

FishingPoleRepositoryMock.poles = {}

function FishingPoleRepositoryMock.Get(poleName)
    return FishingPoleRepositoryMock.poles[poleName]
end

return FishingPoleRepositoryMock