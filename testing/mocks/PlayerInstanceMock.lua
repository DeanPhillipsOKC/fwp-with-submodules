local PlayerInstanceMock = {}

local humanoidMock = require(".HumanoidMock")

--dependencies.PlayersService[self.PlayerName].Character.Humanoid:LoadAnimation(animation)
function PlayerInstanceMock.new()
    local pi = {
        Character = {
            Humanoid = humanoidMock.new()
        }
    }
    setmetatable(pi, PlayerInstanceMock)
    return pi
end

PlayerInstanceMock.__index = PlayerInstanceMock
return PlayerInstanceMock