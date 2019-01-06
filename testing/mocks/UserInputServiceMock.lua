local UserInputServiceMock = {}

local eventFactory = require(".EventMock")

UserInputServiceMock.InputBegan = eventFactory.new()
UserInputServiceMock.InputEnded = eventFactory.new()

return UserInputServiceMock