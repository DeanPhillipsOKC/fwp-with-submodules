local PlayerEntity = {}

local datastore = require(script.Dependencies).Get().DataStore
local playerBackpack = require(script.Dependencies).Get().PlayerBackpack
local PlayerAnimationController = require(script.Dependencies).Get().PlayerAnimationController
local BobberFactory = require(script.Dependencies).Get().Bobber
local PlayerFishingController = require(script.Dependencies).Get().FishingController

-- Constructor
function PlayerEntity.new(player)
	local p = { 
		Player = player,
	}
	setmetatable(p, PlayerEntity)
	p.coinStore = datastore("coins", player)
	p.poleStore = datastore("poles", player)
	p.backpack = playerBackpack.new(player)
	p.animationController = PlayerAnimationController.new(player)
	p.fishingController = PlayerFishingController.new(player, p)
	return p
end

function PlayerEntity:GetUserId()
	return self.Player.UserId
end

function PlayerEntity:GetTotalCoins()
	return self.coinStore:Get(0)
end

function PlayerEntity:GetCurrentPole()
	return self.poleStore:Get("BasicPole")
end

function PlayerEntity:SetTotalCoins(amount)
	if (amount == nil) then
		error("Attempt to set " .. self.Player.UserId .. "'s total coins to nil.'")
	end
	
	if typeof(amount) == "string" then
		amount = tonumber(amount) or nil
	end

	if (typeof(amount) ~= "number") then
		error("Attempt to set " .. self.Player.UserId .. "'s total coins to a non-numberic value.'")
	end

	if (amount ~= math.floor(amount)) then
		error("Attempt to set " .. self.Player.UserId .. "'s total coins to a non-integer value.'")
	end

	self.coinStore:Set(amount)
end

function PlayerEntity:AddPoleToPack(poleName)
	self.backpack:Add(poleName)
end

function PlayerEntity:PlayAnimation(animationName)
	return self.animationController:Play(animationName)
end

function PlayerEntity:StopAnimation(animationName, fadeTime)
	self.animationController:Stop(animationName, fadeTime)
end

function PlayerEntity:DeployBobber(fishingLocation)
	self.Bobber = BobberFactory.new()
	local pole = self:GetPoleFromeWorkspace()
	self.Bobber:Deploy(pole, fishingLocation)
end

function PlayerEntity:UndeployBobber()
	self.Bobber:Destroy()
end

function PlayerEntity:GetPoleFromeWorkspace()
	return game.Workspace[self.Player.Name][self:GetCurrentPole()]
end

function PlayerEntity:StartFishing(fishingLocation)
	self.fishingController:StartFishing(fishingLocation)
end

function PlayerEntity:StopFishing()
	self.fishingController:StopFishing()
end

PlayerEntity.__index = PlayerEntity
return PlayerEntity