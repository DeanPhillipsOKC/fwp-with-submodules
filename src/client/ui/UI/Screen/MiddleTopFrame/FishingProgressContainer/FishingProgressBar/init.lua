local Roact = require(game.ReplicatedStorage.lib.Roact)
local RoactRodux = require(game.ReplicatedStorage.lib.RoactRodux)

local progressBarReference = nil

local FishingProgressBar = Roact.Component:extend("FishingProgressBar")

function FishingProgressBar:render()
    local props = self.props or {
        PlayerIsFishing = false,
        WaitingForFish = false,
        TimeToWait = 0
    }
    
    if (props.WaitingForFish) then
        progressBarReference.Size = UDim2.new(0, 0, 1, 0)
        progressBarReference:TweenSize(UDim2.new(1, 0, 1, 0), nil, nil, props.TimeToWaitForFish, true, nil)
    end

    return Roact.createElement("Frame", {
        [Roact.Ref] = self.progressBarRef,
        BackgroundTransparency = props.PlayerIsFishing and 0 or 1,
        Name = script.Name,
        BackgroundColor3 = Color3.fromRGB(150, 90, 40)
    }, {
    })
end

function FishingProgressBar:init()
    self.progressBarRef = Roact.createRef()
end

function FishingProgressBar:didMount()
    progressBarReference = self.progressBarRef.current
    progressBarReference.Size = UDim2.new(0, 0, 1, 0)
end

FishingProgressBar = RoactRodux.connect(
    function(state, props)        
        return {
            PlayerIsFishing = state.PlayerIsFishing,
            WaitingForFish = state.WaitingForFish.Waiting,
            TimeToWaitForFish = state.WaitingForFish.TimeToWait,
            TimeLastFishWasCaught = state.CaughtFish.TimeLastFishWasCaught
        }
    end
)(FishingProgressBar)

return FishingProgressBar