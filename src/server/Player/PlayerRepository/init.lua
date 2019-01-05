local PlayerRepository = {}

local players = {}

local playersService = require(script.Dependencies).Get().PlayersService
local playerFactory = require(script.Dependencies).Get().PlayerFactory
local playerInstantiatedEvent = require(script.Dependencies).Get().PlayerInstantiatedEvent
local getTotalCoinsRF = require(script.Dependencies).Get().GetTotalCoinsRF
local getEquippedPoleRF = require(script.Dependencies).Get().GetEquippedPoleRF

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

return PlayerRepository
