return function()
    local dependencies

    local GetRandomIntegerReturnVals = {
        1, 1, 1
    }

    local uut;

    function setup()
        for i,k in ipairs(GetRandomIntegerReturnVals) do
            GetRandomIntegerReturnVals[i] = 1
        end

        dependencies = {
            GetRandomInteger = require(game.Mocks.GetRandomIntegerMock).new(GetRandomIntegerReturnVals)
        }

        getmetatable(script.Parent).instance.moduleLoaded = false

        require(script.Parent.Dependencies).Inject(dependencies)
        uut = require(script.Parent)
    end

    describe("RollForRarity", function()
        it("Should return common if first role is not a 1.", function()
            setup()
            GetRandomIntegerReturnVals[1] = 2

            expect(uut.RollForRarity()).to.equal("Common")
        end)

        it("Should return uncommon if the second role is not a 1 ", function()
            setup()
            GetRandomIntegerReturnVals[2] = 2

            expect(uut.RollForRarity()).to.equal("Uncommon")
        end)

        it("Shoudl return rare if the second role is a 1", function()
            setup()

            expect(uut.RollForRarity()).to.equal("Rare")
        end)
    end)
end