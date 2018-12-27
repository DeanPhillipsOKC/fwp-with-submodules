local PlayerServiceMock = {}

PlayerServiceMock.PlayerAdded = require(".EventMock").new()
PlayerServiceMock.PlayerRemoving = require(".EventMock").new()

return PlayerServiceMock