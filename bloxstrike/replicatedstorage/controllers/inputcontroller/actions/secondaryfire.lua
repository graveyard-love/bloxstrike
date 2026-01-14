-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u2 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u3 = require(v_replicatedstorage.Database.Components.GameState)
local v_u4 = {
	["ToggleScope"] = true
}
return table.freeze({
	["Name"] = "Secondary Fire",
	["Group"] = "Default",
	["Category"] = "Weapon Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u2, (copy) v_u1, (copy) v_u3, (copy) v_u4
		if v_u_localplayer:GetAttribute("IsSpectating") and arg1 == Enum.UserInputState.Begin then
			v_u2.Next()
			return
		elseif v_u2.IsLocalPlayerDead() then
			return
		else
			local v_getcurrentequipped = v_u1.getCurrentEquipped()
			if v_u_localplayer.Character and v_getcurrentequipped then
				if not v_getcurrentequipped or (v_getcurrentequipped.Properties.Slot ~= "Grenade" or v_u3.GetState() ~= "Buy Period") then
					if arg1 == Enum.UserInputState.Begin then
						if v_getcurrentequipped.Properties.Class == "Grenade" then
							if v_u3.GetState() ~= "Buy Period" then
								v_getcurrentequipped:StartThrow()
								return
							end
						else
							if v_getcurrentequipped.Properties.HasScope then
								v_getcurrentequipped:scope(v_u4.ToggleScope)
								return
							end
							if v_getcurrentequipped.Properties.HasSuppressor then
								if v_getcurrentequipped.IsSuppressed then
									v_getcurrentequipped:removeSuppressor()
								else
									v_getcurrentequipped:addSuppressor()
								end
							end
							if v_getcurrentequipped.Properties.ShootingOptions == "Burst" then
								v_getcurrentequipped:updateFireMode()
								return
							end
							if v_getcurrentequipped.Properties.Type == "Equipment" and v_u3.GetState() ~= "Buy Period" then
								v_getcurrentequipped:shoot(true)
								return
							end
						end
					else
						if v_getcurrentequipped.Properties.HasScope and (not v_u4.ToggleScope and arg1 == Enum.UserInputState.End) then
							v_getcurrentequipped:unscope()
							return
						end
						if v_getcurrentequipped.Properties.Slot == "Grenade" and arg1 == Enum.UserInputState.End then
							if v_u3.GetState() == "Buy Period" then
								return
							end
							if v_getcurrentequipped.ThrowStarted and not v_getcurrentequipped.ThrowFinished then
								v_getcurrentequipped:Throw("Near")
							end
						end
					end
				end
			else
				return
			end
		end
	end
})