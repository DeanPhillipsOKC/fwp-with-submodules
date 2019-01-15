local PlayerFactoryMock = {}

local animationTrackMockFactory = require(game.Mocks.AnimationTrackMock)

function PlayerFactoryMock.new(pf)
    local factory = { 
        Name = pf.Name, 
        UserId = pf.UserId,
        TotalCoins = pf.TotalCoins 
    }
    factory.AnimationsPlayed = {}
    factory.AnimationsStopped = {}
    factory.UndeployedBobber = false
    setmetatable(factory, PlayerFactoryMock)
    return factory
end

local defaultEquippedPoleName = nil

function PlayerFactoryMock.SetDefaultEquippedPole(defaultPoleName)
    defaultEquippedPoleName = defaultPoleName
end

function PlayerFactoryMock:GetTotalCoins()
    return self.TotalCoins
end

function PlayerFactoryMock:GetCurrentPole()
    return self.EquippedPole or defaultEquippedPoleName
end

function PlayerFactoryMock:GetUserId()
	return self.UserId
end

function PlayerFactoryMock:AddPoleToPack(pole)
    self.PoleAddedToPack = pole.Name
end

function PlayerFactoryMock:PlayAnimation(animationName)
    self.AnimationsPlayed[animationName] = true
    return animationTrackMockFactory.new()
end

function PlayerFactoryMock:StopAnimation(animationName)
    self.AnimationsStopped[animationName] = true
end

function PlayerFactoryMock:UndeployBobber()
    self.UndeployedBobber = true
end

PlayerFactoryMock.__index = PlayerFactoryMock
return PlayerFactoryMock