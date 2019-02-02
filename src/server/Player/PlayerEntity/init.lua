local PlayerEntity = {}

local datastore = require(script.Dependencies).Get().DataStore
local playerBackpack = require(script.Dependencies).Get().PlayerBackpack
local PlayerAnimationController = require(script.Dependencies).Get().PlayerAnimationController
local BobberFactory = require(script.Dependencies).Get().Bobber
local PlayerFishingController = require(script.Dependencies).Get().FishingController
local FishingPoleRepository = require(script.Dependencies).Get().FishingPoleRepository
local EquippedToolLocation = require(script.Dependencies).Get().EquippedToolLocation
local PlayersService = require(script.Dependencies).Get().PlayersService
local TotalFishCaughtChangedRE = require(script.Dependencies).Get().TotalFishCaughtChangedRE

-- Constructor
function PlayerEntity.new(player)
	local p = { 
		Player = player,
	}
	setmetatable(p, PlayerEntity)
	p.coinStore = datastore("coins", player)
	p.poleStore = datastore("poles", player)
	p.fishBagStore = datastore("fishbag", player)
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

function PlayerEntity:GetFishBagContents()
	local contents = self.fishBagStore:Get({})

	assert(type(contents) == "table", "The datastore returned a non table for the fish bag contents.  This needs to be fixed")

	return contents
end

function PlayerEntity:GetCurrentPole()
	local poleName = self.poleStore:Get("BasicPole")
	return FishingPoleRepository.Get(poleName)
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

function PlayerEntity:IncrementTotalFishCaught()
	local newTotal = self:GetTotalFishCaught() + 1
	TotalFishCaughtChangedRE:FireClient(self.Player, newTotal)
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
	local pole = self:GetEquippedPole()
	self.Bobber:Deploy(pole, fishingLocation)
end

function PlayerEntity:UndeployBobber()
	self.Bobber:Destroy()
end

function PlayerEntity:GetEquippedPole()
	assert(EquippedToolLocation ~= nil, "Cannot get " .. self.Player.Name .. "'s equipped pole because the EquippedToolLocation dependency is not defined.'")
	assert(EquippedToolLocation[self.Player.Name] ~= nil, "Cannot get ".. self.Player.Name .. "'s equipped pole because they do not have an entry in the workspace for some reason.'")
	return EquippedToolLocation[self.Player.Name][self:GetCurrentPole().Name]
end

function PlayerEntity:StartFishing(fishingLocation)
	self.fishingController:StartFishing(fishingLocation)
end

function PlayerEntity:StopFishing()
	self.fishingController:StopFishing()
end

function PlayerEntity:GetCharacter()
	assert(PlayersService ~= nil, "Cannot get player character because there is an issue with the PlayersService")
	assert(self ~= nil, "Cannot get player character because the player entity self referecne was not found.  Did you remember to call GetCharacter with the colon?")
	assert(self.Player ~= nil, "Cannot get player character because the reference to the player instance was nil.")
	assert(self.Player.Name ~= nil, "Cannot get the player character because tbe name on the player instances was nil.")
	assert(PlayersService[self.Player.Name] ~= nil, "Cannot get player character for " .. self.Player.Name .. " because they do not appear to be in the game anymore.")

	local character = PlayersService[self.Player.Name].Character
	
	assert(character ~= nil, "Could not get the character for " .. self.Player.Name .. " because we could not find it.")
	return character
end

function PlayerEntity:GetHumanoid()
	assert(self ~= nil, "Cannot get player humanoid because the player entity self reference was not found.  Did you remember to call GetHumanoid with the colon operator?")

	local character = self:GetCharacter()
	assert(character ~= nil, "Could not get the humanoid for " .. self.Player.Name .. " because his or her character is nil.")

	local humanoid = character.Humanoid
	assert(humanoid ~= nil, "Could not get the humanoid for " .. self.Player.Name .. " because his or her humanoid is nil.")
	
	return humanoid
end

PlayerEntity.__index = PlayerEntity
return PlayerEntity