local PlayerEntity = {}

local datastore = require(script.Dependencies).Get().DataStore
local playerBackpack = require(script.Dependencies).Get().PlayerBackpack
local PlayerAnimationController = require(script.Dependencies).Get().PlayerAnimationController

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
	self.animationController:Play(animationName)
end

PlayerEntity.__index = PlayerEntity
return PlayerEntity