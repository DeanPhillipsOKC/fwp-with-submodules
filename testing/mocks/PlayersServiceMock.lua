local PlayersServiceMock = {}

local PlayerInstanceMock = require(".PlayerInstanceMock")

PlayersServiceMock.PlayerAdded = require(".EventMock").new()
PlayersServiceMock.PlayerRemoving = require(".EventMock").new()

-- Not methods on the real Players Service
function PlayersServiceMock.AddPlayerToGame(player)
    PlayersServiceMock[player.Name] = PlayerInstanceMock.new()
end

return PlayersServiceMock