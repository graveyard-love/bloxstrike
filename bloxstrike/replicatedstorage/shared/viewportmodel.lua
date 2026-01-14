-- Decompiled with Bunni.lol Decompiler

local v_u1 = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7
}
local v_u2 = {
	0,
	1,
	3,
	4,
	5,
	7
}
local v_u3 = {
	0,
	1,
	4,
	5,
	6
}
local v_u4 = {}
v_u4.__index = v_u4
v_u4.ClassName = "ViewportModel"
local function v_u5(arg1, arg2, arg3)
	local v1 = {}
	for v2, v3 in pairs(arg3) do
		v1[v2] = arg1 * (arg2 * Vector3.new(math.floor(v3 / 4) % 2 * 2 - 1, math.floor(v3 / 2) % 2 * 2 - 1, 2 * (v3 % 2) - 1))
	end
	return v1
end
local function v_u6(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u3, (copy) v_u1, (copy) v_u5
	local v1 = {}
	for _, v2 in pairs(arg1:GetDescendants()) do
		if v2:IsA("BasePart") then
			local v3
			if v2:IsA("WedgePart") then
				v3 = v_u2
			elseif v2:IsA("CornerWedgePart") then
				v3 = v_u3
			else
				v3 = v_u1
			end
			local v4 = v_u5(v2.CFrame, v2.Size / 2, v3)
			for _, v5 in pairs(v4) do
				table.insert(v1, v5)
			end
		end
	end
	return v1
end
local function v_u7(arg1, arg2, arg3, arg4)
	local v1 = (-1 / 0)
	local v2 = (1 / 0)
	for _, v3 in pairs(arg1) do
		local v4 = arg4 * (arg3 - v3.Z)
		local v5 = v3[arg2] + v4
		local v6 = v3[arg2] - v4
		v1 = math.max(v1, v5, v6)
		v2 = math.min(v2, v5, v6)
	end
	return v1, v2
end
function v_u4.GenerateViewport(arg1, arg2, arg3)
	-- upvalues: (copy) v_u4
	local v1 = arg3 or CFrame.Angles(0, 0, 0)
	local v_camera = arg1:FindFirstChildOfClass("Camera")
	if not v_camera then
		v_camera = Instance.new("Camera")
		v_camera.FieldOfView = 70
		v_camera.Parent = arg1
		arg1.CurrentCamera = v_camera
	end
	arg2.Parent = arg1
	local v_new = v_u4.new(arg1, v_camera)
	v_new:SetModel(arg2)
	v_camera.CFrame = v_new:GetMinimumFitCFrame(v1)
end
function v_u4.CleanViewport(arg1)
	local v_model = arg1:FindFirstChildOfClass("Model")
	if v_model then
		v_model:Destroy()
	end
end
function v_u4.new(arg1, arg2)
	-- upvalues: (copy) v_u4
	local v1 = setmetatable({}, v_u4)
	v1.Model = nil
	v1.ViewportFrame = arg1
	v1.Camera = arg2
	v1._points = {}
	v1._modelCFrame = CFrame.new()
	v1._modelSize = Vector3.new()
	v1._modelRadius = 0
	v1._viewport = {}
	v1:Calibrate()
	return v1
end
function v_u4.SetModel(arg1, arg2)
	-- upvalues: (copy) v_u6
	arg1.Model = arg2
	local v_getboundingbox, v1 = arg2:GetBoundingBox()
	arg1._points = v_u6(arg2)
	arg1._modelCFrame = v_getboundingbox
	arg1._modelSize = v1
	arg1._modelRadius = v1.Magnitude / 2
end
function v_u4.Calibrate(arg1)
	local v1 = {}
	local v_absolutesize = arg1.ViewportFrame.AbsoluteSize
	v1.aspect = v_absolutesize.X / v_absolutesize.Y
	v1.yFov2 = math.rad(arg1.Camera.FieldOfView / 2)
	v1.tanyFov2 = math.tan(v1.yFov2)
	v1.xFov2 = math.atan(v1.tanyFov2 * v1.aspect)
	v1.tanxFov2 = math.tan(v1.xFov2)
	v1.cFov2 = math.atan(v1.tanyFov2 * math.min(1, v1.aspect))
	v1.sincFov2 = math.sin(v1.cFov2)
	arg1._viewport = v1
end
function v_u4.GetFitDistance(arg1, arg2)
	return (arg1._modelRadius + (arg2 and ((arg2 - arg1._modelCFrame.Position).Magnitude or 0) or 0)) / arg1._viewport.sincFov2
end
function v_u4.GetMinimumFitCFrame(arg1, arg2)
	-- upvalues: (copy) v_u7
	if not arg1.Model then
		return CFrame.new()
	end
	local v_inverse = (arg2 - arg2.Position):Inverse()
	local v__points = arg1._points
	local v1 = { v_inverse * v__points[1] }
	local v_z = v1[1].Z
	for v2 = 2, #v__points do
		v_z = math.min(v_z, (v_inverse * v__points[v2]).Z)
		v1[v2] = UNNAMED_1728996444024
	end
	local v3, v4 = v_u7(v1, "X", v_z, arg1._viewport.tanxFov2)
	local v5, v6 = v_u7(v1, "Y", v_z, arg1._viewport.tanyFov2)
	local v_max = math.max((v3 - v4) / 2 / arg1._viewport.tanxFov2, (v5 - v6) / 2 / arg1._viewport.tanyFov2)
	return arg2 * CFrame.new((v3 + v4) / 2, (v5 + v6) / 2, v_z + v_max)
end
return v_u4