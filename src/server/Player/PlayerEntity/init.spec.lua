return function()
    local uutDependencies = require(script.Parent.Dependencies)

    local DataStoreMock = requireFsModule("DataStore2Mock")
    local PlayersInGame = {}

    setmetatable(PlayersInGame, {})

    uutDependencies.Inject({
        DataStore = DataStoreMock,
        PlayerBackpack = requireFsModule("PlayerBackpackMock"),
        PlayerAnimationController = requireFsModule("PlayerAnimationControllerMock")
    })

    local uut = require(script.Parent)

    describe("GetUserId", function()
        it("Should return the player's UserID", function()
            local player = uut.new({ UserId = "Unit Tester 0", Name = "bob"})
            expect(player:GetUserId()).to.equal("Unit Tester 0")
        end)
    end)

    describe("GetTotalCoins", function()
        it("Should return total coin value stored in the database", function()
            local player = uut.new({ UserId = "Unit Tester 1", Name = "bob"})
            DataStoreMock.SetGet(321)
            expect(player:GetTotalCoins()).to.equal(321)
        end)

        it("Should return 0, if user does not have any coins yet", function()
            local player = uut.new({ UserId = "Unit Tester 2", Name = "bob"})
            DataStoreMock.SetGet(nil)
            expect(player:GetTotalCoins()).to.equal(0)
        end)
    end)

    describe("SetTotalCoins", function()
        it("Should update the users total coins", function()
            local player = uut.new( { UserId = "Unit Tester 3", Name = "bob" })
            DataStoreMock.SetGet(nil)
            player:SetTotalCoins(112233)
            expect(player:GetTotalCoins()).to.equal(112233)
        end)

        it("Should accept strings as long as they can be converted to an integer", function()
            local player = uut.new( { UserId = "Unit Tester 4", Name = "bob" })
            DataStoreMock.SetGet(nil)
            player:SetTotalCoins("223344")
            expect(player:GetTotalCoins()).to.equal(223344)
        end)

        it("Should throw an error if the new total coins value is nil", function()
            local player = uut.new( { UserId = "Unit Tester 5", Name = "bob" })
            DataStoreMock.SetGet(nil)
            expect(function() 
                player:SetTotalCoins(nil) 
            end).to.throw()
        end)

        it("Should throw an error if the new total coins value is non-numeric", function()
            local player = uut.new( { UserId = "Unit Tester 6", Name = "bob" })
            DataStoreMock.SetGet(nil)
            expect(function() 
                player:SetTotalCoins("abc") 
            end).to.throw()
        end)

        it("Should throw an error if the new total coins value is not a whole number", function()
            local player = uut.new( { UserId = "Unit Tester 7", Name = "bob" })
            DataStoreMock.SetGet(nil)
            expect(function() 
                player:SetTotalCoins(123.5) 
            end).to.throw()
        end)
    end)

    describe("GetCurrentPole", function()
        it("Should return the name of pole that is stored in the database", function()
            local player = uut.new( {UserId = "GetCurrentPole Test User 1", Name = "bob" })
            DataStoreMock.SetGet("SomeAwesomePole")
            expect(player:GetCurrentPole()).to.equal("SomeAwesomePole")
        end)

        it("Should return the basic pole if nothing is stored in the database", function()
            local player = uut.new({UserId = "GetCurrentPole Test User 2", Name = "bob"})
            DataStoreMock.SetGet(nil)
            expect(player:GetCurrentPole()).to.equal("BasicPole")
        end)
    end)

    describe("PlayAnimation", function()
        it("Should play the animation", function()
            local player = uut.new( {UserId = 123, Name = "bob" })
            player:PlayAnimation("SomeAnimation")
            expect(player.animationController.AnimationsPlayed.SomeAnimation).to.equal(true)
        end)
    end)

    describe("StopAnimation", function()
        it("Should stop the animation from playing", function()
            local player = uut.new( {UserId = 123, Name = "bob" })
            player:StopAnimation("SomeAnimation")
            expect(player.animationController.AnimationsStopped.SomeAnimation).to.equal(true)
        end)
    end)
end