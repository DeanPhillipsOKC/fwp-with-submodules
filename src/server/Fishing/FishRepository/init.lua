local FishRepository = {}
FishRepository.prototype = {}

local dependencies = require(script.Dependencies).Get()

FishRepository.fishTables = {}

FishRepository.fishTables.Common = {
    "Brown Spotted Sturdy Erv",
    "Green Banded Lilac Wretzel", 
}

FishRepository.fishTables.Uncommon = {
    "Sweetwater Melon Cote", 
}

FishRepository.fishTables.Rare = {
    "Silver Dollar Sand Skipper"
}

function FishRepository.prototype.RollForFish(rarity)
    local fishTable = FishRepository.fishTables[rarity]

    return fishTable[math.random(1, #fishTable)]
end

return FishRepository.prototype