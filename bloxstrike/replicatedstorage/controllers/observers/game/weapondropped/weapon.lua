-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u3 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u4 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
local v_u5 = require(v_replicatedstorage.Shared.Janitor)
local v_u6 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u7 = require(v_replicatedstorage.Database.Security.Router)
local v_u8 = require(v_replicatedstorage.Database.Custom.GameStats.NumberSlots)
local v_u9 = require(v_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u10 = require(v_replicatedstorage.Database.Custom.GameStats.Grenades)
local v_u_current_camera = workspace.CurrentCamera
local v_u_localplayer = v_players.LocalPlayer
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local v_u11 = {
	["ProximityRange"] = 6
}
function v_u1.autoPickup(arg1)
	-- upvalues: (copy) v_u3, (copy) v_u8, (copy) v_u2, (copy) v_u10, (copy) v_u4, (copy) v_u9, (copy) v_u_localplayer, (copy) v_u7, (copy) v_u6
	local v_weapon = arg1.Model:GetAttribute("Weapon")
	if v_weapon then
		local v1 = v_u3(v_weapon)
		if v1 then
			local v2 = v_u8[v1.Slot]
			if v2 then
				local v_getinventoryslot = v_u2.getInventorySlot(v2)
				local v3 = v_u10[v_weapon]
				local v4
				if v3 then
					local v5 = 0
					if v_getinventoryslot then
						for _, v6 in ipairs(v_getinventoryslot._items) do
							if v6.Name == v_weapon then
								v5 = v5 + 1
							end
						end
					else
						v5 = 0
					end
					if v3 <= v5 then
						v4 = true
					else
						v4 = false
					end
				else
					v4 = false
				end
				if v4 then
					return
				else
					if v_getinventoryslot then
						v_getinventoryslot = #v_getinventoryslot._items < v_getinventoryslot._settings._strict_slot_space
					end
					if v_getinventoryslot then
						if arg1.Model:GetAttribute("CanPickup") then
							local v_name = arg1.Model.Name
							if not arg1.SentPickupRequest then
								arg1.SentPickupRequest = true
								local v_getskininformation = v_u4.GetSkinInformation(arg1.Weapon, arg1.Skin)
								assert(v_getskininformation, "Skin data not found for weapon: " .. arg1.Weapon .. " and skin: " .. arg1.Skin)
								local v7 = v_u9[v_getskininformation.rarity]
								local v_floor = math.floor(v7.Color.R * 255)
								local v_floor = math.floor(v7.Color.G * 255)
								local v_floor = math.floor(v7.Color.B * 255)
								if arg1.Weapon == "C4" and v_u_localplayer:GetAttribute("Team") ~= "Terrorists" then
									return
								end
								v_u7.broadcastRouter("CreateNotification", "Item Picked Up", ("You picked up a <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v_floor, v_floor, v_floor, arg1.Weapon, arg1.Skin), 2)
								v_u6.Inventory.PickupWeapon.Send({
									["Identity"] = v_name
								})
							end
						end
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
function v_u1.updateState(arg1, arg2)
	-- upvalues: (copy) v_u_new, (copy) v_u_localplayer, (copy) v_u_current_camera, (copy) v_u11
	arg1.AlphaTime = arg1.AlphaTime + arg2
	if arg1.Model.PrimaryPart then
		v_u_new.FilterDescendantsInstances = { v_u_localplayer.Character, v_u_current_camera }
		local v_raycast = workspace:Raycast(v_u_current_camera.CFrame.Position, v_u_current_camera.CFrame.LookVector * 10, v_u_new)
		if v_raycast then
			v_raycast = v_raycast.Instance:IsDescendantOf(arg1.Model)
		end
		local v1 = v_raycast and "Hovering"
		local v_character = v_u_localplayer.Character
		if v_character then
			v_character = v_u_localplayer.Character.PrimaryPart
		end
		local v2 = v_character and (v_character.Position - arg1.Model.PrimaryPart.Position).Magnitude <= v_u11.ProximityRange and (v1 or "Proximity") or v1
		if arg1.Weapon == "C4" then
			local v_team = v_u_localplayer:GetAttribute("Team")
			if arg1.AlphaTime >= 1 then
				local v_flashinglight = arg1.Model.Weapon:FindFirstChild("FlashingLight")
				arg1.AlphaTime = 0
				if v_flashinglight then
					v_flashinglight.Attachment.PointLight.Enabled = not v_flashinglight.Attachment.PointLight.Enabled
					v_flashinglight.Attachment.PointLight.Color = Color3.fromRGB(255, 255, 15)
					v_flashinglight.Attachment.PointLight.Brightness = 5
				end
			end
			if v_team ~= "Terrorists" then
				v2 = false
			end
		end
		if v2 == "Hovering" or v2 == "Proximity" then
			arg1.Model:SetAttribute("HoveringState", v2)
			arg1.Model:AddTag("IsHoveringInteractable")
			if v2 == "Proximity" then
				arg1:autoPickup()
				return
			end
		else
			arg1.Model:RemoveTag("IsHoveringInteractable")
			arg1.Model:SetAttribute("HoveringState", nil)
		end
	end
end
function v_u1.new(arg1)
	-- upvalues: (copy) v_u1, (copy) v_u5, (copy) v_u_run
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u5.new()
	v_u1.Model = arg1
	v_u1.AlphaTime = 0
	v_u1.Weapon = v_u1.Model:GetAttribute("Weapon")
	v_u1.Skin = v_u1.Model:GetAttribute("Skin")
	v_u1.SentPickupRequest = false
	v_u1.Janitor:Add(v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		if v_u1.Model and v_u1.Model.PrimaryPart then
			v_u1:updateState(arg1)
		end
	end))
	return v_u1
end
function v_u1.destroy(arg1)
	arg1.Janitor:Destroy()
end
return v_u1