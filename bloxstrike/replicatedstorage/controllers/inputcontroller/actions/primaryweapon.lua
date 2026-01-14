-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u2 = require(v_replicatedstorage.Controllers.HintController)
local v_u3 = require(v_replicatedstorage.Controllers.CaseSceneController)
local v_u4 = require(v_replicatedstorage.Controllers.InspectController)
local v_u5 = require(v_replicatedstorage.Components.Common.UserInput.EquipInventorySlot)
return table.freeze({
	["Name"] = "Primary Weapon",
	["Group"] = "Gameplay",
	["Category"] = "Weapon Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u3, (copy) v_u4, (copy) v_u1, (copy) v_u2, (copy) v_u5
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		elseif arg1 == Enum.UserInputState.Begin then
			if v_u3.IsActive() or v_u4.IsActive() then
				return
			elseif v_u1.getCurrentEquipped() then
				v_u2:clearHint("Reload")
				v_u5(1)
			end
		else
			return
		end
	end
})