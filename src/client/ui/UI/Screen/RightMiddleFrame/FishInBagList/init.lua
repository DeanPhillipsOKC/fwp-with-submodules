local dependencies = require(script.Dependencies).Get()

function FishInBagComponent(props)
    props = props or {}
    props.FishBagContents = props.FishBagContents or {}

    local list = {
        Layout = dependencies.Roact.createElement("UIGridLayout", {
            Name = "Layout",
            CellPadding = UDim2.new(0, 0, 0, 0)
        })
    }

    for k,v in pairs(props.FishBagContents) do
        list[k] = dependencies.Roact.createElement(dependencies.CaughtFishComponent, {
            ID = v.ImageAssetId, 
            Count = v.Total
        })
    end

    return dependencies.Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        CanvasSize = UDim2.new(1, 0, 1, 0)
    }, list)
end

FishInBagList = dependencies.RoactRodux.connect(
    function(state, props)
        assert(state ~= nil, "State should not be nil.")
        assert(state.FishBag ~= nil, "State should have a FishBag property")
        assert(state.FishBag.Contents ~= nil, "State FishBag property should have Contents")

        return {
            FishBagContents = state.FishBag.Contents
        }
    end
)(FishInBagComponent)

return FishInBagList