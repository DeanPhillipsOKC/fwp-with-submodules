local FishingBobber = {}

function FishingBobber.new()
    local fb = {
        Model = game.ReplicatedStorage.Equipment.Bobbers.SimpleBobber:Clone()
    }
    setmetatable(fb, FishingBobber)
    return fb
end

function createLine(bobber, pole)
    bobber.Line = Instance.new("Beam")
	bobber.Line.Attachment0 = pole.Tip.Attachment
	bobber.Line.Attachment1 = bobber.Model.Top.Attachment

	bobber.Line.CurveSize0 = 0 -- create a curved beam
	bobber.Line.CurveSize1 = -2 -- create a curved beam
	bobber.Line.FaceCamera = true -- beam is visible from every angle 
	bobber.Line.Segments = 10 -- default curve resolution  
	bobber.Line.Width0 = 0.1
	bobber.Line.Width1 = 0.1
	
    bobber.Line.Color = ColorSequence.new({ -- a color sequence shifting from white to blue
		ColorSequenceKeypoint.new(0, Color3.fromRGB(139,69,19)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(139,69,19))
	})

	-- parent beam
	bobber.Line.Enabled = true
	bobber.Line.Parent = bobber.Line.Attachment0
end

function FishingBobber:Deploy(pole, targetLocation)
    createLine(self, pole)
    self.Model.Parent = game.Workspace
	self.Model:MoveTo(targetLocation)
end

function FishingBobber:Destroy()
    self.Line:Destroy()
    self.Model:Destroy()
    self = nil
end

FishingBobber.__index = FishingBobber
return FishingBobber