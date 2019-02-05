local VmMock = {}

function VmMock.new()
    vm = {
        dispatchedObjectCapture = nil
    }

    setmetatable(vm, VmMock)
    return vm
end

function VmMock:dispatch(obj)
    self.dispatchedObjectCapture = obj
end

VmMock.__index = VmMock
return VmMock