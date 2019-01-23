return function()
    
    require(script.Parent.Dependencies).Inject({
        FishingPoleFactory = require(game.Mocks.FishingPoleFactoryMock)
    })

    local uut = require(script.Parent)

    describe("Initialization", function()
        describe("BasicPole", function()
            it("Should get created.", function()
                expect(uut.Get("BasicPole")).to.be.ok()
            end)

            it("Should have a catch delay of 5 seconds", function()
                expect(uut.Get("BasicPole").CatchDelay).to.equal(5)
            end)
        end)
    end)

    describe("Get", function()
        it("Should return the pole with a matching name.", function()
            expect(uut.Get("BasicPole")).to.be.ok()
            expect(uut.Get("BasicPole").CatchDelay).to.equal(5)
        end)

        it("Should throw an error if the repository does not have a matching pole.", function()
            expect(function()
                uut.Get("NoPoleWithThisName")
            end).to.throw()
        end)
    end)

end