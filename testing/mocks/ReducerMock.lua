local ReducerMock = {}

function ReducerMock.new()
    local reducer = {}
    reducer.stateCapture = nil
    reducer.actionCapture = nil
    reducer.returnValue = nil

    setmetatable(reducer, {
        __call = function(state, action)
            reducer.stateCapture = state
            reducer.actionCapture = action
            
            return reducer.returnValue ~= nil and reducer.returnValue or state
        end
    })

    return reducer
end

return ReducerMock