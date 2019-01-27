local FishingValidationService = {}

function FishingValidationService.new(settings)
    assert(settings ~= nil, "Cannot instantiate the FishingValidationService without providing a settings object.")
    assert(settings.Player ~= nil, "Cannot instantiate the FishingValidationService without providing a player instance.")

    setmetatable(settings, FishingValidationService)
    return FishingValidationService
end

function FishingValidationService:CanFishHere()
    local part, coords = dependencies.Input2dToWorld3dService.Convert(xCoordinate, yCoordinate)
                
    if part ~= nil and part.Name == "WaterFilter" and dependencies.Player:DistanceFromCharacter(coords) < 20 then
        return true
    end

    return false
end

function FishingValidationService:PlayerInValidFishingState()
    
end

FishingValidationService.__index= FishingValidationService
return FishingValidationService