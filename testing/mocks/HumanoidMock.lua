local HumanoidMock = {}

function HumanoidMock.new()
    local h = {
        AnimationTrackToReturn = nil
    }
    setmetatable(h, HumanoidMock)
    return h
end

function HumanoidMock:LoadAnimation(animationName)
    return self.AnimationTrackToReturn
end

HumanoidMock.__index = HumanoidMock
return HumanoidMock