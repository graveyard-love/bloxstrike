-- Decompiled with Bunni.lol Decompiler

local v_u_players = game:GetService("Players")
return function(self)
	-- upvalues: (copy) v_u_players
	local v_u1 = nil
	local v_u2 = {}
	local function v_u3(self)
		-- upvalues: (ref) v_u1, (copy) self, (copy) v_u2
		if v_u1.Connected then
			task.spawn(function()
				-- upvalues: (ref) self, (copy) self, (ref) v_u1, (ref) v_u2
				local v1 = self(self)
				if typeof(v1) == "function" then
					if v_u1.Connected and self.Parent then
						v_u2[self] = v1
						return
					end
					task.spawn(v1)
				end
			end)
		end
	end
	v_u1 = v_u_players.PlayerAdded:Connect(v_u3)
	local v_u_connection = v_u_players.PlayerRemoving:Connect(function(arg1)
		-- upvalues: (copy) v_u2
		local v1 = v_u2[arg1]
		v_u2[arg1] = nil
		if typeof(v1) == "function" then
			task.spawn(v1)
		end
	end)
	task.defer(function()
		-- upvalues: (ref) v_u1, (ref) v_u_players, (copy) v_u3
		if v_u1.Connected then
			for _, v1 in v_u_players:GetPlayers() do
				task.spawn(v_u3, v1)
			end
		end
	end)
	return function()
		-- upvalues: (ref) v_u1, (ref) v_u_connection, (copy) v_u2
		v_u1:Disconnect()
		v_u_connection:Disconnect()
		local v1 = next(v_u2)
		while v1 do
			local v2 = v_u2[v1]
			v_u2[v1] = nil
			if typeof(v2) == "function" then
				task.spawn(v2)
			end
			v1 = next(v_u2)
		end
	end
end