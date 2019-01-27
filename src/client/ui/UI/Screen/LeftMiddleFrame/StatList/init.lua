local Roact = require(game.ReplicatedStorage.lib.Roact)

local TotalCoinsStat = require(script.TotalCoinsStat)
local TotalFishStat = require(script.TotalFishStat)

function StatList()
    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }, {
        Layout = Roact.createElement("UIGridLayout", {
            Name = "Layout"
        }),
        TotalCoinsStat = Roact.createElement(TotalCoinsStat),
        TotalFishStat = Roact.createElement(TotalFishStat)
    })
end

return StatList