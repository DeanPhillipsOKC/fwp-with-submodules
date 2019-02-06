local FishRepository = {}
FishRepository.prototype = {}

local dependencies = require(script.Dependencies).Get()

FishRepository.fishTable = {
    "Green Banded Lilac Wretzel", 
    "Brown Spotted Sturdy Erv",
    "Sweetwater Melon Cote", 
    "Silver Dollar Sand Skipper"
}

function FishRepository.prototype.RollForFish()
    return FishRepository.fishTable[math.random(1, #FishRepository.fishTable)]
end

return FishRepository.prototype