-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_u_players = game:GetService("Players")
local v_u_run = game:GetService("RunService")
local v_u_userinput = game:GetService("UserInputService")
local v_u_gui = game:GetService("GuiService")
local v_u_workspace = game:GetService("Workspace")
local v_u_usergamesettings = UserSettings():GetService("UserGameSettings")
local v_u_vr = game:GetService("VRService")
script.Parent:WaitForChild("CommonUtils")
local v_u2 = require(script:WaitForChild("Keyboard"))
local v_u3 = require(script:WaitForChild("Gamepad"))
local v_u4 = require(script:WaitForChild("DynamicThumbstick"))
local v5, v6 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate")
end)
local v_u7 = v5 and v6
local v_u8 = require(script:WaitForChild("TouchThumbstick"))
local v_u9 = require(script:WaitForChild("ClickToMoveController"))
local v_u10 = require(script:WaitForChild("TouchJump"))
local v_u11 = require(script:WaitForChild("VehicleController"))
local v_u_value = Enum.ContextActionPriority.Medium.Value
local v_u12 = {
	[Enum.TouchMovementMode.DPad] = v_u4,
	[Enum.DevTouchMovementMode.DPad] = v_u4,
	[Enum.TouchMovementMode.Thumbpad] = v_u4,
	[Enum.DevTouchMovementMode.Thumbpad] = v_u4,
	[Enum.TouchMovementMode.Thumbstick] = v_u8,
	[Enum.DevTouchMovementMode.Thumbstick] = v_u8,
	[Enum.TouchMovementMode.DynamicThumbstick] = v_u4,
	[Enum.DevTouchMovementMode.DynamicThumbstick] = v_u4,
	[Enum.TouchMovementMode.ClickToMove] = v_u9,
	[Enum.DevTouchMovementMode.ClickToMove] = v_u9,
	[Enum.TouchMovementMode.Default] = v_u4,
	[Enum.ComputerMovementMode.Default] = v_u2,
	[Enum.ComputerMovementMode.KeyboardMouse] = v_u2,
	[Enum.DevComputerMovementMode.KeyboardMouse] = v_u2,
	[Enum.DevComputerMovementMode.Scriptable] = nil,
	[Enum.ComputerMovementMode.ClickToMove] = v_u9,
	[Enum.DevComputerMovementMode.ClickToMove] = v_u9
}
local v_u13 = {
	[Enum.UserInputType.Keyboard] = v_u2,
	[Enum.UserInputType.MouseButton1] = v_u2,
	[Enum.UserInputType.MouseButton2] = v_u2,
	[Enum.UserInputType.MouseButton3] = v_u2,
	[Enum.UserInputType.MouseWheel] = v_u2,
	[Enum.UserInputType.MouseMovement] = v_u2,
	[Enum.UserInputType.Gamepad1] = v_u3,
	[Enum.UserInputType.Gamepad2] = v_u3,
	[Enum.UserInputType.Gamepad3] = v_u3,
	[Enum.UserInputType.Gamepad4] = v_u3
}
local v_u14 = nil
function v_u1.new()
	-- upvalues: (copy) v_u1, (copy) v_u_players, (copy) v_u11, (copy) v_u_value, (copy) v_u_run, (copy) v_u_userinput, (copy) v_u_usergamesettings, (copy) v_u_gui
	local v_u1 = setmetatable({}, v_u1)
	v_u1.controllers = {}
	v_u1.activeControlModule = nil
	v_u1.activeController = nil
	v_u1.touchJumpController = nil
	v_u1.moveFunction = v_u_players.LocalPlayer.Move
	v_u1.humanoid = nil
	v_u1.lastInputType = Enum.UserInputType.None
	v_u1.controlsEnabled = true
	v_u1.humanoidSeatedConn = nil
	v_u1.vehicleController = nil
	v_u1.touchControlFrame = nil
	v_u1.currentTorsoAngle = 0
	v_u1.inputMoveVector = Vector3.new(0, 0, 0)
	v_u1.vehicleController = v_u11.new(v_u_value)
	v_u_players.LocalPlayer.CharacterAdded:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		v_u1:OnCharacterAdded(arg1)
	end)
	v_u_players.LocalPlayer.CharacterRemoving:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		v_u1:OnCharacterRemoving(arg1)
	end)
	if v_u_players.LocalPlayer.Character then
		v_u1:OnCharacterAdded(v_u_players.LocalPlayer.Character)
	end
	v_u_run:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(arg1)
		-- upvalues: (copy) v_u1
		v_u1:OnRenderStepped(arg1)
	end)
	v_u_userinput.LastInputTypeChanged:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		v_u1:OnLastInputTypeChanged(arg1)
	end)
	v_u_usergamesettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:OnTouchMovementModeChange()
	end)
	v_u_players.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:OnTouchMovementModeChange()
	end)
	v_u_usergamesettings:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:OnComputerMovementModeChange()
	end)
	v_u_players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:OnComputerMovementModeChange()
	end)
	v_u1.playerGui = nil
	v_u1.touchGui = nil
	v_u1.playerGuiAddedConn = nil
	v_u_gui:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:UpdateTouchGuiVisibility()
		v_u1:UpdateActiveControlModuleEnabled()
	end)
	if not v_u_userinput.TouchEnabled then
		v_u1:OnLastInputTypeChanged(v_u_userinput:GetLastInputType())
		return v_u1
	end
	v_u1.playerGui = v_u_players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
	if not v_u1.playerGui then
		v_u1.playerGuiAddedConn = v_u_players.LocalPlayer.ChildAdded:Connect(function(arg1)
			-- upvalues: (copy) v_u1, (ref) v_u_userinput
			if arg1:IsA("PlayerGui") then
				v_u1.playerGui = arg1
				v_u1:CreateTouchGuiContainer()
				v_u1.playerGuiAddedConn:Disconnect()
				v_u1.playerGuiAddedConn = nil
				v_u1:OnLastInputTypeChanged(v_u_userinput:GetLastInputType())
			end
		end)
		return v_u1
	end
	v_u1:CreateTouchGuiContainer()
	v_u1:OnLastInputTypeChanged(v_u_userinput:GetLastInputType())
	return v_u1
end
function v_u1.GetMoveVector(arg1)
	return not arg1.activeController and Vector3.new(0, 0, 0) or arg1.activeController:GetMoveVector()
end
function v_u1.GetEstimatedVRTorsoFrame(arg1)
	-- upvalues: (copy) v_u_vr
	local v_getusercframe = v_u_vr:GetUserCFrame(Enum.UserCFrame.Head)
	local _, v1, _ = v_getusercframe:ToEulerAnglesYXZ()
	local v2 = -v1
	if v_u_vr:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and v_u_vr:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
		local v_getusercframe = v_u_vr:GetUserCFrame(Enum.UserCFrame.LeftHand)
		local v_getusercframe = v_u_vr:GetUserCFrame(Enum.UserCFrame.RightHand)
		local v3 = v_getusercframe.Position - v_getusercframe.Position
		local v4 = v_getusercframe.Position - v_getusercframe.Position
		local v5 = -math.atan2(v3.X, v3.Z)
		local v6 = (-math.atan2(v4.X, v4.Z) - v5 + 12.566370614359172) % 6.283185307179586
		if v6 > 3.141592653589793 then
			v6 = v6 - 6.283185307179586
		end
		local v7 = (v5 + v6 / 2 + 12.566370614359172) % 6.283185307179586
		if v7 > 3.141592653589793 then
			v7 = v7 - 6.283185307179586
		end
		local v8 = (v2 - arg1.currentTorsoAngle + 12.566370614359172) % 6.283185307179586
		if v8 > 3.141592653589793 then
			v8 = v8 - 6.283185307179586
		end
		local v9 = (v7 - arg1.currentTorsoAngle + 12.566370614359172) % 6.283185307179586
		if v9 > 3.141592653589793 then
			v9 = v9 - 6.283185307179586
		end
		local v10
		if v9 > -1.5707963267948966 then
			v10 = v9 < 1.5707963267948966
		else
			v10 = false
		end
		if not v10 then
			v9 = v8
		end
		local v_min = math.min(v9, v8)
		local v_max = math.max(v9, v8)
		local v11 = 0
		if v_min > 0 then
			v_max = v_min
		elseif v_max >= 0 then
			v_max = v11
		end
		arg1.currentTorsoAngle = v_max + arg1.currentTorsoAngle
	else
		arg1.currentTorsoAngle = v2
	end
	return CFrame.new(v_getusercframe.Position) * CFrame.fromEulerAnglesYXZ(0, -arg1.currentTorsoAngle, 0)
end
function v_u1.GetActiveController(arg1)
	return arg1.activeController
end
function v_u1.UpdateActiveControlModuleEnabled(self)
	-- upvalues: (copy) v_u_players, (copy) v_u9, (copy) v_u8, (copy) v_u4, (copy) v_u10, (copy) v_u_gui, (copy) v_u_userinput
	local function v1()
		-- upvalues: (copy) self, (ref) v_u9, (ref) v_u8, (ref) v_u4, (ref) v_u10, (ref) v_u_players
		if self.touchControlFrame and (self.activeControlModule == v_u9 or (self.activeControlModule == v_u8 or self.activeControlModule == v_u4)) then
			if not self.controllers[v_u10] then
				self.controllers[v_u10] = v_u10.new()
			end
			self.touchJumpController = self.controllers[v_u10]
			self.touchJumpController:Enable(true, self.touchControlFrame)
		elseif self.touchJumpController then
			self.touchJumpController:Enable(false)
		end
		if self.activeControlModule == v_u9 then
			self.activeController:Enable(true, v_u_players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, self.touchJumpController)
			return
		elseif self.touchControlFrame then
			self.activeController:Enable(true, self.touchControlFrame)
		else
			self.activeController:Enable(true)
		end
	end
	if self.activeController then
		if self.controlsEnabled then
			if v_u_gui.TouchControlsEnabled or (not v_u_userinput.TouchEnabled or self.activeControlModule ~= v_u9 and (self.activeControlModule ~= v_u8 and self.activeControlModule ~= v_u4)) then
				v1()
			else
				self.activeController:Enable(false)
				if self.touchJumpController then
					self.touchJumpController:Enable(false)
				end
				if self.moveFunction then
					self.moveFunction(v_u_players.LocalPlayer, Vector3.new(0, 0, 0), true)
				end
			end
		else
			self.activeController:Enable(false)
			if self.touchJumpController then
				self.touchJumpController:Enable(false)
			end
			if self.moveFunction then
				self.moveFunction(v_u_players.LocalPlayer, Vector3.new(0, 0, 0), true)
			end
			return
		end
	else
		return
	end
end
function v_u1.Enable(arg1, arg2)
	local v1 = arg2 == nil and true or arg2
	if arg1.controlsEnabled == v1 then
		return
	else
		arg1.controlsEnabled = v1
		if arg1.activeController then
			arg1:UpdateActiveControlModuleEnabled()
		end
	end
end
function v_u1.Disable(arg1)
	arg1:Enable(false)
end
function v_u1.SelectComputerMovementModule(_)
	-- upvalues: (copy) v_u_userinput, (copy) v_u_players, (copy) v_u13, (ref) v_u14, (copy) v_u_usergamesettings, (copy) v_u2, (copy) v_u9, (copy) v_u12
	if v_u_userinput.KeyboardEnabled or v_u_userinput.GamepadEnabled then
		local v_devcomputermovementmode = v_u_players.LocalPlayer.DevComputerMovementMode
		local v1
		if v_devcomputermovementmode == Enum.DevComputerMovementMode.UserChoice then
			v1 = v_u13[v_u14]
			if v_u_usergamesettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v1 == v_u2 then
				v1 = v_u9
			end
		else
			v1 = v_u12[v_devcomputermovementmode]
			if not v1 and v_devcomputermovementmode ~= Enum.DevComputerMovementMode.Scriptable then
				warn("No character control module is associated with DevComputerMovementMode ", v_devcomputermovementmode)
			end
		end
		if v1 then
			return v1, true
		elseif v_devcomputermovementmode == Enum.DevComputerMovementMode.Scriptable then
			return nil, true
		else
			return nil, false
		end
	else
		return nil, false
	end
end
function v_u1.SelectTouchModule(_)
	-- upvalues: (copy) v_u_userinput, (copy) v_u_players, (copy) v_u12, (copy) v_u_usergamesettings
	if not v_u_userinput.TouchEnabled then
		return nil, false
	end
	local v_devtouchmovementmode = v_u_players.LocalPlayer.DevTouchMovementMode
	local v1
	if v_devtouchmovementmode == Enum.DevTouchMovementMode.UserChoice then
		v1 = v_u12[v_u_usergamesettings.TouchMovementMode]
	else
		if v_devtouchmovementmode == Enum.DevTouchMovementMode.Scriptable then
			return nil, true
		end
		v1 = v_u12[v_devtouchmovementmode]
	end
	return v1, true
end
local function v_u15()
	-- upvalues: (copy) v_u_userinput
	local v_getgamepadstate = v_u_userinput:GetGamepadState(Enum.UserInputType.Gamepad1)
	for _, v1 in pairs(v_getgamepadstate) do
		if v1.KeyCode == Enum.KeyCode.Thumbstick2 then
			return v1.Position
		end
	end
	return Vector3.new(0, 0, 0)
end
function v_u1.calculateRawMoveVector(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_workspace, (copy) v_u_vr, (copy) v_u15
	local v_current_camera = v_u_workspace.CurrentCamera
	if not v_current_camera then
		return arg3
	end
	local v_cframe = v_current_camera.CFrame
	if v_u_vr.VREnabled and arg2.RootPart then
		v_u_vr:GetUserCFrame(Enum.UserCFrame.Head)
		local v_getestimatedvrtorsoframe = arg1:GetEstimatedVRTorsoFrame()
		if (v_current_camera.Focus.Position - v_cframe.Position).Magnitude < 3 then
			v_cframe = v_cframe * v_getestimatedvrtorsoframe
		else
			v_cframe = v_current_camera.CFrame * (v_getestimatedvrtorsoframe.Rotation + v_getestimatedvrtorsoframe.Position * v_current_camera.HeadScale)
		end
	end
	if arg2:GetState() ~= Enum.HumanoidStateType.Swimming then
		local _, _, _, v5, v2, v3, _, _, v4, _, _, v5 = v_cframe:GetComponents()
		if v4 >= 1 or v4 <= -1 then
			v3 = -v2 * math.sign(v4)
		end
		local v_sqrt = math.sqrt(v5 * v5 + v3 * v3)
		return Vector3.new((v5 * arg3.X + v3 * arg3.Z) / v_sqrt, 0, (v5 * arg3.Z - v3 * arg3.X) / v_sqrt)
	end
	if not v_u_vr.VREnabled then
		return v_cframe:VectorToWorldSpace(arg3)
	end
	local v_new = Vector3.new(arg3.X, 0, arg3.Z)
	if v_new.Magnitude < 0.01 then
		return Vector3.new(0, 0, 0)
	end
	local v_atan2 = math.atan2(-v_new.X, -v_new.Z)
	local _, v6, _ = v_cframe:ToEulerAnglesYXZ()
	return CFrame.fromEulerAnglesYXZ(-v_u15().Y * 1.3962634015954636, v_atan2 + v6, 0).LookVector
end
function v_u1.OnRenderStepped(arg1, arg2)
	-- upvalues: (copy) v_u3, (copy) v_u_vr, (copy) v_u_players
	if arg1.activeController and (arg1.activeController.enabled and arg1.humanoid) then
		local v_getmovevector = arg1.activeController:GetMoveVector()
		local v_ismovevectorcamerarelative = arg1.activeController:IsMoveVectorCameraRelative()
		local v_getclicktomovecontroller = arg1:GetClickToMoveController()
		if arg1.activeController == v_getclicktomovecontroller then
			v_getclicktomovecontroller:OnRenderStepped(arg2)
		elseif v_getmovevector.magnitude > 0 then
			v_getclicktomovecontroller:CleanupPath()
		else
			v_getclicktomovecontroller:OnRenderStepped(arg2)
			v_getmovevector = v_getclicktomovecontroller:GetMoveVector()
			v_ismovevectorcamerarelative = v_getclicktomovecontroller:IsMoveVectorCameraRelative()
		end
		if arg1.vehicleController then
			local v1
			v_getmovevector, v1 = arg1.vehicleController:Update(v_getmovevector, v_ismovevectorcamerarelative, arg1.activeControlModule == v_u3)
		end
		if v_ismovevectorcamerarelative then
			v_getmovevector = arg1:calculateRawMoveVector(arg1.humanoid, v_getmovevector)
		end
		arg1.inputMoveVector = v_getmovevector
		if v_u_vr.VREnabled then
			v_getmovevector = arg1:updateVRMoveVector(v_getmovevector)
		end
		arg1.moveFunction(v_u_players.LocalPlayer, v_getmovevector, false)
	end
end
function v_u1.updateVRMoveVector(arg1, arg2)
	-- upvalues: (copy) v_u_vr
	local v_current_camera = workspace.CurrentCamera
	if arg2.Magnitude ~= 0 or ((v_current_camera.Focus.Position - v_current_camera.CFrame.Position).Magnitude >= 5 or (not v_u_vr.AvatarGestures or (not arg1.humanoid or arg1.humanoid.Sit))) then
		return arg2
	end
	local v_getusercframe = v_u_vr:GetUserCFrame(Enum.UserCFrame.Head)
	local v1 = (v_current_camera.CFrame * (v_getusercframe.Rotation + v_getusercframe.Position * v_current_camera.HeadScale) * CFrame.new(0, -0.7 * arg1.humanoid.RootPart.Size.Y / 2, 0)).Position - arg1.humanoid.RootPart.CFrame.Position
	return Vector3.new(v1.x, 0, v1.z)
end
function v_u1.OnHumanoidSeated(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_value
	if arg2 then
		if arg3 and arg3:IsA("VehicleSeat") then
			if not arg1.vehicleController then
				arg1.vehicleController = arg1.vehicleController.new(v_u_value)
			end
			arg1.vehicleController:Enable(true, arg3)
			return
		end
	elseif arg1.vehicleController then
		arg1.vehicleController:Enable(false, arg3)
	end
end
function v_u1.OnCharacterAdded(arg1, arg2)
	arg1.humanoid = arg2:FindFirstChildOfClass("Humanoid")
	while not arg1.humanoid do
		arg2.ChildAdded:wait()
		arg1.humanoid = arg2:FindFirstChildOfClass("Humanoid")
	end
	arg1:UpdateTouchGuiVisibility()
	if arg1.humanoidSeatedConn then
		arg1.humanoidSeatedConn:Disconnect()
		arg1.humanoidSeatedConn = nil
	end
	arg1.humanoidSeatedConn = arg1.humanoid.Seated:Connect(function(arg1, arg2)
		-- upvalues: (copy) arg1
		arg1:OnHumanoidSeated(arg1, arg2)
	end)
end
function v_u1.OnCharacterRemoving(arg1, _)
	arg1.humanoid = nil
	arg1:UpdateTouchGuiVisibility()
end
function v_u1.UpdateTouchGuiVisibility(arg1)
	-- upvalues: (copy) v_u_gui
	if arg1.touchGui then
		local v_humanoid = arg1.humanoid
		if v_humanoid then
			v_humanoid = v_u_gui.TouchControlsEnabled
		end
		arg1.touchGui.Enabled = v_humanoid and true or false
	end
end
function v_u1.SwitchToController(arg1, arg2)
	-- upvalues: (copy) v_u_value
	if arg2 then
		if not arg1.controllers[arg2] then
			arg1.controllers[arg2] = arg2.new(v_u_value)
		end
		if arg1.activeController ~= arg1.controllers[arg2] then
			if arg1.activeController then
				arg1.activeController:Enable(false)
			end
			arg1.activeController = arg1.controllers[arg2]
			arg1.activeControlModule = arg2
			arg1:UpdateActiveControlModuleEnabled()
		end
	else
		if arg1.activeController then
			arg1.activeController:Enable(false)
		end
		arg1.activeController = nil
		arg1.activeControlModule = nil
	end
end
function v_u1.OnLastInputTypeChanged(arg1, arg2)
	-- upvalues: (ref) v_u14, (copy) v_u13
	if v_u14 == arg2 then
		warn("LastInputType Change listener called with current type.")
	end
	if arg2 == Enum.UserInputType.Touch then
		local v_selecttouchmodule, v1 = arg1:SelectTouchModule()
		if v1 then
			while not arg1.touchControlFrame do
				wait()
			end
			arg1:SwitchToController(v_selecttouchmodule)
		end
	elseif v_u13[v_u14] ~= nil then
		local v_selectcomputermovementmodule = arg1:SelectComputerMovementModule()
		if v_selectcomputermovementmodule then
			arg1:SwitchToController(v_selectcomputermovementmodule)
		end
	end
	arg1:UpdateTouchGuiVisibility()
end
function v_u1.OnComputerMovementModeChange(arg1)
	local v_selectcomputermovementmodule, v1 = arg1:SelectComputerMovementModule()
	if v1 then
		arg1:SwitchToController(v_selectcomputermovementmodule)
	end
end
function v_u1.OnTouchMovementModeChange(arg1)
	local v_selecttouchmodule, v1 = arg1:SelectTouchModule()
	if v1 then
		while not arg1.touchControlFrame do
			wait()
		end
		arg1:SwitchToController(v_selecttouchmodule)
	end
end
function v_u1.CreateTouchGuiContainer(arg1)
	-- upvalues: (ref) v_u7
	if arg1.touchGui then
		arg1.touchGui:Destroy()
	end
	arg1.touchGui = Instance.new("ScreenGui")
	arg1.touchGui.Name = "TouchGui"
	arg1.touchGui.ResetOnSpawn = false
	arg1.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	arg1:UpdateTouchGuiVisibility()
	if v_u7 then
		arg1.touchGui.ClipToDeviceSafeArea = false
	end
	arg1.touchControlFrame = Instance.new("Frame")
	arg1.touchControlFrame.Name = "TouchControlFrame"
	arg1.touchControlFrame.Size = UDim2.new(1, 0, 1, 0)
	arg1.touchControlFrame.BackgroundTransparency = 1
	arg1.touchControlFrame.Parent = arg1.touchGui
	arg1.touchGui.Parent = arg1.playerGui
end
function v_u1.GetClickToMoveController(arg1)
	-- upvalues: (copy) v_u9, (copy) v_u_value
	if not arg1.controllers[v_u9] then
		arg1.controllers[v_u9] = v_u9.new(v_u_value)
	end
	return arg1.controllers[v_u9]
end
return v_u1.new()