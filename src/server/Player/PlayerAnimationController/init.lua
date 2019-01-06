local PlayerAnimationController = {}

local dependencies = require(script.Dependencies).Get()

function PlayerAnimationController.new(player)
    local pac = {
        PlayerName = player.Name,
        AnimationTracks = {}
    }
    setmetatable(pac, PlayerAnimationController)
    return pac
end

function PlayerAnimationController:Play(animationName)
    local animation = dependencies.ReplicatedStorage.Animations[animationName]
    self.AnimationTracks[animationName] = dependencies.PlayersService[self.PlayerName].Character.Humanoid:LoadAnimation(animation)
    self.AnimationTracks[animationName]:Play()
end

function PlayerAnimationController:Stop(animationName, fadeTime)
    if self.AnimationTracks[animationName] ~= nil and self.AnimationTracks[animationName].IsPlaying then
        self.AnimationTracks[animationName]:Stop(fadeTime)
    end
end

--function PlayerAnimationController:GetTrack(animationName)
--    return self.AnimationTracks[animationName]
--end

PlayerAnimationController.__index = PlayerAnimationController
return PlayerAnimationController
