local PlayerBackpack = {}

local dependencies = require(script.Dependencies).Get()

assert(dependencies.PlayersInGame ~= nil, "Could not find player backpack dependency playersInGame")
assert(dependencies.EquipmentModelLocation ~= nil, "Could not find equipment model location dependency")

function PlayerBackpack.new(player)
    assert(player ~= nil, "Cannot instantiate a player backpack without providing a name.")
    assert(player.Name ~= nil, "Cannot instantiate a player backpack for a user without a UserId.")
    assert(dependencies.PlayersInGame[player.Name] ~= nil, "Cannot instantiate a player backpack for a user that is not in the game.")

    local pb = {
        Player = player
    }
    setmetatable(pb, PlayerBackpack)
    return pb
end

function PlayerBackpack:Add(item)
    assert(item ~= nil, "Cannot add a nil item to player backpack.")
    assert(item.Category ~= nil, "Cannot add an item without a category to player backpack.")
    assert(item.Name ~= nil, "Cannot add an item with a name to player backpack.")
    assert(dependencies.EquipmentModelLocation[item.Category] ~= nil, "Attempting to add an item with unknown category " .. item.Category .. " to player backpack.")
    assert(dependencies.EquipmentModelLocation[item.Category][item.Name] ~= nil, "Attempting to add an item with category " .. item.Category .. ", and unknown name " .. item.Name .. " to player backpack.")
    assert(dependencies.PlayersInGame[self.Player.Name] ~= nil, "Cannot add an item to " .. self.Player.Name .. "'s backpack the player does not appear to be in the game anymore.'")
    assert(dependencies.PlayersInGame[self.Player.Name]:WaitForChild("Backpack") ~= nil, "Cannot add an item to " .. self.Player.Name .. "'s backpack because we could not find their backpack.'")

    while not dependencies.HasItemInBackpackRF:InvokeClient(self.Player, item.Name) do
        local itemClone = dependencies.EquipmentModelLocation[item.Category][item.Name]:Clone()
        itemClone.Parent = dependencies.PlayersInGame[self.Player.Name]:WaitForChild("Backpack")
        wait(0.2)
    end
end

PlayerBackpack.__index = PlayerBackpack

return PlayerBackpack