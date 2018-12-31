local GetTotalCoinsRF = game.ReplicatedStorage.src.Player.Stats.GetTotalCoinsRF
local PlayerInstantiatedRE = game.ReplicatedStorage.src.Player.PlayerInstantiatedRE
local VM = require(Game:GetService("Players").LocalPlayer.PlayerScripts.src.viewmodel)

PlayerInstantiatedRE.OnClientEvent:Connect(function()
    local totalCoins = GetTotalCoinsRF:InvokeServer()
    VM:dispatch({
        type = "totalCoinsChanged",
        newTotalCoins = totalCoins
    })
end)

local totalCoins = GetTotalCoinsRF:InvokeServer()
VM:dispatch({
    type = "totalCoinsChanged",
    newTotalCoins = totalCoins
})