return function()
    local uutDependencies = require(script.Parent.Dependencies)

    local dependencies = {
        PlayersInGame = {},
        EquipmentModelLocation = {}
    }

    uutDependencies.Inject(dependencies)

    describe("Loading the module script", function()
        it("should fail, if missing the players in game dependency.", function()
            dependencies.PlayersInGame = nil
            dependencies.EquipmentModelLocation = {}

            expect(function()
                local uut = require(script.Parent)
            end).to.throw()
        end)

        it("should fail, if missing the equipment model location dependency.", function()
            dependencies.PlayersInGame = {}
            dependencies.EquipmentModelLocation = nil

            expect(function()
                local uut = require(script.Parent)
            end).to.throw()

            EquipmentModelLocation = {}
        end)
    end)

    describe("PlayerBackpack constructor", function()
        it("should fail, if a player is not passed into the constructor", function()
            dependencies.PlayersInGame = {}
            dependencies.EquipmentModelLocation = {}

            local uut = require(script.Parent)

            expect(function()
                uut.new()
            end).to.throw()
        end)

        it("should fail, if the supplied player does not have a Name", function()
            dependencies.PlayersInGame = {}
            dependencies.EquipmentModelLocation = {}
            
            local uut = require(script.Parent)

            expect(function()
                uut.new({})
            end).to.throw()
        end)

        it("should fail, if the supplied player has a null Name", function()
            dependencies.PlayersInGame = {}
            dependencies.EquipmentModelLocation = {}
            
            local uut = require(script.Parent)

            expect(function()
                uut.new({ Name = nil })
            end).to.throw()
        end)

        it("should fail, if the user is not in the game", function()
            dependencies.PlayersInGame = {bob = true}
            dependencies.EquipmentModelLocation = {}
            
            local uut = require(script.Parent)

            expect(function()
                uut.new({ Name = "notbob"})
            end).to.throw()
        end)
    end)

    describe("Add (item to backpack)", function()
        it("Should throw an error if the item is nil", function()
            dependencies.PlayersInGame = {bob = true}
            dependencies.EquipmentModelLocation = {}

            local backpack = require(script.Parent).new({ Name = "bob" })

            expect(function()
                backpack.Add()
            end).to.throw()
        end)

        it("Should throw an error if the item has not category", function()
            dependencies.PlayersInGame = {bob = true}
            dependencies.EquipmentModelLocation = {}

            local backpack = require(script.Parent).new({ Name = "bob" })

            expect(function()
                backpack.Add({
                    Category = nil,
                    Name = "SomeTool"
                })
            end).to.throw()
        end)

        it("Should throw an error if the item has no name", function()
            dependencies.PlayersInGame = {bob = true}
            dependencies.EquipmentModelLocation = {}

            local backpack = require(script.Parent).new({ Name = "bob" })

            expect(function()
                backpack.Add({
                    Category = "SomeCategory",
                    Name = nil
                })
            end).to.throw()
        end)

        it("Should throw an error if the item's category is not known", function()
            dependencies.PlayersInGame = {bob = true}
            dependencies.EquipmentModelLocation = {}

            local backpack = require(script.Parent).new({ Name = "bob" })

            expect(function()
                backpack.Add({
                    Category = "SomeCategory",
                    Name = "SomeTool"
                })
            end).to.throw()
        end)

        it("Should throw an error if the name of the tool is not known", function()
            dependencies.PlayersInGame = {bob = true}
            dependencies.EquipmentModelLocation = {
                SomeCategory = {
                    SomeTool = {}
                }
            }

            local backpack = require(script.Parent).new({ Name = "bob" })

            expect(function()
                backpack.Add({
                    Category = "SomeCategory",
                    Name = "SomeOtherTool"
                })
            end).to.throw()
        end)

        it("Should throw an error if the player is no longer in the game", function()
            dependencies.PlayersInGame = {bob = true}
            dependencies.EquipmentModelLocation = {
                SomeCategory = {
                    SomeTool = {}
                }
            }

            local backpack = require(script.Parent).new({ Name = "bob" })

            dependencies.PlayersInGame.bob = nil

            expect(function()
                backpack.Add({
                    Category = "SomeCategory",
                    Name = "SomeTool"
                })
            end).to.throw()
        end)

        it("Should throw an error if the player does not have a backpack", function()
            dependencies.PlayersInGame = {bob = {
                
            }}
            dependencies.EquipmentModelLocation = {
                SomeCategory = {
                    SomeTool = {}
                }
            }

            local backpack = require(script.Parent).new({ Name = "bob" })

            expect(function()
                backpack:Add({
                    Category = "SomeCategory",
                    Name = "SomeTool"
                })
            end).to.throw()
        end)

        it("Should add the item to the players backpack if there are no errors", function()
            dependencies.PlayersInGame = {
                bob = {
                    WaitForChild = function()
                        return {
                            Backpack = "This is a backpack"
                        }
                    end
                }
            }
            dependencies.EquipmentModelLocation = {
                SomeCategory = {
                    SomeTool = {
                        Clone = function() 
                            return {
                                Parent = nil
                            }
                        end
                    }
                }
            }

            local backpack = require(script.Parent).new({ Name = "bob" })
            backpack:Add({
                Category = "SomeCategory",
                Name = "SomeTool"
            })
        end)
    end)
end