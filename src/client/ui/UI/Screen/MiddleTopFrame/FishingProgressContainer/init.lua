local Roact = require(game.ReplicatedStorage.lib.Roact)
local RoactRodux = require(game.ReplicatedStorage.lib.RoactRodux)
local FishingProgressCaption = require(script.FishingProgressCaption)
local FishingProgressBar = require(script.FishingProgressBar)

function FishingProgressContainer(props)
    props = props or {
        PlayerIsFishing = false
    }

    return Roact.createElement("Frame", {
        BackgroundTransparency = props.PlayerIsFishing and 0 or 1,
        Name = script.Name,
        Position = UDim2.new(-0.25, 0, 0, 0),
        Size = UDim2.new(1.5, 0, 0.25, 0),
        BackgroundColor3 = Color3.fromRGB(200, 113, 55)
    }, {
        FishingProgressCaption = Roact.createElement(FishingProgressCaption),
        FishingProgressBar = Roact.createElement(FishingProgressBar)
    })
end

FishingProgressContainer = RoactRodux.connect(
    function(state, props)
        return {
            PlayerIsFishing = state.PlayerIsFishing,
        }
    end
)(FishingProgressContainer)

return FishingProgressContainer