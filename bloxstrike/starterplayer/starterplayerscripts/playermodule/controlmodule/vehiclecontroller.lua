-- Decompiled with Bunni.lol Decompiler

local v_u_contextaction = game:GetService("ContextActionService")
local v_u1 = {}
v_u1.__index = v_u1
function v_u1.new(arg1)
	-- upvalues: (copy) v_u1
	local v1 = setmetatable({}, v_u1)
	v1.CONTROL_ACTION_PRIORITY = arg1
	v1.enabled = false
	v1.vehicleSeat = nil
	v1.throttle = 0
	v1.steer = 0
	v1.acceleration = 0
	v1.decceleration = 0
	v1.turningRight = 0
	v1.turningLeft = 0
	v1.vehicleMoveVector = Vector3.new(0, 0, 0)
	v1.autoPilot = {}
	v1.autoPilot.MaxSpeed = 0
	v1.autoPilot.MaxSteeringAngle = 0
	return v1
end
function v_u1.BindContextActions(self)
	-- upvalues: (copy) v_u_contextaction
	v_u_contextaction:BindActionAtPriority("throttleAccel", function(arg1, arg2, arg3)
		-- upvalues: (copy) self
		self:OnThrottleAccel(arg1, arg2, arg3)
		return Enum.ContextActionResult.Pass
	end, false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonR2)
	v_u_contextaction:BindActionAtPriority("throttleDeccel", function(arg1, arg2, arg3)
		-- upvalues: (copy) self
		self:OnThrottleDeccel(arg1, arg2, arg3)
		return Enum.ContextActionResult.Pass
	end, false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonL2)
	v_u_contextaction:BindActionAtPriority("arrowSteerRight", function(arg1, arg2, arg3)
		-- upvalues: (copy) self
		self:OnSteerRight(arg1, arg2, arg3)
		return Enum.ContextActionResult.Pass
	end, false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Right)
	v_u_contextaction:BindActionAtPriority("arrowSteerLeft", function(arg1, arg2, arg3)
		-- upvalues: (copy) self
		self:OnSteerLeft(arg1, arg2, arg3)
		return Enum.ContextActionResult.Pass
	end, false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Left)
end
function v_u1.Enable(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_contextaction
	if arg2 ~= arg1.enabled or arg3 ~= arg1.vehicleSeat then
		arg1.enabled = arg2
		arg1.vehicleMoveVector = Vector3.new(0, 0, 0)
		if arg2 then
			if arg3 then
				arg1.vehicleSeat = arg3
				arg1:SetupAutoPilot()
				arg1:BindContextActions()
				return
			end
		else
			v_u_contextaction:UnbindAction("throttleAccel")
			v_u_contextaction:UnbindAction("throttleDeccel")
			v_u_contextaction:UnbindAction("arrowSteerRight")
			v_u_contextaction:UnbindAction("arrowSteerLeft")
			arg1.vehicleSeat = nil
		end
	end
end
function v_u1.OnThrottleAccel(arg1, _, arg3, _)
	if arg3 == Enum.UserInputState.End or arg3 == Enum.UserInputState.Cancel then
		arg1.acceleration = 0
	else
		arg1.acceleration = -1
	end
	arg1.throttle = arg1.acceleration + arg1.decceleration
end
function v_u1.OnThrottleDeccel(arg1, _, arg3, _)
	if arg3 == Enum.UserInputState.End or arg3 == Enum.UserInputState.Cancel then
		arg1.decceleration = 0
	else
		arg1.decceleration = 1
	end
	arg1.throttle = arg1.acceleration + arg1.decceleration
end
function v_u1.OnSteerRight(arg1, _, arg3, _)
	if arg3 == Enum.UserInputState.End or arg3 == Enum.UserInputState.Cancel then
		arg1.turningRight = 0
	else
		arg1.turningRight = 1
	end
	arg1.steer = arg1.turningRight + arg1.turningLeft
end
function v_u1.OnSteerLeft(arg1, _, arg3, _)
	if arg3 == Enum.UserInputState.End or arg3 == Enum.UserInputState.Cancel then
		arg1.turningLeft = 0
	else
		arg1.turningLeft = -1
	end
	arg1.steer = arg1.turningRight + arg1.turningLeft
end
function v_u1.Update(arg1, arg2, arg3, _)
	if arg1.vehicleSeat then
		if arg3 then
			local v1 = arg2 + Vector3.new(arg1.steer, 0, arg1.throttle)
			arg1.vehicleSeat.ThrottleFloat = -v1.Z
			arg1.vehicleSeat.SteerFloat = v1.X
			return v1, true
		else
			local v_vectortoobjectspace = arg1.vehicleSeat.Occupant.RootPart.CFrame:VectorToObjectSpace(arg2)
			arg1.vehicleSeat.ThrottleFloat = arg1:ComputeThrottle(v_vectortoobjectspace)
			arg1.vehicleSeat.SteerFloat = arg1:ComputeSteer(v_vectortoobjectspace)
			return Vector3.new(0, 0, 0), true
		end
	else
		return arg2, false
	end
end
function v_u1.ComputeThrottle(_, arg2)
	return arg2 == Vector3.new(0, 0, 0) and 0 or -arg2.Z
end
function v_u1.ComputeSteer(arg1, arg2)
	return arg2 == Vector3.new(0, 0, 0) and 0 or -math.atan2(-arg2.x, -arg2.z) * 57.29577951308232 / arg1.autoPilot.MaxSteeringAngle
end
function v_u1.SetupAutoPilot(arg1)
	arg1.autoPilot.MaxSpeed = arg1.vehicleSeat.MaxSpeed
	arg1.autoPilot.MaxSteeringAngle = 35
end
return v_u1