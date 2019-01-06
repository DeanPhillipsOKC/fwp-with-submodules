local PlayerAnimationController = {}

local dependencies = require(script.Dependencies).Get()

function PlayerAnimationController.new(player)
    assert(player ~= nil, "A non-nil player object must be provided to the PlayerAnimationController constructor")
    assert(player.Name ~= nil, "Cannot construct an animation controller for a player object that does not have a name.")
    local pac = {
        PlayerName = player.Name,
        AnimationTracks = {}
    }
    setmetatable(pac, PlayerAnimationController)
    return pac
end

function PlayerAnimationController:Play(animationName)
    assert(dependencies.ReplicatedStorage.Animations ~= nil, "Will not be able to play any player animations because the Animations folder in replicated storage is missing.")
    assert(animationName ~= nil, "Cannot play a player animation with a nil name.")
    assert(animationName ~= "", "Cannot play a player animation with no name.")
    assert(dependencies.ReplicatedStorage.Animations[animationName] ~= nil, "Request to player animation " .. animationName .. ", that does not exist in the ReplicatedStorage.Animations folder")
    assert(dependencies.PlayersService[self.PlayerName] ~= nil, "Request to play an animation for character " .. self.PlayerName .. ", that does not appear to be in the game anymore.")

    local animation = dependencies.ReplicatedStorage.Animations[animationName]
    self.AnimationTracks[animationName] = dependencies.PlayersService[self.PlayerName].Character.Humanoid:LoadAnimation(animation)
    self.AnimationTracks[animationName]:Play()
end

function PlayerAnimationController:Stop(animationName, fadeTime)
    if self.AnimationTracks[animationName] ~= nil and self.AnimationTracks[animationName].IsPlaying then
        self.AnimationTracks[animationName]:Stop(fadeTime)
    end
end

PlayerAnimationController.__index = PlayerAnimationController
return PlayerAnimationController
