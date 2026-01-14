-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.Parent.Parent.CameraUtils)
local v_u2 = require(script.Parent.VehicleCameraConfig)
local v_u_map = v1.map
local v_u_mapclamp = v1.mapClamp
local v_u_sanitizeangle = v1.sanitizeAngle
local v_u3 = {}
v_u3.__index = v_u3
function v_u3.new(arg1, arg2, arg3)
	-- upvalues: (copy) v_u3
	return setmetatable({
		["fRising"] = arg1,
		["fFalling"] = arg2,
		["g"] = arg3,
		["p"] = arg3,
		["v"] = arg3 * 0
	}, v_u3)
end
function v_u3.step(arg1, arg2)
	local v_frising = arg1.fRising
	local v_ffalling = arg1.fFalling
	local v_g = arg1.g
	local v_p = arg1.p
	local v_v = arg1.v
	local v1 = 6.283185307179586
	if v_v > 0 then
		v_ffalling = v_frising or v_ffalling
	end
	local v_exp = math.exp(-(v1 * v_ffalling) * arg2)
	local v2 = ((v_p - v_g) * (1 + UNNAMED_1728994321192 * arg2) + v_v * arg2) * v_exp + v_g
	arg1.p = v2
	arg1.v = (v_v * (1 - UNNAMED_1728994321192 * arg2) - UNNAMED_1728994322152 * (UNNAMED_1728994321192 * UNNAMED_1728994321192 * arg2)) * v_exp
	return v2
end
local v_u4 = {}
v_u4.__index = v_u4
function v_u4.new(arg1)
	-- upvalues: (copy) v_u_sanitizeangle, (copy) v_u3, (copy) v_u2, (copy) v_u4
	assert(typeof(arg1) == "CFrame")
	local v1 = {}
	local _, v2 = arg1:toEulerAnglesYXZ()
	v1.yawG = v_u_sanitizeangle(v2)
	local _, v3 = arg1:toEulerAnglesYXZ()
	v1.yawP = v_u_sanitizeangle(v3)
	v1.yawV = 0
	v1.pitchG = v_u_sanitizeangle((arg1:toEulerAnglesYXZ()))
	v1.pitchP = v_u_sanitizeangle((arg1:toEulerAnglesYXZ()))
	v1.pitchV = 0
	v1.fSpringYaw = v_u3.new(v_u2.yawReponseDampingRising, v_u2.yawResponseDampingFalling, 0)
	v1.fSpringPitch = v_u3.new(v_u2.pitchReponseDampingRising, v_u2.pitchResponseDampingFalling, 0)
	return setmetatable(v1, v_u4)
end
function v_u4.setGoal(arg1, arg2)
	-- upvalues: (copy) v_u_sanitizeangle
	assert(typeof(arg2) == "CFrame")
	local _, v1 = arg2:toEulerAnglesYXZ()
	arg1.yawG = v_u_sanitizeangle(v1)
	arg1.pitchG = v_u_sanitizeangle((arg2:toEulerAnglesYXZ()))
end
function v_u4.getCFrame(arg1)
	return CFrame.fromEulerAnglesYXZ(arg1.pitchP, arg1.yawP, 0)
end
function v_u4.step(arg1, arg2, arg3, arg4, arg5)
	-- upvalues: (copy) v_u_mapclamp, (copy) v_u_map, (copy) v_u2, (copy) v_u_sanitizeangle
	assert(typeof(arg2) == "number")
	assert(typeof(arg4) == "number")
	assert(typeof(arg3) == "number")
	assert(typeof(arg5) == "number")
	local v1 = v_u_map(arg5, 0, 1, arg4, 0)
	local v_rad = math.rad(v_u2.cutoffMinAngularVelYaw)
	arg1.fSpringYaw.g = v_u_mapclamp(v1, v_rad, math.rad(v_u2.cutoffMaxAngularVelYaw), 1, 0)
	local v2 = v_u_map(arg5, 0, 1, arg3, 0)
	local v_rad = math.rad(v_u2.cutoffMinAngularVelPitch)
	arg1.fSpringPitch.g = v_u_mapclamp(v2, v_rad, math.rad(v_u2.cutoffMaxAngularVelPitch), 1, 0)
	local v_yawg = arg1.yawG
	local v3 = v_u_sanitizeangle(arg1.yawP - v_yawg)
	local v_exp = math.exp(-(6.283185307179586 * v_u2.yawStiffness * UNNAMED_1729000798888:step(arg2) * v_u_map(arg5, 0, 1, 1, v_u2.firstPersonResponseMul)) * arg2)
	arg1.yawP = v_u_sanitizeangle((v3 * (1 + UNNAMED_1728994513160 * arg2) + arg1.yawV * arg2) * v_exp + v_yawg)
	arg1.yawV = (UNNAMED_1728994512632 * (1 - UNNAMED_1728994513160 * arg2) - v3 * (UNNAMED_1728994513160 * UNNAMED_1728994513160 * arg2)) * v_exp
	local v_pitchg = arg1.pitchG
	local v4 = v_u_sanitizeangle(arg1.pitchP - v_pitchg)
	local v_exp = math.exp(-(6.283185307179586 * v_u2.pitchStiffness * UNNAMED_1729000798984:step(arg2) * v_u_map(arg5, 0, 1, 1, v_u2.firstPersonResponseMul)) * arg2)
	arg1.pitchP = v_u_sanitizeangle((v4 * (1 + UNNAMED_1728994239960 * arg2) + arg1.pitchV * arg2) * v_exp + v_pitchg)
	arg1.pitchV = (UNNAMED_1728994511912 * (1 - UNNAMED_1728994239960 * arg2) - v4 * (UNNAMED_1728994239960 * UNNAMED_1728994239960 * arg2)) * v_exp
	return arg1:getCFrame()
end
local v_u5 = {}
v_u5.__index = v_u5
function v_u5.new(arg1)
	-- upvalues: (copy) v_u4, (copy) v_u5
	return setmetatable({
		["vrs"] = v_u4.new(arg1)
	}, v_u5)
end
function v_u5.step(arg1, arg2, arg3, arg4, arg5)
	return arg1.vrs:step(arg2, arg3, arg4, arg5)
end
function v_u5.setTransform(arg1, arg2)
	arg1.vrs:setGoal(arg2)
end
return v_u5