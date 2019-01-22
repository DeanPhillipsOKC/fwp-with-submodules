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

function PlayerFishingController:StartFishing(fishingLocation)
	if self.Player:DistanceFromCharacter(fishingLocation) < 20 then
		self.PlayerEntity:PlayAnimation("CastPole").KeyframeReached:Connect(function(keyframeName)
			if keyframeName == "Casted" then
				self.PlayerEntity:DeployBobber(fishingLocation)
				dependencies.StartFishingRE:FireClient(self.Player)
				waitForFish(self.Player)
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

	return fishTable[math.random(1, #fishTable)]
end

function waitForFish(player)
	spawn(function() 
		local interrupted = false
		local timeRemaining = 0
		local ttw = 5

		dependencies.StopFishingRE.OnServerEvent:Connect(function(player)
			interrupted = true
		end)
		
		local elapsedTime = 0
		while elapsedTime < ttw and not interrupted do
			local timeRemaining = ttw - elapsedTime
			elapsedTime = elapsedTime + wait(timeRemaining < 0.1 and timeRemaining or 0.1)
		end

		if not interrupted then
			dependencies.CaughtFishRE:FireClient(player, getFish())
			waitForFish(player)
		end
	end)
	dependencies.WaitForFishRE:FireClient(player, 5)
end

PlayerFishingController.__index = PlayerFishingController
return PlayerFishingController