local playerBackpack = game.Players.LocalPlayer:WaitForChild("Backpack")
local getEquippedPoleRF = game.ReplicatedStorage.src.Player.Equipment.GetEquippedPoleRF
local poleToolFolder = game.ReplicatedStorage.Poles

local equippedPoleName = getEquippedPoleRF:InvokeServer()
assert(equippedPoleName ~= nil, "Server should never return nil as the currently equipped pole")
assert(poleToolFolder[equippedPoleName] ~= nil, "Server said currently equipped pole is " .. equippedPoleName .. ", but no such pole exists in game.ReplicatedStorage.Poles")

poleToolFolder[equippedPoleName]:Clone().Parent = playerBackpack