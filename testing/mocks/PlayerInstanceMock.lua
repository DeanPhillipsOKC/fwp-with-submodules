local PlayerInstanceMock = {}

local humanoidMock = require(game.Mocks.HumanoidMock)

--dependencies.PlayersService[self.PlayerName].Character.Humanoid:LoadAnimation(animation)
function PlayerInstanceMock.new(pi)
    local pi = pi or {} 
    pi.Character = {
        Humanoid = humanoidMock.new()
    }
    pi.DistanceFromCharacterReturnValue = nil
    setmetatable(pi, PlayerInstanceMock)
    return pi
end

function PlayerInstanceMock:DistanceFromCharacter(pointToMeasureFrom)
    return self.DistanceFromCharacterReturnValue
end

PlayerInstanceMock.__index = PlayerInstanceMock
return PlayerInstanceMock