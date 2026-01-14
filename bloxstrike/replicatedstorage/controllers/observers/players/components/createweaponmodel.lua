-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u1 = require(v_replicatedstorage.Shared.DebugFlags)
local v_u2 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u3 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
local v_u4 = { "PrimaryAttachment", "SecondaryAttachment", "MeleeAttachment" }
local v_u5 = {
	["MuzzlePartL"] = 1,
	["MuzzlePartR"] = 1,
	["MuzzlePart"] = 1,
	["RootPart"] = 1,
	["Hitbox"] = 1,
	["Insert"] = 1,
	["move"] = 1
}
local v_u6 = {
	["AWP"] = "UpperTorso",
	["C4"] = "LeftHand"
}
local v_u7 = {}
local v_u8 = {}
local function v_u9(arg1, arg2, ...)
	-- upvalues: (copy) v_u1
	if v_u1.IsEnabled("ThirdPersonWeaponModels") then
		warn((not arg1 and "[ThirdPersonWeaponModels] " or "[ThirdPersonWeaponModels] " .. arg1.Name .. " - ") .. arg2:format(...))
	end
end
local function v_u10(arg1)
	for _, v1 in ipairs(arg1:GetDescendants()) do
		if v1:IsA("BasePart") then
			v1.CollisionGroup = "WeaponModel"
			v1.CastShadow = false
			v1.CanCollide = false
			v1.CanTouch = false
			v1.CanQuery = false
			v1.Anchored = false
			v1.Massless = true
		end
	end
end
local function v_u11(arg1)
	-- upvalues: (copy) v_u5
	for v1, v2 in pairs(v_u5) do
		local v3 = arg1:FindFirstChild(v1, true)
		if v3 then
			v3.Transparency = v2
		end
	end
end
local function v_u12(arg1, arg2)
	-- upvalues: (copy) v_u11
	for _, v1 in ipairs(arg1:GetDescendants()) do
		if v1:IsA("BasePart") then
			v1.Transparency = arg2 and 0 or 1
		end
	end
	v_u11(arg1)
end
local function v_u13(arg1, arg2)
	local v_parent = arg2.Parent
	if not (v_parent and v_parent:IsA("BasePart")) then
		error((("Character attachment parent is not a BasePart: %*"):format(arg2.Name)))
	end
	local v_u1 = arg1:FindFirstChild("Insert", true) or arg1.PrimaryPart
	if not v_u1 then
		error("Weapon model has no PrimaryPart or Insert part")
	end
	local v_u_weaponattachment = v_u1:FindFirstChild("WeaponAttachment")
	if not v_u_weaponattachment then
		v_u_weaponattachment = Instance.new("Attachment")
		v_u_weaponattachment.Name = "WeaponAttachment"
		v_u_weaponattachment.Parent = v_u1
	end
	local v2, v3 = pcall(function()
		-- upvalues: (copy) v_u1, (copy) arg2, (copy) v_u_weaponattachment
		local v_attachmentconstraint = Instance.new("AttachmentConstraint")
		v_attachmentconstraint.Parent = v_u1
		v_attachmentconstraint.Attachment0 = arg2
		v_attachmentconstraint.Attachment1 = v_u_weaponattachment
		return v_attachmentconstraint
	end)
	if not v2 then
		v_u1.CFrame = v_parent.CFrame * arg2.CFrame * v_u_weaponattachment.CFrame:Inverse()
		v3 = Instance.new("WeldConstraint")
		v3.Parent = v_u1
		v3.Part0 = v_parent
		v3.Part1 = v_u1
	end
	return v3
end
local function v_u14(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
	-- upvalues: (copy) v_u3, (copy) v_u10, (copy) v_u11, (copy) v_u4, (copy) v_u9, (copy) v_u13, (copy) v_u7
	local v1 = nil
	local v2
	if arg4 == "Smoke Grenade" then
		v2 = arg1:GetAttribute("Team")
		if v2 ~= "Counter-Terrorists" and v2 ~= "Terrorists" then
			v2 = v1
		end
	else
		v2 = v1
	end
	local v_getcharactermodel = v_u3.GetCharacterModel(arg4, arg5, arg6, arg7, arg8, arg9, arg10, v2)
	v_u10(v_getcharactermodel)
	v_u11(v_getcharactermodel)
	local v3 = v_u4[arg3]
	local v4
	if v3 then
		v4 = arg2:FindFirstChild(v3, true)
	else
		v4 = nil
	end
	if not v4 then
		v_u9(arg1, "missing character attachment for slot=%d weapon=%s (expected %s)", arg3, arg4, (tostring(v_u4[arg3])))
		error((("Missing character attachment for slot: %*"):format(arg3)))
	end
	v_u13(v_getcharactermodel, v4)
	local v_debris = workspace:FindFirstChild("Debris")
	if v_debris then
		local v5 = arg1.Name .. "_WeaponAttachments"
		local v6 = v_debris:FindFirstChild(v5)
		if not v6 then
			v6 = Instance.new("Folder")
			v6.Name = v5
			v6.Parent = v_debris
		end
		v_getcharactermodel.Parent = v6
		v_getcharactermodel.Name = arg4
	end
	local v7 = v_u7[arg1] or {
		["Character"] = nil
	}
	v_u7[arg1] = v7
	v7[arg3] = {
		["StatTrack"] = arg7,
		["Stickers"] = arg10,
		["NameTag"] = arg8,
		["Model"] = v_getcharactermodel,
		["Float"] = arg6,
		["Charm"] = arg9,
		["Weapon"] = arg4,
		["Skin"] = arg5
	}
	v_u9(arg1, "cached holster slot=%d weapon=%s skin=%s visible=%s", arg3, arg4, arg5, "unknown")
	return v_getcharactermodel
end
local function v_u15(arg1)
	-- upvalues: (copy) v_u8, (copy) v_u7, (copy) v_u9
	local v1 = v_u8[arg1]
	if v1 then
		v1:Disconnect()
		v_u8[arg1] = nil
	end
	local v2 = v_u7[arg1]
	if v2 then
		for v3, v4 in pairs(v2) do
			if v4 and (typeof(v3) == "number" and typeof(v4) == "table") then
				if v4.Model then
					v4.Model:Destroy()
				end
				v2[v3] = nil
			end
		end
		local v_debris = workspace:FindFirstChild("Debris")
		if v_debris then
			local v5 = v_debris:FindFirstChild(arg1.Name .. "_Weapon")
			if v5 then
				v5:Destroy()
			end
			local v6 = v_debris:FindFirstChild(arg1.Name .. "_WeaponAttachments")
			if v6 then
				v6:Destroy()
			end
		end
		v_u9(arg1, "cleared player cache (destroyed holsters)")
		v_u7[arg1] = nil
	end
end
local function v_u16(arg1, arg2)
	-- upvalues: (copy) v_u7, (copy) v_u15, (copy) v_u8
	local v1 = v_u7[arg1] or {
		["Character"] = nil
	}
	v_u7[arg1] = v1
	if v1.Character ~= arg2 then
		if v1.Character then
			v_u15(arg1)
			v1 = v_u7[arg1] or {
				["Character"] = nil
			}
			v_u7[arg1] = v1
		end
		v1.Character = arg2
		local v2 = v_u8[arg1]
		if v2 then
			v2:Disconnect()
		end
		v_u8[arg1] = arg2.AncestryChanged:Connect(function(_, arg2)
			-- upvalues: (copy) arg1, (ref) v_u7
			if not arg2 or arg2.Name == "Debris" then
				local v_debris = workspace:FindFirstChild("Debris")
				if v_debris then
					local v1 = v_debris:FindFirstChild(arg1.Name .. "_Weapon")
					if v1 then
						v1:Destroy()
					end
					local v2 = v_debris:FindFirstChild(arg1.Name .. "_WeaponAttachments")
					if v2 then
						v2:Destroy()
					end
				end
				local v3 = v_u7[arg1]
				if v3 then
					for v4, v5 in pairs(v3) do
						if v5 and (typeof(v4) == "number" and typeof(v5) == "table") then
							v3[v4] = nil
						end
					end
					v3.Character = nil
				end
			end
		end)
	end
end
local function v_u17(arg1, arg2, arg3, arg4, arg5)
	-- upvalues: (copy) v_u2, (copy) v_u7, (copy) v_u12, (copy) v_u9, (copy) v_u14
	local v1 = v_u2(arg4.Weapon)
	if not v1 or v1.ShootingOptions ~= "Dual" then
		local v2 = v_u7[arg1] or {
			["Character"] = nil
		}
		v_u7[arg1] = v2
		local v3 = v2[arg3]
		if v3 then
			if v3.Skin == arg4.Skin and (v3.Weapon == arg4.Weapon and v3.Model) then
				local v_skin = v3.Skin
				local v4
				if v3.Weapon == arg5.Name then
					v4 = v_skin == arg5.Skin
				else
					v4 = false
				end
				v_u12(v3.Model, not v4)
				return
			end
			if v3.Model then
				v3.Model:Destroy()
			end
		end
		v2[arg3] = nil
		local v_skin = arg4.Skin
		local v5
		if arg4.Weapon == arg5.Name then
			v5 = v_skin == arg5.Skin
		else
			v5 = false
		end
		v_u9(arg1, "holster slot=%d weapon=%s skin=%s equippedInHand=%s", arg3, arg4.Weapon, arg4.Skin, (tostring(v5)))
		v_u12(v_u14(arg1, arg2, arg3, arg4.Weapon, arg4.Skin, arg4.Float, arg4.StatTrack, arg4.NameTag, arg4.Charm, arg4.Stickers), not v5)
	end
end
local function v_u18(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u16, (copy) v_u7, (copy) v_u17
	v_u16(arg1, arg2)
	if not arg4[1] then
		local v1 = v_u7[arg1]
		local v2 = v1 and v1[1]
		if v2 then
			local v_model = v2.Model
			if v_model then
				v_model:Destroy()
			end
			v1[1] = nil
		end
	end
	if not arg4[2] then
		local v3 = v_u7[arg1]
		local v4 = v3 and v3[2]
		if v4 then
			local v_model = v4.Model
			if v_model then
				v_model:Destroy()
			end
			v3[2] = nil
		end
	end
	if not arg4[3] then
		local v5 = v_u7[arg1]
		local v6 = v5 and v5[3]
		if v6 then
			local v_model = v6.Model
			if v_model then
				v_model:Destroy()
			end
			v5[3] = nil
		end
	end
	for v7, v8 in pairs(arg4) do
		if v8 then
			v_u17(arg1, arg2, v7, v8, arg3)
		end
	end
end
local function v_u19(arg1, arg2, arg3)
	local v_motor6d = Instance.new("Motor6D")
	v_motor6d.Name = "WeaponAttachment" .. (arg3 or "")
	v_motor6d.Parent = arg1
	v_motor6d.Part0 = arg1
	v_motor6d.Part1 = arg3 and arg2:FindFirstChild(arg3, true) or arg2.PrimaryPart
	local v_properties = arg2:FindFirstChild("Properties")
	if v_properties then
		for _, v1 in ipairs(arg3 and { "LEFT", "RIGHT" } or { "" }) do
			local v2 = v_properties:FindFirstChild("C0" .. v1)
			if v2 then
				v_motor6d.C0 = v2.Value
			end
			local v3 = v_properties:FindFirstChild("C1" .. v1)
			if v3 then
				v_motor6d.C1 = v3.Value
			end
		end
	end
	return v_motor6d
end
local function v_u20(arg1, arg2)
	-- upvalues: (copy) v_u19
	local v_righthand = arg1:FindFirstChild("RightHand")
	local v_lefthand = arg1:FindFirstChild("LeftHand")
	if v_righthand and v_lefthand then
		v_u19(v_righthand, arg2, "HandleR")
		v_u19(v_lefthand, arg2, "HandleL")
	else
		warn("CreateDualMotor6DAttachments: Could not find RightHand or LeftHand for dual weapon")
	end
end
local function v_u21(arg1, arg2, arg3)
	local v_weaponattachment = arg3:FindFirstChild("WeaponAttachment")
	arg2:ClearAllChildren()
	local v_debris = workspace:FindFirstChild("Debris")
	local v1 = v_debris and v_debris:FindFirstChild(arg1.Name .. "_Weapon")
	if v1 then
		v1:Destroy()
	end
	if v_weaponattachment then
		v_weaponattachment:Destroy()
	end
	local v_weaponattachmenthandler = arg3:FindFirstChild("WeaponAttachmentHandleR")
	if v_weaponattachmenthandler then
		v_weaponattachmenthandler:Destroy()
	end
end
local function v_u22(arg1, arg2, arg3)
	-- upvalues: (copy) v_u6, (copy) v_u2, (copy) v_u21, (copy) v_u3, (copy) v_u10, (copy) v_u11, (copy) v_u20, (copy) v_u19
	local v_parent = arg2.Parent
	if not v_parent or v_parent.Name == "Debris" then
		return nil, nil
	end
	local v_name = arg3.Name
	local v1 = v_u6[v_name] or "RightHand"
	local v2 = arg2:WaitForChild(v1, 10)
	local v_format = ("Failed to get joint part: %* for weapon: %*"):format(v1, v_name)
	assert(v2, v_format)
	local v3 = v_u2(arg3.Name)
	local v_weaponmodel = arg2:FindFirstChild("WeaponModel")
	if not v_weaponmodel then
		return nil, nil
	end
	v_u21(arg1, v_weaponmodel, v2)
	local v_lefthand = arg2:FindFirstChild("LeftHand")
	local v4 = v_lefthand and v_lefthand:FindFirstChild("WeaponAttachmentHandleL")
	if v4 then
		v4:Destroy()
	end
	local v5 = nil
	local v6
	if arg3.Name == "Smoke Grenade" then
		v6 = arg1:GetAttribute("Team")
		if v6 ~= "Counter-Terrorists" and v6 ~= "Terrorists" then
			v6 = v5
		end
	else
		v6 = v5
	end
	local v_getcharactermodel = v_u3.GetCharacterModel(arg3.Name, arg3.Skin, arg3.Float, arg3.StatTrack, arg3.NameTag, arg3.Charm, arg3.Stickers, v6)
	v_u10(v_getcharactermodel)
	v_u11(v_getcharactermodel)
	local v_issuppressed = arg3.IsSuppressed
	local v_silencer = v_getcharactermodel:FindFirstChild("Silencer", true)
	if v_silencer and v3.HasSuppressor then
		v_silencer.Transparency = v_issuppressed and 0 or 1
	end
	if v3.ShootingOptions == "Dual" then
		v_u20(arg2, v_getcharactermodel)
	else
		v_u19(v2, v_getcharactermodel, nil)
	end
	local v_debris = workspace:FindFirstChild("Debris")
	if v_debris then
		v_getcharactermodel.Parent = v_debris
		v_getcharactermodel.Name = arg1.Name .. "_Weapon"
		v_getcharactermodel:SetAttribute("PersistentDebris", true)
	end
	return v_getcharactermodel, v2
end
local function v_u23(arg1, arg2, arg3)
	-- upvalues: (copy) v_u22, (copy) v_u18, (copy) v_u15
	local v_character = arg1.Character
	if v_character then
		local _, v1 = v_u22(arg1, v_character, arg2)
		if v1 then
			v_u18(arg1, v_character, arg2, arg3)
			return v1, v_u15
		end
	end
	return nil, nil
end
local v24 = setmetatable({}, {
	["__call"] = function(_, ...)
		-- upvalues: (copy) v_u23
		return v_u23(...)
	end
})
v24.ClearPlayerCache = v_u15
v_players.PlayerRemoving:Connect(function(arg1)
	-- upvalues: (copy) v_u15
	v_u15(arg1)
end)
return v24