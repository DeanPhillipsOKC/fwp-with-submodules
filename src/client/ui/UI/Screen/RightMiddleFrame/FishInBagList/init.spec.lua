return function()
    local dependencies

    function setup()
        dependencies = {}
        dependencies.Roact = require(game.Mocks.RoactMock)
        dependencies.RoactRodux = require(game.Mocks.RoactRoduxMock)
        dependencies.CaughtFishComponent = "Caught Fish Component"

        require(script.Parent.Dependencies).Inject(dependencies)
    end

    describe("Property Mapper", function()
        it("Should set the FishBagContents property to the total in the FishBag Contents state property", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            expect(roactRoduxComponent.Mapper({
                FishBag = {
                    Contents = 123
                }
            }, nil).FishBagContents).to.equal(123)
        end)

        it("Should throw an exception if the state is nil.", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            expect(function()
                roactRoduxComponent.Mapper(nil, {})
            end).to.throw()
        end)

        it("Should throw an error if the state is missing a FishBag property", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            expect(function()
                roactRoduxComponent.Mapper({}, {})
            end)
        end)

        it("Should throw an error if the state is missing a FishBag.Contents property", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            expect(function()
                roactRoduxComponent.Mapper({ 
                    FishBag = {}
                }, {})
            end).to.throw()
        end)
    end)

    describe("Component Builder", function()
        it("Should return a top-level component of type ScrollingFrame", function()
            setup()

            local roactRoduxComponent = require(script.Parent)
            
            local component, props, childComponent = roactRoduxComponent.PropertyBuilder()

            expect(component).to.equal("ScrollingFrame")
        end)

        it("Should return a child component with a Layout component of type UIGridLayout", function()
            setup()

            local roactRoduxComponent = require(script.Parent)
            
            local component, props, childComponent = roactRoduxComponent.PropertyBuilder()

            expect(childComponent.Layout).to.equal("UIGridLayout")
        end)
    end)
end