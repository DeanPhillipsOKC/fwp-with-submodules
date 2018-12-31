local Rodux = require(script.Dependencies).Get().Rodux

local function reducer(state, action)
    state = state or {
        TotalCoins = 0,
    }

    if action.type == "totalCoinsChagned" then
        return {
            TotalCoins = action.newtotalCoins
        }
    end

    return state
end

local store = Rodux.Store.new(reducer)

return store