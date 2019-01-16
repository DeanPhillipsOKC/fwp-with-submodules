local AnimationTrackMock = {}

local EventMockFactory = require(game.Mocks.EventMock)

function AnimationTrackMock.new(at)
    at = at or {}
    at.IsPlaying = false
    at.KeyframeReached = EventMockFactory.new()

    setmetatable(at, AnimationTrackMock)
    return at
end

function AnimationTrackMock:Play()
    self.IsPlaying = true
end

function AnimationTrackMock:Stop()
    self.IsPlaying = false
end

AnimationTrackMock.__index = AnimationTrackMock
return AnimationTrackMock