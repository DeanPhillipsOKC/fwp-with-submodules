local FishingPoleController = {}

local dependencies = require(script.Dependencies).Get()

function FishingPoleController.new(fpc)
	assert(fpc ~= nil, "Cannot create a fishing pole without a template.")
	assert(fpc.Pole ~= nil, "Cannot create a fishing pole controller without passing a pole to the constructor.")

	setmetatable(fpc, FishingPoleController)

	fpc.inputBeganConnection = nil
	fpc.inputEndedConnection = nil

	fpc.Pole.Equipped:Connect(function()
		fpc.inputBeganConnection = dependencies.UserInputService.InputBegan:Connect(function (input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dependencies.StartFishingRE:FireServer()
			end
		end)
		
		fpc.inputEndedConnection = dependencies.UserInputService.InputEnded:Connect(function (input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dependencies.StopFishingRE:FireServer()
			end
		end)
	end)

	fpc.Pole.Unequipped:Connect(function()
		assert(fpc.inputBeganConnection ~= nil, "Invalid State Detected:  Recieved an unequipped event, and tried to disconnect the input began connection, but could not find one.  Something's wrong")
		fpc.inputBeganConnection:Disconnect()
		assert(fpc.inputEndedConnection ~= nil, "Invalid State Detected:  Recieved an unequipped event, and tried to disconnect the input ended connection, but could not find one.  Something's wrong")
		fpc.inputEndedConnection:Disconnect()
	end)

	return fpc
end

FishingPoleController.__index = FishingPoleController
return FishingPoleController