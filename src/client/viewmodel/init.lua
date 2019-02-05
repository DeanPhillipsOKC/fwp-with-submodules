local dependencies = require(script.Dependencies).Get()

local function reducer(state, action)
    state = state or {}
    local newState = {
        FishBag = dependencies.FishBagReducer(state, action),
        TotalCoins = dependencies.TotalCoinsReducer(state.TotalCoins, action),
        PlayerIsFishing = dependencies.IsfishingReducer(state, action),
        WaitingForFish = dependencies.WaitingForFishReducer(state, action) or {}
    }
    return newState
end

local store = dependencies.Rodux.Store.new(reducer)

return store