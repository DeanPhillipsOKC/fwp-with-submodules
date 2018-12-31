local PlayerFactoryMock = {}

function PlayerFactoryMock.new(pf)
    pf = pf or { }
    setmetatable(pf, PlayerFactoryMock)
    return pf
end

function PlayerFactoryMock:GetTotalCoins()
    return self.TotalCoins
end

function PlayerFactoryMock:GetUserId()
	return self.UserId
end

PlayerFactoryMock.__index = PlayerFactoryMock
return PlayerFactoryMock