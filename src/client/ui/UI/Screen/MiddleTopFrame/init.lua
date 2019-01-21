local Roact = require(game.ReplicatedStorage.lib.Roact)
local FishingProgressContainer = require(script.FishingProgressContainer)

function MiddleTopFrame()
    return Roact.createElement("Frame", {
        Name = script.Name,
        BackgroundColor3 = Color3.fromRGB(59, 255, 38),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, -150, 0, 10),
        Size = UDim2.new(0, 300, 0, 100),
        SizeConstraint = Enum.SizeConstraint.RelativeXY
    }, {
        FishingProgressContainer = Roact.createElement(FishingProgressContainer)
    })
end

return MiddleTopFrame