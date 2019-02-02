return function()
    local uutDependencies = require(script.Parent.Dependencies)

    local DataStoreMock = require(game.Mocks.DataStore2Mock)
    local FishingPoleRepositoryMock =  require(game.Mocks.FishingPoleRepositoryMock)
    local PlayersInGame = {}
    local EquippedToolLocationMock = {}

    setmetatable(PlayersInGame, {})

    uutDependencies.Inject({
        DataStore = DataStoreMock,
        PlayerBackpack = require(game.Mocks.PlayerBackpackMock),
        PlayerAnimationController = require(game.Mocks.PlayerAnimationControllerMock),
        FishingController = require(game.Mocks.PlayerFishingControllerMock),
        FishingPoleRepository = FishingPoleRepositoryMock,
        EquippedToolLocation = EquippedToolLocationMock
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

    describe("GetFishBagContents", function()
        local player

        function setup()
            player = uut.new( { UserId = 123, Name = "tester"} )
        end

        it("Should return an empty table if database record is null.", function()
            setup()
            DataStoreMock.SetGet(nil)

            expect(player:GetFishBagContents()).to.be.ok()
        end)

        it("Should return whatever table is in the database if record found.", function()
            setup()
            DataStoreMock.SetGet({Name = "someName"})

            expect(player:GetFishBagContents().Name).to.equal("someName")
        end)

        it("Should throw an error if the record in the database is not a table.", function()
            uut.new( { UserId = 123, Name = "tester"} )
            DataStoreMock.SetGet(321)

            expect(function ()
                player:GetFishBagContents()
            end).to.throw()
        end)
    end)

    describe("GetCurrentPole", function()
        it("Should return a pole with the matching name from the fishing pole repository.", function()
            local player = uut.new( {UserId = "GetCurrentPole Test User 1", Name = "bob" })
            DataStoreMock.SetGet("SomeAwesomePole")
            FishingPoleRepositoryMock.poles["SomeAwesomePole"] = {
                Name = "SomeAwesomePole"
            }
            expect(player:GetCurrentPole().Name).to.equal("SomeAwesomePole")
        end)

        it("Should return the basic pole if there is no record of a fishing pole in the database.", function()
            local player = uut.new({UserId = "GetCurrentPole Test User 2", Name = "bob"})
            DataStoreMock.SetGet(nil)
            FishingPoleRepositoryMock.poles["BasicPole"] = {
                Name = "BasicPole"
            }
            expect(player:GetCurrentPole().Name).to.equal("BasicPole")
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

    describe("GetEquippedPole", function()
        it("Should return currently equipped pole from the workspace", function()
            local player = uut.new({
                UserId = 123,
                Name = "bob"
            })
            
            DataStoreMock.SetGet(nil)
            FishingPoleRepositoryMock.poles["BasicPole"] = {
                Name = "BasicPole"
            }

            EquippedToolLocationMock.bob = {
                BasicPole = {
                    Name = "BasicPole"
                }
            }

            expect(player:GetEquippedPole().Name).to.equal("BasicPole")
        end)

        it("Should return null if there is no equipped pole", function()
            local player = uut.new({
                UserId = 123,
                Name = "bob"
            })
            
            DataStoreMock.SetGet(nil)
            FishingPoleRepositoryMock.poles["BasicPole"] = {
                Name = "BasicPole"
            }

            EquippedToolLocationMock.bob = { }

            expect(player:GetEquippedPole()).never.to.be.ok()
        end)

        it("Should throw an exception if there is no entry for player in workspace", function()
            local player = uut.new({
                UserId = 123,
                Name = "bob"
            })
            
            DataStoreMock.SetGet(nil)
            FishingPoleRepositoryMock.poles["BasicPole"] = {
                Name = "BasicPole"
            }

            EquippedToolLocationMock.bob = nil
            
            expect(function()
                player:GetEquippedPole()
            end).to.throw()
        end)
    end)
end