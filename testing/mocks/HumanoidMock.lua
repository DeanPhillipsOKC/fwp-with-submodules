local HumanoidMock = {}
local AnimationTrackMock = require(".AnimationTrackMock")

function HumanoidMock.new()
    local h = { }
    setmetatable(h, HumanoidMock)
    return h
end

function HumanoidMock:LoadAnimation(animationName)
    return AnimationTrackMock.new(animationName)
end

HumanoidMock.__index = HumanoidMock
return HumanoidMock