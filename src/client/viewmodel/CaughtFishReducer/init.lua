local function reducer(state, action)
    
    if action.type == "caughtfish" then
        return {
            Name = action.fishName,
            ImageId = action.fishImageId,
            TimeLastFishWasCaught = action.timeLastFishWasCaught
        }
    end

    return state.CaughtFish or {}
end

return reducer