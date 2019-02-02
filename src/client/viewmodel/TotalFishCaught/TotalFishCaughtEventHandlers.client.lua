local GetTotalFishCaughtRF = game.ReplicatedStorage.src.Player.Stats.GetTotalFishCaughtRF
local PlayerInstantiatedRE = game.ReplicatedStorage.src.Player.PlayerInstantiatedRE
local VM = require(Game:GetService("Players").LocalPlayer.PlayerScripts.src.viewmodel)

PlayerInstantiatedRE.OnClientEvent:Connect(function()
    local totalFishCaught = GetTotalFishCaughtRF:InvokeServer()
    VM:dispatch({
        type = "totalfishcaughtchanged",
        newTotalFishCaught = totalFishCaught
    })
end)

--TotalFishCaughtChanged.OnClientEvent:Connect(function(newTotal)
--    VM:dispatch({
--        type = "totalfishcaughtchanged",
--        newTotalFishCaught = newTotal
--    })
--end)

local totalFishCaught = GetTotalFishCaughtRF:InvokeServer()
VM:dispatch({
    type = "totalfishcaughtchanged",
    newTotalCoins = totalFishCaught
})