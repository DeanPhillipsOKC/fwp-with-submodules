local Roact = require(game.ReplicatedStorage.lib.Roact)
local LeftMiddleFrame = require(script.LeftMiddleFrame)

local function ScreenUI()
    return Roact.createElement("ScreenGui", {
        Name = "ScreenUI"
    }, {
        LeftMiddleFrame = Roact.createElement(LeftMiddleFrame)
    })
end

return ScreenUI