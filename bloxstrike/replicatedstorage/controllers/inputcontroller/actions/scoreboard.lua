-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Interface.Screens.Gameplay.Middle.Leaderboard)
return table.freeze({
	["Name"] = "Scoreboard",
	["Group"] = "Default",
	["Category"] = "UI Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u1
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		elseif arg1 == Enum.UserInputState.Begin then
			v_u1.openFrame()
			return
		elseif arg1 == Enum.UserInputState.End then
			v_u1.closeFrame()
		end
	end
})