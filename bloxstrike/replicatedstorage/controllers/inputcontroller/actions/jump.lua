-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u1 = require(v_replicatedstorage.Controllers.CharacterController)
local v_u_localplayer = v_players.LocalPlayer
return table.freeze({
	["Name"] = "Jump",
	["Group"] = "Gameplay",
	["Category"] = "Movement Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u1
		if not v_u_localplayer:GetAttribute("IsPlayerChatting") then
			if arg1 == Enum.UserInputState.Begin then
				v_u1.jump()
			end
		end
	end
})