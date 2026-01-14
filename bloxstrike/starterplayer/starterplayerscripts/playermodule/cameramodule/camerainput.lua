-- Decompiled with Bunni.lol Decompiler

local v_u_contextaction = game:GetService("ContextActionService")
local v_u_userinput = game:GetService("UserInputService")
local v_players = game:GetService("Players")
local v_run = game:GetService("RunService")
local v_u_usergamesettings = UserSettings():GetService("UserGameSettings")
local v_u_vr = game:GetService("VRService")
local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_usercamerainputdt = require(v_commonutils:WaitForChild("FlagUtil")).getUserFlag("UserCameraInputDt")
local v_u_localplayer = v_players.LocalPlayer
local v_u_value = Enum.ContextActionPriority.Medium.Value
local v_u1 = Vector2.new(1, 0.77) * 0.06981317007977318
local v_u2 = Vector2.new(1, 0.77) * 0.008726646259971648
local v_u3 = Vector2.new(1, 0.77) * 0.12217304763960307
local v_u4 = Vector2.new(1, 0.66) * 0.017453292519943295
if v_u_usercamerainputdt then
	v_u1 = v_u1 * 60
end
local v5, v6 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserResetTouchStateOnMenuOpen")
end)
local v_u7 = v5 and v6
local v8, v9 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserClearPanOnCameraDisable")
end)
local v_u10 = v8 and v9
local v_u_bindableevent = Instance.new("BindableEvent")
local v_u_bindableevent = Instance.new("BindableEvent")
local v_u_event = v_u_bindableevent.Event
local v_u_event = v_u_bindableevent.Event
v_u_userinput.InputBegan:Connect(function(arg1, arg2)
	-- upvalues: (copy) v_u_bindableevent
	if not arg2 and arg1.UserInputType == Enum.UserInputType.MouseButton2 then
		v_u_bindableevent:Fire()
	end
end)
v_u_userinput.InputEnded:Connect(function(arg1, _)
	-- upvalues: (copy) v_u_bindableevent
	if arg1.UserInputType == Enum.UserInputType.MouseButton2 then
		v_u_bindableevent:Fire()
	end
end)
local function v_u11(arg1)
	return math.sign(arg1) * math.clamp((math.exp((math.abs(arg1) - 0.1) / 0.9 * 2) - 1) / 6.38905609893065, 0, 1)
end
local function v_u12(arg1)
	local v_current_camera = workspace.CurrentCamera
	if v_current_camera then
		local v_toeuleranglesyxz = v_current_camera.CFrame:ToEulerAnglesYXZ()
		if arg1.Y * v_toeuleranglesyxz >= 0 then
			return arg1
		else
			return Vector2.new(1, (1 - (math.abs(v_toeuleranglesyxz) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25) * arg1
		end
	else
		return arg1
	end
end
local function v_u13(arg1)
	-- upvalues: (copy) v_u_localplayer
	local v_playergui = v_u_localplayer:FindFirstChildOfClass("PlayerGui")
	if v_playergui then
		v_playergui = v_playergui:FindFirstChild("TouchGui")
	end
	local v1
	if v_playergui then
		v1 = v_playergui:FindFirstChild("TouchControlFrame")
	else
		v1 = v_playergui
	end
	if v1 then
		v1 = v1:FindFirstChild("DynamicThumbstickFrame")
	end
	if not v1 then
		return false
	end
	if not v_playergui.Enabled then
		return false
	end
	local v_absoluteposition = v1.AbsolutePosition
	local v2 = v_absoluteposition + v1.AbsoluteSize
	local v3
	if arg1.X >= v_absoluteposition.X and (arg1.Y >= v_absoluteposition.Y and arg1.X <= v2.X) then
		v3 = arg1.Y <= v2.Y
	else
		v3 = false
	end
	return v3
end
local v_u14 = 0.016666666666666666
v_run.Stepped:Connect(function(_, arg2)
	-- upvalues: (ref) v_u14
	v_u14 = arg2
end)
local v15 = {}
local v_u16 = {}
local v_u17 = 0
local v_u18 = {
	["Thumbstick2"] = Vector2.new()
}
local v_u19 = {
	["Left"] = 0,
	["Right"] = 0,
	["I"] = 0,
	["O"] = 0
}
local v_u20 = {
	["Movement"] = Vector2.new(),
	["Wheel"] = 0,
	["Pan"] = Vector2.new(),
	["Pinch"] = 0
}
local v_u21 = {
	["Move"] = Vector2.new(),
	["Pinch"] = 0
}
local v_u_bindableevent = Instance.new("BindableEvent")
v15.gamepadZoomPress = v_u_bindableevent.Event
local v_u22 = v_u_vr.VREnabled and Instance.new("BindableEvent") or nil
if v_u_vr.VREnabled then
	v15.gamepadReset = v_u22.Event
end
function v15.getRotationActivated()
	-- upvalues: (ref) v_u17, (copy) v_u18
	return v_u17 > 0 and true or v_u18.Thumbstick2.Magnitude > 0
end
function v15.getRotation(arg1, arg2)
	-- upvalues: (copy) v_u_usergamesettings, (copy) v_u_usercamerainputdt, (copy) v_u19, (ref) v_u14, (copy) v_u18, (copy) v_u20, (copy) v_u12, (copy) v_u21, (ref) v_u1, (copy) v_u2, (copy) v_u3, (copy) v_u4
	local v_new = Vector2.new(1, v_u_usergamesettings:GetCameraYInvertValue())
	local v1
	if v_u_usercamerainputdt then
		v1 = Vector2.new(v_u19.Right - v_u19.Left, 0) * arg1
	else
		v1 = Vector2.new(v_u19.Right - v_u19.Left, 0) * v_u14
	end
	local v2 = v_u18.Thumbstick2 * v_u_usergamesettings.GamepadCameraSensitivity
	if v_u_usercamerainputdt then
		v2 = v2 * arg1
	end
	local v_movement = v_u20.Movement
	local v_pan = v_u20.Pan
	local v3 = v_u12(v_u21.Move)
	if arg2 then
		v1 = Vector2.new()
	end
	return (v1 * 2.0943951023931953 + v2 * v_u1 + v_movement * v_u2 + v_pan * v_u3 + v3 * v_u4) * v_new
end
function v15.getZoomDelta()
	-- upvalues: (copy) v_u19, (copy) v_u20, (copy) v_u21
	return (v_u19.O - v_u19.I) * 0.1 + (-v_u20.Wheel + v_u20.Pinch) * 1 + -v_u21.Pinch * 0.04
end
local function v_u23(_, _, arg3)
	-- upvalues: (copy) v_u18, (ref) v_u11
	local v_position = arg3.Position
	v_u18[arg3.KeyCode.Name] = Vector2.new(v_u11(v_position.X), -v_u11(v_position.Y))
	return Enum.ContextActionResult.Pass
end
local function v_u24(_, arg2, arg3)
	-- upvalues: (copy) v_u19
	v_u19[arg3.KeyCode.Name] = arg2 == Enum.UserInputState.Begin and 1 or 0
end
local function v_u25(_, arg2, _)
	-- upvalues: (copy) v_u_bindableevent
	if arg2 == Enum.UserInputState.Begin then
		v_u_bindableevent:Fire()
	end
end
local function v_u26(_, arg2, _)
	-- upvalues: (copy) v_u22
	if arg2 == Enum.UserInputState.Begin then
		v_u22:Fire()
	end
end
local function v_u27()
	-- upvalues: (copy) v_u18, (copy) v_u19, (copy) v_u20, (copy) v_u21, (ref) v_u10, (ref) v_u17
	for _, v1 in pairs({
		v_u18,
		v_u19,
		v_u20,
		v_u21
	}) do
		for v2, v3 in pairs(v1) do
			if type(v3) == "boolean" then
				v1[v2] = false
			else
				v1[v2] = v1[v2] * 0
			end
		end
	end
	if v_u10 then
		v_u17 = 0
	end
end
local v_u28 = {}
local v_u29 = nil
local v_u30 = nil
local function v_u31(arg1, arg2)
	-- upvalues: (ref) v_u29, (copy) v_u13, (ref) v_u17, (ref) v_u28
	assert(arg1.UserInputType == Enum.UserInputType.Touch)
	assert(arg1.UserInputState == Enum.UserInputState.Begin)
	if v_u29 == nil and (v_u13(arg1.Position) and not arg2) then
		v_u29 = arg1
	else
		if not arg2 then
			v_u17 = math.max(0, v_u17 + 1)
		end
		v_u28[arg1] = arg2
	end
end
local function v_u32(arg1, _)
	-- upvalues: (ref) v_u29, (ref) v_u28, (ref) v_u30, (ref) v_u17
	assert(arg1.UserInputType == Enum.UserInputType.Touch)
	assert(arg1.UserInputState == Enum.UserInputState.End)
	if arg1 == v_u29 then
		v_u29 = nil
	end
	if v_u28[arg1] == false then
		v_u30 = nil
		v_u17 = math.max(0, v_u17 - 1)
	end
	v_u28[arg1] = nil
end
local function v_u33(arg1, arg2)
	-- upvalues: (ref) v_u29, (ref) v_u28, (copy) v_u21, (ref) v_u30
	assert(arg1.UserInputType == Enum.UserInputType.Touch)
	assert(arg1.UserInputState == Enum.UserInputState.Change)
	if arg1 == v_u29 then
		return
	else
		if v_u28[arg1] == nil then
			v_u28[arg1] = arg2
		end
		local v1 = {}
		for v2, v3 in pairs(v_u28) do
			if not v3 then
				table.insert(v1, v2)
			end
		end
		if #v1 == 1 and v_u28[arg1] == false then
			local v_delta = arg1.Delta
			local v4 = v_u21
			v4.Move = v4.Move + Vector2.new(v_delta.X, v_delta.Y)
		end
		if #v1 == 2 then
			local v_magnitude = (v1[1].Position - v1[2].Position).Magnitude
			if v_u30 then
				local v5 = v_u21
				v5.Pinch = v5.Pinch + (v_magnitude - v_u30)
			end
			v_u30 = v_magnitude
		else
			v_u30 = nil
		end
	end
end
local function v_u34()
	-- upvalues: (ref) v_u28, (ref) v_u29, (ref) v_u30, (ref) v_u7, (ref) v_u17
	v_u28 = {}
	v_u29 = nil
	v_u30 = nil
	if v_u7 then
		v_u17 = 0
	end
end
local function v_u35(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u20
	if not arg4 then
		v_u20.Wheel = arg1
		v_u20.Pan = arg2
		v_u20.Pinch = -arg3
	end
end
local function v_u36(arg1, arg2)
	-- upvalues: (ref) v_u31, (ref) v_u17
	if arg1.UserInputType == Enum.UserInputType.Touch then
		v_u31(arg1, arg2)
	elseif arg1.UserInputType == Enum.UserInputType.MouseButton2 and not arg2 then
		v_u17 = math.max(0, v_u17 + 1)
	end
end
local function v_u37(arg1, arg2)
	-- upvalues: (ref) v_u33, (copy) v_u20
	if arg1.UserInputType == Enum.UserInputType.Touch then
		v_u33(arg1, arg2)
	elseif arg1.UserInputType == Enum.UserInputType.MouseMovement then
		local v_delta = arg1.Delta
		v_u20.Movement = Vector2.new(v_delta.X, v_delta.Y)
	end
end
local function v_u38(arg1, arg2)
	-- upvalues: (ref) v_u32, (ref) v_u17
	if arg1.UserInputType == Enum.UserInputType.Touch then
		v_u32(arg1, arg2)
	elseif arg1.UserInputType == Enum.UserInputType.MouseButton2 then
		v_u17 = math.max(0, v_u17 - 1)
	end
end
local v_u39 = false
function v15.setInputEnabled(arg1)
	-- upvalues: (ref) v_u39, (copy) v_u27, (ref) v_u34, (copy) v_u_contextaction, (copy) v_u23, (copy) v_u_value, (copy) v_u24, (copy) v_u_vr, (copy) v_u26, (copy) v_u25, (ref) v_u16, (copy) v_u_userinput, (copy) v_u36, (copy) v_u37, (copy) v_u38, (copy) v_u35, (ref) v_u7
	if v_u39 ~= arg1 then
		v_u27()
		v_u34()
		if arg1 then
			v_u_contextaction:BindActionAtPriority("RbxCameraThumbstick", v_u23, false, v_u_value, Enum.KeyCode.Thumbstick2)
			v_u_contextaction:BindActionAtPriority("RbxCameraKeypress", v_u24, false, v_u_value, Enum.KeyCode.I, Enum.KeyCode.O)
			if v_u_vr.VREnabled then
				v_u_contextaction:BindAction("RbxCameraGamepadReset", v_u26, false, Enum.KeyCode.ButtonL3)
			end
			v_u_contextaction:BindAction("RbxCameraGamepadZoom", v_u25, false, Enum.KeyCode.ButtonR3)
			table.insert(v_u16, v_u_userinput.InputBegan:Connect(v_u36))
			table.insert(v_u16, v_u_userinput.InputChanged:Connect(v_u37))
			table.insert(v_u16, v_u_userinput.InputEnded:Connect(v_u38))
			table.insert(v_u16, v_u_userinput.PointerAction:Connect(v_u35))
			if v_u7 then
				table.insert(v_u16, game:GetService("GuiService").MenuOpened:connect(v_u34))
				return
			end
		else
			v_u_contextaction:UnbindAction("RbxCameraThumbstick")
			v_u_contextaction:UnbindAction("RbxCameraMouseMove")
			v_u_contextaction:UnbindAction("RbxCameraMouseWheel")
			v_u_contextaction:UnbindAction("RbxCameraKeypress")
			v_u_contextaction:UnbindAction("RbxCameraGamepadZoom")
			if v_u_vr.VREnabled then
				v_u_contextaction:UnbindAction("RbxCameraGamepadReset")
			end
			for _, v1 in pairs(v_u16) do
				v1:Disconnect()
			end
			v_u16 = {}
		end
	end
end
function v15.getInputEnabled()
	-- upvalues: (ref) v_u39
	return v_u39
end
function v15.resetInputForFrameEnd()
	-- upvalues: (copy) v_u20, (copy) v_u21
	v_u20.Movement = Vector2.new()
	v_u21.Move = Vector2.new()
	v_u21.Pinch = 0
	v_u20.Wheel = 0
	v_u20.Pan = Vector2.new()
	v_u20.Pinch = 0
end
v_u_userinput.WindowFocused:Connect(v_u27)
v_u_userinput.WindowFocusReleased:Connect(v_u27)
local v_u40 = false
local v_u41 = false
local v_u42 = 0
function v15.getHoldPan()
	-- upvalues: (ref) v_u40
	return v_u40
end
function v15.getTogglePan()
	-- upvalues: (ref) v_u41
	return v_u41
end
function v15.getPanning()
	-- upvalues: (ref) v_u41, (ref) v_u40
	return v_u41 or v_u40
end
function v15.setTogglePan(arg1)
	-- upvalues: (ref) v_u41
	v_u41 = arg1
end
local v_u43 = false
local v_u44 = nil
local v_u45 = nil
function v15.enableCameraToggleInput()
	-- upvalues: (ref) v_u43, (ref) v_u40, (ref) v_u41, (ref) v_u44, (ref) v_u45, (ref) v_u_event, (ref) v_u42, (ref) v_u_event, (copy) v_u_userinput
	if not v_u43 then
		v_u43 = true
		v_u40 = false
		v_u41 = false
		if v_u44 then
			v_u44:Disconnect()
		end
		if v_u45 then
			v_u45:Disconnect()
		end
		v_u44 = v_u_event:Connect(function()
			-- upvalues: (ref) v_u40, (ref) v_u42
			v_u40 = true
			v_u42 = tick()
		end)
		v_u45 = v_u_event:Connect(function()
			-- upvalues: (ref) v_u40, (ref) v_u42, (ref) v_u41, (ref) v_u_userinput
			v_u40 = false
			if tick() - v_u42 < 0.3 and (v_u41 or v_u_userinput:GetMouseDelta().Magnitude < 2) then
				v_u41 = not v_u41
			end
		end)
	end
end
function v15.disableCameraToggleInput()
	-- upvalues: (ref) v_u43, (ref) v_u44, (ref) v_u45
	if v_u43 then
		v_u43 = false
		if v_u44 then
			v_u44:Disconnect()
			v_u44 = nil
		end
		if v_u45 then
			v_u45:Disconnect()
			v_u45 = nil
		end
	end
end
return v15