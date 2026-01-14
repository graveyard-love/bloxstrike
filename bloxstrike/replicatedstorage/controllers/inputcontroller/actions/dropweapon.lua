-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u2 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u3 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
local v_u4 = require(v_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u5 = require(v_replicatedstorage.Database.Security.Router)
return table.freeze({
	["Name"] = "Drop Weapon",
	["Group"] = "Gameplay",
	["Category"] = "Weapon Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u2, (copy) v_u1, (copy) v_u3, (copy) v_u4, (copy) v_u5
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		elseif arg1 == Enum.UserInputState.Begin then
			if v_u2.IsLocalPlayerDead() then
				return
			else
				local v_getcurrentequipped = v_u1.getCurrentEquipped()
				if v_getcurrentequipped then
					local v_getskininformation = v_u3.GetSkinInformation(v_getcurrentequipped.Name, v_getcurrentequipped.Skin)
					if v_getskininformation then
						local v1 = v_u4[v_getskininformation.rarity]
						local v_floor = math.floor(v1.Color.R * 255)
						local v_floor = math.floor(v1.Color.G * 255)
						local v_floor = math.floor(v1.Color.B * 255)
						if v_getcurrentequipped:drop() then
							v_u5.broadcastRouter("CreateNotification", "Item Dropped", ("You dropped your <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v_floor, v_floor, v_floor, v_getcurrentequipped.Name, v_getcurrentequipped.Skin), 2)
							return
						end
					end
				end
			end
		else
			return
		end
	end
})