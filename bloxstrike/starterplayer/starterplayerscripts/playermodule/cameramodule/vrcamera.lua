-- Decompiled with Bunni.lol Decompiler

local v_u_players = game:GetService("Players")
local v_u_vr = game:GetService("VRService")
UserSettings():GetService("UserGameSettings")
require(script.Parent:WaitForChild("CameraInput"))
require(script.Parent:WaitForChild("CameraUtils"))
local v_u1 = require(script.Parent:WaitForChild("VRBaseCamera"))
local v_u2 = setmetatable({}, v_u1)
v_u2.__index = v_u2
function v_u2.new()
	-- upvalues: (copy) v_u1, (copy) v_u2, (copy) v_u_players
	local v_new = v_u1.new()
	local v1 = setmetatable(v_new, v_u2)
	v1.lastUpdate = tick()
	v1.focusOffset = CFrame.new()
	v1:Reset()
	v1.controlModule = require(v_u_players.LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"))
	v1.savedAutoRotate = true
	return v1
end
function v_u2.Reset(arg1)
	-- upvalues: (copy) v_u1
	arg1.needsReset = true
	arg1.needsBlackout = true
	arg1.motionDetTime = 0
	arg1.blackOutTimer = 0
	arg1.lastCameraResetPosition = nil
	v_u1.Reset(arg1)
end
function v_u2.Update(arg1, arg2)
	-- upvalues: (copy) v_u_players, (copy) v_u_vr
	local v_current_camera = workspace.CurrentCamera
	local v_cframe = v_current_camera.CFrame
	local v_focus = v_current_camera.Focus
	local v_localplayer = v_u_players.LocalPlayer
	arg1:GetHumanoid()
	local _ = v_current_camera.CameraSubject
	if arg1.lastUpdate == nil or arg2 > 1 then
		arg1.lastCameraTransform = nil
	end
	arg1:UpdateFadeFromBlack(arg2)
	arg1:UpdateEdgeBlur(v_localplayer, arg2)
	local v_lastsubjectposition = arg1.lastSubjectPosition
	local v_getsubjectposition = arg1:GetSubjectPosition()
	if arg1.needsBlackout then
		arg1:StartFadeFromBlack()
		local v_clamp = math.clamp(arg2, 0.0001, 0.1)
		arg1.blackOutTimer = arg1.blackOutTimer + v_clamp
		if arg1.blackOutTimer > 0.1 and game:IsLoaded() then
			arg1.needsBlackout = false
			arg1.needsReset = true
		end
	end
	if v_getsubjectposition and (v_localplayer and v_current_camera) then
		local v_getvrfocus = arg1:GetVRFocus(v_getsubjectposition, arg2)
		if arg1:IsInFirstPerson() then
			if v_u_vr.AvatarGestures then
				v_cframe, v_focus = arg1:UpdateImmersionCamera(arg2, v_cframe, v_getvrfocus, v_lastsubjectposition, v_getsubjectposition)
			else
				v_cframe, v_focus = arg1:UpdateFirstPersonTransform(arg2, v_cframe, v_getvrfocus, v_lastsubjectposition, v_getsubjectposition)
			end
		elseif v_u_vr.ThirdPersonFollowCamEnabled then
			v_cframe, v_focus = arg1:UpdateThirdPersonFollowTransform(arg2, v_cframe, v_getvrfocus, v_lastsubjectposition, v_getsubjectposition)
		else
			v_cframe, v_focus = arg1:UpdateThirdPersonComfortTransform(arg2, v_cframe, v_getvrfocus, v_lastsubjectposition, v_getsubjectposition)
		end
		arg1.lastCameraTransform = v_cframe
		arg1.lastCameraFocus = v_focus
	end
	arg1.lastUpdate = tick()
	return v_cframe, v_focus
end
function v_u2.GetAvatarFeetWorldYValue(_)
	local v_camerasubject = workspace.CurrentCamera.CameraSubject
	if not v_camerasubject then
		return nil
	end
	if not (v_camerasubject:IsA("Humanoid") and v_camerasubject.RootPart) then
		return nil
	end
	local v_rootpart = v_camerasubject.RootPart
	return v_rootpart.Position.Y - v_rootpart.Size.Y / 2 - v_camerasubject.HipHeight
end
function v_u2.UpdateFirstPersonTransform(arg1, arg2, _, arg4, arg5, arg6)
	-- upvalues: (copy) v_u_players
	if arg1.needsReset then
		arg1:StartFadeFromBlack()
		arg1.needsReset = false
	end
	local v_localplayer = v_u_players.LocalPlayer
	if (arg5 - arg6).magnitude > 0.01 then
		arg1:StartVREdgeBlur(v_localplayer)
	end
	local v_p = arg4.p
	local v_getcameralookvector = arg1:GetCameraLookVector()
	local v_getrotation = arg1:getRotation(arg2)
	local v_calculatenewlookvectorfromarg = arg1:CalculateNewLookVectorFromArg(Vector3.new(v_getcameralookvector.X, 0, v_getcameralookvector.Z).Unit, Vector2.new(v_getrotation, 0))
	return CFrame.new(v_p - 0.5 * v_calculatenewlookvectorfromarg, v_p), arg4
end
function v_u2.UpdateImmersionCamera(arg1, arg2, _, _, _, arg6)
	-- upvalues: (copy) v_u_players, (copy) v_u_vr
	local v_getsubjectcframe = arg1:GetSubjectCFrame()
	local v_current_camera = workspace.CurrentCamera
	local v_character = v_u_players.LocalPlayer.Character
	local v_gethumanoid = arg1:GetHumanoid()
	if not v_gethumanoid then
		return v_current_camera.CFrame, v_current_camera.Focus
	end
	local v_humanoidrootpart = v_character:FindFirstChild("HumanoidRootPart")
	if not v_humanoidrootpart then
		return v_current_camera.CFrame, v_current_camera.Focus
	end
	arg1.characterOrientation = v_humanoidrootpart:FindFirstChild("CharacterAlignOrientation")
	if not arg1.characterOrientation then
		local v_rootattachment = v_humanoidrootpart:FindFirstChild("RootAttachment")
		if not v_rootattachment then
			return
		end
		arg1.characterOrientation = Instance.new("AlignOrientation")
		arg1.characterOrientation.Name = "CharacterAlignOrientation"
		arg1.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
		arg1.characterOrientation.Attachment0 = v_rootattachment
		arg1.characterOrientation.RigidityEnabled = true
		arg1.characterOrientation.Parent = v_humanoidrootpart
	end
	if arg1.characterOrientation.Enabled == false then
		arg1.characterOrientation.Enabled = true
	end
	if arg1.needsReset then
		arg1.needsReset = false
		arg1.savedAutoRotate = v_gethumanoid.AutoRotate
		v_gethumanoid.AutoRotate = false
		if arg1.NoRecenter then
			arg1.NoRecenter = false
			v_u_vr:RecenterUserHeadCFrame()
		end
		arg1:StartFadeFromBlack()
	elseif v_gethumanoid.Sit then
		if (v_getsubjectcframe.Position - v_current_camera.CFrame.Position).Magnitude > 0.01 then
			arg1:StartVREdgeBlur(v_u_players.LocalPlayer)
		end
	else
		local v_getestimatedvrtorsoframe = arg1.controlModule:GetEstimatedVRTorsoFrame()
		arg1.characterOrientation.CFrame = v_current_camera.CFrame * v_getestimatedvrtorsoframe
		if arg1.controlModule.inputMoveVector.Magnitude > 0 then
			arg1.motionDetTime = 0.1
		end
		if arg1.controlModule.inputMoveVector.Magnitude > 0 or arg1.motionDetTime > 0 then
			arg1.motionDetTime = arg1.motionDetTime - arg2
			arg1:StartVREdgeBlur(v_u_players.LocalPlayer)
			local v_getusercframe = v_u_vr:GetUserCFrame(Enum.UserCFrame.Head)
			local v_lookvector = v_character.HumanoidRootPart.CFrame.LookVector
			local v1 = arg6 - (v_current_camera.CFrame * (v_getusercframe.Rotation + v_getusercframe.Position * v_current_camera.HeadScale) * CFrame.new(0, -0.7 * UNNAMED_1728998481720.Size.Y / 2, 0) - Vector3.new(v_lookvector.X, 0, v_lookvector.Z).Unit * UNNAMED_1728998481720.Size.Y * 0.125).Position + v_current_camera.CFrame.Position
			local v_new = Vector3.new(v1.X, arg6.Y, v1.Z)
			v_getsubjectcframe = v_current_camera.CFrame.Rotation + v_new
		else
			v_getsubjectcframe = v_current_camera.CFrame.Rotation + Vector3.new(v_current_camera.CFrame.Position.X, arg6.Y, v_current_camera.CFrame.Position.Z)
		end
		local v_getrotation = arg1:getRotation(arg2)
		if math.abs(v_getrotation) > 0 then
			local v_getusercframe = v_u_vr:GetUserCFrame(Enum.UserCFrame.Head)
			local v2 = v_getusercframe.Rotation + v_getusercframe.Position * v_current_camera.HeadScale
			local v3 = v_getsubjectcframe * v2
			v_getsubjectcframe = CFrame.new(v3.Position) * CFrame.Angles(0, -math.rad(v_getrotation * 90), 0) * v3.Rotation * v2:Inverse()
		end
	end
	return v_getsubjectcframe, v_getsubjectcframe * CFrame.new(0, 0, -0.5)
end
function v_u2.UpdateThirdPersonComfortTransform(arg1, arg2, arg3, arg4, arg5, arg6)
	-- upvalues: (copy) v_u_players, (copy) v_u_vr
	local v_getcameratosubjectdistance = arg1:GetCameraToSubjectDistance()
	local v1 = v_getcameratosubjectdistance < 0.5 and 0.5 or v_getcameratosubjectdistance
	if arg5 ~= nil and arg1.lastCameraFocus ~= nil then
		local _ = v_u_players.LocalPlayer
		local v_getmovevector = arg1.controlModule:GetMoveVector()
		local v2 = (arg5 - arg6).magnitude > 0.01 and true or v_getmovevector.magnitude > 0.01
		if v2 then
			arg1.motionDetTime = 0.1
		end
		arg1.motionDetTime = arg1.motionDetTime - arg2
		if (arg1.motionDetTime > 0 and true or v2) and not arg1.needsReset then
			arg1.VRCameraFocusFrozen = true
			return arg3, arg1.lastCameraFocus
		end
		local v3 = arg1.lastCameraResetPosition == nil and true or (arg6 - arg1.lastCameraResetPosition).Magnitude > 1
		local v_getrotation = arg1:getRotation(arg2)
		if math.abs(v_getrotation) > 0 then
			local v_toobjectspace = arg4:ToObjectSpace(arg3)
			arg3 = arg4 * CFrame.Angles(0, -v_getrotation, 0) * v_toobjectspace
		end
		if arg1.VRCameraFocusFrozen and v3 or arg1.needsReset then
			v_u_vr:RecenterUserHeadCFrame()
			arg1.VRCameraFocusFrozen = false
			arg1.needsReset = false
			arg1.lastCameraResetPosition = arg6
			arg1:ResetZoom()
			arg1:StartFadeFromBlack()
			local v_gethumanoid = arg1:GetHumanoid()
			local v4 = v_gethumanoid.Torso and v_gethumanoid.Torso.CFrame.lookVector or Vector3.new(1, 0, 0)
			local v_new = Vector3.new(v4.X, 0, v4.Z)
			local v_new = Vector3.new(arg4.Position.X, (arg4.Position - v_new * v1).Y, arg4.Position.Z)
			arg3 = CFrame.new(UNNAMED_1728998481336, v_new)
		end
	end
	return arg3, arg4
end
function v_u2.UpdateThirdPersonFollowTransform(arg1, arg2, _, _, arg5, arg6)
	-- upvalues: (copy) v_u_vr, (copy) v_u_players
	local v_current_camera = workspace.CurrentCamera
	local v_getcameratosubjectdistance = arg1:GetCameraToSubjectDistance()
	local v_getvrfocus = arg1:GetVRFocus(arg6, arg2)
	if arg1.needsReset then
		arg1.needsReset = false
		v_u_vr:RecenterUserHeadCFrame()
		arg1:ResetZoom()
		arg1:StartFadeFromBlack()
	end
	if arg1.recentered then
		local v_getsubjectcframe = arg1:GetSubjectCFrame()
		if not v_getsubjectcframe then
			return v_current_camera.CFrame, v_current_camera.Focus
		end
		local v1 = v_getvrfocus * v_getsubjectcframe.Rotation * CFrame.new(0, 0, v_getcameratosubjectdistance)
		arg1.focusOffset = v_getvrfocus:ToObjectSpace(v1)
		arg1.recentered = false
		return v1, v_getvrfocus
	end
	local v_toworldspace = v_getvrfocus:ToWorldSpace(arg1.focusOffset)
	local _ = v_u_players.LocalPlayer
	local v_controlmodule = arg1.controlModule
	local v_getmovevector = v_controlmodule:GetMoveVector()
	if (arg5 - arg6).magnitude > 0.01 or v_getmovevector.magnitude > 0 then
		local v_getestimatedvrtorsoframe = v_controlmodule:GetEstimatedVRTorsoFrame()
		local v2 = v_current_camera.CFrame * (v_getestimatedvrtorsoframe.Rotation + v_getestimatedvrtorsoframe.Position * v_current_camera.HeadScale)
		local v_lookvector = v2.LookVector
		v_toworldspace = v_toworldspace:Lerp(CFrame.new(v_current_camera.CFrame.Position + (v_getvrfocus.Position - Vector3.new(v_lookvector.X, 0, v_lookvector.Z).Unit * v_getcameratosubjectdistance) - v2.Position) * v_toworldspace.Rotation, 0.01)
	end
	local v_getrotation = arg1:getRotation(arg2)
	if math.abs(v_getrotation) > 0 then
		local v_toobjectspace = v_getvrfocus:ToObjectSpace(v_toworldspace)
		v_toworldspace = v_getvrfocus * CFrame.Angles(0, -v_getrotation, 0) * v_toobjectspace
	end
	arg1.focusOffset = v_getvrfocus:ToObjectSpace(v_toworldspace)
	local v3 = v_toworldspace * CFrame.new(0, 0, -v_getcameratosubjectdistance)
	if (v3.Position - v_current_camera.Focus.Position).Magnitude > 0.01 then
		arg1:StartVREdgeBlur(v_u_players.LocalPlayer)
	end
	return v_toworldspace, v3
end
function v_u2.LeaveFirstPerson(arg1)
	-- upvalues: (copy) v_u1
	v_u1.LeaveFirstPerson(arg1)
	arg1.needsReset = true
	if arg1.VRBlur then
		arg1.VRBlur.Visible = false
	end
	if arg1.characterOrientation then
		arg1.characterOrientation.Enabled = false
	end
	local v_gethumanoid = arg1:GetHumanoid()
	if v_gethumanoid then
		v_gethumanoid.AutoRotate = arg1.savedAutoRotate
	end
end
return v_u2