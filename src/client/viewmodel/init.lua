local Rodux = require(script.Dependencies).Get().Rodux

local TotalCoinsReducer = require(script.TotalCoins.TotalCoinsReducer)
local IsfishingReducer = require(script.IsFishingReducer)
local WaitingForFishReducer = require(script.WaitingForFishReducer)

function reducer(state, action)
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