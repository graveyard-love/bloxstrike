-- Decompiled with Bunni.lol Decompiler

local v_u_vr = game:GetService("VRService")
local v_u1 = {
	"BasePart",
	"Decal",
	"Beam",
	"ParticleEmitter",
	"Trail",
	"Fire",
	"Smoke",
	"Sparkles",
	"Explosion"
}
local v_u2 = require(script.Parent:WaitForChild("CameraUtils"))
local v3, v4 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserHideCharacterParticlesInFirstPerson")
end)
local v_u5 = v3 and v4
local v_u6 = {}
v_u6.__index = v_u6
function v_u6.new()
	-- upvalues: (copy) v_u6
	local v1 = setmetatable({}, v_u6)
	v1.transparencyDirty = false
	v1.enabled = false
	v1.lastTransparency = nil
	v1.descendantAddedConn = nil
	v1.descendantRemovingConn = nil
	v1.toolDescendantAddedConns = {}
	v1.toolDescendantRemovingConns = {}
	v1.cachedParts = {}
	return v1
end
function v_u6.HasToolAncestor(arg1, arg2)
	if arg2.Parent == nil then
		return false
	end
	assert(arg2.Parent, "")
	return arg2.Parent:IsA("Tool") or arg1:HasToolAncestor(arg2.Parent)
end
function v_u6.IsValidPartToModify(arg1, arg2)
	-- upvalues: (ref) v_u5, (copy) v_u1
	if v_u5 then
		for _, v1 in v_u1 do
			if arg2:IsA(v1) then
				return not arg1:HasToolAncestor(arg2)
			end
		end
	elseif arg2:IsA("BasePart") or arg2:IsA("Decal") then
		return not arg1:HasToolAncestor(arg2)
	end
	return false
end
function v_u6.CachePartsRecursive(arg1, arg2)
	if arg2 then
		if arg1:IsValidPartToModify(arg2) then
			arg1.cachedParts[arg2] = true
			arg1.transparencyDirty = true
		end
		for _, v1 in pairs(arg2:GetChildren()) do
			arg1:CachePartsRecursive(v1)
		end
	end
end
function v_u6.TeardownTransparency(arg1)
	for v1, _ in pairs(arg1.cachedParts) do
		v1.LocalTransparencyModifier = 0
	end
	arg1.cachedParts = {}
	arg1.transparencyDirty = true
	arg1.lastTransparency = nil
	if arg1.descendantAddedConn then
		arg1.descendantAddedConn:disconnect()
		arg1.descendantAddedConn = nil
	end
	if arg1.descendantRemovingConn then
		arg1.descendantRemovingConn:disconnect()
		arg1.descendantRemovingConn = nil
	end
	for v2, v3 in pairs(arg1.toolDescendantAddedConns) do
		v3:Disconnect()
		arg1.toolDescendantAddedConns[v2] = nil
	end
	for v4, v5 in pairs(arg1.toolDescendantRemovingConns) do
		v5:Disconnect()
		arg1.toolDescendantRemovingConns[v4] = nil
	end
end
function v_u6.SetupTransparency(arg1, arg2)
	arg1:TeardownTransparency()
	if arg1.descendantAddedConn then
		arg1.descendantAddedConn:disconnect()
	end
	arg1.descendantAddedConn = arg2.DescendantAdded:Connect(function(arg1)
		-- upvalues: (copy) arg1, (copy) arg2
		if arg1:IsValidPartToModify(arg1) then
			arg1.cachedParts[arg1] = true
			arg1.transparencyDirty = true
		elseif arg1:IsA("Tool") then
			if arg1.toolDescendantAddedConns[arg1] then
				arg1.toolDescendantAddedConns[arg1]:Disconnect()
			end
			arg1.toolDescendantAddedConns[arg1] = arg1.DescendantAdded:Connect(function(arg1)
				-- upvalues: (ref) arg1
				arg1.cachedParts[arg1] = nil
				if arg1:IsA("BasePart") or arg1:IsA("Decal") then
					arg1.LocalTransparencyModifier = 0
				end
			end)
			if arg1.toolDescendantRemovingConns[arg1] then
				arg1.toolDescendantRemovingConns[arg1]:disconnect()
			end
			arg1.toolDescendantRemovingConns[arg1] = arg1.DescendantRemoving:Connect(function(arg1)
				-- upvalues: (ref) arg2, (ref) arg1
				wait()
				if arg2 and (arg1 and (arg1:IsDescendantOf(arg2) and arg1:IsValidPartToModify(arg1))) then
					arg1.cachedParts[arg1] = true
					arg1.transparencyDirty = true
				end
			end)
		end
	end)
	if arg1.descendantRemovingConn then
		arg1.descendantRemovingConn:disconnect()
	end
	arg1.descendantRemovingConn = arg2.DescendantRemoving:connect(function(arg1)
		-- upvalues: (copy) arg1
		if arg1.cachedParts[arg1] then
			arg1.cachedParts[arg1] = nil
			arg1.LocalTransparencyModifier = 0
		end
	end)
	arg1:CachePartsRecursive(arg2)
end
function v_u6.Enable(arg1, arg2)
	if arg1.enabled ~= arg2 then
		arg1.enabled = arg2
	end
end
function v_u6.SetSubject(arg1, arg2)
	local v1
	if arg2 and arg2:IsA("Humanoid") then
		v1 = arg2.Parent
	else
		v1 = nil
	end
	if arg2 and (arg2:IsA("VehicleSeat") and arg2.Occupant) then
		v1 = arg2.Occupant.Parent
	end
	if v1 then
		arg1:SetupTransparency(v1)
	else
		arg1:TeardownTransparency()
	end
end
function v_u6.Update(arg1, arg2)
	-- upvalues: (copy) v_u2, (copy) v_u_vr
	local v_current_camera = workspace.CurrentCamera
	if v_current_camera and arg1.enabled then
		local v_magnitude = (v_current_camera.Focus.p - v_current_camera.CoordinateFrame.p).magnitude
		local v1 = v_magnitude < 2 and 1 - (v_magnitude - 0.5) / 1.5 or 0
		local v2 = v1 < 0.5 and 0 or v1
		if arg1.lastTransparency and (v2 < 1 and arg1.lastTransparency < 0.95) then
			local v_clamp = math.clamp(v2 - arg1.lastTransparency, -(2.8 * arg2), 2.8 * arg2)
			v2 = arg1.lastTransparency + v_clamp
		else
			arg1.transparencyDirty = true
		end
		local v_round = v_u2.Round(v2, 2)
		local v_clamp = math.clamp(v_round, 0, 1)
		if arg1.transparencyDirty or arg1.lastTransparency ~= v_clamp then
			for v3, _ in pairs(arg1.cachedParts) do
				if v_u_vr.VREnabled and v_u_vr.AvatarGestures then
					if v3.Parent:IsA("Accessory") and ({
						[Enum.AccessoryType.Hat] = true,
						[Enum.AccessoryType.Hair] = true,
						[Enum.AccessoryType.Face] = true,
						[Enum.AccessoryType.Eyebrow] = true,
						[Enum.AccessoryType.Eyelash] = true
					})[v3.Parent.AccessoryType] or v3.Name == "Head" then
						v3.LocalTransparencyModifier = v_clamp
					else
						v3.LocalTransparencyModifier = 0
					end
				else
					v3.LocalTransparencyModifier = v_clamp
				end
			end
			arg1.transparencyDirty = false
			arg1.lastTransparency = v_clamp
		end
	end
end
return v_u6