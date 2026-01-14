-- Decompiled with Bunni.lol Decompiler

local v_serverscript = game:GetService("ServerScriptService")
require(v_serverscript.TestRunner.Test)
local function v_u1(arg1, arg2)
	local v_clock = os.clock()
	local v1 = arg2 or 10
	while not arg1() do
		if v1 < os.clock() - v_clock then
			return false
		end
		task.wait()
	end
	return true
end
return function(self)
	-- upvalues: (copy) v_u1
	local v_u1 = require(script.Parent)
	local v_u2 = nil
	self:BeforeEach(function()
		-- upvalues: (ref) v_u2, (copy) v_u1
		v_u2 = v_u1.new()
	end)
	self:AfterEach(function()
		-- upvalues: (ref) v_u2
		v_u2:Destroy()
	end)
	self:Describe("Constructor", function()
		-- upvalues: (copy) self, (copy) v_u1, (ref) v_u2, (ref) v_u1
		self:Test("should create a new signal and fire it", function()
			-- upvalues: (ref) self, (ref) v_u1, (ref) v_u2
			self:Expect(v_u1.Is(v_u2)):ToBe(true)
			task.defer(function()
				-- upvalues: (ref) v_u2
				v_u2:Fire(10, 20)
			end)
			local v_waited, v1 = v_u2:Wait()
			self:Expect(v_waited):ToBe(10)
			self:Expect(v1):ToBe(20)
		end)
		self:Test("should create a proxy signal and connect to it", function()
			-- upvalues: (ref) v_u1, (ref) self, (ref) v_u1
			local v_wrap = v_u1.Wrap(game:GetService("RunService").Heartbeat)
			self:Expect(v_u1.Is(v_wrap)):ToBe(true)
			local v_u1 = false
			v_wrap:Connect(function()
				-- upvalues: (ref) v_u1
				v_u1 = true
			end)
			self:Expect(v_u1(function()
				-- upvalues: (ref) v_u1
				return v_u1
			end, 2)):ToBe(true)
			v_wrap:Destroy()
		end)
	end)
	self:Describe("FireDeferred", function()
		-- upvalues: (copy) self, (ref) v_u2, (ref) v_u1
		self:Test("should be able to fire primitive argument", function()
			-- upvalues: (ref) v_u2, (ref) self, (ref) v_u1
			local v_u1 = nil
			v_u2:Connect(function(arg1)
				-- upvalues: (ref) v_u1
				v_u1 = arg1
			end)
			v_u2:FireDeferred(10)
			self:Expect(v_u1(function()
				-- upvalues: (ref) v_u1
				return v_u1 == 10
			end, 1)):ToBe(true)
		end)
		self:Test("should be able to fire a reference based argument", function()
			-- upvalues: (ref) v_u2, (ref) self, (ref) v_u1
			local v_u1 = { 10, 20 }
			local v_u2 = nil
			v_u2:Connect(function(arg1)
				-- upvalues: (ref) v_u2
				v_u2 = arg1
			end)
			v_u2:FireDeferred(v_u1)
			self:Expect(v_u1(function()
				-- upvalues: (copy) v_u1, (ref) v_u2
				return v_u1 == v_u2
			end, 1)):ToBe(true)
		end)
	end)
	self:Describe("Fire", function()
		-- upvalues: (copy) self, (ref) v_u2
		self:Test("should be able to fire primitive argument", function()
			-- upvalues: (ref) v_u2, (ref) self
			local v_u1 = nil
			v_u2:Connect(function(arg1)
				-- upvalues: (ref) v_u1
				v_u1 = arg1
			end)
			v_u2:Fire(10)
			self:Expect(v_u1):ToBe(10)
		end)
		self:Test("should be able to fire a reference based argument", function()
			-- upvalues: (ref) v_u2, (ref) self
			local v1 = { 10, 20 }
			local v_u2 = nil
			v_u2:Connect(function(arg1)
				-- upvalues: (ref) v_u2
				v_u2 = arg1
			end)
			v_u2:Fire(v1)
			self:Expect(v_u2):ToBe(v1)
		end)
	end)
	self:Describe("ConnectOnce", function()
		-- upvalues: (copy) self, (ref) v_u2
		self:Test("should only capture first fire", function()
			-- upvalues: (ref) v_u2, (ref) self
			local v_u1 = nil
			local v_connectonce = v_u2:ConnectOnce(function(arg1)
				-- upvalues: (ref) v_u1
				v_u1 = arg1
			end)
			self:Expect(v_connectonce.Connected):ToBe(true)
			v_u2:Fire(10)
			self:Expect(v_connectonce.Connected):ToBe(false)
			v_u2:Fire(20)
			self:Expect(v_u1):ToBe(10)
		end)
	end)
	self:Describe("Wait", function()
		-- upvalues: (copy) self, (ref) v_u2
		self:Test("should be able to wait for a signal to fire", function()
			-- upvalues: (ref) v_u2, (ref) self
			task.defer(function()
				-- upvalues: (ref) v_u2
				v_u2:Fire(10, 20, 30)
			end)
			local v_waited, v1, v2 = v_u2:Wait()
			self:Expect(v_waited):ToBe(10)
			self:Expect(v1):ToBe(20)
			self:Expect(v2):ToBe(30)
		end)
	end)
	self:Describe("DisconnectAll", function()
		-- upvalues: (copy) self, (ref) v_u2
		self:Test("should disconnect all connections", function()
			-- upvalues: (ref) v_u2, (ref) self
			v_u2:Connect(function() end)
			v_u2:Connect(function() end)
			self:Expect(#(nil or v_u2):GetConnections()):ToBe(2)
			v_u2:DisconnectAll()
			self:Expect(#(nil or v_u2):GetConnections()):ToBe(0)
		end)
	end)
	self:Describe("Disconnect", function()
		-- upvalues: (copy) self, (ref) v_u2, (ref) v_u1
		self:Test("should disconnect connection", function()
			-- upvalues: (ref) v_u2, (ref) self
			local v_connection = v_u2:Connect(function() end)
			self:Expect(#(nil or v_u2):GetConnections()):ToBe(1)
			v_connection:Disconnect()
			self:Expect(#(nil or v_u2):GetConnections()):ToBe(0)
		end)
		self:Test("should still work if connections disconnected while firing", function()
			-- upvalues: (ref) v_u2, (ref) self
			local v_u1 = 0
			local v_u2 = nil
			v_u2:Connect(function()
				-- upvalues: (ref) v_u1
				v_u1 = v_u1 + 1
			end)
			v_u2 = v_u2:Connect(function()
				-- upvalues: (ref) v_u2, (ref) v_u1
				v_u2:Disconnect()
				v_u1 = v_u1 + 1
			end)
			v_u2:Connect(function()
				-- upvalues: (ref) v_u1
				v_u1 = v_u1 + 1
			end)
			v_u2:Fire()
			self:Expect(v_u1):ToBe(3)
		end)
		self:Test("should still work if connections disconnected while firing deferred", function()
			-- upvalues: (ref) v_u2, (ref) self, (ref) v_u1
			local v_u1 = 0
			local v_u2 = nil
			v_u2:Connect(function()
				-- upvalues: (ref) v_u1
				v_u1 = v_u1 + 1
			end)
			v_u2 = v_u2:Connect(function()
				-- upvalues: (ref) v_u2, (ref) v_u1
				v_u2:Disconnect()
				v_u1 = v_u1 + 1
			end)
			v_u2:Connect(function()
				-- upvalues: (ref) v_u1
				v_u1 = v_u1 + 1
			end)
			v_u2:FireDeferred()
			self:Expect(v_u1(function()
				-- upvalues: (ref) v_u1
				return v_u1 == 3
			end)):ToBe(true)
		end)
	end)
end