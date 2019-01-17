local Roact = require(game.ReplicatedStorage.lib.Roact)
local CaughtFishComponent = require(script.CaughtFish)
local RoactRodux = require(game.ReplicatedStorage.lib.RoactRodux)


local FishInBagList = Roact.Component:extend("FishInBagList")

local FishInBag = {}

function FishInBagList:render()
    local list = {
        Layout = Roact.createElement("UIGridLayout", {
            Name = "Layout",
            CellPadding = UDim2.new(0, 0, 0, 0)
        })
    }

    for k,v in pairs(FishInBag) do
        list[k] = Roact.createElement(CaughtFishComponent, {
            ID = v.ImageId, 
            Count = v.Count
        })
    end
    
    return Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        CanvasSize = UDim2.new(1, 0, 1, 0)
    }, list)
end

-- Used to determine if we need ot update our FishInBag list with a new catch
function caughtNewFish(state)
    return state.CaughtFish.TimeLastFishWasCaught ~= nil and FishInBag[state.CaughtFish.TimeLastFishWasCaught] == nil
end

function addLatestCatchToBag(state)
    -- Search the bag for the same kind of fish.  If found, remember the key so that we
    -- can update the count, and delete it.
    for k, v in pairs(FishInBag) do
        if v.Name == state.CaughtFish.Name then
            fishFound = true
            keyToReplace = k
            break
        end
    end

    FishInBag[state.CaughtFish.TimeLastFishWasCaught] = {
        Name = state.CaughtFish.Name,
        Count = fishFound and (FishInBag[keyToReplace].Count + 1) or 1,
        ImageId = state.CaughtFish.ImageId
    }

    -- If the fish was found in the old list, we need to get rid of the old key
    -- because the time of the latest catch has changed.
    if fishFound then
        FishInBag[keyToReplace] = nil
    end
end

FishInBagList = RoactRodux.connect(
    function(state, props)
        local fishFound = false
        local keyToReplace = nil
        if caughtNewFish(state) then
            addLatestCatchToBag(state)
        end

        return {
            TimeLastFishWasCaught = state.CaughtFish.TimeLastFishWasCaught,
            NameOfLastFishCaught = state.CaughtFish.Name,
            ImageIdOfLastFishCaught = state.CaughtFish.ImageId
        }
    end
)(FishInBagList)

return FishInBagList