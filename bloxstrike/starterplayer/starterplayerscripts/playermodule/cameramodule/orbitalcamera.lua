-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u2 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_players = game:GetService("Players")
local v_u3 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u4 = setmetatable({}, v_u3)
v_u4.__index = v_u4
function v_u4.new()
	-- upvalues: (copy) v_u3, (copy) v_u4
	local v_new = v_u3.new()
	local v1 = setmetatable(v_new, v_u4)
	v1.lastUpdate = tick()
	v1.changedSignalConnections = {}
	v1.refAzimuthRad = nil
	v1.curAzimuthRad = nil
	v1.minAzimuthAbsoluteRad = nil
	v1.maxAzimuthAbsoluteRad = nil
	v1.useAzimuthLimits = nil
	v1.curElevationRad = nil
	v1.minElevationRad = nil
	v1.maxElevationRad = nil
	v1.curDistance = nil
	v1.minDistance = nil
	v1.maxDistance = nil
	v1.gamepadDollySpeedMultiplier = 1
	v1.lastUserPanCamera = tick()
	v1.externalProperties = {}
	v1.externalProperties.InitialDistance = 25
	v1.externalProperties.MinDistance = 10
	v1.externalProperties.MaxDistance = 100
	v1.externalProperties.InitialElevation = 35
	v1.externalProperties.MinElevation = 35
	v1.externalProperties.MaxElevation = 35
	v1.externalProperties.ReferenceAzimuth = -45
	v1.externalProperties.CWAzimuthTravel = 90
	v1.externalProperties.CCWAzimuthTravel = 90
	v1.externalProperties.UseAzimuthLimits = false
	v1:LoadNumberValueParameters()
	return v1
end
function v_u4.LoadOrCreateNumberValueParameter(arg1, arg2, arg3, arg4)
	local v1 = script:FindFirstChild(arg2)
	if v1 and v1:IsA(arg3) then
		arg1.externalProperties[arg2] = v1.Value
	else
		if arg1.externalProperties[arg2] == nil then
			return
		end
		v1 = Instance.new(arg3)
		v1.Name = arg2
		v1.Parent = script
		v1.Value = arg1.externalProperties[arg2]
	end
	if arg4 then
		if arg1.changedSignalConnections[arg2] then
			arg1.changedSignalConnections[arg2]:Disconnect()
		end
		arg1.changedSignalConnections[arg2] = v1.Changed:Connect(function(arg1)
			-- upvalues: (copy) arg1, (copy) arg2, (copy) arg4
			arg1.externalProperties[arg2] = arg1
			arg4(arg1)
		end)
	end
end
function v_u4.SetAndBoundsCheckAzimuthValues(arg1)
	local v_rad = math.rad(arg1.externalProperties.ReferenceAzimuth)
	local v_rad = math.rad(arg1.externalProperties.CWAzimuthTravel)
	arg1.minAzimuthAbsoluteRad = v_rad - math.abs(v_rad)
	local v_rad = math.rad(arg1.externalProperties.ReferenceAzimuth)
	local v_rad = math.rad(arg1.externalProperties.CCWAzimuthTravel)
	arg1.maxAzimuthAbsoluteRad = v_rad + math.abs(v_rad)
	arg1.useAzimuthLimits = arg1.externalProperties.UseAzimuthLimits
	if arg1.useAzimuthLimits then
		arg1.curAzimuthRad = math.max(arg1.curAzimuthRad, arg1.minAzimuthAbsoluteRad)
		arg1.curAzimuthRad = math.min(arg1.curAzimuthRad, arg1.maxAzimuthAbsoluteRad)
	end
end
function v_u4.SetAndBoundsCheckElevationValues(arg1)
	local v_max = math.max(arg1.externalProperties.MinElevation, -80)
	local v_min = math.min(arg1.externalProperties.MaxElevation, 80)
	local v_min = math.min(v_max, v_min)
	arg1.minElevationRad = math.rad(v_min)
	local v_max = math.max(v_max, v_min)
	arg1.maxElevationRad = math.rad(v_max)
	arg1.curElevationRad = math.max(arg1.curElevationRad, arg1.minElevationRad)
	arg1.curElevationRad = math.min(arg1.curElevationRad, arg1.maxElevationRad)
end
function v_u4.SetAndBoundsCheckDistanceValues(arg1)
	arg1.minDistance = arg1.externalProperties.MinDistance
	arg1.maxDistance = arg1.externalProperties.MaxDistance
	arg1.curDistance = math.max(arg1.curDistance, arg1.minDistance)
	arg1.curDistance = math.min(arg1.curDistance, arg1.maxDistance)
end
function v_u4.LoadNumberValueParameters(arg1)
	arg1:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil)
	arg1:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil)
	arg1:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", arg1.SetAndBoundsCheckAzimuthValue)
	arg1:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", arg1.SetAndBoundsCheckAzimuthValues)
	arg1:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", arg1.SetAndBoundsCheckAzimuthValues)
	arg1:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", arg1.SetAndBoundsCheckElevationValues)
	arg1:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", arg1.SetAndBoundsCheckElevationValues)
	arg1:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", arg1.SetAndBoundsCheckDistanceValues)
	arg1:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", arg1.SetAndBoundsCheckDistanceValues)
	arg1:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", arg1.SetAndBoundsCheckAzimuthValues)
	arg1.curAzimuthRad = math.rad(arg1.externalProperties.ReferenceAzimuth)
	arg1.curElevationRad = math.rad(arg1.externalProperties.InitialElevation)
	arg1.curDistance = arg1.externalProperties.InitialDistance
	arg1:SetAndBoundsCheckAzimuthValues()
	arg1:SetAndBoundsCheckElevationValues()
	arg1:SetAndBoundsCheckDistanceValues()
end
function v_u4.GetModuleName(_)
	return "OrbitalCamera"
end
function v_u4.SetInitialOrientation(arg1, arg2)
	-- upvalues: (copy) v_u1
	if arg2 and arg2.RootPart then
		assert(arg2.RootPart, "")
		local v_getanglebetweenxzvectors = v_u1.GetAngleBetweenXZVectors((arg2.RootPart.CFrame.LookVector - Vector3.new(0, 0.23, 0)).Unit, arg1:GetCameraLookVector())
		v_u1.IsFinite(v_getanglebetweenxzvectors)
		v_u1.IsFinite(math.asin(arg1:GetCameraLookVector().Y) - math.asin(UNNAMED_1728994295192.Y))
	else
		warn("OrbitalCamera could not set initial orientation due to missing humanoid")
	end
end
function v_u4.GetCameraToSubjectDistance(arg1)
	return arg1.curDistance
end
function v_u4.SetCameraToSubjectDistance(arg1, arg2)
	-- upvalues: (copy) v_u_players
	if v_u_players.LocalPlayer then
		arg1.currentSubjectDistance = math.clamp(arg2, arg1.minDistance, arg1.maxDistance)
		arg1.currentSubjectDistance = math.max(arg1.currentSubjectDistance, arg1.FIRST_PERSON_DISTANCE_THRESHOLD)
	end
	arg1.inFirstPerson = false
	arg1:UpdateMouseBehavior()
	return arg1.currentSubjectDistance
end
function v_u4.CalculateNewLookVector(arg1, arg2, arg3)
	local v1 = arg2 or arg1:GetCameraLookVector()
	local v_asin = math.asin(v1.Y)
	local v_clamp = math.clamp(arg3.Y, v_asin - 1.3962634015954636, v_asin - -1.3962634015954636)
	local v_new = Vector2.new(arg3.X, v_clamp)
	local v_new = CFrame.new(Vector3.new(0, 0, 0), v1)
	return (CFrame.Angles(0, -v_new.X, 0) * v_new * CFrame.Angles(-v_new.Y, 0, 0)).LookVector
end
function v_u4.Update(arg1, arg2)
	-- upvalues: (copy) v_u2, (copy) v_u_players
	local v1 = tick()
	local v2 = v1 - arg1.lastUpdate
	local v3 = v_u2.getRotation(arg2) ~= Vector2.new()
	local v_current_camera = workspace.CurrentCamera
	local v_cframe = v_current_camera.CFrame
	local v_focus = v_current_camera.Focus
	local v_localplayer = v_u_players.LocalPlayer
	local v4
	if v_current_camera then
		v4 = v_current_camera.CameraSubject
	else
		v4 = v_current_camera
	end
	local v5
	if v4 then
		v5 = v4:IsA("VehicleSeat")
	else
		v5 = v4
	end
	local v6
	if v4 then
		v6 = v4:IsA("SkateboardPlatform")
	else
		v6 = v4
	end
	if arg1.lastUpdate == nil or v2 > 1 then
		arg1.lastCameraTransform = nil
	end
	if v3 then
		arg1.lastUserPanCamera = tick()
	end
	local v_getsubjectposition = arg1:GetSubjectPosition()
	if v_getsubjectposition and (v_localplayer and v_current_camera) then
		if arg1.gamepadDollySpeedMultiplier ~= 1 then
			arg1:SetCameraToSubjectDistance(arg1.currentSubjectDistance * arg1.gamepadDollySpeedMultiplier)
		end
		v_focus = CFrame.new(v_getsubjectposition)
		local v_getrotation = v_u2.getRotation(arg2)
		arg1.curAzimuthRad = arg1.curAzimuthRad - v_getrotation.X
		if arg1.useAzimuthLimits then
			arg1.curAzimuthRad = math.clamp(arg1.curAzimuthRad, arg1.minAzimuthAbsoluteRad, arg1.maxAzimuthAbsoluteRad)
		else
			arg1.curAzimuthRad = arg1.curAzimuthRad == 0 and 0 or (math.sign(arg1.curAzimuthRad) * (math.abs(arg1.curAzimuthRad) % 6.283185307179586) or 0)
		end
		arg1.curElevationRad = math.clamp(arg1.curElevationRad + v_getrotation.Y, arg1.minElevationRad, arg1.maxElevationRad)
		v_cframe = CFrame.new(v_getsubjectposition + arg1.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-arg1.curElevationRad, arg1.curAzimuthRad, 0) * Vector3.new(0, 0, 1)), v_getsubjectposition)
		arg1.lastCameraTransform = v_cframe
		arg1.lastCameraFocus = v_focus
		if (v5 or v6) and v4:IsA("BasePart") then
			arg1.lastSubjectCFrame = v4.CFrame
		else
			arg1.lastSubjectCFrame = nil
		end
	end
	arg1.lastUpdate = v1
	return v_cframe, v_focus
end
return v_u4