local FishImageServiceMock = {}

local map = nil

function FishImageServiceMock.SetMap(newMap)
    map = newMap
end

function FishImageServiceMock.GetAssetIdFromName(name)
    return map ~= nil and map[name] or name
end

return FishImageServiceMock