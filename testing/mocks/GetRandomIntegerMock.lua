local GetRandomIntegerMock = {}

function GetRandomIntegerMock.new(returnVals)
    local settings = {
        counter = 1,
        returnVals = returnVals
    }

    setmetatable(settings, GetRandomIntegerMock)

    return settings
end

function GetRandomIntegerMock.__call(self)
    local returnVal = self.returnVals[self.counter]
    self.counter = self.counter + 1
    return returnVal
end

GetRandomIntegerMock.__index = GetRandomIntegerMock
return GetRandomIntegerMock
