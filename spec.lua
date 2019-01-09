local lfs = require"lfs"

-- This makes sure we can load Lemur and other libraries that depend on init.lua
package.path = package.path .. ";?/init.lua"

local lemur = require("modules.infrastructure.lemur")
local habitat = lemur.Habitat.new()

-- Do not fix indent here! Until I work on a way to do this more beautifully, it helps
-- visualize the hierarchy.

local Root = lemur.Instance.new("Folder")
Root.Name = "Root"

	local Dependencies = lemur.Instance.new("Folder")
	Dependencies.Parent = Root
	Dependencies.Name = "Dependencies"

		local TestEZ = habitat:loadFromFs("modules/infrastructure/testez/lib")
		TestEZ.Name = "TestEZ"
		TestEZ.Parent = Dependencies

	local game = habitat.game
	game.Parent = Root

		local Mocks = habitat:loadFromFs("testing/mocks")
		Mocks.Name = "Mocks"
		Mocks.Parent = game

		local ReplicatedStorage = habitat.game:GetService("ReplicatedStorage")
		ReplicatedStorage.Parent = game

			local sharedSrc = habitat:loadFromFs("src/shared")
			sharedSrc.Parent = ReplicatedStorage
			sharedSrc.Name = "src"

		local ServerScriptService = habitat.game:GetService("ServerScriptService")
		ServerScriptService.Parent = game
			
			local serverSrc = habitat:loadFromFs("src/server")
			serverSrc.Parent = ServerScriptService
			serverSrc.Name = "src"

			local serverLib = habitat:loadFromFs("modules/server")
			serverLib.Parent = ServerScriptService
			serverLib.Name = "lib"

		local StarterPlayer = habitat.game:GetService("StarterPlayer")
		StarterPlayer.Parent = game

			local StarterPlayerScripts = StarterPlayer:FindFirstChild("StarterPlayerScripts")
			
				local clientSrc = habitat:loadFromFs("src/client")
				clientSrc.Parent = StarterPlayerScripts
				clientSrc.Name = "src"

-- Load TestEZ and run our tests
local TestEZ = habitat:require(Dependencies.TestEZ)

local results = TestEZ.TestBootstrap:run({Root}, TestEZ.Reporters.TextReporter)

-- Did something go wrong?
if results.failureCount > 0 then
	os.exit(1)
end