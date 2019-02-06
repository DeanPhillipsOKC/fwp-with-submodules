local RarityRepository = {}
RarityRepository.prototype = {}

local dependencies = require(script.Dependencies).Get()

RarityRepository.rarityTable = {
    "Common",
    "Uncommon",
    "Rare"
}

-- The roll starts at "Common" and only moves to the next level if a 1 out of 10 is rolled.
function RarityRepository.prototype.RollForRarity()
    for i,v in pairs(RarityRepository.rarityTable) do
        if dependencies.GetRandomInteger(1, #RarityRepository.rarityTable) == 1 then
            return RarityRepository.rarityTable[i]
        end
    end
    return RarityRepository.rarityTable[#RarityRepository.rarityTable]
end

return RarityRepository.prototype