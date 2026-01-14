-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_u_collection = game:GetService("CollectionService")
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
local v_workspace = game:GetService("Workspace")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u_debris = workspace:WaitForChild("Debris")
local v_u_current_camera = v_workspace.CurrentCamera
local v_u_characteranimations = v_replicatedstorage:WaitForChild("Assets"):WaitForChild("CharacterAnimations")
local v_u2 = require(script.Components.GetMovementAnimation)
local v_u3 = require(script.Classes.CharacterAnimator)
local v_u4 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u5 = require(v_replicatedstorage.Database.Components.GameState)
local v_u6 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u7 = require(v_replicatedstorage.Shared.Janitor)
local v_u8 = require(v_replicatedstorage.Packages.Signal)
local v_u_getcontrols = require(v_u_localplayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.RespectCanCollide = true
if not v_u_localplayer:GetAttribute("DefaultCameraOffset") then
	v_u_localplayer:SetAttribute("DefaultCameraOffset", Vector3.new(0, -0.15, -0.5))
end
if not v_u_localplayer:GetAttribute("CrouchCameraOffset") then
	v_u_localplayer:SetAttribute("CrouchCameraOffset", Vector3.new(0, -1.4, 0))
end
local v_u9 = {
	["SSG 08"] = 13.6,
	["SG 553"] = 12,
	["AWP"] = 8,
	["AUG"] = 12,
	["SCAR-20"] = 8,
	["G3SG1"] = 8
}
local function v_u10()
	-- failed to decompile
end
function v_u1.GetMaxSpeed(arg1)
	-- upvalues: (copy) v_u5, (copy) v_u_localplayer, (copy) v_u4, (copy) v_u9
	if v_u5.GetState() == "Buy Period" then
		return 0
	end
	if v_u_localplayer:GetAttribute("IsDefusingBomb") then
		return 0
	end
	if v_u_localplayer:GetAttribute("IsRescuingHostage") then
		return 0
	end
	local v1 = v_u_localplayer:GetAttribute("IsCarryingHostage") and 0.75 or 1
	local v_getcurrentequipped = v_u4.getCurrentEquipped()
	if v_getcurrentequipped and (v_getcurrentequipped.Properties.Class == "C4" and v_getcurrentequipped.IsPlanting) then
		return 0
	end
	local v2 = not (v_getcurrentequipped and (v_getcurrentequipped.Properties and v_getcurrentequipped.Properties.WalkSpeed)) and 20 or v_getcurrentequipped.Properties.WalkSpeed
	local v3 = v_getcurrentequipped and (v_getcurrentequipped.IsAiming and v_u9[v_getcurrentequipped.Name])
	if v3 then
		return v3 * (arg1.IsWalking and 0.52 or 1) * (arg1.IsClimbing and 0.5 or 1) * (arg1.IsCrouching and not arg1.IsJumping and 0.34 or 1)
	end
	local v4 = arg1.IsCrouching and not arg1.IsJumping and 0.34 or (arg1.IsWalking and 0.52 or 1)
	local v5 = arg1.IsClimbing and 0.5 or 1
	if arg1.CanceledInertia then
		v2 = 2.424
	elseif arg1.IsJumping and not (arg1.IsAirStrafing or arg1.CanceledInertia) then
		v2 = math.max(arg1.LocalVelocityOnJump.Magnitude, 2.424)
	end
	return v2 * v4 * v5 * v1
end
function v_u1.ValidateHumanoidRootPart(arg1)
	local v_humanoidrootpart = arg1.HumanoidRootPart
	if v_humanoidrootpart and (v_humanoidrootpart.Parent and v_humanoidrootpart:IsDescendantOf(workspace)) then
		return v_humanoidrootpart
	else
		return nil
	end
end
function v_u1.TakeStamina(arg1, arg2)
	arg1.Stamina = math.clamp(arg1.Stamina - arg2, 0, 100)
end
function v_u1.ApplyFriction(arg1, arg2)
	if arg1.IsJumping then
		return
	else
		local v_magnitude = arg1.GlobalVelocity.Magnitude
		if v_magnitude >= 0.001 then
			local v1
			if arg1.GlobalDirection.Magnitude < 0.1 then
				v1 = math.max(v_magnitude, 5)
			else
				v1 = v_magnitude
			end
			local v_max = math.max(v_magnitude - v1 * 6 * arg2, 0)
			if v_max ~= v_magnitude then
				if v_max == 0 then
					arg1.GlobalVelocity = Vector3.new(0, 0, 0)
					return
				end
				arg1.GlobalVelocity = arg1.GlobalVelocity.Unit * v_max
			end
		end
	end
end
function v_u1.Accelerate(arg1, arg2, arg3, arg4, arg5)
	local v1 = arg3 - arg1.GlobalVelocity:Dot(arg2)
	if v1 > 0 then
		local v_min = math.min(arg4 * arg5 * arg3, v1)
		arg1.GlobalVelocity = arg1.GlobalVelocity + arg2 * v_min
	end
end
function v_u1.AirAccelerate(arg1, arg2, arg3, arg4)
	local v_min = math.min(arg3, 2.5)
	local v1 = v_min - arg1.GlobalVelocity:Dot(arg2)
	if v1 > 0 then
		local v2 = v_min * 100 * arg4
		if v1 >= v2 then
			v1 = v2
		end
		arg1.GlobalVelocity = arg1.GlobalVelocity + arg2 * v1
	end
end
function v_u1.CheckGroundContact(arg1)
	-- upvalues: (copy) v_u_current_camera, (copy) v_u_debris
	if not arg1.HumanoidRootPart then
		return false, nil, nil
	end
	local v_new = RaycastParams.new()
	v_new.FilterType = Enum.RaycastFilterType.Exclude
	v_new.FilterDescendantsInstances = { arg1.Character, v_u_current_camera, v_u_debris }
	v_new.RespectCanCollide = true
	local v_team = arg1.Player:GetAttribute("Team")
	if v_team then
		v_new.CollisionGroup = v_team
	end
	local v_position = arg1.HumanoidRootPart.Position
	for _, v1 in ipairs({
		Vector3.new(0, 0, 0),
		Vector3.new(0.8, 0, 0),
		Vector3.new(-0.8, 0, 0),
		Vector3.new(0, 0, 0.8),
		Vector3.new(0, 0, -0.8)
	}) do
		local v_raycast = workspace:Raycast(v_position + v1, Vector3.new(0, -3.1, 0), v_new)
		if v_raycast and (v_raycast.Normal.Y > 0.7 and v_raycast.Instance.CanCollide) then
			return true, v_raycast.Instance, v_raycast.Normal
		end
	end
	return false, nil, nil
end
function v_u1.SetTargetMoveDirection(arg1, arg2)
	if not arg2:FuzzyEq(arg1.TargetMoveDirection, 0.001) then
		arg1.TargetMoveDirection = arg2
		arg1.MoveDirectionChanged:Fire(arg2)
	end
end
function v_u1.Jump(arg1)
	-- upvalues: (copy) v_u5, (copy) v_u_localplayer, (copy) v_u4
	if v_u5.GetState() == "Buy Period" then
		return
	elseif v_u_localplayer:GetAttribute("IsDefusingBomb") then
		return
	else
		local v_getcurrentequipped = v_u4.getCurrentEquipped()
		if v_getcurrentequipped and (v_getcurrentequipped.Properties.Class == "C4" and v_getcurrentequipped.IsPlanting) then
			return
		elseif arg1.Character and (arg1.Humanoid and arg1.HumanoidRootPart) then
			if tick() - arg1.LastJumpTick < 0.15 and (arg1.LastJumpTick > 0 and (not (tick() - arg1.LastLandTick <= 0.5) or (arg1.LastAirTime or 0) < 0.15)) then
				arg1.IsJumpRequested = false
				return
			else
				if not arg1.IsClimbing then
					local v_getstate = arg1.Humanoid:GetState()
					if v_getstate == Enum.HumanoidStateType.Freefall or v_getstate == Enum.HumanoidStateType.Jumping then
						arg1.IsJumpRequested = false
						return
					end
				end
				local v_humanoidrootpart = arg1.HumanoidRootPart
				if arg1.IsClimbing and (arg1.IsJumpRequested and not arg1.JumpedOffLadder) then
					arg1.LastLadderJumpTick = tick()
					arg1.JumpedOffLadder = true
					local v1 = Vector3.new(0, 0, 1)
					local v_ladderzone = arg1.LadderZone
					if v_ladderzone then
						local v_getladdercframe = arg1:GetLadderCFrame(v_ladderzone)
						if v_getladdercframe then
							local v_position = v_humanoidrootpart.Position
							local v_position = v_getladdercframe.Position
							local v_new = Vector3.new(v_position.X - v_position.X, 0, v_position.Z - v_position.Z)
							if v_new.Magnitude > 0.1 then
								v1 = -v_new.Unit
							end
						end
					end
					local v_new = Vector3.new(v1.X * 12, -1 - (arg1.LadderClimbPercentage or 0.5) * 2, v1.Z * 12)
					print("[Ladder Debug] Jumping off ladder", "climb%:", string.format("%.2f", UNNAMED_1728998388728), "jumpVel:", v_new)
					arg1.ClimbEnded:Fire(arg1.LadderZone, true)
					local v2
					if v_new == v_new then
						v2 = v_new.Magnitude < 10000
					else
						v2 = false
					end
					if v2 then
						v_humanoidrootpart.AssemblyLinearVelocity = v_new
						arg1.GlobalVelocity = Vector3.new(v_new.X, 0, v_new.Z)
					end
					arg1.ReadyToJump = false
					arg1.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
				elseif not arg1.IsClimbing and (not arg1.IsJumping and (arg1.IsJumpRequested and arg1.Stamina >= 20)) then
					arg1.Humanoid.JumpPower = 19.5
					if arg1.AgainstWall then
						arg1.GlobalVelocity = Vector3.new(0, 0, 0)
					end
					local v_new = Vector3.new(arg1.HumanoidRootPart.AssemblyLinearVelocity.X, 0, arg1.HumanoidRootPart.AssemblyLinearVelocity.Z)
					local v_movedirection = arg1.Humanoid.MoveDirection
					if v_new.Magnitude < 1 and v_movedirection.Magnitude > 0.1 then
						local v_new = RaycastParams.new()
						v_new.FilterType = Enum.RaycastFilterType.Exclude
						v_new.FilterDescendantsInstances = { arg1.Character }
						local v_raycast = workspace:Raycast(arg1.HumanoidRootPart.Position, v_movedirection * 2, v_new)
						if v_raycast and math.abs(v_raycast.Normal.Y) < 0.5 then
							local v3 = Vector3.new(v_raycast.Normal.X, 0, v_raycast.Normal.Z).Unit * 400
							arg1.HumanoidRootPart:ApplyImpulse((Vector3.new(v3.X, arg1.HumanoidRootPart.AssemblyLinearVelocity.Y, v3.Z)))
						end
					end
					if arg1.HumanoidRootPart.AssemblyLinearVelocity.Y > 5 then
						local v_assemblylinearvelocity = arg1.HumanoidRootPart.AssemblyLinearVelocity
						arg1.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(v_assemblylinearvelocity.X, 0, v_assemblylinearvelocity.Z)
					end
					arg1.Humanoid.Jump = true
					arg1.IsJumping = true
					arg1.LastJumpTick = tick()
					arg1.ReadyToJump = false
					arg1.IsJumpRequested = false
					arg1.Jumping:Fire()
					arg1.CharacterAnimator:play("Jump", 0.2)
				end
			end
		else
			return
		end
	end
end
function v_u1.AddLadder(arg1, arg2)
	if not arg1.LadderZones[arg2] then
		arg2.Anchored = true
		arg2.CollisionGroup = "Debris"
		arg2.CastShadow = false
		arg2.CanCollide = false
		arg2.CanTouch = false
		arg2.Transparency = 1
		arg1.LadderZones[arg2] = {
			["CFrame"] = arg2.CFrame,
			["Extents"] = arg2.Size / 2,
			["Part"] = arg2
		}
	end
end
function v_u1.RemoveLadder(arg1, arg2)
	arg1.LadderZones[arg2] = nil
end
function v_u1.GetLadderCFrame(_, arg2)
	if arg2.Part and arg2.Part.Parent then
		return arg2.Part.CFrame
	else
		return nil
	end
end
function v_u1.ForceExitLadder(arg1, arg2)
	if arg1.IsClimbing then
		print("[Ladder Debug] ForceExitLadder reason:", arg2 or "unknown")
		arg1.VectorForce.Enabled = false
		arg1.IsClimbing = false
		arg1.LadderZone = nil
		arg1.LadderClimbPercentage = 0
		arg1.LastLadderJumpTick = tick()
		if arg1.Humanoid then
			arg1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
		end
		arg1.Climbing:Fire()
	end
end
function v_u1.GetLadderClimbPercentage(arg1, arg2)
	local v_validatehumanoidrootpart = arg1:ValidateHumanoidRootPart()
	if v_validatehumanoidrootpart then
		local v_getladdercframe = arg1:GetLadderCFrame(arg2)
		if v_getladdercframe then
			local v1 = arg2.Extents.Y * 2
			if v1 <= 0 then
				warn("[Character] Invalid ladder height:", v1)
				return 0.5
			else
				local v2 = v_getladdercframe.Position - Vector3.new(0, arg2.Extents.Y, 0)
				local v_position = v_validatehumanoidrootpart.Position
				if v_position == v_position and v2 == v2 then
					local v_clamp = math.clamp((v_position.Y - v2.Y) / v1, 0, 1)
					return v_clamp ~= v_clamp and 0.5 or v_clamp
				else
					warn("[Character] Invalid positions in climb calculation")
					return 0.5
				end
			end
		else
			return 0
		end
	else
		return 0
	end
end
function v_u1.CheckLadderOverlap(arg1, arg2)
	local v_validatehumanoidrootpart = arg1:ValidateHumanoidRootPart()
	if v_validatehumanoidrootpart then
		local v_getladdercframe = arg1:GetLadderCFrame(arg2)
		if v_getladdercframe then
			local v_extents = arg2.Extents
			local v1 = v_getladdercframe:Inverse() * v_validatehumanoidrootpart.Position
			local v_abs = math.abs(v1.X)
			local v_abs = math.abs(v1.Z)
			local v2 = v1.Y >= v_extents.Y - 1
			local v_humanoid = arg1.Character:FindFirstChildOfClass("Humanoid")
			if v_humanoid then
				v_humanoid = v_humanoid.FloorMaterial ~= Enum.Material.Air
			end
			if v2 and v_humanoid then
				return false
			else
				local v3
				if v_extents.X > v_extents.Z then
					if v_extents.Z * 0.5 <= v_abs then
						v3 = v_abs <= v_extents.Z + 2
					else
						v3 = false
					end
				elseif v_extents.X * 0.5 <= v_abs then
					v3 = v_abs <= v_extents.X + 2
				else
					v3 = false
				end
				if v1.Y <= v_extents.Y + 0.8 + (v3 and 3 or 0.5) and v1.Y >= -(v_extents.Y + 0.8 + 3) then
					if v_extents.X > v_extents.Z then
						if v_extents.X + 0.8 < v_abs then
							return false
						elseif v_extents.X < v_abs and v_abs < v_extents.Z * 2 then
							return false
						else
							return v_abs <= v_extents.Z + 2
						end
					elseif v_extents.Z + 0.8 < v_abs then
						return false
					elseif v_extents.Z < v_abs and v_abs < v_extents.X * 2 then
						return false
					else
						return v_abs <= v_extents.X + 2
					end
				else
					return false
				end
			end
		else
			return false
		end
	else
		return false
	end
end
function v_u1.FindNearestLadder(arg1)
	local v_validatehumanoidrootpart = arg1:ValidateHumanoidRootPart()
	if not v_validatehumanoidrootpart then
		return nil
	end
	local v_position = v_validatehumanoidrootpart.Position
	local v1 = 0
	local v2 = (1 / 0)
	local v3 = nil
	for _, v4 in pairs(arg1.LadderZones) do
		v1 = v1 + 1
		local v_getladdercframe = arg1:GetLadderCFrame(v4)
		if v_getladdercframe then
			local v_magnitude = Vector3.new(v_position.X - v_getladdercframe.Position.X, 0, v_position.Z - v_getladdercframe.Position.Z).Magnitude
			if v_magnitude <= 2 and (arg1:CheckLadderOverlap(v4) and v_magnitude < v2) then
				v3 = v4
				v2 = v_magnitude
			end
		end
	end
	local _ = v1 == 0
	return v3
end
function v_u1.MoveFunction(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_current_camera, (copy) v_u_new, (copy) v_u_debris, (copy) v_u10, (copy) v_u_getcontrols, (copy) v_u_localplayer
	if arg1.MaxSpeed == 0 then
		return
	end
	local v_validatehumanoidrootpart = arg1:ValidateHumanoidRootPart()
	if not v_validatehumanoidrootpart then
		if arg1.IsClimbing then
			arg1:ForceExitLadder("Invalid HumanoidRootPart at MoveFunction start")
		end
		return
	end
	local v1 = tick()
	local v2 = v1 - arg1.LastMoveUpdate
	local v_getmaxspeed = arg1:GetMaxSpeed()
	arg1.GlobalDirection = Vector3.new(0, 0, 0)
	local v3 = Vector3.new(0, 0, 0)
	local v_checkgroundcontact, _, _ = arg1:CheckGroundContact()
	if v_checkgroundcontact and (arg1.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and v_validatehumanoidrootpart.AssemblyLinearVelocity.Y <= 1) then
		local v_assemblylinearvelocity = v_validatehumanoidrootpart.AssemblyLinearVelocity
		local v_new = Vector3.new(v_assemblylinearvelocity.X, 0, v_assemblylinearvelocity.Z)
		local v4
		if v_new == v_new then
			v4 = v_new.Magnitude < 10000
		else
			v4 = false
		end
		if v4 then
			v_validatehumanoidrootpart.AssemblyLinearVelocity = v_new
		end
		arg1.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
		arg1.IsJumping = false
		arg1.IsLanded = true
		arg1.ReadyToJump = true
		arg1.LockedAirDirection = nil
	end
	if arg1.IsJumping and (v_checkgroundcontact and tick() - arg1.LastJumpTick >= 0.15) then
		local v_y = v_validatehumanoidrootpart.AssemblyLinearVelocity.Y
		if v_y <= 1 then
			arg1.LastAirTime = tick() - (arg1.LastFreefallTick or arg1.LastJumpTick)
			arg1.LandingVelocityY = arg1.PeakFallVelocity or v_y
			arg1.IsJumping = false
			arg1.IsLanded = true
			arg1.LandAtPosition = v_validatehumanoidrootpart.CFrame.Position
			arg1.LastLandTick = tick()
			arg1.ReadyToJump = true
			arg1.LockedAirDirection = nil
			arg1.CharacterAnimator:stop("Jump", 0.2)
			arg1.Landed:Fire()
		end
	end
	local v_getstate = arg1.Humanoid:GetState()
	if v_getstate == Enum.HumanoidStateType.Freefall and true or v_getstate == Enum.HumanoidStateType.Jumping then
		if not arg1.LastFreefallTick then
			arg1.LastFreefallTick = tick()
			arg1.PeakFallVelocity = 0
		end
		local v_y = v_validatehumanoidrootpart.AssemblyLinearVelocity.Y
		if v_y < (arg1.PeakFallVelocity or 0) then
			arg1.PeakFallVelocity = v_y
		end
	end
	local v_toeuleranglesxyz, v5, v6 = v_u_current_camera.CFrame:ToEulerAnglesXYZ()
	local v7 = CFrame.new(UNNAMED_1728997147320.Position) * CFrame.fromEulerAnglesXYZ(v_toeuleranglesxyz, v5, v6)
	if arg2.Magnitude > 0 then
		if arg3 then
			arg1.GlobalDirection = v7:VectorToWorldSpace(arg2)
		else
			arg1.GlobalDirection = arg2
			arg2 = v7:VectorToObjectSpace(arg2)
		end
	else
		arg2 = v3
	end
	local v_new = Vector3.new(v7.LookVector.X, 0, v7.LookVector.Z)
	local v_y = Vector3.new(arg1.LastCameraCFrame.LookVector.X, 0, arg1.LastCameraCFrame.LookVector.Z):Cross(v_new).Y
	arg1.LocalVelocity = v7:VectorToObjectSpace(arg1.GlobalVelocity)
	local v_angle = arg1.LocalVelocity:Angle(arg2, Vector3.new(0, 1, 0))
	local _ = v_angle == v_angle
	v_new.Unit:Angle(arg1.GlobalDirection, Vector3.new(0, 1, 0))
	local v_angle = arg1.GlobalDirection:Angle(arg1.GlobalVelocity, Vector3.new(0, 1, 0))
	math.abs(v_angle)
	local v8 = math.abs(arg2.X) > 0.1
	local v9 = arg2.Z <= 0
	local v10 = math.abs(v_y) > 0.02
	local v_sign = math.sign(arg2.X)
	local v_sign = math.sign(v_y)
	local v_isjumping = arg1.IsJumping
	if v_isjumping then
		if v8 then
			if v9 then
				if v10 then
					v10 = v_sign == -v_sign
				end
			else
				v10 = v9
			end
		else
			v10 = v8
		end
	else
		v10 = v_isjumping
	end
	arg1.IsAirStrafing = v10
	local v11
	if arg1.GlobalDirection.Magnitude > 0 then
		v11 = arg1.GlobalDirection.Unit
	else
		v_getmaxspeed = 0
		v11 = Vector3.new(0, 0, 0)
	end
	if arg1.IsJumping then
		local v_assemblylinearvelocity = v_validatehumanoidrootpart.AssemblyLinearVelocity
		arg1.GlobalVelocity = Vector3.new(v_assemblylinearvelocity.X, 0, v_assemblylinearvelocity.Z)
		if v_getmaxspeed > 0 then
			arg1:AirAccelerate(v11, v_getmaxspeed, v2)
		end
		if arg1.IsAirStrafing then
			local v_magnitude = arg1.GlobalVelocity.Magnitude
			if v_magnitude > 0.1 then
				local v_new = Vector3.new(v_new.X, 0, v_new.Z)
				if v_new.Magnitude > 0 then
					local v_unit = arg1.GlobalVelocity.Unit
					local v_min = math.min(1, 5 * v2 * 10)
					local v12 = v_unit + (v_new.Unit - v_unit) * v_min
					if v12.Magnitude > 0 then
						arg1.GlobalVelocity = v12.Unit * v_magnitude
					end
				end
			end
		end
		if arg1.GlobalVelocity.Magnitude > 24.5 then
			arg1.GlobalVelocity = arg1.GlobalVelocity * (24.5 / UNNAMED_1728999379736)
		end
		local v_new = Vector3.new(arg1.GlobalVelocity.X, v_assemblylinearvelocity.Y, arg1.GlobalVelocity.Z)
		local v13
		if v_new == v_new then
			v13 = v_new.Magnitude < 10000
		else
			v13 = false
		end
		if v13 then
			v_validatehumanoidrootpart.AssemblyLinearVelocity = v_new
		end
	else
		local v14
		if tick() - arg1.LastLandTick < 0.5 then
			v14 = arg1.IsJumpRequested
		else
			v14 = false
		end
		if not v14 then
			arg1:ApplyFriction(v2)
		end
		if v_getmaxspeed > 0 then
			arg1:Accelerate(v11, math.min(v_getmaxspeed, 24.5), 6, v2)
		end
	end
	local v_magnitude = Vector3.new(arg1.GlobalVelocity.X, 0, arg1.GlobalVelocity.Z).Magnitude
	local _ = arg1.IsJumping or arg1.IsBhopAttempt
	local v15 = 24.5
	if v15 < v_magnitude then
		local v16 = v15 / v_magnitude
		arg1.GlobalVelocity = Vector3.new(arg1.GlobalVelocity.X * v16, arg1.GlobalVelocity.Y, arg1.GlobalVelocity.Z * v16)
	end
	arg1.Humanoid.WalkSpeed = arg1.LocalVelocity.Magnitude
	v_u_new.FilterDescendantsInstances = { arg1.Character, v_u_current_camera, v_u_debris }
	local v_team = arg1.Player:GetAttribute("Team")
	if v_team then
		v_u_new.CollisionGroup = v_team
	end
	arg1.AgainstWall = false
	arg1.WallNormal = nil
	if arg1.IsJumping then
		local v_assemblylinearvelocity = v_validatehumanoidrootpart.AssemblyLinearVelocity
		local v_new = Vector3.new(v_assemblylinearvelocity.X, 0, v_assemblylinearvelocity.Z)
		local v_magnitude = v_new.Magnitude
		local v_position = v_validatehumanoidrootpart.Position
		local v17 = tick()
		if arg1.LastWallNormal and v17 - arg1.LastWallHitTime < 0.15 then
			local v_lastwallnormal = arg1.LastWallNormal
			local v_dot = v_new:Dot((Vector3.new(v_lastwallnormal.X, 0, v_lastwallnormal.Z)))
			if v_dot > 0.5 then
				v_assemblylinearvelocity = v_assemblylinearvelocity - Vector3.new(v_lastwallnormal.X, 0, v_lastwallnormal.Z) * v_dot
				local v18
				if v_assemblylinearvelocity == v_assemblylinearvelocity then
					v18 = v_assemblylinearvelocity.Magnitude < 10000
				else
					v18 = false
				end
				if v18 then
					v_validatehumanoidrootpart.AssemblyLinearVelocity = v_assemblylinearvelocity
				end
				v_new = Vector3.new(v_assemblylinearvelocity.X, 0, v_assemblylinearvelocity.Z)
				v_magnitude = v_new.Magnitude
			end
		end
		local v19 = { Vector3.new(0, 0, 0), v_validatehumanoidrootpart.CFrame.RightVector * 1 * 0.8, -v_validatehumanoidrootpart.CFrame.RightVector * 1 * 0.8 }
		local v20 = {}
		if v_magnitude > 0.5 then
			table.insert(v20, v_new.Unit)
		end
		local v_new = Vector3.new(arg1.GlobalDirection.X, 0, arg1.GlobalDirection.Z)
		if v_new.Magnitude > 0.1 then
			table.insert(v20, v_new.Unit)
		end
		for _, v21 in ipairs(v20) do
			for _, v22 in ipairs(v19) do
				local v_raycast = workspace:Raycast(v_position + v22, v21 * (0.5 + (v_magnitude > 0.5 and (v_magnitude * 0.02 or 0.3) or 0.3)), v_u_new)
				if v_raycast then
					local v_normal = v_raycast.Normal
					if math.abs(v_normal.Y) < 0.7 then
						arg1.AgainstWall = true
						arg1.WallNormal = v_normal
						arg1.LastWallNormal = v_normal
						arg1.LastWallHitTime = v17
						local v23 = v_u10(v_assemblylinearvelocity, v_normal, 1)
						local v_new = Vector3.new(v23.X, 0, v23.Z)
						if v_new.Magnitude < v_magnitude * 0.3 then
							v23 = Vector3.new(0, v_assemblylinearvelocity.Y, 0)
							arg1.GlobalVelocity = Vector3.new(0, 0, 0)
						else
							arg1.GlobalVelocity = v_new
						end
						local v24
						if v23 == v23 then
							v24 = v23.Magnitude < 10000
						else
							v24 = false
						end
						if v24 then
							v_validatehumanoidrootpart.AssemblyLinearVelocity = v23
						end
						break
					end
				end
			end
			if arg1.AgainstWall then
				break
			end
		end
	end
	if v_validatehumanoidrootpart and (arg1.IsCrouching and not arg1.CrouchInputDown) then
		arg1.CrouchHeadBlocked = workspace:Spherecast(v_validatehumanoidrootpart.CFrame.Position, 1.5, Vector3.new(0, 1, 0), v_u_new) ~= nil
	end
	if v_validatehumanoidrootpart then
		if arg1.IsClimbing then
			local v_ladderzone = arg1.LadderZone
			if v_ladderzone then
				local v_getladdercframe = arg1:GetLadderCFrame(v_ladderzone)
				if not v_getladdercframe then
					arg1:ForceExitLadder("Ladder part removed")
					return
				end
				local v_position = v_validatehumanoidrootpart.Position
				local v25 = v_position.Y - 2.5
				local v_position = v_getladdercframe.Position
				local v26 = v_position.Y - v_ladderzone.Extents.Y
				local v_clamp = math.clamp((v25 - v26) / (v_position.Y + v_ladderzone.Extents.Y - v26), 0, 1)
				arg1.LadderClimbPercentage = v_clamp
				local v_magnitude = Vector3.new(v_position.X - v_position.X, 0, v_position.Z - v_position.Z).Magnitude
				if v_magnitude > 50 then
					print("[Ladder Debug] Sanity check failed - distance:", string.format("%.2f", v_magnitude))
					arg1:ForceExitLadder("Distance sanity check failed")
					return
				end
				local v27 = v_clamp <= 0.15
				local v28 = v_clamp >= 0.98
				local v29 = v_magnitude > 2.5
				local v_globaldirection = arg1.GlobalDirection
				local v_new = Vector3.new(v_globaldirection.X, 0, v_globaldirection.Z)
				if v_new.Magnitude > 0.1 then
					v_new = v_new.Unit
				end
				local v_new = Vector3.new(v7.LookVector.X, 0, v7.LookVector.Z)
				if v_new.Magnitude > 0 then
					v_new = v_new.Unit
				end
				local v_dot = v_new:Dot(v_new)
				local v_new = Vector3.new(v_position.X - v_position.X, 0, v_position.Z - v_position.Z)
				if v_new.Magnitude > 0.1 and v_new:Dot(v_new.Unit) <= 0 then
					v_dot = -v_dot
				end
				local v30 = v_dot > 0.1
				local v31 = v_dot < -0.1
				local v32 = tick() - (arg1.LastLadderAttachTick or 0) >= 0.1
				if v29 then
					v32 = v29
				elseif not (v27 and (v31 and v32)) then
					if v28 then
						if not v30 then
							v32 = v30
						end
					else
						v32 = v28
					end
				end
				if UNNAMED_1729003639832 + 0.5 <= v25 and true or v32 then
					print("[Ladder Debug] Detaching", "reason:", v29 and "TooFar" or (v27 and v31 and "BottomExit" or (v28 and v30 and "TopExit" or "FeetAboveTop")), "climb%:", string.format("%.2f", v_clamp), "dist:", string.format("%.2f", v_magnitude), "verticalInput:", string.format("%.2f", v_dot))
					if v28 and v30 then
						local v33 = v_new * 8
						local v_new = Vector3.new(v33.X, 2, v33.Z)
						local v34
						if v_new == v_new then
							v34 = v_new.Magnitude < 10000
						else
							v34 = false
						end
						if v34 then
							v_validatehumanoidrootpart.AssemblyLinearVelocity = v_new
							arg1.GlobalVelocity = v33
						end
					end
					arg1.ClimbEnded:Fire(v_ladderzone, false)
				end
			end
		else
			local v35 = tick() - (arg1.LastLadderJumpTick or 0) > (arg1.JumpedOffLadder and 0.5 or 0.25) and arg1:FindNearestLadder()
			if v35 then
				arg1.ClimbBegan:Fire(v35)
			end
		end
	end
	local v36 = Vector3.new(0, 0, 0)
	if arg1.IsClimbing and not arg1.JumpedOffLadder then
		local v_ladderzone = arg1.LadderZone
		arg1.GlobalVelocity = Vector3.new(0, 0, 0)
		if v_ladderzone and v_validatehumanoidrootpart then
			local v_globaldirection = arg1.GlobalDirection
			local v_new = Vector3.new(v_globaldirection.X, 0, v_globaldirection.Z)
			local v_new = Vector3.new(v7.LookVector.X, 0, v7.LookVector.Z)
			local v_new = Vector3.new(v7.RightVector.X, 0, v7.RightVector.Z)
			if v_new.Magnitude > 0.1 then
				v_new = v_new.Unit
			end
			local v37 = v_new.Magnitude <= 0 and Vector3.new(0, 0, -1) or v_new.Unit
			if v_new.Magnitude > 0 then
				v_new = v_new.Unit
			end
			local v38 = arg1.LadderClimbPercentage or 0
			local v39 = v38 >= 0.98
			local v40 = v38 <= 0.15
			local v_dot = v_new:Dot(v37)
			local v_dot = v_new:Dot(v_new)
			local v41 = v_globaldirection.Magnitude > 0.1
			local v_getladdercframe = arg1:GetLadderCFrame(v_ladderzone)
			if not v_getladdercframe then
				arg1:ForceExitLadder("Ladder part removed during climb")
				return
			end
			local v_position = v_validatehumanoidrootpart.Position
			local v_position = v_getladdercframe.Position
			local v_new = Vector3.new(v_position.X - v_position.X, 0, v_position.Z - v_position.Z)
			if v_new.Magnitude > 0.1 and v37:Dot(v_new.Unit) <= 0 then
				v_dot = -v_dot
			end
			local v42 = tick() - (arg1.LastLadderAttachTick or 0) >= 0.1
			if v39 and (v_dot > 0.1 and v42) then
				print("[Ladder Debug] Auto-detach at top", "climb%:", string.format("%.2f", v38), "verticalInput:", string.format("%.2f", v_dot))
				local v43 = v37 * 8
				local v_new = Vector3.new(v43.X, 2, v43.Z)
				local v44
				if v_new == v_new then
					v44 = v_new.Magnitude < 10000
				else
					v44 = false
				end
				if v44 then
					v_validatehumanoidrootpart.AssemblyLinearVelocity = v_new
					arg1.GlobalVelocity = v43
				end
				arg1.ClimbEnded:Fire(v_ladderzone, false)
				return
			end
			if v40 and (v_dot < -0.1 and v42) then
				print("[Ladder Debug] Auto-detach at bottom", "climb%:", string.format("%.2f", v38), "verticalInput:", string.format("%.2f", v_dot))
				arg1.ClimbEnded:Fire(v_ladderzone, false)
				return
			end
			if v41 then
				if math.abs(v_dot) > 0.1 then
					local v45 = 14 * v_dot
					if math.abs(v_dot) > 0.1 then
						v45 = v45 * 1.15
					end
					v36 = Vector3.new(0, v45, 0)
				end
				if math.abs(v_dot) > 0.1 then
					local v_getladdercframe = arg1:GetLadderCFrame(v_ladderzone)
					if not v_getladdercframe then
						arg1:ForceExitLadder("Ladder part removed during strafe")
						return
					end
					local v_rightvector = v_getladdercframe.RightVector
					if math.abs(v_getladdercframe:VectorToObjectSpace(v_position - v_position).X + v_dot * 0.5) < v_ladderzone.Extents.X * 0.8 then
						v36 = v36 + v_rightvector * (5.6000000000000005 * v_dot)
					end
				end
			end
		end
		local v46 = v_validatehumanoidrootpart and arg1.Character.PrimaryPart
		if v46 then
			local v47
			if v36 == v36 then
				v47 = v36.Magnitude < 10000
			else
				v47 = false
			end
			if v47 then
				v46.AssemblyLinearVelocity = v36
			end
		end
	end
	local v48 = not v_u_getcontrols.activeController:GetIsJumping() and v_u_getcontrols.touchJumpController
	if v48 then
		v48 = v_u_getcontrols.touchJumpController:GetIsJumping()
	end
	if v48 and not (arg1.IsJumping or arg1.IsJumpRequested) then
		arg1.IsJumpRequested = true
	elseif not v48 then
		arg1.IsJumpRequested = false
	end
	arg1:Jump()
	arg1.LastCameraCFrame = v7
	v_u_localplayer:Move(arg1.GlobalVelocity, false)
	arg1.LastMoveUpdate = v1
end
function v_u1.StopMovementAnimations(arg1)
	-- upvalues: (copy) v_u_characteranimations
	local v1 = {}
	local v_crouch = v_u_characteranimations:FindFirstChild("Crouch")
	if v_crouch then
		for _, v2 in ipairs(v_crouch:GetDescendants()) do
			if v2:IsA("Animation") then
				v1[v2.Name] = true
			end
		end
	end
	local v_movement = v_u_characteranimations:FindFirstChild("Movement")
	if v_movement then
		local v_walking = v_movement:FindFirstChild("Walking")
		if v_walking then
			for _, v3 in ipairs(v_walking:GetDescendants()) do
				if v3:IsA("Animation") then
					v1[v3.Name] = true
				end
			end
		end
	end
	for v4, v5 in pairs(arg1.CharacterAnimator.Animations) do
		if v4 ~= "Jump" and (v1[v4] and v5.IsPlaying) then
			arg1.CharacterAnimator:stop(v4, 0.2)
		end
	end
end
function v_u1.ToggleWalkState(arg1, arg2)
	-- upvalues: (copy) v_u6
	if arg2 ~= arg1.IsWalking then
		arg1.IsWalking = arg2
		v_u6.Character.UpdateWalkState.Send(arg1.IsWalking)
		arg1.Walking:Fire(arg1.IsWalking)
	end
end
function v_u1.ToggleCrouchInput(arg1, arg2)
	arg1.CrouchInputDown = arg2
end
function v_u1.PlantBomb(arg1)
	-- upvalues: (copy) v_u_tween
	if not arg1.IsPlantingBomb then
		arg1.IsPlantingBomb = true
		if arg1.BombPlantTween then
			arg1.BombPlantTween:Cancel()
			arg1.BombPlantTween = nil
		end
		local v_new = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
		arg1.BombPlantTween = arg1.Janitor:Add(v_u_tween:Create(arg1.Humanoid, v_new, {
			["CameraOffset"] = Vector3.new(0, -0.9, 0) + arg1.DefaultCameraOffset
		}))
		arg1.BombPlantTween:Play()
	end
end
function v_u1.CancelBombPlant(arg1)
	-- upvalues: (copy) v_u_tween
	if arg1.IsPlantingBomb then
		arg1.IsPlantingBomb = false
		if arg1.BombPlantTween then
			arg1.BombPlantTween:Cancel()
			arg1.BombPlantTween = nil
		end
		local v_new = TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
		arg1.Janitor:Add(v_u_tween:Create(arg1.Humanoid, v_new, {
			["CameraOffset"] = arg1.DefaultCameraOffset
		})):Play()
	end
end
function v_u1.ToggleCrouchState(arg1, arg2)
	-- upvalues: (copy) v_u4, (copy) v_u6, (copy) v_u_tween
	local v_getcurrentequipped = v_u4.getCurrentEquipped()
	if v_getcurrentequipped and (v_getcurrentequipped.Properties.Class == "C4" and v_getcurrentequipped.IsPlanting) then
		return
	elseif arg2 ~= arg1.IsCrouching then
		local v1 = tick()
		arg1.IsCrouching = arg2
		v_u6.Character.UpdateCrouchState.Send(arg1.IsCrouching)
		if arg1.CrouchTween then
			arg1.CrouchTween:Cancel()
			arg1.CrouchTween = nil
		end
		if arg1.IsCrouching then
			arg1.CrouchCount = arg1.CrouchCount + 1
			if v1 - arg1.LastCrouchTick > 0.5 then
				arg1.CrouchCount = 0
			end
			local v_min = math.min(arg1.CrouchCount * 0.05 + 0.15, 0.4)
			arg1.LastCrouchTick = v1
			local v_new = TweenInfo.new(v_min, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
			arg1.CrouchTween = arg1.Janitor:Add(v_u_tween:Create(arg1.Humanoid, v_new, {
				["CameraOffset"] = arg1.CrouchCameraOffset + arg1.DefaultCameraOffset
			}))
			arg1.CrouchTween:Play()
		else
			local v_min = math.min(arg1.CrouchCount * 0.05 + 0.15, 0.4)
			local v_new = TweenInfo.new(v_min, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
			arg1.CrouchTween = arg1.Janitor:Add(v_u_tween:Create(arg1.Humanoid, v_new, {
				["CameraOffset"] = arg1.DefaultCameraOffset
			}))
			arg1.CrouchTween:Play()
		end
		arg1.LastCrouchTick = v1
		arg1.Crouching:Fire(arg1.IsCrouching)
	end
end
function v_u1.UpdateCharacterAnimations(arg1, _)
	-- upvalues: (copy) v_u2
	if arg1.IsJumping then
		arg1.CurrentMovementAnimation = nil
		arg1:StopMovementAnimations()
	else
		local v_crouchidle = arg1.CharacterAnimator:getAnimation("CrouchIdle")
		local v1 = v_u2(arg1.Character)
		if arg1.IsCrouching then
			if arg1.Humanoid.MoveDirection.Magnitude <= 0.1 then
				if not v_crouchidle.IsPlaying then
					arg1.CurrentMovementAnimation = nil
					arg1:StopMovementAnimations()
					arg1.CharacterAnimator:play("CrouchIdle", (math.min(arg1.CrouchCount * 0.05 + 0.15, 0.4)))
				end
				return
			end
			v1 = ("Crouch%*"):format(v1)
			if v_crouchidle.IsPlaying then
				arg1.CharacterAnimator:stop("CrouchIdle", (math.min(arg1.CrouchCount * 0.05 + 0.15, 0.4)))
			end
		elseif v_crouchidle.IsPlaying then
			arg1.CharacterAnimator:stop("CrouchIdle", (math.min(arg1.CrouchCount * 0.05 + 0.15, 0.4)))
		end
		local v_getanimation = arg1.CharacterAnimator:getAnimation(v1)
		if v_getanimation then
			v_getanimation:AdjustSpeed(arg1.Humanoid.MoveDirection.Magnitude * arg1.Humanoid.WalkSpeed / (arg1.IsCrouching and 12 or 16))
		end
		if arg1.CurrentMovementAnimation ~= v1 then
			arg1.CurrentMovementAnimation = v1
			arg1:StopMovementAnimations()
			if v_getanimation then
				v_getanimation:Play(0.15)
			end
		end
	end
end
function v_u1.new(arg1, arg2, arg3)
	-- upvalues: (copy) v_u1, (copy) v_u7, (copy) v_u_localplayer, (copy) v_u3, (copy) v_u_current_camera, (copy) v_u8, (copy) v_u_getcontrols, (copy) v_u6, (copy) v_u_run, (copy) v_u_collection
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u7.new()
	v_u1.DefaultCameraOffset = v_u_localplayer:GetAttribute("DefaultCameraOffset") or Vector3.new(0, -0.15, -0.5)
	v_u1.CrouchCameraOffset = v_u_localplayer:GetAttribute("CrouchCameraOffset") or Vector3.new(0, -1.4, 0)
	v_u1.Janitor:Add(v_u_localplayer:GetAttributeChangedSignal("DefaultCameraOffset"):Connect(function()
		-- upvalues: (copy) v_u1, (ref) v_u_localplayer
		v_u1.DefaultCameraOffset = v_u_localplayer:GetAttribute("DefaultCameraOffset") or Vector3.new(0, -0.15, -0.5)
	end))
	v_u1.Janitor:Add(v_u_localplayer:GetAttributeChangedSignal("CrouchCameraOffset"):Connect(function()
		-- upvalues: (copy) v_u1, (ref) v_u_localplayer
		v_u1.CrouchCameraOffset = v_u_localplayer:GetAttribute("CrouchCameraOffset") or Vector3.new(0, -1.4, 0)
	end))
	v_u1.CharacterAnimator = v_u3.new(arg1)
	v_u1.HumanoidRootPart = arg2
	v_u1.Character = arg1
	v_u1.Humanoid = arg3
	v_u1.Player = v_u_localplayer
	v_u1.Janitor:Add(arg2.AncestryChanged:Connect(function(_, arg2)
		-- upvalues: (copy) v_u1
		if not arg2 then
			if v_u1.IsClimbing then
				v_u1:ForceExitLadder("HumanoidRootPart removed")
			end
			v_u1.HumanoidRootPart = nil
		end
	end))
	v_u1.Humanoid.WalkSpeed = 20
	v_u1.Humanoid.AutoRotate = false
	v_u1.Humanoid.MaxSlopeAngle = 90
	if v_u_localplayer:GetAttribute("SV_ACCELERATE") == nil then
		v_u_localplayer:SetAttribute("SV_ACCELERATE", 6)
	end
	if v_u_localplayer:GetAttribute("SV_STOPSPEED") == nil then
		v_u_localplayer:SetAttribute("SV_STOPSPEED", 5)
	end
	if v_u_localplayer:GetAttribute("SV_FRICTION") == nil then
		v_u_localplayer:SetAttribute("SV_FRICTION", 6)
	end
	local function v_u2(arg1)
		if arg1.Name == "CollisionCapsule" then
			arg1.CanCollide = false
			return
		elseif arg1.Name == "HumanoidRootPart" and arg1:IsA("Part") then
			arg1.CanCollide = true
			arg1.Size = Vector3.new(2, 2, 2)
			arg1.Shape = Enum.PartType.Ball
			arg1.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0, 1, 1)
			return
		elseif arg1.Name == "Head" then
			arg1.CanCollide = true
			return
		elseif arg1.Name == "UpperTorso" or arg1.Name == "LowerTorso" then
			arg1.CanCollide = false
		else
			arg1.CanCollide = false
		end
	end
	for _, v3 in ipairs(arg1:GetDescendants()) do
		if v3:IsA("BasePart") then
			v_u2(v3)
		end
	end
	v_u1.Janitor:Add(arg1.DescendantAdded:Connect(function(arg1)
		-- upvalues: (copy) v_u2
		if arg1:IsA("BasePart") then
			v_u2(arg1)
		end
	end))
	v_u1.Humanoid.UseJumpPower = true
	v_u1.Humanoid.JumpPower = 19.5
	v_u1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
	v_u1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	v_u1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	v_u1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
	v_u1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	v_u1.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
	v_u1.GlobalVelocity = Vector3.new(0, 0, 0)
	v_u1.LocalVelocity = Vector3.new(0, 0, 0)
	v_u1.LocalVelocityOnJump = Vector3.new(0, 0, 0)
	v_u1.GlobalDirection = Vector3.new(0, 0, 0)
	v_u1.LastCameraCFrame = CFrame.new()
	v_u1.LastMoveUpdate = 0
	v_u1.JumpCooldownActive = false
	v_u1.ReadyToJump = false
	v_u1.LastJumpTick = 0
	v_u1.JumpCount = 0
	v_u1.LastWallHitTick = 0
	v_u1.WallJumpCooldown = false
	v_u1.LockedAirDirection = nil
	v_u1.LastAirDirectionChangeTick = 0
	v_u1.LastLandTick = 0
	v_u1.LastFreefallTick = nil
	v_u1.LastAirTime = 0
	v_u1.PeakFallVelocity = 0
	v_u1.LandingVelocityY = nil
	v_u1.LastCrouchTick = 0
	v_u1.CrouchCount = 0
	v_u1.CrouchHeadBlocked = false
	v_u1.CrouchInputDown = false
	v_u1.CurrentMovementAnimation = nil
	v_u1.LadderZones = {}
	v_u1.LadderPart = nil
	v_u1.LadderZone = nil
	v_u1.LadderClimbPercentage = 0
	v_u1.LastLadderJumpTick = 0
	v_u1.LastLadderAttachTick = 0
	local _, v4, _ = v_u_current_camera.CFrame:ToEulerAnglesYXZ()
	v_u1.CurrentYRotation = v4
	v_u1.TargetYRotation = v4
	local v_rootattachment = arg2:FindFirstChild("RootAttachment")
	if not v_rootattachment then
		warn("[Character] RootAttachment not found - creating one")
		v_rootattachment = Instance.new("Attachment")
		v_rootattachment.Name = "RootAttachment"
		v_rootattachment.Parent = arg2
	end
	local v_assemblymass = arg2.AssemblyMass
	if v_assemblymass ~= v_assemblymass or v_assemblymass <= 0 then
		warn("[Character] Invalid initial AssemblyMass:", v_assemblymass, "- using fallback")
		v_assemblymass = 10
	end
	v_u1.VectorForce = v_u1.Janitor:Add(Instance.new("VectorForce"))
	v_u1.VectorForce.Force = Vector3.new(0, v_assemblymass * workspace.Gravity, 0)
	v_u1.VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
	v_u1.VectorForce.Enabled = false
	v_u1.VectorForce.ApplyAtCenterOfMass = false
	v_u1.VectorForce.Attachment0 = v_rootattachment
	v_u1.VectorForce.Parent = arg2
	v_u1.AlignOrientation = v_u1.Janitor:Add(Instance.new("AlignOrientation"))
	v_u1.AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
	v_u1.AlignOrientation.Attachment0 = arg2:FindFirstChild("RootAttachment")
	v_u1.AlignOrientation.RigidityEnabled = true
	v_u1.AlignOrientation.MaxTorque = (1 / 0)
	v_u1.AlignOrientation.Responsiveness = 200
	v_u1.AlignOrientation.CFrame = CFrame.Angles(0, v_u1.CurrentYRotation, 0)
	v_u1.AlignOrientation.Parent = arg2
	v_u1.JumpedOffLadder = false
	v_u1.IsPlantingBomb = false
	v_u1.IsCrouching = false
	v_u1.IsClimbing = false
	v_u1.IsJumping = false
	v_u1.IsWalking = false
	v_u1.IsLanded = false
	v_u1.IsBhopAttempt = false
	v_u1.AgainstWall = false
	v_u1.WallNormal = nil
	v_u1.LastWallHitTime = 0
	v_u1.LastWallNormal = nil
	v_u1.Stamina = 100
	v_u1.CurrentMoveDirection = Vector3.new(0, 0, 0)
	v_u1.TargetMoveDirection = Vector3.new(0, 0, 0)
	v_u1.MaxSpeed = 20
	v_u1.LastLookAngle = 0
	v_u1.LastLookAngleUpdate = 0
	v_u1.MoveDirectionChanged = v_u1.Janitor:Add(v_u8.new())
	v_u1.Crouching = v_u1.Janitor:Add(v_u8.new())
	v_u1.ClimbBegan = v_u1.Janitor:Add(v_u8.new())
	v_u1.ClimbEnded = v_u1.Janitor:Add(v_u8.new())
	v_u1.Climbing = v_u1.Janitor:Add(v_u8.new())
	v_u1.Jumping = v_u1.Janitor:Add(v_u8.new())
	v_u1.Walking = v_u1.Janitor:Add(v_u8.new())
	v_u1.Landed = v_u1.Janitor:Add(v_u8.new())
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1
		if v_u1.CharacterAnimator then
			v_u1.CharacterAnimator:destroy()
		end
	end)
	v_u1.Janitor:Add(v_u1.Humanoid.StateChanged:Connect(function(arg1, arg2)
		-- upvalues: (copy) v_u1
		local v1 = arg2 == Enum.HumanoidStateType.Jumping and true or arg2 == Enum.HumanoidStateType.Freefall
		local v2
		if arg1 == Enum.HumanoidStateType.Freefall then
			v2 = not v1
		else
			v2 = false
		end
		if arg2 == Enum.HumanoidStateType.Freefall then
			v_u1.LastFreefallTick = tick()
			v_u1.PeakFallVelocity = 0
		end
		if v2 then
			v_u1.LastAirTime = tick() - (v_u1.LastFreefallTick or 0)
			v_u1.LandingVelocityY = math.min(v_u1.HumanoidRootPart and v_u1.HumanoidRootPart.AssemblyLinearVelocity.Y or 0, v_u1.PeakFallVelocity or 0)
			v_u1.IsJumping = false
			v_u1.IsLanded = true
			v_u1.LandAtPosition = v_u1.HumanoidRootPart.CFrame.Position
			v_u1.LastLandTick = tick()
			v_u1.ReadyToJump = true
			v_u1.LockedAirDirection = nil
			v_u1.CharacterAnimator:stop("Jump", 0.2)
			v_u1.Landed:Fire()
		end
	end))
	v_u1.OriginalMoveFunction = v_u_getcontrols.moveFunction
	v_u1.IsDestroyed = false
	local v_u5 = setmetatable({
		["instance"] = v_u1
	}, {
		["__mode"] = "v"
	})
	v_u1._characterRef = v_u5
	function v_u_getcontrols.moveFunction(_, ...)
		-- upvalues: (copy) v_u5, (ref) v_u_getcontrols
		local v_instance = v_u5.instance
		if v_instance and not v_instance.IsDestroyed then
			v_instance:MoveFunction(...)
		elseif v_instance and v_instance.OriginalMoveFunction then
			v_u_getcontrols.moveFunction = v_instance.OriginalMoveFunction
		end
	end
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u5, (copy) v_u1, (ref) v_u_getcontrols
		if v_u5 then
			v_u5.instance = nil
		end
		if not v_u1.IsDestroyed then
			v_u1.IsDestroyed = true
			if v_u1.OriginalMoveFunction then
				v_u_getcontrols.moveFunction = v_u1.OriginalMoveFunction
				v_u1.OriginalMoveFunction = nil
			end
		end
	end, true, "MoveFunctionCleanup")
	v_u1.Janitor:Add(v_u1.Landed:Connect(function()
		-- upvalues: (copy) v_u1, (ref) v_u6
		local v1 = v_u1.LandingVelocityY or v_u1.HumanoidRootPart.AssemblyLinearVelocity.Y
		v_u1.CanceledInertia = false
		v_u1.IsCrouchJumping = false
		v_u1.JumpedOffLadder = false
		if v_u1.HumanoidRootPart then
			local v_assemblylinearvelocity = v_u1.HumanoidRootPart.AssemblyLinearVelocity
			local v_new = Vector3.new(v_assemblylinearvelocity.X, 0, v_assemblylinearvelocity.Z)
			if v_new.Magnitude > 19 then
				v_u1.GlobalVelocity = v_new * math.max(0.4, 1 - (0.1 + (UNNAMED_1728997148088 - 19) * 0.03))
				v_u1.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(UNNAMED_1728997147080.X, v_assemblylinearvelocity.Y, UNNAMED_1728997147080.Z)
			end
		end
		if v1 <= -42 and v_u1.LastLandTick - (v_u1.LastFreefallTick or v_u1.LastJumpTick) >= 0.3 then
			v_u6.Character.FallDamage.Send((math.abs((v1 - -42) / -35 * 100)))
			v_u1:TakeStamina(100)
		end
		v_u1.LandingVelocityY = nil
		v_u1.LastFreefallTick = nil
	end), "Disconnect")
	v_u1.Janitor:Add(v_u1.Jumping:Connect(function()
		-- upvalues: (copy) v_u1, (ref) v_u_current_camera
		v_u1.LocalVelocityOnJump = v_u_current_camera.CFrame:VectorToObjectSpace(v_u1.GlobalVelocity)
		v_u1.GlobalDirectionOnJump = v_u1.GlobalDirection
		v_u1.ReadyToJump = false
	end), "Disconnect")
	v_u1.Janitor:Add(v_u1.ClimbBegan:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		if arg1 and (arg1.Part and arg1.Part.Parent) then
			local v_getladdercframe = v_u1:GetLadderCFrame(arg1)
			if v_getladdercframe then
				local v_position = v_getladdercframe.Position
				if v_position == v_position and (math.abs(v_position.X) <= 50000 and (math.abs(v_position.Y) <= 50000 and math.abs(v_position.Z) <= 50000)) then
					local v_validatehumanoidrootpart = v_u1:ValidateHumanoidRootPart()
					if v_validatehumanoidrootpart then
						local v_position = v_validatehumanoidrootpart.Position
						if v_position == v_position and (math.abs(v_position.X) <= 50000 and (math.abs(v_position.Y) <= 50000 and math.abs(v_position.Z) <= 50000)) then
							v_u1.GlobalVelocity = Vector3.new(0, 0, 0)
							local v_assemblylinearvelocity = v_validatehumanoidrootpart.AssemblyLinearVelocity
							if v_assemblylinearvelocity == v_assemblylinearvelocity then
								v_validatehumanoidrootpart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								v_validatehumanoidrootpart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
							else
								warn("[Ladder Debug] HRP velocity was already NaN before climbing! Attempting recovery...")
								v_validatehumanoidrootpart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								v_validatehumanoidrootpart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
							end
							if v_u1.VectorForce.Attachment0 and v_u1.VectorForce.Attachment0.Parent then
								local v_assemblymass = v_validatehumanoidrootpart.AssemblyMass
								if v_assemblymass ~= v_assemblymass or (v_assemblymass <= 0 or v_assemblymass > 10000) then
									warn("[Ladder Debug] Invalid AssemblyMass:", v_assemblymass, "- using fallback")
									v_assemblymass = 10
								end
								local v_new = Vector3.new(0, v_assemblymass * workspace.Gravity, 0)
								if v_new == v_new and v_new.Magnitude <= 100000 then
									v_u1.VectorForce.Force = v_new
									task.defer(function()
										-- upvalues: (ref) v_u1
										if v_u1.IsDestroyed or not v_u1.IsClimbing then
											return
										else
											local v_validatehumanoidrootpart = v_u1:ValidateHumanoidRootPart()
											if v_validatehumanoidrootpart then
												local v_position = v_validatehumanoidrootpart.Position
												if v_position == v_position then
													v_u1.VectorForce.Enabled = true
												else
													warn("[Ladder Debug] Position became NaN during defer - aborting")
													v_u1:ForceExitLadder("Position NaN during defer")
												end
											else
												v_u1:ForceExitLadder("HRP invalid after defer")
												return
											end
										end
									end)
									v_u1.LadderZone = arg1
									v_u1.IsClimbing = true
									v_u1.LastLadderAttachTick = tick()
									v_u1.LadderClimbPercentage = v_u1:GetLadderClimbPercentage(arg1)
									v_u1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
									local v_getladderclimbpercentage = v_u1:GetLadderClimbPercentage(arg1)
									local v_part = arg1.Part
									print("[Ladder Debug] ClimbBegan", "part:", v_part and v_part.Name or "nil", "pos:", v_getladdercframe and v_getladdercframe.Position or "nil", "climb%:", string.format("%.2f", v_getladderclimbpercentage), "mass:", v_assemblymass, "force:", v_new)
									v_u1.IsJumping = false
									v_u1.IsJumpRequested = false
									v_u1.JumpedOffLadder = false
									v_u1.Climbing:Fire()
								else
									warn("[Ladder Debug] Invalid counter-gravity force:", v_new, "- aborting climb")
								end
							else
								warn("[Ladder Debug] VectorForce has no valid Attachment0 - aborting climb")
								return
							end
						else
							warn("[Ladder Debug] ClimbBegan rejected - invalid player position:", v_position)
							return
						end
					else
						warn("[Ladder Debug] ClimbBegan rejected - no valid HumanoidRootPart")
						return
					end
				else
					warn("[Ladder Debug] ClimbBegan rejected - invalid ladder position:", v_position)
					return
				end
			else
				warn("[Ladder Debug] ClimbBegan rejected - could not get ladder CFrame")
				return
			end
		else
			warn("[Ladder Debug] ClimbBegan rejected - invalid ladder zone")
			return
		end
	end), "Disconnect")
	v_u1.Janitor:Add(v_u1.ClimbEnded:Connect(function(arg1, arg2)
		-- upvalues: (copy) v_u1
		local v1 = v_u1.LadderClimbPercentage or 0
		local v2
		if v_u1.HumanoidRootPart then
			v2 = v_u1.HumanoidRootPart.AssemblyLinearVelocity
		else
			v2 = nil
		end
		print("[Ladder Debug] ClimbEnded", arg2 and "jumpedOff" or "walkedOff", "climb%:", string.format("%.2f", v1), "velocity:", v2, "ladder:", arg1 and (arg1.Part and arg1.Part.Name) or "nil")
		v_u1.VectorForce.Enabled = false
		v_u1.IsClimbing = false
		v_u1.LadderZone = nil
		v_u1.LadderClimbPercentage = 0
		v_u1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
		v_u1.LastLadderJumpTick = tick()
		if arg2 then
			v_u1.JumpedOffLadder = true
		end
		v_u1.Climbing:Fire()
	end), "Disconnect")
	v_u1.Janitor:Add(v_u_run.Stepped:Connect(function(_, arg2)
		-- upvalues: (copy) v_u1, (ref) v_u_current_camera, (ref) v_u6
		if not v_u1.IsDestroyed then
			if v_u1.HumanoidRootPart and v_u1.HumanoidRootPart.Parent then
				local v_position = v_u1.HumanoidRootPart.Position
				if v_position ~= v_position or (math.abs(v_position.X) > 50000 or (math.abs(v_position.Y) > 50000 or math.abs(v_position.Z) > 50000)) then
					warn("[Character] Detected invalid HumanoidRootPart position:", v_position, "- forcing ladder exit and resetting velocity")
					if v_u1.IsClimbing then
						v_u1:ForceExitLadder("Invalid position detected")
					end
					if (Vector3.new(0, 0, 0)).Magnitude < 10000 then
						v_u1.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						v_u1.GlobalVelocity = Vector3.new(0, 0, 0)
					end
					return
				end
			end
			v_u1:UpdateCharacterAnimations(arg2)
			if v_u1.CrouchInputDown then
				v_u1:ToggleCrouchState(true)
			elseif not v_u1.CrouchHeadBlocked then
				v_u1:ToggleCrouchState(false)
			end
			if not v_u1.IsClimbing and v_u1.Humanoid:GetState() == Enum.HumanoidStateType.Climbing then
				v_u1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
				v_u1.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
			end
			if v_u1.IsClimbing and v_u1.LadderZone then
				v_u1.LadderClimbPercentage = v_u1:GetLadderClimbPercentage(v_u1.LadderZone)
			end
			if v_u1.Stamina < 100 then
				v_u1.Stamina = math.min(v_u1.Stamina + arg2 * 100, 100)
			end
			local _, v1, _ = v_u_current_camera.CFrame:ToEulerAnglesYXZ()
			v_u1.TargetYRotation = v1
			if (Vector3.new(v_u1.GlobalVelocity.X, 0, v_u1.GlobalVelocity.Z).Magnitude > 0.1 or v_u1.Humanoid.MoveDirection.Magnitude > 0.1) and true or v_u1.IsClimbing then
				local v2 = v_u1.TargetYRotation - v_u1.CurrentYRotation
				if v2 == v2 and math.abs(v2) ~= (1 / 0) then
					local v3 = 0
					while v2 > 3.141592653589793 and v3 < 10 do
						v2 = v2 - 6.283185307179586
						v3 = v3 + 1
					end
					local v4 = 0
					while v2 < -3.141592653589793 and v4 < 10 do
						v2 = v2 + 6.283185307179586
						v4 = v4 + 1
					end
				else
					warn("[Character] Detected invalid rotation values - resetting. TargetY:", v_u1.TargetYRotation, "CurrentY:", v_u1.CurrentYRotation)
					v_u1.CurrentYRotation = v1
					v_u1.TargetYRotation = v1
					v2 = 0
				end
				local v_min = math.min(1, arg2 * 20)
				v_u1.CurrentYRotation = v_u1.CurrentYRotation + v2 * v_min
				v_u1.AlignOrientation.RigidityEnabled = true
				v_u1.AlignOrientation.MaxTorque = (1 / 0)
				v_u1.AlignOrientation.Enabled = true
			else
				if v1 ~= v1 or math.abs(v1) == (1 / 0) then
					warn("[Character] Detected invalid camera rotation - skipping stationary rotation update")
					return
				end
				v_u1.CurrentYRotation = v_u1.TargetYRotation
				v_u1.AlignOrientation.Enabled = false
				if v_u1.HumanoidRootPart and v_u1.HumanoidRootPart.Parent then
					local v_position = v_u1.HumanoidRootPart.Position
					if v_position == v_position and (math.abs(v_position.X) < 50000 and (math.abs(v_position.Y) < 50000 and math.abs(v_position.Z) < 50000)) then
						v_u1.HumanoidRootPart.CFrame = CFrame.new(v_position) * CFrame.Angles(0, v_u1.CurrentYRotation, 0)
					end
				end
			end
			if v_u1.CurrentYRotation == v_u1.CurrentYRotation and math.abs(v_u1.CurrentYRotation) < 100 then
				v_u1.AlignOrientation.CFrame = CFrame.Angles(0, v_u1.CurrentYRotation, 0)
			end
			local v5 = tick()
			if v5 - v_u1.LastLookAngleUpdate >= 0.05 and math.abs(v1 - v_u1.LastLookAngle) > 0.01 then
				v_u1.LastLookAngle = v1
				v_u1.LastLookAngleUpdate = v5
				v_u6.Character.UpdateLookAngle.Send(v1)
			end
		end
	end))
	local v_ladder = v_u_collection:GetTagged("Ladder")
	for _, v6 in pairs(v_ladder) do
		v_u1:AddLadder(v6)
	end
	local v7 = 0
	for _ in pairs(v_u1.LadderZones) do
		v7 = v7 + 1
	end
	v_u1.Janitor:Add(v_u_collection:GetInstanceAddedSignal("Ladder"):Connect(function(arg1)
		-- upvalues: (copy) v_u1
		if arg1:IsA("BasePart") then
			v_u1:AddLadder(arg1)
		end
	end))
	v_u1.Janitor:Add(v_u_collection:GetInstanceRemovedSignal("Ladder"):Connect(function(arg1)
		-- upvalues: (copy) v_u1
		if arg1:IsA("BasePart") then
			v_u1:RemoveLadder(arg1)
		end
	end))
	v_u1._deadAttributeConnection = arg1:GetAttributeChangedSignal("Dead"):Connect(function()
		-- upvalues: (copy) arg1, (copy) v_u1
		if arg1:GetAttribute("Dead") and not v_u1.IsDestroyed then
			v_u1:Destroy()
		end
	end)
	return v_u1
end
function v_u1.Destroy(arg1)
	-- upvalues: (copy) v_u_getcontrols
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		if arg1.CharacterAnimator then
			arg1.CharacterAnimator:destroy()
			arg1.CharacterAnimator = nil
		end
		if arg1._characterRef then
			arg1._characterRef.instance = nil
			arg1._characterRef = nil
		end
		if arg1.OriginalMoveFunction then
			v_u_getcontrols.moveFunction = arg1.OriginalMoveFunction
			arg1.OriginalMoveFunction = nil
		end
		if arg1._deadAttributeConnection then
			arg1._deadAttributeConnection:Disconnect()
			arg1._deadAttributeConnection = nil
		end
		if arg1.MoveDirectionChanged then
			arg1.MoveDirectionChanged:Destroy()
			arg1.MoveDirectionChanged = nil
		end
		if arg1.Crouching then
			arg1.Crouching:Destroy()
			arg1.Crouching = nil
		end
		if arg1.ClimbBegan then
			arg1.ClimbBegan:Destroy()
			arg1.ClimbBegan = nil
		end
		if arg1.ClimbEnded then
			arg1.ClimbEnded:Destroy()
			arg1.ClimbEnded = nil
		end
		if arg1.Climbing then
			arg1.Climbing:Destroy()
			arg1.Climbing = nil
		end
		if arg1.Jumping then
			arg1.Jumping:Destroy()
			arg1.Jumping = nil
		end
		if arg1.Walking then
			arg1.Walking:Destroy()
			arg1.Walking = nil
		end
		if arg1.Landed then
			arg1.Landed:Destroy()
			arg1.Landed = nil
		end
		if arg1.LadderZones then
			table.clear(arg1.LadderZones)
			arg1.LadderZones = nil
		end
		arg1.Character = nil
		arg1.HumanoidRootPart = nil
		arg1.Humanoid = nil
		arg1.LadderZone = nil
		arg1.LadderPart = nil
		if arg1.VectorForce then
			arg1.VectorForce = nil
		end
		if arg1.AlignOrientation then
			arg1.AlignOrientation = nil
		end
		if arg1.BombPlantTween then
			arg1.BombPlantTween = nil
		end
		if arg1.CrouchTween then
			arg1.CrouchTween = nil
		end
		arg1.DefaultCameraOffset = nil
		arg1.CrouchCameraOffset = nil
		arg1.GlobalVelocity = nil
		arg1.LocalVelocity = nil
		arg1.LocalVelocityOnJump = nil
		arg1.GlobalDirection = nil
		arg1.TargetMoveDirection = nil
		arg1.CurrentMoveDirection = nil
		arg1.WallNormal = nil
		arg1.LastWallNormal = nil
		arg1.LandingVelocityY = nil
		arg1.LockedAirDirection = nil
		arg1.Janitor:Destroy()
		arg1.Janitor = nil
	end
end
return v_u1