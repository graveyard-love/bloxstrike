-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Interface.Screens.Gameplay.Middle.TeamSelection)
return table.freeze({
	["Name"] = "Choose Team",
	["Group"] = "Default",
	["Category"] = "UI Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u1
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		elseif arg1 == Enum.UserInputState.Begin then
			local v_isspectating = v_u_localplayer:GetAttribute("IsSpectating")
			local v_team = v_u_localplayer:GetAttribute("Team")
			if (v_team == "Counter-Terrorists" or v_team == "Terrorists") and true or v_isspectating == true then
				if v_isspectating then
					v_u1.openFrame()
					return
				elseif v_u_localplayer.Character then
					v_u1.ToggleTeamSelection()
				end
			else
				return
			end
		else
			return
		end
	end
})