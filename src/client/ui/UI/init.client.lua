local screenGui = require(script.Screen)
local Roact = require(game.ReplicatedStorage.lib.Roact)
local RoactRodux = require(game.ReplicatedStorage.lib.RoactRodux)
local PlayersService = game:GetService("Players")
local VM = require(Game:GetService("Players").LocalPlayer.PlayerScripts.src.viewmodel)

local mainUI = Roact.createElement(RoactRodux.StoreProvider, {
    store = VM
}, {
    Roact.createElement(screenGui)
})

Roact.mount(mainUI, PlayersService.LocalPlayer:WaitForChild("PlayerGui"))