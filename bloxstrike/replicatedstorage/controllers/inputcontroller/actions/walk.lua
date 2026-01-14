-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u1 = require(v_replicatedstorage.Controllers.CharacterController)
local v_u_localplayer = v_players.LocalPlayer
return table.freeze({
	["Name"] = "Walk",
	["Group"] = "Default",
	["Category"] = "Movement Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u1
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		else
			local v_character = v_u_localplayer.Character
			local v1
			if v_character and v_character:IsDescendantOf(workspace) then
				local v_humanoid = v_character:WaitForChild("Humanoid")
				v1 = v_humanoid and v_humanoid.Health > 0 and true or false
			else
				v1 = false
			end
			if v1 then
				if arg1 == Enum.UserInputState.Begin then
					v_u1.walk(true)
					return
				elseif arg1 == Enum.UserInputState.End then
					v_u1.walk(false)
				end
			else
				return
			end
		end
	end
})