local Rodux = require(script.Dependencies).Get().Rodux

local TotalCoinsReducer = require(script.TotalCoins.TotalCoinsReducer)
local IsfishingReducer = require(script.IsFishingReducer)
local WaitingForFishReducer = require(script.WaitingForFishReducer)

-- These are not used, but need to be loaded so that the dispatchers can respond to events
local FishBagDispatcher = require(script.FishBagDispatcher)

local function reducer(state, action)
    state = state or {}
    local newState = {
        TotalCoins = TotalCoinsReducer(state.TotalCoins, action),
        PlayerIsFishing = IsfishingReducer(state, action),
        WaitingForFish = WaitingForFishReducer(state, action) or {},
    }

    return newState
end

local store = Rodux.Store.new(reducer)

return store