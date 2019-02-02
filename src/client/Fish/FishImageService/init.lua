local FishImageService = {}

nameToImageIdMap = { }
nameToImageIdMap["Green Banded Lilac Wretzel"] = "2771043601"
nameToImageIdMap["Brown Spotted Sturdy Erv"] = "2754714344"
nameToImageIdMap["Sweetwater Melon Cote"] = "2773360527"
nameToImageIdMap["Silver Dollar Sand Skipper"] = "2778875718"

function FishImageService.GetAssetIdFromName(fishName)
    assert(fishName ~= nil, "Fish name parameter is null.")
    assert(nameToImageIdMap[fishName] ~= nil, "Could not find an asset id for " .. fishName)

    return nameToImageIdMap[fishName]
end

return FishImageService