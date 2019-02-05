local dependencies = {}

dependencies.VM = require(game.Mocks.VmMock).new()
dependencies.FishBagContentsChangedRE = require(game.Mocks.RemoteEventMock).new()
dependencies.GetTotalFishCaughtRF = require(game.Mocks.RemoteFunctionMock).new()
dependencies.GetFishBagContentsRF = require(game.Mocks.RemoteFunctionMock).new()

local uut
local totalFishOnServer
local fishBagContentsOnServer
local serverAskedForTotalFishCaught
local serverAskedForFishBagContents

local function setup()
    serverAskedForTotalFishCaught = false
    serverAskedForFishBagContents = false

    getmetatable(script.Parent).instance.moduleLoaded = false
    
    require(script.Parent.Dependencies).Inject(dependencies)
    
    dependencies.GetTotalFishCaughtRF.OnServerInvoke = function()
        serverAskedForTotalFishCaught = true
        return totalFishOnServer
    end

    dependencies.GetFishBagContentsRF.OnServerInvoke = function()
        serverAskedForFishBagContents = true
        return fishBagContentsOnServer
    end

    dependencies.VM.dispatchedObjectCapture = nil
end

return function()
    describe("Bootstrapper", function()        
        it("Should retrieve the total fish caught from the server when loading.", function()
            totalFishOnServer = 11
            fishBagContentsOnServer = {}

            setup()

            require(script.Parent)

            expect(serverAskedForTotalFishCaught).to.equal(true)
        end)

        it("Should retrieve the contents of the fish bag from the server when loading.", function()
            totalFishOnServer = 22
            fishBagContentsOnServer = {
                StarFish = 2,
                SunFish = 4
            }

            setup()

            require(script.Parent)

            local dispatchedObj = dependencies.VM.dispatchedObjectCapture.FishBag.Contents

            expect(serverAskedForFishBagContents).to.equal(true)
        end)

        it("Should throw an error if the total fish caught is not available when loading.", function()
            totalFishOnServer = nil
            fishBagContentsOnServer = {
                StarFish = 2,
                SunFish = 2
            }

            setup()

            expect(function()
                require(script.Parent)
            end).to.throw()
        end)

        it("Should throw an error if the contents of the fish bag is null when loading.", function()
            totalFishOnServer = 22
            fishBagContentsOnServer = nil
            
            setup()

            expect(function()
                require(script.Parent)
            end).to.throw()
        end)

        it("Should dispatch an action of type fishBagContentsChanged, when loading", function()
            totalFishOnServer = 22
            fishBagContentsOnServer = {}

            setup()

            require(script.Parent)

            expect(dependencies.VM.dispatchedObjectCapture.type).to.equal("fishBagContentsChanged")
        end)

        it("Should dispatch an action with a FishBag object, when loading", function()
            totalFishOnServer = 22
            fishBagContentsOnServer = {}

            setup()

            require(script.Parent)

            expect(dependencies.VM.dispatchedObjectCapture.FishBag).to.be.ok()
        end)

        it("Should dispatch an action with an updated total fish count, when loading", function()
            totalFishOnServer = 22
            fishBagContentsOnServer = {}

            setup()

            require(script.Parent)

            expect(dependencies.VM.dispatchedObjectCapture.FishBag.Total).to.equal(22)
        end)

        it("Should dispatch an action with the new fish bag contents, when loading", function()
            totalFishOnServer = 22
            fishBagContentsOnServer = {
                SunFish = 2,
                StarFish = 3
            }

            setup()

            require(script.Parent)

            expect(dependencies.VM.dispatchedObjectCapture.FishBag.Contents).to.be.ok()
            expect(dependencies.VM.dispatchedObjectCapture.FishBag.Contents.SunFish).to.equal(2)
            expect(dependencies.VM.dispatchedObjectCapture.FishBag.Contents.StarFish).to.equal(3)
        end)
    end)

    describe("Fish Bag Contents Changed Event Handler", function()
        function initialize()
            -- Set the values returned by the remote function calls during
            -- bootstrapping to values that will not throw an exception.
            totalFishOnServer = 11
            fishBagContentsOnServer = {}

            setup()            
            require(script.Parent)
            dependencies.VM.dispatchedObjectCapture = nil
        end

        it("Should throw an error if the total fish caught is not available when contents change.", function()
            initialize()

            expect(function()
                dependencies.FishBagContentsChangedRE:FireClient(nil, {})
            end).to.throw()
        end)

        it("Should throw an error if the contents of the fish bag is null when contents change.", function()
            initialize()

            expect(function()
                dependencies.FishBagContentsChangedRE:FireClient(7, nil)
            end).to.throw()
        end)

        it("Should dispatch an action of type fishBagContentsChanged, when contents change", function()
            initialize()

            dependencies.FishBagContentsChangedRE:FireClient({}, 7, {})

            expect(dependencies.VM.dispatchedObjectCapture.type).to.equal("fishBagContentsChanged")
        end)

        it("Should dispatch an action with a FishBag object, when contents change", function()
            initialize()

            dependencies.FishBagContentsChangedRE:FireClient({}, 7, {})

            expect(dependencies.VM.dispatchedObjectCapture.FishBag).to.be.ok()
        end)

        it("Should dispatch an action with an updated total fish count, when contents change", function()
            initialize()

            dependencies.FishBagContentsChangedRE:FireClient({}, 7, {})

            expect(dependencies.VM.dispatchedObjectCapture.FishBag.Total).to.equal(7)
        end)

        it("Should dispatch an action with the new fish bag contents, when contents change", function()
            initialize()

            dependencies.FishBagContentsChangedRE:FireClient({}, 7, {
                SunFish = 123,
                StarFish = 321
            })

            expect(dependencies.VM.dispatchedObjectCapture.FishBag.Contents).to.be.ok()
            expect(dependencies.VM.dispatchedObjectCapture.FishBag.Contents.SunFish).to.equal(123)
            expect(dependencies.VM.dispatchedObjectCapture.FishBag.Contents.StarFish).to.equal(321)
        end)
    end)
end
