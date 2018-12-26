local PlayerRepository = {}

local players = {}

local playersService = require(script.Dependencies).Get().PlayersService
local playerFactory = require(script.Dependencies).Get().PlayerFactory
local playerInstantiatedEvent = require(script.Dependencies).Get().PlayerInstantiatedEvent

function PlayerRepository.StartListeners()
	playersService.PlayerAdded:Connect(function (player)
		players[player.UserId] = playerFactory.new(player)
		if not pcall(function()
			playerInstantiatedEvent:FireClient(player)
		end) then
			print("Error while firing PlayerInstantiatedEvent to ", player.UserId, ".  Maybe they disconnected?") 
		end
	end)

	playersService.PlayerRemoving:Connect(function (player)
		players[player.UserId] = nil
	end)
end

function PlayerRepository.GetPlayer(player)
	return players[player.UserId]
end

return PlayerRepository
