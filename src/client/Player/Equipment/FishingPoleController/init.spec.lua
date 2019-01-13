return function()
    local dependencyInjector = require(script.Parent.Dependencies)
    local uutDependencies = {
        UserInputService = require(game.Mocks.UserInputServiceMock),
        StartFishingRE = require(game.Mocks.RemoteEventMock).new(),
        StopFishingRE = require(game.Mocks.RemoteEventMock).new(),
        Mouse = { Icon = "SomeIcon" },
        Input2dToWorld3dService = require(game.Mocks.Input2dToWorld3dServiceMock),
        Player = require(game.Mocks.PlayerInstanceMock).new()
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

    describe("User Input Service - Input Changed Event Handler", function()
        it("Will not change the mouse cursor if the type of event is something other than mouse movement.", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            pole.Equipped:Fire()

            uutDependencies.Mouse.Icon = "SomeIcon"

            uutDependencies.UserInputService.InputChanged:Fire({ UserInputType = Enum.UserInputType.MouseButton1 })

            expect(uutDependencies.Mouse.Icon).to.equal("")
        end)

        it("Will change the mouse cursor if the mouse cursoor moves over the water filter, and the user is less than 20 studs away.", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            pole.Equipped:Fire()

            uutDependencies.Mouse.Icon = "SomeIcon"

            uutDependencies.Input2dToWorld3dService.ConvertReturnValues.Part = { Name = "WaterFilter" }

            uutDependencies.Player.DistanceFromCharacterReturnValue = 19

            uutDependencies.UserInputService.InputChanged:Fire({ 
                UserInputType = Enum.UserInputType.MouseMovement,
                Position = { X = 1, Y = 2 }
            })

            expect(uutDependencies.Mouse.Icon).to.equal("rbxassetid://2733335402")
        end)

        it("Will keep the default mouse cursor if the user is not less than 20 studs away.", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            pole.Equipped:Fire()

            uutDependencies.Mouse.Icon = "SomeIcon"

            uutDependencies.Input2dToWorld3dService.ConvertReturnValues.Part = { Name = "WaterFilter" }

            uutDependencies.Player.DistanceFromCharacterReturnValue = 20

            uutDependencies.UserInputService.InputChanged:Fire({ 
                UserInputType = Enum.UserInputType.MouseMovement,
                Position = { X = 1, Y = 2 }
            })

            expect(uutDependencies.Mouse.Icon).to.equal("")
        end)

        it("Will keep the default mouse cursor if the mouse cursoor moves over any part other than the water filter", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            pole.Equipped:Fire()

            uutDependencies.Mouse.Icon = "SomeIcon"

            uutDependencies.Input2dToWorld3dService.ConvertReturnValues.Part = { Name = "NotTheWaterFilter" }

            uutDependencies.Player.DistanceFromCharacterReturnValue = 19

            uutDependencies.UserInputService.InputChanged:Fire({ 
                UserInputType = Enum.UserInputType.MouseMovement,
                Position = { X = 1, Y = 2 }
            })

            expect(uutDependencies.Mouse.Icon).to.equal("")
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

        it("Should terminate the connection to the input changed user input service event", function()
            local pole = {
                Equipped = eventFactory.new(),
                Unequipped = eventFactory.new()
            }
            local controller = uut.new({ Pole = pole })

            pole.Equipped:Fire()
            pole.Unequipped:Fire()

            uutDependencies.Mouse.Icon = "SomeIcon"

            uutDependencies.UserInputService.InputChanged:Fire({ UserinputType = Enum.UserInputType.MouseMovement })

            expect(uutDependencies.Mouse.Icon).to.equal("SomeIcon")
        end)
    end)
end