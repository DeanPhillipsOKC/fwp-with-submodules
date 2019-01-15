return function()
    local uutDependencies = require(script.Parent.Dependencies);

    local PlayerServiceMock = require(game.Mocks.PlayersServiceMock)
    local PlayerFactoryMock = require(game.Mocks.PlayerFactoryMock)
    local PlayerInstantiatedEvent = require(game.Mocks.RemoteEventMock).new()
    local GetTotalCoinsRF = require(game.Mocks.RemoteFunctionMock).new()
    local StartFishingRE = require(game.Mocks.RemoteEventMock).new()
    local StopFishingRE = require(game.Mocks.RemoteEventMock).new()
    local PlayerInstanceMockFactory = require(game.Mocks.PlayerInstanceMock)

    uutDependencies.Inject({
        PlayersService = PlayerServiceMock,
        PlayerFactory = PlayerFactoryMock,
        PlayerInstantiatedEvent = PlayerInstantiatedEvent,
        GetTotalCoinsRF = GetTotalCoinsRF,
        StartFishingRE = StartFishingRE,
        StopFishingRE = StopFishingRE
    })

    local uut = require(script.Parent)

    describe("PlayerAdded Event Handler", function()
        it("Should instantiate, and save a reference for a player that has joined the game", function()
            local player = { UserId = "Unit Tester 1"}
            
            PlayerServiceMock.PlayerAdded:Fire(player)
            expect(uut.GetPlayer(player):GetUserId()).to.equal(player.UserId)
        end)

        it("Should fire a player instantiated event to the client", function()
            local player = { UserId = "Unit Tester 2"}
            local playerRxFromServer = nil

            PlayerInstantiatedEvent:HandleClient(function(player)
                playerRxFromServer = player
            end)

            PlayerServiceMock.PlayerAdded:Fire(player)
            expect(playerRxFromServer.UserId).to.equal(player.UserId)
        end)

        it("Should add the player's currently equipped pole to his or her backpack.", function()
            local player = { UserId = "Unit Tester 3"}
            
            PlayerFactoryMock.SetDefaultEquippedPole("SomePole")
            PlayerServiceMock.PlayerAdded:Fire(player)

            local playerEntity = uut.GetPlayer(player)
            expect(playerEntity.PoleAddedToPack).to.equal("SomePole")
        end)
    end)

    describe("PlayerRemoving Event Handler", function()
        it("Should remove the saved reference to the player that left the game.", function()
            local player = { UserId = "Unit Tester 3"}
            
            PlayerServiceMock.PlayerRemoving:Fire(player)
            expect(uut.GetPlayer(player)).to.equal(nil)
        end)
    end)

    describe("GetTotalCoins Remote Function", function()
        it("Should return the total gold for the corresponding player when invoked.", function()
            local player = { 
                UserId = "Unit Tester GetTotalCoinsRF 1",
                TotalCoins = 743
            }
            PlayerServiceMock.PlayerAdded:Fire(player)

            expect(GetTotalCoinsRF:InvokeServer(player)).to.equal(743)
        end)
    end)

    describe("StartFishing Remote Event", function()
        it("Should play action and idle animations for casting a pole, if player is within 20 studs.", function()
            local player = PlayerInstanceMockFactory.new({ UserId = 123, Name = "bob" })
            player.DistanceFromCharacterReturnValue = 19
            PlayerServiceMock.PlayerAdded:Fire(player)

            StartFishingRE:FireServer(player)
            expect(uut.GetPlayer(player).AnimationsPlayed.CastPole).to.ok()
            expect(uut.GetPlayer(player).AnimationsPlayed.PoleIdle).to.ok()
        end)
    end)

    describe("StartFishing Remote Event", function()
        it("Should deploy the bobber if the casted keyframe is reached in the cast animation", function()
            local player = PlayerInstanceMockFactory.new({ UserId = 123, Name = "bob" })
            player.DistanceFromCharacterReturnValue = 19
            PlayerServiceMock.PlayerAdded:Fire(player)

            StartFishingRE:FireServer(player)
            uut.GetPlayer(player).AnimationsPlayed.CastPole.KeyframeReached:Fire("Casted")

            expect(uut.GetPlayer(player).DeployedBobber).to.be.ok()
        end)
    end)

    describe("StartFishing Remote Event", function()
        it("Should not play action and idle animations for casting a pole, if player is not within 20 studs.", function()
            local player = PlayerInstanceMockFactory.new({ UserId = 123, Name = "bob" })
            player.DistanceFromCharacterReturnValue = 20
            PlayerServiceMock.PlayerAdded:Fire(player)

            StartFishingRE:FireServer(player)
            expect(uut.GetPlayer(player).AnimationsPlayed.CastPole).never.to.be.ok()
            expect(uut.GetPlayer(player).AnimationsPlayed.PoleIdle).never.to.be.ok()
        end)
    end)

    describe("StopFishing Remote Event", function()
        it("Should stop the action, and idle pole animations, if they are playing", function()
            local player = PlayerInstanceMockFactory.new({ UserId = 123, Name = "bob" })
            player.DistanceFromCharacterReturnValue = 19
            
            PlayerServiceMock.PlayerAdded:Fire(player)

            StartFishingRE:FireServer(player)
            StopFishingRE:FireServer(player)
            expect(uut.GetPlayer(player).AnimationsStopped.CastPole).to.equal(true)
            expect(uut.GetPlayer(player).AnimationsStopped.PoleIdle).to.equal(true)
        end)

        it("Should undeploy the bobber.", function()
            local player = PlayerInstanceMockFactory.new({ UserId = 123, Name = "bob" })
            player.DistanceFromCharacterReturnValue = 19
            
            PlayerServiceMock.PlayerAdded:Fire(player)

            StartFishingRE:FireServer(player)
            StopFishingRE:FireServer(player)
            expect(uut.GetPlayer(player).DeployedBobber).never.to.equal(true)
        end)
    end)
end