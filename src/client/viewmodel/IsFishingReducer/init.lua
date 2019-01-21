local function reducer(state, action)
    if action.type == "playerisfishing" then
        return true
    elseif action.type == "playerstoppedfishing" then
        return false
    end

    return state.PlayerIsFishing
end

return reducer