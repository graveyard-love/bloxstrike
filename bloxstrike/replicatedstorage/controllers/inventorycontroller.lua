-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
local v_players = game:GetService("Players")
require(v_u_replicatedstorage.Database.Custom.Types)
local v_u2 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u3 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u4 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u5 = require(v_u_replicatedstorage.Database.Security.Router)
local v6 = require(v_u_replicatedstorage.Packages.Signal)
local v_u7 = require(v_u_replicatedstorage.Classes.Loadout)
local v_u8 = require(v_u_replicatedstorage.Database.Custom.Constants)
local v_u9 = require(v_u_replicatedstorage.Components.Common.VFXLibary.CreateMuzzleFlash.Character)
local v_u10 = require(v_u_replicatedstorage.Components.Common.VFXLibary.CreateTracer)
local v_u11 = require(v_u_replicatedstorage.Components.Common.VFXLibary.CreateMarker)
local v_u12 = require(v_u_replicatedstorage.Components.Common.VFXLibary.CreateImpact)
local v_u13 = require(v_u_replicatedstorage.Components.Common.VFXLibary.BreakGlass)
local v_u14 = require(v_u_replicatedstorage.Components.Common.VFXLibary.CreateVoxelSmoke)
local v_u15 = require(v_u_replicatedstorage.Components.Common.VFXLibary.CreateVoxelFire)
local v_u16 = require(v_u_replicatedstorage.Components.Common.VFXLibary.FlashEffect)
local v_u17 = require(v_u_replicatedstorage.Components.Common.CreateRagdoll)
local v_u18 = require(v_u_replicatedstorage.Components.Common.RecycleFX)
local v_u_new = v6.new()
v_u1.OnInventoryItemEquipped = v_u_new
local v_u_new = v6.new()
v_u1.OnInventoryChanged = v_u_new
local v_u_localplayer = v_players.LocalPlayer
local v_u19 = nil
local v_u20 = true
local v_u21 = 0
local function v_u22()
	local v_debris = workspace:FindFirstChild("Debris")
	if v_debris then
		for _, v1 in ipairs(v_debris:GetChildren()) do
			if v1:HasTag("Ragdoll") then
				v1:Destroy()
			end
		end
	end
end
function v_u1.GetInventoryItemFromIdentifier(arg1, arg2)
	-- upvalues: (copy) v_u3
	local v_get = v_u3.Get(arg1, "Inventory")
	if not v_get then
		return nil
	end
	for _, v1 in ipairs(v_get) do
		if v1._id == arg2 then
			return v1
		end
	end
	return nil
end
function v_u1.GetEquippedInventoryItem(arg1, arg2)
	-- upvalues: (copy) v_u3
	local v_team = arg1:GetAttribute("Team")
	if not v_team or v_team ~= "Counter-Terrorists" and v_team ~= "Terrorists" then
		return nil
	end
	local v_get, v1 = v_u3.Get(arg1, "Inventory", "Loadout")
	if not (v_get and v1) then
		return nil
	end
	local v2 = v1[v_team]
	for _, v3 in ipairs(string.split(arg2, ".")) do
		local v4 = tonumber(v3) or v3
		if v2 then
			v2 = v2[v4]
		end
		if not v2 then
			return nil
		end
	end
	for _, v5 in ipairs(v_get) do
		if v5._id == v2 then
			return v5
		end
	end
	return nil
end
function v_u1.getInventorySlot(arg1)
	-- upvalues: (ref) v_u19
	if v_u19 then
		return v_u19.Inventory[arg1]
	else
		return nil
	end
end
function v_u1.getPreviousEquipped()
	-- upvalues: (ref) v_u19
	if v_u19 then
		return v_u19.PreviousEquipped
	else
		return nil
	end
end
function v_u1.getCurrentEquipped()
	-- upvalues: (ref) v_u19
	if v_u19 then
		return v_u19.CurrentEquipped
	else
		return nil
	end
end
function v_u1.getCurrentInventory()
	-- upvalues: (ref) v_u19
	if v_u19 then
		return v_u19.Inventory
	else
		return nil
	end
end
function v_u1.getInventoryItemFromLoadout(arg1)
	-- upvalues: (ref) v_u19
	if v_u19 then
		return v_u19:getInventoryItemFromLoadout(arg1)
	else
		return nil
	end
end
function v_u1.UpdateStatTrack(_)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u1
	local v_character = v_u_localplayer.Character
	local v1
	if v_character and v_character:IsDescendantOf(workspace) then
		local v_humanoid = v_character:FindFirstChild("Humanoid")
		v1 = v_humanoid and v_humanoid.Health > 0 and true or false
	else
		v1 = false
	end
	if v1 then
		local v_getcurrentinventory = v_u1.getCurrentInventory()
		if not v_getcurrentinventory then
			return
		end
		for _, v2 in pairs(v_getcurrentinventory) do
			for _, v3 in pairs(v2._items) do
				local v_getinventoryitemfromidentifier = v_u1.GetInventoryItemFromIdentifier(v_u_localplayer, v3._id)
				if v_getinventoryitemfromidentifier then
					v3:updateStatTrackCounter(v_getinventoryitemfromidentifier.StatTrack)
				end
			end
		end
	end
end
local function v_u23(arg1, arg2, arg3)
	-- upvalues: (ref) v_u19, (copy) v_u_replicatedstorage, (copy) v_u2, (copy) v_u8, (copy) v_u4, (ref) v_u21, (copy) v_u_new
	if v_u19 then
		local v1 = v_u19.Inventory[arg1]
		if not v1 then
			return
		end
		local v2 = v1._items[arg2]
		if not v2 then
			return
		end
		local v_currentequipped = v_u19.CurrentEquipped
		local v3
		if v_currentequipped then
			v3 = v_currentequipped.Identifier
		else
			v3 = v_currentequipped
		end
		if v_currentequipped and v2.Identifier == v_currentequipped.Identifier then
			return
		end
		if v_currentequipped then
			v_currentequipped:unequip()
		end
		v_u19:setCurrentEquipped(v2)
		local v_currentequipped = v_u19.CurrentEquipped
		if v_currentequipped then
			if not require(v_u_replicatedstorage.Controllers.CaseSceneController).IsActive() then
				v_u2.updateCameraFOV(v_u8.DEFAULT_CAMERA_FOV)
			end
			v_currentequipped:equip()
			if arg3 then
				v_u4.Inventory.WeaponEquipped.Send({
					["Identifier"] = v_currentequipped.Identifier,
					["PreviousIdentifier"] = v3
				})
			end
		end
		v_u21 = tick()
		if v_u19.CurrentEquipped then
			v_u_new:Fire(arg2, v_u19.CurrentEquipped)
		end
	end
end
function v_u1.equip(arg1, arg2)
	-- upvalues: (ref) v_u21, (copy) v_u23
	if tick() - v_u21 > 0 then
		v_u23(arg1, arg2, true)
	end
end
function v_u1.equipLocal(arg1, arg2)
	-- upvalues: (copy) v_u23
	v_u23(arg1, arg2, false)
end
function v_u1.removeInventoryItem(arg1)
	-- upvalues: (ref) v_u19, (copy) v_u1, (copy) v_u_new
	if v_u19 then
		v_u19:removeInventoryItem(arg1)
		local v1 = not v_u19.CurrentEquipped and v_u19:getNextInventorySlotFromPriority()
		if v1 then
			v_u1.equip(v1, 1)
		end
		v_u_new:Fire(v_u19.Inventory)
	end
end
function v_u1.newInventoryItem(arg1)
	-- upvalues: (ref) v_u19, (copy) v_u1, (copy) v_u_new
	if v_u19 then
		v_u19:grantPlayerInventoryItem(arg1.slot, arg1.identifier, arg1._id, arg1.weapon, arg1.skin, arg1.Float, arg1.StatTrack, arg1.NameTag, arg1.OriginalOwner, arg1.Charm, arg1.Stickers, arg1.customProperties)
		if arg1.shouldEquip then
			local _, v1, v2 = v_u19:getInventoryItemFromLoadout(arg1.identifier)
			if v1 and v2 then
				v_u1.equipLocal(v1, v2)
			else
				warn((("[InventoryController] Could not find item %* in loadout!"):format(arg1.identifier)))
			end
		else
			local v3 = not v_u19.CurrentEquipped and v_u19:getNextInventorySlotFromPriority()
			if v3 then
				v_u1.equip(v3, 1)
			end
		end
		v_u_new:Fire(v_u19.Inventory)
	end
end
local function v_u24()
	-- upvalues: (ref) v_u19, (ref) v_u21, (copy) v_u_localplayer, (copy) v_u_http, (copy) v_u_new
	if v_u19 then
		if tick() - v_u21 < 1.5 then
			return
		else
			local v_u_currentequipped = v_u_localplayer:GetAttribute("CurrentEquipped")
			if v_u_currentequipped then
				local v1, v2 = pcall(function()
					-- upvalues: (ref) v_u_http, (copy) v_u_currentequipped
					return v_u_http:JSONDecode(v_u_currentequipped)
				end)
				if v1 and (v2 and v2.Identifier) then
					local v_currentequipped = v_u19.CurrentEquipped
					if v_currentequipped and v_currentequipped.Identifier == v2.Identifier then
						return
					else
						local v_getinventoryitemfromloadout, _, v3 = v_u19:getInventoryItemFromLoadout(v2.Identifier)
						if v_getinventoryitemfromloadout then
							if v_currentequipped then
								v_currentequipped:unequip()
							end
							v_u19:setCurrentEquipped(v_getinventoryitemfromloadout)
							v_getinventoryitemfromloadout:equip()
							if v_u19.CurrentEquipped then
								v_u_new:Fire(v3, v_u19.CurrentEquipped)
							end
						end
					end
				else
					return
				end
			else
				return
			end
		end
	else
		return
	end
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u4, (copy) v_u1, (copy) v_u3, (copy) v_u_localplayer, (ref) v_u19, (copy) v_u7, (copy) v_u_new, (copy) v_u24
	v_u4.Inventory.RemoveInventoryItem.Listen(v_u1.removeInventoryItem)
	v_u4.Inventory.NewInventoryItem.Listen(v_u1.newInventoryItem)
	v_u4.Inventory.UpdateStatTrack.Listen(function(arg1)
		-- upvalues: (ref) v_u3, (ref) v_u_localplayer, (ref) v_u1
		local v_player = arg1.Player
		local v_identifier = arg1.Identifier
		if not (v_player and v_identifier) then
			return
		end
		local v_get = v_u3.Get(v_player, "Inventory")
		if v_get then
			for _, v1 in ipairs(v_get) do
				if v1._id == v_identifier then
					v1.StatTrack = arg1.StatTrack
					break
				end
			end
		end
		if v_player == v_u_localplayer then
			local v_getcurrentinventory = v_u1.getCurrentInventory()
			if not v_getcurrentinventory then
				return
			end
			for _, v2 in pairs(v_getcurrentinventory) do
				for _, v3 in pairs(v2._items) do
					if v3._id == v_identifier then
						v3:updateStatTrackCounter(arg1.StatTrack)
						return
					end
				end
			end
		end
	end)
	v_u4.Inventory.CleanupGameLoadout.Listen(function()
		-- upvalues: (ref) v_u19
		if v_u19 then
			v_u19:destroy()
			v_u19 = nil
		end
	end)
	v_u4.Inventory.CreateGameLoadout.Listen(function(...)
		-- upvalues: (ref) v_u19, (ref) v_u7, (ref) v_u_new
		v_u19 = v_u7.new(...)
		if v_u19 then
			v_u_new:Fire(v_u19.Inventory)
		end
	end)
	v_u_localplayer:GetAttributeChangedSignal("CurrentEquipped"):Connect(function()
		-- upvalues: (ref) v_u24
		task.defer(v_u24)
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u3, (copy) v_u_localplayer, (ref) v_u20, (copy) v_u22, (copy) v_u4, (copy) v_u17, (copy) v_u18, (copy) v_u9, (copy) v_u12, (copy) v_u11, (copy) v_u10, (copy) v_u13, (copy) v_u14, (copy) v_u15, (copy) v_u16, (copy) v_u_replicatedstorage, (copy) v_u1, (copy) v_u5
	v_u3.CreateListener(v_u_localplayer, "Settings.Video.Presets.Ragdolls", function(arg1)
		-- upvalues: (ref) v_u20, (ref) v_u22
		if arg1 == false then
			v_u22()
		end
	end)
	v_u4.VFX.CreateRagdoll.Listen(function(arg1)
		-- upvalues: (ref) v_u20, (ref) v_u17
		if v_u20 then
			v_u17(arg1)
		else
			local v_character = arg1.Character
			if v_character and (typeof(v_character) == "Instance" and v_character:IsA("Model")) then
				v_character:Destroy()
			end
		end
	end)
	v_u4.VFX.CleanupDebris.Listen(v_u18)
	v_u4.VFX.CreateCharacterMuzzleFlash.Listen(function(arg1)
		-- upvalues: (ref) v_u9
		v_u9(arg1.PlayerName, arg1.WeaponName, arg1.ShootingHand, arg1.Suppressor)
	end)
	v_u4.VFX.CreateImpact.Listen(function(arg1)
		-- upvalues: (ref) v_u12
		v_u12(arg1.Instance, arg1.Material, arg1.Position, arg1.Normal, arg1.Exit, arg1.Ricochet)
	end)
	v_u4.VFX.CreateMarker.Listen(function(arg1)
		-- upvalues: (ref) v_u11
		v_u11(arg1.Instance, arg1.Type, arg1.Position, arg1.Normal)
	end)
	v_u4.VFX.CreateTracer.Listen(function(arg1)
		-- upvalues: (ref) v_u10
		v_u10(arg1.Distance, arg1.Origin, arg1.Target)
	end)
	v_u4.VFX.BreakGlass.Listen(function(arg1)
		-- upvalues: (ref) v_u13
		v_u13(arg1.Instance, arg1.Position, arg1.Direction)
	end)
	v_u4.VFX.CreateVoxelSmoke.Listen(function(arg1)
		-- upvalues: (ref) v_u14
		v_u14.Create(arg1)
	end)
	v_u4.VFX.DestroyVoxelSmoke.Listen(function(arg1)
		-- upvalues: (ref) v_u14
		v_u14.Destroy(arg1)
	end)
	v_u4.VFX.DisruptVoxelSmoke.Listen(function(arg1)
		-- upvalues: (ref) v_u14
		v_u14.Disrupt(arg1.Position, arg1.Radius, arg1.Duration)
	end)
	v_u4.VFX.CreateVoxelFire.Listen(function(arg1)
		-- upvalues: (ref) v_u15
		v_u15.Create(arg1)
	end)
	v_u4.VFX.DestroyVoxelFire.Listen(function(arg1)
		-- upvalues: (ref) v_u15
		v_u15.Destroy(arg1)
	end)
	v_u4.VFX.UpdateVoxelFire.Listen(function(arg1)
		-- upvalues: (ref) v_u15
		v_u15.Update(arg1)
	end)
	v_u4.VFX.FlashPlayer.Listen(function(arg1)
		-- upvalues: (ref) v_u16
		v_u16.Flash(arg1)
	end)
	require(v_u_replicatedstorage.Database.Components.GameState).ListenToState(function(_, arg2)
		-- upvalues: (ref) v_u14, (ref) v_u15
		if arg2 == "Buy Period" then
			v_u14.DestroyAll()
			v_u15.DestroyAll()
		end
	end)
	v_u3.CreateListener(v_u_localplayer, "Inventory", function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.UpdateStatTrack(arg1)
	end)
	v_u5.observerRouter("GetInventoryItemFromIdentifier", function(arg1, arg2)
		-- upvalues: (ref) v_u1
		return v_u1.GetInventoryItemFromIdentifier(arg1, arg2)
	end)
	v_u5.observerRouter("GetEquippedInventoryItem", function(arg1, arg2)
		-- upvalues: (ref) v_u1
		return v_u1.GetEquippedInventoryItem(arg1, arg2)
	end)
end
return v_u1