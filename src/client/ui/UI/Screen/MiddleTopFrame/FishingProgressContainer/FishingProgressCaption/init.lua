local Roact = require(game.ReplicatedStorage.lib.Roact)
local RoactRodux = require(game.ReplicatedStorage.lib.RoactRodux)

function FishingProgressCaption(props)
    props = props or {
        PlayerIsFishing = false
    }

    return Roact.createElement("TextLabel", {
        Name = script.Name,
        Text = "Fishing...",
        Font = Enum.Font.Legacy,
        Position = UDim2.new(0, 10, 0, 0),
        TextSize = 16,
        BackgroundTransparency = props.PlayerIsFishing and 0 or 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextColor3 = Color3.fromRGB(255, 220, 255),
        Visible = props.PlayerIsFishing and true or false
    }, {
    })
end

FishingProgressCaption = RoactRodux.connect(
    function(state, props)
        return {
            PlayerIsFishing = state.PlayerIsFishing
        }
    end
)(FishingProgressCaption)

return FishingProgressCaption