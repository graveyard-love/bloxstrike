-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Interface.Screens.Menu.Top)
return table.freeze({
	["Name"] = "Main Menu",
	["Group"] = "Default",
	["Category"] = "UI Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u1
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		else
			local v_isspectating = v_u_localplayer:GetAttribute("IsSpectating")
			local v_team = v_u_localplayer:GetAttribute("Team")
			if (v_team == "Counter-Terrorists" or v_team == "Terrorists") and true or v_isspectating == true then
				if arg1 == Enum.UserInputState.Begin then
					v_u1.ToggleMenu()
				end
			end
		end
	end
})