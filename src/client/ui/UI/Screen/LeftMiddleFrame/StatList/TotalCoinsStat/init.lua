local Roact = require(game.ReplicatedStorage.lib.Roact)
local LeftHudStat = require(script.Parent.LeftHudStat)

function TotalCoinsStat()
    return Roact.createElement(LeftHudStat, {
        FrameName = "TotalCoinsStatComponent",
        IconText = "💰",
        AmountText = "Loading..."
    })
end

return TotalCoinsStat