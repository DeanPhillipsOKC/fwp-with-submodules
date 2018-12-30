print("including the vm")

local Rodux = require(script.Dependencies).Get().Rodux

local function TotalCoinsChanged(newTotal)
    return {
        type = "TotalCoinsChanged",
        newTotal = newTotal
    }
end

local totalCoinsReducer = Rodux.createReducer("", {
    RecievedNewTotal = function(state, action)
        return action.newTotal
    end,
})

local reducer = Rodux.combineReducers({
    playerTotalCoins = totalCoinsReducer,
})

local store = Rodux.Store.new(reducer, nil, {
    Rodux.loggerMiddleware,
})

store:dispatch(TotalCoinsChanged(12345))

return store