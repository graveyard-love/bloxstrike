-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.CameraController)
local v_u3 = require(v_replicatedstorage.Controllers.InputController)
local v_u4 = require(v_replicatedstorage.Shared.Janitor)
local v_u_current_camera = workspace.CurrentCamera
local v_u_new = Vector2.new(9.42477796076938, 5.497787143782138)
function v_u1.UpdateMovement(arg1, arg2)
	-- upvalues: (copy) v_u3
	local v1 = Vector3.new(0, 0, 0)
	if v_u3.isActionActive("Move Forward") then
		v1 = v1 + Vector3.new(0, 0, -1)
	end
	if v_u3.isActionActive("Move Backward") then
		v1 = v1 + Vector3.new(0, 0, 1)
	end
	if v_u3.isActionActive("Move Left (Strafe)") then
		v1 = v1 + Vector3.new(-1, 0, 0)
	end
	if v_u3.isActionActive("Move Right (Strafe)") then
		v1 = v1 + Vector3.new(1, 0, 0)
	end
	local v2 = 40 * (v_u3.isActionActive("Walk") and 0.2 or 1)
	if v1 ~= Vector3.new(0, 0, 0) then
		v1 = v1.Unit
	end
	local v_cameracframe = arg1.CameraCFrame
	local v3 = arg1.CameraCFrame.Position + (v_cameracframe.RightVector * v1.X + v_cameracframe.UpVector * v1.Y + v_cameracframe.LookVector * -v1.Z) * (v2 * arg2)
	arg1.CameraCFrame = CFrame.new(v3, v3 + UNNAMED_1729002860920)
	arg1:UpdateMouseWheel(arg2)
end
function v_u1.UpdateMouseWheel(arg1, _)
	-- upvalues: (copy) v_u3
	if arg1.MouseWheelDelta ~= 0 then
		local v_walk = v_u3.isActionActive("Walk")
		local v_cameracframe = arg1.CameraCFrame
		local v_lookvector = v_cameracframe.LookVector
		local v1 = 15 * (v_walk and 0.5 or 1)
		local v2 = v_cameracframe.Position + v_lookvector * (arg1.MouseWheelDelta > 0 and v1 and v1 or -v1)
		arg1.CameraCFrame = CFrame.new(v2, v2 + v_lookvector)
		arg1.MouseWheelDelta = 0
	end
end
function v_u1.UpdateRotation(arg1, _)
	-- upvalues: (copy) v_u_userinput, (copy) v_u3, (copy) v_u_current_camera, (copy) v_u_new
	local v_getmousedelta = v_u_userinput:GetMouseDelta()
	local v_cameracframe = arg1.CameraCFrame
	local v_position = v_cameracframe.Position
	local v_lookvector = v_cameracframe.LookVector
	local v_clamp = math.clamp(math.asin(v_lookvector.Y) - v_getmousedelta.Y / v_u_current_camera.ViewportSize.Y * (v_u_new.Y * (v_u3.isActionActive("Walk") and 0.5 or 1)), -1.3962634015954636, 1.3962634015954636)
	local v_new = Vector3.new(v_lookvector.X, 0, v_lookvector.Z)
	local v_magnitude = v_new.Magnitude
	local v1 = v_magnitude < 0.001 and Vector3.new(0, 0, -1) or v_new / v_magnitude
	local v2 = math.atan2(-v1.X, -v1.Z) - v_getmousedelta.X / UNNAMED_1729007507064.X * (v_u_new.X * UNNAMED_1729007506680)
	local v_cos = math.cos(v_clamp)
	local v_sin = math.sin(v_clamp)
	local v_new = Vector3.new(-math.sin(v2) * v_cos, v_sin, -math.cos(v2) * v_cos)
	arg1.CameraCFrame = CFrame.new(v_position, v_position + v_new)
end
function v_u1.UpdateCamera(arg1)
	-- upvalues: (copy) v_u_current_camera
	v_u_current_camera.CFrame = arg1.CameraCFrame
end
function v_u1.Render(arg1, arg2)
	arg1:UpdateMovement(arg2)
	arg1:UpdateRotation(arg2)
	arg1:UpdateCamera()
end
function v_u1.Start(self)
	-- upvalues: (copy) v_u_current_camera, (copy) v_u2, (copy) v_u_userinput, (copy) v_u_run, (copy) v_u_localplayer
	if not self.IsActive then
		self.IsActive = true
		self.CameraCFrame = v_u_current_camera.CFrame
		self.MouseWheelDelta = 0
		v_u_current_camera.CameraType = Enum.CameraType.Scriptable
		v_u2.setMouseEnabled(false)
		self.Janitor:Add(v_u_userinput:GetPropertyChangedSignal("MouseBehavior"):Connect(function()
			-- upvalues: (copy) self, (ref) v_u_userinput
			if self.IsActive and v_u_userinput.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
				v_u_userinput.MouseBehavior = Enum.MouseBehavior.LockCenter
			end
		end), "Disconnect", "EnforceMouseBehavior")
		self.RenderStepName = "Freecam"
		v_u_run:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value + 10, function(arg1)
			-- upvalues: (copy) self
			if self.IsActive then
				self:Render(arg1)
			end
		end)
		local v_map = workspace:FindFirstChild("Map")
		local v1
		if v_map then
			local v_replicationfocus = v_map:FindFirstChild("ReplicationFocus")
			if v_replicationfocus then
				v1 = v_replicationfocus:FindFirstChild("Focus")
			else
				v1 = nil
			end
		else
			v1 = nil
		end
		if v1 then
			v_u_localplayer.ReplicationFocus = v1
			self.Janitor:Add(function()
				-- upvalues: (ref) v_u_localplayer
				v_u_localplayer.ReplicationFocus = nil
			end, true, "ReplicationFocus")
		end
		self.Janitor:Add(function()
			-- upvalues: (ref) v_u_run
			v_u_run:UnbindFromRenderStep("Freecam")
		end, true)
	end
end
function v_u1.Stop(arg1)
	-- upvalues: (copy) v_u_run, (copy) v_u_current_camera, (copy) v_u2
	if arg1.IsActive then
		arg1.IsActive = false
		v_u_run:UnbindFromRenderStep("Freecam")
		arg1.RenderStepName = nil
		v_u_current_camera.CameraType = Enum.CameraType.Custom
		v_u2.setPerspective(false, true)
		if arg1.Janitor:Get("EnforceMouseBehavior") then
			arg1.Janitor:Remove("EnforceMouseBehavior")
		end
		if arg1.Janitor:Get("ReplicationFocus") then
			arg1.Janitor:Remove("ReplicationFocus")
		end
	end
end
function v_u1.new()
	-- upvalues: (copy) v_u1, (copy) v_u4, (copy) v_u_userinput, (copy) v_u2
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u4.new()
	v_u1.CameraCFrame = CFrame.identity
	v_u1.MouseWheelDelta = 0
	v_u1.RenderStepName = nil
	v_u1.IsActive = false
	v_u1.Janitor:Add(v_u_userinput.InputChanged:Connect(function(arg1, arg2)
		-- upvalues: (copy) v_u1
		if v_u1.IsActive and (not arg2 and arg1.UserInputType == Enum.UserInputType.MouseWheel) then
			v_u1.MouseWheelDelta = arg1.Position.Z
		end
	end), "Disconnect")
	v_u1.Janitor:Add(function()
		-- upvalues: (ref) v_u2, (copy) v_u1
		v_u2.setPerspective(false, true)
		if v_u1.IsActive then
			v_u1:Stop()
		end
	end)
	return v_u1
end
function v_u1.Destroy(arg1)
	arg1.Janitor:Destroy()
end
return v_u1