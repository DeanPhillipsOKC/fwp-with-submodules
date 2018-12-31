local Roact = require(game.ReplicatedStorage.lib.Roact)

--  Props
--      FrameName: The name of the left HUD stat container that will display in Roblox Studio
--      IconText: The text display to the left of the amount.  This is usually an emoji (e.g., coin bag)
--      AmountText: The amount to display (e.g., total coins) when the component is first rendered.

function LeftHudStat(props)
    return Roact.createElement("Frame", {
        Name = props.FrameName,
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
                Text = props.IconText,
                Font = Enum.Font.Legacy,
                TextSize = 42,
                BackgroundTransparency = 1
            }),
            AmountLabel = Roact.createElement("TextLabel", {
                Name = "AmountLabel",
                Size = UDim2.new(0, 200, 1, 0),
                Position = UDim2.new(0, 90, 0, 0),
                Text = props.AmountText,
                Font = Enum.Font.GothamBlack,
                TextSize = 38,
                BackgroundTransparency = 1,
                TextColor3 = Color3.fromRGB(0, 255, 0)
            })
        })
    })
end

return LeftHudStat