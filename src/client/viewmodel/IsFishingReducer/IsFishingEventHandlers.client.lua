local StartFishingRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StartFishingRE
local StopFishingRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StopFishingRE

local VM = require(Game:GetService("Players").LocalPlayer.PlayerScripts.src.viewmodel)

StartFishingRE.OnClientEvent:Connect(function()
    VM:dispatch({
        type = "playerisfishing"
    })
end)

StopFishingRE.OnClientEvent:Connect(function()
    VM:dispatch({
        type = "playerstoppedfishing"
    })
end)