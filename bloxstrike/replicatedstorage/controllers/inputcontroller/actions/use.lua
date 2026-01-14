-- Decompiled with Bunni.lol Decompiler

local v_u_run = game:GetService("RunService")
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_collection = game:GetService("CollectionService")
local v_u_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
require(script.Parent.Parent.Types)
local v_u_localplayer = v_u_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u2 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v3 = require(v_replicatedstorage.Components.Common.GetUserPlatform)
local v_u4 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
local v_u5 = require(v_replicatedstorage.Database.Custom.GameStats.NumberSlots)
local v_u6 = require(v_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u7 = require(v_replicatedstorage.Database.Custom.GameStats.Grenades)
local v_u8 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u9 = require(v_replicatedstorage.Database.Security.Router)
local v_u_current_camera = workspace.CurrentCamera
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local v_u10
if table.find(v3(), "Mobile") == nil then
	v_u10 = false
else
	v_u10 = #v3() <= 1
end
local v_u11 = nil
local v_u12 = nil
local v_u13 = false
local v_u14 = nil
local v_u15 = {
	["UserInputType"] = Enum.UserInputType.Touch
}
local v_u16 = nil
local function v_u17(arg1)
	-- upvalues: (copy) v_u_players, (copy) v_u_localplayer
	if not (arg1 and arg1.Parent) then
		return false
	end
	local v_parent = arg1.Parent
	local v_humanoid = v_parent:FindFirstChildOfClass("Humanoid")
	if not v_humanoid or v_humanoid.Health <= 0 then
		return false
	end
	local v_getplayerfromcharacter = v_u_players:GetPlayerFromCharacter(v_parent)
	if not v_getplayerfromcharacter then
		return false
	end
	local v_team = v_u_localplayer:GetAttribute("Team")
	local v_team = v_getplayerfromcharacter:GetAttribute("Team")
	if v_team then
		v_team = v_team ~= v_team
	end
	return v_team
end
local function v_u18(arg1, arg2)
	-- upvalues: (copy) v_u_localplayer
	local v_character = v_u_localplayer.Character
	if v_character and v_character.PrimaryPart then
		local v_hoveringstate = arg1:GetAttribute("HoveringState")
		local v_hoveringstate = arg2:GetAttribute("HoveringState")
		if v_hoveringstate == "Hovering" then
			return true
		elseif v_hoveringstate == "Hovering" then
			return false
		else
			local v_canpickup = arg1:GetAttribute("CanPickup")
			local v_canpickup = arg2:GetAttribute("CanPickup")
			if v_canpickup == false then
				return false
			elseif v_canpickup == false then
				return true
			elseif arg1.PrimaryPart and arg2.PrimaryPart then
				return (v_character.PrimaryPart.Position - arg1.PrimaryPart.Position).Magnitude < (v_character.PrimaryPart.Position - arg2.PrimaryPart.Position).Magnitude
			else
				return false
			end
		end
	else
		return false
	end
end
local function v_u19()
	-- upvalues: (copy) v_u_current_camera, (copy) v_u_localplayer, (copy) v_u_new
	if not (v_u_current_camera and v_u_localplayer.Character) then
		return nil
	end
	if v_u_localplayer:GetAttribute("Team") ~= "Counter-Terrorists" then
		return nil
	end
	v_u_new.FilterDescendantsInstances = { v_u_localplayer.Character, v_u_current_camera }
	local v_raycast = workspace:Raycast(v_u_current_camera.CFrame.Position, v_u_current_camera.CFrame.LookVector * 5, v_u_new)
	if v_raycast then
		local v_instance = v_raycast.Instance
		if v_instance and (v_instance.Parent and v_instance.Parent:HasTag("Hostage")) or false then
			local v_parent = v_raycast.Instance.Parent
			if v_parent and v_parent:GetAttribute("CanRescue") == true then
				local v_rescuingplayer = v_parent:GetAttribute("RescuingPlayer")
				if v_rescuingplayer and v_rescuingplayer ~= v_u_localplayer.Name then
					return nil
				elseif v_parent:GetAttribute("CarryingPlayer") then
					return nil
				else
					return v_parent
				end
			end
		end
	end
	return nil
end
local function v_u20()
	-- upvalues: (copy) v_u_current_camera, (copy) v_u_localplayer, (copy) v_u_new, (copy) v_u17
	if v_u_current_camera and v_u_localplayer.Character then
		v_u_new.FilterDescendantsInstances = { v_u_localplayer.Character, v_u_current_camera }
		local v_raycast = workspace:Raycast(v_u_current_camera.CFrame.Position, v_u_current_camera.CFrame.LookVector * 180, v_u_new)
		if v_raycast then
			if v_u17(v_raycast.Instance) then
				return v_raycast.Instance.Parent
			else
				return nil
			end
		else
			return nil
		end
	else
		return nil
	end
end
task.defer(function()
	-- upvalues: (ref) v_u16, (copy) v_u10, (ref) v_u14, (copy) v_u_run, (copy) v_u20, (copy) v_u1, (copy) v_u_current_camera, (ref) v_u11, (ref) v_u12, (copy) v_u15, (ref) v_u13
	v_u16 = require(script.Parent.Fire).Callback
	if v_u10 then
		if not v_u14 then
			v_u14 = v_u_run.RenderStepped:Connect(function()
				-- upvalues: (ref) v_u20, (ref) v_u1, (ref) v_u_current_camera, (ref) v_u11, (ref) v_u12, (ref) v_u16, (ref) v_u15, (ref) v_u13
				local v1 = v_u20()
				local v2 = v1 ~= nil
				local v_getcurrentequipped = v_u1.getCurrentEquipped()
				if not v_getcurrentequipped or v_getcurrentequipped.Properties.Class ~= "Weapon" then
					v2 = false
				end
				local v3 = tick()
				if v2 then
					local v_max = math.max(0.1 - math.clamp((not (v1 and (v1.PrimaryPart and v_u_current_camera)) and 180 or (v_u_current_camera.CFrame.Position - v1.PrimaryPart.Position).Magnitude) / 180, 0, 1) * 0.07500000000000001, 0.025)
					if not v_u11 then
						v_u11 = v3
					end
					if v_max <= v3 - v_u11 and ((not v_u12 or (v_getcurrentequipped.Properties.FireRate or 0.15) <= v3 - v_u12) and v_u16) then
						v_u16(Enum.UserInputState.Begin, v_u15)
						v_u12 = v3
					end
				else
					v_u11 = nil
					v_u12 = nil
					if v_u13 and v_u16 then
						v_u16(Enum.UserInputState.End, v_u15)
					end
				end
				v_u13 = v2
			end)
		end
	else
		return
	end
end)
v_u_localplayer.CharacterRemoving:Connect(function()
	-- upvalues: (copy) v_u10, (ref) v_u14, (ref) v_u13, (ref) v_u16, (copy) v_u15, (ref) v_u11, (ref) v_u12
	if v_u10 then
		if v_u14 then
			v_u14:Disconnect()
			v_u14 = nil
		end
		if v_u13 then
			if v_u16 then
				v_u16(Enum.UserInputState.End, v_u15)
			end
			v_u13 = false
		end
		v_u11 = nil
		v_u12 = nil
	end
end)
v_u_localplayer.CharacterAdded:Connect(function()
	-- upvalues: (copy) v_u10, (ref) v_u16, (ref) v_u14, (copy) v_u_run, (copy) v_u20, (copy) v_u1, (copy) v_u_current_camera, (ref) v_u11, (ref) v_u12, (copy) v_u15, (ref) v_u13
	if v_u10 and v_u16 then
		if not v_u14 then
			v_u14 = v_u_run.RenderStepped:Connect(function()
				-- upvalues: (ref) v_u20, (ref) v_u1, (ref) v_u_current_camera, (ref) v_u11, (ref) v_u12, (ref) v_u16, (ref) v_u15, (ref) v_u13
				local v1 = v_u20()
				local v2 = v1 ~= nil
				local v_getcurrentequipped = v_u1.getCurrentEquipped()
				if not v_getcurrentequipped or v_getcurrentequipped.Properties.Class ~= "Weapon" then
					v2 = false
				end
				local v3 = tick()
				if v2 then
					local v_max = math.max(0.1 - math.clamp((not (v1 and (v1.PrimaryPart and v_u_current_camera)) and 180 or (v_u_current_camera.CFrame.Position - v1.PrimaryPart.Position).Magnitude) / 180, 0, 1) * 0.07500000000000001, 0.025)
					if not v_u11 then
						v_u11 = v3
					end
					if v_max <= v3 - v_u11 and ((not v_u12 or (v_getcurrentequipped.Properties.FireRate or 0.15) <= v3 - v_u12) and v_u16) then
						v_u16(Enum.UserInputState.Begin, v_u15)
						v_u12 = v3
					end
				else
					v_u11 = nil
					v_u12 = nil
					if v_u13 and v_u16 then
						v_u16(Enum.UserInputState.End, v_u15)
					end
				end
				v_u13 = v2
			end)
		end
	else
		return
	end
end)
return table.freeze({
	["Category"] = "Weapon Keys",
	["Callback"] = function(arg1, _)
		-- upvalues: (copy) v_u_localplayer, (copy) v_u_collection, (copy) v_u9, (copy) v_u19, (copy) v_u18, (copy) v_u7, (copy) v_u2, (copy) v_u5, (copy) v_u1, (copy) v_u4, (copy) v_u6, (copy) v_u8
		if v_u_localplayer:GetAttribute("IsPlayerChatting") then
			return
		elseif v_u_localplayer.Character then
			if arg1 == Enum.UserInputState.Begin then
				local v1 = v_u_collection:GetTagged("Bomb")[1]
				if v1 and (v1:GetAttribute("CanDefuse") and not v1:GetAttribute("Defused")) then
					v_u9.broadcastRouter("Start Defuse Bomb")
					return
				end
				local v2 = v_u19()
				if v2 then
					local v_team = v_u_localplayer:GetAttribute("Team")
					if not v_u_localplayer:GetAttribute("IsCarryingHostage") and (not v_u_localplayer:GetAttribute("IsRescuingHostage") and v_team == "Counter-Terrorists") then
						local v_rescuingplayer = v2:GetAttribute("RescuingPlayer")
						local v_carryingplayer = v2:GetAttribute("CarryingPlayer")
						if (not v_rescuingplayer or v_rescuingplayer == v_u_localplayer.Name) and not v_carryingplayer then
							v_u9.broadcastRouter("Start Rescue Hostage")
							return
						end
					end
				end
				local v_gettagged = v_u_collection:GetTagged("IsHoveringInteractable")
				if #v_gettagged == 0 then
					return
				end
				table.sort(v_gettagged, v_u18)
				local v3 = v_gettagged[1]
				local v_weapon = v3:GetAttribute("Weapon")
				local v_skin = v3:GetAttribute("Skin")
				if v_weapon == "C4" and v_u_localplayer:GetAttribute("Team") ~= "Terrorists" then
					return
				end
				if v_u7[v_weapon] ~= nil then
					local v4 = v_u2(v_weapon)
					if v4 then
						local v_getinventoryslot = v_u1.getInventorySlot(v_u5[v4.Slot])
						if v_getinventoryslot then
							local v5 = 0
							for _, v6 in ipairs(v_getinventoryslot._items) do
								if v6.Name == v_weapon then
									v5 = v5 + 1
								end
							end
							if v_u7[v_weapon] <= v5 or #v_getinventoryslot._items >= v_getinventoryslot._settings._strict_slot_space then
								return
							end
						end
					end
				end
				if v3:GetAttribute("CanPickup") then
					local v_getskininformation = v_u4.GetSkinInformation(v_weapon, v_skin)
					if v_getskininformation then
						local v7 = v_u6[v_getskininformation.rarity]
						local v_floor = math.floor(v7.Color.R * 255)
						local v_floor = math.floor(v7.Color.G * 255)
						local v_floor = math.floor(v7.Color.B * 255)
						v_u9.broadcastRouter("CreateNotification", "Item Picked Up", ("You picked up a <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v_floor, v_floor, v_floor, v_weapon, v_skin), 2)
					end
					v_u8.Inventory.PickupWeapon.Send({
						["Identity"] = v3.Name
					})
					return
				end
			elseif arg1 == Enum.UserInputState.End then
				if v_u_collection:GetTagged("Bomb")[1] and v_u_localplayer:GetAttribute("IsDefusingBomb") then
					v_u9.broadcastRouter("Cancel Defuse Bomb")
					return
				end
				if v_u_localplayer:GetAttribute("IsRescuingHostage") then
					v_u9.broadcastRouter("Cancel Rescue Hostage")
					return
				end
			end
		end
	end,
	["Group"] = "Gameplay",
	["Name"] = "Use"
})