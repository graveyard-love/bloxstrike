-- Decompiled with Bunni.lol Decompiler

local v1, v2 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding")
end)
local v_u3 = v1 and v2
local v4, v5 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2")
end)
local v_u6 = v4 and v5
local v_u_userinput = game:GetService("UserInputService")
local v_u_pathfinding = game:GetService("PathfindingService")
local v_u_players = game:GetService("Players")
game:GetService("Debris")
local v_u_startergui = game:GetService("StarterGui")
local v_u_workspace = game:GetService("Workspace")
local v_u_collection = game:GetService("CollectionService")
local v_u_gui = game:GetService("GuiService")
local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_userraycastupdateapi = require(v_commonutils:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI")
local v_u7 = true
local v_u8 = true
local v_u9 = false
local v_u10 = 1
local v_u11 = 8
local v_u12 = {
	[Enum.KeyCode.W] = true,
	[Enum.KeyCode.A] = true,
	[Enum.KeyCode.S] = true,
	[Enum.KeyCode.D] = true,
	[Enum.KeyCode.Up] = true,
	[Enum.KeyCode.Down] = true
}
local v_u_localplayer = v_u_players.LocalPlayer
local v_u13 = require(script.Parent:WaitForChild("ClickToMoveDisplay"))
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
local v_u14 = {}
if not v_u_userraycastupdateapi then
	local function v_u15(arg1)
		-- upvalues: (copy) v_u15
		if arg1 then
			local v_humanoid = arg1:FindFirstChildOfClass("Humanoid")
			if v_humanoid then
				return arg1, v_humanoid
			else
				return v_u15(arg1.Parent)
			end
		else
			return
		end
	end
	v_u14.FindCharacterAncestor = v_u15
	local function v_u16(arg1, arg2, arg3)
		-- upvalues: (copy) v_u_workspace, (copy) v_u15, (copy) v_u16
		local v1 = arg3 or {}
		local v_findpartonraywithignorelist, v2, v3, v4 = v_u_workspace:FindPartOnRayWithIgnoreList(arg1, v1)
		if not v_findpartonraywithignorelist then
			return nil, nil
		end
		if arg2 and v_findpartonraywithignorelist.CanCollide == false then
			local v5 = not v_findpartonraywithignorelist or v_findpartonraywithignorelist:FindFirstChildOfClass("Humanoid")
			if not v5 then
				local v6
				v6, v5 = v_u15(v_findpartonraywithignorelist.Parent)
			end
			if v5 == nil then
				table.insert(v1, v_findpartonraywithignorelist)
				return v_u16(arg1, arg2, v1)
			end
		end
		return v_findpartonraywithignorelist, v2, v3, v4
	end
	v_u14.Raycast = v_u16
end
local v_u17 = {}
local v_u18 = nil
local v_u19 = nil
local v_u20 = nil
local v_u21 = nil
local function v_u22(arg1)
	-- upvalues: (ref) v_u19, (ref) v_u20, (ref) v_u21, (ref) v_u18, (copy) v_u_localplayer, (copy) v_u_collection
	if arg1 ~= v_u19 then
		if v_u20 then
			v_u20:Disconnect()
			v_u20 = nil
		end
		if v_u21 then
			v_u21:Disconnect()
			v_u21 = nil
		end
		v_u19 = arg1
		local v1 = {}
		local v2 = v_u_localplayer
		if v2 then
			v2 = v_u_localplayer.Character
		end
		__set_list(v1, 1, {v2})
		v_u18 = v1
		if v_u19 ~= nil then
			local v_gettagged = v_u_collection:GetTagged(v_u19)
			for _, v3 in ipairs(v_gettagged) do
				table.insert(v_u18, v3)
			end
			v_u20 = v_u_collection:GetInstanceAddedSignal(v_u19):Connect(function(arg1)
				-- upvalues: (ref) v_u18
				table.insert(v_u18, arg1)
			end)
			v_u21 = v_u_collection:GetInstanceRemovedSignal(v_u19):Connect(function(arg1)
				-- upvalues: (ref) v_u18
				for v1 = 1, #v_u18 do
					if v_u18[v1] == arg1 then
						v_u18[v1] = v_u18[#v_u18]
						table.remove(v_u18)
						return
					end
				end
			end)
		end
	end
end
local function v_u23(arg1)
	if arg1 == nil or arg1.PrimaryPart == nil then
		return
	else
		assert(arg1, "")
		assert(arg1.PrimaryPart, "")
		local v_inverse = arg1.PrimaryPart.CFrame:Inverse()
		local v1 = Vector3.new(inf, inf, inf)
		local v2 = Vector3.new(-inf, -inf, -inf)
		for _, v3 in pairs(arg1:GetDescendants()) do
			if v3:IsA("BasePart") and v3.CanCollide then
				local v4 = v_inverse * v3.CFrame
				local v_new = Vector3.new(v3.Size.X / 2, v3.Size.Y / 2, v3.Size.Z / 2)
				for _, v5 in ipairs({
					Vector3.new(v_new.X, v_new.Y, v_new.Z),
					Vector3.new(v_new.X, v_new.Y, -v_new.Z),
					Vector3.new(v_new.X, -v_new.Y, v_new.Z),
					Vector3.new(v_new.X, -v_new.Y, -v_new.Z),
					Vector3.new(-v_new.X, v_new.Y, v_new.Z),
					Vector3.new(-v_new.X, v_new.Y, -v_new.Z),
					Vector3.new(-v_new.X, -v_new.Y, v_new.Z),
					(Vector3.new(-v_new.X, -v_new.Y, -v_new.Z))
				}) do
					local v6 = v4 * v5
					local v_min = math.min(v1.X, v6.X)
					local v_min = math.min(v1.Y, v6.Y)
					local v_min = math.min(v1.Z, v6.Z)
					v1 = Vector3.new(v_min, v_min, v_min)
					local v_max = math.max(v2.X, v6.X)
					local v_max = math.max(v2.Y, v6.Y)
					local v_max = math.max(v2.Z, v6.Z)
					v2 = Vector3.new(v_max, v_max, v_max)
				end
			end
		end
		local v7 = v2 - v1
		if v7.X < 0 or (v7.Y < 0 or v7.Z < 0) then
			return nil
		else
			return v7
		end
	end
end
local function v_u24(arg1, arg2, arg3)
	-- upvalues: (ref) v_u9, (copy) v_u_localplayer, (copy) v_u17, (ref) v_u10, (copy) v_u3, (copy) v_u23, (copy) v_u6, (copy) v_u_pathfinding, (ref) v_u7, (copy) v_u13, (ref) v_u11, (copy) v_u_userraycastupdateapi, (copy) v_u_new, (ref) v_u18, (copy) v_u_workspace
	local v_u1 = {}
	local v2
	if arg3 == nil then
		v2 = v_u9
		arg3 = true
	else
		v2 = arg3
	end
	v_u1.Cancelled = false
	v_u1.Started = false
	v_u1.Finished = Instance.new("BindableEvent")
	v_u1.PathFailed = Instance.new("BindableEvent")
	v_u1.PathComputing = false
	v_u1.PathComputed = false
	v_u1.OriginalTargetPoint = arg1
	v_u1.TargetPoint = arg1
	v_u1.TargetSurfaceNormal = arg2
	v_u1.DiedConn = nil
	v_u1.SeatedConn = nil
	v_u1.BlockedConn = nil
	v_u1.TeleportedConn = nil
	v_u1.CurrentPoint = 0
	v_u1.HumanoidOffsetFromPath = Vector3.new(0, 0, 0)
	v_u1.CurrentWaypointPosition = nil
	v_u1.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
	v_u1.CurrentWaypointPlaneDistance = 0
	v_u1.CurrentWaypointNeedsJump = false
	v_u1.CurrentHumanoidPosition = Vector3.new(0, 0, 0)
	v_u1.CurrentHumanoidVelocity = 0
	v_u1.NextActionMoveDirection = Vector3.new(0, 0, 0)
	v_u1.NextActionJump = false
	v_u1.Timeout = 0
	local v3 = v_u_localplayer
	local v4
	if v3 then
		v4 = v3.Character
	else
		v4 = v3
	end
	local v5
	if v4 then
		v5 = v_u17[v3]
		if not v5 or v5.Parent ~= v4 then
			v_u17[v3] = nil
			v5 = v4:FindFirstChildOfClass("Humanoid")
			if v5 then
				v_u17[v3] = v5
			end
		end
	else
		v5 = nil
	end
	v_u1.Humanoid = v5
	v_u1.OriginPoint = nil
	v_u1.AgentCanFollowPath = false
	v_u1.DirectPath = false
	v_u1.DirectPathRiseFirst = false
	v_u1.stopTraverseFunc = nil
	v_u1.setPointFunc = nil
	v_u1.pointList = nil
	local v_humanoid = v_u1.Humanoid
	if v_humanoid then
		v_humanoid = v_u1.Humanoid.RootPart
	end
	if v_humanoid then
		v_u1.OriginPoint = v_humanoid.CFrame.Position
		local v6 = 2
		local v7 = 5
		local v8 = true
		local v_seatpart = v_u1.Humanoid.SeatPart
		if v_seatpart and v_seatpart:IsA("VehicleSeat") then
			local v_model = v_seatpart:FindFirstAncestorOfClass("Model")
			if v_model then
				local v_primarypart = v_model.PrimaryPart
				v_model.PrimaryPart = v_seatpart
				if arg3 then
					local v_getextentssize = v_model:GetExtentsSize()
					v6 = v_u10 * 0.5 * math.sqrt(v_getextentssize.X * v_getextentssize.X + v_getextentssize.Z * v_getextentssize.Z)
					v7 = v_u10 * v_getextentssize.Y
					v_u1.AgentCanFollowPath = true
					v_u1.DirectPath = arg3
					v8 = false
				end
				v_model.PrimaryPart = v_primarypart
			end
		else
			local v9 = nil
			if v_u3 then
				local v10 = v_u_localplayer
				if v10 then
					v10 = v_u_localplayer.Character
				end
				if v10 ~= nil then
					v9 = v_u23(v10)
				end
			end
			if v9 == nil then
				local v11 = v_u_localplayer
				if v11 then
					v11 = v_u_localplayer.Character
				end
				v9 = v11:GetExtentsSize()
			end
			assert(v9, "")
			v6 = v_u10 * 0.5 * math.sqrt(v9.X * v9.X + v9.Z * v9.Z)
			v7 = v_u10 * v9.Y
			v8 = v_u1.Humanoid.JumpPower > 0
			v_u1.AgentCanFollowPath = true
			v_u1.DirectPath = v2
			v_u1.DirectPathRiseFirst = v_u1.Humanoid.Sit
		end
		if v_u6 then
			v_u1.pathResult = v_u_pathfinding:CreatePath({
				["AgentRadius"] = v6,
				["AgentHeight"] = v7,
				["AgentCanJump"] = v8,
				["AgentCanClimb"] = true
			})
		else
			v_u1.pathResult = v_u_pathfinding:CreatePath({
				["AgentRadius"] = v6,
				["AgentHeight"] = v7,
				["AgentCanJump"] = v8
			})
		end
	end
	function v_u1.Cleanup(_)
		-- upvalues: (copy) v_u1
		if v_u1.stopTraverseFunc then
			v_u1.stopTraverseFunc()
			v_u1.stopTraverseFunc = nil
		end
		if v_u1.BlockedConn then
			v_u1.BlockedConn:Disconnect()
			v_u1.BlockedConn = nil
		end
		if v_u1.DiedConn then
			v_u1.DiedConn:Disconnect()
			v_u1.DiedConn = nil
		end
		if v_u1.SeatedConn then
			v_u1.SeatedConn:Disconnect()
			v_u1.SeatedConn = nil
		end
		if v_u1.TeleportedConn then
			v_u1.TeleportedConn:Disconnect()
			v_u1.TeleportedConn = nil
		end
		v_u1.Started = false
	end
	function v_u1.Cancel(_)
		-- upvalues: (copy) v_u1
		v_u1.Cancelled = true
		v_u1:Cleanup()
	end
	function v_u1.IsActive(_)
		-- upvalues: (copy) v_u1
		local v1 = v_u1.AgentCanFollowPath and v_u1.Started
		if v1 then
			v1 = not v_u1.Cancelled
		end
		return v1
	end
	function v_u1.OnPathInterrupted(_)
		-- upvalues: (copy) v_u1
		v_u1.Cancelled = true
		v_u1:OnPointReached(false)
	end
	function v_u1.ComputePath(_)
		-- upvalues: (copy) v_u1
		if v_u1.OriginPoint then
			if v_u1.PathComputed or v_u1.PathComputing then
				return
			end
			v_u1.PathComputing = true
			if v_u1.AgentCanFollowPath then
				if v_u1.DirectPath then
					v_u1.pointList = { PathWaypoint.new(v_u1.OriginPoint, Enum.PathWaypointAction.Walk), PathWaypoint.new(v_u1.TargetPoint, v_u1.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk) }
					v_u1.PathComputed = true
				else
					v_u1.pathResult:ComputeAsync(v_u1.OriginPoint, v_u1.TargetPoint)
					v_u1.pointList = v_u1.pathResult:GetWaypoints()
					v_u1.BlockedConn = v_u1.pathResult.Blocked:Connect(function(arg1)
						-- upvalues: (ref) v_u1
						v_u1:OnPathBlocked(arg1)
					end)
					v_u1.PathComputed = v_u1.pathResult.Status == Enum.PathStatus.Success
				end
			end
			v_u1.PathComputing = false
		end
	end
	function v_u1.IsValidPath(_)
		-- upvalues: (copy) v_u1
		v_u1:ComputePath()
		local v_pathcomputed = v_u1.PathComputed
		if v_pathcomputed then
			v_pathcomputed = v_u1.AgentCanFollowPath
		end
		return v_pathcomputed
	end
	v_u1.Recomputing = false
	function v_u1.OnPathBlocked(_, arg2)
		-- upvalues: (copy) v_u1, (ref) v_u7, (ref) v_u13
		if v_u1.CurrentPoint <= arg2 and not v_u1.Recomputing then
			v_u1.Recomputing = true
			if v_u1.stopTraverseFunc then
				v_u1.stopTraverseFunc()
				v_u1.stopTraverseFunc = nil
			end
			v_u1.OriginPoint = v_u1.Humanoid.RootPart.CFrame.p
			v_u1.pathResult:ComputeAsync(v_u1.OriginPoint, v_u1.TargetPoint)
			v_u1.pointList = v_u1.pathResult:GetWaypoints()
			if #v_u1.pointList > 0 then
				v_u1.HumanoidOffsetFromPath = v_u1.pointList[1].Position - v_u1.OriginPoint
			end
			v_u1.PathComputed = v_u1.pathResult.Status == Enum.PathStatus.Success
			if v_u7 then
				local v_createpathdisplay, v1 = v_u13.CreatePathDisplay(v_u1.pointList)
				v_u1.stopTraverseFunc = v_createpathdisplay
				v_u1.setPointFunc = v1
			end
			if v_u1.PathComputed then
				v_u1.CurrentPoint = 1
				v_u1:OnPointReached(true)
			else
				v_u1.PathFailed:Fire()
				v_u1:Cleanup()
			end
			v_u1.Recomputing = false
		end
	end
	function v_u1.OnRenderStepped(_, arg2)
		-- upvalues: (copy) v_u1, (ref) v_u11
		if v_u1.Started and not v_u1.Cancelled then
			v_u1.Timeout = v_u1.Timeout + arg2
			if v_u11 < v_u1.Timeout then
				v_u1:OnPointReached(false)
				return
			end
			v_u1.CurrentHumanoidPosition = v_u1.Humanoid.RootPart.Position + v_u1.HumanoidOffsetFromPath
			v_u1.CurrentHumanoidVelocity = v_u1.Humanoid.RootPart.Velocity
			while v_u1.Started and v_u1:IsCurrentWaypointReached() do
				v_u1:OnPointReached(true)
			end
			if v_u1.Started then
				v_u1.NextActionMoveDirection = v_u1.CurrentWaypointPosition - v_u1.CurrentHumanoidPosition
				if v_u1.NextActionMoveDirection.Magnitude > 1e-6 then
					v_u1.NextActionMoveDirection = v_u1.NextActionMoveDirection.Unit
				else
					v_u1.NextActionMoveDirection = Vector3.new(0, 0, 0)
				end
				if v_u1.CurrentWaypointNeedsJump then
					v_u1.NextActionJump = true
					v_u1.CurrentWaypointNeedsJump = false
					return
				end
				v_u1.NextActionJump = false
			end
		end
	end
	function v_u1.IsCurrentWaypointReached(_)
		-- upvalues: (copy) v_u1
		local v1 = v_u1.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0) and true or v_u1.CurrentWaypointPlaneNormal:Dot(v_u1.CurrentHumanoidPosition) - v_u1.CurrentWaypointPlaneDistance < math.max(1, 0.0625 * -v_u1.CurrentWaypointPlaneNormal:Dot(v_u1.CurrentHumanoidVelocity))
		if v1 then
			v_u1.CurrentWaypointPosition = nil
			v_u1.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
			v_u1.CurrentWaypointPlaneDistance = 0
		end
		return v1
	end
	function v_u1.OnPointReached(_, arg2)
		-- upvalues: (copy) v_u1
		if arg2 and not v_u1.Cancelled then
			if v_u1.setPointFunc then
				v_u1.setPointFunc(v_u1.CurrentPoint)
			end
			local v1 = v_u1.CurrentPoint + 1
			if #v_u1.pointList < v1 then
				if v_u1.stopTraverseFunc then
					v_u1.stopTraverseFunc()
				end
				v_u1.Finished:Fire()
				v_u1:Cleanup()
			else
				local v2 = v_u1.pointList[v_u1.CurrentPoint]
				local v3 = v_u1.pointList[v1]
				local v_getstate = v_u1.Humanoid:GetState()
				if (v_getstate == Enum.HumanoidStateType.FallingDown or v_getstate == Enum.HumanoidStateType.Freefall) and true or v_getstate == Enum.HumanoidStateType.Jumping then
					local v4 = v3.Action == Enum.PathWaypointAction.Jump
					if not v4 and v_u1.CurrentPoint > 1 then
						local v5 = v2.Position - v_u1.pointList[v_u1.CurrentPoint - 1].Position
						local v6 = v3.Position - v2.Position
						v4 = Vector2.new(v5.x, v5.z).Unit:Dot(Vector2.new(v6.x, v6.z).Unit) < 0.996
					end
					if v4 then
						v_u1.Humanoid.FreeFalling:Wait()
						wait(0.1)
					end
				end
				v_u1:MoveToNextWayPoint(v2, v3, v1)
			end
		else
			v_u1.PathFailed:Fire()
			v_u1:Cleanup()
			return
		end
	end
	function v_u1.MoveToNextWayPoint(_, arg2, arg3, arg4)
		-- upvalues: (copy) v_u1, (ref) v_u6
		v_u1.CurrentWaypointPlaneNormal = arg2.Position - arg3.Position
		if not v_u6 or arg3.Label ~= "Climb" then
			v_u1.CurrentWaypointPlaneNormal = Vector3.new(v_u1.CurrentWaypointPlaneNormal.X, 0, v_u1.CurrentWaypointPlaneNormal.Z)
		end
		if v_u1.CurrentWaypointPlaneNormal.Magnitude > 1e-6 then
			v_u1.CurrentWaypointPlaneNormal = v_u1.CurrentWaypointPlaneNormal.Unit
			v_u1.CurrentWaypointPlaneDistance = v_u1.CurrentWaypointPlaneNormal:Dot(arg3.Position)
		else
			v_u1.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
			v_u1.CurrentWaypointPlaneDistance = 0
		end
		v_u1.CurrentWaypointNeedsJump = arg3.Action == Enum.PathWaypointAction.Jump
		v_u1.CurrentWaypointPosition = arg3.Position
		v_u1.CurrentPoint = arg4
		v_u1.Timeout = 0
	end
	function v_u1.Start(_, arg2)
		-- upvalues: (copy) v_u1, (ref) v_u13, (ref) v_u7
		if v_u1.AgentCanFollowPath then
			if v_u1.Started then
				return
			else
				v_u1.Started = true
				v_u13.CancelFailureAnimation()
				if v_u7 and (arg2 == nil or arg2) then
					local v_createpathdisplay, v1 = v_u13.CreatePathDisplay(v_u1.pointList, v_u1.OriginalTargetPoint)
					v_u1.stopTraverseFunc = v_createpathdisplay
					v_u1.setPointFunc = v1
				end
				if #v_u1.pointList > 0 then
					v_u1.HumanoidOffsetFromPath = Vector3.new(0, v_u1.pointList[1].Position.Y - v_u1.OriginPoint.Y, 0)
					v_u1.CurrentHumanoidPosition = v_u1.Humanoid.RootPart.Position + v_u1.HumanoidOffsetFromPath
					v_u1.CurrentHumanoidVelocity = v_u1.Humanoid.RootPart.Velocity
					v_u1.SeatedConn = v_u1.Humanoid.Seated:Connect(function(_, _)
						-- upvalues: (ref) v_u1
						v_u1:OnPathInterrupted()
					end)
					v_u1.DiedConn = v_u1.Humanoid.Died:Connect(function()
						-- upvalues: (ref) v_u1
						v_u1:OnPathInterrupted()
					end)
					v_u1.TeleportedConn = v_u1.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(function()
						-- upvalues: (ref) v_u1
						v_u1:OnPathInterrupted()
					end)
					v_u1.CurrentPoint = 1
					v_u1:OnPointReached(true)
				else
					v_u1.PathFailed:Fire()
					if v_u1.stopTraverseFunc then
						v_u1.stopTraverseFunc()
					end
				end
			end
		else
			v_u1.PathFailed:Fire()
			return
		end
	end
	local v12 = v_u1.TargetPoint + v_u1.TargetSurfaceNormal * 1.5
	if v_u_userraycastupdateapi then
		local v13 = v_u_new
		local v14
		if v_u18 then
			v14 = v_u18
		else
			assert({}, "")
			local v15 = v_u18
			local v16 = v_u_localplayer
			if v16 then
				v16 = v_u_localplayer.Character
			end
			table.insert(v15, v16)
			v14 = v_u18
		end
		v13.FilterDescendantsInstances = v14
		local v_raycast = v_u_workspace:Raycast(v12, Vector3.new(-0, -50, -0), v_u_new)
		if v_raycast then
			v_u1.TargetPoint = v_raycast.Position
		end
	else
		local v_new = Ray.new(v12, Vector3.new(0, -50, 0))
		local v17 = v_u_workspace
		local v18
		if v_u18 then
			v18 = v_u18
		else
			assert({}, "")
			local v19 = v_u18
			local v20 = v_u_localplayer
			if v20 then
				v20 = v_u_localplayer.Character
			end
			table.insert(v19, v20)
			v18 = v_u18
		end
		local v_findpartonraywithignorelist, v21 = v17:FindPartOnRayWithIgnoreList(v_new, v18)
		if v_findpartonraywithignorelist then
			v_u1.TargetPoint = v21
		end
	end
	v_u1:ComputePath()
	return v_u1
end
local function v_u25(arg1)
	if arg1 ~= nil then
		for _, v1 in pairs(arg1:GetChildren()) do
			if v1:IsA("Tool") then
				return v1
			end
		end
	end
end
local v_u26 = nil
local v_u27 = nil
local v_u28 = nil
local function v_u29(arg1, arg2, arg3, arg4, arg5)
	-- upvalues: (ref) v_u26, (ref) v_u27, (ref) v_u28, (copy) v_u25, (ref) v_u8, (copy) v_u13
	if v_u26 then
		if v_u26 then
			v_u26:Cancel()
			v_u26 = nil
		end
		if v_u27 then
			v_u27:Disconnect()
			v_u27 = nil
		end
		if v_u28 then
			v_u28:Disconnect()
			v_u28 = nil
		end
	end
	v_u26 = arg1
	arg1:Start(arg5)
	v_u27 = arg1.Finished.Event:Connect(function()
		-- upvalues: (ref) v_u26, (ref) v_u27, (ref) v_u28, (copy) arg3, (ref) v_u25, (copy) arg4
		if v_u26 then
			v_u26:Cancel()
			v_u26 = nil
		end
		if v_u27 then
			v_u27:Disconnect()
			v_u27 = nil
		end
		if v_u28 then
			v_u28:Disconnect()
			v_u28 = nil
		end
		local v1 = arg3 and v_u25(arg4)
		if v1 then
			v1:Activate()
		end
	end)
	v_u28 = arg1.PathFailed.Event:Connect(function()
		-- upvalues: (ref) v_u26, (ref) v_u27, (ref) v_u28, (copy) arg5, (ref) v_u8, (ref) v_u13, (copy) arg2
		if v_u26 then
			v_u26:Cancel()
			v_u26 = nil
		end
		if v_u27 then
			v_u27:Disconnect()
			v_u27 = nil
		end
		if v_u28 then
			v_u28:Disconnect()
			v_u28 = nil
		end
		if arg5 == nil or arg5 then
			local v1 = v_u8
			if v1 then
				local v2 = v_u26
				if v2 then
					v2 = v_u26:IsActive()
				end
				v1 = not v2
			end
			if v1 then
				v_u13.PlayFailureAnimation()
			end
			v_u13.DisplayFailureWaypoint(arg2)
		end
	end)
end
function OnTap(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_workspace, (copy) v_u_localplayer, (copy) v_u17, (copy) v_u_userraycastupdateapi, (ref) v_u18, (copy) v_u_new, (copy) v_u_startergui, (copy) v_u_players, (ref) v_u26, (ref) v_u27, (ref) v_u28, (copy) v_u24, (copy) v_u29, (ref) v_u8, (copy) v_u13, (copy) v_u14, (copy) v_u25
	local v_current_camera = v_u_workspace.CurrentCamera
	local v_character = v_u_localplayer.Character
	local v1 = v_u_localplayer
	local v2
	if v1 then
		v2 = v1.Character
	else
		v2 = v1
	end
	local v3
	if v2 then
		v3 = v_u17[v1]
		if not v3 or v3.Parent ~= v2 then
			v_u17[v1] = nil
			v3 = v2:FindFirstChildOfClass("Humanoid")
			if v3 then
				v_u17[v1] = v3
			end
		end
	else
		v3 = nil
	end
	local v4
	if v3 == nil then
		v4 = false
	else
		v4 = v3.Health > 0
	end
	if not v4 then
		return
	end
	if #arg1 ~= 1 and not arg2 then
		local v5 = #arg1 >= 2 and (v_current_camera and v_u25(v_character))
		if v5 then
			v5:Activate()
		end
		goto l21
	end
	if not v_current_camera then
		::l21::
		return
	end
	local v_screenpointtoray = v_current_camera:ScreenPointToRay(arg1[1].X, arg1[1].Y)
	if not v_u_userraycastupdateapi then
		local v_new = Ray.new(v_screenpointtoray.Origin, v_screenpointtoray.Direction * 1000)
		local v_raycast = v_u14.Raycast
		local v6 = true
		local v7
		if v_u18 then
			v7 = v_u18
		else
			assert({}, "")
			local v8 = v_u18
			local v9 = v_u_localplayer
			if v9 then
				v9 = v_u_localplayer.Character
			end
			table.insert(v8, v9)
			v7 = v_u18
		end
		local v10, v11, v12 = v_raycast(v_new, v6, v7)
		local v_findcharacterancestor, v13 = v_u14.FindCharacterAncestor(v10)
		if arg3 and (v13 and (v_u_startergui:GetCore("AvatarContextMenuEnabled") and v_u_players:GetPlayerFromCharacter(v13.Parent))) then
			if v_u26 then
				v_u26:Cancel()
				v_u26 = nil
			end
			if v_u27 then
				v_u27:Disconnect()
				v_u27 = nil
			end
			if v_u28 then
				v_u28:Disconnect()
				v_u28 = nil
			end
			return
		end
		if arg2 then
			v_findcharacterancestor = nil
		else
			arg2 = v11
		end
		if arg2 and v_character then
			if v_u26 then
				v_u26:Cancel()
				v_u26 = nil
			end
			if v_u27 then
				v_u27:Disconnect()
				v_u27 = nil
			end
			if v_u28 then
				v_u28:Disconnect()
				v_u28 = nil
			end
			local v14 = v_u24(arg2, v12)
			if v14:IsValidPath() then
				v_u29(v14, arg2, v_findcharacterancestor, v_character)
			else
				v14:Cleanup()
				if v_u26 and v_u26:IsActive() then
					v_u26:Cancel()
				end
				if v_u8 then
					v_u13.PlayFailureAnimation()
				end
				v_u13.DisplayFailureWaypoint(arg2)
			end
		end
		goto l21
	end
	local v15 = nil
	local v16 = nil
	local v17
	if v_u18 then
		v17 = v_u18
	else
		assert({}, "")
		local v18 = v_u18
		local v19 = v_u_localplayer
		if v19 then
			v19 = v_u_localplayer.Character
		end
		table.insert(v18, v19)
		v17 = v_u18
	end
	if not v17 then
		v17 = {}
	end
	while true do
		local v20 = true
		v_u_new.FilterDescendantsInstances = v17
		local v_raycast = v_u_workspace:Raycast(v_screenpointtoray.Origin, v_screenpointtoray.Direction * 1000, v_u_new)
		if v_raycast then
			local v_instance = v_raycast.Instance
			if not v_instance.CanCollide then
				while true do
					v15 = v_instance:FindFirstChildOfClass("Humanoid")
					local v_parent = v_instance.Parent
					if v15 or (not v_parent or v_parent == v_u_workspace) then
						break
					end
					v_instance = v_parent
				end
				if v15 then
					v16 = v_instance
				else
					table.insert(v17, v_parent)
					v20 = false
					v16 = nil
				end
				goto l32
			end
		end
		::l32::
		if v20 then
			if arg3 and (v15 and (v_u_startergui:GetCore("AvatarContextMenuEnabled") and v_u_players:GetPlayerFromCharacter(v15.Parent))) then
				if v_u26 then
					v_u26:Cancel()
					v_u26 = nil
				end
				if v_u27 then
					v_u27:Disconnect()
					v_u27 = nil
				end
				if v_u28 then
					v_u28:Disconnect()
					v_u28 = nil
				end
				return
			elseif v_raycast and v_character then
				local v_position = v_raycast.Position
				if arg2 then
					v16 = nil
				else
					arg2 = v_position
				end
				if v_u26 then
					v_u26:Cancel()
					v_u26 = nil
				end
				if v_u27 then
					v_u27:Disconnect()
					v_u27 = nil
				end
				if v_u28 then
					v_u28:Disconnect()
					v_u28 = nil
				end
				local v21 = v_u24(arg2, v_raycast.Normal)
				if v21:IsValidPath() then
					v_u29(v21, arg2, v16, v_character)
				else
					v21:Cleanup()
					if v_u26 and v_u26:IsActive() then
						v_u26:Cancel()
					end
					if v_u8 then
						v_u13.PlayFailureAnimation()
					end
					v_u13.DisplayFailureWaypoint(arg2)
				end
			else
				return
			end
		end
	end
end
local v_u30 = require(script.Parent:WaitForChild("Keyboard"))
local v_u31 = setmetatable({}, v_u30)
v_u31.__index = v_u31
function v_u31.new(arg1)
	-- upvalues: (copy) v_u30, (copy) v_u31
	local v_new = v_u30.new(arg1)
	local v1 = setmetatable(v_new, v_u31)
	v1.fingerTouches = {}
	v1.numUnsunkTouches = 0
	v1.mouse1Down = tick()
	v1.mouse1DownPos = Vector2.new()
	v1.mouse2DownTime = tick()
	v1.mouse2DownPos = Vector2.new()
	v1.mouse2UpTime = tick()
	v1.keyboardMoveVector = Vector3.new(0, 0, 0)
	v1.tapConn = nil
	v1.inputBeganConn = nil
	v1.inputChangedConn = nil
	v1.inputEndedConn = nil
	v1.humanoidDiedConn = nil
	v1.characterChildAddedConn = nil
	v1.onCharacterAddedConn = nil
	v1.characterChildRemovedConn = nil
	v1.renderSteppedConn = nil
	v1.menuOpenedConnection = nil
	v1.running = false
	v1.wasdEnabled = false
	return v1
end
function v_u31.DisconnectEvents(arg1)
	local v_tapconn = arg1.tapConn
	if v_tapconn then
		v_tapconn:Disconnect()
	end
	local v_inputbeganconn = arg1.inputBeganConn
	if v_inputbeganconn then
		v_inputbeganconn:Disconnect()
	end
	local v_inputchangedconn = arg1.inputChangedConn
	if v_inputchangedconn then
		v_inputchangedconn:Disconnect()
	end
	local v_inputendedconn = arg1.inputEndedConn
	if v_inputendedconn then
		v_inputendedconn:Disconnect()
	end
	local v_humanoiddiedconn = arg1.humanoidDiedConn
	if v_humanoiddiedconn then
		v_humanoiddiedconn:Disconnect()
	end
	local v_characterchildaddedconn = arg1.characterChildAddedConn
	if v_characterchildaddedconn then
		v_characterchildaddedconn:Disconnect()
	end
	local v_oncharacteraddedconn = arg1.onCharacterAddedConn
	if v_oncharacteraddedconn then
		v_oncharacteraddedconn:Disconnect()
	end
	local v_rendersteppedconn = arg1.renderSteppedConn
	if v_rendersteppedconn then
		v_rendersteppedconn:Disconnect()
	end
	local v_characterchildremovedconn = arg1.characterChildRemovedConn
	if v_characterchildremovedconn then
		v_characterchildremovedconn:Disconnect()
	end
	local v_menuopenedconnection = arg1.menuOpenedConnection
	if v_menuopenedconnection then
		v_menuopenedconnection:Disconnect()
	end
end
function v_u31.OnTouchBegan(arg1, arg2, arg3)
	if arg1.fingerTouches[arg2] == nil and not arg3 then
		arg1.numUnsunkTouches = arg1.numUnsunkTouches + 1
	end
	arg1.fingerTouches[arg2] = arg3
end
function v_u31.OnTouchChanged(arg1, arg2, arg3)
	if arg1.fingerTouches[arg2] == nil then
		arg1.fingerTouches[arg2] = arg3
		if not arg3 then
			arg1.numUnsunkTouches = arg1.numUnsunkTouches + 1
		end
	end
end
function v_u31.OnTouchEnded(arg1, arg2, _)
	if arg1.fingerTouches[arg2] ~= nil and arg1.fingerTouches[arg2] == false then
		arg1.numUnsunkTouches = arg1.numUnsunkTouches - 1
	end
	arg1.fingerTouches[arg2] = nil
end
function v_u31.OnCharacterAdded(arg1, arg2)
	-- upvalues: (copy) v_u_userinput, (copy) v_u12, (ref) v_u26, (ref) v_u27, (ref) v_u28, (copy) v_u13, (copy) v_u_gui
	arg1:DisconnectEvents()
	arg1.inputBeganConn = v_u_userinput.InputBegan:Connect(function(arg1, arg2)
		-- upvalues: (copy) arg1, (ref) v_u12, (ref) v_u26, (ref) v_u27, (ref) v_u28, (ref) v_u13
		if arg1.UserInputType == Enum.UserInputType.Touch then
			arg1:OnTouchBegan(arg1, arg2)
		end
		if arg1.wasdEnabled and (arg2 == false and (arg1.UserInputType == Enum.UserInputType.Keyboard and v_u12[arg1.KeyCode])) then
			if v_u26 then
				v_u26:Cancel()
				v_u26 = nil
			end
			if v_u27 then
				v_u27:Disconnect()
				v_u27 = nil
			end
			if v_u28 then
				v_u28:Disconnect()
				v_u28 = nil
			end
			v_u13.CancelFailureAnimation()
		end
		if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
			arg1.mouse1DownTime = tick()
			arg1.mouse1DownPos = arg1.Position
		end
		if arg1.UserInputType == Enum.UserInputType.MouseButton2 then
			arg1.mouse2DownTime = tick()
			arg1.mouse2DownPos = arg1.Position
		end
	end)
	arg1.inputChangedConn = v_u_userinput.InputChanged:Connect(function(arg1, arg2)
		-- upvalues: (copy) arg1
		if arg1.UserInputType == Enum.UserInputType.Touch then
			arg1:OnTouchChanged(arg1, arg2)
		end
	end)
	arg1.inputEndedConn = v_u_userinput.InputEnded:Connect(function(arg1, arg2)
		-- upvalues: (copy) arg1, (ref) v_u26
		if arg1.UserInputType == Enum.UserInputType.Touch then
			arg1:OnTouchEnded(arg1, arg2)
		end
		if arg1.UserInputType == Enum.UserInputType.MouseButton2 then
			arg1.mouse2UpTime = tick()
			local v_position = arg1.Position
			if arg1.mouse2UpTime - arg1.mouse2DownTime < 0.25 and ((v_position - arg1.mouse2DownPos).magnitude < 5 and (v_u26 or arg1.keyboardMoveVector.Magnitude <= 0)) then
				OnTap({ v_position })
			end
		end
	end)
	arg1.tapConn = v_u_userinput.TouchTap:Connect(function(arg1, arg2)
		if not arg2 then
			OnTap(arg1, nil, true)
		end
	end)
	arg1.menuOpenedConnection = v_u_gui.MenuOpened:Connect(function()
		-- upvalues: (ref) v_u26, (ref) v_u27, (ref) v_u28
		if v_u26 then
			v_u26:Cancel()
			v_u26 = nil
		end
		if v_u27 then
			v_u27:Disconnect()
			v_u27 = nil
		end
		if v_u28 then
			v_u28:Disconnect()
			v_u28 = nil
		end
	end)
	local function v_u1(arg1)
		-- upvalues: (ref) v_u_userinput, (copy) arg1
		if v_u_userinput.TouchEnabled and arg1:IsA("Tool") then
			arg1.ManualActivationOnly = true
		end
		if arg1:IsA("Humanoid") then
			local v_humanoiddiedconn = arg1.humanoidDiedConn
			if v_humanoiddiedconn then
				v_humanoiddiedconn:Disconnect()
			end
			arg1.humanoidDiedConn = arg1.Died:Connect(function() end)
		end
	end
	arg1.characterChildAddedConn = arg2.ChildAdded:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		v_u1(arg1)
	end)
	arg1.characterChildRemovedConn = arg2.ChildRemoved:Connect(function(arg1)
		-- upvalues: (ref) v_u_userinput
		if v_u_userinput.TouchEnabled and arg1:IsA("Tool") then
			arg1.ManualActivationOnly = false
		end
	end)
	for _, v2 in pairs(arg2:GetChildren()) do
		v_u1(v2)
	end
end
function v_u31.Start(arg1)
	arg1:Enable(true)
end
function v_u31.Stop(arg1)
	arg1:Enable(false)
end
function v_u31.CleanupPath(_)
	-- upvalues: (ref) v_u26, (ref) v_u27, (ref) v_u28
	if v_u26 then
		v_u26:Cancel()
		v_u26 = nil
	end
	if v_u27 then
		v_u27:Disconnect()
		v_u27 = nil
	end
	if v_u28 then
		v_u28:Disconnect()
		v_u28 = nil
	end
end
function v_u31.Enable(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_localplayer, (ref) v_u26, (ref) v_u27, (ref) v_u28, (copy) v_u_userinput, (copy) v_u30
	if arg2 then
		if not arg1.running then
			if v_u_localplayer.Character then
				arg1:OnCharacterAdded(v_u_localplayer.Character)
			end
			arg1.onCharacterAddedConn = v_u_localplayer.CharacterAdded:Connect(function(arg1)
				-- upvalues: (copy) arg1
				arg1:OnCharacterAdded(arg1)
			end)
			arg1.running = true
		end
		arg1.touchJumpController = arg4
		if arg1.touchJumpController then
			arg1.touchJumpController:Enable(arg1.jumpEnabled)
		end
	else
		if arg1.running then
			arg1:DisconnectEvents()
			if v_u26 then
				v_u26:Cancel()
				v_u26 = nil
			end
			if v_u27 then
				v_u27:Disconnect()
				v_u27 = nil
			end
			if v_u28 then
				v_u28:Disconnect()
				v_u28 = nil
			end
			if v_u_userinput.TouchEnabled then
				local v_character = v_u_localplayer.Character
				if v_character then
					for _, v1 in pairs(v_character:GetChildren()) do
						if v1:IsA("Tool") then
							v1.ManualActivationOnly = false
						end
					end
				end
			end
			arg1.running = false
		end
		if arg1.touchJumpController and not arg1.jumpEnabled then
			arg1.touchJumpController:Enable(true)
		end
		arg1.touchJumpController = nil
	end
	v_u30.Enable(arg1, arg2)
	arg1.wasdEnabled = arg2 and arg3 and arg3 or false
	arg1.enabled = arg2
end
function v_u31.OnRenderStepped(arg1, arg2)
	-- upvalues: (ref) v_u26
	arg1.isJumping = false
	if v_u26 then
		v_u26:OnRenderStepped(arg2)
		if v_u26 then
			arg1.moveVector = v_u26.NextActionMoveDirection
			arg1.moveVectorIsCameraRelative = false
			if v_u26.NextActionJump then
				arg1.isJumping = true
			end
		else
			arg1.moveVector = arg1.keyboardMoveVector
			arg1.moveVectorIsCameraRelative = true
		end
	else
		arg1.moveVector = arg1.keyboardMoveVector
		arg1.moveVectorIsCameraRelative = true
	end
	if arg1.jumpRequested then
		arg1.isJumping = true
	end
end
function v_u31.UpdateMovement(arg1, arg2)
	if arg2 == Enum.UserInputState.Cancel then
		arg1.keyboardMoveVector = Vector3.new(0, 0, 0)
	elseif arg1.wasdEnabled then
		arg1.keyboardMoveVector = Vector3.new(arg1.leftValue + arg1.rightValue, 0, arg1.forwardValue + arg1.backwardValue)
	end
end
function v_u31.UpdateJump(_) end
function v_u31.SetShowPath(_, arg2)
	-- upvalues: (ref) v_u7
	v_u7 = arg2
end
function v_u31.GetShowPath(_)
	-- upvalues: (ref) v_u7
	return v_u7
end
function v_u31.SetWaypointTexture(_, arg2)
	-- upvalues: (copy) v_u13
	v_u13.SetWaypointTexture(arg2)
end
function v_u31.GetWaypointTexture(_)
	-- upvalues: (copy) v_u13
	return v_u13.GetWaypointTexture()
end
function v_u31.SetWaypointRadius(_, arg2)
	-- upvalues: (copy) v_u13
	v_u13.SetWaypointRadius(arg2)
end
function v_u31.GetWaypointRadius(_)
	-- upvalues: (copy) v_u13
	return v_u13.GetWaypointRadius()
end
function v_u31.SetEndWaypointTexture(_, arg2)
	-- upvalues: (copy) v_u13
	v_u13.SetEndWaypointTexture(arg2)
end
function v_u31.GetEndWaypointTexture(_)
	-- upvalues: (copy) v_u13
	return v_u13.GetEndWaypointTexture()
end
function v_u31.SetWaypointsAlwaysOnTop(_, arg2)
	-- upvalues: (copy) v_u13
	v_u13.SetWaypointsAlwaysOnTop(arg2)
end
function v_u31.GetWaypointsAlwaysOnTop(_)
	-- upvalues: (copy) v_u13
	return v_u13.GetWaypointsAlwaysOnTop()
end
function v_u31.SetFailureAnimationEnabled(_, arg2)
	-- upvalues: (ref) v_u8
	v_u8 = arg2
end
function v_u31.GetFailureAnimationEnabled(_)
	-- upvalues: (ref) v_u8
	return v_u8
end
function v_u31.SetIgnoredPartsTag(_, arg2)
	-- upvalues: (copy) v_u22
	v_u22(arg2)
end
function v_u31.GetIgnoredPartsTag(_)
	-- upvalues: (ref) v_u19
	return v_u19
end
function v_u31.SetUseDirectPath(_, arg2)
	-- upvalues: (ref) v_u9
	v_u9 = arg2
end
function v_u31.GetUseDirectPath(_)
	-- upvalues: (ref) v_u9
	return v_u9
end
function v_u31.SetAgentSizeIncreaseFactor(_, arg2)
	-- upvalues: (ref) v_u10
	v_u10 = arg2 / 100 + 1
end
function v_u31.GetAgentSizeIncreaseFactor(_)
	-- upvalues: (ref) v_u10
	return (v_u10 - 1) * 100
end
function v_u31.SetUnreachableWaypointTimeout(_, arg2)
	-- upvalues: (ref) v_u11
	v_u11 = arg2
end
function v_u31.GetUnreachableWaypointTimeout(_)
	-- upvalues: (ref) v_u11
	return v_u11
end
function v_u31.SetUserJumpEnabled(arg1, arg2)
	arg1.jumpEnabled = arg2
	if arg1.touchJumpController then
		arg1.touchJumpController:Enable(arg2)
	end
end
function v_u31.GetUserJumpEnabled(arg1)
	return arg1.jumpEnabled
end
function v_u31.MoveTo(_, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u24, (copy) v_u29
	local v_character = v_u_localplayer.Character
	if v_character == nil then
		return false
	end
	local v1 = v_u24(arg2, Vector3.new(0, 1, 0), arg4)
	if not (v1 and v1:IsValidPath()) then
		return false
	end
	v_u29(v1, arg2, nil, v_character, arg3)
	return true
end
return v_u31