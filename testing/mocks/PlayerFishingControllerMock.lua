local PlayerFishingController = {}

function PlayerFishingController.new(player, playerEntity)
    pfc = {
        Player = player,
        PlayerEntity = playerEntity
    }
    pfc.StartFishingFishingLocationParameterCapture = nil
    pfc.StartFishingCalled = false
    pfc.StopFishingCalled = false

    setmetatable(pfc, PlayerFishingController)
    return pfc
end

function PlayerFishingController:StartFishing(fishingLocation)
    self.StartFishingFishingLocationParameterCapture = fishingLocation
    self.StartFishingCalled = true
end

function PlayerFishingController:StopFishing()
    self.StopFishingCalled = true
end

PlayerFishingController.__index = PlayerFishingController
return PlayerFishingController