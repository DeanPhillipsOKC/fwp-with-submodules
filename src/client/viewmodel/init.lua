local Rodux = require(script.Dependencies).Get().Rodux

local function reducer(state, action)
    state = state or {
        TotalCoins = nil,
    }

    if action.type == "totalCoinsChanged" then
        return {
            TotalCoins = action.newtotalCoins
        }
    end

    return state
end

local store = Rodux.Store.new(reducer)

return store