return function()
    local uutDependencies = require(script.Parent.Dependencies);

    local PlayerServiceMock = requireFsModule("PlayerServiceMock")
    local PlayerInstantiatedEvent = requireFsModule("RemoteEventMock").new()

    uutDependencies.Inject({
        PlayersService = PlayerServiceMock,
        PlayerFactory = require(script.Parent.Parent.PlayerEntity),
        PlayerInstantiatedEvent = PlayerInstantiatedEvent
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
    end)

    describe("PlayerRemoving Event Handler", function()
        it("Should remove the saved reference to the player that left the game.", function()
            local player = { UserId = "Unit Tester 3"}
            
            PlayerServiceMock.PlayerRemoving:Fire(player)
            expect(uut.GetPlayer(player)).to.equal(nil)
        end)
    end)
end