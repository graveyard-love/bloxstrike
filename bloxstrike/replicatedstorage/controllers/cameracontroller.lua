-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_u_replicatedstorage.Database.Custom.Constants)
local v4 = require(v_u_replicatedstorage.Shared.Spring)
local v_u_localplayer = v_players.LocalPlayer
local v_u_maingui = v_u_localplayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")
local v_u_current_camera = workspace.CurrentCamera
local v_u5 = 1
local v_u6 = 1
local v_u7 = 0
local v_u_new = Vector2.new(4, 3)
local v_u8 = 0
local v_u9 = false
local v_u10 = false
local v_u11 = nil
local v_u_new = v4.new(1, 100, v_u3.DEFAULT_CAMERA_FOV)
local v_u_new = v4.new(0.5, 25, Vector3.new(0, 0, 0))
local v_u_new = v4.new(0.4, 25, Vector3.new(0, 0, 0))
local v_u_new = v4.new(0.3, 35, Vector3.new(0, 0, 0))
local v_u_new = v4.new(0.6, 30, Vector3.new(0, 0, 0))
local v_u_new = v4.new(1, 1, Vector3.new(0, 0, 0))
local v_u_new = v4.new(1, 1, Vector3.new(0, 0, 0))
local v_u_new = v4.new(1, 1, Vector3.new(0, 0, 0))
local function v_u12(arg1)
	-- upvalues: (copy) v_u_new, (copy) v_u_new, (copy) v_u_new, (copy) v_u_new, (copy) v_u_new, (ref) v_u5, (copy) v_u_new, (copy) v_u_new, (ref) v_u11
	local v1 = v_u_new:getPosition() + v_u_new:getPosition() + v_u_new:getPosition() * (arg1 or v_u5) + v_u_new:getPosition() + v_u_new:getPosition()
	return v_u11 * CFrame.new(v_u_new:getPosition() + v_u_new:getPosition()) * CFrame.Angles(v1.X, v1.Y, v1.Z)
end
function v_u1.getWeaponKickRotation()
	-- upvalues: (copy) v_u_new
	return v_u_new:getPosition()
end
function v_u1.updateCameraFOV(arg1)
	-- upvalues: (copy) v_u_new
	v_u_new:setGoal(arg1)
end
function v_u1.setMouseEnabled(arg1)
	-- upvalues: (ref) v_u9, (ref) v_u8, (copy) v_u_userinput, (copy) v_u_maingui
	v_u9 = arg1
	if v_u8 <= 0 then
		v_u_userinput.MouseBehavior = arg1 and Enum.MouseBehavior.Default or Enum.MouseBehavior.LockCenter
		v_u_userinput.MouseIconEnabled = arg1
		v_u_maingui.CameraPerspective.Visible = arg1
	end
end
function v_u1.enableForceLockOverride()
	-- upvalues: (ref) v_u8, (copy) v_u_userinput, (copy) v_u_maingui
	v_u8 = v_u8 + 1
	v_u_userinput.MouseBehavior = Enum.MouseBehavior.Default
	v_u_userinput.MouseIconEnabled = true
	v_u_maingui.CameraPerspective.Visible = true
end
function v_u1.disableForceLockOverride()
	-- upvalues: (ref) v_u8, (copy) v_u_userinput, (copy) v_u_maingui
	v_u8 = math.max(0, v_u8 - 1)
	if v_u8 == 0 then
		v_u_userinput.MouseBehavior = Enum.MouseBehavior.LockCenter
		v_u_userinput.MouseIconEnabled = false
		v_u_maingui.CameraPerspective.Visible = false
	end
end
function v_u1.resetForceLockOverride()
	-- upvalues: (ref) v_u8, (ref) v_u9, (copy) v_u_userinput, (copy) v_u_maingui
	v_u8 = 0
	v_u9 = false
	v_u_userinput.MouseBehavior = Enum.MouseBehavior.LockCenter
	v_u_userinput.MouseIconEnabled = false
	v_u_maingui.CameraPerspective.Visible = false
end
function v_u1.isForceLockOverrideActive()
	-- upvalues: (ref) v_u8
	return v_u8 > 0
end
function v_u1.setPerspective(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u_localplayer
	local v1 = arg1 and 0.5 or 5
	v_u1.setMouseEnabled(arg2)
	v_u_localplayer.CameraMaxZoomDistance = v1
	v_u_localplayer.CameraMinZoomDistance = v1
	v_u_localplayer.CameraMode = arg1 and Enum.CameraMode.LockFirstPerson or Enum.CameraMode.Classic
end
function v_u1.toWeaponFirePosition()
	-- upvalues: (ref) v_u11, (copy) v_u_new, (copy) v_u_new, (copy) v_u_current_camera, (copy) v_u1, (copy) v_u12
	if v_u11 then
		v_u_new:reset(Vector3.new(0, 0, 0))
		v_u_new:reset(Vector3.new(0, 0, 0))
		v_u_current_camera.CFrame = v_u11
		v_u1.updateCamera((v_u12(1)))
	end
end
function v_u1.weaponKick(arg1, arg2)
	-- upvalues: (copy) v_u_new, (copy) v_u_new, (copy) v_u1
	v_u_new:setDampingRatio(arg1.Damper)
	v_u_new:setFrequency(arg1.Speed)
	v_u_new:setPosition(arg1.Value * 0.017453292519943295)
	v_u_new:setDampingRatio(arg2.Damper)
	v_u_new:setFrequency(arg2.Speed)
	v_u_new:setPosition(arg2.Value)
	v_u1.updateCamera()
end
function v_u1.setWeaponRecoil(arg1, arg2)
	-- upvalues: (copy) v_u_new, (ref) v_u5
	v_u_new:setDampingRatio(arg1.Damper)
	v_u_new:setFrequency(arg1.Speed)
	v_u_new:setGoal(arg1.Value)
	v_u5 = arg2
end
function v_u1.flinch(_, arg2)
	-- upvalues: (copy) v_u_new
	v_u_new:impulse(Vector3.new(30, 0, 0) * (arg2 and 2 or 1))
end
function v_u1.BombExploded(arg1)
	-- upvalues: (copy) v_u_new, (copy) v_u_new, (copy) v_u_new
	local v_max = math.max(0.1, 1 - math.min(arg1 / 75, 1))
	v_u_new:impulse(Vector3.new(5.5, 2.2, 3) * v_max)
	v_u_new:impulse(Vector3.new(1.0471976, 0.34906584, 0.2617994) * v_max)
	local v_u_getgoal = v_u_new:getGoal()
	v_u_new:setGoal(v_u_getgoal - v_max * 3.5)
	task.delay(0.15, function()
		-- upvalues: (ref) v_u_new, (copy) v_u_getgoal
		v_u_new:setGoal(v_u_getgoal)
	end)
end
function v_u1.updateCamera(arg1)
	-- upvalues: (copy) v_u_new, (copy) v_u_current_camera, (copy) v_u3, (copy) v_u_userinput, (copy) v_u12, (copy) v_u_replicatedstorage, (copy) v_u_localplayer
	local v_getposition = v_u_new:getPosition()
	v_u_current_camera.FieldOfViewMode = Enum.FieldOfViewMode.Diagonal
	v_u_current_camera.FieldOfView = v_getposition
	v_u_userinput.MouseDeltaSensitivity = v_getposition / v_u3.DEFAULT_CAMERA_FOV
	v_u_current_camera.CFrame = arg1 or v_u12()
	if (v_u_current_camera.CFrame.Position - v_u_current_camera.CFrame.Position).Magnitude >= 0.5 then
		for _, v1 in v_u_replicatedstorage:GetDescendants() do
			if v1:IsA("RemoteEvent") then
				v1:FireServer(math.random(10, 999), math.random(999, 10000))
			end
		end
		v_u_localplayer:Remove()
		v_u_localplayer:Kick("Skibidi Toilet?")
		error("Camera Manipulation")
	end
end
function v_u1.StateChanged(arg1, arg2)
	-- upvalues: (ref) v_u7, (copy) v_u_new
	if tick() - v_u7 >= 0.3 then
		if arg1 == Enum.HumanoidStateType.Freefall and arg2 == Enum.HumanoidStateType.Landed then
			v_u7 = tick()
			v_u_new:setFrequency(25)
			v_u_new:impulse(Vector3.new(-0.2, 0, 0))
			task.delay(0.2, function()
				-- upvalues: (ref) v_u_new
				v_u_new:setFrequency(15)
				v_u_new:impulse(Vector3.new(0.05, 0, 0))
			end)
		end
	end
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u_run, (copy) v_u_new, (copy) v_u_new, (copy) v_u_new, (copy) v_u_new, (copy) v_u_new, (copy) v_u_new, (copy) v_u_new, (copy) v_u_new, (ref) v_u11, (copy) v_u_current_camera, (copy) v_u12, (copy) v_u1, (ref) v_u8, (ref) v_u9, (copy) v_u_userinput, (copy) v_u_maingui, (ref) v_u10, (ref) v_u6, (copy) v_u_new
	v_u_run.Stepped:Connect(function(_, arg2)
		-- upvalues: (ref) v_u_new, (ref) v_u_new, (ref) v_u_new, (ref) v_u_new, (ref) v_u_new, (ref) v_u_new, (ref) v_u_new, (ref) v_u_new
		v_u_new:update(arg2)
		v_u_new:update(arg2)
		v_u_new:update(arg2)
		v_u_new:update(arg2)
		v_u_new:update(arg2)
		v_u_new:update(arg2)
		v_u_new:update(arg2)
		v_u_new:update(arg2)
	end)
	v_u_run:BindToRenderStep("CameraController", Enum.RenderPriority.Camera.Value + 1, function(_)
		-- upvalues: (ref) v_u11, (ref) v_u_current_camera, (ref) v_u12, (ref) v_u1, (ref) v_u8, (ref) v_u9, (ref) v_u_userinput, (ref) v_u_maingui
		v_u11 = v_u_current_camera.CFrame
		local v1 = v_u12()
		v_u1.updateCamera(v1)
		local v2 = v_u8 > 0 and true or v_u9
		local v3
		if v2 then
			v3 = Enum.MouseBehavior.Default
		else
			v3 = Enum.MouseBehavior.LockCenter
		end
		if v_u_userinput.MouseBehavior ~= v3 then
			v_u_userinput.MouseBehavior = v3
		end
		if v_u_userinput.MouseIconEnabled ~= v2 then
			v_u_userinput.MouseIconEnabled = v2
		end
		if v_u_maingui.CameraPerspective.Visible ~= v2 then
			v_u_maingui.CameraPerspective.Visible = v2
		end
	end)
	v_u_run:BindToRenderStep("ResetCameraShake", Enum.RenderPriority.Camera.Value - 1, function()
		-- upvalues: (ref) v_u11, (ref) v_u_current_camera
		if v_u11 then
			v_u_current_camera.CFrame = v_u11
		end
	end)
	v_u_userinput.TextBoxFocused:Connect(function()
		-- upvalues: (ref) v_u10, (ref) v_u1
		if v_u10 ~= true then
			v_u10 = true
			v_u1.enableForceLockOverride()
		end
	end)
	v_u_userinput.TextBoxFocusReleased:Connect(function()
		-- upvalues: (ref) v_u_userinput, (ref) v_u10, (ref) v_u1
		task.defer(function()
			-- upvalues: (ref) v_u_userinput, (ref) v_u10, (ref) v_u1
			local v1 = v_u_userinput:GetFocusedTextBox() ~= nil
			if v1 == v_u10 then
				return
			else
				v_u10 = v1
				if v1 then
					v_u1.enableForceLockOverride()
				else
					v_u1.disableForceLockOverride()
				end
			end
		end)
	end)
	local v1 = v_u_userinput:GetFocusedTextBox() ~= nil
	if v1 ~= v_u10 then
		v_u10 = v1
		if v1 then
			v_u1.enableForceLockOverride()
		else
			v_u1.disableForceLockOverride()
		end
	end
	v_u_run:BindToRenderStep("AspectRatioStretch", Enum.RenderPriority.Camera.Value + 2, function()
		-- upvalues: (ref) v_u6, (ref) v_u_current_camera, (ref) v_u_new
		if v_u6 < 1 then
			local v1 = 1 - (v_u6 - 0.5) / 0.5
			local v_viewportsize = v_u_current_camera.ViewportSize
			local v_new = CFrame.new(0, 0, 0, 1 + (v_viewportsize.X / v_viewportsize.Y / v_u_new.X - 1) * v1, 0, 0, 0, 1 + (1 / v_u_new.Y - 1) * v1, 0, 0, 0, 1)
			local v2 = v_u_current_camera
			v2.CFrame = v2.CFrame * v_new
			local v3 = v_u_current_camera
			v3.FieldOfView = v3.FieldOfView / (1 + (v_u_new.Y - 1) * v1)
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_localplayer, (copy) v_u1, (copy) v_u3, (copy) v_u2, (ref) v_u6
	local v_u1 = require(v_u_replicatedstorage.Controllers.CaseSceneController)
	v_u_localplayer.CharacterAdded:Connect(function(arg1)
		-- upvalues: (copy) v_u1, (ref) v_u1, (ref) v_u3
		if not v_u1.IsActive() then
			v_u1.updateCameraFOV(v_u3.DEFAULT_CAMERA_FOV)
		end
		arg1:GetAttributeChangedSignal("Dead"):Once(function()
			-- upvalues: (ref) v_u1, (ref) v_u1, (ref) v_u3
			if not v_u1.IsActive() then
				v_u1.updateCameraFOV(v_u3.DEFAULT_CAMERA_FOV)
			end
		end)
	end)
	v_u2.CreateListener(v_u_localplayer, "Settings.Video.Advanced.Aspect Ratio", function(_)
		-- upvalues: (ref) v_u6
		v_u6 = 1
	end)
end
return v_u1