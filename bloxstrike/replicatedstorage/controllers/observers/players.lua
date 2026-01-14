-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
local v_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
local v_u1 = require(v_replicatedstorage.Packages.Observers)
local v_u2 = require(v_replicatedstorage.Shared.DebugFlags)
local v_u_localplayer = v_players.LocalPlayer
local v_u3 = require(script.Components.CreateWeaponModel)
local v_u4 = {}
local function v_u5(arg1)
	-- upvalues: (copy) v_u_http
	local v1 = {}
	for v2 = 1, 3 do
		local v_getattribute = arg1:GetAttribute("Slot" .. v2)
		if v_getattribute then
			v1[v2] = v_u_http:JSONDecode(v_getattribute)
		end
	end
	return v1
end
local function v_u6(arg1)
	if typeof(arg1) ~= "table" then
		return ""
	end
	local v1 = {}
	for v2, v3 in ipairs(arg1) do
		if typeof(v3) == "table" then
			local v_position = v3.Position
			v1[v2] = string.format("%s@%s,%s,%s", tostring(v3.Sticker or ""), tostring(typeof(v_position) == "table" and (v_position.Rotation or "") or ""), tostring(typeof(v_position) == "table" and (v_position.X or "") or ""), (tostring(typeof(v_position) == "table" and (v_position.Y or "") or "")))
		else
			v1[v2] = tostring(v3)
		end
	end
	return table.concat(v1, ";")
end
local function v_u7(arg1)
	-- upvalues: (copy) v_u6
	if typeof(arg1) ~= "table" then
		return ""
	end
	local v_concat = table.concat
	local v1 = {}
	local v2 = tostring(arg1.Identifier or "")
	local v3 = tostring(arg1.Name or "")
	local v4 = tostring(arg1.Skin or "")
	local v5 = tostring(arg1.Float or "")
	local v6 = tostring(arg1.StatTrack or "")
	local v7 = tostring(arg1.NameTag or "")
	local v_charm = arg1.Charm
	local v8
	if v_charm == nil or v_charm == false then
		v8 = ""
	elseif typeof(v_charm) == "table" then
		v8 = tostring(v_charm._id or "") .. "@" .. tostring(v_charm.Position or "")
	else
		v8 = tostring(v_charm)
	end
	__set_list(v1, 1, {v2, v3, v4, v5, v6, v7, v8, tostring(arg1.IsSuppressed or ""), v_u6(arg1.Stickers)})
	return v_concat(v1, "|")
end
return v_u1.observePlayer(function(self)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u1, (copy) v_u2, (copy) v_u4, (copy) v_u_http, (copy) v_u7, (copy) v_u3, (copy) v_u5
	if self == v_u_localplayer then
		return function() end
	end
	local v_u_observeattribute = v_u1.observeAttribute(self, "CurrentEquipped", function(arg1)
		-- upvalues: (ref) v_u2, (copy) self, (ref) v_u4, (ref) v_u_http, (ref) v_u7, (ref) v_u3, (ref) v_u5
		if v_u2.IsEnabled("ThirdPersonWeaponModels") then
			warn(("[ThirdPersonWeaponModels] %s CurrentEquipped changed (%s bytes JSON)"):format(self.Name, (tostring(typeof(arg1) == "string" and (#arg1 or -1) or -1))))
		end
		if not arg1 then
			v_u4[self] = nil
			local v_character = self.Character
			if v_character and v_character:IsDescendantOf(workspace) then
				local v_weaponattachments = v_character:FindFirstChild("WeaponAttachments")
				if v_weaponattachments then
					v_weaponattachments:ClearAllChildren()
				end
				local v_weaponmodel = v_character:FindFirstChild("WeaponModel")
				if v_weaponmodel then
					v_weaponmodel:ClearAllChildren()
				end
				local v_debris = workspace:FindFirstChild("Debris")
				if v_debris then
					local v1 = v_debris:FindFirstChild(self.Name .. "_Weapon")
					if v1 then
						v1:Destroy()
					end
					local v2 = v_debris:FindFirstChild(self.Name .. "_WeaponAttachments")
					if v2 then
						v2:Destroy()
					end
				end
			end
			return function() end
		end
		local v_u_jsondecode = v_u_http:JSONDecode(arg1)
		local v3 = v_u7(v_u_jsondecode)
		if v3 ~= "" and v_u4[self] == v3 then
			return function() end
		end
		v_u4[self] = v3
		local v4, v5, _ = pcall(function()
			-- upvalues: (ref) v_u3, (ref) self, (copy) v_u_jsondecode, (ref) v_u5
			return v_u3(self, v_u_jsondecode, (v_u5(self)))
		end)
		if v_u2.IsEnabled("ThirdPersonWeaponModels") then
			if v4 then
				warn(("[ThirdPersonWeaponModels] %s CreateWeaponModel ok"):format(self.Name))
			else
				warn(("[ThirdPersonWeaponModels] %s CreateWeaponModel failed: %s"):format(self.Name, (tostring(v5))))
			end
		end
		return function() end
	end)
	return function()
		-- upvalues: (copy) v_u_observeattribute, (ref) v_u3, (copy) self, (ref) v_u4
		v_u_observeattribute()
		v_u3.ClearPlayerCache(self)
		v_u4[self] = nil
	end
end)