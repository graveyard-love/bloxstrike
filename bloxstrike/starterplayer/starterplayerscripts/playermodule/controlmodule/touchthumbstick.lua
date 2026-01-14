-- Decompiled with Bunni.lol Decompiler

game:GetService("Players")
local v_u_gui = game:GetService("GuiService")
local v_u_userinput = game:GetService("UserInputService")
UserSettings():GetService("UserGameSettings")
local v_u1 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u2 = setmetatable({}, v_u1)
v_u2.__index = v_u2
function v_u2.new()
	-- upvalues: (copy) v_u1, (copy) v_u2
	local v_new = v_u1.new()
	local v1 = setmetatable(v_new, v_u2)
	v1.isFollowStick = false
	v1.thumbstickFrame = nil
	v1.moveTouchObject = nil
	v1.onTouchMovedConn = nil
	v1.onTouchEndedConn = nil
	v1.screenPos = nil
	v1.stickImage = nil
	v1.thumbstickSize = nil
	return v1
end
function v_u2.Enable(arg1, arg2, arg3)
	if arg2 == nil then
		return false
	end
	local v1 = arg2 and true or false
	if arg1.enabled == v1 then
		return true
	end
	arg1.moveVector = Vector3.new(0, 0, 0)
	arg1.isJumping = false
	if v1 then
		if not arg1.thumbstickFrame then
			arg1:Create(arg3)
		end
		arg1.thumbstickFrame.Visible = true
	else
		arg1.thumbstickFrame.Visible = false
		arg1:OnInputEnded()
	end
	arg1.enabled = v1
end
function v_u2.OnInputEnded(arg1)
	arg1.thumbstickFrame.Position = arg1.screenPos
	arg1.stickImage.Position = UDim2.new(0, arg1.thumbstickFrame.Size.X.Offset / 2 - arg1.thumbstickSize / 4, 0, arg1.thumbstickFrame.Size.Y.Offset / 2 - arg1.thumbstickSize / 4)
	arg1.moveVector = Vector3.new(0, 0, 0)
	arg1.isJumping = false
	arg1.thumbstickFrame.Position = arg1.screenPos
	arg1.moveTouchObject = nil
end
function v_u2.Create(arg1, arg2)
	-- upvalues: (copy) v_u_userinput, (copy) v_u_gui
	if arg1.thumbstickFrame then
		arg1.thumbstickFrame:Destroy()
		arg1.thumbstickFrame = nil
		if arg1.onTouchMovedConn then
			arg1.onTouchMovedConn:Disconnect()
			arg1.onTouchMovedConn = nil
		end
		if arg1.onTouchEndedConn then
			arg1.onTouchEndedConn:Disconnect()
			arg1.onTouchEndedConn = nil
		end
		if arg1.absoluteSizeChangedConn then
			arg1.absoluteSizeChangedConn:Disconnect()
			arg1.absoluteSizeChangedConn = nil
		end
	end
	arg1.thumbstickFrame = Instance.new("Frame")
	arg1.thumbstickFrame.Name = "ThumbstickFrame"
	arg1.thumbstickFrame.Active = true
	arg1.thumbstickFrame.Visible = false
	arg1.thumbstickFrame.BackgroundTransparency = 1
	local v_u_imagelabel = Instance.new("ImageLabel")
	v_u_imagelabel.Name = "OuterImage"
	v_u_imagelabel.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
	v_u_imagelabel.ImageRectOffset = Vector2.new()
	v_u_imagelabel.ImageRectSize = Vector2.new(220, 220)
	v_u_imagelabel.BackgroundTransparency = 1
	v_u_imagelabel.Position = UDim2.new(0, 0, 0, 0)
	arg1.stickImage = Instance.new("ImageLabel")
	arg1.stickImage.Name = "StickImage"
	arg1.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
	arg1.stickImage.ImageRectOffset = Vector2.new(220, 0)
	arg1.stickImage.ImageRectSize = Vector2.new(111, 111)
	arg1.stickImage.BackgroundTransparency = 1
	arg1.stickImage.ZIndex = 2
	local function v1()
		-- upvalues: (copy) arg2, (copy) arg1, (copy) v_u_imagelabel
		local v1 = math.min(arg2.AbsoluteSize.X, arg2.AbsoluteSize.Y) <= 500
		arg1.thumbstickSize = v1 and 70 or 120
		arg1.screenPos = v1 and UDim2.new(0, arg1.thumbstickSize / 2 - 10, 1, -arg1.thumbstickSize - 20) or UDim2.new(0, arg1.thumbstickSize / 2, 1, -arg1.thumbstickSize * 1.75)
		arg1.thumbstickFrame.Size = UDim2.new(0, arg1.thumbstickSize, 0, arg1.thumbstickSize)
		arg1.thumbstickFrame.Position = arg1.screenPos
		v_u_imagelabel.Size = UDim2.new(0, arg1.thumbstickSize, 0, arg1.thumbstickSize)
		arg1.stickImage.Size = UDim2.new(0, arg1.thumbstickSize / 2, 0, arg1.thumbstickSize / 2)
		arg1.stickImage.Position = UDim2.new(0, arg1.thumbstickSize / 2 - arg1.thumbstickSize / 4, 0, arg1.thumbstickSize / 2 - arg1.thumbstickSize / 4)
	end
	v1()
	arg1.absoluteSizeChangedConn = arg2:GetPropertyChangedSignal("AbsoluteSize"):Connect(v1)
	v_u_imagelabel.Parent = arg1.thumbstickFrame
	arg1.stickImage.Parent = arg1.thumbstickFrame
	local v_u2 = nil
	local function v_u3(arg1)
		-- upvalues: (ref) v_u2, (copy) arg1
		local v_new = Vector2.new(arg1.X - v_u2.X, arg1.Y - v_u2.Y)
		local v_magnitude = v_new.magnitude
		local v1 = arg1.thumbstickFrame.AbsoluteSize.X / 2
		if arg1.isFollowStick and v1 < v_magnitude then
			local v2 = v_new.unit * v1
			arg1.thumbstickFrame.Position = UDim2.new(0, arg1.X - arg1.thumbstickFrame.AbsoluteSize.X / 2 - v2.X, 0, arg1.Y - arg1.thumbstickFrame.AbsoluteSize.Y / 2 - v2.Y)
		else
			local v_min = math.min(v_magnitude, v1)
			v_new = v_new.unit * v_min
		end
		arg1.stickImage.Position = UDim2.new(0, v_new.X + arg1.stickImage.AbsoluteSize.X / 2, 0, v_new.Y + arg1.stickImage.AbsoluteSize.Y / 2)
	end
	arg1.thumbstickFrame.InputBegan:Connect(function(arg1)
		-- upvalues: (copy) arg1, (ref) v_u2
		if not arg1.moveTouchObject and (arg1.UserInputType == Enum.UserInputType.Touch and arg1.UserInputState == Enum.UserInputState.Begin) then
			arg1.moveTouchObject = arg1
			arg1.thumbstickFrame.Position = UDim2.new(0, arg1.Position.X - arg1.thumbstickFrame.Size.X.Offset / 2, 0, arg1.Position.Y - arg1.thumbstickFrame.Size.Y.Offset / 2)
			v_u2 = Vector2.new(arg1.thumbstickFrame.AbsolutePosition.X + arg1.thumbstickFrame.AbsoluteSize.X / 2, arg1.thumbstickFrame.AbsolutePosition.Y + arg1.thumbstickFrame.AbsoluteSize.Y / 2)
			Vector2.new(arg1.Position.X - v_u2.X, arg1.Position.Y - v_u2.Y)
		end
	end)
	arg1.onTouchMovedConn = v_u_userinput.TouchMoved:Connect(function(arg1, _)
		-- upvalues: (copy) arg1, (ref) v_u2, (copy) v_u3
		if arg1 == arg1.moveTouchObject then
			v_u2 = Vector2.new(arg1.thumbstickFrame.AbsolutePosition.X + arg1.thumbstickFrame.AbsoluteSize.X / 2, arg1.thumbstickFrame.AbsolutePosition.Y + arg1.thumbstickFrame.AbsoluteSize.Y / 2)
			local v1
			if (Vector2.new(arg1.Position.X - v_u2.X, arg1.Position.Y - v_u2.Y) / (arg1.thumbstickSize / 2)).magnitude < 0.05 then
				v1 = Vector3.new()
			else
				local v2 = UNNAMED_1728994285704.unit * math.min(1, (UNNAMED_1728994285800 - 0.05) / 0.95)
				v1 = Vector3.new(v2.X, 0, v2.Y)
			end
			arg1.moveVector = v1
			v_u3(arg1.Position)
		end
	end)
	arg1.onTouchEndedConn = v_u_userinput.TouchEnded:Connect(function(arg1, _)
		-- upvalues: (copy) arg1
		if arg1 == arg1.moveTouchObject then
			arg1:OnInputEnded()
		end
	end)
	v_u_gui.MenuOpened:Connect(function()
		-- upvalues: (copy) arg1
		if arg1.moveTouchObject then
			arg1:OnInputEnded()
		end
	end)
	arg1.thumbstickFrame.Parent = arg2
end
return v_u2