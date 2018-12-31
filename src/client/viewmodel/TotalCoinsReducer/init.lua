local function reducer(state, action)
    if action.type == "totalCoinsChanged" then
        return action.newTotalCoins
    end

    return state
end

return reducer