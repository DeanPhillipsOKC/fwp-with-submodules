local RoduxStoreMock = {}

function RoduxStoreMock.new(reducer)
    return reducer
end

RoduxStoreMock.__index = RoduxStoreMock
return RoduxStoreMock