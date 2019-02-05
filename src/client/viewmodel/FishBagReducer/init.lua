local function reducer(state, action)
    
    local dependencies = require(script.Dependencies).Get()
    
    if action.type == "fishBagContentsChanged" then
        assert(action.FishBag ~= nil, "Fish bag contents changed, but were not sent with the event dispatcher.")
        assert(action.FishBag.Total ~= nil, "Fish bag contents changed, but the event dispatcher did not send a new total.")
        assert(action.FishBag.Contents ~= nil, "Fish bag contents changed, but the event dispatcher did not send new contents.")

        local totalFishInBag = action.FishBag.Total
        local bagContents = action.FishBag.Contents

        local newState = {}
        newState.Total = totalFishInBag
        newState.Contents = {}

        for k,v in pairs(bagContents) do
            newState.Contents[k] = {}
            newState.Contents[k].ImageAssetId = dependencies.FishImageService.GetAssetIdFromName(k)
            newState.Contents[k].Total = v
        end

        return newState
    end

    return state.FishBag or {
        Total = 0,
        Contents = {}
    }
end

return reducer