-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Interface.Screens.Gameplay.Middle.BuyMenu)
return table.freeze({
	["Name"] = "Buy Menu",
	["Group"] = "Gameplay",
	["Category"] = "Weapon Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u1
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		elseif arg1 == Enum.UserInputState.Begin then
			local v_character = v_u_localplayer.Character
			if v_character and v_character:IsDescendantOf(workspace) then
				local v_humanoid = v_character:FindFirstChild("Humanoid")
				if v_humanoid and v_humanoid.Health > 0 then
					v_u1.toggleFrame()
					return
				end
			end
		end
	end
})