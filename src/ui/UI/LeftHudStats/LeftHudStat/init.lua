local Roact = require(script.Dependencies).Get().Roact

local LeftHudStatComponent = Roact.Component:extend("LeftHudStat")

function LeftHudStatComponent:init(props)
    print("setting state");
    self.state = props
end

LeftHudStatComponent.defaultProps = {
    AmountText = "Loading...",
}

function LeftHudStatComponent:render()
    return Roact.createElement("Frame", {
        Name = self.state.FrameName,
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
                Text = self.state.IconText,
                Font = Enum.Font.Legacy,
                TextSize = 42,
                BackgroundTransparency = 1
            }),
            AmountLabel = Roact.createElement("TextLabel", {
                Name = "AmountLabel",
                Size = UDim2.new(0, 200, 1, 0),
                Position = UDim2.new(0, 90, 0, 0),
                Text = self.state.AmountText,
                Font = Enum.Font.GothamBlack,
                TextSize = 38,
                BackgroundTransparency = 1,
                TextColor3 = Color3.fromRGB(0, 255, 0)
            })
        })
    })
end

return LeftHudStatComponent;