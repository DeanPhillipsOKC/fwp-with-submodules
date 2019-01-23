return function()
    local uut = require(script.Parent)

    describe("Constructor", function()
        it("Should return a reference to the new fishing pole.", function()
            data = {
                CatchDelay = 4
            }

            local pole = uut.new(data)

            expect(pole).never.to.equal(data)
            expect(pole.CatchDelay).to.equal(4)
        end)

        it("Should throw an exception if a CatchDelay is not provided", function()
            expect(function()
                uut.new({})
            end).to.throw()
        end)

        it("Should throw an exception if no data is provided.", function()
            expect(function()
                uut.new()
            end).to.throw()
        end)
    end)
end