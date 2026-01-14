-- Decompiled with Bunni.lol Decompiler

local v_u_vr = game:GetService("VRService")
local v_u_userinput = game:GetService("UserInputService")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
local v_u_pathfinding = game:GetService("PathfindingService")
local v_u_contextaction = game:GetService("ContextActionService")
local v_u_startergui = game:GetService("StarterGui")
local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v1 = require(v_commonutils:WaitForChild("FlagUtil"))
local v_u2 = nil
local v_u_localplayer = v_players.LocalPlayer
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
local v_u_userraycastupdateapi = v1.getUserFlag("UserRaycastUpdateAPI")
local v_u_bindableevent = Instance.new("BindableEvent")
v_u_bindableevent.Name = "MovementUpdate"
v_u_bindableevent.Parent = script
coroutine.wrap(function()
	-- upvalues: (ref) v_u2
	local v_pathdisplay = script.Parent:WaitForChild("PathDisplay")
	if v_pathdisplay then
		v_u2 = require(v_pathdisplay)
	end
end)()
local v_u3 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u4 = setmetatable({}, v_u3)
v_u4.__index = v_u4
function v_u4.new(arg1)
	-- upvalues: (copy) v_u3, (copy) v_u4
	local v_new = v_u3.new()
	local v1 = setmetatable(v_new, v_u4)
	v1.CONTROL_ACTION_PRIORITY = arg1
	v1.navigationRequestedConn = nil
	v1.heartbeatConn = nil
	v1.currentDestination = nil
	v1.currentPath = nil
	v1.currentPoints = nil
	v1.currentPointIdx = 0
	v1.expectedTimeToNextPoint = 0
	v1.timeReachedLastPoint = tick()
	v1.moving = false
	v1.isJumpBound = false
	v1.moveLatch = false
	v1.userCFrameEnabledConn = nil
	return v1
end
function v_u4.SetLaserPointerMode(_, arg2)
	-- upvalues: (copy) v_u_startergui
	pcall(function()
		-- upvalues: (ref) v_u_startergui, (copy) arg2
		v_u_startergui:SetCore("VRLaserPointerMode", arg2)
	end)
end
function v_u4.GetLocalHumanoid(_)
	-- upvalues: (copy) v_u_localplayer
	local v_character = v_u_localplayer.Character
	if v_character then
		for _, v1 in pairs(v_character:GetChildren()) do
			if v1:IsA("Humanoid") then
				return v1
			end
		end
		return nil
	end
end
function v_u4.HasBothHandControllers(_)
	-- upvalues: (copy) v_u_vr
	local v_getusercframeenabled = v_u_vr:GetUserCFrameEnabled(Enum.UserCFrame.RightHand)
	if v_getusercframeenabled then
		v_getusercframeenabled = v_u_vr:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)
	end
	return v_getusercframeenabled
end
function v_u4.HasAnyHandControllers(_)
	-- upvalues: (copy) v_u_vr
	return v_u_vr:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or v_u_vr:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)
end
function v_u4.IsMobileVR(_)
	-- upvalues: (copy) v_u_userinput
	return v_u_userinput.TouchEnabled
end
function v_u4.HasGamepad(_)
	-- upvalues: (copy) v_u_userinput
	return v_u_userinput.GamepadEnabled
end
function v_u4.ShouldUseNavigationLaser(arg1)
	if arg1:IsMobileVR() then
		return true
	elseif arg1:HasBothHandControllers() then
		return false
	else
		return arg1:HasAnyHandControllers() and true or not arg1:HasGamepad()
	end
end
function v_u4.StartFollowingPath(arg1, arg2)
	-- upvalues: (copy) v_u_bindableevent
	currentPath = arg2
	currentPoints = currentPath:GetPointCoordinates()
	currentPointIdx = 1
	moving = true
	timeReachedLastPoint = tick()
	local v_getlocalhumanoid = arg1:GetLocalHumanoid()
	if v_getlocalhumanoid and (v_getlocalhumanoid.Torso and #currentPoints >= 1) then
		expectedTimeToNextPoint = (currentPoints[1] - v_getlocalhumanoid.Torso.Position).magnitude / v_getlocalhumanoid.WalkSpeed
	end
	v_u_bindableevent:Fire("targetPoint", arg1.currentDestination)
end
function v_u4.GoToPoint(arg1, arg2)
	-- upvalues: (copy) v_u_bindableevent
	currentPath = true
	currentPoints = { arg2 }
	currentPointIdx = 1
	moving = true
	local v_getlocalhumanoid = arg1:GetLocalHumanoid()
	timeReachedLastPoint = tick()
	expectedTimeToNextPoint = (v_getlocalhumanoid.Torso.Position - arg2).magnitude / v_getlocalhumanoid.WalkSpeed
	v_u_bindableevent:Fire("targetPoint", arg2)
end
function v_u4.StopFollowingPath(arg1)
	currentPath = nil
	currentPoints = nil
	currentPointIdx = 0
	moving = false
	arg1.moveVector = Vector3.new(0, 0, 0)
end
function v_u4.TryComputePath(_, arg2, arg3)
	-- upvalues: (copy) v_u_pathfinding
	local v1 = nil
	local v2 = 0
	while not v1 and v2 < 5 do
		v1 = v_u_pathfinding:ComputeSmoothPathAsync(arg2, arg3, 200)
		v2 = v2 + 1
		if v1.Status == Enum.PathStatus.ClosestNoPath or v1.Status == Enum.PathStatus.ClosestOutOfRange then
			return nil
		end
		if v1 and v1.Status == Enum.PathStatus.FailStartNotEmpty then
			arg2 = arg2 + (arg3 - arg2).Unit
			v1 = nil
		end
		if v1 and v1.Status == Enum.PathStatus.FailFinishNotEmpty then
			arg3 = arg3 + Vector3.new(0, 1, 0)
			v1 = nil
		end
	end
	return v1
end
function v_u4.OnNavigationRequest(arg1, arg2, _)
	-- upvalues: (ref) v_u2
	local v_position = arg2.Position
	local v_currentdestination = arg1.currentDestination
	local v_x = v_position.x
	local v1
	if v_x == v_x and v_x ~= (1 / 0) then
		v1 = v_x ~= (-1 / 0)
	else
		v1 = false
	end
	if v1 then
		local v_y = v_position.y
		if v_y == v_y and v_y ~= (1 / 0) then
			v1 = v_y ~= (-1 / 0)
		else
			v1 = false
		end
		if v1 then
			local v_z = v_position.z
			if v_z == v_z and v_z ~= (1 / 0) then
				v1 = v_z ~= (-1 / 0)
			else
				v1 = false
			end
		end
	end
	if v1 then
		arg1.currentDestination = v_position
		local v_getlocalhumanoid = arg1:GetLocalHumanoid()
		if v_getlocalhumanoid and v_getlocalhumanoid.Torso then
			local v_position = v_getlocalhumanoid.Torso.Position
			if (arg1.currentDestination - v_position).magnitude < 12 then
				arg1:GoToPoint(arg1.currentDestination)
			elseif v_currentdestination and (arg1.currentDestination - v_currentdestination).magnitude <= 4 then
				if moving then
					arg1.currentPoints[#currentPoints] = arg1.currentDestination
					return
				end
				arg1:GoToPoint(arg1.currentDestination)
			else
				local v_trycomputepath = arg1:TryComputePath(v_position, arg1.currentDestination)
				if v_trycomputepath then
					arg1:StartFollowingPath(v_trycomputepath)
					if v_u2 then
						v_u2.setCurrentPoints(arg1.currentPoints)
						v_u2.renderPath()
						return
					end
				else
					arg1:StopFollowingPath()
					if v_u2 then
						v_u2.clearRenderedPath()
						return
					end
				end
			end
		else
			return
		end
	else
		return
	end
end
function v_u4.OnJumpAction(arg1, _, arg3, _)
	if arg3 == Enum.UserInputState.Begin then
		arg1.isJumping = true
	end
	return Enum.ContextActionResult.Sink
end
function v_u4.BindJumpAction(arg1, arg2)
	-- upvalues: (copy) v_u_contextaction
	if arg2 then
		if not arg1.isJumpBound then
			arg1.isJumpBound = true
			v_u_contextaction:BindActionAtPriority("VRJumpAction", function()
				-- upvalues: (copy) arg1
				return arg1:OnJumpAction()
			end, false, arg1.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA)
			return
		end
	elseif arg1.isJumpBound then
		arg1.isJumpBound = false
		v_u_contextaction:UnbindAction("VRJumpAction")
	end
end
function v_u4.ControlCharacterGamepad(arg1, _, arg3, arg4)
	-- upvalues: (ref) v_u2, (copy) v_u_bindableevent
	if arg4.KeyCode == Enum.KeyCode.Thumbstick1 then
		if arg3 ~= Enum.UserInputState.Cancel then
			if arg3 == Enum.UserInputState.End then
				arg1.moveVector = Vector3.new(0, 0, 0)
				if arg1:ShouldUseNavigationLaser() then
					arg1:BindJumpAction(false)
					arg1:SetLaserPointerMode("Navigation")
				end
				if arg1.moveLatch then
					arg1.moveLatch = false
					v_u_bindableevent:Fire("offtrack")
				end
			else
				arg1:StopFollowingPath()
				if v_u2 then
					v_u2.clearRenderedPath()
				end
				if arg1:ShouldUseNavigationLaser() then
					arg1:BindJumpAction(true)
					arg1:SetLaserPointerMode("Hidden")
				end
				if arg4.Position.magnitude > 0.22 then
					arg1.moveVector = Vector3.new(arg4.Position.X, 0, -arg4.Position.Y)
					if arg1.moveVector.magnitude > 0 then
						arg1.moveVector = arg1.moveVector.unit * math.min(1, arg4.Position.magnitude)
					end
					arg1.moveLatch = true
				end
			end
			return Enum.ContextActionResult.Sink
		end
		arg1.moveVector = Vector3.new(0, 0, 0)
	end
end
function v_u4.OnHeartbeat(arg1, arg2)
	-- upvalues: (ref) v_u2, (copy) v_u_userraycastupdateapi, (copy) v_u_new, (copy) v_u_bindableevent
	local v_movevector = arg1.moveVector
	local v_getlocalhumanoid = arg1:GetLocalHumanoid()
	if v_getlocalhumanoid and v_getlocalhumanoid.Torso then
		if arg1.moving and arg1.currentPoints then
			local v_position = v_getlocalhumanoid.Torso.Position
			local v1 = (currentPoints[1] - v_position) * Vector3.new(1, 0, 1)
			local v_magnitude = v1.magnitude
			local v2 = v1 / v_magnitude
			if v_magnitude < 1 then
				local v3 = currentPoints[1]
				local v4 = 0
				for v5, v6 in pairs(currentPoints) do
					if v5 ~= 1 then
						v4 = v4 + (v6 - v3).magnitude / v_getlocalhumanoid.WalkSpeed
						v3 = v6
					end
				end
				table.remove(currentPoints, 1)
				currentPointIdx = currentPointIdx + 1
				if #currentPoints == 0 then
					arg1:StopFollowingPath()
					if v_u2 then
						v_u2.clearRenderedPath()
					end
					return
				end
				if v_u2 then
					v_u2.setCurrentPoints(currentPoints)
					v_u2.renderPath()
				end
				expectedTimeToNextPoint = (currentPoints[1] - v_position).magnitude / v_getlocalhumanoid.WalkSpeed
				timeReachedLastPoint = tick()
			else
				if v_u_userraycastupdateapi then
					v_u_new.FilterDescendantsInstances = { game.Players.LocalPlayer.Character, workspace.CurrentCamera }
					local v_raycast = workspace:Raycast(v_position - Vector3.new(0, 1, 0), v2 * 3, v_u_new)
					if v_raycast then
						local v7 = workspace:Raycast(v_raycast.Position + v2 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0), v_u_new).Position.Y - v_position.Y
						if v7 < 6 and v7 > -2 then
							v_getlocalhumanoid.Jump = true
						end
					end
				else
					local v8 = { game.Players.LocalPlayer.Character, workspace.CurrentCamera }
					local v_new = Ray.new(v_position - Vector3.new(0, 1, 0), v2 * 3)
					local v_findpartonraywithignorelist, v9, _ = workspace:FindPartOnRayWithIgnoreList(v_new, v8)
					if v_findpartonraywithignorelist then
						local v_new = Ray.new(v9 + v2 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0))
						local _, v10, _ = workspace:FindPartOnRayWithIgnoreList(v_new, v8)
						local v11 = v10.Y - v_position.Y
						if v11 < 6 and v11 > -2 then
							v_getlocalhumanoid.Jump = true
						end
					end
				end
				if tick() - timeReachedLastPoint > expectedTimeToNextPoint + 2 then
					arg1:StopFollowingPath()
					if v_u2 then
						v_u2.clearRenderedPath()
					end
					v_u_bindableevent:Fire("offtrack")
				end
				v_movevector = arg1.moveVector:Lerp(v2, arg2 * 10)
			end
		end
		local v_x = v_movevector.x
		local v12
		if v_x == v_x and v_x ~= (1 / 0) then
			v12 = v_x ~= (-1 / 0)
		else
			v12 = false
		end
		if v12 then
			local v_y = v_movevector.y
			if v_y == v_y and v_y ~= (1 / 0) then
				v12 = v_y ~= (-1 / 0)
			else
				v12 = false
			end
			if v12 then
				local v_z = v_movevector.z
				if v_z == v_z and v_z ~= (1 / 0) then
					v12 = v_z ~= (-1 / 0)
				else
					v12 = false
				end
			end
		end
		if v12 then
			arg1.moveVector = v_movevector
		end
	end
end
function v_u4.OnUserCFrameEnabled(arg1)
	if arg1:ShouldUseNavigationLaser() then
		arg1:BindJumpAction(false)
		arg1:SetLaserPointerMode("Navigation")
	else
		arg1:BindJumpAction(true)
		arg1:SetLaserPointerMode("Hidden")
	end
end
function v_u4.Enable(arg1, arg2)
	-- upvalues: (copy) v_u_vr, (copy) v_u_run, (copy) v_u_contextaction
	arg1.moveVector = Vector3.new(0, 0, 0)
	arg1.isJumping = false
	if arg2 then
		arg1.navigationRequestedConn = v_u_vr.NavigationRequested:Connect(function(arg1, arg2)
			-- upvalues: (copy) arg1
			arg1:OnNavigationRequest(arg1, arg2)
		end)
		arg1.heartbeatConn = v_u_run.Heartbeat:Connect(function(arg1)
			-- upvalues: (copy) arg1
			arg1:OnHeartbeat(arg1)
		end)
		v_u_contextaction:BindAction("MoveThumbstick", function(arg1, arg2, arg3)
			-- upvalues: (copy) arg1
			return arg1:ControlCharacterGamepad(arg1, arg2, arg3)
		end, false, arg1.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1)
		v_u_contextaction:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
		arg1.userCFrameEnabledConn = v_u_vr.UserCFrameEnabled:Connect(function()
			-- upvalues: (copy) arg1
			arg1:OnUserCFrameEnabled()
		end)
		arg1:OnUserCFrameEnabled()
		v_u_vr:SetTouchpadMode(Enum.VRTouchpad.Left, Enum.VRTouchpadMode.VirtualThumbstick)
		v_u_vr:SetTouchpadMode(Enum.VRTouchpad.Right, Enum.VRTouchpadMode.ABXY)
		arg1.enabled = true
	else
		arg1:StopFollowingPath()
		v_u_contextaction:UnbindAction("MoveThumbstick")
		v_u_contextaction:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
		arg1:BindJumpAction(false)
		arg1:SetLaserPointerMode("Disabled")
		if arg1.navigationRequestedConn then
			arg1.navigationRequestedConn:Disconnect()
			arg1.navigationRequestedConn = nil
		end
		if arg1.heartbeatConn then
			arg1.heartbeatConn:Disconnect()
			arg1.heartbeatConn = nil
		end
		if arg1.userCFrameEnabledConn then
			arg1.userCFrameEnabledConn:Disconnect()
			arg1.userCFrameEnabledConn = nil
		end
		arg1.enabled = false
	end
end
return v_u4