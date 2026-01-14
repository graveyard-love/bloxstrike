-- Decompiled with Bunni.lol Decompiler

local v_players = game:GetService("Players")
local v_u_userinput = game:GetService("UserInputService")
local v_u_vr = game:GetService("VRService")
local v_u_usergamesettings = UserSettings():GetService("UserGameSettings")
local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u1 = require(v_commonutils:WaitForChild("ConnectionUtil"))
local v2 = require(v_commonutils:WaitForChild("FlagUtil"))
local v_u3 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u4 = require(script.Parent:WaitForChild("ZoomController"))
local v_u5 = require(script.Parent:WaitForChild("CameraToggleStateController"))
local v_u6 = require(script.Parent:WaitForChild("CameraInput"))
local v_u7 = require(script.Parent:WaitForChild("CameraUI"))
local v_u_localplayer = v_players.LocalPlayer
local v8, v9 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserFixGamepadMaxZoom")
end)
local v_u10 = v8 and v9
local v_u_getuserflag = v2.getUserFlag("UserFixCameraCameraCharacterUpdates")
Vector2.new(0, 0)
local v_u11 = {
	["CHARACTER_ADDED"] = "CHARACTER_ADDED",
	["CAMERA_MODE_CHANGED"] = "CAMERA_MODE_CHANGED",
	["CAMERA_MIN_DISTANCE_CHANGED"] = "CAMERA_MIN_DISTANCE_CHANGED",
	["CAMERA_MAX_DISTANCE_CHANGED"] = "CAMERA_MAX_DISTANCE_CHANGED"
}
local v_u12 = {}
v_u12.__index = v_u12
function v_u12.new()
	-- upvalues: (copy) v_u12, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u_getuserflag, (copy) v_u_usergamesettings
	local v1 = setmetatable({}, v_u12)
	v1._connections = v_u1.new()
	v1.gamepadZoomLevels = { 0, 10, 20 }
	v1.FIRST_PERSON_DISTANCE_THRESHOLD = 1
	v1.cameraType = nil
	v1.cameraMovementMode = nil
	v1.lastCameraTransform = nil
	v1.lastUserPanCamera = tick()
	v1.humanoidRootPart = nil
	v1.humanoidCache = {}
	v1.lastSubject = nil
	v1.lastSubjectPosition = Vector3.new(0, 5, 0)
	v1.lastSubjectCFrame = CFrame.new(v1.lastSubjectPosition)
	v1.currentSubjectDistance = math.clamp(12.5, v_u_localplayer.CameraMinZoomDistance, v_u_localplayer.CameraMaxZoomDistance)
	v1.inFirstPerson = false
	v1.inMouseLockedMode = false
	v1.portraitMode = false
	v1.isSmallTouchScreen = false
	v1.resetCameraAngle = true
	v1.enabled = false
	if not v_u_getuserflag then
		v1.PlayerGui = nil
	end
	v1.cameraChangedConn = nil
	v1.viewportSizeChangedConn = nil
	v1.shouldUseVRRotation = false
	v1.VRRotationIntensityAvailable = false
	v1.lastVRRotationIntensityCheckTime = 0
	v1.lastVRRotationTime = 0
	v1.vrRotateKeyCooldown = {}
	v1.cameraTranslationConstraints = Vector3.new(1, 1, 1)
	v1.humanoidJumpOrigin = nil
	v1.trackingHumanoid = nil
	v1.cameraFrozen = false
	v1.subjectStateChangedConn = nil
	v1.gamepadZoomPressConnection = nil
	v1.mouseLockOffset = Vector3.new(0, 0, 0)
	v_u_usergamesettings:SetCameraYInvertVisible()
	v_u_usergamesettings:SetGamepadCameraSensitivityVisible()
	return v1
end
function v_u12.GetModuleName(_)
	return "BaseCamera"
end
function v_u12._setUpConfigurations(self)
	-- upvalues: (copy) v_u11, (copy) v_u_localplayer, (copy) v_u_getuserflag
	self._connections:trackConnection(v_u11.CHARACTER_ADDED, v_u_localplayer.CharacterAdded:Connect(function(arg1)
		-- upvalues: (copy) self
		self:OnCharacterAdded(arg1)
	end))
	if v_u_getuserflag then
		self.humanoidRootPart = nil
	elseif v_u_localplayer.Character then
		self:OnCharacterAdded(v_u_localplayer.Character)
	end
	self._connections:trackConnection(v_u11.CAMERA_MODE_CHANGED, v_u_localplayer:GetPropertyChangedSignal("CameraMode"):Connect(function()
		-- upvalues: (copy) self
		self:OnPlayerCameraPropertyChange()
	end))
	self._connections:trackConnection(v_u11.CAMERA_MIN_DISTANCE_CHANGED, v_u_localplayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function()
		-- upvalues: (copy) self
		self:OnPlayerCameraPropertyChange()
	end))
	self._connections:trackConnection(v_u11.CAMERA_MAX_DISTANCE_CHANGED, v_u_localplayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()
		-- upvalues: (copy) self
		self:OnPlayerCameraPropertyChange()
	end))
	self:OnPlayerCameraPropertyChange()
end
function v_u12.OnCharacterAdded(arg1, arg2)
	-- upvalues: (copy) v_u_getuserflag, (copy) v_u_userinput, (copy) v_u_localplayer
	arg1.resetCameraAngle = arg1.resetCameraAngle or arg1:GetEnabled()
	arg1.humanoidRootPart = nil
	if not v_u_getuserflag and v_u_userinput.TouchEnabled then
		arg1.PlayerGui = v_u_localplayer:WaitForChild("PlayerGui")
		for _, v1 in ipairs(arg2:GetChildren()) do
			if v1:IsA("Tool") then
				arg1.isAToolEquipped = true
			end
		end
		arg1._connections:trackConnection("char.ChildAdded", arg2.ChildAdded:Connect(function(arg1)
			-- upvalues: (copy) arg1
			if arg1:IsA("Tool") then
				arg1.isAToolEquipped = true
			end
		end))
		arg1._connections:trackConnection("char.ChildRemoved", arg2.ChildRemoved:Connect(function(arg1)
			-- upvalues: (copy) arg1
			if arg1:IsA("Tool") then
				arg1.isAToolEquipped = false
			end
		end))
	end
end
function v_u12.GetHumanoidRootPart(arg1)
	-- upvalues: (copy) v_u_localplayer
	local v1 = (not arg1.humanoidRootPart and v_u_localplayer.Character and true or false) and v_u_localplayer.Character:FindFirstChildOfClass("Humanoid")
	if v1 then
		arg1.humanoidRootPart = v1.RootPart
	end
	return arg1.humanoidRootPart
end
function v_u12.GetBodyPartToFollow(_, arg2, _)
	if arg2:GetState() == Enum.HumanoidStateType.Dead then
		local v_parent = arg2.Parent
		if v_parent and v_parent:IsA("Model") then
			return v_parent:FindFirstChild("Head") or arg2.RootPart
		end
	end
	return arg2.RootPart
end
function v_u12.GetSubjectCFrame(arg1)
	local v_lastsubjectcframe = arg1.lastSubjectCFrame
	local v_current_camera = workspace.CurrentCamera
	if v_current_camera then
		v_current_camera = v_current_camera.CameraSubject
	end
	if not v_current_camera then
		return v_lastsubjectcframe
	end
	if v_current_camera:IsA("Humanoid") then
		local v1 = v_current_camera:GetState() == Enum.HumanoidStateType.Dead
		local v_cameraoffset = v_current_camera.CameraOffset
		if arg1:GetIsMouseLocked() then
			v_cameraoffset = Vector3.new()
		end
		local v_rootpart = v_current_camera.RootPart
		if v1 and (v_current_camera.Parent and v_current_camera.Parent:IsA("Model")) then
			v_rootpart = v_current_camera.Parent:FindFirstChild("Head") or v_rootpart
		end
		if v_rootpart and v_rootpart:IsA("BasePart") then
			local v2
			if v_current_camera.RigType == Enum.HumanoidRigType.R15 then
				if v_current_camera.AutomaticScalingEnabled then
					v2 = Vector3.new(0, 1.5, 0)
					if v_rootpart == v_current_camera.RootPart then
						v2 = v2 + Vector3.new(0, (UNNAMED_1728996635320.Size.Y - (Vector3.new(2, 2, 1)).Y) / 2, 0)
					end
				else
					v2 = Vector3.new(0, 2, 0)
				end
			else
				v2 = Vector3.new(0, 1.5, 0)
			end
			v_lastsubjectcframe = v_rootpart.CFrame * CFrame.new((v1 and Vector3.new(0, 0, 0) or v2) + v_cameraoffset)
		end
	elseif v_current_camera:IsA("BasePart") then
		v_lastsubjectcframe = v_current_camera.CFrame
	elseif v_current_camera:IsA("Model") then
		if v_current_camera.PrimaryPart then
			v_lastsubjectcframe = v_current_camera:GetPrimaryPartCFrame()
		else
			v_lastsubjectcframe = CFrame.new()
		end
	end
	if v_lastsubjectcframe then
		arg1.lastSubjectCFrame = v_lastsubjectcframe
	end
	return v_lastsubjectcframe
end
function v_u12.GetSubjectVelocity(_)
	local v_current_camera = workspace.CurrentCamera
	if v_current_camera then
		v_current_camera = v_current_camera.CameraSubject
	end
	if not v_current_camera then
		return Vector3.new(0, 0, 0)
	end
	if v_current_camera:IsA("BasePart") then
		return v_current_camera.Velocity
	end
	if v_current_camera:IsA("Humanoid") then
		local v_rootpart = v_current_camera.RootPart
		if v_rootpart then
			return v_rootpart.Velocity
		end
	else
		local v1 = v_current_camera:IsA("Model") and v_current_camera.PrimaryPart
		if v1 then
			return v1.Velocity
		end
	end
	return Vector3.new(0, 0, 0)
end
function v_u12.GetSubjectRotVelocity(_)
	local v_current_camera = workspace.CurrentCamera
	if v_current_camera then
		v_current_camera = v_current_camera.CameraSubject
	end
	if not v_current_camera then
		return Vector3.new(0, 0, 0)
	end
	if v_current_camera:IsA("BasePart") then
		return v_current_camera.RotVelocity
	end
	if v_current_camera:IsA("Humanoid") then
		local v_rootpart = v_current_camera.RootPart
		if v_rootpart then
			return v_rootpart.RotVelocity
		end
	else
		local v1 = v_current_camera:IsA("Model") and v_current_camera.PrimaryPart
		if v1 then
			return v1.RotVelocity
		end
	end
	return Vector3.new(0, 0, 0)
end
function v_u12.StepZoom(arg1)
	-- upvalues: (copy) v_u6, (copy) v_u4
	local v_currentsubjectdistance = arg1.currentSubjectDistance
	local v_getzoomdelta = v_u6.getZoomDelta()
	if math.abs(v_getzoomdelta) > 0 then
		local v1
		if v_getzoomdelta > 0 then
			v1 = math.max(v_currentsubjectdistance + v_getzoomdelta * (v_currentsubjectdistance * 0.5 + 1), arg1.FIRST_PERSON_DISTANCE_THRESHOLD)
		else
			v1 = math.max((v_currentsubjectdistance + v_getzoomdelta) / (1 - v_getzoomdelta * 0.5), 0.5)
		end
		arg1:SetCameraToSubjectDistance(v1 < arg1.FIRST_PERSON_DISTANCE_THRESHOLD and 0.5 or v1)
	end
	return v_u4.GetZoomRadius()
end
function v_u12.GetSubjectPosition(arg1)
	local v_lastsubjectposition = arg1.lastSubjectPosition
	local v_current_camera = game.Workspace.CurrentCamera
	if v_current_camera then
		v_current_camera = v_current_camera.CameraSubject
	end
	if not v_current_camera then
		return nil
	end
	if v_current_camera:IsA("Humanoid") then
		local v1 = v_current_camera:GetState() == Enum.HumanoidStateType.Dead
		local v_cameraoffset = v_current_camera.CameraOffset
		if arg1:GetIsMouseLocked() then
			v_cameraoffset = Vector3.new()
		end
		local v_rootpart = v_current_camera.RootPart
		if v1 and (v_current_camera.Parent and v_current_camera.Parent:IsA("Model")) then
			v_rootpart = v_current_camera.Parent:FindFirstChild("Head") or v_rootpart
		end
		if v_rootpart and v_rootpart:IsA("BasePart") then
			local v2
			if v_current_camera.RigType == Enum.HumanoidRigType.R15 then
				if v_current_camera.AutomaticScalingEnabled then
					v2 = Vector3.new(0, 1.5, 0)
					if v_rootpart == v_current_camera.RootPart then
						v2 = v2 + Vector3.new(0, v_current_camera.RootPart.Size.Y / 2 - (Vector3.new(2, 2, 1)).Y / 2, 0)
					end
				else
					v2 = Vector3.new(0, 2, 0)
				end
			else
				v2 = Vector3.new(0, 1.5, 0)
			end
			v_lastsubjectposition = v_rootpart.CFrame.p + v_rootpart.CFrame:vectorToWorldSpace((v1 and Vector3.new(0, 0, 0) or v2) + v_cameraoffset)
		end
	elseif v_current_camera:IsA("VehicleSeat") then
		v_lastsubjectposition = v_current_camera.CFrame.p + v_current_camera.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0))
	elseif v_current_camera:IsA("SkateboardPlatform") then
		v_lastsubjectposition = v_current_camera.CFrame.p + Vector3.new(0, 5, 0)
	elseif v_current_camera:IsA("BasePart") then
		v_lastsubjectposition = v_current_camera.CFrame.p
	elseif v_current_camera:IsA("Model") then
		if v_current_camera.PrimaryPart then
			v_lastsubjectposition = v_current_camera:GetPrimaryPartCFrame().p
		else
			v_lastsubjectposition = v_current_camera:GetModelCFrame().p
		end
	end
	arg1.lastSubject = v_current_camera
	arg1.lastSubjectPosition = v_lastsubjectposition
	return v_lastsubjectposition
end
function v_u12.OnViewportSizeChanged(arg1)
	-- upvalues: (copy) v_u_userinput
	local v_viewportsize = game.Workspace.CurrentCamera.ViewportSize
	arg1.portraitMode = v_viewportsize.X < v_viewportsize.Y
	local v_touchenabled = v_u_userinput.TouchEnabled
	if v_touchenabled then
		v_touchenabled = v_viewportsize.Y < 500 and true or v_viewportsize.X < 700
	end
	arg1.isSmallTouchScreen = v_touchenabled
end
function v_u12.OnCurrentCameraChanged(self)
	-- upvalues: (copy) v_u_userinput
	if v_u_userinput.TouchEnabled then
		if self.viewportSizeChangedConn then
			self.viewportSizeChangedConn:Disconnect()
			self.viewportSizeChangedConn = nil
		end
		local v_current_camera = game.Workspace.CurrentCamera
		if v_current_camera then
			self:OnViewportSizeChanged()
			self.viewportSizeChangedConn = v_current_camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				-- upvalues: (copy) self
				self:OnViewportSizeChanged()
			end)
		end
	end
	if self.cameraSubjectChangedConn then
		self.cameraSubjectChangedConn:Disconnect()
		self.cameraSubjectChangedConn = nil
	end
	local v_current_camera = game.Workspace.CurrentCamera
	if v_current_camera then
		self.cameraSubjectChangedConn = v_current_camera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
			-- upvalues: (copy) self
			self:OnNewCameraSubject()
		end)
		self:OnNewCameraSubject()
	end
end
function v_u12.OnPlayerCameraPropertyChange(arg1)
	arg1:SetCameraToSubjectDistance(arg1.currentSubjectDistance)
end
function v_u12.InputTranslationToCameraAngleChange(_, arg2, arg3)
	return arg2 * arg3
end
function v_u12.GamepadZoomPress(arg1)
	-- upvalues: (copy) v_u_localplayer, (ref) v_u10
	local v_getcameratosubjectdistance = arg1:GetCameraToSubjectDistance()
	local v_cameramaxzoomdistance = v_u_localplayer.CameraMaxZoomDistance
	for v1 = #arg1.gamepadZoomLevels, 1, -1 do
		local v2 = arg1.gamepadZoomLevels[v1]
		if v_cameramaxzoomdistance >= v2 then
			if v2 < v_u_localplayer.CameraMinZoomDistance then
				v2 = v_u_localplayer.CameraMinZoomDistance
				if v_u10 and v_cameramaxzoomdistance == v2 then
					break
				end
			end
			if not v_u10 and v_cameramaxzoomdistance == v2 then
				break
			end
			if v2 + (v_cameramaxzoomdistance - v2) / 2 < v_getcameratosubjectdistance then
				arg1:SetCameraToSubjectDistance(v2)
				return
			end
			v_cameramaxzoomdistance = v2
		end
	end
	arg1:SetCameraToSubjectDistance(arg1.gamepadZoomLevels[#arg1.gamepadZoomLevels])
end
function v_u12.Enable(arg1, arg2)
	if arg1.enabled ~= arg2 then
		arg1.enabled = arg2
		arg1:OnEnabledChanged()
	end
end
function v_u12.OnEnabledChanged(self)
	-- upvalues: (copy) v_u6, (copy) v_u_localplayer
	if self.enabled then
		self:_setUpConfigurations()
		v_u6.setInputEnabled(true)
		self.gamepadZoomPressConnection = v_u6.gamepadZoomPress:Connect(function()
			-- upvalues: (copy) self
			self:GamepadZoomPress()
		end)
		if v_u_localplayer.CameraMode == Enum.CameraMode.LockFirstPerson then
			self.currentSubjectDistance = 0.5
			if not self.inFirstPerson then
				self:EnterFirstPerson()
			end
		end
		if self.cameraChangedConn then
			self.cameraChangedConn:Disconnect()
			self.cameraChangedConn = nil
		end
		self.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
			-- upvalues: (copy) self
			self:OnCurrentCameraChanged()
		end)
		self:OnCurrentCameraChanged()
	else
		self._connections:disconnectAll()
		v_u6.setInputEnabled(false)
		if self.gamepadZoomPressConnection then
			self.gamepadZoomPressConnection:Disconnect()
			self.gamepadZoomPressConnection = nil
		end
		self:Cleanup()
	end
end
function v_u12.GetEnabled(arg1)
	return arg1.enabled
end
function v_u12.Cleanup(arg1)
	-- upvalues: (copy) v_u3
	if arg1.subjectStateChangedConn then
		arg1.subjectStateChangedConn:Disconnect()
		arg1.subjectStateChangedConn = nil
	end
	if arg1.viewportSizeChangedConn then
		arg1.viewportSizeChangedConn:Disconnect()
		arg1.viewportSizeChangedConn = nil
	end
	if arg1.cameraChangedConn then
		arg1.cameraChangedConn:Disconnect()
		arg1.cameraChangedConn = nil
	end
	arg1.lastCameraTransform = nil
	arg1.lastSubjectCFrame = nil
	v_u3.restoreMouseBehavior()
end
function v_u12.UpdateMouseBehavior(arg1)
	-- upvalues: (copy) v_u_usergamesettings, (copy) v_u7, (copy) v_u6, (copy) v_u5, (copy) v_u3
	if arg1.isCameraToggle and v_u_usergamesettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove == false then
		v_u7.setCameraModeToastEnabled(true)
		v_u6.enableCameraToggleInput()
		v_u5(arg1.inFirstPerson)
		return
	else
		v_u7.setCameraModeToastEnabled(false)
		v_u6.disableCameraToggleInput()
		if arg1.inFirstPerson or arg1.inMouseLockedMode then
			v_u3.setRotationTypeOverride(Enum.RotationType.CameraRelative)
			v_u3.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
			return
		else
			v_u3.restoreRotationType()
			if v_u6.getRotationActivated() then
				v_u3.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
			else
				v_u3.restoreMouseBehavior()
			end
		end
	end
end
function v_u12.UpdateForDistancePropertyChange(arg1)
	arg1:SetCameraToSubjectDistance(arg1.currentSubjectDistance)
end
function v_u12.SetCameraToSubjectDistance(arg1, arg2)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u4
	local v_currentsubjectdistance = arg1.currentSubjectDistance
	if v_u_localplayer.CameraMode == Enum.CameraMode.LockFirstPerson then
		arg1.currentSubjectDistance = 0.5
		if not arg1.inFirstPerson then
			arg1:EnterFirstPerson()
		end
	else
		local v_clamp = math.clamp(arg2, v_u_localplayer.CameraMinZoomDistance, v_u_localplayer.CameraMaxZoomDistance)
		if v_clamp < 1 then
			arg1.currentSubjectDistance = 0.5
			if not arg1.inFirstPerson then
				arg1:EnterFirstPerson()
			end
		else
			arg1.currentSubjectDistance = v_clamp
			if arg1.inFirstPerson then
				arg1:LeaveFirstPerson()
			end
		end
	end
	v_u4.SetZoomParameters(arg1.currentSubjectDistance, (math.sign(arg2 - v_currentsubjectdistance)))
	return arg1.currentSubjectDistance
end
function v_u12.SetCameraType(arg1, arg2)
	arg1.cameraType = arg2
end
function v_u12.GetCameraType(arg1)
	return arg1.cameraType
end
function v_u12.SetCameraMovementMode(arg1, arg2)
	arg1.cameraMovementMode = arg2
end
function v_u12.GetCameraMovementMode(arg1)
	return arg1.cameraMovementMode
end
function v_u12.SetIsMouseLocked(arg1, arg2)
	arg1.inMouseLockedMode = arg2
end
function v_u12.GetIsMouseLocked(arg1)
	return arg1.inMouseLockedMode
end
function v_u12.SetMouseLockOffset(arg1, arg2)
	arg1.mouseLockOffset = arg2
end
function v_u12.GetMouseLockOffset(arg1)
	return arg1.mouseLockOffset
end
function v_u12.InFirstPerson(arg1)
	return arg1.inFirstPerson
end
function v_u12.EnterFirstPerson(arg1)
	arg1.inFirstPerson = true
	arg1:UpdateMouseBehavior()
end
function v_u12.LeaveFirstPerson(arg1)
	arg1.inFirstPerson = false
	arg1:UpdateMouseBehavior()
end
function v_u12.GetCameraToSubjectDistance(arg1)
	return arg1.currentSubjectDistance
end
function v_u12.GetMeasuredDistanceToFocus(_)
	local v_current_camera = game.Workspace.CurrentCamera
	if v_current_camera then
		return (v_current_camera.CoordinateFrame.p - v_current_camera.Focus.p).magnitude
	else
		return nil
	end
end
function v_u12.GetCameraLookVector(_)
	return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1)
end
function v_u12.CalculateNewLookCFrameFromArg(arg1, arg2, arg3)
	local v1 = arg2 or arg1:GetCameraLookVector()
	local v_asin = math.asin(v1.Y)
	local v_clamp = math.clamp(arg3.Y, v_asin + -1.3962634015954636, v_asin + 1.3962634015954636)
	local v_new = Vector2.new(arg3.X, v_clamp)
	local v_new = CFrame.new(Vector3.new(0, 0, 0), v1)
	return CFrame.Angles(0, -v_new.X, 0) * v_new * CFrame.Angles(-v_new.Y, 0, 0)
end
function v_u12.CalculateNewLookVectorFromArg(arg1, arg2, arg3)
	return arg1:CalculateNewLookCFrameFromArg(arg2, arg3).LookVector
end
function v_u12.CalculateNewLookVectorVRFromArg(arg1, arg2)
	local v_new = Vector2.new(arg2.X, 0)
	local v_new = CFrame.new(Vector3.new(0, 0, 0), ((arg1:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit)
	return ((CFrame.Angles(0, -v_new.X, 0) * v_new * CFrame.Angles(-v_new.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit
end
function v_u12.GetHumanoid(arg1)
	-- upvalues: (copy) v_u_localplayer
	local v1 = v_u_localplayer
	if v1 then
		v1 = v_u_localplayer.Character
	end
	if not v1 then
		return nil
	end
	local v2 = arg1.humanoidCache[v_u_localplayer]
	if v2 and v2.Parent == v1 then
		return v2
	end
	arg1.humanoidCache[v_u_localplayer] = nil
	local v_humanoid = v1:FindFirstChildOfClass("Humanoid")
	if v_humanoid then
		arg1.humanoidCache[v_u_localplayer] = v_humanoid
	end
	return v_humanoid
end
function v_u12.GetHumanoidPartToFollow(_, arg2, arg3)
	if arg3 == Enum.HumanoidStateType.Dead then
		local v_parent = arg2.Parent
		if v_parent then
			return v_parent:FindFirstChild("Head") or arg2.Torso
		else
			return arg2.Torso
		end
	else
		return arg2.Torso
	end
end
function v_u12.OnNewCameraSubject(arg1)
	if arg1.subjectStateChangedConn then
		arg1.subjectStateChangedConn:Disconnect()
		arg1.subjectStateChangedConn = nil
	end
end
function v_u12.IsInFirstPerson(arg1)
	return arg1.inFirstPerson
end
function v_u12.Update(_, _)
	error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2)
end
function v_u12.GetCameraHeight(arg1)
	-- upvalues: (copy) v_u_vr
	return (not v_u_vr.VREnabled or arg1.inFirstPerson) and 0 or 0.25881904510252074 * arg1.currentSubjectDistance
end
return v_u12