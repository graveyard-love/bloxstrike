-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v3 = require(v_replicatedstorage.Components.Grenade)
local v4 = require(v_replicatedstorage.Components.Weapon)
local v5 = require(v_replicatedstorage.Components.Melee)
local v6 = require(v_replicatedstorage.Components.C4)
local v_u7 = require(v_replicatedstorage.Shared.Janitor)
local v_u8 = {
	["Grenade"] = v3,
	["Weapon"] = v4,
	["Melee"] = v5,
	["C4"] = v6
}
local function v_u9()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_run
	while true do
		local v_character = v_u_localplayer.Character
		local v1 = v_character and v_character:FindFirstChild("Humanoid")
		if v1 then
			v1 = v_character:IsDescendantOf(workspace)
		end
		if v1 then
			return
		end
		v_u_run.Heartbeat:Wait()
	end
end
function v_u1.setCurrentEquipped(arg1, arg2)
	arg1.PreviousEquipped = arg1.CurrentEquipped
	arg1.CurrentEquipped = arg2
end
function v_u1.getNextInventorySlotFromPriority(arg1)
	local v1 = nil
	for v2, v3 in ipairs(arg1.Inventory) do
		if #v3._items >= 1 then
			return v2
		end
	end
	return v1
end
function v_u1.getInventoryItemFromLoadout(arg1, arg2)
	local v1 = nil
	local v2 = nil
	local v3 = nil
	for v4, v5 in ipairs(arg1.Inventory) do
		for v6, v7 in ipairs(v5._items) do
			if v7.Identifier == arg2 then
				v3 = v6
				v2 = v4
				v1 = v7
				break
			end
		end
	end
	return v1, v2, v3
end
function v_u1.removeInventoryItem(arg1, arg2)
	local v_getinventoryitemfromloadout, v1, v2 = arg1:getInventoryItemFromLoadout(arg2)
	local v3 = v_getinventoryitemfromloadout and arg1.Inventory[v1]
	if v3 then
		table.remove(v3._items, v2)
		if arg1.CurrentEquipped == v_getinventoryitemfromloadout then
			arg1:setCurrentEquipped(nil)
		end
		v_getinventoryitemfromloadout:destroy()
	end
end
function v_u1.grantPlayerInventoryItem(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
	-- upvalues: (copy) v_u9, (copy) v_u2, (copy) v_u8, (copy) v_u_localplayer
	v_u9()
	local v_format = ("%* does not exist in player inventory"):format(arg2)
	assert(arg1.Inventory[arg2], v_format)
	local v1 = v_u8[v_u2(arg5).Class]
	local v_format = ("Client couldn\'t find weapon component for \"%*\""):format(arg5)
	assert(v1, v_format)
	local v_u_new = v1.new(v_u_localplayer, arg3, arg4, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
	table.insert(UNNAMED_1729007506712._items, v_u_new)
	arg1.Janitor:Add(function()
		-- upvalues: (copy) arg1, (copy) v_u_new
		if not arg1.IsDestroyed and (v_u_new and (getmetatable(v_u_new) and not v_u_new.IsDestroyed)) then
			v_u_new:destroy()
		end
	end)
end
function v_u1.new(arg1)
	-- upvalues: (copy) v_u1, (copy) v_u7, (copy) v_u_run, (copy) v_u_localplayer
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u7.new()
	v_u1.IsDestroyed = false
	v_u1.Inventory = arg1
	v_u1.PreviousEquipped = nil
	v_u1.CurrentEquipped = nil
	v_u1.Janitor:Add(v_u_run.RenderStepped:Connect(function(arg1)
		-- upvalues: (copy) v_u1, (ref) v_u_localplayer
		if v_u1.IsDestroyed then
			return
		else
			local v_character = v_u_localplayer.Character
			if not (v_character and v_character:GetAttribute("Dead")) then
				if v_u1.CurrentEquipped then
					v_u1.CurrentEquipped.Viewmodel:render(arg1)
				end
			end
		end
	end))
	return v_u1
end
function v_u1.destroy(arg1)
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		if arg1.CurrentEquipped then
			if arg1.CurrentEquipped.unequip then
				arg1.CurrentEquipped:unequip()
			end
			if arg1.CurrentEquipped.destroy and not arg1.CurrentEquipped.IsDestroyed then
				arg1.CurrentEquipped:destroy()
			end
			arg1.CurrentEquipped = nil
		end
		if arg1.PreviousEquipped then
			if arg1.PreviousEquipped.destroy and not arg1.PreviousEquipped.IsDestroyed then
				arg1.PreviousEquipped:destroy()
			end
			arg1.PreviousEquipped = nil
		end
		if arg1.Inventory then
			for _, v1 in ipairs(arg1.Inventory) do
				if v1 and v1._items then
					table.clear(v1._items)
				end
			end
		end
		arg1.Janitor:Destroy()
		arg1.Janitor = nil
		arg1.Inventory = nil
	end
end
return v_u1