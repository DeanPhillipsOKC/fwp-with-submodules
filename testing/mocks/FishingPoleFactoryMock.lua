local FishingPoleFactoryMock = {}

function FishingPoleFactoryMock.new(data)
    data = data or {}
    setmetatable(data, FishingPoleFactoryMock)
    return data
end

FishingPoleFactoryMock.__index = FishingPoleFactoryMock
return FishingPoleFactoryMock