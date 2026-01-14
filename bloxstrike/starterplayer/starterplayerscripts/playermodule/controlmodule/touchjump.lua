-- Decompiled with Bunni.lol Decompiler

game:GetService("Players")
local v_u_gui = game:GetService("GuiService")
local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u1 = require(v_commonutils:WaitForChild("ConnectionUtil"))
local v_u2 = require(v_commonutils:WaitForChild("CharacterUtil"))
local v_u3 = {
	["HUMANOID_STATE_ENABLED_CHANGED"] = "HUMANOID_STATE_ENABLED_CHANGED",
	["HUMANOID_JUMP_POWER"] = "HUMANOID_JUMP_POWER",
	["HUMANOID"] = "HUMANOID",
	["JUMP_INPUT_ENDED"] = "JUMP_INPUT_ENDED",
	["MENU_OPENED"] = "MENU_OPENED"
}
local v_u4 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u5 = setmetatable({}, v_u4)
v_u5.__index = v_u5
function v_u5.new()
	-- upvalues: (copy) v_u4, (copy) v_u5, (copy) v_u1
	local v_new = v_u4.new()
	local v1 = setmetatable(v_new, v_u5)
	v1.parentUIFrame = nil
	v1.jumpButton = nil
	v1.externallyEnabled = false
	v1.isJumping = false
	v1._active = false
	v1._connectionUtil = v_u1.new()
	return v1
end
function v_u5._reset(arg1)
	arg1.isJumping = false
	arg1.touchObject = nil
	if arg1.jumpButton then
		arg1.jumpButton.ImageRectOffset = Vector2.new(1, 146)
	end
end
function v_u5.EnableButton(arg1, arg2)
	-- upvalues: (copy) v_u3, (copy) v_u_gui
	if arg2 == arg1._active then
		arg1:_reset()
	else
		if arg2 then
			if not arg1.jumpButton then
				arg1:Create()
			end
			arg1.jumpButton.Visible = false
			arg1._connectionUtil:trackConnection(v_u3.JUMP_INPUT_ENDED, arg1.jumpButton.InputEnded:Connect(function(arg1)
				-- upvalues: (copy) arg1
				if arg1 == arg1.touchObject then
					arg1:_reset()
				end
			end))
			arg1._connectionUtil:trackConnection(v_u3.MENU_OPENED, v_u_gui.MenuOpened:Connect(function()
				-- upvalues: (copy) arg1
				if arg1.touchObject then
					arg1:_reset()
				end
			end))
		else
			if arg1.jumpButton then
				arg1.jumpButton.Visible = false
			end
			arg1._connectionUtil:disconnect(v_u3.JUMP_INPUT_ENDED)
			arg1._connectionUtil:disconnect(v_u3.MENU_OPENED)
		end
		arg1:_reset()
		arg1._active = arg2
	end
end
function v_u5.UpdateEnabled(arg1)
	-- upvalues: (copy) v_u2
	local v_humanoid = v_u2.getChild("Humanoid", "Humanoid")
	if v_humanoid and (arg1.externallyEnabled and (v_humanoid.JumpPower > 0 and v_humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping))) then
		arg1:EnableButton(true)
	else
		arg1:EnableButton(false)
	end
end
function v_u5._setupConfigurations(self)
	-- upvalues: (copy) v_u2, (copy) v_u3
	local function v_u1()
		-- upvalues: (copy) self
		self:UpdateEnabled()
	end
	local v_humanoid = v_u2.onChild("Humanoid", "Humanoid", function(arg1)
		-- upvalues: (copy) self, (ref) v_u3, (copy) v_u1
		self:UpdateEnabled()
		self._connectionUtil:trackConnection(v_u3.HUMANOID_JUMP_POWER, arg1:GetPropertyChangedSignal("JumpPower"):Connect(v_u1))
		self._connectionUtil:trackConnection(v_u3.HUMANOID_STATE_ENABLED_CHANGED, arg1.StateEnabledChanged:Connect(function(arg1, arg2)
			-- upvalues: (ref) self
			if arg1 == Enum.HumanoidStateType.Jumping and arg2 ~= self._active then
				self:UpdateEnabled()
			end
		end))
	end)
	self._connectionUtil:trackConnection(v_u3.HUMANOID, v_humanoid)
end
function v_u5.Enable(arg1, arg2, arg3)
	if arg3 then
		arg1.parentUIFrame = arg3
	end
	if arg1.externallyEnabled == arg2 then
		return
	else
		arg1.externallyEnabled = arg2
		arg1:UpdateEnabled()
		if arg2 then
			arg1:_setupConfigurations()
		else
			arg1._connectionUtil:disconnectAll()
		end
	end
end
function v_u5.Create(self)
	if self.parentUIFrame then
		if self.jumpButton then
			self.jumpButton:Destroy()
			self.jumpButton = nil
		end
		if self.absoluteSizeChangedConn then
			self.absoluteSizeChangedConn:Disconnect()
			self.absoluteSizeChangedConn = nil
		end
		self.jumpButton = Instance.new("ImageButton")
		self.jumpButton.Name = "JumpButton"
		self.jumpButton.Visible = false
		self.jumpButton.BackgroundTransparency = 1
		self.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
		self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
		self.jumpButton.ImageRectSize = Vector2.new(144, 144)
		local function v1()
			-- upvalues: (copy) self
			local v1 = math.min(self.parentUIFrame.AbsoluteSize.x, self.parentUIFrame.AbsoluteSize.y) <= 500
			local v2 = v1 and 70 or 120
			self.jumpButton.Size = UDim2.new(0, v2, 0, v2)
			self.jumpButton.Position = v1 and UDim2.new(1, -(v2 * 1.5 - 10), 1, -v2 - 20) or UDim2.new(1, -(v2 * 1.5 - 10), 1, -v2 * 1.75)
		end
		v1()
		self.absoluteSizeChangedConn = self.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(v1)
		self.touchObject = nil
		self.jumpButton.InputBegan:connect(function(arg1)
			-- upvalues: (copy) self
			if not self.touchObject and (arg1.UserInputType == Enum.UserInputType.Touch and arg1.UserInputState == Enum.UserInputState.Begin) then
				self.touchObject = arg1
				self.jumpButton.ImageRectOffset = Vector2.new(146, 146)
				self.isJumping = true
			end
		end)
		self.jumpButton.Parent = self.parentUIFrame
	end
end
return v_u5