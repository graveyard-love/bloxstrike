-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = nil
return table.freeze({
	["Name"] = "Team Message",
	["Group"] = "Default",
	["Category"] = "Communication Options",
	["Callback"] = function(arg1, _)
		-- upvalues: (ref) v_u1, (copy) v_u_replicatedstorage, (copy) v_u_localplayer
		if arg1 == Enum.UserInputState.Begin then
			if not v_u1 then
				v_u1 = require(v_u_replicatedstorage.Interface.Screens.Gameplay.Middle.Chat)
			end
			local v_team = v_u_localplayer:GetAttribute("Team")
			v_u1.OpenChat((not v_team or v_team == "Spectators") and 1 or 0)
		end
	end
})