local hasItemInBackpackRF = game.ReplicatedStorage.src.Player.Equipment.HasItemInBackpackRF
local playerName = game.Players.LocalPlayer.Name

hasItemInBackpackRF.OnClientInvoke = function(itemName)
    local backpack = game.Players[playerName]:WaitForChild("Backpack")
    for k,v in pairs(backpack:GetChildren()) do
        if v.Name == itemName then
            return true
        end
    end
    return false
end