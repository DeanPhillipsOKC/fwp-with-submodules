return function()
    local dependencies

    function setup()
        dependencies = {}
        dependencies.Roact = require(game.Mocks.RoactMock)
        dependencies.RoactRodux = require(game.Mocks.RoactRoduxMock)
        dependencies.BaseComponent = "Some Base Component"

        require(script.Parent.Dependencies).Inject(dependencies)
    end

    describe("Property Mapper", function()
        it("Should set the AmountText property to the total in the FishBag state property", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            expect(roactRoduxComponent.Mapper({
                FishBag = {
                    Total = 123
                }
            }, nil).AmountText).to.equal(123)
        end)

        it("Should throw an error if the state is nil", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            expect(function()
                roactRoduxComponent.Mapper(nil, {})
            end).to.throw()
        end)

        it("Should throw an error if the state does not have a FishBag property", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            expect(function()
                roactRoduxComponent.Mapper({}, {})
            end).to.throw()
        end)

        it("Should throw an error if the state FishBag property does not have a Total property", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            expect(function()
                roactRoduxComponent.Mapper({
                    FishBag = { }
                }, {})
            end).to.throw()
        end)
    end)

    describe("Property Builder", function()
        it("Should inherit the BaseComponent", function()
            setup()

            local roactRoduxComponent = require(script.Parent)
            
            local component, props = roactRoduxComponent.PropertyBuilder()

            expect(component).to.equal(dependencies.BaseComponent)
        end)

        it("should set the FrameName property to TotalFishStatComponent, if not already set by mapper", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            local component, props = roactRoduxComponent.PropertyBuilder()

            expect(props.FrameName).to.equal("TotalFishStatComponent")
        end)

        it("Should set the FrameName property to the mapper output, if it was given a value.", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            local component, props = roactRoduxComponent.PropertyBuilder({
                FrameName = "Foo"
            })

            expect(props.FrameName).to.equal("Foo")
        end)

        it("Should set the IconText to a fish emoji, if it was not given a value by the mapper.", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            local component, props = roactRoduxComponent.PropertyBuilder()

            expect(props.IconText).to.equal("🐟")
        end)

        it("Should set the IconText property to the mapper output, if it was given a value.", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            local component, props = roactRoduxComponent.PropertyBuilder({
                IconText = "SomeText"
            })

            expect(props.IconText).to.equal("SomeText")
        end)

        it("Should set the AmountText to Loading, if it was not given a value by the mapper.", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            local component, props = roactRoduxComponent.PropertyBuilder()

            expect(props.AmountText).to.equal("Loading...")
        end)

        it("Should set the AmountText property to the mapper output, if it was given a value.", function()
            setup()

            local roactRoduxComponent = require(script.Parent)

            local component, props = roactRoduxComponent.PropertyBuilder({
                AmountText = "An Amount"
            })

            expect(props.AmountText).to.equal("An Amount")
        end)
    end)

    --return dependencies.Roact.createElement(dependencies.BaseComponent, {
    --    AmountText = props.AmountText or "Loading..."
    --})
end