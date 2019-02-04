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

-- These are not used, but need to be loaded so that the dispatchers can respond to events
local FishBagDispatcher = require(dependencies.FishBagDispatcherInstance)

return store