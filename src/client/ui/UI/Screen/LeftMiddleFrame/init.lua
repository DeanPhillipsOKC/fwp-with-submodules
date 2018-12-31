local Roact = require(game.ReplicatedStorage.lib.Roact)
local StatList = require(script.StatList)

function LeftMiddleFrame()
    return Roact.createElement("Frame", {
        Name = script.Name,
        BackgroundColor3 = Color3.fromRGB(255, 110, 137),
        BackgroundTransparency = 0,
        Position = UDim2.new(0, 10, 0.5, -150),
        Size = UDim2.new(0, 100, 0, 300),
        SizeConstraint = Enum.SizeConstraint.RelativeXY
    }, {
        StatList = Roact.createElement(StatList)
    })
end

return LeftMiddleFrame