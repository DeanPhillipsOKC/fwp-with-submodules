local Roact = require(script.Dependencies).Get().Roact
local Players = require(script.Dependencies).Get().PlayersService
local LeftHudStats = require(script.Dependencies).Get().LeftHudStats.Get()
local VM = require(script.Dependencies).Get().VM
local RoactRodux = require(script.Dependencies).Get().RoactRodux

local function HUD()
    return Roact.createElement(RoactRodux.StoreProvider, {
        store = VM
    }, {
        LeftHudStats = Roact.createElement("ScreenGui", {
            Name = "MainGui"
        }, {
            LeftHudStats = LeftHudStats
        })
    })
end
print("Mounting")
Roact.mount(HUD(), Players.LocalPlayer:WaitForChild("PlayerGui"))
