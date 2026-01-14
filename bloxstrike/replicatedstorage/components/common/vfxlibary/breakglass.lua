-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_debris = workspace:WaitForChild("Debris")
local v_u1 = require(v_replicatedstorage.Shared.Janitor)
local v_u2 = require(v_replicatedstorage.Classes.Sound)
local v_u_wedgepart = Instance.new("WedgePart", script)
v_u_wedgepart.BottomSurface = Enum.SurfaceType.Smooth
v_u_wedgepart.TopSurface = Enum.SurfaceType.Smooth
v_u_wedgepart.Anchored = true
local function v_u3(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_wedgepart
	local v1 = arg2 - arg1
	local v2 = arg3 - arg1
	local v3 = arg3 - arg2
	local v_dot = v1:Dot(v1)
	local v_dot = v2:Dot(v2)
	local v_dot = v3:Dot(v3)
	if v_dot < v_dot and v_dot < v_dot then
		local v4 = arg3
		arg3 = arg1
		arg1 = arg2
		arg2 = v4
	elseif v_dot < v_dot then
		if v_dot >= v_dot then
			local v5 = arg2
			arg2 = arg1
			arg1 = v5
		end
	else
		local v6 = arg2
		arg2 = arg1
		arg1 = v6
	end
	local v7 = arg1 - arg2
	local v8 = arg3 - arg2
	local v9 = arg3 - arg1
	local v_unit = v8:Cross(v7).Unit
	local v_unit = v9:Cross(v_unit).Unit
	local v_unit = v9.Unit
	local v_dot = v7:Dot(v_unit)
	local v_abs = math.abs(v_dot)
	local v_clone = v_u_wedgepart:Clone()
	local v_dot = v7:Dot(v_unit)
	local v_abs = math.abs(v_dot)
	v_clone.Size = Vector3.new(0, v_abs, v_abs)
	v_clone.CFrame = CFrame.fromMatrix((arg2 + arg1) / 2, v_unit, v_unit, v_unit)
	v_clone.Parent = arg4
	local v_clone = v_u_wedgepart:Clone()
	local v_dot = v8:Dot(v_unit)
	local v_abs = math.abs(v_dot)
	v_clone.Size = Vector3.new(0, v_abs, v_abs)
	v_clone.CFrame = CFrame.fromMatrix((arg2 + arg3) / 2, -v_unit, v_unit, -v_unit)
	v_clone.Parent = arg4
	return v_clone, v_clone
end
return function(arg1, arg2, arg3)
	-- upvalues: (copy) v_u1, (copy) v_u3, (copy) v_u_debris, (copy) v_u_tween, (copy) v_u2
	local v1 = {}
	if arg1 then
		local v_u_new = v_u1.new()
		if arg1.Size.Z > arg1.Size.X then
			table.insert(v1, arg1.CFrame * CFrame.new(0, arg1.Size.Y * 0.5, arg1.Size.Z * 0.5))
			table.insert(v1, arg1.CFrame * CFrame.new(0, arg1.Size.Y * 0.5, 0))
			table.insert(v1, arg1.CFrame * CFrame.new(0, arg1.Size.Y * 0.5, -arg1.Size.Z * 0.5))
			table.insert(v1, arg1.CFrame * CFrame.new(0, 0, -arg1.Size.Z * 0.5))
			table.insert(v1, arg1.CFrame * CFrame.new(0, -arg1.Size.Y * 0.5, -arg1.Size.Z * 0.5))
			table.insert(v1, arg1.CFrame * CFrame.new(0, -arg1.Size.Y * 0.5, 0))
			table.insert(v1, arg1.CFrame * CFrame.new(0, -arg1.Size.Y * 0.5, arg1.Size.Z * 0.5))
			table.insert(v1, arg1.CFrame * CFrame.new(0, 0, arg1.Size.Z * 0.5))
		else
			table.insert(v1, arg1.CFrame * CFrame.new(arg1.Size.X * 0.5, arg1.Size.Y * 0.5, 0))
			table.insert(v1, arg1.CFrame * CFrame.new(0, arg1.Size.Y * 0.5, 0))
			table.insert(v1, arg1.CFrame * CFrame.new(-arg1.Size.X * 0.5, arg1.Size.Y * 0.5, 0))
			table.insert(v1, arg1.CFrame * CFrame.new(-arg1.Size.X * 0.5, 0, 0))
			table.insert(v1, arg1.CFrame * CFrame.new(-arg1.Size.X * 0.5, -arg1.Size.Y * 0.5, 0))
			table.insert(v1, arg1.CFrame * CFrame.new(0, -arg1.Size.Y * 0.5, 0))
			table.insert(v1, arg1.CFrame * CFrame.new(arg1.Size.X * 0.5, -arg1.Size.Y * 0.5, 0))
			table.insert(v1, arg1.CFrame * CFrame.new(arg1.Size.X * 0.5, 0, 0))
		end
		for v2, v3 in ipairs(v1) do
			local v_u4, v_u5 = v_u3(v3.Position, (v1[v2 + 1] or v1[1]).Position, arg2, v_u_debris)
			for _, v6 in ipairs({ v_u4, v_u5 }) do
				v6.Transparency = math.min(arg1.Transparency, 0.6)
				v6.AssemblyLinearVelocity = arg3 * 15
				v6.CollisionGroup = "Debris"
				v6.Color = arg1.Color
				v6.Anchored = false
			end
			v_u_new:Add(v_u4)
			v_u_new:Add(v_u5)
			task.delay(4.75, function()
				-- upvalues: (copy) v_u_new, (ref) v_u_tween, (copy) v_u4, (copy) v_u5
				v_u_new:Add(v_u_tween:Create(v_u4, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
					["Transparency"] = 1
				})):Play()
				v_u_new:Add(v_u_tween:Create(v_u5, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
					["Transparency"] = 1
				})):Play()
			end)
		end
		arg1.CollisionGroup = "Debris"
		arg1.Transparency = 1
		arg1.CanCollide = false
		arg1.CastShadow = false
		arg1.CanQuery = false
		arg1.CanTouch = false
		arg1.Anchored = true
		v_u2.new("Bullet"):playOneTime({
			["Name"] = "Glass Shattered",
			["Parent"] = arg1
		})
		v_u_new:Add(arg1)
		local v_parent = arg1.Parent
		if v_parent and (v_parent:IsA("Model") and v_parent:HasTag("BreakableGlass")) then
			v_u_new:Add(v_parent)
			for _, v7 in ipairs(v_parent:GetDescendants()) do
				if v7:IsA("Decal") then
					v7:Destroy()
				end
			end
		end
		task.delay(5, function()
			-- upvalues: (copy) v_u_new
			v_u_new:Destroy()
		end)
	end
end