-- Decompiled with Bunni.lol Decompiler

local v_u_userinput = game:GetService("UserInputService")
local v_u_contextaction = game:GetService("ContextActionService")
script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_none = Enum.UserInputType.None
local v_u1 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u2 = setmetatable({}, v_u1)
v_u2.__index = v_u2
function v_u2.new(arg1)
	-- upvalues: (copy) v_u1, (copy) v_u2, (copy) v_u_none
	local v_new = v_u1.new()
	local v1 = setmetatable(v_new, v_u2)
	v1.CONTROL_ACTION_PRIORITY = arg1
	v1.forwardValue = 0
	v1.backwardValue = 0
	v1.leftValue = 0
	v1.rightValue = 0
	v1.activeGamepad = v_u_none
	v1.gamepadConnectedConn = nil
	v1.gamepadDisconnectedConn = nil
	return v1
end
function v_u2.Enable(arg1, arg2)
	-- upvalues: (copy) v_u_none
	if arg2 == arg1.enabled then
		return true
	end
	arg1.forwardValue = 0
	arg1.backwardValue = 0
	arg1.leftValue = 0
	arg1.rightValue = 0
	arg1.moveVector = Vector3.new(0, 0, 0)
	arg1.isJumping = false
	if arg2 then
		arg1.activeGamepad = arg1:GetHighestPriorityGamepad()
		if arg1.activeGamepad == v_u_none then
			return false
		end
		arg1:BindContextActions()
		arg1:ConnectGamepadConnectionListeners()
	else
		arg1:UnbindContextActions()
		arg1:DisconnectGamepadConnectionListeners()
		arg1.activeGamepad = v_u_none
	end
	arg1.enabled = arg2
	return true
end
function v_u2.GetHighestPriorityGamepad(_)
	-- upvalues: (copy) v_u_userinput, (copy) v_u_none
	local v_getconnectedgamepads = v_u_userinput:GetConnectedGamepads()
	local v1 = v_u_none
	for _, v2 in pairs(v_getconnectedgamepads) do
		if v2.Value < v1.Value then
			v1 = v2
		end
	end
	return v1
end
function v_u2.BindContextActions(self)
	-- upvalues: (copy) v_u_none, (copy) v_u_contextaction
	if self.activeGamepad == v_u_none then
		return false
	end
	v_u_contextaction:BindActivate(self.activeGamepad, Enum.KeyCode.ButtonR2)
	v_u_contextaction:BindActionAtPriority("jumpAction", function(_, arg2, _)
		-- upvalues: (copy) self
		self.isJumping = arg2 == Enum.UserInputState.Begin
		return Enum.ContextActionResult.Sink
	end, false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA)
	v_u_contextaction:BindActionAtPriority("moveThumbstick", function(_, arg2, arg3)
		-- upvalues: (copy) self
		if arg2 == Enum.UserInputState.Cancel then
			self.moveVector = Vector3.new(0, 0, 0)
			return Enum.ContextActionResult.Sink
		end
		if self.activeGamepad ~= arg3.UserInputType then
			return Enum.ContextActionResult.Pass
		end
		if arg3.KeyCode == Enum.KeyCode.Thumbstick1 then
			if arg3.Position.magnitude > 0.2 then
				self.moveVector = Vector3.new(arg3.Position.X, 0, -arg3.Position.Y)
			else
				self.moveVector = Vector3.new(0, 0, 0)
			end
			return Enum.ContextActionResult.Sink
		end
	end, false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1)
	return true
end
function v_u2.UnbindContextActions(arg1)
	-- upvalues: (copy) v_u_none, (copy) v_u_contextaction
	if arg1.activeGamepad ~= v_u_none then
		v_u_contextaction:UnbindActivate(arg1.activeGamepad, Enum.KeyCode.ButtonR2)
	end
	v_u_contextaction:UnbindAction("moveThumbstick")
	v_u_contextaction:UnbindAction("jumpAction")
end
function v_u2.OnNewGamepadConnected(arg1)
	-- upvalues: (copy) v_u_none
	local v_gethighestprioritygamepad = arg1:GetHighestPriorityGamepad()
	if v_gethighestprioritygamepad == arg1.activeGamepad then
		return
	elseif v_gethighestprioritygamepad == v_u_none then
		warn("Gamepad:OnNewGamepadConnected found no connected gamepads")
		arg1:UnbindContextActions()
	else
		if arg1.activeGamepad ~= v_u_none then
			arg1:UnbindContextActions()
		end
		arg1.activeGamepad = v_gethighestprioritygamepad
		arg1:BindContextActions()
	end
end
function v_u2.OnCurrentGamepadDisconnected(arg1)
	-- upvalues: (copy) v_u_none, (copy) v_u_contextaction
	if arg1.activeGamepad ~= v_u_none then
		v_u_contextaction:UnbindActivate(arg1.activeGamepad, Enum.KeyCode.ButtonR2)
	end
	local v_gethighestprioritygamepad = arg1:GetHighestPriorityGamepad()
	if arg1.activeGamepad == v_u_none or v_gethighestprioritygamepad ~= arg1.activeGamepad then
		if v_gethighestprioritygamepad == v_u_none then
			arg1:UnbindContextActions()
			arg1.activeGamepad = v_u_none
		else
			arg1.activeGamepad = v_gethighestprioritygamepad
			v_u_contextaction:BindActivate(arg1.activeGamepad, Enum.KeyCode.ButtonR2)
		end
	else
		warn("Gamepad:OnCurrentGamepadDisconnected found the supposedly disconnected gamepad in connectedGamepads.")
		arg1:UnbindContextActions()
		arg1.activeGamepad = v_u_none
		return
	end
end
function v_u2.ConnectGamepadConnectionListeners(self)
	-- upvalues: (copy) v_u_userinput
	self.gamepadConnectedConn = v_u_userinput.GamepadConnected:Connect(function(_)
		-- upvalues: (copy) self
		self:OnNewGamepadConnected()
	end)
	self.gamepadDisconnectedConn = v_u_userinput.GamepadDisconnected:Connect(function(arg1)
		-- upvalues: (copy) self
		if self.activeGamepad == arg1 then
			self:OnCurrentGamepadDisconnected()
		end
	end)
end
function v_u2.DisconnectGamepadConnectionListeners(arg1)
	if arg1.gamepadConnectedConn then
		arg1.gamepadConnectedConn:Disconnect()
		arg1.gamepadConnectedConn = nil
	end
	if arg1.gamepadDisconnectedConn then
		arg1.gamepadDisconnectedConn:Disconnect()
		arg1.gamepadDisconnectedConn = nil
	end
end
return v_u2