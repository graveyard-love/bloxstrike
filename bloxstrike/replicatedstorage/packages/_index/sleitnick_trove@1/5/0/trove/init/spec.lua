-- Decompiled with Bunni.lol Decompiler

return function()
	local v_u1 = require(script.Parent)
	describe("Trove", function()
		-- upvalues: (copy) v_u1
		local v_u1 = nil
		beforeEach(function()
			-- upvalues: (ref) v_u1, (ref) v_u1
			v_u1 = v_u1.new()
		end)
		afterEach(function()
			-- upvalues: (ref) v_u1
			if v_u1 then
				v_u1:Destroy()
				v_u1 = nil
			end
		end)
		it("should add and clean up roblox instance", function()
			-- upvalues: (ref) v_u1
			local v_part = Instance.new("Part")
			v_part.Parent = workspace
			v_u1:Add(v_part)
			v_u1:Destroy()
			expect(v_part.Parent).to.equal(nil)
		end)
		it("should add and clean up roblox connection", function()
			-- upvalues: (ref) v_u1
			local v_connection = workspace.Changed:Connect(function() end)
			v_u1:Add(v_connection)
			v_u1:Destroy()
			expect(v_connection.Connected).to.equal(false)
		end)
		it("should add and clean up a table with a destroy method", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				["Destroyed"] = false,
				["Destroy"] = function(arg1)
					arg1.Destroyed = true
				end
			}
			v_u1:Add(v1)
			v_u1:Destroy()
			expect(v1.Destroyed).to.equal(true)
		end)
		it("should add and clean up a table with a disconnect method", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				["Connected"] = true,
				["Disconnect"] = function(arg1)
					arg1.Connected = false
				end
			}
			v_u1:Add(v1)
			v_u1:Destroy()
			expect(v1.Connected).to.equal(false)
		end)
		it("should add and clean up a function", function()
			-- upvalues: (ref) v_u1
			local v_u1 = false
			v_u1:Add(function()
				-- upvalues: (ref) v_u1
				v_u1 = true
			end)
			v_u1:Destroy()
			expect(v_u1).to.equal(true)
		end)
		it("should allow a custom cleanup method", function()
			-- upvalues: (ref) v_u1
			local v1 = {
				["Cleaned"] = false,
				["Cleanup"] = function(arg1)
					arg1.Cleaned = true
				end
			}
			v_u1:Add(v1, "Cleanup")
			v_u1:Destroy()
			expect(v1.Cleaned).to.equal(true)
		end)
		it("should return the object passed to add", function()
			-- upvalues: (ref) v_u1
			local v_part = Instance.new("Part")
			local v_add = v_u1:Add(v_part)
			expect(v_part).to.equal(v_add)
			v_u1:Destroy()
		end)
		it("should fail to add object without proper cleanup method", function()
			-- upvalues: (ref) v_u1
			local v_u1 = {}
			expect(function()
				-- upvalues: (ref) v_u1, (copy) v_u1
				v_u1:Add(v_u1)
			end).to.throw()
		end)
		it("should construct an object and add it", function()
			-- upvalues: (ref) v_u1
			local v_u1 = {}
			v_u1.__index = v_u1
			function v_u1.new(arg1)
				-- upvalues: (copy) v_u1
				local v1 = setmetatable({}, v_u1)
				v1._msg = arg1
				v1._destroyed = false
				return v1
			end
			function v_u1.Destroy(arg1)
				arg1._destroyed = true
			end
			local v_construct = v_u1:Construct(v_u1, "abc")
			expect((typeof(v_construct))).to.equal("table")
			expect((getmetatable(v_construct))).to.equal(v_u1)
			expect(v_construct._msg).to.equal("abc")
			expect(v_construct._destroyed).to.equal(false)
			v_u1:Destroy()
			expect(v_construct._destroyed).to.equal(true)
		end)
		it("should connect to a signal", function()
			-- upvalues: (ref) v_u1
			local v_connection = v_u1:Connect(workspace.Changed, function() end)
			expect((typeof(v_connection))).to.equal("RBXScriptConnection")
			expect(v_connection.Connected).to.equal(true)
			v_u1:Destroy()
			expect(v_connection.Connected).to.equal(false)
		end)
		it("should remove an object", function()
			-- upvalues: (ref) v_u1
			local v_connection = v_u1:Connect(workspace.Changed, function() end)
			expect(v_u1:Remove(v_connection)).to.equal(true)
			expect(v_connection.Connected).to.equal(false)
		end)
		it("should not remove an object not in the trove", function()
			-- upvalues: (ref) v_u1
			local v_connection = workspace.Changed:Connect(function() end)
			expect(v_u1:Remove(v_connection)).to.equal(false)
			expect(v_connection.Connected).to.equal(true)
			v_connection:Disconnect()
		end)
		it("should attach to instance", function()
			-- upvalues: (ref) v_u1
			local v_part = Instance.new("Part")
			v_part.Parent = workspace
			local v_attachtoinstance = v_u1:AttachToInstance(v_part)
			expect(v_attachtoinstance.Connected).to.equal(true)
			v_part:Destroy()
			expect(v_attachtoinstance.Connected).to.equal(false)
		end)
		it("should fail to attach to instance not in hierarchy", function()
			-- upvalues: (ref) v_u1
			local v_u_part = Instance.new("Part")
			expect(function()
				-- upvalues: (ref) v_u1, (copy) v_u_part
				v_u1:AttachToInstance(v_u_part)
			end).to.throw()
		end)
		it("should extend itself", function()
			-- upvalues: (ref) v_u1, (ref) v_u1
			local v_extend = v_u1:Extend()
			local v_u1 = false
			v_extend:Add(function()
				-- upvalues: (ref) v_u1
				v_u1 = true
			end)
			expect(v_extend).to.be.a("table")
			expect((getmetatable(v_extend))).to.equal(v_u1)
			v_u1:Clean()
			expect(v_u1).to.equal(true)
		end)
		it("should clone an instance", function()
			-- upvalues: (ref) v_u1
			local v_construct = v_u1:Construct(Instance.new, "Part")
			v_construct.Name = "TroveCloneTest"
			local v_clone = v_u1:Clone(v_construct)
			expect((typeof(v_clone))).to.equal("Instance")
			expect(v_clone).to.never.equal(v_construct)
			expect(v_clone.Name).to.equal("TroveCloneTest")
			expect(v_construct.Name).to.equal(v_clone.Name)
		end)
		it("should clean up a thread", function()
			-- upvalues: (ref) v_u1
			local v_create = coroutine.create(function() end)
			v_u1:Add(v_create)
			expect(coroutine.status(v_create)).to.equal("suspended")
			v_u1:Clean()
			expect(coroutine.status(v_create)).to.equal("dead")
		end)
		it("should not allow objects added during cleanup", function()
			-- upvalues: (ref) v_u1
			expect(function()
				-- upvalues: (ref) v_u1
				v_u1:Add(function()
					-- upvalues: (ref) v_u1
					v_u1:Add(function() end)
				end)
				v_u1:Clean()
			end).to.throw()
		end)
		it("should not allow objects to be removed during cleanup", function()
			-- upvalues: (ref) v_u1
			expect(function()
				-- upvalues: (ref) v_u1
				local function v_u1() end
				v_u1:Add(v_u1)
				v_u1:Add(function()
					-- upvalues: (ref) v_u1, (copy) v_u1
					v_u1:Remove(v_u1)
				end)
				v_u1:Clean()
			end).to.throw()
		end)
	end)
end