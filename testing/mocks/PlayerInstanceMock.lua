local PlayerInstanceMock = {}

--dependencies.PlayersService[self.PlayerName].Character.Humanoid:LoadAnimation(animation)
function PlayerInstanceMock.new()
    local pi = {
        Character = {
            Humanoid = requireFsModule("HumanoidMock").new()
        }
    }
    setmetatable(pi, PlayerInstanceMock)
    return pi
end

PlayerInstanceMock.__index = PlayerInstanceMock
return PlayerInstanceMock