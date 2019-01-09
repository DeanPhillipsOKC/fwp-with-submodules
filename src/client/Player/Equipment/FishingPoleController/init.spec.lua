return function()
    local dependencyInjector = require(script.Parent.Dependencies)
    local uutDependencies = {
        UserInputService = require(game.Mocks.UserInputServiceMock),
        StartFishingRE = require(game.Mocks.RemoteEventMock).new(),
        StopFishingRE = require(game.Mocks.RemoteEventMock).new()
    }
    dependencyInjector.Inject(uutDependencies)
    
    local playerStartedFishing = false
    local playerStoppedFishing = false

    uutDependencies.StartFishingRE.OnServerEvent:Connect(function()
        playerStartedFishing = true
    end)

    uutDependencies.StopFishingRE.OnServerEvent:Connect(function()
        playerStoppedFishing = true
    end)

    local uut = require(script.Parent)

    local eventFactory = require(game.Mocks.EventMock)

    describe("Constructor", function()
        it("Should throw an error if no parameters supplied", function()
            expect(function()
                uut.new()
            end).to.throw()
        end)

        it("Should throw an error if no pole provided", function()
            expect(function()
                uut.new({})
            end).to.throw()
        end)

        it("Should build a controller if parameters are valid.", function()
            uut.new({ 
                Pole = {
                    Equipped = eventFactory.new(),
                    Unequipped = eventFactory.new()
                } 
            })
        end)
    end)

    describe("Pole equipped event handler", function()
        it("Should start a connection to the input began user input service event", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            pole.Equipped:Fire()

            expect(controller.inputBeganConnection).to.be.ok()

            pole.Unequipped:Fire()
        end)

        it("Should start a connection to the input ended user input service event", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            pole.Equipped:Fire()

            expect(controller.inputEndedConnection).to.be.ok()

            pole.Unequipped:Fire()
        end)
    end)

    describe("User Input Service - Input Began Handler", function()
        it("Should tell the server that the player started fishing, if the pole is equipped", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            pole.Equipped:Fire()

            playerStartedFishing = false
            playerStoppedFishing = false

            uutDependencies.UserInputService.InputBegan:Fire({ UserInputType = Enum.UserInputType.MouseButton1} )

            expect(playerStartedFishing).to.equal(true)

            pole.Unequipped:Fire()
        end)

        it("Will not tell the server that the player started fishing, if the pole is not equipped", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            playerStartedFishing = false
            playerStoppedFishing = false

            uutDependencies.UserInputService.InputBegan:Fire({ UserInputType = Enum.UserInputType.MouseButton1 })

            expect(playerStartedFishing).never.to.equal(true)
        end)

        it("Will not tell the server that the player started fishing, if the input not the left mouse button.", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            playerStartedFishing = false
            playerStoppedFishing = false

            pole.Equipped:Fire()

            uutDependencies.UserInputService.InputBegan:Fire({ UserInputType = Enum.UserInputType.MouseButton2 })

            expect(playerStartedFishing).never.to.equal(true)

            pole.Unequipped:Fire()
        end)
    end)

    describe("User Input Service - Input Ended Event Handler", function()
        it("Will tell the server that the user stopped fishign if the pole is equipped", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            pole.Equipped:Fire()

            playerStartedFishing = false
            playerStoppedFishing = false

            uutDependencies.UserInputService.InputEnded:Fire({ UserInputType = Enum.UserInputType.MouseButton1} )

            expect(playerStoppedFishing).to.equal(true)

            pole.Unequipped:Fire()
        end)

        it("Will not tell the server that the player stopped fishing, if the pole is not equipped", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            playerStartedFishing = false
            playerStoppedFishing = false

            uutDependencies.UserInputService.InputEnded:Fire({ UserInputType = Enum.UserInputType.MouseButton1 })

            expect(playerStoppedFishing).never.to.equal(true)
        end)

        it("Will not tell the server that the player stopped fishing, if the input is not from the left mouse button.", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            playerStartedFishing = false
            playerStoppedFishing = false

            pole.Equipped:Fire()

            uutDependencies.UserInputService.InputEnded:Fire({ UserInputType = Enum.UserInputType.MouseButton2 })

            expect(playerStoppedFishing).never.to.equal(true)

            pole.Unequipped:Fire()
        end)
    end)

    describe("Pole unequipped event handler", function()
        it("Should terminate the connection to the input began user input service event", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            pole.Equipped:Fire()
            pole.Unequipped:Fire()

            playerStartedFishing = false
            playerStoppedFishing = false

            uutDependencies.UserInputService.InputBegan:Fire({ UserInputType = Enum.UserInputType.MouseButton1 })

            expect(playerStartedFishing).never.to.equal(true)
        end)

        it("Should terminate the connection to the input ended user input service event", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            pole.Equipped:Fire()
            pole.Unequipped:Fire()

            playerStartedFishing = false
            playerStoppedFishing = false

            uutDependencies.UserInputService.InputEnded:Fire({ UserInputType = Enum.UserInputType.MouseButton1 })

            expect(playerStoppedFishing).never.to.equal(true)
        end)
    end)
end