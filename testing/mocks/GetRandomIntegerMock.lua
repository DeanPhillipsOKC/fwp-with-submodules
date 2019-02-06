local GetRandomIntegerMock = {}

function GetRandomIntegerMock.new(returnVals)
    local settings = {
        counter = 1,
        returnVals = returnVals
    }

    setmetatable(settings, GetRandomIntegerMock)

    return GetRandomIntegerMock
end

GetRandomIntegerMock.__call = function(self)
    local returnVal = self.returnVals[self.counter]
    self.counter = self.counter + 1
end

GetRandomIntegerMock.__index = GetRandomIntegerMock
return GetRandomIntegerMock
