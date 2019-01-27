local Roact = require(game.ReplicatedStorage.lib.Roact)
local RoactRodux = require(game.ReplicatedStorage.lib.RoactRodux)

local LeftHudStat = require(script.Parent.LeftHudStat)

function TotalFishStat(props)
    props = props or {}

    return Roact.createElement(LeftHudStat, {
        FrameName = props.FrameName or "TotalFishStatComponent",
        IconText = props.IconText or "🐟",
        AmountText = props.AmountText or "Loading..."
    })
end

TotalFishStat = RoactRodux.connect(
    function(state, props)
        -- mapStateToProps is run every time the store's state updates.
        -- It's also run whenever the component receives new props.
        return {
            AmountText = state.TotalFishCaught,
        }
    end
)(TotalFishStat)

return TotalFishStat