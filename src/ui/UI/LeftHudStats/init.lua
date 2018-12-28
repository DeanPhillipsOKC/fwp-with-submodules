local LeftHudStats = {}

local Roact = require(script.Dependencies).Get().Roact

function LeftHudStats.Get()
    return Roact.createElement("Frame", {
        Name = script.Name,
        BackgroundColor3 = Color3.fromRGB(255, 110, 137),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0.5, -150),
        Size = UDim2.new(0, 100, 0, 300),
        SizeConstraint = Enum.SizeConstraint.RelativeXY
    }, {

        Layout = Roact.createElement("UIGridLayout", {
            Name = "Layout"
        }),
        CoinsFrame = Roact.createElement("Frame", {
            Name = "CoinsFrame",
            BackgroundTransparency = 1
        }, {
            LabelsFrame = Roact.createElement("Frame", {
                Name = "LabelsFrame",
                Size = UDim2.new(3, 0, 0.8, 0),
                Position = UDim2.new(0.1, 0, 0.1, 0),
                BackgroundColor3 = Color3.fromRGB(170, 0, 255)
            }, {
                IconLabel = Roact.createElement("TextLabel", {
                    Name = "IconLabel",
                    Size = UDim2.new(0, 80, 1, 0),
                    Text = "💰",
                    Font = Enum.Font.Legacy,
                    TextSize = 42,
                    BackgroundTransparency = 1
                }),
                AmountLabel = Roact.createElement("TextLabel", {
                    Name = "AmountLabel",
                    Size = UDim2.new(0, 200, 1, 0),
                    Position = UDim2.new(0, 90, 0, 0),
                    Text = "Loading...",
                    Font = Enum.Font.GothamBlack,
                    TextSize = 38,
                    BackgroundTransparency = 1,
                    TextColor3 = Color3.fromRGB(0, 255, 0)
                })
            })
        })
    })
end

return LeftHudStats