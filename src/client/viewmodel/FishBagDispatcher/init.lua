local FishBagDispatcher = {}
FishBagDispatcher.prototype = {}

local dependencies = require(script.Dependencies).Get()

function FishBagDispatcher.Dispatch(totalFishCaught, bagContents)
    assert(totalFishCaught ~= nil, "Attempted to dispatch a fish bag contents change without a total fish caught.")
    assert(bagContents ~= nil, "Attempted to dispatch a fish bag contents change without bag contents. ")

    dependencies.VM:dispatch({
        type = "fishBagContentsChanged",
        FishBag = {
            Total = totalFishCaught,
            Contents = bagContents
        }
    })
end

dependencies.FishBagContentsChangedRE.OnClientEvent:Connect(function(newTotalFishCaught, newFishBagContents)
    print("newTotalFishCaught", newTotalFishCaught)
    FishBagDispatcher.Dispatch(newTotalFishCaught, newFishBagContents)
end)

local totalFishCaught = dependencies.GetTotalFishCaughtRF:InvokeServer()
local fishBagContents = dependencies.GetFishBagContentsRF:InvokeServer()

FishBagDispatcher.Dispatch(totalFishCaught, fishBagContents)

return FishBagDispatcher.prototype