local UserInputServiceMock = {}

local eventFactory = require(game.Mocks.EventMock)

UserInputServiceMock.InputBegan = eventFactory.new()
UserInputServiceMock.InputEnded = eventFactory.new()
UserInputServiceMock.InputChanged = eventFactory.new()

return UserInputServiceMock