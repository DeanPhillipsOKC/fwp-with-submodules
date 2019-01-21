local Roact = require(game.ReplicatedStorage.lib.Roact)
local LeftMiddleFrame = require(script.LeftMiddleFrame)
local MiddleTopFrame = require(script.MiddleTopFrame)
local RightMiddleFrame = require(script.RightMiddleFrame)

local function ScreenUI()
    return Roact.createElement("ScreenGui", {
        Name = "ScreenUI"
    }, {
        LeftMiddleFrame = Roact.createElement(LeftMiddleFrame),
        MiddleTopFrame = Roact.createElement(MiddleTopFrame),
        RightMiddleFrame = Roact.createElement(RightMiddleFrame)
    })
end

return ScreenUI