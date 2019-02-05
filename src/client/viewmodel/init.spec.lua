return function()
    local dependencies

    function setup()
        getmetatable(script.Parent).instance.moduleLoaded = false

        dependencies = {}
        dependencies.Rodux = require(game.Mocks.RoduxMock)
        dependencies.TotalCoinsReducer = require(game.Mocks.ReducerMock).new()
        dependencies.IsfishingReducer = require(game.Mocks.ReducerMock).new()
        dependencies.WaitingForFishReducer = require(game.Mocks.ReducerMock).new()
        dependencies.FishBagReducer = require(game.Mocks.ReducerMock).new()
        dependencies.FishBagDispatcherInstance = game.Mocks.FishBagDispatcherMock

        require(script.Parent.Dependencies).Inject(dependencies)

        getmetatable(dependencies.FishBagDispatcherInstance).instance.moduleLoaded = false

        dependencies.FishBagReducer.returnValue = nil
        dependencies.TotalCoinsReducer.returnValue = nil
        dependencies.IsfishingReducer.returnValue = nil
        dependencies.WaitingForFishReducer.returnValue = nil
    end

    describe("Store State", function()
        it("Will have a property called FishBag that is set by the fish bag reducer.", function()
            setup()
            dependencies.FishBagReducer.returnValue = 123

            local uut = require(script.Parent)
            expect(uut().FishBag).to.equal(123)
        end)

        it("Will have a property called TotalCoins that is set by the total coins reducer", function()
            setup()
            dependencies.TotalCoinsReducer.returnValue = 321

            local uut = require(script.Parent)
            expect(uut().TotalCoins).to.equal(321)
        end)

        it("Will have a property called PlayerIsFishing that is set by the is fishing reducer", function()
            setup()
            dependencies.IsfishingReducer.returnValue = "abc"

            local uut = require(script.Parent)
            expect(uut().PlayerIsFishing).to.equal("abc")
        end)

        it("Will have a property called WaitingForFish that is set by the waiting for fish reducer", function()
            setup()
            dependencies.WaitingForFishReducer.returnValue = "xyz"

            local uut = require(script.Parent)
            expect(uut().WaitingForFish).to.equal("xyz")
        end)
    end)
end