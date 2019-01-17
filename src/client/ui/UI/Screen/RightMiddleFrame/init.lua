local Roact = require(game.ReplicatedStorage.lib.Roact)
local FishInBagList = require(script.FishInBagList)

function RightMiddleFrame()
    return Roact.createElement("Frame", {
        Name = script.Name,
        BackgroundColor3 = Color3.fromRGB(98, 56, 170),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -110, 0.5, -150),
        Size = UDim2.new(0, 100, 0, 300),
        SizeConstraint = Enum.SizeConstraint.RelativeXY
    }, {
       FishInBagList = Roact.createElement(FishInBagList)
    })
end

return RightMiddleFrame