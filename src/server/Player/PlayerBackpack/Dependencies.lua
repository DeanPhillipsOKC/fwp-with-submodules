local PlayerBackpackDependencies = {}

local injected = nil

function PlayerBackpackDependencies.Inject(newDependencies)
    injected = newDependencies
end

function PlayerBackpackDependencies.Get()
    return injected or {
        PlayersInGame = game.Players,
        EquipmentModelLocation = game.ReplicatedStorage.Equipment,
        HasItemInBackpackRF = game.ReplicatedStorage.src.Player.Equipment.HasItemInBackpackRF
    }
end

return PlayerBackpackDependencies