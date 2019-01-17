local Roact = require(game.ReplicatedStorage.lib.Roact)

function CaughtFish(props)
    return Roact.createElement("Frame", {
        BackgroundTransparency = 1
    }, {
        LabelsFrame = Roact.createElement("Frame", {
            Name = "LabelsFrame",
            Size = UDim2.new(1, -12, 1, -12),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(170, 0, 255),
            BackgroundTransparency = 1
        }, {
            IconLabel = Roact.createElement("ImageLabel", {
                Name = "IconLabel",
                Size = UDim2.new(1, -10, 1, -10),
                Image = "rbxassetid://" .. props.ID,
                Position = UDim2.new(0, 5, 0, 5),
                BackgroundTransparency = 1,
                ScaleType = Enum.ScaleType.Fit
            }),
            Badge = Roact.createElement("ImageLabel", {
                Name = "BadgeBackground",
                Size = UDim2.new(0, 30, 0, 30),
                Position = UDim2.new(0, 0, 1, -30),
                Image = "rbxassetid://2770094188",
                BackgroundTransparency = 1
            }, {
                CountLabel = Roact.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    Font = Enum.Font.Legacy,
                    TextSize = 10,
                    TextColor3 = Color3.fromRGB(255, 0, 128),
                    Text = props.Count
                })
            })
        })
    })
end

return CaughtFish