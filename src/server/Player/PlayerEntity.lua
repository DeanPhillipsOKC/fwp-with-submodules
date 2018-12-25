local PlayerEntity = {}

PlayerEntity.Dependencies = {
	DataStore = require(game.ServerScriptService.SharedKernel.ThirdParty.DataStore2)
}

-- Constructor
function PlayerEntity.new(player)
	local p = { 
		Player = player,
	}
	setmetatable(p, PlayerEntity)
	p.coinStore = PlayerEntity.Dependencies.DataStore("coins", player)
	return p
end

function PlayerEntity:GetCoins()
	return self.coinStore:Get(0)
end

function PlayerEntity:SetCoins(amount)
	if type(amount) == "number" then
		self.coinStore:Set(amount)
	else
		error("Attempt to set " .. self.Player.UserId .. "'s total coins to a null, or non-numeric value", 2) 
	end
end

PlayerEntity.__index = PlayerEntity
return PlayerEntity