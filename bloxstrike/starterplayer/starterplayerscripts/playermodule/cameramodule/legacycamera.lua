-- Decompiled with Bunni.lol Decompiler

Vector2.new()
require(script.Parent:WaitForChild("CameraUtils"))
local v_u1 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_players = game:GetService("Players")
local v_u2 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u3 = setmetatable({}, v_u2)
v_u3.__index = v_u3
function v_u3.new()
	-- upvalues: (copy) v_u2, (copy) v_u3
	local v_new = v_u2.new()
	local v1 = setmetatable(v_new, v_u3)
	v1.cameraType = Enum.CameraType.Fixed
	v1.lastUpdate = tick()
	v1.lastDistanceToSubject = nil
	return v1
end
function v_u3.GetModuleName(_)
	return "LegacyCamera"
end
function v_u3.SetCameraToSubjectDistance(arg1, arg2)
	-- upvalues: (copy) v_u2
	return v_u2.SetCameraToSubjectDistance(arg1, arg2)
end
function v_u3.Update(arg1, arg2)
	-- upvalues: (copy) v_u_players, (copy) v_u1
	if not arg1.cameraType then
		return nil, nil
	end
	local v1 = tick()
	local v_current_camera = workspace.CurrentCamera
	local v_cframe = v_current_camera.CFrame
	local v_focus = v_current_camera.Focus
	local v_localplayer = v_u_players.LocalPlayer
	local v_getrotation = v_u1.getRotation(arg2)
	if arg1.lastUpdate == nil or v1 - arg1.lastUpdate > 1 then
		arg1.lastDistanceToSubject = nil
	end
	local v_getsubjectposition = arg1:GetSubjectPosition()
	if arg1.cameraType == Enum.CameraType.Fixed then
		if v_getsubjectposition and (v_localplayer and v_current_camera) then
			local v_getcameratosubjectdistance = arg1:GetCameraToSubjectDistance()
			local v_calculatenewlookvectorfromarg = arg1:CalculateNewLookVectorFromArg(nil, v_getrotation)
			v_focus = v_current_camera.Focus
			v_cframe = CFrame.new(v_current_camera.CFrame.p, v_current_camera.CFrame.p + v_getcameratosubjectdistance * v_calculatenewlookvectorfromarg)
		end
	elseif arg1.cameraType == Enum.CameraType.Attach then
		local v_getsubjectcframe = arg1:GetSubjectCFrame()
		local v_toeuleranglesyxz = v_current_camera.CFrame:ToEulerAnglesYXZ()
		local _, v2 = v_getsubjectcframe:ToEulerAnglesYXZ()
		local v_clamp = math.clamp(v_toeuleranglesyxz - v_getrotation.Y, -1.3962634015954636, 1.3962634015954636)
		v_focus = CFrame.new(v_getsubjectcframe.p) * CFrame.fromEulerAnglesYXZ(v_clamp, v2, 0)
		v_cframe = v_focus * CFrame.new(0, 0, arg1:StepZoom())
	else
		if arg1.cameraType ~= Enum.CameraType.Watch then
			return v_current_camera.CFrame, v_current_camera.Focus
		end
		if v_getsubjectposition and (v_localplayer and v_current_camera) then
			local v3 = nil
			if v_getsubjectposition == v_current_camera.CFrame.p then
				warn("Camera cannot watch subject in same position as itself")
				return v_current_camera.CFrame, v_current_camera.Focus
			end
			local v_gethumanoid = arg1:GetHumanoid()
			if v_gethumanoid and v_gethumanoid.RootPart then
				local v4 = v_getsubjectposition - v_current_camera.CFrame.p
				v3 = v4.unit
				if arg1.lastDistanceToSubject and arg1.lastDistanceToSubject == arg1:GetCameraToSubjectDistance() then
					arg1:SetCameraToSubjectDistance(v4.magnitude)
				end
			end
			local v_getcameratosubjectdistance = arg1:GetCameraToSubjectDistance()
			local v_calculatenewlookvectorfromarg = arg1:CalculateNewLookVectorFromArg(v3, v_getrotation)
			v_focus = CFrame.new(v_getsubjectposition)
			v_cframe = CFrame.new(v_getsubjectposition - v_getcameratosubjectdistance * v_calculatenewlookvectorfromarg, v_getsubjectposition)
			arg1.lastDistanceToSubject = v_getcameratosubjectdistance
		end
	end
	arg1.lastUpdate = v1
	return v_cframe, v_focus
end
return v_u3