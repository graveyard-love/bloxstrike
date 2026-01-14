-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
local v_u_players = game:GetService("Players")
require(v_u_replicatedstorage.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u3 = nil
local v4 = require(v_u_replicatedstorage.Packages.Signal)
local v_u_assets = v_u_replicatedstorage:WaitForChild("Assets")
local v_u_weapons = v_u_assets:WaitForChild("Weapons")
local v_u_skins = v_u_assets:WaitForChild("Skins")
local v_u_new = v4.new()
v_u1.OnItemStockSchemasUpdated = v_u_new
local v_u5 = {}
local function v_u6(arg1)
	-- upvalues: (ref) v_u3, (copy) v_u_replicatedstorage, (copy) v_u_players
	if not v_u3 then
		local v1, v2 = pcall(function()
			-- upvalues: (ref) v_u_replicatedstorage
			return require(v_u_replicatedstorage.Controllers.DataController)
		end)
		if v1 then
			v_u3 = v2
		end
	end
	local v3 = v_u3
	if not v3 then
		return nil
	end
	local v_localplayer = v_u_players.LocalPlayer
	if not v_localplayer then
		return nil
	end
	local v_get = v3.Get(v_localplayer, "Inventory")
	if not v_get or typeof(v_get) ~= "table" then
		return nil
	end
	for _, v4 in ipairs(v_get) do
		if v4._id == arg1 and v4.Type == "Charm" then
			return {
				["Skin"] = v4.Skin,
				["Pattern"] = v4.Pattern
			}
		end
	end
	return nil
end
local function v_u7(arg1, arg2)
	-- upvalues: (copy) v_u2
	local v1 = arg1 or 0
	assert(typeof(v1) == "number", "KillCount must be a number")
	local v2, v3 = pcall(function(...)
		-- upvalues: (ref) v_u2, (copy) arg2
		return v_u2(arg2)
	end)
	if v2 and v3 then
		if v3.Class == "Melee" then
			local v_floor = math.floor(v1)
			local v_clamp = math.clamp(v_floor, 0, 9999)
			return tostring(v_clamp)
		else
			local v_floor = math.floor(v1)
			local v_clamp = math.clamp(v_floor, 0, 999999)
			return string.format("%06d", v_clamp)
		end
	else
		return nil
	end
end
local function v_u8(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_skins
	local v1 = v_u_skins:WaitForChild(arg1, 10)
	if v1 then
		if arg3 and arg1 == "Smoke Grenade" then
			local v2 = v1:WaitForChild(arg3, 5)
			if v2 and v2:IsA("Folder") then
				return v2
			end
		end
		local v3 = v1:WaitForChild(arg2, 10)
		if v3 and v3:IsA("Folder") then
			return v3
		else
			return nil
		end
	else
		return nil
	end
end
local function v_u9(arg1, arg2)
	local v_floatrange = arg1.floatRange
	local v_floatchances = arg1.floatChances
	local v_clamp = math.clamp(arg2, v_floatrange.min, v_floatrange.max)
	local v1 = v_floatrange.max - v_floatrange.min
	local v2 = v1 > 0 and (v_clamp - v_floatrange.min) / v1 or 0
	local v3 = 0
	for _, v4 in ipairs(v_floatchances) do
		v3 = v3 + v4.chance / 100
		if v2 <= v3 then
			return v4.wear
		end
	end
	local v5 = v_floatchances[#v_floatchances]
	if v5 then
		return v5.wear
	else
		return nil
	end
end
local function v_u10(arg1, arg2)
	for _, v1 in ipairs(arg2:GetChildren()) do
		if v1:IsA("SurfaceAppearance") then
			local v2 = arg1:FindFirstChild(v1.Name, true)
			if v2 and v2:IsA("MeshPart") then
				local v_surfaceappearance = v2:FindFirstChildOfClass("SurfaceAppearance")
				if v_surfaceappearance then
					v_surfaceappearance:Destroy()
				end
				v1:Clone().Parent = v2
			end
		end
	end
end
local function v_u11(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u2, (copy) v_u_assets, (copy) v_u7
	local v1, v2 = pcall(function(...)
		-- upvalues: (ref) v_u2, (copy) arg4
		return v_u2(arg4)
	end)
	local v_clone = v_u_assets.Other[v1 and (v2 and v2.Class == "Melee") and "KillTrackKnife" or "KillTrak"]:Clone()
	local v_primarypart = arg2.PrimaryPart
	if v_primarypart then
		local v_killtrack = arg1:FindFirstChild("KillTrack", true)
		if v_killtrack then
			local v_primarypart = v_clone.PrimaryPart
			local v_weldconstraint = Instance.new("WeldConstraint")
			v_weldconstraint.Part0 = v_primarypart
			v_weldconstraint.Part1 = v_primarypart
			v_weldconstraint.Parent = v_primarypart
			v_clone:PivotTo(v_killtrack.WorldCFrame)
			v_clone.Screen.SurfaceGui.TextLabel.Text = v_u7(arg3, arg4)
			v_clone.Parent = arg1
		else
			v_clone:Destroy()
		end
	else
		v_clone:Destroy()
		return
	end
end
local function v_u12(arg1, arg2, arg3)
	-- upvalues: (copy) v_u11
	local v_weapon = arg1:FindFirstChild("Weapon")
	if v_weapon then
		v_u11(arg1, v_weapon, arg2, arg3)
	else
		local v_weaponl = arg1:FindFirstChild("WeaponL")
		local v_weaponr = arg1:FindFirstChild("WeaponR")
		if v_weaponl then
			v_u11(arg1, v_weaponl, arg2, arg3)
		end
		if v_weaponr then
			v_u11(arg1, v_weaponr, arg2, arg3)
		end
	end
end
local function v_u13(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_assets
	local v_clone = v_u_assets.Other.NamePlate:Clone()
	local v_primarypart = arg2.PrimaryPart
	if v_primarypart then
		local v_nametag = v_primarypart:FindFirstChild("Nametag")
		if v_nametag then
			local v_primarypart = v_clone.PrimaryPart
			local v_weldconstraint = Instance.new("WeldConstraint")
			v_weldconstraint.Part0 = v_primarypart
			v_weldconstraint.Part1 = v_primarypart
			v_weldconstraint.Parent = v_primarypart
			v_clone:PivotTo(v_nametag.WorldCFrame)
			v_clone.Screen.SurfaceGui.TextLabel.Text = tostring(arg3)
			v_clone.Parent = arg1
		else
			v_clone:Destroy()
		end
	else
		v_clone:Destroy()
		return
	end
end
local function v_u14(arg1, arg2)
	-- upvalues: (copy) v_u13
	local v_weapon = arg1:FindFirstChild("Weapon")
	if v_weapon then
		v_u13(arg1, v_weapon, arg2)
	else
		local v_weaponl = arg1:FindFirstChild("WeaponL")
		local v_weaponr = arg1:FindFirstChild("WeaponR")
		if v_weaponl then
			v_u13(arg1, v_weaponl, arg2)
		end
		if v_weaponr then
			v_u13(arg1, v_weaponr, arg2)
		end
	end
end
local function v_u15(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u2, (copy) v_u_assets, (copy) v_u7
	local v1, v2 = pcall(function(...)
		-- upvalues: (ref) v_u2, (copy) arg4
		return v_u2(arg4)
	end)
	local v_clone = v_u_assets.Other[v1 and (v2 and v2.Class == "Melee") and "KillTrackKnife" or "KillTrak"]:Clone()
	local v_primarypart = arg2.PrimaryPart
	if v_primarypart then
		local v_killtrack = arg2:FindFirstChild("KillTrack", true)
		if v_killtrack then
			local v_primarypart = v_clone.PrimaryPart
			local v_weldconstraint = Instance.new("WeldConstraint")
			v_weldconstraint.Part0 = v_primarypart
			v_weldconstraint.Part1 = v_primarypart
			v_weldconstraint.Parent = v_primarypart
			v_clone:PivotTo(v_killtrack.WorldCFrame)
			local v_surfacegui = v_clone.Screen.SurfaceGui
			v_surfacegui.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
			v_surfacegui.CanvasSize = Vector2.new(100, 25)
			v_surfacegui.TextLabel.Text = v_u7(arg3, arg4)
			v_surfacegui.TextLabel.TextSize = 29
			v_surfacegui.TextLabel.Size = UDim2.fromScale(1, 1)
			v_clone.Parent = arg1
		else
			v_clone:Destroy()
		end
	else
		v_clone:Destroy()
		return
	end
end
local function v_u16(arg1, arg2, arg3)
	-- upvalues: (copy) v_u15
	local v_weapon = arg1:FindFirstChild("Weapon")
	if v_weapon then
		v_u15(arg1, v_weapon, arg2, arg3)
	else
		local v_weaponl = arg1:FindFirstChild("WeaponL")
		local v_weaponr = arg1:FindFirstChild("WeaponR")
		if v_weaponl then
			v_u15(arg1, v_weaponl, arg2, arg3)
		end
		if v_weaponr then
			v_u15(arg1, v_weaponr, arg2, arg3)
		end
	end
end
local function v_u17(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_assets
	local v_clone = v_u_assets.Other.NamePlate:Clone()
	local v_primarypart = arg2.PrimaryPart
	if v_primarypart then
		local v_nametag = v_primarypart:FindFirstChild("Nametag")
		if v_nametag then
			local v_primarypart = v_clone.PrimaryPart
			local v_weldconstraint = Instance.new("WeldConstraint")
			v_weldconstraint.Part0 = v_primarypart
			v_weldconstraint.Part1 = v_primarypart
			v_weldconstraint.Parent = v_primarypart
			v_clone:PivotTo(v_nametag.WorldCFrame)
			local v_surfacegui = v_clone.Screen.SurfaceGui
			v_surfacegui.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
			v_surfacegui.CanvasSize = Vector2.new(100, 8)
			v_surfacegui.TextLabel.Text = tostring(arg3)
			v_surfacegui.TextLabel.TextSize = 8.98
			v_surfacegui.TextLabel.Size = UDim2.fromScale(0.95, 1)
			v_surfacegui.TextLabel.Position = UDim2.fromOffset(5, 0)
			v_clone.Parent = arg1
		else
			v_clone:Destroy()
		end
	else
		v_clone:Destroy()
		return
	end
end
local function v_u18(arg1, arg2)
	-- upvalues: (copy) v_u17
	local v_weapon = arg1:FindFirstChild("Weapon")
	if v_weapon then
		v_u17(arg1, v_weapon, arg2)
	else
		local v_weaponl = arg1:FindFirstChild("WeaponL")
		local v_weaponr = arg1:FindFirstChild("WeaponR")
		if v_weaponl then
			v_u17(arg1, v_weaponl, arg2)
		end
		if v_weaponr then
			v_u17(arg1, v_weaponr, arg2)
		end
	end
end
local function v_u19(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_assets
	local v_charms = v_u_assets:FindFirstChild("Charms")
	local v1
	if v_charms then
		v1 = v_charms:FindFirstChild("CharmBase")
	else
		v1 = v_charms
	end
	if v1 and v1:IsA("Model") then
		local v2 = v_charms:FindFirstChild(arg2)
		if v2 then
			v2 = v2:FindFirstChild((tostring(arg3)))
		end
		if v2 and v2:IsA("Model") then
			local v3 = arg1:FindFirstChild("Charm" .. arg4, true)
			if v3 then
				local v_parent = v3.Parent
				if v_parent and v_parent:IsA("BasePart") then
					local v_clone = v1:Clone()
					v_clone.Parent = arg1
					v_clone:PivotTo(v3.WorldCFrame * CFrame.Angles(0, 0, 0))
					if v_clone.PrimaryPart then
						local v_primarypart = v_clone.PrimaryPart
						local v_weldconstraint = Instance.new("WeldConstraint")
						v_weldconstraint.Part0 = v_primarypart
						v_weldconstraint.Part1 = v_parent
						v_weldconstraint.Parent = v_primarypart
					end
					local v_clone = v2:Clone()
					v_clone.Parent = v_clone
					local v_part = v_clone:FindFirstChild("Part")
					if v_part and v_part:IsA("BasePart") then
						v_clone:PivotTo(v_part.CFrame)
						v_part:Destroy()
					end
					local v_hingeconstraint = v_clone:FindFirstChild("HingeConstraint", true)
					local v4 = v_hingeconstraint and (v_clone.PrimaryPart and v_clone.PrimaryPart:FindFirstChild("Attachment"))
					if v4 then
						v_hingeconstraint.Attachment1 = v4
					end
				end
			else
				print("Charm attachment not found for weapon:", arg1.Name, arg4)
				return
			end
		else
			warn("Specific charm not found for weapon:", arg1.Name, arg2, arg3)
			return
		end
	else
		warn("Charm base not found for weapon:", arg1.Name)
		return
	end
end
local function v_u20(arg1, arg2)
	-- upvalues: (copy) v_u6, (copy) v_u19
	if typeof(arg2) == "table" then
		if arg2._id and arg2.Position then
			local v_position = arg2.Position
			local v1, v2
			if arg2.Skin and arg2.Pattern then
				v1 = arg2.Skin
				v2 = arg2.Pattern
			else
				local v3 = v_u6(arg2._id)
				if not v3 then
					return
				end
				v1 = v3.Skin
				v2 = v3.Pattern
			end
			if v1 and v2 then
				if arg1:FindFirstChild("Weapon") then
					v_u19(arg1, v1, v2, v_position)
				else
					local v_weaponl = arg1:FindFirstChild("WeaponL")
					local v_weaponr = arg1:FindFirstChild("WeaponR")
					if v_weaponl then
						v_u19(arg1, v1, v2, v_position)
					end
					if v_weaponr then
						v_u19(arg1, v1, v2, v_position)
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
local function v_u21(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_assets
	local v_charms = v_u_assets:FindFirstChild("Charms")
	local v1
	if v_charms then
		v1 = v_charms:FindFirstChild("CharmBase")
	else
		v1 = v_charms
	end
	if v1 and v1:IsA("Model") then
		local v2 = v_charms:FindFirstChild(arg2)
		if v2 then
			v2 = v2:FindFirstChild((tostring(arg3)))
		end
		if v2 and v2:IsA("Model") then
			local v3 = arg1:FindFirstChild("Charm" .. arg4, true)
			if v3 then
				local v_parent = v3.Parent
				if v_parent and v_parent:IsA("BasePart") then
					local v_clone = v1:Clone()
					v_clone.Parent = arg1
					v_clone:PivotTo(v3.WorldCFrame * CFrame.Angles(0, 0, 0))
					if v_clone.PrimaryPart then
						local v_primarypart = v_clone.PrimaryPart
						local v_weldconstraint = Instance.new("WeldConstraint")
						v_weldconstraint.Part0 = v_primarypart
						v_weldconstraint.Part1 = v_parent
						v_weldconstraint.Parent = v_primarypart
					end
					local v_clone = v2:Clone()
					v_clone.Parent = v_clone
					local v_part = v_clone:FindFirstChild("Part")
					if v_part and v_part:IsA("BasePart") then
						v_clone:PivotTo(v_part.CFrame)
						v_part:Destroy()
					end
					local v_hingeconstraint = v_clone:FindFirstChild("HingeConstraint", true)
					local v4 = v_hingeconstraint and (v_clone.PrimaryPart and v_clone.PrimaryPart:FindFirstChild("Attachment"))
					if v4 then
						v_hingeconstraint.Attachment1 = v4
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
local function v_u22(arg1, arg2)
	-- upvalues: (copy) v_u6, (copy) v_u21
	if typeof(arg2) == "table" then
		if arg2._id and arg2.Position then
			local v_position = arg2.Position
			local v1, v2
			if arg2.Skin and arg2.Pattern then
				v1 = arg2.Skin
				v2 = arg2.Pattern
			else
				local v3 = v_u6(arg2._id)
				if not v3 then
					return
				end
				v1 = v3.Skin
				v2 = v3.Pattern
			end
			if v1 and v2 then
				if arg1:FindFirstChild("Weapon") then
					v_u21(arg1, v1, v2, v_position)
				else
					local v_weaponl = arg1:FindFirstChild("WeaponL")
					local v_weaponr = arg1:FindFirstChild("WeaponR")
					if v_weaponl then
						v_u21(arg1, v1, v2, v_position)
					end
					if v_weaponr then
						v_u21(arg1, v1, v2, v_position)
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
function v_u1.GetCharmModel(arg1, arg2)
	-- upvalues: (copy) v_u_assets
	local v_charms = v_u_assets:FindFirstChild("Charms")
	local v1
	if v_charms then
		v1 = v_charms:FindFirstChild("CharmBase")
	else
		v1 = v_charms
	end
	if not (v1 and v1:IsA("Model")) then
		warn((("Skins.GetCharmModel: Charm base not found for charm \"%*\" with pattern \"%*\""):format(arg1, arg2)))
		return nil
	end
	local v2 = v_charms:FindFirstChild(arg1)
	if v2 then
		v2 = v2:FindFirstChild((tostring(arg2)))
	end
	if not (v2 and v2:IsA("Model")) then
		warn((("Skins.GetCharmModel: Specific charm not found for charm \"%*\" with pattern \"%*\""):format(arg1, arg2)))
		return nil
	end
	local v_clone = v1:Clone()
	v_clone.Name = arg1
	local v_clone = v2:Clone()
	v_clone.Parent = v_clone
	local v_part = v_clone:FindFirstChild("Part")
	if v_part and v_part:IsA("BasePart") then
		v_clone:PivotTo(v_part.CFrame)
		v_part:Destroy()
	end
	local v_hingeconstraint = v_clone:FindFirstChild("HingeConstraint", true)
	local v3 = v_hingeconstraint and (v_clone.PrimaryPart and v_clone.PrimaryPart:FindFirstChild("Attachment"))
	if v3 then
		v_hingeconstraint.Attachment1 = v3
	end
	return v_clone
end
function v_u1.GetWearNameForFloat(arg1, arg2)
	-- upvalues: (copy) v_u9
	return v_u9(arg1, arg2)
end
function v_u1.GetKillTrackValue(arg1, arg2)
	-- upvalues: (copy) v_u7
	return v_u7(arg1, arg2)
end
function v_u1.GetMagazine(arg1, arg2, arg3)
	-- upvalues: (copy) v_u1, (ref) v_u5, (copy) v_u_new, (copy) v_u_weapons, (copy) v_u9, (copy) v_u8, (copy) v_u10
	local v1
	if typeof(arg1) == "string" and (typeof(arg2) == "string" and arg1 ~= "") then
		v1 = arg2 ~= ""
	else
		v1 = false
	end
	if not v1 then
		return nil
	end
	local v_getskininformation = v_u1.GetSkinInformation(arg1, arg2)
	if not v_getskininformation and next(v_u5) == nil then
		v_u_new:Wait()
		v_getskininformation = v_u1.GetSkinInformation(arg1, arg2)
	end
	if not v_getskininformation then
		return nil
	end
	local v2 = v_u_weapons:WaitForChild(arg1, 10)
	if not (v2 and v2:IsA("Folder")) then
		v2 = nil
	end
	if v2 then
		v2 = v2:FindFirstChild("Character")
	end
	if not (v2 and v2:IsA("Model")) then
		return nil
	end
	local v3 = {}
	for _, v4 in ipairs(v2:GetDescendants()) do
		if v4:IsA("BasePart") and v4:HasTag("CharacterMagazine") then
			table.insert(v3, v4)
		end
	end
	if #v3 == 0 then
		return nil
	end
	local v_model = Instance.new("Model")
	v_model.Name = "Magazine"
	for _, v5 in ipairs(v3) do
		local v_clone = v5:Clone()
		v_clone.Parent = v_model
		if not v_model.PrimaryPart then
			v_model.PrimaryPart = v_clone
		end
	end
	local v6 = v_u9(v_getskininformation, arg3 or v_getskininformation.floatRange.min)
	if v6 then
		local v7 = v_u8(arg1, arg2)
		if v7 then
			v7 = v7:FindFirstChild("Character")
		end
		if v7 then
			v7 = v7:FindFirstChild(v6)
		end
		if v7 and v7:IsA("Folder") then
			v_u10(v_model, v7)
		end
	end
	return v_model
end
function v_u1.GetGloves(arg1, arg2, arg3)
	-- upvalues: (copy) v_u1, (ref) v_u5, (copy) v_u_new, (copy) v_u_weapons, (copy) v_u9, (copy) v_u8, (copy) v_u10
	local v1
	if typeof(arg1) == "string" and (typeof(arg2) == "string" and arg1 ~= "") then
		v1 = arg2 ~= ""
	else
		v1 = false
	end
	if not v1 then
		return nil
	end
	local v_getskininformation = v_u1.GetSkinInformation(arg1, arg2)
	if not v_getskininformation and next(v_u5) == nil then
		v_u_new:Wait()
		v_getskininformation = v_u1.GetSkinInformation(arg1, arg2)
	end
	if not v_getskininformation then
		return nil
	end
	local v2 = v_u_weapons:WaitForChild(arg1, 10)
	if not (v2 and v2:IsA("Folder")) then
		v2 = nil
	end
	if not v2 then
		return nil
	end
	local v_model = Instance.new("Model")
	v_model.Name = arg1
	for _, v3 in ipairs(v2:GetChildren()) do
		if v3:IsA("BasePart") then
			v3:Clone().Parent = v_model
		end
	end
	local v4 = v_u9(v_getskininformation, arg3 or v_getskininformation.floatRange.min)
	if v4 then
		local v5 = v_u8(arg1, arg2)
		if v5 then
			v5 = v5:FindFirstChild("Camera")
		end
		if v5 then
			v5 = v5:FindFirstChild(v4)
		end
		if v5 and v5:IsA("Folder") then
			v_u10(v_model, v5)
		end
	end
	return v_model
end
function v_u1.GetCharacterModel(arg1, arg2, arg3, arg4, arg5, arg6, _, arg8)
	-- upvalues: (copy) v_u1, (ref) v_u5, (copy) v_u_new, (copy) v_u_weapons, (copy) v_u9, (copy) v_u8, (copy) v_u10, (copy) v_u12, (copy) v_u14, (copy) v_u20
	local v1
	if typeof(arg1) == "string" and (typeof(arg2) == "string" and arg1 ~= "") then
		v1 = arg2 ~= ""
	else
		v1 = false
	end
	if not v1 then
		return nil
	end
	local v_getskininformation = v_u1.GetSkinInformation(arg1, arg2)
	if not v_getskininformation and next(v_u5) == nil then
		v_u_new:Wait()
		v_getskininformation = v_u1.GetSkinInformation(arg1, arg2)
	end
	if not v_getskininformation then
		warn((("SkinHandler.GetCharacterModel: Skin \"%*\" not found for weapon \"%*\""):format(arg2, arg1)))
		return nil
	end
	local v2 = v_u_weapons:WaitForChild(arg1, 10)
	if not (v2 and v2:IsA("Folder")) then
		v2 = nil
	end
	if v2 then
		v2 = v2:FindFirstChild("Character")
	end
	if not (v2 and v2:IsA("Model")) then
		warn((("SkinHandler.GetCharacterModel: Base character model not found for weapon \"%*\""):format(arg1)))
		return nil
	end
	local v_clone = v2:Clone()
	local v3 = v_u9(v_getskininformation, arg3 or v_getskininformation.floatRange.max)
	if v3 then
		local v4 = v_u8(arg1, arg2, arg8)
		if v4 then
			v4 = v4:FindFirstChild("Character")
		end
		if v4 then
			v4 = v4:FindFirstChild(v3)
		end
		if v4 and v4:IsA("Folder") then
			v_u10(v_clone, v4)
		end
	end
	if arg4 then
		v_u12(v_clone, arg4, arg1)
	end
	if arg5 then
		v_u14(v_clone, arg5)
	end
	if arg6 then
		print(arg6)
		v_u20(v_clone, arg6)
	end
	return v_clone
end
function v_u1.GetWorldModel(arg1, arg2, arg3, arg4, arg5, arg6, _)
	-- upvalues: (copy) v_u1, (ref) v_u5, (copy) v_u_new, (copy) v_u_weapons, (copy) v_u9, (copy) v_u8, (copy) v_u10, (copy) v_u12, (copy) v_u14, (copy) v_u20
	local v1
	if typeof(arg1) == "string" and (typeof(arg2) == "string" and arg1 ~= "") then
		v1 = arg2 ~= ""
	else
		v1 = false
	end
	if not v1 then
		return nil
	end
	local v_getskininformation = v_u1.GetSkinInformation(arg1, arg2)
	if not v_getskininformation and next(v_u5) == nil then
		v_u_new:Wait()
		v_getskininformation = v_u1.GetSkinInformation(arg1, arg2)
	end
	if not v_getskininformation then
		return nil
	end
	local v2 = v_u_weapons:WaitForChild(arg1, 10)
	if not (v2 and v2:IsA("Folder")) then
		v2 = nil
	end
	if v2 then
		v2 = v2:FindFirstChild("Other")
	end
	if v2 then
		v2 = v2:FindFirstChild("World")
	end
	if not (v2 and v2:IsA("Model")) then
		return nil
	end
	local v_clone = v2:Clone()
	local v3 = v_u9(v_getskininformation, arg3 or v_getskininformation.floatRange.max)
	if v3 then
		local v4 = v_u8(arg1, arg2, nil)
		if v4 then
			v4 = v4:FindFirstChild("Character")
		end
		if v4 then
			v4 = v4:FindFirstChild(v3)
		end
		if v4 and v4:IsA("Folder") then
			v_u10(v_clone, v4)
		end
	end
	if arg4 then
		v_u12(v_clone, arg4, arg1)
	end
	if arg5 then
		v_u14(v_clone, arg5)
	end
	if arg6 then
		v_u20(v_clone, arg6)
	end
	return v_clone
end
function v_u1.GetCameraModel(arg1, arg2, arg3, arg4, arg5, arg6, _, arg8)
	-- upvalues: (copy) v_u1, (ref) v_u5, (copy) v_u_new, (copy) v_u_weapons, (copy) v_u9, (copy) v_u8, (copy) v_u10, (copy) v_u16, (copy) v_u18, (copy) v_u22
	local v1
	if typeof(arg1) == "string" and (typeof(arg2) == "string" and arg1 ~= "") then
		v1 = arg2 ~= ""
	else
		v1 = false
	end
	if not v1 then
		return nil
	end
	local v_getskininformation = v_u1.GetSkinInformation(arg1, arg2)
	if not v_getskininformation and next(v_u5) == nil then
		v_u_new:Wait()
		v_getskininformation = v_u1.GetSkinInformation(arg1, arg2)
	end
	if not v_getskininformation then
		return nil
	end
	local v2 = v_u_weapons:WaitForChild(arg1, 10)
	if not (v2 and v2:IsA("Folder")) then
		v2 = nil
	end
	if v2 then
		v2 = v2:FindFirstChild("Camera")
	end
	if not (v2 and v2:IsA("Model")) then
		return nil
	end
	local v_clone = v2:Clone()
	local v3 = v_u9(v_getskininformation, arg3 or v_getskininformation.floatRange.max)
	if v3 then
		local v4 = v_u8(arg1, arg2, arg8)
		if v4 then
			v4 = v4:FindFirstChild("Camera")
		end
		if v4 then
			v4 = v4:FindFirstChild(v3)
		end
		if v4 and v4:IsA("Folder") then
			v_u10(v_clone, v4)
		end
	end
	if arg4 then
		v_u16(v_clone, arg4, arg1)
	end
	if arg5 then
		v_u18(v_clone, arg5)
	end
	if arg6 then
		v_u22(v_clone, arg6)
	end
	return v_clone
end
function v_u1.GetSkinInformation(arg1, arg2)
	-- upvalues: (ref) v_u5
	local v1
	if typeof(arg1) == "string" and (typeof(arg2) == "string" and arg1 ~= "") then
		v1 = arg2 ~= ""
	else
		v1 = false
	end
	if v1 then
		local v2 = v_u5[arg1]
		if v2 then
			return v2[arg2]
		else
			return nil
		end
	else
		return nil
	end
end
function v_u1.GetAllSkinsForWeapon(arg1)
	-- upvalues: (ref) v_u5
	if typeof(arg1) ~= "string" or arg1 == "" then
		return nil
	end
	local v1 = v_u5[arg1]
	if not v1 then
		return nil
	end
	local v2 = {}
	for _, v3 in pairs(v1) do
		table.insert(v2, v3)
	end
	return v2
end
function v_u1.GetWearImageForFloat(arg1, arg2)
	-- upvalues: (copy) v_u9
	local v1 = v_u9(arg1, arg2)
	if not v1 then
		return nil
	end
	for _, v2 in ipairs(arg1.wearImages) do
		if v2.wear == v1 then
			return v2.assetId
		end
	end
	return nil
end
function v_u1.GetBaseWeaponModel(arg1, arg2)
	-- upvalues: (copy) v_u_weapons
	if typeof(arg1) == "string" and arg1 ~= "" then
		local v1 = v_u_weapons:WaitForChild(arg1, 10)
		if not (v1 and v1:IsA("Folder")) then
			v1 = nil
		end
		if v1 then
			local v2 = v1:FindFirstChild(arg2)
			if v2 and v2:IsA("Model") then
				return v2:Clone()
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
if v_u_replicatedstorage:GetAttribute("AvaiableSkins") then
	v_u5 = v_u_http:JSONDecode((v_u_replicatedstorage:GetAttribute("AvaiableSkins")))
	if #v_u_new:GetConnections() > 0 then
		v_u_new:Fire(v_u5)
	end
end
v_u_replicatedstorage:GetAttributeChangedSignal("AvaiableSkins"):Connect(function()
	-- upvalues: (copy) v_u_replicatedstorage, (ref) v_u5, (copy) v_u_http, (copy) v_u_new
	local v_avaiableskins = v_u_replicatedstorage:GetAttribute("AvaiableSkins")
	if v_avaiableskins then
		v_u5 = v_u_http:JSONDecode(v_avaiableskins)
		if #v_u_new:GetConnections() > 0 then
			v_u_new:Fire(v_u5)
		end
	else
		return
	end
end)
return v_u1