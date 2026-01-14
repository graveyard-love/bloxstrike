-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Components.Common.UserInput.EquipSlotRight)
local v_u2 = require(v_replicatedstorage.Controllers.HintController)
local v_u3 = require(v_replicatedstorage.Controllers.CaseSceneController)
local v_u4 = require(v_replicatedstorage.Controllers.InspectController)
return table.freeze({
	["Name"] = "Cycle Weapons Right",
	["Group"] = "Gameplay",
	["Category"] = "Weapon Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u3, (copy) v_u4, (copy) v_u1, (copy) v_u2
		if v_u_localplayer:GetAttribute("IsPlayerChatting") or arg1 ~= Enum.UserInputState.Begin then
			return
		elseif not (v_u3.IsActive() or v_u4.IsActive()) then
			v_u1()
			v_u2:clearHint("Reload")
		end
	end
})