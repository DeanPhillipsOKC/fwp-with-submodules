local caughtFishRE = game.ReplicatedStorage.src.Player.Actions.Fishing.CaughtFishRE

local VM = require(Game:GetService("Players").LocalPlayer.PlayerScripts.src.viewmodel)

caughtFishRE.OnClientEvent:Connect(function(fishInfo)
    VM:dispatch({
        type = "caughtfish",
        fishName = fishInfo.Name,
        fishImageId = fishInfo.ImageAssetId,
        timeLastFishWasCaught = tick()
    })
end)