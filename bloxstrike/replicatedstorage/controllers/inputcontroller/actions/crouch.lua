-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Controllers.CharacterController)
return table.freeze({
	["Name"] = "Crouch",
	["Group"] = "Gameplay",
	["Category"] = "Movement Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u1
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		elseif arg1 == Enum.UserInputState.Begin then
			v_u1.crouch(true)
			return
		elseif arg1 == Enum.UserInputState.End then
			v_u1.crouch(false)
		end
	end
})