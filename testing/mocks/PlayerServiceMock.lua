local PlayersServiceMock = {}

local playerInstances = {}

PlayersServiceMock.PlayerAdded = require(".EventMock").new()
PlayersServiceMock.PlayerRemoving = require(".EventMock").new()

-- Not methods on the real Players Service
function PlayersServiceMock.AddPlayerToGame(player)
    playerInstances[player.Name] = requireFsModule("PlayerInstanceMock").new()
end

return PlayersServiceMock