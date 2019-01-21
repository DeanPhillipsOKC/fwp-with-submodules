local WaitForFishRE = game.ReplicatedStorage.src.Player.Actions.Fishing.WaitForFishRE
local StopWaitingForFishRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StopWaitingForFishRE
local StopFishingRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StopFishingRE

local VM = require(Game:GetService("Players").LocalPlayer.PlayerScripts.src.viewmodel)

WaitForFishRE.OnClientEvent:Connect(function(timeToWait)
    VM:dispatch({
        type = "waitingforfish",
        timeToWait = timeToWait
    })
end)

StopFishingRE.OnClientEvent:Connect(function()
    VM:dispatch({
        type = "stoppedwaitingforfish"
    })
end)