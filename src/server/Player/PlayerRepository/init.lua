local PlayerRepository = {}

local players = {}

local playersService = require(script.Dependencies).Get().PlayersService
local playerFactory = require(script.Dependencies).Get().PlayerFactory
local playerInstantiatedEvent = require(script.Dependencies).Get().PlayerInstantiatedEvent
local getTotalCoinsRF = require(script.Dependencies).Get().GetTotalCoinsRF
local getEquippedPoleRF = require(script.Dependencies).Get().GetEquippedPoleRF
local startFishingRE = require(script.Dependencies).Get().StartFishingRE
local stopFishingRE = require(script.Dependencies).Get().StopFishingRE
local waitForFishRE = require(script.Dependencies).Get().WaitForFishRE
local caughtFishRE = require(script.Dependencies).Get().CaughtFishRE

playersService.PlayerAdded:Connect(function (player)
	newPlayerEntity = playerFactory.new(player)
	players[player.UserId] = newPlayerEntity

	newPlayerEntity:AddPoleToPack({
		Name = newPlayerEntity:GetCurrentPole(),
		Category = "Poles"
	})
	
	if not pcall(function()
		playerInstantiatedEvent:FireClient(player)
	end) then
		print("Error while firing PlayerInstantiatedEvent to ", player.UserId, ".  Maybe they disconnected?") 
	end
end)

playersService.PlayerRemoving:Connect(function (player)
	players[player.UserId] = nil
end)

function PlayerRepository.GetPlayer(player)
	return players[player.UserId]
end

function getTotalCoinsRF.OnServerInvoke(player)
	local playerEntity = PlayerRepository.GetPlayer(player)
	return playerEntity:GetTotalCoins()
end

startFishingRE.OnServerEvent:Connect(function(player, fishingLocation)
	local playerEntity = PlayerRepository.GetPlayer(player)
	playerEntity:StartFishing(fishingLocation)
end)

stopFishingRE.OnServerEvent:Connect(function(player)
	local playerEntity = PlayerRepository.GetPlayer(player)
	playerEntity:StopFishing()
end)

return PlayerRepository
