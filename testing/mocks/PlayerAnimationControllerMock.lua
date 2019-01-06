local PlayerAnimationControllerMock = {}

function PlayerAnimationControllerMock.new(player)
    local pacm = {
        PlayerName = player.Name
    }
    setmetatable(pacm, PlayerAnimationControllerMock)
    return pacm
end

PlayerAnimationControllerMock.__index = PlayerAnimationControllerMock
return PlayerAnimationControllerMock