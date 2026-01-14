-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_u2 = {
	"CameraMinZoomDistance",
	"CameraMaxZoomDistance",
	"CameraMode",
	"DevCameraOcclusionMode",
	"DevComputerCameraMode",
	"DevTouchCameraMode",
	"DevComputerMovementMode",
	"DevTouchMovementMode",
	"DevEnableMouseLock"
}
local v_u3 = {
	"ComputerCameraMovementMode",
	"ComputerMovementMode",
	"ControlMode",
	"GamepadCameraSensitivity",
	"MouseSensitivity",
	"RotationType",
	"TouchCameraMovementMode",
	"TouchMovementMode"
}
local v_u_players = game:GetService("Players")
local v_u_run = game:GetService("RunService")
local v_u_userinput = game:GetService("UserInputService")
local v_u_vr = game:GetService("VRService")
local v_u_usergamesettings = UserSettings():GetService("UserGameSettings")
local v_commonutils = script.Parent:WaitForChild("CommonUtils")
local v_u4 = require(v_commonutils:WaitForChild("ConnectionUtil"))
local v5 = require(v_commonutils:WaitForChild("FlagUtil"))
local v_u6 = require(script:WaitForChild("CameraUtils"))
local v_u7 = require(script:WaitForChild("CameraInput"))
local v_u8 = require(script:WaitForChild("ClassicCamera"))
local v_u9 = require(script:WaitForChild("OrbitalCamera"))
local v_u10 = require(script:WaitForChild("LegacyCamera"))
local v_u11 = require(script:WaitForChild("VehicleCamera"))
local v_u12 = require(script:WaitForChild("VRCamera"))
local v_u13 = require(script:WaitForChild("VRVehicleCamera"))
local v_u14 = require(script:WaitForChild("Invisicam"))
local v_u15 = require(script:WaitForChild("Poppercam"))
local v_u16 = require(script:WaitForChild("TransparencyController"))
local v_u17 = require(script:WaitForChild("MouseLockController"))
local v_u18 = {}
local v_u19 = {}
if not v_u_players.LocalPlayer then
	return {}
end
assert(v_u_players.LocalPlayer, "Strict typing check")
local v_playerscripts = v_u_players.LocalPlayer:WaitForChild("PlayerScripts")
v_playerscripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default)
v_playerscripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow)
v_playerscripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic)
v_playerscripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default)
v_playerscripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow)
v_playerscripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic)
v_playerscripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle)
local v_u_getuserflag = v5.getUserFlag("UserRespectLegacyCameraOptions")
v5.getUserFlag("UserPlayerConnectionMemoryLeak")
function v_u1.new()
	-- upvalues: (copy) v_u16, (copy) v_u4, (copy) v_u1, (copy) v_u_players, (copy) v_u_userinput, (copy) v_u17, (copy) v_u_getuserflag, (copy) v_u_run, (copy) v_u2, (copy) v_u3, (copy) v_u_usergamesettings
	local v_u1 = setmetatable({
		["activeTransparencyController"] = v_u16.new(),
		["connectionUtil"] = v_u4.new()
	}, v_u1)
	v_u1.activeCameraController = nil
	v_u1.activeOcclusionModule = nil
	v_u1.activeMouseLockController = nil
	v_u1.currentComputerCameraMovementMode = nil
	v_u1.cameraSubjectChangedConn = nil
	v_u1.cameraTypeChangedConn = nil
	v_u1.renderStepName = "cameraRenderUpdate"
	for _, v2 in pairs(v_u_players:GetPlayers()) do
		v_u1:OnPlayerAdded(v2)
	end
	v_u1.connectionUtil:trackConnection("Players.PlayerAdded", v_u_players.PlayerAdded:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		v_u1:OnPlayerAdded(arg1)
	end))
	v_u1.connectionUtil:trackConnection("Players.PlayerRemoving", v_u_players.PlayerRemoving:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		v_u1:OnPlayerRemoving(arg1)
	end))
	v_u1.activeTransparencyController:Enable(true)
	if not v_u_userinput.TouchEnabled then
		v_u1.activeMouseLockController = v_u17.new()
		assert(v_u1.activeMouseLockController, "Strict typing check")
		local v_getbindabletoggleevent = v_u1.activeMouseLockController:GetBindableToggleEvent()
		if v_getbindabletoggleevent then
			v_u1.connectionUtil:trackConnection("MouseLockToggleEvent", v_getbindabletoggleevent:Connect(function()
				-- upvalues: (copy) v_u1
				v_u1:OnMouseLockToggled()
			end))
		end
	end
	if v_u_getuserflag then
		v_u1:ActivateCameraController()
	else
		v_u1:ActivateCameraController(v_u1:GetCameraControlChoice())
	end
	v_u1:ActivateOcclusionModule(v_u_players.LocalPlayer.DevCameraOcclusionMode)
	v_u1:OnCurrentCameraChanged()
	v_u_run:BindToRenderStep(v_u1.renderStepName, Enum.RenderPriority.Camera.Value, function(arg1)
		-- upvalues: (copy) v_u1
		v_u1:Update(arg1)
	end)
	for _, v_u3 in pairs(v_u2) do
		v_u1.connectionUtil:trackConnection(("LocalPlayer.%*"):format(v_u3), v_u_players.LocalPlayer:GetPropertyChangedSignal(v_u3):Connect(function()
			-- upvalues: (copy) v_u1, (copy) v_u3
			v_u1:OnLocalPlayerCameraPropertyChanged(v_u3)
		end))
	end
	for _, v_u4 in pairs(v_u3) do
		v_u1.connectionUtil:trackConnection(("UserGameSettings.%*"):format(v_u4), v_u_usergamesettings:GetPropertyChangedSignal(v_u4):Connect(function()
			-- upvalues: (copy) v_u1, (copy) v_u4
			v_u1:OnUserGameSettingsPropertyChanged(v_u4)
		end))
	end
	v_u1.connectionUtil:trackConnection("Workspace.CurrentCamera", game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:OnCurrentCameraChanged()
	end))
	return v_u1
end
function v_u1.GetCameraMovementModeFromSettings(_)
	-- upvalues: (copy) v_u_players, (copy) v_u6, (copy) v_u_userinput, (copy) v_u_usergamesettings
	if v_u_players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
		return v_u6.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic)
	else
		local v1, v2
		if v_u_userinput.TouchEnabled then
			v1 = v_u6.ConvertCameraModeEnumToStandard(v_u_players.LocalPlayer.DevTouchCameraMode)
			v2 = v_u6.ConvertCameraModeEnumToStandard(v_u_usergamesettings.TouchCameraMovementMode)
		else
			v1 = v_u6.ConvertCameraModeEnumToStandard(v_u_players.LocalPlayer.DevComputerCameraMode)
			v2 = v_u6.ConvertCameraModeEnumToStandard(v_u_usergamesettings.ComputerCameraMovementMode)
		end
		if v1 == Enum.DevComputerCameraMovementMode.UserChoice then
			return v2
		else
			return v1
		end
	end
end
function v_u1.ActivateOcclusionModule(arg1, arg2)
	-- upvalues: (copy) v_u15, (copy) v_u14, (copy) v_u19, (copy) v_u_players
	local v1
	if arg2 == Enum.DevCameraOcclusionMode.Zoom then
		v1 = v_u15
	else
		if arg2 ~= Enum.DevCameraOcclusionMode.Invisicam then
			warn("CameraScript ActivateOcclusionModule called with unsupported mode")
			return
		end
		v1 = v_u14
	end
	arg1.occlusionMode = arg2
	if arg1.activeOcclusionModule and arg1.activeOcclusionModule:GetOcclusionMode() == arg2 then
		if not arg1.activeOcclusionModule:GetEnabled() then
			arg1.activeOcclusionModule:Enable(true)
		end
	else
		local v_activeocclusionmodule = arg1.activeOcclusionModule
		arg1.activeOcclusionModule = v_u19[v1]
		if not arg1.activeOcclusionModule then
			arg1.activeOcclusionModule = v1.new()
			if arg1.activeOcclusionModule then
				v_u19[v1] = arg1.activeOcclusionModule
			end
		end
		if arg1.activeOcclusionModule then
			if arg1.activeOcclusionModule:GetOcclusionMode() ~= arg2 then
				warn("CameraScript ActivateOcclusionModule mismatch: ", arg1.activeOcclusionModule:GetOcclusionMode(), "~=", arg2)
			end
			if v_activeocclusionmodule then
				if v_activeocclusionmodule == arg1.activeOcclusionModule then
					warn("CameraScript ActivateOcclusionModule failure to detect already running correct module")
				else
					v_activeocclusionmodule:Enable(false)
				end
			end
			if arg2 == Enum.DevCameraOcclusionMode.Invisicam then
				if v_u_players.LocalPlayer.Character then
					arg1.activeOcclusionModule:CharacterAdded(v_u_players.LocalPlayer.Character, v_u_players.LocalPlayer)
				end
			else
				for _, v2 in pairs(v_u_players:GetPlayers()) do
					if v2 and v2.Character then
						arg1.activeOcclusionModule:CharacterAdded(v2.Character, v2)
					end
				end
				arg1.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject)
			end
			arg1.activeOcclusionModule:Enable(true)
		end
	end
end
function v_u1.ShouldUseVehicleCamera(arg1)
	local v_current_camera = workspace.CurrentCamera
	if not v_current_camera then
		return false
	end
	local v_cameratype = v_current_camera.CameraType
	local v_camerasubject = v_current_camera.CameraSubject
	local v1 = v_cameratype == Enum.CameraType.Custom and true or v_cameratype == Enum.CameraType.Follow
	local v2 = v_camerasubject and v_camerasubject:IsA("VehicleSeat") or false
	local v3 = arg1.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam
	if v2 then
		if not v1 then
			v3 = v1
		end
	else
		v3 = v2
	end
	return v3
end
function v_u1.ActivateCameraController(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_getuserflag, (copy) v_u10, (copy) v_u_vr, (copy) v_u12, (copy) v_u8, (copy) v_u9, (copy) v_u13, (copy) v_u11, (copy) v_u18
	if v_u_getuserflag then
		arg3 = workspace.CurrentCamera.CameraType
		arg2 = arg1:GetCameraMovementModeFromSettings()
	end
	local v1 = nil
	if v_u_getuserflag and true or arg3 ~= nil then
		if arg3 == Enum.CameraType.Scriptable then
			if arg1.activeCameraController then
				arg1.activeCameraController:Enable(false)
				arg1.activeCameraController = nil
			end
			return
		end
		if arg3 == Enum.CameraType.Custom then
			arg2 = arg1:GetCameraMovementModeFromSettings()
		elseif arg3 == Enum.CameraType.Track then
			arg2 = Enum.ComputerCameraMovementMode.Classic
		elseif arg3 == Enum.CameraType.Follow then
			arg2 = Enum.ComputerCameraMovementMode.Follow
		elseif arg3 == Enum.CameraType.Orbital then
			arg2 = Enum.ComputerCameraMovementMode.Orbital
		elseif arg3 == Enum.CameraType.Attach or (arg3 == Enum.CameraType.Watch or arg3 == Enum.CameraType.Fixed) then
			v1 = v_u10
		else
			warn("CameraScript encountered an unhandled Camera.CameraType value: ", arg3)
		end
	end
	if not v1 then
		if v_u_vr.VREnabled then
			v1 = v_u12
		elseif arg2 == Enum.ComputerCameraMovementMode.Classic or (arg2 == Enum.ComputerCameraMovementMode.Follow or (arg2 == Enum.ComputerCameraMovementMode.Default or arg2 == Enum.ComputerCameraMovementMode.CameraToggle)) then
			v1 = v_u8
		else
			if arg2 ~= Enum.ComputerCameraMovementMode.Orbital then
				warn("ActivateCameraController did not select a module.")
				return
			end
			v1 = v_u9
		end
	end
	if arg1:ShouldUseVehicleCamera() then
		if v_u_vr.VREnabled then
			v1 = v_u13
		else
			v1 = v_u11
		end
	end
	local v2
	if v_u18[v1] then
		v2 = v_u18[v1]
		if v2.Reset then
			v2:Reset()
		end
	else
		v2 = v1.new()
		v_u18[v1] = v2
	end
	if arg1.activeCameraController then
		if arg1.activeCameraController == v2 then
			if not arg1.activeCameraController:GetEnabled() then
				arg1.activeCameraController:Enable(true)
			end
		else
			arg1.activeCameraController:Enable(false)
			arg1.activeCameraController = v2
			arg1.activeCameraController:Enable(true)
		end
	elseif v2 ~= nil then
		arg1.activeCameraController = v2
		assert(arg1.activeCameraController, "Strict typing check")
		arg1.activeCameraController:Enable(true)
	end
	if arg1.activeCameraController then
		if v_u_getuserflag then
			arg1.activeCameraController:SetCameraMovementMode(arg2)
			arg1.activeCameraController:SetCameraType(arg3)
			return
		end
		if arg2 ~= nil then
			arg1.activeCameraController:SetCameraMovementMode(arg2)
			return
		end
		if arg3 ~= nil then
			arg1.activeCameraController:SetCameraType(arg3)
		end
	end
end
function v_u1.OnCameraSubjectChanged(arg1)
	local v_current_camera = workspace.CurrentCamera
	local v1
	if v_current_camera then
		v1 = v_current_camera.CameraSubject
	else
		v1 = nil
	end
	if arg1.activeTransparencyController then
		arg1.activeTransparencyController:SetSubject(v1)
	end
	if arg1.activeOcclusionModule then
		arg1.activeOcclusionModule:OnCameraSubjectChanged(v1)
	end
	local v2 = nil
	local v3
	if v_current_camera then
		v3 = v_current_camera.CameraType
	else
		v3 = nil
	end
	arg1:ActivateCameraController(v2, v3)
end
function v_u1.OnCameraTypeChanged(arg1, arg2)
	-- upvalues: (copy) v_u_userinput, (copy) v_u6
	if arg2 == Enum.CameraType.Scriptable and v_u_userinput.MouseBehavior == Enum.MouseBehavior.LockCenter then
		v_u6.restoreMouseBehavior()
	end
	arg1:ActivateCameraController(nil, arg2)
end
function v_u1.OnCurrentCameraChanged(self)
	local v_u_current_camera = game.Workspace.CurrentCamera
	if v_u_current_camera then
		if self.cameraSubjectChangedConn then
			self.cameraSubjectChangedConn:Disconnect()
		end
		if self.cameraTypeChangedConn then
			self.cameraTypeChangedConn:Disconnect()
		end
		self.cameraSubjectChangedConn = v_u_current_camera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
			-- upvalues: (copy) self
			self:OnCameraSubjectChanged()
		end)
		self.cameraTypeChangedConn = v_u_current_camera:GetPropertyChangedSignal("CameraType"):Connect(function()
			-- upvalues: (copy) self, (copy) v_u_current_camera
			self:OnCameraTypeChanged(v_u_current_camera.CameraType)
		end)
		self:OnCameraSubjectChanged()
		self:OnCameraTypeChanged(v_u_current_camera.CameraType)
	end
end
function v_u1.OnLocalPlayerCameraPropertyChanged(arg1, arg2)
	-- upvalues: (copy) v_u_players, (copy) v_u6
	if arg2 == "CameraMode" then
		if v_u_players.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
			if v_u_players.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
				local v_getcameramovementmodefromsettings = arg1:GetCameraMovementModeFromSettings()
				arg1:ActivateCameraController(v_u6.ConvertCameraModeEnumToStandard(v_getcameramovementmodefromsettings))
			else
				warn("Unhandled value for property player.CameraMode: ", v_u_players.LocalPlayer.CameraMode)
			end
		end
		if not arg1.activeCameraController or arg1.activeCameraController:GetModuleName() ~= "ClassicCamera" then
			arg1:ActivateCameraController(v_u6.ConvertCameraModeEnumToStandard(Enum.DevComputerCameraMovementMode.Classic))
		end
		if arg1.activeCameraController then
			arg1.activeCameraController:UpdateForDistancePropertyChange()
			return
		end
	else
		if arg2 == "DevComputerCameraMode" or arg2 == "DevTouchCameraMode" then
			local v_getcameramovementmodefromsettings = arg1:GetCameraMovementModeFromSettings()
			arg1:ActivateCameraController(v_u6.ConvertCameraModeEnumToStandard(v_getcameramovementmodefromsettings))
			return
		end
		if arg2 == "DevCameraOcclusionMode" then
			arg1:ActivateOcclusionModule(v_u_players.LocalPlayer.DevCameraOcclusionMode)
			return
		end
		if arg2 == "CameraMinZoomDistance" or arg2 == "CameraMaxZoomDistance" then
			if arg1.activeCameraController then
				arg1.activeCameraController:UpdateForDistancePropertyChange()
				return
			end
		else
			if arg2 == "DevTouchMovementMode" then
				return
			end
			if arg2 == "DevComputerMovementMode" then
				return
			end
			local _ = arg2 == "DevEnableMouseLock"
		end
	end
end
function v_u1.OnUserGameSettingsPropertyChanged(arg1, arg2)
	-- upvalues: (copy) v_u6
	if arg2 == "ComputerCameraMovementMode" then
		local v_getcameramovementmodefromsettings = arg1:GetCameraMovementModeFromSettings()
		arg1:ActivateCameraController(v_u6.ConvertCameraModeEnumToStandard(v_getcameramovementmodefromsettings))
	end
end
function v_u1.Update(arg1, arg2)
	-- upvalues: (copy) v_u7
	if arg1.activeCameraController then
		arg1.activeCameraController:UpdateMouseBehavior()
		local v_update, v1 = arg1.activeCameraController:Update(arg2)
		if arg1.activeOcclusionModule then
			v_update, v1 = arg1.activeOcclusionModule:Update(arg2, v_update, v1)
		end
		local v_current_camera = game.Workspace.CurrentCamera
		v_current_camera.CFrame = v_update
		v_current_camera.Focus = v1
		if arg1.activeTransparencyController then
			arg1.activeTransparencyController:Update(arg2)
		end
		if v_u7.getInputEnabled() then
			v_u7.resetInputForFrameEnd()
		end
	end
end
function v_u1.GetCameraControlChoice(_)
	-- upvalues: (copy) v_u_getuserflag, (copy) v_u_userinput, (copy) v_u_players, (copy) v_u6, (copy) v_u_usergamesettings
	assert(not v_u_getuserflag, "CameraModule:GetCameraControlChoice should not be called when FFlagUserRespectLegacyCameraOptions is enabled")
	if v_u_userinput:GetLastInputType() == Enum.UserInputType.Touch or v_u_userinput.TouchEnabled then
		if v_u_players.LocalPlayer.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice then
			return v_u6.ConvertCameraModeEnumToStandard(v_u_usergamesettings.TouchCameraMovementMode)
		else
			return v_u6.ConvertCameraModeEnumToStandard(v_u_players.LocalPlayer.DevTouchCameraMode)
		end
	else
		if v_u_players.LocalPlayer.DevComputerCameraMode ~= Enum.DevComputerCameraMovementMode.UserChoice then
			return v_u6.ConvertCameraModeEnumToStandard(v_u_players.LocalPlayer.DevComputerCameraMode)
		end
		local v_convertcameramodeenumtostandard = v_u6.ConvertCameraModeEnumToStandard(v_u_usergamesettings.ComputerCameraMovementMode)
		return v_u6.ConvertCameraModeEnumToStandard(v_convertcameramodeenumtostandard)
	end
end
function v_u1.OnCharacterAdded(arg1, arg2, arg3)
	if arg1.activeOcclusionModule then
		arg1.activeOcclusionModule:CharacterAdded(arg2, arg3)
	end
end
function v_u1.OnCharacterRemoving(arg1, arg2, arg3)
	if arg1.activeOcclusionModule then
		arg1.activeOcclusionModule:CharacterRemoving(arg2, arg3)
	end
end
function v_u1.OnPlayerAdded(arg1, arg2)
	arg1.connectionUtil:trackConnection(("%*CharacterAdded"):format(arg2.UserId), arg2.CharacterAdded:Connect(function(arg1)
		-- upvalues: (copy) arg1, (copy) arg2
		arg1:OnCharacterAdded(arg1, arg2)
	end))
	arg1.connectionUtil:trackConnection(("%*CharacterRemoving"):format(arg2.UserId), arg2.CharacterRemoving:Connect(function(arg1)
		-- upvalues: (copy) arg1, (copy) arg2
		arg1:OnCharacterRemoving(arg1, arg2)
	end))
end
function v_u1.OnPlayerRemoving(arg1, arg2)
	arg1.connectionUtil:disconnect((("%*CharacterAdded"):format(arg2.UserId)))
	arg1.connectionUtil:disconnect((("%*CharacterRemoving"):format(arg2.UserId)))
end
function v_u1.OnMouseLockToggled(arg1)
	if arg1.activeMouseLockController then
		local v_getismouselocked = arg1.activeMouseLockController:GetIsMouseLocked()
		local v_getmouselockoffset = arg1.activeMouseLockController:GetMouseLockOffset()
		if arg1.activeCameraController then
			arg1.activeCameraController:SetIsMouseLocked(v_getismouselocked)
			arg1.activeCameraController:SetMouseLockOffset(v_getmouselockoffset)
		end
	end
end
v_u1.new()
return {}