-- Decompiled with Bunni.lol Decompiler

local v1, v2 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserVRVehicleCamera2")
end)
local v_u3 = v1 and v2
local v_u4 = { 0, 30 }
local v_u_usergamesettings = UserSettings():GetService("UserGameSettings")
local v_u5 = require(script.Parent:WaitForChild("VRBaseCamera"))
local v_u6 = require(script.Parent:WaitForChild("CameraInput"))
local v_u7 = require(script.Parent:WaitForChild("CameraUtils"))
require(script.Parent:WaitForChild("VehicleCamera"))
local v_u8 = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraCore"))
local v_u9 = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraConfig"))
local v_players = game:GetService("Players")
local v_u_run = game:GetService("RunService")
local v_u_vr = game:GetService("VRService")
local v_u_localplayer = v_players.LocalPlayer
local v_u_spring = v_u7.Spring
local v_u_mapclamp = v_u7.mapClamp
local v_u_sanitizeangle = v_u7.sanitizeAngle
local v_u10 = 0.016666666666666666
local v_u11 = setmetatable({}, v_u5)
v_u11.__index = v_u11
function v_u11.new()
	-- upvalues: (copy) v_u5, (copy) v_u11, (copy) v_u_run, (ref) v_u10
	local v_new = v_u5.new()
	local v1 = setmetatable(v_new, v_u11)
	v1:Reset()
	v_u_run.Stepped:Connect(function(_, arg2)
		-- upvalues: (ref) v_u10
		v_u10 = arg2
	end)
	return v1
end
function v_u11.Reset(arg1)
	-- upvalues: (copy) v_u8, (ref) v_u3, (copy) v_u_spring, (copy) v_u9, (copy) v_u7, (copy) v_u4
	arg1.vehicleCameraCore = v_u8.new(arg1:GetSubjectCFrame())
	if v_u3 then
		arg1.pitchSpring = v_u_spring.new(0, 0)
	else
		arg1.pitchSpring = v_u_spring.new(0, -math.rad(v_u9.pitchBaseAngle))
	end
	arg1.yawSpring = v_u_spring.new(0, 0)
	if v_u3 then
		arg1.lastPanTick = 0
		arg1.currentDriftAngle = 0
		arg1.needsReset = true
	end
	local v_current_camera = workspace.CurrentCamera
	local v1
	if v_current_camera then
		v1 = v_current_camera.CameraSubject
	else
		v1 = v_current_camera
	end
	assert(v_current_camera, "VRVehicleCamera initialization error")
	assert(v1)
	assert(v1:IsA("VehicleSeat"))
	local v_getconnectedparts = v1:GetConnectedParts(true)
	local v_getlooseboundingsphere, v2 = v_u7.getLooseBoundingSphere(v_getconnectedparts)
	arg1.assemblyRadius = math.max(v2, 5)
	arg1.assemblyOffset = v1.CFrame:Inverse() * v_getlooseboundingsphere
	arg1.gamepadZoomLevels = {}
	for _, v3 in v_u4 do
		table.insert(arg1.gamepadZoomLevels, v3 * arg1.headScale * arg1.assemblyRadius / 10)
	end
	arg1.lastCameraFocus = nil
	arg1:SetCameraToSubjectDistance(arg1.gamepadZoomLevels[#arg1.gamepadZoomLevels])
end
function v_u11._StepRotation(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_sanitizeangle, (copy) v_u6, (copy) v_u9, (copy) v_u_mapclamp
	local v_yawspring = arg1.yawSpring
	local v_pitchspring = arg1.pitchSpring
	v_yawspring.pos = v_u_sanitizeangle(v_yawspring.pos + -arg1:getRotation(arg2))
	v_pitchspring.pos = v_u_sanitizeangle((math.clamp(v_pitchspring.pos, -1.3962634015954636, 1.3962634015954636)))
	if v_u6.getRotationActivated() then
		arg1.lastPanTick = os.clock()
	end
	local v_rad = math.rad(v_u9.pitchDeadzoneAngle)
	if os.clock() - arg1.lastPanTick > v_u9.autocorrectDelay then
		local v1 = v_u_mapclamp(arg3, v_u9.autocorrectMinCarSpeed, v_u9.autocorrectMaxCarSpeed, 0, v_u9.autocorrectResponse)
		v_yawspring.freq = v1
		v_pitchspring.freq = v1
		if v_yawspring.freq < 0.001 then
			v_yawspring.vel = 0
		end
		if v_pitchspring.freq < 0.001 then
			v_pitchspring.vel = 0
		end
		local v2 = v_u_sanitizeangle(0 - v_pitchspring.pos)
		if math.abs(v2) <= v_rad then
			v_pitchspring.goal = v_pitchspring.pos
		else
			v_pitchspring.goal = 0
		end
	else
		v_yawspring.freq = 0
		v_yawspring.vel = 0
		v_pitchspring.freq = 0
		v_pitchspring.vel = 0
		v_pitchspring.goal = 0
	end
	return CFrame.fromEulerAnglesYXZ(v_pitchspring:step(arg2), v_yawspring:step(arg2), 0)
end
function v_u11._GetThirdPersonLocalOffset(arg1)
	-- upvalues: (copy) v_u9
	return arg1.assemblyOffset + Vector3.new(0, arg1.assemblyRadius * v_u9.verticalCenterOffset, 0)
end
function v_u11._GetFirstPersonLocalOffset(arg1, arg2)
	-- upvalues: (copy) v_u_localplayer
	local v_character = v_u_localplayer.Character
	if v_character and v_character.Parent then
		local v_head = v_character:FindFirstChild("Head")
		if v_head and v_head:IsA("BasePart") then
			return arg2:Inverse() * v_head.Position
		end
	end
	return arg1:_GetThirdPersonLocalOffset()
end
function v_u11.Update(arg1)
	-- upvalues: (ref) v_u3, (ref) v_u10, (copy) v_u_localplayer, (copy) v_u_vr
	if v_u3 then
		local v1 = v_u10
		v_u10 = 0
		arg1:UpdateFadeFromBlack(v1)
		arg1:UpdateEdgeBlur(v_u_localplayer, v1)
		if v_u_vr.ThirdPersonFollowCamEnabled then
			local v_updatesteprotation, v2 = arg1:UpdateStepRotation(v1)
			return v_updatesteprotation, v2
		else
			local v_updatecomfortcamera, v3 = arg1:UpdateComfortCamera(v1)
			return v_updatecomfortcamera, v3
		end
	else
		return arg1:UpdateComfortCamera()
	end
end
function v_u11.addDrift(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_vr
	local v_current_camera = workspace.CurrentCamera
	local v_getcameratosubjectdistance = arg1:GetCameraToSubjectDistance()
	local v_getsubjectvelocity = arg1:GetSubjectVelocity()
	local v_getsubjectcframe = arg1:GetSubjectCFrame()
	require(v_u_localplayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"))
	if v_getsubjectvelocity.Magnitude > 0.1 then
		local v_getusercframe = v_u_vr:GetUserCFrame(Enum.UserCFrame.Head)
		local v1 = v_current_camera.CFrame * (v_getusercframe.Rotation + v_getusercframe.Position * v_current_camera.HeadScale)
		local _, v2, _ = v1:ToEulerAnglesYXZ()
		local _, v3, _ = v_getsubjectcframe:ToEulerAnglesYXZ()
		local v4 = (v2 - arg1.currentDriftAngle + 12.566370614359172) % 6.283185307179586
		if v4 > 3.141592653589793 then
			v4 = v4 - 6.283185307179586
		end
		local v5 = (v3 - arg1.currentDriftAngle + 12.566370614359172) % 6.283185307179586
		if v5 > 3.141592653589793 then
			v5 = v5 - 6.283185307179586
		end
		local v_min = math.min(v5, v4)
		local v_max = math.max(v5, v4)
		local v6 = 0
		if v_min > 0 then
			v_max = v_min
		elseif v_max >= 0 then
			v_max = v6
		end
		arg1.currentDriftAngle = v_max + arg1.currentDriftAngle
		local v_lookvector = CFrame.fromEulerAnglesYXZ(0, arg1.currentDriftAngle, 0).LookVector
		arg2 = arg2:Lerp(CFrame.new(v_current_camera.CFrame.Position + (arg3.Position - Vector3.new(v_lookvector.X, 0, v_lookvector.Z).Unit * v_getcameratosubjectdistance) - v1.Position) * v_current_camera.CFrame.Rotation, 0.01)
	end
	return arg2, arg3
end
function v_u11.UpdateRotationCamera(arg1, arg2)
	-- upvalues: (copy) v_u_mapclamp, (copy) v_u_localplayer
	local v_current_camera = workspace.CurrentCamera
	local v1
	if v_current_camera then
		v1 = v_current_camera.CameraSubject
	else
		v1 = v_current_camera
	end
	local v_vehiclecameracore = arg1.vehicleCameraCore
	assert(v_current_camera)
	assert(v1)
	assert(v1:IsA("VehicleSeat"))
	local v_getsubjectcframe = arg1:GetSubjectCFrame()
	local v_getsubjectvelocity = arg1:GetSubjectVelocity()
	local v_getsubjectrotvelocity = arg1:GetSubjectRotVelocity()
	local v_dot = v_getsubjectvelocity:Dot(v_getsubjectcframe.ZVector)
	local v_abs = math.abs(v_dot)
	local v_dot = v_getsubjectcframe.YVector:Dot(v_getsubjectrotvelocity)
	local v_abs = math.abs(v_dot)
	local v_dot = v_getsubjectcframe.XVector:Dot(v_getsubjectrotvelocity)
	local v_abs = math.abs(v_dot)
	local v_getcameratosubjectdistance = arg1:GetCameraToSubjectDistance()
	local v2 = v_u_mapclamp(v_getcameratosubjectdistance, 0.5, arg1.assemblyRadius, 1, 0)
	local v_lerp = arg1:_GetThirdPersonLocalOffset():Lerp(arg1:_GetFirstPersonLocalOffset(v_getsubjectcframe), v2)
	v_vehiclecameracore:setTransform(v_getsubjectcframe)
	local v_step = v_vehiclecameracore:step(arg2, v_abs, v_abs, v2)
	local v__steprotation = arg1:_StepRotation(arg2, v_abs)
	local v3 = arg1:GetVRFocus(v_getsubjectcframe * v_lerp, arg2) * v_step * v__steprotation
	local v4 = v3 * CFrame.new(0, 0, v_getcameratosubjectdistance)
	if v_getsubjectvelocity.Magnitude > 0.1 then
		arg1:StartVREdgeBlur(v_u_localplayer)
	end
	return v4, v3
end
function v_u11.UpdateStepRotation(arg1, arg2)
	-- upvalues: (copy) v_u_mapclamp, (copy) v_u_usergamesettings, (copy) v_u_vr, (copy) v_u_localplayer
	local v_current_camera = workspace.CurrentCamera
	local v_getsubjectcframe = arg1:GetSubjectCFrame()
	local v_getsubjectvelocity = arg1:GetSubjectVelocity()
	local v_getcameratosubjectdistance = arg1:GetCameraToSubjectDistance()
	local v1 = v_u_mapclamp(v_getcameratosubjectdistance, 0.5, arg1.assemblyRadius, 1, 0)
	local v_lerp = arg1:_GetThirdPersonLocalOffset():Lerp(arg1:_GetFirstPersonLocalOffset(v_getsubjectcframe), v1)
	local v_getvrfocus = arg1:GetVRFocus(v_getsubjectcframe * v_lerp, arg2)
	local v_adddrift, v2 = arg1:addDrift(v_getvrfocus:ToWorldSpace(arg1:GetVRFocus(arg1.lastSubjectCFrame * v_lerp, arg2):ToObjectSpace(v_current_camera.CFrame)), v_getvrfocus)
	local v_getrotation = arg1:getRotation(arg2)
	local v3
	if math.abs(v_getrotation) > 0 then
		local v_toobjectspace = v2:ToObjectSpace(v_adddrift)
		v3 = v2 * CFrame.Angles(0, -v_getrotation, 0) * v_toobjectspace
		if not v_u_usergamesettings.VRSmoothRotationEnabled then
			local v_getusercframe = v_u_vr:GetUserCFrame(Enum.UserCFrame.Head)
			local v4 = v_getusercframe.Rotation + v_getusercframe.Position * v_current_camera.HeadScale
			local v5 = v2 * v_getsubjectcframe.Rotation
			local v_toobjectspace = v5:ToObjectSpace(v_adddrift * v4)
			local v_dot = Vector3.new(v_toobjectspace.X, 0, v_toobjectspace.Z).Unit:Dot(Vector3.new(0, 0, 1))
			local v_acos = math.acos(v_dot)
			local v_toobjectspace = v5:ToObjectSpace(v3 * v4)
			local v_dot = Vector3.new(v_toobjectspace.X, 0, v_toobjectspace.Z).Unit:Dot(Vector3.new(0, 0, 1))
			if math.acos(v_dot) < v_acos then
				if v_getrotation < 0 then
					v_acos = v_acos * -1
				end
				v3 = v2 * CFrame.Angles(0, -v_acos, 0) * v_toobjectspace
			end
		end
	else
		v3 = v_adddrift
	end
	if v_getsubjectvelocity.Magnitude > 0.1 then
		arg1:StartVREdgeBlur(v_u_localplayer)
	end
	if arg1.needsReset then
		arg1.needsReset = false
		v_u_vr:RecenterUserHeadCFrame()
		arg1:StartFadeFromBlack()
		arg1:ResetZoom()
	end
	if arg1.recentered then
		v3 = v2 * v_getsubjectcframe.Rotation * CFrame.new(0, 0, v_getcameratosubjectdistance)
		arg1.recentered = false
	end
	return v3, v3 * CFrame.new(0, 0, -v_getcameratosubjectdistance)
end
function v_u11.UpdateComfortCamera(arg1, arg2)
	-- upvalues: (ref) v_u3, (ref) v_u10, (copy) v_u_mapclamp, (copy) v_u_localplayer
	local v_current_camera = workspace.CurrentCamera
	local v1
	if v_current_camera then
		v1 = v_current_camera.CameraSubject
	else
		v1 = v_current_camera
	end
	local v_vehiclecameracore = arg1.vehicleCameraCore
	assert(v_current_camera)
	assert(v1)
	assert(v1:IsA("VehicleSeat"))
	if not v_u3 then
		arg2 = v_u10
		v_u10 = 0
	end
	local v_getsubjectcframe = arg1:GetSubjectCFrame()
	local v_getsubjectvelocity = arg1:GetSubjectVelocity()
	local v_getsubjectrotvelocity = arg1:GetSubjectRotVelocity()
	local v_dot = v_getsubjectvelocity:Dot(v_getsubjectcframe.ZVector)
	math.abs(v_dot)
	local v_dot = v_getsubjectcframe.YVector:Dot(v_getsubjectrotvelocity)
	local v_abs = math.abs(v_dot)
	local v_dot = v_getsubjectcframe.XVector:Dot(v_getsubjectrotvelocity)
	local v_abs = math.abs(v_dot)
	local v_stepzoom = arg1:StepZoom()
	local v2 = v_u_mapclamp(v_stepzoom, 0.5, arg1.assemblyRadius, 1, 0)
	local v_lerp = arg1:_GetThirdPersonLocalOffset():Lerp(arg1:_GetFirstPersonLocalOffset(v_getsubjectcframe), v2)
	v_vehiclecameracore:setTransform(v_getsubjectcframe)
	local v_step = v_vehiclecameracore:step(arg2, v_abs, v_abs, v2)
	if not v_u3 then
		arg1:UpdateFadeFromBlack(arg2)
	end
	local v3, v4
	if arg1:IsInFirstPerson() then
		local v_new = CFrame.new(v_step.Position, Vector3.new(v_step.LookVector.X, 0, v_step.LookVector.Z).Unit)
		v3 = CFrame.new(v_getsubjectcframe * v_lerp) * v_new
		v4 = v3 * CFrame.new(0, 0, v_stepzoom)
		if v_u3 then
			if v_getsubjectvelocity.Magnitude > 0.1 then
				arg1:StartVREdgeBlur(v_u_localplayer)
			end
		else
			arg1:StartVREdgeBlur(v_u_localplayer)
		end
	else
		v3 = CFrame.new(v_getsubjectcframe * v_lerp) * v_step
		v4 = v3 * CFrame.new(0, 0, v_stepzoom)
		if not arg1.lastCameraFocus then
			arg1.lastCameraFocus = v3
			arg1.needsReset = true
		end
		if (v3.Position - v_current_camera.CFrame.Position).Unit:Dot(v_current_camera.CFrame.LookVector) > 0.56 and ((v3.Position - v_current_camera.CFrame.Position).magnitude < 200 and not arg1.needsReset) then
			v3 = arg1.lastCameraFocus
			local v_p = v3.p
			local v_getcameralookvector = arg1:GetCameraLookVector()
			local v_calculatenewlookvectorfromarg = arg1:CalculateNewLookVectorFromArg(Vector3.new(v_getcameralookvector.X, 0, v_getcameralookvector.Z).Unit, Vector2.new(0, 0))
			v4 = CFrame.new(v_p - v_stepzoom * v_calculatenewlookvectorfromarg, v_p)
		else
			arg1.lastCameraFocus = arg1:GetVRFocus(v_getsubjectcframe.Position, arg2)
			arg1.needsReset = false
			arg1:StartFadeFromBlack()
			arg1:ResetZoom()
		end
		if not v_u3 then
			arg1:UpdateEdgeBlur(v_u_localplayer, arg2)
		end
	end
	return v4, v3
end
return v_u11