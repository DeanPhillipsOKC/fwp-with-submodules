local Input2dToWorld3dSvcMock = {}

Input2dToWorld3dSvcMock.ConvertReturnValues = {
    Part = nil,
    Coords = nil
}

Input2dToWorld3dSvcMock.CapturedParameters = {
    X = nil,
    Y = nil
}

function Input2dToWorld3dSvcMock.Convert(x, y)
    Input2dToWorld3dSvcMock.CapturedParameters.X = x
    Input2dToWorld3dSvcMock.CapturedParameters.Y = y

    return Input2dToWorld3dSvcMock.ConvertReturnValues.Part, Input2dToWorld3dSvcMock.ConvertReturnValues.Coords
end

return Input2dToWorld3dSvcMock