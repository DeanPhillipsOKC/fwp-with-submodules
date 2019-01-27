local Rodux = require(script.Dependencies).Get().Rodux

local TotalCoinsReducer = require(script.TotalCoins.TotalCoinsReducer)
local IsfishingReducer = require(script.IsFishingReducer)
local WaitingForFishReducer = require(script.WaitingForFishReducer)
local CaughtFishReducer = require(script.CaughtFishReducer)
local TotalFishCaughtReducer = require(script.TotalFishCaught.TotalFishCaughtReducer)

function reducer(state, action)
    state = state or {}
    local newState = {
        TotalCoins = TotalCoinsReducer(state.TotalCoins, action),
        TotalFishCaught = TotalFishCaughtReducer(state.TotalFishCaught, action),
        PlayerIsFishing = IsfishingReducer(state, action),
        WaitingForFish = WaitingForFishReducer(state, action) or {},
        CaughtFish = CaughtFishReducer(state, action)
    }

    return newState
end


local store = Rodux.Store.new(reducer)

return store