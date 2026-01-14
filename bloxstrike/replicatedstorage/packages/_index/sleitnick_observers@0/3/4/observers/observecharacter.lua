-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.observePlayer)
return function(self)
	-- upvalues: (copy) v_u1
	return v_u1(function(self)
		-- upvalues: (copy) self
		local v_u1 = nil
		local v_u2 = nil
		local function v_u3(self)
			-- upvalues: (ref) self, (copy) self, (ref) v_u2, (ref) v_u1
			local v_u1 = nil
			task.defer(function()
				-- upvalues: (ref) self, (ref) self, (copy) self, (ref) v_u2, (ref) v_u1, (ref) v_u1
				local v1 = self(self, self)
				if typeof(v1) == "function" then
					if v_u2.Connected and self.Parent then
						v_u1 = v1
						v_u1 = v1
						return
					end
					task.spawn(v1)
				end
			end)
			local v_u2 = nil
			v_u2 = self.AncestryChanged:Connect(function(_, arg2)
				-- upvalues: (ref) v_u2, (ref) v_u1, (ref) v_u1
				if arg2 == nil and v_u2.Connected then
					v_u2:Disconnect()
					if v_u1 ~= nil then
						task.spawn(v_u1)
						if v_u1 == v_u1 then
							v_u1 = nil
						end
						v_u1 = nil
					end
				end
			end)
		end
		v_u2 = self.CharacterAdded:Connect(v_u3)
		task.defer(function()
			-- upvalues: (copy) self, (ref) v_u2, (copy) v_u3
			if self.Character and v_u2.Connected then
				task.spawn(v_u3, self.Character)
			end
		end)
		return function()
			-- upvalues: (ref) v_u2, (ref) v_u1
			v_u2:Disconnect()
			if v_u1 ~= nil then
				task.spawn(v_u1)
				v_u1 = nil
			end
		end
	end)
end