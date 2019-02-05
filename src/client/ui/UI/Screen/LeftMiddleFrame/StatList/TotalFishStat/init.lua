local dependencies = require(script.Dependencies).Get()

function TotalFishStat(props)
    props = props or {}

    return dependencies.Roact.createElement(dependencies.BaseComponent, {
        FrameName = props.FrameName or "TotalFishStatComponent",
        IconText = props.IconText or "🐟",
        AmountText = props.AmountText or "Loading..."
    })
end

TotalFishStat = dependencies.RoactRodux.connect(
    function(state, props)
        assert(state ~= nil, "state should not be nil.")
        assert(state.FishBag ~= nil, "state should have a FishBag property")
        assert(state.FishBag.Total ~= nil, "FishBag should have a Total property")

        -- mapStateToProps is run every time the store's state updates.
        -- It's also run whenever the component receives new props.
        return {
            AmountText = state.FishBag.Total
        }
    end
)(TotalFishStat)

return TotalFishStat