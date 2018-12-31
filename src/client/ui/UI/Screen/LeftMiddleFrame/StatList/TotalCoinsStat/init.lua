local Roact = require(game.ReplicatedStorage.lib.Roact)
local RoactRodux = require(game.ReplicatedStorage.lib.RoactRodux)

local LeftHudStat = require(script.Parent.LeftHudStat)

function TotalCoinsStat(props)
    props = props or {}

    return Roact.createElement(LeftHudStat, {
        FrameName = props.FrameName or "TotalCoinsStatComponent",
        IconText = props.IconText or "💰",
        AmountText = props.AmountText or "Loading..."
    })
end

TotalCoinsStat = RoactRodux.connect(
    function(state, props)
        -- mapStateToProps is run every time the store's state updates.
        -- It's also run whenever the component receives new props.
        return {
            AmountText = state.TotalCoins,
        }
    end
)(TotalCoinsStat)

return TotalCoinsStat