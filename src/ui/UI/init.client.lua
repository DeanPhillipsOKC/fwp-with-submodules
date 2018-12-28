local Roact = require(script.Dependencies).Get().Roact
local Players = require(script.Dependencies).Get().PlayersService
local LeftHudStats = require(script.Dependencies).Get().LeftHudStats.Get()

local function HUD()
    return Roact.createElement("ScreenGui", {
        Name = "MainGui"
    }, {
        LeftHudStats = LeftHudStats
    })
end

Roact.mount(HUD(), Players.LocalPlayer:WaitForChild("PlayerGui"))