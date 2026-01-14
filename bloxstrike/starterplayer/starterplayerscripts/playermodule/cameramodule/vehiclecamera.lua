-- Decompiled with Bunni.lol Decompiler

local v_u1 = { 0, 15, 30 }
local v_players = game:GetService("Players")
local v_run = game:GetService("RunService")
local v_u2 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u3 = require(script.Parent:WaitForChild("CameraInput"))
local v_u4 = require(script.Parent:WaitForChild("CameraUtils"))
require(script.Parent:WaitForChild("ZoomController"))
local v_u5 = require(script:WaitForChild("VehicleCameraCore"))
local v_u6 = require(script:WaitForChild("VehicleCameraConfig"))
local v_u_localplayer = v_players.LocalPlayer
local _ = v_u4.map
local v_u_spring = v_u4.Spring
local v_u_mapclamp = v_u4.mapClamp
local v_u_sanitizeangle = v_u4.sanitizeAngle
local v_u7 = 0.016666666666666666
v_run.Stepped:Connect(function(_, arg2)
	-- upvalues: (ref) v_u7
	v_u7 = arg2
end)
local v_u8 = setmetatable({}, v_u2)
v_u8.__index = v_u8
function v_u8.new()
	-- upvalues: (copy) v_u2, (copy) v_u8
	local v_new = v_u2.new()
	local v1 = setmetatable(v_new, v_u8)
	v1:Reset()
	return v1
end
function v_u8.Reset(arg1)
	-- upvalues: (copy) v_u5, (copy) v_u_spring, (copy) v_u6, (copy) v_u4, (copy) v_u1
	arg1.vehicleCameraCore = v_u5.new(arg1:GetSubjectCFrame())
	arg1.pitchSpring = v_u_spring.new(0, -math.rad(v_u6.pitchBaseAngle))
	arg1.yawSpring = v_u_spring.new(0, 0)
	arg1.lastPanTick = 0
	local v_current_camera = workspace.CurrentCamera
	local v1
	if v_current_camera then
		v1 = v_current_camera.CameraSubject
	else
		v1 = v_current_camera
	end
	assert(v_current_camera)
	assert(v1)
	assert(v1:IsA("VehicleSeat"))
	local v_getconnectedparts = v1:GetConnectedParts(true)
	local v_getlooseboundingsphere, v2 = v_u4.getLooseBoundingSphere(v_getconnectedparts)
	arg1.assemblyRadius = math.max(v2, 5)
	arg1.assemblyOffset = v1.CFrame:Inverse() * v_getlooseboundingsphere
	arg1.gamepadZoomLevels = {}
	for _, v3 in v_u1 do
		table.insert(arg1.gamepadZoomLevels, v3 * arg1.assemblyRadius / 10)
	end
	arg1:SetCameraToSubjectDistance(arg1.gamepadZoomLevels[#arg1.gamepadZoomLevels])
end
function v_u8._StepRotation(arg1, arg2, arg3)
	-- upvalues: (copy) v_u3, (copy) v_u_sanitizeangle, (copy) v_u6, (copy) v_u_mapclamp
	local v_yawspring = arg1.yawSpring
	local v_pitchspring = arg1.pitchSpring
	local v_getrotation = v_u3.getRotation(arg2, true)
	v_yawspring.pos = v_u_sanitizeangle(v_yawspring.pos + -v_getrotation.X)
	v_pitchspring.pos = v_u_sanitizeangle((math.clamp(v_pitchspring.pos + -v_getrotation.Y, -1.3962634015954636, 1.3962634015954636)))
	if v_u3.getRotationActivated() then
		arg1.lastPanTick = os.clock()
	end
	local v1 = -math.rad(v_u6.pitchBaseAngle)
	local v_rad = math.rad(v_u6.pitchDeadzoneAngle)
	if os.clock() - arg1.lastPanTick > v_u6.autocorrectDelay then
		local v2 = v_u_mapclamp(arg3, v_u6.autocorrectMinCarSpeed, v_u6.autocorrectMaxCarSpeed, 0, v_u6.autocorrectResponse)
		v_yawspring.freq = v2
		v_pitchspring.freq = v2
		if v_yawspring.freq < 0.001 then
			v_yawspring.vel = 0
		end
		if v_pitchspring.freq < 0.001 then
			v_pitchspring.vel = 0
		end
		local v3 = v_u_sanitizeangle(v1 - v_pitchspring.pos)
		if math.abs(v3) <= v_rad then
			v_pitchspring.goal = v_pitchspring.pos
		else
			v_pitchspring.goal = v1
		end
	else
		v_yawspring.freq = 0
		v_yawspring.vel = 0
		v_pitchspring.freq = 0
		v_pitchspring.vel = 0
		v_pitchspring.goal = v1
	end
	return CFrame.fromEulerAnglesYXZ(v_pitchspring:step(arg2), v_yawspring:step(arg2), 0)
end
function v_u8._GetThirdPersonLocalOffset(arg1)
	-- upvalues: (copy) v_u6
	return arg1.assemblyOffset + Vector3.new(0, arg1.assemblyRadius * v_u6.verticalCenterOffset, 0)
end
function v_u8._GetFirstPersonLocalOffset(arg1, arg2)
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
function v_u8.Update(arg1)
	-- upvalues: (ref) v_u7, (copy) v_u_mapclamp
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
	local v2 = v_u7
	v_u7 = 0
	local v_getsubjectcframe = arg1:GetSubjectCFrame()
	local v_getsubjectvelocity = arg1:GetSubjectVelocity()
	local v_getsubjectrotvelocity = arg1:GetSubjectRotVelocity()
	local v_dot = v_getsubjectvelocity:Dot(v_getsubjectcframe.ZVector)
	local v_abs = math.abs(v_dot)
	local v_dot = v_getsubjectcframe.YVector:Dot(v_getsubjectrotvelocity)
	local v_abs = math.abs(v_dot)
	local v_dot = v_getsubjectcframe.XVector:Dot(v_getsubjectrotvelocity)
	local v_abs = math.abs(v_dot)
	local v_stepzoom = arg1:StepZoom()
	local v__steprotation = arg1:_StepRotation(v2, v_abs)
	local v3 = v_u_mapclamp(v_stepzoom, 0.5, arg1.assemblyRadius, 1, 0)
	local v_lerp = arg1:_GetThirdPersonLocalOffset():Lerp(arg1:_GetFirstPersonLocalOffset(v_getsubjectcframe), v3)
	v_vehiclecameracore:setTransform(v_getsubjectcframe)
	local v_step = v_vehiclecameracore:step(v2, v_abs, v_abs, v3)
	local v4 = CFrame.new(v_getsubjectcframe * v_lerp) * v_step * v__steprotation
	return v4 * CFrame.new(0, 0, v_stepzoom), v4
end
function v_u8.ApplyVRTransform(_) end
return v_u8