-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u2 = require(v_replicatedstorage.Controllers.CaseSceneController)
local v_u3 = require(v_replicatedstorage.Controllers.InspectController)
return table.freeze({
	["Name"] = "Last Weapon Used",
	["Group"] = "Gameplay",
	["Category"] = "Weapon Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u2, (copy) v_u3, (copy) v_u1
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		end
		if arg1 ~= Enum.UserInputState.Begin then
			return
		end
		if v_u2.IsActive() or v_u3.IsActive() then
			return
		end
		local v_getpreviousequipped = v_u1.getPreviousEquipped()
		if v_getpreviousequipped then
			local _, v1, v2 = v_u1.getInventoryItemFromLoadout(v_getpreviousequipped.Identifier)
			if v1 and v2 then
				v_u1.equip(v1, v2)
				return
			end
		else
			local v_getcurrentinventory = v_u1.getCurrentInventory()
			local v_getcurrentequipped = v_u1.getCurrentEquipped()
			if v_getcurrentinventory and v_getcurrentequipped then
				local v3 = nil
				local v4 = nil
				for _, v5 in ipairs(v_getcurrentinventory) do
					if #v5._items > 0 then
						for v6, v7 in ipairs(v5._items) do
							if v7.Identifier ~= v_getcurrentequipped.Identifier then
								v3 = v7.Slot
								v4 = v6
								break
							end
						end
					end
				end
				if v3 and v4 then
					v_u1.equip(v3, v4)
				end
			end
		end
	end
})