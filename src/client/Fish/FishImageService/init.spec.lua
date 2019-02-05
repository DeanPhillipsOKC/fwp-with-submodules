return function()
    describe("GetAssetIdFromName", function()
        local uut

        local function setup()
            uut = require(script.Parent)
        end

        it("Should return the asset ID corresponding to the fish name parameter", function()
            setup()

            expect(uut.GetAssetIdFromName("Sweetwater Melon Cote")).to.be.ok()
        end)

        it("Should throw an error if the asset ID is not known", function()
            setup()

            expect(function()
                uut.GetAssetIdFromName("Who Dat")
            end).to.throw()
        end)

        it("Should throw an error if the fish name parameter is null", function()
            setup()

            expect(function()
                uut.GetAssetIdFromName()
            end).to.throw()

            expect(function()
                uut.GetAssetIdFromName(nil)
            end)
        end)
    end)
end