local PlayerAnimationController = {}

function PlayerAnimationController.new(player)
    local pac = {
        PlayerName = player.Name,
        AnimationTracks = {}
    }
    setmetatable(pac, PlayerAnimationController)
    return pac
end

function PlayerAnimationController:Play(animationName)
    local animation = game.ReplicatedStorage.Animations[animationName]
    self.AnimationTracks[animationName] = game.Players[self.PlayerName].Character.Humanoid:LoadAnimation(animation)
    self.AnimationTracks[animationName]:Play()
end

function PlayerAnimationController:GetTrack(animationName)
    return self.AnimationTracks[animationName]
end

PlayerAnimationController.__index = PlayerAnimationController
return PlayerAnimationController
