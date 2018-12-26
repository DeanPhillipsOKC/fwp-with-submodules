return function()
    local uutDependencies = require(script.Parent.Dependencies)

    local DataStoreMock = requireFsModule("DataStore2Mock")

    uutDependencies.Inject({
        DataStore = DataStoreMock
    })

    local uut = require(script.Parent)

    describe("GetTotalCoins", function()
        it("Should return total coin value stored in the database", function()
            local player = uut.new({ UserId = "Unit Tester 1"})
            DataStoreMock.SetGet(321)
            expect(player:GetTotalCoins()).to.equal(321)
        end)

        it("Should return 0, if user does not have any coins yet", function()
            local player = uut.new({ UserId = "Unit Tester 2"})
            DataStoreMock.SetGet(nil)
            expect(player:GetTotalCoins()).to.equal(0)
        end)
    end)

    describe("SetTotalCoins", function()
        it("Should update the users total coins", function()
            local player = uut.new( { UserId = "Unit Tester 3" })
            DataStoreMock.SetGet(nil)
            player:SetTotalCoins(112233)
            expect(player:GetTotalCoins()).to.equal(112233)
        end)

        it("Should accept strings as long as they can be converted to an integer", function()
            local player = uut.new( { UserId = "Unit Tester 4" })
            DataStoreMock.SetGet(nil)
            player:SetTotalCoins("223344")
            expect(player:GetTotalCoins()).to.equal(223344)
        end)

        it("Should throw an error if the new total coins value is nil", function()
            local player = uut.new( { UserId = "Unit Tester 5" })
            DataStoreMock.SetGet(nil)
            expect(function() 
                player:SetTotalCoins(nil) 
            end).to.throw()
        end)

        it("Should throw an error if the new total coins value is non-numeric", function()
            local player = uut.new( { UserId = "Unit Tester 6" })
            DataStoreMock.SetGet(nil)
            expect(function() 
                player:SetTotalCoins("abc") 
            end).to.throw()
        end)

        it("Should throw an error if the new total coins value is not a whole number", function()
            local player = uut.new( { UserId = "Unit Tester 7" })
            DataStoreMock.SetGet(nil)
            expect(function() 
                player:SetTotalCoins(123.5) 
            end).to.throw()
        end)
    end)
end