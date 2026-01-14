-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u2 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u3 = require(v_replicatedstorage.Controllers.HintController)
local v_u4 = require(v_replicatedstorage.Database.Security.Router)
local v_u5 = require(v_replicatedstorage.Database.Components.GameState)
local v_u6 = nil
local v_u7 = nil
return table.freeze({
	["Name"] = "Fire",
	["Group"] = "Default",
	["Category"] = "Weapon Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u2, (copy) v_u1, (copy) v_u5, (copy) v_u4, (ref) v_u6, (ref) v_u7, (copy) v_u3, (copy) v_u_run
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		elseif v_u_localplayer:GetAttribute("IsSpectating") and arg1 == Enum.UserInputState.Begin then
			v_u2.Previous()
			return
		elseif v_u2.IsLocalPlayerDead() then
			return
		else
			local v_u_getcurrentequipped = v_u1.getCurrentEquipped()
			if v_u_getcurrentequipped and v_u_localplayer.Character then
				if v_u5.GetState() ~= "Buy Period" then
					v_u4.broadcastRouter("Cancel Defuse Bomb")
					if arg1 == Enum.UserInputState.Begin then
						local v_slot = v_u_getcurrentequipped.Properties.Slot
						if v_u_getcurrentequipped.Properties.Class == "C4" then
							v_u_getcurrentequipped:shoot()
							return
						end
						if v_slot == "Grenade" then
							v_u_getcurrentequipped:StartThrow()
							return
						end
						local v1 = not v_u_getcurrentequipped.IsBurstShooting and (not v_u_getcurrentequipped.IsShooting and v_u_getcurrentequipped.Properties.FireRate)
						if v1 then
							v1 = tick() - v_u_getcurrentequipped.AlternativeSwitchTick > v_u_getcurrentequipped.Properties.FireRate
						end
						if v1 then
							if v_u6 then
								task.cancel(v_u6)
								v_u6 = nil
								v_u7 = nil
							end
							local v2 = v_u_getcurrentequipped.AlternativeShootingOption == "Burst" and 3 or 1
							v_u_getcurrentequipped.IsBurstShooting = v2 == 3
							for _ = 1, v2 do
								v_u_getcurrentequipped:shoot()
								if v_u_getcurrentequipped.Rounds and v_u_getcurrentequipped.Rounds <= 0 then
									v_u3:createHint("Reload")
								end
								task.wait(0.075)
							end
							task.wait(0.15)
							if v_u_getcurrentequipped and v_u_getcurrentequipped.IsBurstShooting then
								v_u_getcurrentequipped.IsBurstShooting = false
								return
							end
						elseif not v_u_getcurrentequipped.Properties.Automatic and (v_u_getcurrentequipped.AlternativeShootingOption == "Default" and (v_u_getcurrentequipped.IsShooting and v_u7 ~= v_u_getcurrentequipped.Identifier)) then
							if v_u6 then
								task.cancel(v_u6)
							end
							local v_max = math.max(0, (v_u_getcurrentequipped.Properties.FireRate or 0.15) - (tick() - v_u_getcurrentequipped.ShootRequestTick))
							if v_max <= 0.15 then
								v_u7 = v_u_getcurrentequipped.Identifier
								v_u6 = task.delay(v_max, function()
									-- upvalues: (ref) v_u_run, (ref) v_u6, (ref) v_u7, (ref) v_u1, (copy) v_u_getcurrentequipped, (ref) v_u3
									v_u_run.Heartbeat:Wait()
									v_u_run.Heartbeat:Wait()
									v_u6 = nil
									v_u7 = nil
									local v_getcurrentequipped = v_u1.getCurrentEquipped()
									if v_getcurrentequipped then
										if v_getcurrentequipped.Identifier == v_u_getcurrentequipped.Identifier then
											if v_getcurrentequipped.Properties.Automatic then
												return
											elseif v_getcurrentequipped.AlternativeShootingOption == "Burst" then
												return
											elseif v_getcurrentequipped.Rounds <= 0 then
												v_u3:createHint("Reload")
											else
												v_getcurrentequipped:shoot()
											end
										else
											return
										end
									else
										return
									end
								end)
								return
							end
						end
					else
						if arg1 == Enum.UserInputState.End and v_u_getcurrentequipped.Properties.Class == "C4" then
							v_u_getcurrentequipped:cancel()
							return
						end
						if v_u_getcurrentequipped.Properties.Slot == "Grenade" and arg1 == Enum.UserInputState.End then
							if v_u_getcurrentequipped.ThrowStarted and not v_u_getcurrentequipped.ThrowFinished then
								v_u_getcurrentequipped:Throw("Far")
							end
							return
						end
					end
				end
			else
				return
			end
		end
	end
})