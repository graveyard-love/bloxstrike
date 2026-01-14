-- Decompiled with Bunni.lol Decompiler

local v1, v2 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserVRVehicleCamera2")
end)
local v_u3 = v1 and v2
local v_u_vr = game:GetService("VRService")
local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u_lighting = game:GetService("Lighting")
local v_u_run = game:GetService("RunService")
local v_u_usergamesettings = UserSettings():GetService("UserGameSettings")
local v_u4 = require(script.Parent:WaitForChild("CameraInput"))
local v_u5 = require(script.Parent:WaitForChild("ZoomController"))
local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_usercamerainputdt = require(v_commonutils:WaitForChild("FlagUtil")).getUserFlag("UserCameraInputDt")
local v_u6 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u7 = setmetatable({}, v_u6)
v_u7.__index = v_u7
function v_u7.new()
	-- upvalues: (copy) v_u6, (copy) v_u7
	local v_new = v_u6.new()
	local v1 = setmetatable(v_new, v_u7)
	v1.gamepadZoomLevels = { 0, 7 }
	v1.headScale = 1
	v1:SetCameraToSubjectDistance(7)
	v1.VRFadeResetTimer = 0
	v1.VREdgeBlurTimer = 0
	v1.gamepadResetConnection = nil
	v1.needsReset = true
	v1.recentered = false
	v1:Reset()
	return v1
end
function v_u7.Reset(arg1)
	arg1.stepRotateTimeout = 0
end
function v_u7.GetModuleName(_)
	return "VRBaseCamera"
end
function v_u7.GamepadZoomPress(arg1)
	-- upvalues: (copy) v_u6
	v_u6.GamepadZoomPress(arg1)
	arg1:GamepadReset()
	arg1:ResetZoom()
end
function v_u7.GamepadReset(arg1)
	arg1.stepRotateTimeout = 0
	arg1.needsReset = true
end
function v_u7.ResetZoom(arg1)
	-- upvalues: (copy) v_u5
	v_u5.SetZoomParameters(arg1.currentSubjectDistance, 0)
	v_u5.ReleaseSpring()
end
function v_u7.OnEnabledChanged(self)
	-- upvalues: (copy) v_u6, (copy) v_u4, (copy) v_u_vr, (ref) v_u3, (copy) v_u_localplayer, (copy) v_u_lighting
	v_u6.OnEnabledChanged(self)
	if self.enabled then
		self.gamepadResetConnection = v_u4.gamepadReset:Connect(function()
			-- upvalues: (copy) self
			self:GamepadReset()
		end)
		self.thirdPersonOptionChanged = v_u_vr:GetPropertyChangedSignal("ThirdPersonFollowCamEnabled"):Connect(function()
			-- upvalues: (ref) v_u3, (copy) self
			if v_u3 then
				self:Reset()
			elseif not self:IsInFirstPerson() then
				self:Reset()
			end
		end)
		self.vrRecentered = v_u_vr.UserCFrameChanged:Connect(function(arg1, _)
			-- upvalues: (copy) self
			if arg1 == Enum.UserCFrame.Floor then
				self.recentered = true
			end
		end)
	else
		if self.inFirstPerson then
			self:GamepadZoomPress()
		end
		if self.thirdPersonOptionChanged then
			self.thirdPersonOptionChanged:Disconnect()
			self.thirdPersonOptionChanged = nil
		end
		if self.vrRecentered then
			self.vrRecentered:Disconnect()
			self.vrRecentered = nil
		end
		if self.cameraHeadScaleChangedConn then
			self.cameraHeadScaleChangedConn:Disconnect()
			self.cameraHeadScaleChangedConn = nil
		end
		if self.gamepadResetConnection then
			self.gamepadResetConnection:Disconnect()
			self.gamepadResetConnection = nil
		end
		self.VREdgeBlurTimer = 0
		self:UpdateEdgeBlur(v_u_localplayer, 1)
		local v_vrfade = v_u_lighting:FindFirstChild("VRFade")
		if v_vrfade then
			v_vrfade.Brightness = 0
		end
	end
end
function v_u7.OnCurrentCameraChanged(self)
	-- upvalues: (copy) v_u6
	v_u6.OnCurrentCameraChanged(self)
	if self.cameraHeadScaleChangedConn then
		self.cameraHeadScaleChangedConn:Disconnect()
		self.cameraHeadScaleChangedConn = nil
	end
	local v_current_camera = workspace.CurrentCamera
	if v_current_camera then
		self.cameraHeadScaleChangedConn = v_current_camera:GetPropertyChangedSignal("HeadScale"):Connect(function()
			-- upvalues: (copy) self
			self:OnHeadScaleChanged()
		end)
		self:OnHeadScaleChanged()
	end
end
function v_u7.OnHeadScaleChanged(arg1)
	local v_headscale = workspace.CurrentCamera.HeadScale
	for v1, v2 in arg1.gamepadZoomLevels do
		arg1.gamepadZoomLevels[v1] = v2 * v_headscale / arg1.headScale
	end
	arg1:SetCameraToSubjectDistance(arg1:GetCameraToSubjectDistance() * v_headscale / arg1.headScale)
	arg1.headScale = v_headscale
end
function v_u7.GetVRFocus(arg1, arg2, arg3)
	local v_min = math.min(1, arg1.cameraTranslationConstraints.y + arg3)
	arg1.cameraTranslationConstraints = Vector3.new(arg1.cameraTranslationConstraints.x, v_min, arg1.cameraTranslationConstraints.z)
	local v_getcameraheight = arg1:GetCameraHeight()
	local v_new = Vector3.new(0, v_getcameraheight, 0)
	return CFrame.new(Vector3.new(arg2.x, (arg1.lastCameraFocus or arg2).y, arg2.z):Lerp(arg2 + v_new, arg1.cameraTranslationConstraints.y))
end
function v_u7.StartFadeFromBlack(arg1)
	-- upvalues: (copy) v_u_usergamesettings, (copy) v_u_lighting
	if v_u_usergamesettings.VignetteEnabled ~= false then
		local v_vrfade = v_u_lighting:FindFirstChild("VRFade")
		if not v_vrfade then
			v_vrfade = Instance.new("ColorCorrectionEffect")
			v_vrfade.Name = "VRFade"
			v_vrfade.Parent = v_u_lighting
		end
		v_vrfade.Brightness = -1
		arg1.VRFadeResetTimer = 0.1
	end
end
function v_u7.UpdateFadeFromBlack(arg1, arg2)
	-- upvalues: (copy) v_u_lighting
	local v_vrfade = v_u_lighting:FindFirstChild("VRFade")
	if arg1.VRFadeResetTimer > 0 then
		arg1.VRFadeResetTimer = math.max(arg1.VRFadeResetTimer - arg2, 0)
		local v_vrfade = v_u_lighting:FindFirstChild("VRFade")
		if v_vrfade and v_vrfade.Brightness < 0 then
			v_vrfade.Brightness = math.min(v_vrfade.Brightness + arg2 * 10, 0)
			return
		end
	elseif v_vrfade then
		v_vrfade.Brightness = 0
	end
end
function v_u7.StartVREdgeBlur(arg1, arg2)
	-- upvalues: (copy) v_u_usergamesettings, (copy) v_u_run, (copy) v_u_vr
	if v_u_usergamesettings.VignetteEnabled ~= false then
		local v_vrblurpart = workspace.CurrentCamera:FindFirstChild("VRBlurPart")
		if not v_vrblurpart then
			local v_u_part = Instance.new("Part")
			v_u_part.Name = "VRBlurPart"
			v_u_part.Parent = workspace.CurrentCamera
			v_u_part.CanTouch = false
			v_u_part.CanCollide = false
			v_u_part.CanQuery = false
			v_u_part.Anchored = true
			v_u_part.Size = Vector3.new(0.44, 0.47, 1)
			v_u_part.Transparency = 1
			v_u_part.CastShadow = false
			v_u_run.RenderStepped:Connect(function(_)
				-- upvalues: (ref) v_u_vr, (ref) v_u_part
				local v_getusercframe = v_u_vr:GetUserCFrame(Enum.UserCFrame.Head)
				local v1 = workspace.CurrentCamera.CFrame * (CFrame.new(v_getusercframe.p * workspace.CurrentCamera.HeadScale) * (v_getusercframe - v_getusercframe.p))
				v_u_part.CFrame = v1 * CFrame.Angles(0, 3.141592653589793, 0) + v1.LookVector * (1.05 * workspace.CurrentCamera.HeadScale)
				v_u_part.Size = Vector3.new(0.44, 0.47, 1) * workspace.CurrentCamera.HeadScale
			end)
			v_vrblurpart = v_u_part
		end
		local v_vrblurscreen = arg2.PlayerGui:FindFirstChild("VRBlurScreen")
		local v1
		if v_vrblurscreen then
			v1 = v_vrblurscreen:FindFirstChild("VRBlur")
		else
			v1 = nil
		end
		if not v1 then
			local v2 = v_vrblurscreen or (Instance.new("SurfaceGui") or Instance.new("ScreenGui"))
			v2.Name = "VRBlurScreen"
			v2.Parent = arg2.PlayerGui
			v2.Adornee = v_vrblurpart
			v1 = Instance.new("ImageLabel")
			v1.Name = "VRBlur"
			v1.Parent = v2
			v1.Image = "rbxasset://textures/ui/VR/edgeBlur.png"
			v1.AnchorPoint = Vector2.new(0.5, 0.5)
			v1.Position = UDim2.new(0.5, 0, 0.5, 0)
			v1.Size = UDim2.fromScale(workspace.CurrentCamera.ViewportSize.X * 2.3 / 512, workspace.CurrentCamera.ViewportSize.Y * 2.3 / 512)
			v1.BackgroundTransparency = 1
			v1.Active = true
			v1.ScaleType = Enum.ScaleType.Stretch
		end
		v1.Visible = true
		v1.ImageTransparency = 0
		arg1.VREdgeBlurTimer = 0.14
	end
end
function v_u7.UpdateEdgeBlur(arg1, arg2, arg3)
	local v_vrblurscreen = arg2.PlayerGui:FindFirstChild("VRBlurScreen")
	local v1
	if v_vrblurscreen then
		v1 = v_vrblurscreen:FindFirstChild("VRBlur")
	else
		v1 = nil
	end
	if v1 then
		if arg1.VREdgeBlurTimer > 0 then
			arg1.VREdgeBlurTimer = arg1.VREdgeBlurTimer - arg3
			local v_vrblurscreen = arg2.PlayerGui:FindFirstChild("VRBlurScreen")
			local v2 = v_vrblurscreen and v_vrblurscreen:FindFirstChild("VRBlur")
			if v2 then
				v2.ImageTransparency = 1 - math.clamp(arg1.VREdgeBlurTimer, 0.01, 0.14) * 7.142857142857142
				return
			end
		else
			v1.Visible = false
		end
	end
end
function v_u7.GetCameraHeight(arg1)
	return arg1.inFirstPerson and 0 or 0.25881904510252074 * arg1.currentSubjectDistance
end
function v_u7.GetSubjectCFrame(arg1)
	-- upvalues: (copy) v_u6
	local v_getsubjectcframe = v_u6.GetSubjectCFrame(arg1)
	local v_current_camera = workspace.CurrentCamera
	if v_current_camera then
		v_current_camera = v_current_camera.CameraSubject
	end
	if not v_current_camera then
		return v_getsubjectcframe
	end
	if v_current_camera:IsA("Humanoid") and (v_current_camera:GetState() == Enum.HumanoidStateType.Dead and v_current_camera == arg1.lastSubject) then
		v_getsubjectcframe = arg1.lastSubjectCFrame
	end
	if v_getsubjectcframe then
		arg1.lastSubjectCFrame = v_getsubjectcframe
	end
	return v_getsubjectcframe
end
function v_u7.GetSubjectPosition(arg1)
	-- upvalues: (copy) v_u6
	local v_getsubjectposition = v_u6.GetSubjectPosition(arg1)
	local v_current_camera = game.Workspace.CurrentCamera
	if v_current_camera then
		v_current_camera = v_current_camera.CameraSubject
	end
	if not v_current_camera then
		return nil
	end
	if v_current_camera:IsA("Humanoid") then
		if v_current_camera:GetState() == Enum.HumanoidStateType.Dead and v_current_camera == arg1.lastSubject then
			v_getsubjectposition = arg1.lastSubjectPosition
		end
	elseif v_current_camera:IsA("VehicleSeat") then
		v_getsubjectposition = v_current_camera.CFrame.p + v_current_camera.CFrame:vectorToWorldSpace(Vector3.new(0, 4, 0))
	end
	arg1.lastSubjectPosition = v_getsubjectposition
	return v_getsubjectposition
end
function v_u7.getRotation(arg1, arg2)
	-- upvalues: (copy) v_u4, (copy) v_u_usergamesettings, (copy) v_u_usercamerainputdt
	local v_getrotation = v_u4.getRotation(arg2)
	local v1 = 0
	if v_u_usergamesettings.VRSmoothRotationEnabled then
		if v_u_usercamerainputdt then
			return v_getrotation.X
		else
			return v_getrotation.X * 40 * arg2
		end
	else
		if math.abs(v_getrotation.X) > 0.03 then
			if arg1.stepRotateTimeout > 0 then
				arg1.stepRotateTimeout = arg1.stepRotateTimeout - arg2
			end
			if arg1.stepRotateTimeout <= 0 then
				arg1:StartFadeFromBlack()
				arg1.stepRotateTimeout = 0.25
				return (v_getrotation.X < 0 and -1 or 1) * 0.5235987755982988
			end
		elseif math.abs(v_getrotation.X) < 0.02 then
			arg1.stepRotateTimeout = 0
		end
		return v1
	end
end
return v_u7