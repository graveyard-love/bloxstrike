-- Decompiled with Bunni.lol Decompiler

game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
return table.freeze({
	["Name"] = "Health Shot",
	["Group"] = "Gameplay",
	["Category"] = "Weapon Keys",
	["Callback"] = function(_, _)
		-- upvalues: (copy) v_u_localplayer
		if not v_u_localplayer:GetAttribute("IsPlayerChatting") then
		end
	end
})