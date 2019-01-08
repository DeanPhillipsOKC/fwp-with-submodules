return function()
    local dependencies = {
        ReplicatedStorage = { },
        PlayersService = require("PlayersServiceMock")
    }

    require(script.Parent.Dependencies).Inject(dependencies)

    local uut = require(script.Parent)

    describe("Constructor", function()
        it("Will throw an error, if the player object is nil", function()
            expect(function()
                uut.new()
            end).to.throw()        
        end)

        it("Will throw an error, if a player name is not provided", function()
            expect(function()
                uut.new({})
            end).to.throw()
        end)

        it("Will create a new player animation controller if parameter checking passes", function()
            local pac = uut.new({ Name = "bob" })
            expect(pac).to.be.ok()
        end)
    end)

    describe("Play()", function()
        it("Will throw an error, if the Animations folder cannot be found in replicated storage", function()
            dependencies.ReplicatedStorage.Animations = nil
            local pac = uut.new( { Name = "bob" })

            expect(function()
                pac:Play()
            end).to.throw()
        end)

        it("Will throw an error, if the animation name is null", function()
            dependencies.ReplicatedStorage.Animations = { }
            local pac = uut.new ({ Name = "bob" })
            expect(function()
                pac:Play()
            end).to.throw()
        end)

        it("Will throw an error, if the animation name is empty", function()
            dependencies.ReplicatedStorage.Animations = {}
            local pac = uut.new({ Name = "bob" })
            
            expect(function()
                pac:Play("")
            end).to.throw()
        end)

        it("Will throw an error, if the animation does not exist in replicated storage.", function()
            dependencies.ReplicatedStorage.Animations = {}
            local pac = uut.new({ Name = "bob" })

            expect(function()
                pac:Play("SomeAnimation")
            end).to.throw()
        end)

        it("Will throw an error, if the player is no longer in the game.", function()
            dependencies.ReplicatedStorage.Animations = { 
                SomeAnimation = {}
            }
            local pac = uut.new({ Name = "bob" })

            expect(function()
                pac:Play("SomeAnimation")
            end).to.throw()
        end)

        it("Will load the animation track and play it", function()
            local player = { Name = "bob" }
            dependencies.ReplicatedStorage.Animations = {
                SomeAnimation = {}
            }
            dependencies.PlayersService.AddPlayerToGame(player)

            local pac = uut.new(player)

            pac:Play("SomeAnimation")

            expect(pac.AnimationTracks["SomeAnimation"].IsPlaying).to.equal(true)
        end)
    end)

    describe("Stop()", function() 
        it("Should stop the animation track", function()
            local player = { Name = "bob" }
            dependencies.ReplicatedStorage.Animations = {
                SomeAnimation = {}
            }
            dependencies.PlayersService.AddPlayerToGame(player)

            local pac = uut.new(player)

            pac:Play("SomeAnimation")
            pac:Stop("SomeAnimation")

            expect(pac.AnimationTracks.SomeAnimation.IsPlaying).to.equal(false)
        end)
    end)
end