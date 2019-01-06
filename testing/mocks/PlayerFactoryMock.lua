local PlayerFactoryMock = {}

function PlayerFactoryMock.new(pf)
    pf = pf or { }
    pf.AnimationsPlayed = {}
    pf.AnimationsStopped = {}
    setmetatable(pf, PlayerFactoryMock)
    return pf
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
end

function PlayerFactoryMock:StopAnimation(animationName)
    self.AnimationsStopped[animationName] = true
end

PlayerFactoryMock.__index = PlayerFactoryMock
return PlayerFactoryMock