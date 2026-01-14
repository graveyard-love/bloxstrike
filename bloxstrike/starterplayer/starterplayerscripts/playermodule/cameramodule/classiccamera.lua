-- Decompiled with Bunni.lol Decompiler

Vector2.new(0, 0)
local v_u1 = 0
local v_u_fromorientation = CFrame.fromOrientation(-0.2617993877991494, 0, 0)
local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v2 = require(v_commonutils:WaitForChild("FlagUtil"))
local v_u_usercamerainputdt = v2.getUserFlag("UserCameraInputDt")
local v_u_userfixcamerafperror = v2.getUserFlag("UserFixCameraFPError")
local v_u_players = game:GetService("Players")
local v_u3 = require(script.Parent:WaitForChild("CameraInput"))
local v_u4 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u5 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u6 = setmetatable({}, v_u5)
v_u6.__index = v_u6
function v_u6.new()
	-- upvalues: (copy) v_u5, (copy) v_u6, (copy) v_u4
	local v_new = v_u5.new()
	local v1 = setmetatable(v_new, v_u6)
	v1.isFollowCamera = false
	v1.isCameraToggle = false
	v1.lastUpdate = tick()
	v1.cameraToggleSpring = v_u4.Spring.new(5, 0)
	return v1
end
function v_u6.GetCameraToggleOffset(arg1, arg2)
	-- upvalues: (copy) v_u3, (copy) v_u4
	if not arg1.isCameraToggle then
		return Vector3.new()
	end
	local v_currentsubjectdistance = arg1.currentSubjectDistance
	if v_u3.getTogglePan() then
		local v_map = v_u4.map(v_currentsubjectdistance, 0.5, arg1.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1)
		arg1.cameraToggleSpring.goal = math.clamp(v_map, 0, 1)
	else
		arg1.cameraToggleSpring.goal = 0
	end
	local v_map = v_u4.map(v_currentsubjectdistance, 0.5, 64, 0, 1)
	return Vector3.new(0, arg1.cameraToggleSpring:step(arg2) * (math.clamp(v_map, 0, 1) + 1), 0)
end
function v_u6.SetCameraMovementMode(arg1, arg2)
	-- upvalues: (copy) v_u5
	v_u5.SetCameraMovementMode(arg1, arg2)
	arg1.isFollowCamera = arg2 == Enum.ComputerCameraMovementMode.Follow
	arg1.isCameraToggle = arg2 == Enum.ComputerCameraMovementMode.CameraToggle
end
function v_u6.Update(arg1, arg2)
	-- upvalues: (copy) v_u_usercamerainputdt, (copy) v_u_fromorientation, (copy) v_u_players, (copy) v_u3, (ref) v_u1, (copy) v_u4, (copy) v_u_userfixcamerafperror
	local v1 = tick()
	local v2 = v1 - arg1.lastUpdate
	if v_u_usercamerainputdt then
		v2 = arg2
	end
	local v_current_camera = workspace.CurrentCamera
	local v_cframe = v_current_camera.CFrame
	local v_focus = v_current_camera.Focus
	local v3
	if arg1.resetCameraAngle then
		local v_gethumanoidrootpart = arg1:GetHumanoidRootPart()
		if v_gethumanoidrootpart then
			v3 = (v_gethumanoidrootpart.CFrame * v_u_fromorientation).lookVector
		else
			v3 = v_u_fromorientation.lookVector
		end
		arg1.resetCameraAngle = false
	else
		v3 = nil
	end
	local v_localplayer = v_u_players.LocalPlayer
	local v_gethumanoid = arg1:GetHumanoid()
	local v_camerasubject = v_current_camera.CameraSubject
	local v4
	if v_camerasubject then
		v4 = v_camerasubject:IsA("VehicleSeat")
	else
		v4 = v_camerasubject
	end
	local v5
	if v_camerasubject then
		v5 = v_camerasubject:IsA("SkateboardPlatform")
	else
		v5 = v_camerasubject
	end
	local v6
	if v_gethumanoid then
		v6 = v_gethumanoid:GetState() == Enum.HumanoidStateType.Climbing
	else
		v6 = v_gethumanoid
	end
	if arg1.lastUpdate == nil or v2 > 1 then
		arg1.lastCameraTransform = nil
	end
	local v_getrotation = v_u3.getRotation(v2)
	arg1:StepZoom()
	local v_getcameraheight = arg1:GetCameraHeight()
	if v_getrotation ~= Vector2.new() then
		v_u1 = 0
		arg1.lastUserPanCamera = tick()
	end
	local v7 = v1 - arg1.lastUserPanCamera < 2
	local v_getsubjectposition = arg1:GetSubjectPosition()
	if v_getsubjectposition and (v_localplayer and v_current_camera) then
		local v_getcameratosubjectdistance = arg1:GetCameraToSubjectDistance()
		local v8 = v_getcameratosubjectdistance < 0.5 and 0.5 or v_getcameratosubjectdistance
		if arg1:GetIsMouseLocked() and not arg1:IsInFirstPerson() then
			local v_calculatenewlookcframefromarg = arg1:CalculateNewLookCFrameFromArg(v3, v_getrotation)
			local v_getmouselockoffset = arg1:GetMouseLockOffset()
			if v_gethumanoid then
				v_getmouselockoffset = v_getmouselockoffset + v_gethumanoid.CameraOffset
			end
			local v9 = v_getmouselockoffset.X * v_calculatenewlookcframefromarg.RightVector + v_getmouselockoffset.Y * v_calculatenewlookcframefromarg.UpVector + v_getmouselockoffset.Z * v_calculatenewlookcframefromarg.LookVector
			if v_u4.IsFiniteVector3(v9) then
				v_getsubjectposition = v_getsubjectposition + v9
			end
		elseif v_getrotation == Vector2.new() and arg1.lastCameraTransform then
			local v_isinfirstperson = arg1:IsInFirstPerson()
			if (v4 or (v5 or arg1.isFollowCamera and v6)) and (arg1.lastUpdate and (v_gethumanoid and v_gethumanoid.Torso)) then
				if v_isinfirstperson then
					if arg1.lastSubjectCFrame and (v4 or v5) and v_camerasubject:IsA("BasePart") then
						local v10 = -v_u4.GetAngleBetweenXZVectors(arg1.lastSubjectCFrame.lookVector, v_camerasubject.CFrame.lookVector)
						if v_u4.IsFinite(v10) then
							v_getrotation = v_getrotation + Vector2.new(v10, 0)
						end
						v_u1 = 0
					end
				elseif not v7 then
					v_u1 = math.clamp(v_u1 + 3.839724354387525 * v2, 0, 4.363323129985824)
					local v_clamp = math.clamp(v_u1 * v2, 0, 1)
					local v11 = arg1:IsInFirstPerson() and not (arg1.isFollowCamera and arg1.isClimbing) and 1 or v_clamp
					local v_getanglebetweenxzvectors = v_u4.GetAngleBetweenXZVectors(v_gethumanoid.Torso.CFrame.lookVector, arg1:GetCameraLookVector())
					if v_u4.IsFinite(v_getanglebetweenxzvectors) and math.abs(v_getanglebetweenxzvectors) > 0.0001 then
						v_getrotation = v_getrotation + Vector2.new(v_getanglebetweenxzvectors * v11, 0)
					end
				end
			elseif arg1.isFollowCamera and not (v_isinfirstperson or v7) then
				local v_getanglebetweenxzvectors = v_u4.GetAngleBetweenXZVectors(-(arg1.lastCameraTransform.p - v_getsubjectposition), arg1:GetCameraLookVector())
				if v_u4.IsFinite(v_getanglebetweenxzvectors) and (math.abs(v_getanglebetweenxzvectors) > 0.0001 and math.abs(v_getanglebetweenxzvectors) > 0.4 * v2) then
					v_getrotation = v_getrotation + Vector2.new(v_getanglebetweenxzvectors, 0)
				end
			end
		end
		local v12, v13
		if arg1.isFollowCamera then
			local v_calculatenewlookvectorfromarg = arg1:CalculateNewLookVectorFromArg(v3, v_getrotation)
			v12 = CFrame.new(v_getsubjectposition)
			if v_u_userfixcamerafperror then
				v13 = CFrame.lookAlong(v12.p - v8 * v_calculatenewlookvectorfromarg, v_calculatenewlookvectorfromarg)
			else
				v13 = CFrame.new(v12.p - v8 * v_calculatenewlookvectorfromarg, v12.p) + Vector3.new(0, v_getcameraheight, 0)
			end
		else
			v12 = CFrame.new(v_getsubjectposition)
			local v_p = v12.p
			local v_calculatenewlookvectorfromarg = arg1:CalculateNewLookVectorFromArg(v3, v_getrotation)
			if v_u_userfixcamerafperror then
				v13 = CFrame.lookAlong(v_p - v8 * v_calculatenewlookvectorfromarg, v_calculatenewlookvectorfromarg)
			else
				v13 = CFrame.new(v_p - v8 * v_calculatenewlookvectorfromarg, v_p)
			end
		end
		local v_getcameratoggleoffset = arg1:GetCameraToggleOffset(v2)
		v_focus = v12 + v_getcameratoggleoffset
		v_cframe = v13 + v_getcameratoggleoffset
		arg1.lastCameraTransform = v_cframe
		arg1.lastCameraFocus = v_focus
		if (v4 or v5) and v_camerasubject:IsA("BasePart") then
			arg1.lastSubjectCFrame = v_camerasubject.CFrame
		else
			arg1.lastSubjectCFrame = nil
		end
	end
	arg1.lastUpdate = v1
	return v_cframe, v_focus
end
return v_u6