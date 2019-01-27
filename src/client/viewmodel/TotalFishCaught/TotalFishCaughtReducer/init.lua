local function reducer(state, action)
    if action.type == "totalfishcaughtchanged" then
        return action.newTotalFishCaught
    end

    return state
end

return reducer