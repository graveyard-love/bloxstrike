-- Decompiled with Bunni.lol Decompiler

local v_u_players = game:GetService("Players")
local v_u1 = {
	["LOCAL_PLAYER"] = "LOCAL_PLAYER",
	["ON_LOCAL_PLAYER"] = "ON_LOCAL_PLAYER",
	["CHARACTER_ADDED"] = "CHARACTER_ADDED",
	["ON_CHARACTER"] = "ON_CHARACTER",
	["CHARACTER_CHILD_ADDED"] = "CHARACTER_CHILD_ADDED"
}
local v_u2 = {
	["_connectionUtil"] = require(script.Parent:WaitForChild("ConnectionUtil")).new(),
	["_boundEvents"] = {},
	["getLocalPlayer"] = function()
		-- upvalues: (copy) v_u_players
		return v_u_players.LocalPlayer
	end,
	["onLocalPlayer"] = function(arg1)
		-- upvalues: (copy) v_u2, (copy) v_u1, (copy) v_u_players
		local v_getlocalplayer = v_u2.getLocalPlayer()
		if v_getlocalplayer then
			arg1(v_getlocalplayer)
		end
		v_u2._connectionUtil:trackConnection(v_u1.LOCAL_PLAYER, v_u_players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
			-- upvalues: (ref) v_u2, (ref) v_u1
			local v_getlocalplayer = v_u2.getLocalPlayer()
			assert(v_getlocalplayer)
			v_u2._getOrCreateBoundEvent(v_u1.LOCAL_PLAYER):Fire(v_getlocalplayer)
		end))
		return v_u2._getOrCreateBoundEvent(v_u1.LOCAL_PLAYER).Event:Connect(arg1)
	end,
	["getCharacter"] = function()
		-- upvalues: (copy) v_u2
		local v_getlocalplayer = v_u2.getLocalPlayer()
		if v_getlocalplayer then
			return v_getlocalplayer.Character
		else
			return nil
		end
	end,
	["onCharacter"] = function(self)
		-- upvalues: (copy) v_u2, (copy) v_u1
		v_u2._connectionUtil:trackConnection(v_u1.ON_LOCAL_PLAYER, v_u2.onLocalPlayer(function(arg1)
			-- upvalues: (ref) v_u2, (copy) self, (ref) v_u1
			local v_getcharacter = v_u2.getCharacter()
			if v_getcharacter then
				self(v_getcharacter)
			end
			v_u2._connectionUtil:trackConnection(v_u1.CHARACTER_ADDED, arg1.CharacterAdded:Connect(function(arg1)
				-- upvalues: (ref) v_u2, (ref) v_u1
				assert(arg1)
				v_u2._getOrCreateBoundEvent(v_u1.CHARACTER_ADDED):Fire(arg1)
			end))
		end))
		return v_u2._getOrCreateBoundEvent(v_u1.CHARACTER_ADDED).Event:Connect(self)
	end,
	["getChild"] = function(arg1, arg2)
		-- upvalues: (copy) v_u2
		local v_getcharacter = v_u2.getCharacter()
		if v_getcharacter then
			local v1 = v_getcharacter:FindFirstChild(arg1)
			if v1 and v1:IsA(arg2) then
				return v1
			else
				return nil
			end
		else
			return nil
		end
	end,
	["onChild"] = function(arg1, arg2, arg3)
		-- upvalues: (copy) v_u2, (copy) v_u1
		v_u2._connectionUtil:trackConnection(v_u1.ON_CHARACTER, v_u2.onCharacter(function(arg1)
			-- upvalues: (ref) v_u2, (copy) arg1, (copy) arg2, (copy) arg3, (ref) v_u1
			local v_getchild = v_u2.getChild(arg1, arg2)
			if v_getchild then
				arg3(v_getchild)
			end
			v_u2._connectionUtil:trackConnection(v_u1.CHARACTER_CHILD_ADDED, arg1.ChildAdded:Connect(function(arg1)
				-- upvalues: (ref) arg1, (ref) arg2, (ref) v_u2, (ref) v_u1
				if arg1.Name == arg1 and arg1:IsA(arg2) then
					v_u2._getOrCreateBoundEvent(v_u1.CHARACTER_CHILD_ADDED .. arg1 .. arg2):Fire(arg1)
				end
			end))
		end))
		return v_u2._getOrCreateBoundEvent(v_u1.CHARACTER_CHILD_ADDED .. arg1 .. arg2).Event:Connect(arg3)
	end,
	["_getOrCreateBoundEvent"] = function(arg1)
		-- upvalues: (copy) v_u2
		if not v_u2._boundEvents[arg1] then
			v_u2._boundEvents[arg1] = Instance.new("BindableEvent")
		end
		return v_u2._boundEvents[arg1]
	end
}
return v_u2