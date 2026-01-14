-- Decompiled with Bunni.lol Decompiler

local v_u_userinput = game:GetService("UserInputService")
local v_u_contextaction = game:GetService("ContextActionService")
script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_new = Vector3.new()
local v_u1 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u2 = setmetatable({}, v_u1)
v_u2.__index = v_u2
function v_u2.new(arg1)
	-- upvalues: (copy) v_u1, (copy) v_u2
	local v_new = v_u1.new()
	local v1 = setmetatable(v_new, v_u2)
	v1.CONTROL_ACTION_PRIORITY = arg1
	v1.forwardValue = 0
	v1.backwardValue = 0
	v1.leftValue = 0
	v1.rightValue = 0
	v1.jumpEnabled = true
	return v1
end
function v_u2.Enable(arg1, arg2)
	-- upvalues: (copy) v_u_new
	if arg2 == arg1.enabled then
		return true
	end
	arg1.forwardValue = 0
	arg1.backwardValue = 0
	arg1.leftValue = 0
	arg1.rightValue = 0
	arg1.moveVector = v_u_new
	arg1.jumpRequested = false
	arg1:UpdateJump()
	if arg2 then
		arg1:BindContextActions()
		arg1:ConnectFocusEventListeners()
	else
		arg1._connectionUtil:disconnectAll()
	end
	arg1.enabled = arg2
	return true
end
function v_u2.UpdateMovement(arg1, arg2)
	-- upvalues: (copy) v_u_new
	if arg2 == Enum.UserInputState.Cancel then
		arg1.moveVector = v_u_new
	else
		arg1.moveVector = Vector3.new(arg1.leftValue + arg1.rightValue, 0, arg1.forwardValue + arg1.backwardValue)
	end
end
function v_u2.UpdateJump(arg1)
	arg1.isJumping = arg1.jumpRequested
end
function v_u2.BindContextActions(self)
	-- upvalues: (copy) v_u_contextaction
	v_u_contextaction:BindActionAtPriority("moveForwardAction", function(_, arg2, _)
		-- upvalues: (copy) self
		self.forwardValue = arg2 == Enum.UserInputState.Begin and -1 or 0
		self:UpdateMovement(arg2)
		return Enum.ContextActionResult.Pass
	end, false, self.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterForward)
	v_u_contextaction:BindActionAtPriority("moveBackwardAction", function(_, arg2, _)
		-- upvalues: (copy) self
		self.backwardValue = arg2 == Enum.UserInputState.Begin and 1 or 0
		self:UpdateMovement(arg2)
		return Enum.ContextActionResult.Pass
	end, false, self.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterBackward)
	v_u_contextaction:BindActionAtPriority("moveLeftAction", function(_, arg2, _)
		-- upvalues: (copy) self
		self.leftValue = arg2 == Enum.UserInputState.Begin and -1 or 0
		self:UpdateMovement(arg2)
		return Enum.ContextActionResult.Pass
	end, false, self.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterLeft)
	v_u_contextaction:BindActionAtPriority("moveRightAction", function(_, arg2, _)
		-- upvalues: (copy) self
		self.rightValue = arg2 == Enum.UserInputState.Begin and 1 or 0
		self:UpdateMovement(arg2)
		return Enum.ContextActionResult.Pass
	end, false, self.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterRight)
	v_u_contextaction:BindActionAtPriority("jumpAction", function(_, arg2, _)
		-- upvalues: (copy) self
		local v1 = self
		local v_jumpenabled = self.jumpEnabled
		if v_jumpenabled then
			v_jumpenabled = arg2 == Enum.UserInputState.Begin
		end
		v1.jumpRequested = v_jumpenabled
		self:UpdateJump()
		return Enum.ContextActionResult.Pass
	end, false, self.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterJump)
	self._connectionUtil:trackBoundFunction("moveForwardAction", function()
		-- upvalues: (ref) v_u_contextaction
		v_u_contextaction:UnbindAction("moveForwardAction")
	end)
	self._connectionUtil:trackBoundFunction("moveBackwardAction", function()
		-- upvalues: (ref) v_u_contextaction
		v_u_contextaction:UnbindAction("moveBackwardAction")
	end)
	self._connectionUtil:trackBoundFunction("moveLeftAction", function()
		-- upvalues: (ref) v_u_contextaction
		v_u_contextaction:UnbindAction("moveLeftAction")
	end)
	self._connectionUtil:trackBoundFunction("moveRightAction", function()
		-- upvalues: (ref) v_u_contextaction
		v_u_contextaction:UnbindAction("moveRightAction")
	end)
	self._connectionUtil:trackBoundFunction("jumpAction", function()
		-- upvalues: (ref) v_u_contextaction
		v_u_contextaction:UnbindAction("jumpAction")
	end)
end
function v_u2.ConnectFocusEventListeners(self)
	-- upvalues: (copy) v_u_new, (copy) v_u_userinput
	local function v1()
		-- upvalues: (copy) self, (ref) v_u_new
		self.moveVector = v_u_new
		self.forwardValue = 0
		self.backwardValue = 0
		self.leftValue = 0
		self.rightValue = 0
		self.jumpRequested = false
		self:UpdateJump()
	end
	self._connectionUtil:trackConnection("textBoxFocusReleased", v_u_userinput.TextBoxFocusReleased:Connect(v1))
	self._connectionUtil:trackConnection("textBoxFocused", v_u_userinput.TextBoxFocused:Connect(function(_)
		-- upvalues: (copy) self
		self.jumpRequested = false
		self:UpdateJump()
	end))
	self._connectionUtil:trackConnection("windowFocusReleased", v_u_userinput.WindowFocused:Connect(v1))
end
return v_u2