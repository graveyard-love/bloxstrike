-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Shared.Janitor)
local v_u3 = require(v_replicatedstorage.Shared.Spring)
local v_u_current_camera = workspace.CurrentCamera
local v_u4 = Vector2.new(0.02, 0.015) / 50
local function v_u5(arg1, arg2)
	for _, v1 in pairs(arg1:GetDescendants()) do
		if v1:IsA("MeshPart") then
			v1.Transparency = arg2 == true and 0 or 1
		elseif v1:IsA("SurfaceGui") then
			v1.Enabled = arg2
		end
	end
end
local function v_u6(arg1, arg2)
	if arg1 and arg2 then
		if arg1.ClassName == "Model" and arg2.ClassName == "Model" then
			local function v1(arg1)
				for _, v1 in pairs(arg1:GetChildren()) do
					if v1.ClassName == "SurfaceAppearance" then
						v1:Destroy()
					end
				end
			end
			for _, v2 in pairs(arg1:GetChildren()) do
				local v3 = arg2:FindFirstChild(v2.Name)
				if v3 then
					local v_surfaceappearance = v3:FindFirstChildWhichIsA("SurfaceAppearance")
					if v_surfaceappearance then
						local v_clone = v_surfaceappearance:Clone()
						v_clone.Name = v3.Name
						v1(v2)
						v_clone.Parent = v2
					end
				end
			end
		end
	else
		return
	end
end
function v_u1.addScopeKick(arg1)
	if not arg1.IsDestroyed and arg1.ScopeSpring then
		arg1.ScopeSpring:impulse(Vector2.new(5, 1))
	end
end
function v_u1.getMovementVelocity(arg1)
	-- upvalues: (copy) v_u_current_camera
	if not arg1.Character or UNNAMED_1728998745176.PrimaryPart.AssemblyLinearVelocity.Magnitude <= 0.1 then
		return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
	end
	local v1 = UNNAMED_1728998745272.Unit * math.min(UNNAMED_1728998745272.Magnitude, 50)
	return v1, v_u_current_camera.CFrame:VectorToObjectSpace(v1)
end
function v_u1.getNextCFrame(arg1, arg2)
	-- upvalues: (copy) v_u_current_camera, (copy) v_u4
	if arg1.IsDestroyed or not (arg1.MovementShiftSpring and (arg1.CameraShiftSpring and (arg1.BobbleSpring and arg1.ScopeSpring))) then
		return CFrame.identity, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
	end
	local v1 = (arg2 <= 0 or arg2 ~= arg2) and 0.016666666666666666 or arg2
	local v_getmovementvelocity, v2 = arg1:getMovementVelocity()
	local v3 = v2 * Vector3.new(1, 0, 1)
	local v_magnitude = (v_getmovementvelocity * Vector3.new(1, 0, 1)).Magnitude
	local v_cframe = v_u_current_camera.CFrame
	local v_toorientation, v4, _ = v_cframe:ToObjectSpace(arg1.LastCameraCFrame):ToOrientation()
	local v5 = Vector2.new(v_toorientation, v4) / v1
	local v6 = arg1.RenderTime + v1 * v_getmovementvelocity.Magnitude * 0.1
	local v7 = Vector3.new(0.0011111111, 0.0011111111, 0) * Vector3.new(v5.Y, -v5.X, 0)
	local v8 = v7 ~= v7 and Vector3.new(0, 0, 0) or v7
	local v_abs = math.abs(v3.X)
	local v_abs = math.abs(v2.Z)
	local v_max = math.max(v_abs, v_abs)
	local v9 = Vector3.new(0.0004, 0.0007, 0.0011) * Vector3.new(v3.X, -v_magnitude, v_max)
	local v_sin = math.sin(v6 * 3.141592653589793 * 2)
	local v10 = Vector2.new(v_sin, (math.sin(v6 * 3.141592653589793 * 4))) * (v_u4 * 0.5) * v_magnitude
	if arg1.IsInAir then
		v9 = v9 + Vector3.new(0, -0.02, 0)
		v10 = v10 * 0.3
	end
	arg1.MovementShiftSpring:setGoal(v9)
	arg1.CameraShiftSpring:setGoal(v8)
	arg1.BobbleSpring:setGoal(v10)
	local v11
	if arg1.IsAiming then
		v11 = Vector2.zero
	else
		v11 = Vector2.zero
	end
	arg1.ScopeSpring:setGoal(v11)
	arg1.MovementShiftSpring:update(v1)
	arg1.CameraShiftSpring:update(v1)
	arg1.BobbleSpring:update(v1)
	arg1.ScopeSpring:update(v1)
	arg1.LastCameraCFrame = v_cframe
	arg1.RenderTime = v6
	local v_getposition = arg1.MovementShiftSpring:getPosition()
	local v_getposition = arg1.CameraShiftSpring:getPosition()
	local v_getposition = arg1.BobbleSpring:getPosition()
	local v_new = Vector3.new(v_getposition.X, v_getposition.Y, 0)
	local v_getposition = arg1.ScopeSpring:getPosition()
	local v_rad = math.rad(-v_getposition.X * 250)
	local v12
	if arg1.IsAiming then
		v12 = 0.08726646259971647
		v_rad = 0
	else
		v12 = 0
	end
	local v_new = Vector3.new(v_getposition.X, v_getposition.Y, 0)
	return CFrame.new(v_getposition + v_getposition + v_new) * CFrame.Angles(0, v12, v_rad), v_new + v_getposition, v_new
end
function v_u1.setIsAiming(arg1, arg2)
	arg1.IsAiming = arg2
end
function v_u1.stateChanged(arg1, arg2, arg3)
	if arg3 == Enum.HumanoidStateType.Freefall or arg3 == Enum.HumanoidStateType.Jumping then
		arg1.IsInAir = true
	elseif arg2 == Enum.HumanoidStateType.Freefall or arg2 == Enum.HumanoidStateType.Jumping then
		arg1.IsInAir = false
	end
end
function v_u1.new(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u2, (copy) v_u3, (copy) v_u_current_camera, (copy) v_u5, (copy) v_u6
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u2.new()
	v_u1.IsDestroyed = false
	local v2 = not arg1.Character and arg1.Player
	if v2 then
		v2 = arg1.Player.Character
	end
	v_u1.Character = v2
	v_u1.IsAiming = false
	v_u1.CameraShiftSpring = v_u3.new(0.7, 18, Vector3.new(0, 0, 0))
	v_u1.MovementShiftSpring = v_u3.new(1, 15, Vector3.new(0, 0, 0))
	v_u1.BobbleSpring = v_u3.new(1, 20, Vector2.zero)
	v_u1.ScopeSpring = v_u3.new(1, 20, Vector2.zero)
	v_u1.AimRotationOffset = CFrame.Angles(0, 0, 0)
	v_u1.AimPositionOffset = CFrame.new(0, 0, 0)
	v_u1.LastCameraCFrame = v_u_current_camera.CFrame
	v_u1.CharacterSpeed = 0
	v_u1.RenderTime = 0
	v_u1.IsInAir = false
	local v3 = v_u1.Character and v_u1.Character:FindFirstChild("Humanoid")
	if v3 then
		local v_connection = v3.StateChanged:Connect(function(...)
			-- upvalues: (copy) v_u1
			if not v_u1.IsDestroyed then
				v_u1:stateChanged(...)
			end
		end)
		v_u1.Janitor:Add(v_connection)
	end
	local v_name = arg2.Name
	if v_name == "AUG" or v_name == "SG 553" then
		v_u1.ScopeReticlePart = v_u1.Janitor:Add(arg2.Weapon.ScopeSplit.Part)
		v_u1.Scope = v_u1.Janitor:Add(arg2.Weapon.ScopeSplit)
		v_u1.ScopeReticlePart.Parent = v_u_current_camera
		v_u1.Scope.Parent = v_u_current_camera
		v_u5(v_u1.Scope, false)
		if v_u1.Scope then
			v_u6(v_u1.Scope, arg2.Weapon)
		end
		v_u1.Scope.AncestryChanged:Connect(function(_, arg2)
			print("Scope Ancestor changed", arg2)
		end)
		print("Scope destroying connected")
	end
	return v_u1
end
function v_u1.destroy(arg1)
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		arg1.Janitor:Destroy()
		arg1.Janitor = nil
		if arg1.CameraShiftSpring then
			arg1.CameraShiftSpring = nil
		end
		if arg1.MovementShiftSpring then
			arg1.MovementShiftSpring = nil
		end
		if arg1.BobbleSpring then
			arg1.BobbleSpring = nil
		end
		if arg1.ScopeSpring then
			arg1.ScopeSpring = nil
		end
		arg1.Character = nil
		arg1.Scope = nil
		arg1.ScopeReticlePart = nil
		arg1.AimRotationOffset = nil
		arg1.AimPositionOffset = nil
	end
end
return v_u1