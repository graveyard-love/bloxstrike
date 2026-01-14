-- Decompiled with Bunni.lol Decompiler

local v_u_value = Enum.ContextActionPriority.High.Value
local v_u1 = {
	0.10999999999999999,
	0.30000000000000004,
	0.4,
	0.5,
	0.6,
	0.7,
	0.75
}
local v_u2 = #v_u1
local v_u_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local v_players = game:GetService("Players")
local v_u_gui = game:GetService("GuiService")
local v_u_userinput = game:GetService("UserInputService")
local v_u_contextaction = game:GetService("ContextActionService")
local v_u_run = game:GetService("RunService")
local v_u_tween = game:GetService("TweenService")
local v3, v4 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickMoveOverButtons2")
end)
local v_u5 = v3 and v4
local v6, v7 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate")
end)
local v_u8 = v6 and v7
local v_u_localplayer = v_players.LocalPlayer
if not v_u_localplayer then
	v_players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	v_u_localplayer = v_players.LocalPlayer
end
local v_u9 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u10 = setmetatable({}, v_u9)
v_u10.__index = v_u10
function v_u10.new()
	-- upvalues: (copy) v_u9, (copy) v_u10
	local v_new = v_u9.new()
	local v1 = setmetatable(v_new, v_u10)
	v1.moveTouchObject = nil
	v1.moveTouchLockedIn = false
	v1.moveTouchFirstChanged = false
	v1.moveTouchStartPosition = nil
	v1.startImage = nil
	v1.endImage = nil
	v1.middleImages = {}
	v1.startImageFadeTween = nil
	v1.endImageFadeTween = nil
	v1.middleImageFadeTweens = {}
	v1.isFirstTouch = true
	v1.thumbstickFrame = nil
	v1.onRenderSteppedConn = nil
	v1.fadeInAndOutBalance = 0.5
	v1.fadeInAndOutHalfDuration = 0.3
	v1.hasFadedBackgroundInPortrait = false
	v1.hasFadedBackgroundInLandscape = false
	v1.tweenInAlphaStart = nil
	v1.tweenOutAlphaStart = nil
	return v1
end
function v_u10.GetIsJumping(arg1)
	arg1.isJumping = false
	return arg1.isJumping
end
function v_u10.Enable(arg1, arg2, arg3)
	-- upvalues: (ref) v_u5, (copy) v_u_contextaction
	if arg2 == nil then
		return false
	end
	local v1 = arg2 and true or false
	if arg1.enabled == v1 then
		return true
	end
	if v1 then
		if not arg1.thumbstickFrame then
			arg1:Create(arg3)
		end
		arg1:BindContextActions()
	else
		if v_u5 then
			arg1:UnbindContextActions()
		else
			v_u_contextaction:UnbindAction("DynamicThumbstickAction")
		end
		arg1:OnInputEnded()
	end
	arg1.enabled = v1
	arg1.thumbstickFrame.Visible = v1
	return nil
end
function v_u10.OnInputEnded(arg1)
	arg1.moveTouchObject = nil
	arg1.moveVector = Vector3.new(0, 0, 0)
	arg1:FadeThumbstick(false)
end
function v_u10.FadeThumbstick(arg1, arg2)
	-- upvalues: (copy) v_u_tween, (copy) v_u_new, (copy) v_u1
	if arg2 or not arg1.moveTouchObject then
		if arg1.isFirstTouch then
			return
		else
			if arg1.startImageFadeTween then
				arg1.startImageFadeTween:Cancel()
			end
			if arg1.endImageFadeTween then
				arg1.endImageFadeTween:Cancel()
			end
			for v1 = 1, #arg1.middleImages do
				if arg1.middleImageFadeTweens[v1] then
					arg1.middleImageFadeTweens[v1]:Cancel()
				end
			end
			if arg2 then
				arg1.startImageFadeTween = v_u_tween:Create(arg1.startImage, v_u_new, {
					["ImageTransparency"] = 0
				})
				arg1.startImageFadeTween:Play()
				arg1.endImageFadeTween = v_u_tween:Create(arg1.endImage, v_u_new, {
					["ImageTransparency"] = 0.2
				})
				arg1.endImageFadeTween:Play()
				for v2 = 1, #arg1.middleImages do
					arg1.middleImageFadeTweens[v2] = v_u_tween:Create(arg1.middleImages[v2], v_u_new, {
						["ImageTransparency"] = v_u1[v2]
					})
					arg1.middleImageFadeTweens[v2]:Play()
				end
			else
				arg1.startImageFadeTween = v_u_tween:Create(arg1.startImage, v_u_new, {
					["ImageTransparency"] = 1
				})
				arg1.startImageFadeTween:Play()
				arg1.endImageFadeTween = v_u_tween:Create(arg1.endImage, v_u_new, {
					["ImageTransparency"] = 1
				})
				arg1.endImageFadeTween:Play()
				for v3 = 1, #arg1.middleImages do
					arg1.middleImageFadeTweens[v3] = v_u_tween:Create(arg1.middleImages[v3], v_u_new, {
						["ImageTransparency"] = 1
					})
					arg1.middleImageFadeTweens[v3]:Play()
				end
			end
		end
	else
		return
	end
end
function v_u10.FadeThumbstickFrame(arg1, arg2, arg3)
	arg1.fadeInAndOutHalfDuration = arg2 * 0.5
	arg1.fadeInAndOutBalance = arg3
	arg1.tweenInAlphaStart = tick()
end
function v_u10.InputInFrame(arg1, arg2)
	local v_absoluteposition = arg1.thumbstickFrame.AbsolutePosition
	local v1 = v_absoluteposition + arg1.thumbstickFrame.AbsoluteSize
	local v_position = arg2.Position
	return v_position.X >= v_absoluteposition.X and (v_position.Y >= v_absoluteposition.Y and (v_position.X <= v1.X and v_position.Y <= v1.Y))
end
function v_u10.DoFadeInBackground(arg1)
	-- upvalues: (ref) v_u_localplayer
	local v_playergui = v_u_localplayer:FindFirstChildOfClass("PlayerGui")
	local v1 = false
	if v_playergui then
		if v_playergui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or v_playergui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
			v1 = arg1.hasFadedBackgroundInLandscape
			arg1.hasFadedBackgroundInLandscape = true
		elseif v_playergui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
			v1 = arg1.hasFadedBackgroundInPortrait
			arg1.hasFadedBackgroundInPortrait = true
		end
	end
	if not v1 then
		arg1.fadeInAndOutHalfDuration = 0.3
		arg1.fadeInAndOutBalance = 0.5
		arg1.tweenInAlphaStart = tick()
	end
end
function v_u10.DoMove(arg1, arg2)
	local v1
	if arg2.Magnitude < arg1.radiusOfDeadZone then
		v1 = Vector3.new(0, 0, 0)
	else
		local v2 = arg2.Unit * (1 - math.max(0, (arg1.radiusOfMaxSpeed - arg2.Magnitude) / arg1.radiusOfMaxSpeed))
		v1 = Vector3.new(v2.X, 0, v2.Y)
	end
	arg1.moveVector = v1
end
function v_u10.LayoutMiddleImages(arg1, arg2, arg3)
	-- upvalues: (copy) v_u2
	local v1 = arg1.thumbstickSize / 2 + arg1.middleSize
	local v2 = arg3 - arg2
	local v3 = v2.Magnitude - arg1.thumbstickRingSize / 2 - arg1.middleSize
	local v_unit = v2.Unit
	local v_middlespacing = arg1.middleSpacing
	if arg1.middleSpacing * v_u2 < v3 then
		v_middlespacing = v3 / v_u2
	end
	for v4 = 1, v_u2 do
		local v5 = arg1.middleImages[v4]
		local v6 = v1 + v_middlespacing * (v4 - 1)
		if v1 + v_middlespacing * (v4 - 2) < v3 then
			local v7 = arg3 - v_unit * v6
			local v_clamp = math.clamp(1 - (v6 - v3) / v_middlespacing, 0, 1)
			v5.Visible = true
			v5.Position = UDim2.new(0, v7.X, 0, v7.Y)
			v5.Size = UDim2.new(0, arg1.middleSize * v_clamp, 0, arg1.middleSize * v_clamp)
		else
			v5.Visible = false
		end
	end
end
function v_u10.MoveStick(arg1, arg2)
	local v1 = Vector2.new(arg2.X, arg2.Y) - arg1.thumbstickFrame.AbsolutePosition
	arg1.endImage.Position = UDim2.new(0, v1.X, 0, v1.Y)
	arg1:LayoutMiddleImages(Vector2.new(arg1.moveTouchStartPosition.X, arg1.moveTouchStartPosition.Y) - arg1.thumbstickFrame.AbsolutePosition, v1)
end
function v_u10.BindContextActions(self)
	-- upvalues: (copy) v_u_tween, (ref) v_u5, (copy) v_u_contextaction, (copy) v_u_value, (copy) v_u_userinput
	local function v_u1(arg1)
		-- upvalues: (copy) self, (ref) v_u_tween
		if self.moveTouchObject then
			return Enum.ContextActionResult.Pass
		end
		if not self:InputInFrame(arg1) then
			return Enum.ContextActionResult.Pass
		end
		if self.isFirstTouch then
			self.isFirstTouch = false
			local v_new = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
			v_u_tween:Create(self.startImage, v_new, {
				["Size"] = UDim2.new(0, 0, 0, 0)
			}):Play()
			v_u_tween:Create(self.endImage, v_new, {
				["Size"] = UDim2.new(0, self.thumbstickSize, 0, self.thumbstickSize),
				["ImageColor3"] = Color3.new(0, 0, 0)
			}):Play()
		end
		self.moveTouchLockedIn = false
		self.moveTouchObject = arg1
		self.moveTouchStartPosition = arg1.Position
		self.moveTouchFirstChanged = true
		self:DoFadeInBackground()
		return Enum.ContextActionResult.Pass
	end
	local function v_u2(arg1)
		-- upvalues: (copy) self
		if arg1 ~= self.moveTouchObject then
			return Enum.ContextActionResult.Pass
		end
		if self.moveTouchFirstChanged then
			self.moveTouchFirstChanged = false
			local v_new = Vector2.new(arg1.Position.X - self.thumbstickFrame.AbsolutePosition.X, arg1.Position.Y - self.thumbstickFrame.AbsolutePosition.Y)
			self.startImage.Visible = true
			self.startImage.Position = UDim2.new(0, v_new.X, 0, v_new.Y)
			self.endImage.Visible = true
			self.endImage.Position = self.startImage.Position
			self:FadeThumbstick(true)
			self:MoveStick(arg1.Position)
		end
		self.moveTouchLockedIn = true
		local v_new = Vector2.new(arg1.Position.X - self.moveTouchStartPosition.X, arg1.Position.Y - self.moveTouchStartPosition.Y)
		if math.abs(v_new.X) > 0 or math.abs(v_new.Y) > 0 then
			self:DoMove(v_new)
			self:MoveStick(arg1.Position)
		end
		return Enum.ContextActionResult.Sink
	end
	v_u_contextaction:BindActionAtPriority("DynamicThumbstickAction", function(_, arg2, arg3)
		-- upvalues: (copy) v_u1, (ref) v_u5, (copy) self, (copy) v_u2
		if arg2 == Enum.UserInputState.Begin then
			return v_u1(arg3)
		elseif arg2 == Enum.UserInputState.Change then
			if v_u5 then
				if arg3 == self.moveTouchObject then
					return Enum.ContextActionResult.Sink
				else
					return Enum.ContextActionResult.Pass
				end
			else
				return v_u2(arg3)
			end
		else
			if arg2 == Enum.UserInputState.End then
				if arg3 == self.moveTouchObject then
					self:OnInputEnded()
					if self.moveTouchLockedIn then
						return Enum.ContextActionResult.Sink
					end
				end
				return Enum.ContextActionResult.Pass
			end
			if arg2 == Enum.UserInputState.Cancel then
				self:OnInputEnded()
			end
			return
		end
	end, false, v_u_value, Enum.UserInputType.Touch)
	if v_u5 then
		self.TouchMovedCon = v_u_userinput.TouchMoved:Connect(function(arg1, _)
			-- upvalues: (copy) v_u2
			v_u2(arg1)
		end)
	end
end
function v_u10.UnbindContextActions(arg1)
	-- upvalues: (copy) v_u_contextaction
	v_u_contextaction:UnbindAction("DynamicThumbstickAction")
	if arg1.TouchMovedCon then
		arg1.TouchMovedCon:Disconnect()
	end
end
function v_u10.Create(arg1, arg2)
	-- upvalues: (ref) v_u8, (copy) v_u2, (copy) v_u1, (copy) v_u_run, (copy) v_u_userinput, (copy) v_u_gui, (ref) v_u_localplayer
	if arg1.thumbstickFrame then
		arg1.thumbstickFrame:Destroy()
		arg1.thumbstickFrame = nil
		if arg1.onRenderSteppedConn then
			arg1.onRenderSteppedConn:Disconnect()
			arg1.onRenderSteppedConn = nil
		end
		if arg1.absoluteSizeChangedConn then
			arg1.absoluteSizeChangedConn:Disconnect()
			arg1.absoluteSizeChangedConn = nil
		end
	end
	local v_u1 = v_u8 and 100 or 0
	local function v_u2(arg1)
		-- upvalues: (copy) arg1, (copy) v_u1
		if arg1 then
			arg1.thumbstickFrame.Size = UDim2.new(1, v_u1, 0.4, v_u1)
			arg1.thumbstickFrame.Position = UDim2.new(0, -v_u1, 0.6, 0)
		else
			arg1.thumbstickFrame.Size = UDim2.new(0.4, v_u1, 0.6666666666666666, v_u1)
			arg1.thumbstickFrame.Position = UDim2.new(0, -v_u1, 0.3333333333333333, 0)
		end
	end
	arg1.thumbstickFrame = Instance.new("Frame")
	arg1.thumbstickFrame.BorderSizePixel = 0
	arg1.thumbstickFrame.Name = "DynamicThumbstickFrame"
	arg1.thumbstickFrame.Visible = false
	arg1.thumbstickFrame.BackgroundTransparency = 1
	arg1.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	arg1.thumbstickFrame.Active = false
	v_u2(false)
	arg1.startImage = Instance.new("ImageLabel")
	arg1.startImage.Name = "ThumbstickStart"
	arg1.startImage.Visible = true
	arg1.startImage.BackgroundTransparency = 1
	arg1.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
	arg1.startImage.ImageRectOffset = Vector2.new(1, 1)
	arg1.startImage.ImageRectSize = Vector2.new(144, 144)
	arg1.startImage.ImageColor3 = Color3.new(0, 0, 0)
	arg1.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
	arg1.startImage.ZIndex = 10
	arg1.startImage.Parent = arg1.thumbstickFrame
	arg1.endImage = Instance.new("ImageLabel")
	arg1.endImage.Name = "ThumbstickEnd"
	arg1.endImage.Visible = true
	arg1.endImage.BackgroundTransparency = 1
	arg1.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
	arg1.endImage.ImageRectOffset = Vector2.new(1, 1)
	arg1.endImage.ImageRectSize = Vector2.new(144, 144)
	arg1.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
	arg1.endImage.ZIndex = 10
	arg1.endImage.Parent = arg1.thumbstickFrame
	for v3 = 1, v_u2 do
		arg1.middleImages[v3] = Instance.new("ImageLabel")
		arg1.middleImages[v3].Name = "ThumbstickMiddle"
		arg1.middleImages[v3].Visible = false
		arg1.middleImages[v3].BackgroundTransparency = 1
		arg1.middleImages[v3].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
		arg1.middleImages[v3].ImageRectOffset = Vector2.new(1, 1)
		arg1.middleImages[v3].ImageRectSize = Vector2.new(144, 144)
		arg1.middleImages[v3].ImageTransparency = v_u1[v3]
		arg1.middleImages[v3].AnchorPoint = Vector2.new(0.5, 0.5)
		arg1.middleImages[v3].ZIndex = 9
		arg1.middleImages[v3].Parent = arg1.thumbstickFrame
	end
	local function v4()
		-- upvalues: (copy) arg2, (copy) arg1, (copy) v_u1
		local v_absolutesize = arg2.AbsoluteSize
		if math.min(v_absolutesize.X, v_absolutesize.Y) > 500 then
			arg1.thumbstickSize = 90
			arg1.thumbstickRingSize = 40
			arg1.middleSize = 20
			arg1.middleSpacing = 28
			arg1.radiusOfDeadZone = 4
			arg1.radiusOfMaxSpeed = 40
		else
			arg1.thumbstickSize = 45
			arg1.thumbstickRingSize = 20
			arg1.middleSize = 10
			arg1.middleSpacing = 14
			arg1.radiusOfDeadZone = 2
			arg1.radiusOfMaxSpeed = 20
		end
		arg1.startImage.Position = UDim2.new(0, arg1.thumbstickRingSize * 3.3 + v_u1, 1, -arg1.thumbstickRingSize * 2.8 - v_u1)
		arg1.startImage.Size = UDim2.new(0, arg1.thumbstickRingSize * 3.7, 0, arg1.thumbstickRingSize * 3.7)
		arg1.endImage.Position = arg1.startImage.Position
		arg1.endImage.Size = UDim2.new(0, arg1.thumbstickSize * 0.8, 0, arg1.thumbstickSize * 0.8)
	end
	v4()
	arg1.absoluteSizeChangedConn = arg2:GetPropertyChangedSignal("AbsoluteSize"):Connect(v4)
	local v_u5 = nil
	local function v6()
		-- upvalues: (ref) v_u5, (copy) v_u2
		if v_u5 then
			v_u5:Disconnect()
			v_u5 = nil
		end
		local v_u_current_camera = workspace.CurrentCamera
		if v_u_current_camera then
			local function v1()
				-- upvalues: (copy) v_u_current_camera, (ref) v_u2
				local v_viewportsize = v_u_current_camera.ViewportSize
				v_u2(v_viewportsize.X < v_viewportsize.Y)
			end
			v_u5 = v_u_current_camera:GetPropertyChangedSignal("ViewportSize"):Connect(v1)
			local v_viewportsize = v_u_current_camera.ViewportSize
			v_u2(v_viewportsize.X < v_viewportsize.Y)
		end
	end
	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(v6)
	if workspace.CurrentCamera then
		v6()
	end
	arg1.moveTouchStartPosition = nil
	arg1.startImageFadeTween = nil
	arg1.endImageFadeTween = nil
	arg1.middleImageFadeTweens = {}
	arg1.onRenderSteppedConn = v_u_run.RenderStepped:Connect(function()
		-- upvalues: (copy) arg1
		if arg1.tweenInAlphaStart == nil then
			if arg1.tweenOutAlphaStart ~= nil then
				arg1.thumbstickFrame.BackgroundTransparency = math.min((tick() - arg1.tweenOutAlphaStart) / (arg1.fadeInAndOutHalfDuration * 2 - arg1.fadeInAndOutHalfDuration * 2 * arg1.fadeInAndOutBalance), 1) * 0.35 + 0.65
				if UNNAMED_1729002861464 < UNNAMED_1729002861704 then
					arg1.tweenOutAlphaStart = nil
				end
			end
		else
			arg1.thumbstickFrame.BackgroundTransparency = 1 - math.min((tick() - arg1.tweenInAlphaStart) / (arg1.fadeInAndOutHalfDuration * 2 * arg1.fadeInAndOutBalance), 1) * 0.35
			if UNNAMED_1729002855080 < UNNAMED_1729002857048 then
				arg1.tweenOutAlphaStart = tick()
				arg1.tweenInAlphaStart = nil
				return
			end
		end
	end)
	arg1.onTouchEndedConn = v_u_userinput.TouchEnded:connect(function(arg1)
		-- upvalues: (copy) arg1
		if arg1 == arg1.moveTouchObject then
			arg1:OnInputEnded()
		end
	end)
	v_u_gui.MenuOpened:connect(function()
		-- upvalues: (copy) arg1
		if arg1.moveTouchObject then
			arg1:OnInputEnded()
		end
	end)
	local v_u_playergui = v_u_localplayer:FindFirstChildOfClass("PlayerGui")
	while not v_u_playergui do
		v_u_localplayer.ChildAdded:wait()
		v_u_playergui = v_u_localplayer:FindFirstChildOfClass("PlayerGui")
	end
	local v_u7 = nil
	local v_u8 = v_u_playergui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft and true or v_u_playergui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight
	local _ = v_u_playergui:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function()
		-- upvalues: (copy) v_u8, (ref) v_u_playergui, (ref) v_u7, (copy) arg1
		if v_u8 and v_u_playergui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait or not v_u8 and v_u_playergui.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
			v_u7:disconnect()
			arg1.fadeInAndOutHalfDuration = 2.5
			arg1.fadeInAndOutBalance = 0.05
			arg1.tweenInAlphaStart = tick()
			if v_u8 then
				arg1.hasFadedBackgroundInPortrait = true
				return
			end
			arg1.hasFadedBackgroundInLandscape = true
		end
	end)
	arg1.thumbstickFrame.Parent = arg2
	if game:IsLoaded() then
		arg1.fadeInAndOutHalfDuration = 2.5
		arg1.fadeInAndOutBalance = 0.05
		arg1.tweenInAlphaStart = tick()
	else
		coroutine.wrap(function()
			-- upvalues: (copy) arg1
			game.Loaded:Wait()
			arg1.fadeInAndOutHalfDuration = 2.5
			arg1.fadeInAndOutBalance = 0.05
			arg1.tweenInAlphaStart = tick()
		end)()
	end
end
return v_u10