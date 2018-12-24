return function()
	local Hello = require(script.Parent.hello)

	describe("hello", function()
		it("should include the customary English greeting", function()
			local greeting = Hello.Message
			expect(greeting:match("Hello Lua!")).to.be.ok()
		end)
	end)
end