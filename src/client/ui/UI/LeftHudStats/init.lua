local LeftHudStats = {}

local Roact = require(script.Dependencies).Get().Roact
local LeftHudStatContainer = require(script.Dependencies).Get().LeftHudStatContainer

function LeftHudStats.Get()
    return Roact.createElement("Frame", {
        Name = script.Name,
        BackgroundColor3 = Color3.fromRGB(255, 110, 137),
        BackgroundTransparency = 0,
        Position = UDim2.new(0, 10, 0.5, -150),
        Size = UDim2.new(0, 100, 0, 300),
        SizeConstraint = Enum.SizeConstraint.RelativeXY
    }, {
        Layout = Roact.createElement("UIGridLayout", {
            Name = "Layout"
        }),
        TotalCoinsContainer = Roact.createElement(LeftHudStatContainer, {
            FrameName = "TotalCoins",
            IconText = "💰"
        })
    })
end

return LeftHudStats