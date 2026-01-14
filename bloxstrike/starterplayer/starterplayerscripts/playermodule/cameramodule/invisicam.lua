-- Decompiled with Bunni.lol Decompiler

local v_u_players = game:GetService("Players")
local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_userraycastupdateapi = require(v_commonutils:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI")
local v_u1 = {
	["LIMBS"] = 2,
	["MOVEMENT"] = 3,
	["CORNERS"] = 4,
	["CIRCLE1"] = 5,
	["CIRCLE2"] = 6,
	["LIMBMOVE"] = 7,
	["SMART_CIRCLE"] = 8,
	["CHAR_OUTLINE"] = 9
}
local v_u2 = {
	["Head"] = true,
	["Left Arm"] = true,
	["Right Arm"] = true,
	["Left Leg"] = true,
	["Right Leg"] = true,
	["LeftLowerArm"] = true,
	["RightLowerArm"] = true,
	["LeftUpperLeg"] = true,
	["RightUpperLeg"] = true
}
local v_u3 = {
	Vector3.new(1, 1, -1),
	Vector3.new(1, -1, -1),
	Vector3.new(-1, -1, -1),
	Vector3.new(-1, 1, -1)
}
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Include
local function v_u4(arg1, ...)
	local v1 = {}
	local v2 = ""
	for _, v3 in pairs({ ... }) do
		v1[v3] = true
		v2 = v2 .. (v2 == "" and "" or " or ") .. v3
	end
	local v4 = type(arg1)
	assert(v1[v4], v2 .. " type expected, got: " .. v4)
end
local function v_u5(arg1, arg2, arg3, arg4)
	local v_cross = arg2:Cross(arg4)
	local v1 = arg3.X - arg1.X
	local v2 = arg3.Y - arg1.Y
	local v3 = arg3.Z - arg1.Z
	local v_y = arg2.Y
	local v4 = -arg4.Y
	local v_y = v_cross.Y
	local v_z = arg2.Z
	local v5 = -arg4.Z
	local v_z = v_cross.Z
	if arg2.X * (v4 * v_z - v_y * v5) - -arg4.X * (v_y * v_z - v_y * v_z) + v_cross.X * (v_y * v5 - v4 * v_z) == 0 then
		return Vector3.new(0, 0, 0)
	end
	local v6 = -arg4.Y
	local v_y = v_cross.Y
	local v7 = -arg4.Z
	local v_z = v_cross.Z
	local v_y = arg2.Y
	local v_y = v_cross.Y
	local v_z = arg2.Z
	local v_z = v_cross.Z
	return (arg3 + (arg2.X * (v2 * v_z - v_y * v3) - v1 * (v_y * v_z - v_y * v_z) + v_cross.X * (v_y * v3 - v2 * v_z)) / UNNAMED_1728996361304 * arg4 - (arg1 + (v1 * (v6 * v_z - v_y * v7) - -arg4.X * (v2 * v_z - v_y * v3) + v_cross.X * (v2 * v7 - v6 * v3)) / UNNAMED_1728996361304 * arg2)).Magnitude >= 0.25 and Vector3.new(0, 0, 0) or arg1 + (v1 * (v6 * v_z - v_y * v7) - -arg4.X * (v2 * v_z - v_y * v3) + v_cross.X * (v2 * v7 - v6 * v3)) / UNNAMED_1728996361304 * arg2 + 0.5 * (arg3 + (arg2.X * (v2 * v_z - v_y * v3) - v1 * (v_y * v_z - v_y * v_z) + v_cross.X * (v_y * v3 - v2 * v_z)) / UNNAMED_1728996361304 * arg4 - (arg1 + (v1 * (v6 * v_z - v_y * v7) - -arg4.X * (v2 * v_z - v_y * v3) + v_cross.X * (v2 * v7 - v6 * v3)) / UNNAMED_1728996361304 * arg2))
end
local v_u6 = require(script.Parent:WaitForChild("BaseOcclusion"))
local v_u7 = setmetatable({}, v_u6)
v_u7.__index = v_u7
function v_u7.new()
	-- upvalues: (copy) v_u6, (copy) v_u7, (copy) v_u1
	local v_new = v_u6.new()
	local v1 = setmetatable(v_new, v_u7)
	v1.char = nil
	v1.humanoidRootPart = nil
	v1.torsoPart = nil
	v1.headPart = nil
	v1.childAddedConn = nil
	v1.childRemovedConn = nil
	v1.ancestryChangedConn = nil
	v1.behaviors = {}
	v1.behaviors[v_u1.LIMBS] = v1.LimbBehavior
	v1.behaviors[v_u1.MOVEMENT] = v1.MoveBehavior
	v1.behaviors[v_u1.CORNERS] = v1.CornerBehavior
	v1.behaviors[v_u1.CIRCLE1] = v1.CircleBehavior
	v1.behaviors[v_u1.CIRCLE2] = v1.CircleBehavior
	v1.behaviors[v_u1.LIMBMOVE] = v1.LimbMoveBehavior
	v1.behaviors[v_u1.SMART_CIRCLE] = v1.SmartCircleBehavior
	v1.behaviors[v_u1.CHAR_OUTLINE] = v1.CharacterOutlineBehavior
	v1.mode = v_u1.SMART_CIRCLE
	v1.behaviorFunction = v1.SmartCircleBehavior
	v1.savedHits = {}
	v1.trackedLimbs = {}
	v1.camera = game.Workspace.CurrentCamera
	v1.enabled = false
	return v1
end
function v_u7.Enable(arg1, arg2)
	arg1.enabled = arg2
	if not arg2 then
		arg1:Cleanup()
		if arg1.ancestryChangedConn then
			arg1.ancestryChangedConn:Disconnect()
			arg1.ancestryChangedConn = nil
		end
	end
end
function v_u7.GetOcclusionMode(_)
	return Enum.DevCameraOcclusionMode.Invisicam
end
function v_u7.LimbBehavior(arg1, arg2)
	for v1, _ in pairs(arg1.trackedLimbs) do
		arg2[#arg2 + 1] = v1.Position
	end
end
function v_u7.MoveBehavior(arg1, arg2)
	for v1 = 1, 3 do
		local v_velocity = arg1.humanoidRootPart.Velocity
		arg2[#arg2 + 1] = arg1.humanoidRootPart.Position + (v1 - 1) * arg1.humanoidRootPart.CFrame.lookVector * (Vector3.new(v_velocity.X, 0, v_velocity.Z).Magnitude / 2)
	end
end
function v_u7.CornerBehavior(arg1, arg2)
	-- upvalues: (copy) v_u3
	local v_cframe = arg1.humanoidRootPart.CFrame
	local v_position = v_cframe.Position
	local v1 = v_cframe - v_position
	local v2 = arg1.char:GetExtentsSize() / 2
	arg2[#arg2 + 1] = v_position
	for v3 = 1, #v_u3 do
		arg2[#arg2 + 1] = v_position + v1 * (v2 * v_u3[v3])
	end
end
function v_u7.CircleBehavior(arg1, arg2)
	-- upvalues: (copy) v_u1
	local v1
	if arg1.mode == v_u1.CIRCLE1 then
		v1 = arg1.humanoidRootPart.CFrame
	else
		local v_coordinateframe = arg1.camera.CoordinateFrame
		v1 = v_coordinateframe - v_coordinateframe.Position + arg1.humanoidRootPart.Position
	end
	arg2[#arg2 + 1] = v1.Position
	for v2 = 0, 9 do
		local v3 = 0.6283185307179586 * v2
		local v_cos = math.cos(v3)
		local v_sin = math.sin(v3)
		arg2[#arg2 + 1] = v1 * (3 * Vector3.new(v_cos, v_sin, 0))
	end
end
function v_u7.LimbMoveBehavior(arg1, arg2)
	arg1:LimbBehavior(arg2)
	arg1:MoveBehavior(arg2)
end
function v_u7.CharacterOutlineBehavior(arg1, arg2)
	-- upvalues: (copy) v_u_userraycastupdateapi, (copy) v_u_new
	local v_unit = arg1.torsoPart.CFrame.upVector.unit
	local v_unit = arg1.torsoPart.CFrame.rightVector.unit
	arg2[#arg2 + 1] = arg1.torsoPart.CFrame.p
	arg2[#arg2 + 1] = arg1.torsoPart.CFrame.p + v_unit
	arg2[#arg2 + 1] = arg1.torsoPart.CFrame.p - v_unit
	arg2[#arg2 + 1] = arg1.torsoPart.CFrame.p + v_unit
	arg2[#arg2 + 1] = arg1.torsoPart.CFrame.p - v_unit
	if arg1.headPart then
		arg2[#arg2 + 1] = arg1.headPart.CFrame.p
	end
	local v_new = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(arg1.camera.CoordinateFrame.lookVector.X, 0, arg1.camera.CoordinateFrame.lookVector.Z)))
	local v1 = arg1.torsoPart and arg1.torsoPart.Position or arg1.humanoidRootPart.Position
	local v2 = { arg1.torsoPart }
	if arg1.headPart then
		v2[#v2 + 1] = arg1.headPart
	end
	for v3 = 1, 24 do
		local v4 = 6.283185307179586 * v3 / 24
		local v_cos = math.cos(v4)
		local v_sin = math.sin(v4)
		local v5 = v_new * (3 * Vector3.new(v_cos, v_sin, 0))
		local v_max = math.max(v5.Y, -2.25)
		local v_new = Vector3.new(v5.X, v_max, v5.Z)
		if v_u_userraycastupdateapi then
			v_u_new.FilterDescendantsInstances = v2
			local v_raycast = game.Workspace:Raycast(v1 + v_new, -3 * v_new, v_u_new)
			if v_raycast then
				local v_position = v_raycast.Position
				arg2[#arg2 + 1] = v_position + 0.2 * (v1 - v_position).unit
			end
		else
			local v_new = Ray.new(v1 + v_new, -3 * v_new)
			local v_findpartonraywithwhitelist, v6 = game.Workspace:FindPartOnRayWithWhitelist(v_new, v2, false)
			if v_findpartonraywithwhitelist then
				arg2[#arg2 + 1] = v6 + 0.2 * (v1 - v6).unit
			end
		end
	end
end
function v_u7.SmartCircleBehavior(arg1, arg2)
	-- upvalues: (copy) v_u_userraycastupdateapi, (copy) v_u_new, (copy) v_u5
	local v_unit = arg1.torsoPart.CFrame.upVector.unit
	local v_unit = arg1.torsoPart.CFrame.rightVector.unit
	arg2[#arg2 + 1] = arg1.torsoPart.CFrame.p
	arg2[#arg2 + 1] = arg1.torsoPart.CFrame.p + v_unit
	arg2[#arg2 + 1] = arg1.torsoPart.CFrame.p - v_unit
	arg2[#arg2 + 1] = arg1.torsoPart.CFrame.p + v_unit
	arg2[#arg2 + 1] = arg1.torsoPart.CFrame.p - v_unit
	if arg1.headPart then
		arg2[#arg2 + 1] = arg1.headPart.CFrame.p
	end
	local v1 = arg1.camera.CFrame - arg1.camera.CFrame.p
	local v2 = Vector3.new(0, 0.5, 0) + (arg1.torsoPart and arg1.torsoPart.Position or arg1.humanoidRootPart.Position)
	for v3 = 1, 24 do
		local v4 = 0.2617993877991494 * v3 - 1.5707963267948966
		local v_cos = math.cos(v4)
		local v_sin = math.sin(v4)
		local v5 = v2 + v1 * (2.5 * Vector3.new(v_cos, v_sin, 0))
		local v6 = v5 - arg1.camera.CFrame.p
		if v_u_userraycastupdateapi then
			v_u_new.FilterDescendantsInstances = { arg1.char }
			local v_raycast = game.Workspace:Raycast(v2, v5 - v2, v_u_new)
			if v_raycast then
				local v_normal = v_raycast.Normal
				local v7 = v_raycast.Position + 0.1 * v_normal.unit
				local v8 = v7 - v2
				local v_unit = v8:Cross(v6).unit:Cross(v_normal).unit
				if v8.unit:Dot(-v_unit) < v8.unit:Dot((v7 - arg1.camera.CFrame.p).unit) then
					v5 = v_u5(v7, v_unit, v5, v6)
					if v5.Magnitude > 0 then
						local v_raycast = game.Workspace:Raycast(v7, v5 - v7, v_u_new)
						if v_raycast then
							v5 = v_raycast.Position + 0.1 * v_raycast.Normal.Unit
						end
					else
						v5 = v7
					end
				else
					v5 = v7
				end
				local v_raycast = game.Workspace:Raycast(v2, v5 - v2, v_u_new)
				if v_raycast then
					v5 = v_raycast.Position - 0.1 * (v5 - v2).unit
				end
			end
			arg2[#arg2 + 1] = v5
		else
			local v_new = Ray.new(v2, v5 - v2)
			local v_findpartonraywithignorelist, v9, v10 = game.Workspace:FindPartOnRayWithIgnoreList(v_new, { arg1.char }, false, false)
			if v_findpartonraywithignorelist then
				local v11 = v9 + 0.1 * v10.unit
				local v12 = v11 - v2
				local v_unit = v12:Cross(v6).unit:Cross(v10).unit
				if v12.unit:Dot(-v_unit) < v12.unit:Dot((v11 - arg1.camera.CFrame.p).unit) then
					v5 = v_u5(v11, v_unit, v5, v6)
					if v5.Magnitude > 0 then
						local v_new = Ray.new(v11, v5 - v11)
						local v_findpartonraywithignorelist, v13, v14 = game.Workspace:FindPartOnRayWithIgnoreList(v_new, { arg1.char }, false, false)
						if v_findpartonraywithignorelist then
							v5 = v13 + 0.1 * v14.unit
						end
					else
						v5 = v11
					end
				else
					v5 = v11
				end
				local v_new = Ray.new(v2, v5 - v2)
				local v_findpartonraywithignorelist, v15, _ = game.Workspace:FindPartOnRayWithIgnoreList(v_new, { arg1.char }, false, false)
				if v_findpartonraywithignorelist then
					v5 = v15 - 0.1 * (v5 - v2).unit
				end
			end
			arg2[#arg2 + 1] = v5
		end
	end
end
function v_u7.CheckTorsoReference(arg1)
	if arg1.char then
		arg1.torsoPart = arg1.char:FindFirstChild("Torso")
		if not arg1.torsoPart then
			arg1.torsoPart = arg1.char:FindFirstChild("UpperTorso")
			if not arg1.torsoPart then
				arg1.torsoPart = arg1.char:FindFirstChild("HumanoidRootPart")
			end
		end
		arg1.headPart = arg1.char:FindFirstChild("Head")
	end
end
function v_u7.CharacterAdded(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_players, (copy) v_u2
	if arg3 == v_u_players.LocalPlayer then
		if arg1.childAddedConn then
			arg1.childAddedConn:Disconnect()
			arg1.childAddedConn = nil
		end
		if arg1.childRemovedConn then
			arg1.childRemovedConn:Disconnect()
			arg1.childRemovedConn = nil
		end
		if arg1.ancestryChangedConn then
			arg1.ancestryChangedConn:Disconnect()
			arg1.ancestryChangedConn = nil
		end
		arg1.char = arg2
		arg1.trackedLimbs = {}
		local function v1(arg1)
			-- upvalues: (ref) v_u2, (copy) arg1
			if arg1:IsA("BasePart") then
				if v_u2[arg1.Name] then
					arg1.trackedLimbs[arg1] = true
				end
				if arg1.Name == "Torso" or arg1.Name == "UpperTorso" then
					arg1.torsoPart = arg1
				end
				if arg1.Name == "Head" then
					arg1.headPart = arg1
				end
			end
		end
		arg1.childAddedConn = arg2.ChildAdded:Connect(v1)
		arg1.childRemovedConn = arg2.ChildRemoved:Connect(function(arg1)
			-- upvalues: (copy) arg1
			arg1.trackedLimbs[arg1] = nil
			arg1:CheckTorsoReference()
		end)
		for _, v2 in pairs(arg1.char:GetChildren()) do
			if v2:IsA("BasePart") then
				if v_u2[v2.Name] then
					arg1.trackedLimbs[v2] = true
				end
				if v2.Name == "Torso" or v2.Name == "UpperTorso" then
					arg1.torsoPart = v2
				end
				if v2.Name == "Head" then
					arg1.headPart = v2
				end
			end
		end
	end
end
function v_u7.SetMode(arg1, arg2)
	-- upvalues: (copy) v_u4, (copy) v_u1
	v_u4(arg2, "number")
	for _, v1 in pairs(v_u1) do
		if v1 == arg2 then
			arg1.mode = arg2
			arg1.behaviorFunction = arg1.behaviors[arg1.mode]
			return
		end
	end
	error("Invalid mode number")
end
function v_u7.GetObscuredParts(arg1)
	return arg1.savedHits
end
function v_u7.Cleanup(arg1)
	for v1, v2 in pairs(arg1.savedHits) do
		v1.LocalTransparencyModifier = v2
	end
end
function v_u7.Update(arg1, _, arg3, arg4)
	if not (arg1.enabled and arg1.char) then
		return arg3, arg4
	end
	arg1.camera = game.Workspace.CurrentCamera
	if not arg1.humanoidRootPart then
		local v_humanoid = arg1.char:FindFirstChildOfClass("Humanoid")
		if v_humanoid and v_humanoid.RootPart then
			arg1.humanoidRootPart = v_humanoid.RootPart
		else
			arg1.humanoidRootPart = arg1.char:FindFirstChild("HumanoidRootPart")
			if not arg1.humanoidRootPart then
				return arg3, arg4
			end
		end
		if arg1.ancestryChangedConn then
			arg1.ancestryChangedConn:Disconnect()
			arg1.ancestryChangedConn = nil
		end
		arg1.ancestryChangedConn = arg1.humanoidRootPart.AncestryChanged:Connect(function(arg1, arg2)
			-- upvalues: (copy) arg1
			if arg1 == arg1.humanoidRootPart and not arg2 then
				arg1.humanoidRootPart = nil
				if arg1.ancestryChangedConn and arg1.ancestryChangedConn.Connected then
					arg1.ancestryChangedConn:Disconnect()
					arg1.ancestryChangedConn = nil
				end
			end
		end)
	end
	if not arg1.torsoPart then
		arg1:CheckTorsoReference()
		if not arg1.torsoPart then
			return arg3, arg4
		end
	end
	local v1 = {}
	arg1.behaviorFunction(arg1, v1)
	local v2 = { arg1.char }
	local v_getpartsobscuringtarget = arg1.camera:GetPartsObscuringTarget({ arg1.headPart and arg1.headPart.CFrame.p or v1[1], arg1.torsoPart and arg1.torsoPart.CFrame.p or v1[2] }, v2)
	local v3 = 0
	local v4 = {}
	local v5 = 0.75
	local v6 = {}
	local v7 = 0.75
	for v8 = 1, #v_getpartsobscuringtarget do
		local v9 = v_getpartsobscuringtarget[v8]
		v3 = v3 + 1
		v4[v9] = true
		for _, v10 in pairs(v9:GetChildren()) do
			if v10:IsA("Decal") or v10:IsA("Texture") then
				v3 = v3 + 1
				break
			end
		end
	end
	if v3 > 0 then
		v5 = math.pow(0.375 / v3 + 0.375, 1 / v3)
		v7 = math.pow(0.25 / v3 + 0.25, 1 / v3)
	end
	local v_getpartsobscuringtarget = arg1.camera:GetPartsObscuringTarget(v1, v2)
	local v11 = {}
	for v12 = 1, #v_getpartsobscuringtarget do
		local v13 = v_getpartsobscuringtarget[v12]
		v11[v13] = v4[v13] and v5 and v5 or v7
		if v13.Transparency < v11[v13] then
			v6[v13] = true
			if not arg1.savedHits[v13] then
				arg1.savedHits[v13] = v13.LocalTransparencyModifier
			end
		end
		for _, v14 in pairs(v13:GetChildren()) do
			if (v14:IsA("Decal") or v14:IsA("Texture")) and v14.Transparency < v11[v13] then
				v11[v14] = v11[v13]
				v6[v14] = true
				if not arg1.savedHits[v14] then
					arg1.savedHits[v14] = v14.LocalTransparencyModifier
				end
			end
		end
	end
	for v15, v16 in pairs(arg1.savedHits) do
		if v6[v15] then
			v15.LocalTransparencyModifier = v15.Transparency < 1 and ((v11[v15] - v15.Transparency) / (1 - v15.Transparency) or 0) or 0
		else
			v15.LocalTransparencyModifier = v16
			arg1.savedHits[v15] = nil
		end
	end
	return arg3, arg4
end
return v_u7