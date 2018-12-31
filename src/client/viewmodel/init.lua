local Rodux = require(script.Dependencies).Get().Rodux

local TotalCoinsReducer = require(script.TotalCoinsReducer)

function reducer(state, action)
    state = state or {}
    return {
        TotalCoins = TotalCoinsReducer(state.TotalCoins, action)
    }
end


local store = Rodux.Store.new(reducer)

return store