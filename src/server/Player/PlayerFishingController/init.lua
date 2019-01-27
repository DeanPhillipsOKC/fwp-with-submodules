local PlayerFishingController = {}

local dependencies = require(script.Dependencies).Get()

function PlayerFishingController.new(player, playerEntity)
    pfc = {
        Player = player,
        PlayerEntity = playerEntity
    }
    setmetatable(pfc, PlayerFishingController)
    return pfc
end

function PlayerFishingController:playerInValidFishingState()
	local humanoid = self.PlayerEntity:GetHumanoid()
	assert(humanoid ~= nil, "Could not check to see if " .. self.Player.Name .. " is in a valid fishing state, because we could not find their humanoid instance.")

	return  humanoid:GetState() ~= Enum.HumanoidStateType.Running and
			humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and
			humanoid:GetState() ~= Enum.HumanoidStateType.Swimming and
			humanoid:GetState() ~= Enum.HumanoidStateType.Climbing and
			humanoid:GetState() ~= Enum.HumanoidStateType.Dead
end

function PlayerFishingController:StartFishing(fishingLocation)
	if self.Player:DistanceFromCharacter(fishingLocation) < 20 and self.PlayerEntity:GetEquippedPole() ~= nil then
		self.PlayerEntity:PlayAnimation("CastPole").KeyframeReached:Connect(function(keyframeName)
			if keyframeName == "Casted" then
				self.PlayerEntity:DeployBobber(fishingLocation)
				dependencies.StartFishingRE:FireClient(self.Player)
				self:waitForFish(self.PlayerEntity:GetCurrentPole().CatchDelay)
			end 
		end)
		self.PlayerEntity:PlayAnimation("PoleIdle")
	end
end

function PlayerFishingController:StopFishing()
	self.PlayerEntity:StopAnimation("CastPole")
	self.PlayerEntity:StopAnimation("PoleIdle")
	self.PlayerEntity:UndeployBobber()
	dependencies.StopFishingRE:FireClient(self.Player)
end

function getFish()
	fishTable = {}
	fishTable[1] = {
		ImageAssetId = "2771043601",
		Name = "Green Banded Lilac Wretzel"
	}
	fishTable[2] = {
		Name = "Brown Spotted Sturdy Erv",
		ImageAssetId = "2754714344"
	}
	fishTable[3] = {
		Name = "Sweetwater Melon Cote",
		ImageAssetId = "2773360527"
	}
	fishTable[4] = {
		Name = "Silver Dollar Sand Skipper",
		ImageAssetId = "2778875718"
	}

	return fishTable[math.random(1, #fishTable)]
end

function PlayerFishingController:waitForFish(timeToWait)
	spawn(function() 
		local interrupted = false
		local timeRemaining = 0
		local playerInInvalidState = false

		dependencies.StopFishingRE.OnServerEvent:Connect(function(player)
			interrupted = true
		end)
		
		local stateChangedConnection = self.PlayerEntity:GetHumanoid().StateChanged:Connect(function(old, new)
			if not self:playerInValidFishingState() then
				interrupted = true
				playerInInvalidState = true
			end
		end)

		local elapsedTime = 0
		while elapsedTime < timeToWait and not interrupted do
			local timeRemaining = timeToWait - elapsedTime
			elapsedTime = elapsedTime + wait(timeRemaining < 0.1 and timeRemaining or 0.1)

			self:playerInValidFishingState()
		end

		stateChangedConnection = nil

		if not interrupted then
			dependencies.CaughtFishRE:FireClient(self.Player, getFish())
			self.PlayerEntity:IncrementTotalFishCaught()
			self:waitForFish(timeToWait)
		elseif playerInInvalidState then
			self:StopFishing()
		end
	end)
	dependencies.WaitForFishRE:FireClient(self.Player, timeToWait)
end

PlayerFishingController.__index = PlayerFishingController
return PlayerFishingController