local player = game.Players.LocalPlayer
local pole = script.Parent
local startFishingRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StartFishingRE
local stopfishingRE = game.ReplicatedStorage.src.Player.Actions.Fishing.StopFishingRE
local UserInputService = game:GetService("UserInputService")

local inputBeganConnection = nil
local inputEndedConnection = nil

pole.Equipped:Connect(function()
	inputBeganConnection = UserInputService.InputBegan:connect(function (input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			startFishingRE:FireServer()
		end
	end)
	
	inputEndedConnection = UserInputService.InputEnded:connect(function (input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			stopfishingRE:FireServer()
		end
	end)
end)

pole.Unequipped:Connect(function()
	assert(inputBeganConnection ~= nil, "Invalid State Detected:  Recieved an unequipped event, and tried to disconnect the input began connection, but could not find one.  Something's wrong")
	inputBeganConnection:Disconnect()
	assert(inputEndedConnection ~= nil, "Invalid State Detected:  Recieved an unequipped event, and tried to disconnect the input ended connection, but could not find one.  Something's wrong")
	inputEndedConnection:Disconnect()
end)