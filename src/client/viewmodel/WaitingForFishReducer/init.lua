local function reducer(state, action)
    if action.type == "waitingforfish" then
        return {
            Waiting = true,
            TimeToWait = action.timeToWait
        }
    elseif action.type == "stoppedwaitingforfish" then
        return {
            Waiting = false
        }
    end

    return state.WaitingForFish
end

return reducer