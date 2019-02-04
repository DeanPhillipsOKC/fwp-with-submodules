local RoactRoduxMock = {}

function RoactRoduxMock.connect(fn)
    return function(arg)
        return {
            Mapper = fn,
            PropertyBuilder = arg
        }
    end
end

return RoactRoduxMock