local PlayerAnimationControllerMock = {}

function PlayerAnimationControllerMock.new(player)
    local pacm = {
        PlayerName = player.Name,
        AnimationsPlayed = {},
        AnimationsStopped = {}
    }
    setmetatable(pacm, PlayerAnimationControllerMock)
    return pacm
end

function PlayerAnimationControllerMock:Play(animationName)
    self.AnimationsPlayed[animationName] = true
end

function PlayerAnimationControllerMock:Stop(animationName)
    self.AnimationsStopped[animationName] = true
end

PlayerAnimationControllerMock.__index = PlayerAnimationControllerMock
return PlayerAnimationControllerMock