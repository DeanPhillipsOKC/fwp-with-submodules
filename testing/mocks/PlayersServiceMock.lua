local PlayersServiceMock = {}

local PlayerInstanceMock = require(game.Mocks.PlayerInstanceMock)

PlayersServiceMock.PlayerAdded = require(game.Mocks.EventMock).new()
PlayersServiceMock.PlayerRemoving = require(game.Mocks.EventMock).new()

-- Not methods on the real Players Service
function PlayersServiceMock.AddPlayerToGame(player)
    PlayersServiceMock[player.Name] = PlayerInstanceMock.new()
end

return PlayersServiceMock