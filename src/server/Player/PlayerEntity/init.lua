local PlayerEntity = {}

local datastore = require(script.Dependencies).Get().DataStore

-- Constructor
function PlayerEntity.new(player)
	local p = { 
		Player = player,
	}
	setmetatable(p, PlayerEntity)
	p.coinStore = datastore("coins", player)
	return p
end

function PlayerEntity:GetTotalCoins()
	return self.coinStore:Get(0)
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

PlayerEntity.__index = PlayerEntity
return PlayerEntity