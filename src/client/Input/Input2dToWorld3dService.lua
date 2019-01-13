local Input2dToWorld3dService = {}

function Input2dToWorld3dService.Convert(x, y)
    local CameraToPointUnitRay = game.workspace.CurrentCamera:ScreenPointToRay(x, y)
    local NewRay = Ray.new(CameraToPointUnitRay.Origin, CameraToPointUnitRay.Direction * 1000)
    
    -- Ignore the character when drawing the ray
	return workspace:FindPartOnRay(NewRay, game.Players.LocalPlayer.Character)
end

return Input2dToWorld3dService