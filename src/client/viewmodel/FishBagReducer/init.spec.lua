return function()
    describe("Reducer", function()
        local uut
        local dpendencies
        local oldState
        local changedBagContents

        local function setup()
            uut = require(script.Parent)

            dependencies = {
                FishImageService = require(game.Mocks.FishImageServiceMock)
            }

            require(script.Parent.Dependencies).Inject(dependencies)

            oldState = {
                FishBag = {
                    Total = 7,
                    Contents = {
                        SunFish = {
                            ImageAssetId = "1234",
                            Total = 4
                        },
                        StarFish = {
                            ImageAssetId = "4321",
                            Total = 3
                        }
                    }
                }
            }

            changedBagContents = {
                Total = 12,
                Contents = {
                    SunFish = 5,
                    StarFish = 6,
                    SillyFish = 1
                }
            }
        end
        
        it("Should return a new state with a zero total fish, if the fish bag contents did not change and the fish bag state is nil", function()
            setup()
            expect(uut({}, {}).Total).to.equal(0)
        end)

        it("Should return a new state with an empty bag, if the fish bag contents did not change and the fish bag state is nil", function()
            setup()
            local state = uut({}, {})

            expect(state.Contents).to.be.ok()
            expect(type(state.Contents)).to.equal("table")
        end)

        it("Should return the original fish bag state, if the fish bag contents did not change, and an old state is available.", function()
            setup()
            
            local state = uut(oldState, {})

            expect(state).to.equal(oldState.FishBag)
        end)

        it("Should return a new fish bag state with an updated total fish count, if the fish bag contents changed", function()
            setup()

            local state = uut(oldState, {
                type = "fishBagContentsChanged",
                FishBag = changedBagContents
            })

            expect(state.Total).to.equal(changedBagContents.Total)
        end)

        it("Should return a new fish bag with updated contents, if the fish bag contents changed", function()
            local state = uut(oldState, {
                type = "fishBagContentsChanged",
                FishBag = changedBagContents
            })

            expect(state.Contents).to.be.ok()
            
            expect(state.Contents.SunFish).to.be.ok()
            expect(state.Contents.StarFish).to.be.ok()
            expect(state.Contents.SillyFish).to.be.ok()
            
            expect(state.Contents.SunFish.Total).to.equal(changedBagContents.Contents.SunFish)
            expect(state.Contents.StarFish.Total).to.equal(changedBagContents.Contents.StarFish)
            expect(state.Contents.SillyFish.Total).to.equal(changedBagContents.Contents.SillyFish)
        end)

        it("Should return Image asset IDs for each fish in the bag, if the fish bag contents changed", function()
            local state = uut(oldState, {
                type = "fishBagContentsChanged",
                FishBag = changedBagContents
            })

            expect(state.Contents).to.be.ok()
            
            expect(state.Contents.SunFish.ImageAssetId).to.be.ok()
            expect(state.Contents.StarFish.ImageAssetId).to.be.ok()
            expect(state.Contents.SillyFish.ImageAssetId).to.be.ok()
        end)

        it("Should throw an exception, if not fish bag is found, when the bag contents change", function()    
            expect(function()
                uut(oldState, {
                    type = "fishBagContentsChanged",
                    FishBag = nil
                })
            end).to.throw()
        end)

        it("Should throw an exception, if a new fish bag total is not found, when the bag contents change.", function()
            expect(function()
                uut(oldState, {
                    type = "fishBagContentsChanged",
                    FishBag = {
                        Total = nil,
                        Contents = {}
                    }
                })
            end).to.throw()
        end)

        it("Should throw an exception, if a new fish bag contents are not found, when the bag contents change.", function()
            expect(function()
                uut(oldState, {
                    type = "fishBagContentsChanged",
                    FishBag = {
                        Total = 7,
                        Contents = nil
                    }
                })
            end).to.throw()
        end)

        it("Should throw an exception if no dependencies are found.", function()
            setup()
            require(script.Parent.Dependencies).Inject(nil)
            expect(function()
                uut({}, {})    
            end).to.throw()
        end)
    end)
end