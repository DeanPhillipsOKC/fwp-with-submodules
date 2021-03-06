local PlayerFactoryMock = {}

local animationTrackMockFactory = require(game.Mocks.AnimationTrackMock)

function PlayerFactoryMock.new(pf)
    local factory = { 
        Name = pf.Name, 
        UserId = pf.UserId,
        TotalCoins = pf.TotalCoins,
        FishBagContents = pf.FishBagContents
    }
    factory.AnimationsPlayed = {}
    factory.AnimationsStopped = {}
    factory.UndeployedBobber = nil
    factory.DeployedBobber = nil
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

function PlayerFactoryMock:GetFishBagContents()
    return self.FishBagContents
end

function PlayerFactoryMock:GetCurrentPole()
    return self.EquippedPole or defaultEquippedPoleName or {
        Name = "BasicPole"
    }
end

function PlayerFactoryMock:GetUserId()
	return self.UserId
end

function PlayerFactoryMock:AddPoleToPack(pole)
    self.PoleAddedToPack = pole.Name
end

function PlayerFactoryMock:PlayAnimation(animationName)
    self.AnimationsPlayed[animationName] = animationTrackMockFactory.new()
    return self.AnimationsPlayed[animationName]
end

function PlayerFactoryMock:StopAnimation(animationName)
    self.AnimationsStopped[animationName] = true
end

function PlayerFactoryMock:UndeployBobber()
    self.UndeployedBobber = true
end

function PlayerFactoryMock:DeployBobber()
    self.DeployedBobber = true
end

PlayerFactoryMock.__index = PlayerFactoryMock
return PlayerFactoryMock