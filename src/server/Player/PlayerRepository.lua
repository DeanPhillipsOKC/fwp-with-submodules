local PlayerRepository = {
	Dependencies = {
		PlayersService = game:GetService("Players"),
		PlayerFactory = require(game.ServerScriptService.Player.PlayerEntity),
		PlayerInstantiatedEvent = game.ReplicatedStorage.Player.PlayerInstantiated,
		GetCoinsRemoteFunction = game.ReplicatedStorage.Player.GetCoins
	},
	StartListeners = nil,
	GetPlayer = nil
}

local players = {}

function PlayerRepository.StartListeners()
	PlayerRepository.Dependencies.PlayersService.PlayerAdded:Connect(function (player)
		players[player.UserId] = PlayerRepository.Dependencies.PlayerFactory.new(player)
		if not pcall(function()
			PlayerRepository.Dependencies.PlayerInstantiatedEvent:FireClient(player)
		end) then
			print("Error while firing PlayerInstantiatedEvent to ", player.UserId, ".  Maybe they disconnected?") 
		end
	end)

	PlayerRepository.Dependencies.PlayersService.PlayerRemoving:Connect(function (player)
		players[player.UserId] = nil
	end)
end

function PlayerRepository.GetPlayer(player)
	return players[player.UserId]
end

function PlayerRepository.Dependencies.GetCoinsRemoteFunction.OnServerInvoke(player)
	if players[player.UserId] ~= nil then
		return players[player.UserId]:GetCoins()
	else
		return nil
	end
end

return PlayerRepository
