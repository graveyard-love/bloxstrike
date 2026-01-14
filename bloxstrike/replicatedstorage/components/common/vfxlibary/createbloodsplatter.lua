-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_players = game:GetService("Players")
local v_u_debris = game:GetService("Debris")
local v_u_debris = workspace:WaitForChild("Debris")
local v_u1 = require(v_u_replicatedstorage.Components.Common.GetRayIgnore)
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local v_u2 = {
	"rbxassetid://8635071092",
	"rbxassetid://8634747192",
	"rbxassetid://15067037717",
	"rbxassetid://18779968078"
}
local function v_u3(arg1, arg2, arg3)
	local v1 = arg1.Magnitude == 1
	if arg1.Magnitude <= 0 then
		return Vector3.new(0, 0, 0)
	end
	local v_x = arg1.X
	local v_y = arg1.Y
	local v_z = arg1.Z
	local v2 = nil
	local v3 = nil
	local v4 = nil
	if arg2 == Enum.Axis.Z then
		v2 = v_x * math.cos(arg3) - v_y * math.sin(arg3)
		v3 = v_x * math.sin(arg3) + v_y * math.cos(arg3)
	elseif arg2 == Enum.Axis.X then
		v3 = -v_y * math.cos(arg3) + v_z * math.sin(arg3)
		v4 = v_y * math.sin(arg3) + v_z * math.cos(arg3)
		v2 = v_x
	elseif arg2 == Enum.Axis.Y then
		v2 = v_x * math.cos(arg3) - v_z * math.sin(arg3)
		v4 = v_x * math.sin(arg3) + v_z * math.cos(arg3)
		v3 = v_y
	end
	local v_new = Vector3.new(math.floor(v2 / 0.001 + 0.5) * 0.001, math.floor(v3 / 0.001 + 0.5) * 0.001, math.floor(v4 / 0.001 + 0.5) * 0.001)
	if v1 then
		v_new = v_new.Unit
	end
	assert(v_new == v_new, string.format("rotated vector nan %e %e %e -> %e %e %e", arg1.X, arg1.Y, arg1.Z, v_new.X, v_new.Y, v_new.Z))
	return v_new
end
local function v_u4()
	-- upvalues: (copy) v_u1, (copy) v_u_players, (copy) v_u_new
	local v1 = v_u1()
	for _, v2 in ipairs(v_u_players:GetPlayers()) do
		if v2.Character then
			table.insert(v1, v2.Character)
		end
	end
	v_u_new.FilterDescendantsInstances = v1
end
local function v_u5(arg1, arg2)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_debris, (copy) v_u2, (copy) v_u_tween, (copy) v_u_debris
	local v_clone = v_u_replicatedstorage.Assets.Other.BloodSplatter:Clone()
	v_clone.CFrame = arg1
	v_clone.CollisionGroup = "Debris"
	v_clone.CanCollide = false
	v_clone.CanQuery = false
	v_clone.CanTouch = false
	v_clone.Anchored = true
	v_clone.Size = arg2
	v_clone.Parent = v_u_debris
	for _, v1 in ipairs(v_clone:GetDescendants()) do
		if v1:IsA("Decal") then
			v1.Texture = v_u2[math.random(1, #v_u2)]
			v1.Color3 = Color3.fromRGB(126, 16, 24)
			v_u_tween:Create(v1, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				["Color3"] = Color3.fromRGB(70, 10, 15),
				["Transparency"] = 1
			}):Play()
		end
	end
	v_u_debris:AddItem(v_clone, 15)
	return v_clone
end
local function v_u6(arg1, arg2, arg3)
	-- upvalues: (copy) v_u5
	local v1 = arg1.Y / 2
	local v2 = arg1.X / 2
	local v_position = arg2.Position
	local v_normal = arg2.Normal
	local v3 = -v_normal
	local v_new = CFrame.new(v_position, v_position + v3 * 0.1)
	local v4 = v_position + v_normal
	local v5 = v1
	local v6 = v2
	local v7 = false
	for v8 = 0, 10 do
		v5 = v1 - v8 / 2
		v6 = v2 - v8 / 2
		local v_raycast = workspace:Raycast(v4 + v_new.UpVector * v5 - v_new.RightVector * v6, v3 * 2, arg3)
		local v_raycast = workspace:Raycast(v4 + v_new.UpVector * v5 + v_new.RightVector * v6, v3 * 2, arg3)
		local v_raycast = workspace:Raycast(v4 - v_new.UpVector * v5 - v_new.RightVector * v6, v3 * 2, arg3)
		local v_raycast = workspace:Raycast(v4 - v_new.UpVector * v5 + v_new.RightVector * v6, v3 * 2, arg3)
		if v_raycast and (v_raycast and (v_raycast and (v_raycast and (v_raycast.Normal:Angle(v_raycast.Normal) <= 1.5707963267948966 and (v_raycast.Normal:Angle(v_raycast.Normal) <= 1.5707963267948966 and v_raycast.Normal:Angle(v_raycast.Normal) <= 1.5707963267948966))))) then
			v7 = true
			break
		end
	end
	if v7 then
		local v_new = Vector3.new(v6 * 2, v5 * 2, 0.001)
		v_u5(CFrame.new(arg2.Position, arg2.Position + arg2.Normal) * CFrame.Angles(3.141592653589793, 0, 0) + arg2.Normal * 0.25, v_new)
	end
end
local function v_u7(arg1, arg2, arg3)
	-- upvalues: (copy) v_u3, (copy) v_u6
	local v_raycast = workspace:Raycast(arg1, v_u3(arg2, Enum.Axis.Y, -0.2617993877991494), arg3)
	local v_raycast = workspace:Raycast(arg1, arg2, arg3)
	local v_raycast = workspace:Raycast(arg1, v_u3(arg2, Enum.Axis.Y, 0.2617993877991494), arg3)
	local v1
	if v_raycast then
		if v_raycast then
			if v_raycast.Instance == v_raycast.Instance then
				v1 = v_raycast.Normal == v_raycast.Normal
			else
				v1 = false
			end
		else
			v1 = v_raycast
		end
	else
		v1 = v_raycast
	end
	local v2
	if v_raycast then
		if v_raycast then
			if v_raycast.Instance == v_raycast.Instance then
				v2 = v_raycast.Normal == v_raycast.Normal
			else
				v2 = false
			end
		else
			v2 = v_raycast
		end
	else
		v2 = v_raycast
	end
	local v3 = nil
	if v_raycast then
		v3 = Vector3.new(4, 4, 0) * (math.clamp(v_raycast.Distance, 2, 14) * 0.2) + Vector3.new(0, 0, 0.001)
	elseif v_raycast then
		v3 = Vector3.new(4, 4, 0) * (math.clamp(v_raycast.Distance, 2, 14) * 0.2) + Vector3.new(0, 0, 0.001)
	elseif v_raycast then
		v3 = Vector3.new(4, 4, 0) * (math.clamp(v_raycast.Distance, 2, 14) * 0.2) + Vector3.new(0, 0, 0.001)
	end
	if v3 then
		if v_raycast then
			v_u6(v3, v_raycast, arg3)
		end
		if v_raycast and not v1 then
			v_u6(v3, v_raycast, arg3)
		end
		if v_raycast and not v2 then
			v_u6(v3, v_raycast, arg3)
		end
	end
end
local function v_u8(arg1)
	-- upvalues: (copy) v_u5
	v_u5(CFrame.new(arg1.Position, arg1.Position + arg1.Normal) * CFrame.Angles(3.141592653589793, 0, 0) + arg1.Normal * 0.25, Vector3.new(4, 4, 0) * (math.clamp(arg1.Distance, 2, 14) * 0.2) + Vector3.new(0, 0, 0.001))
end
return function(_, _) end