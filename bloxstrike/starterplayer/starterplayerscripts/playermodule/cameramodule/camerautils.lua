-- Decompiled with Bunni.lol Decompiler

local v_u_players = game:GetService("Players")
local v_u_userinput = game:GetService("UserInputService")
local v_u_usergamesettings = UserSettings():GetService("UserGameSettings")
local v_u1 = {}
local v_u2 = {}
v_u2.__index = v_u2
function v_u2.new(arg1, arg2)
	-- upvalues: (copy) v_u2
	return setmetatable({
		["freq"] = arg1,
		["goal"] = arg2,
		["pos"] = arg2,
		["vel"] = 0
	}, v_u2)
end
function v_u2.step(arg1, arg2)
	local v_exp = math.exp(-(arg1.freq * 2 * 3.141592653589793) * arg2)
	local v1 = ((arg1.pos - arg1.goal) * (UNNAMED_1728994292600 * arg2 + 1) + arg1.vel * arg2) * v_exp + arg1.goal
	arg1.pos = v1
	arg1.vel = (UNNAMED_1728994294520 * (1 - UNNAMED_1728994292600 * arg2) - UNNAMED_1728994293992 * (UNNAMED_1728994292600 * UNNAMED_1728994292600 * arg2)) * v_exp
	return v1
end
v_u1.Spring = v_u2
function v_u1.map(arg1, arg2, arg3, arg4, arg5)
	return (arg1 - arg2) * (arg5 - arg4) / (arg3 - arg2) + arg4
end
function v_u1.mapClamp(arg1, arg2, arg3, arg4, arg5)
	local v_min = math.min(arg4, arg5)
	local v_max = math.max(arg4, arg5)
	return math.clamp((arg1 - arg2) * (arg5 - arg4) / (arg3 - arg2) + arg4, v_min, v_max)
end
function v_u1.getLooseBoundingSphere(arg1)
	local v_create = table.create(#arg1)
	for v1, v2 in pairs(arg1) do
		v_create[v1] = v2.Position
	end
	local v3 = v_create[1]
	local v4 = v3
	local v5 = 0
	for _, v6 in ipairs(v_create) do
		local v_magnitude = (v6 - v3).Magnitude
		if v5 < v_magnitude then
			v4 = v6
			v5 = v_magnitude
		end
	end
	local v7 = v4
	local v8 = 0
	for _, v9 in ipairs(v_create) do
		local v_magnitude = (v9 - v4).Magnitude
		if v8 < v_magnitude then
			v7 = v9
			v8 = v_magnitude
		end
	end
	local v10 = (v4 + v7) * 0.5
	local v11 = (v4 - v7).Magnitude * 0.5
	for _, v12 in ipairs(v_create) do
		local v_magnitude = (v12 - v10).Magnitude
		if v11 < v_magnitude then
			v10 = v10 + (v_magnitude - v11) * 0.5 * (v12 - v10).Unit
			v11 = (v_magnitude + v11) * 0.5
		end
	end
	return v10, v11
end
function v_u1.sanitizeAngle(arg1)
	return (arg1 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
end
function v_u1.Round(arg1, arg2)
	return math.floor(arg1 * 10 ^ arg2 + 0.5) / 10 ^ arg2
end
function v_u1.IsFinite(arg1)
	local v1
	if arg1 == arg1 and arg1 ~= (1 / 0) then
		v1 = arg1 ~= (-1 / 0)
	else
		v1 = false
	end
	return v1
end
function v_u1.IsFiniteVector3(arg1)
	-- upvalues: (copy) v_u1
	local v1 = v_u1.IsFinite(arg1.X) and v_u1.IsFinite(arg1.Y)
	if v1 then
		v1 = v_u1.IsFinite(arg1.Z)
	end
	return v1
end
function v_u1.GetAngleBetweenXZVectors(arg1, arg2)
	return math.atan2(arg2.X * arg1.Z - arg2.Z * arg1.X, arg2.X * arg1.X + arg2.Z * arg1.Z)
end
function v_u1.RotateVectorByAngleAndRound(arg1, arg2, arg3)
	if arg1.Magnitude <= 0 then
		return 0
	end
	local v_unit = arg1.Unit
	local v_atan2 = math.atan2(v_unit.Z, v_unit.X)
	return math.floor((math.atan2(v_unit.Z, v_unit.X) + arg2) / arg3 + 0.5) * arg3 - v_atan2
end
function v_u1.GamepadLinearToCurve(arg1)
	local v_new = Vector2.new
	local v_x = arg1.X
	local v1 = v_x < 0 and -1 or 1
	local v_abs = math.abs(v_x)
	local v_clamp = math.clamp((math.abs(v_abs) * 2 - 1) * 1.1 - 0.1, -1, 1)
	local v2
	if v_clamp >= 0 then
		v2 = v_clamp * 0.35 / (0.35 - v_clamp + 1)
	else
		v2 = -(-v_clamp * 0.8 / (v_clamp + 0.8 + 1))
	end
	local v_clamp = math.clamp((v2 / 2 + 0.5) * v1, -1, 1)
	local v_y = arg1.Y
	local v3 = v_y < 0 and -1 or 1
	local v_abs = math.abs(v_y)
	local v_clamp = math.clamp((math.abs(v_abs) * 2 - 1) * 1.1 - 0.1, -1, 1)
	local v4
	if v_clamp >= 0 then
		v4 = v_clamp * 0.35 / (0.35 - v_clamp + 1)
	else
		v4 = -(-v_clamp * 0.8 / (v_clamp + 0.8 + 1))
	end
	return v_new(v_clamp, (math.clamp((v4 / 2 + 0.5) * v3, -1, 1)))
end
function v_u1.ConvertCameraModeEnumToStandard(arg1)
	if arg1 == Enum.TouchCameraMovementMode.Default then
		return Enum.ComputerCameraMovementMode.Follow
	elseif arg1 == Enum.ComputerCameraMovementMode.Default then
		return Enum.ComputerCameraMovementMode.Classic
	elseif arg1 == Enum.TouchCameraMovementMode.Classic or (arg1 == Enum.DevTouchCameraMovementMode.Classic or (arg1 == Enum.DevComputerCameraMovementMode.Classic or arg1 == Enum.ComputerCameraMovementMode.Classic)) then
		return Enum.ComputerCameraMovementMode.Classic
	elseif arg1 == Enum.TouchCameraMovementMode.Follow or (arg1 == Enum.DevTouchCameraMovementMode.Follow or (arg1 == Enum.DevComputerCameraMovementMode.Follow or arg1 == Enum.ComputerCameraMovementMode.Follow)) then
		return Enum.ComputerCameraMovementMode.Follow
	elseif arg1 == Enum.TouchCameraMovementMode.Orbital or (arg1 == Enum.DevTouchCameraMovementMode.Orbital or (arg1 == Enum.DevComputerCameraMovementMode.Orbital or arg1 == Enum.ComputerCameraMovementMode.Orbital)) then
		return Enum.ComputerCameraMovementMode.Orbital
	elseif arg1 == Enum.ComputerCameraMovementMode.CameraToggle or arg1 == Enum.DevComputerCameraMovementMode.CameraToggle then
		return Enum.ComputerCameraMovementMode.CameraToggle
	elseif arg1 == Enum.DevTouchCameraMovementMode.UserChoice or arg1 == Enum.DevComputerCameraMovementMode.UserChoice then
		return Enum.DevComputerCameraMovementMode.UserChoice
	else
		return Enum.ComputerCameraMovementMode.Classic
	end
end
local v_u3 = ""
local v_u4 = nil
function v_u1.setMouseIconOverride(arg1)
	-- upvalues: (copy) v_u_players, (ref) v_u4, (ref) v_u3
	local v_localplayer = v_u_players.LocalPlayer
	if not v_localplayer then
		v_u_players:GetPropertyChangedSignal("LocalPlayer"):Wait()
		v_localplayer = v_u_players.LocalPlayer
	end
	assert(v_localplayer)
	local v_getmouse = v_localplayer:GetMouse()
	if v_getmouse.Icon ~= v_u4 then
		v_u3 = v_getmouse.Icon
	end
	v_getmouse.Icon = arg1
	v_u4 = arg1
end
function v_u1.restoreMouseIcon()
	-- upvalues: (copy) v_u_players, (ref) v_u4, (ref) v_u3
	local v_localplayer = v_u_players.LocalPlayer
	if not v_localplayer then
		v_u_players:GetPropertyChangedSignal("LocalPlayer"):Wait()
		v_localplayer = v_u_players.LocalPlayer
	end
	assert(v_localplayer)
	local v_getmouse = v_localplayer:GetMouse()
	if v_getmouse.Icon == v_u4 then
		v_getmouse.Icon = v_u3
	end
	v_u4 = nil
end
local v_u_default = Enum.MouseBehavior.Default
local v_u5 = nil
function v_u1.setMouseBehaviorOverride(arg1)
	-- upvalues: (copy) v_u_userinput, (ref) v_u5, (ref) v_u_default
	if v_u_userinput.MouseBehavior ~= v_u5 then
		v_u_default = v_u_userinput.MouseBehavior
	end
	v_u_userinput.MouseBehavior = arg1
	v_u5 = arg1
end
function v_u1.restoreMouseBehavior()
	-- upvalues: (copy) v_u_userinput, (ref) v_u5, (ref) v_u_default
	if v_u_userinput.MouseBehavior == v_u5 then
		v_u_userinput.MouseBehavior = v_u_default
	end
	v_u5 = nil
end
local v_u_movementrelative = Enum.RotationType.MovementRelative
local v_u6 = nil
function v_u1.setRotationTypeOverride(arg1)
	-- upvalues: (copy) v_u_usergamesettings, (ref) v_u6, (ref) v_u_movementrelative
	if v_u_usergamesettings.RotationType ~= v_u6 then
		v_u_movementrelative = v_u_usergamesettings.RotationType
	end
	v_u_usergamesettings.RotationType = arg1
	v_u6 = arg1
end
function v_u1.restoreRotationType()
	-- upvalues: (copy) v_u_usergamesettings, (ref) v_u6, (ref) v_u_movementrelative
	if v_u_usergamesettings.RotationType == v_u6 then
		v_u_usergamesettings.RotationType = v_u_movementrelative
	end
	v_u6 = nil
end
return v_u1