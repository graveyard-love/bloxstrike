-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_u_exp = math.exp
local v_u_sin = math.sin
local v_u_cos = math.cos
local v_u_sqrt = math.sqrt
function v_u1.new(arg1, arg2, arg3)
	-- upvalues: (copy) v_u1
	assert(type(arg1) == "number", "damping ratio must be a number")
	assert(type(arg2) == "number", "frequency must be a number")
	assert(arg1 * arg2 >= 0, "Spring does not converge")
	return setmetatable({
		["d"] = arg1,
		["f"] = arg2 * 0.2,
		["g"] = arg3,
		["p"] = arg3,
		["v"] = arg3 * 0
	}, v_u1)
end
function v_u1.setDampingRatio(arg1, arg2)
	arg1.d = arg2
end
function v_u1.setFrequency(arg1, arg2)
	arg1.f = arg2 * 0.2
end
function v_u1.setGoal(arg1, arg2)
	arg1.g = arg2
end
function v_u1.getGoal(arg1)
	return arg1.g
end
function v_u1.setPosition(arg1, arg2)
	arg1.p = arg2
end
function v_u1.getPosition(arg1)
	return arg1.p
end
function v_u1.getVelocity(arg1)
	return arg1.v / 0.2
end
function v_u1.impulse(arg1, arg2)
	arg1.v = arg1.v + arg2 * 0.2
end
function v_u1.reset(arg1, arg2)
	arg1.g = arg2
	arg1.p = arg1.g
	arg1.v = arg1.g * 0
end
function v_u1.update(arg1, arg2)
	-- upvalues: (copy) v_u_exp, (copy) v_u_sqrt, (copy) v_u_cos, (copy) v_u_sin
	local v_d = arg1.d
	local v1 = arg1.f * 2 * 3.141592653589793
	local v_g = arg1.g
	local v_v = arg1.v
	local v2 = arg1.p - v_g
	local v3 = v_u_exp(-v_d * v1 * arg2)
	local v4, v5
	if v_d == 1 then
		v4 = (v2 * (1 + v1 * arg2) + v_v * arg2) * v3 + v_g
		v5 = (v_v * (1 - v1 * arg2) - v2 * (v1 * v1 * arg2)) * v3
	elseif v_d < 1 then
		local v6 = v_u_sqrt(1 - v_d * v_d)
		local v7 = v_u_cos(v1 * v6 * arg2)
		local v8 = v_u_sin(v1 * v6 * arg2)
		local v9
		if v6 > 0.0001 then
			v9 = v8 / v6
		else
			local v10 = arg2 * v1
			v9 = v10 + (v10 * v10 * (v6 * v6) * (v6 * v6) / 20 - v6 * v6) * (v10 * v10 * v10) / 6
		end
		local v11
		if v1 * v6 > 0.0001 then
			v11 = v8 / (v1 * v6)
		else
			local v12 = v1 * v6
			v11 = arg2 + (arg2 * arg2 * (v12 * v12) * (v12 * v12) / 20 - v12 * v12) * (arg2 * arg2 * arg2) / 6
		end
		v4 = (v2 * (v7 + v_d * v9) + v_v * v11) * v3 + v_g
		v5 = (v_v * (v7 - v9 * v_d) - v2 * (v9 * v1)) * v3
	else
		local v13 = v_u_sqrt(v_d * v_d - 1)
		local v14 = -v1 * (v_d - v13)
		local v15 = -v1 * (v_d + v13)
		local v16 = (v_v - v2 * v14) / (2 * v1 * v13)
		local v17 = (v2 - v16) * v_u_exp(v14 * arg2)
		local v18 = v16 * v_u_exp(v15 * arg2)
		v4 = v17 + v18 + v_g
		v5 = v17 * v14 + v18 * v15
	end
	arg1.p = v4
	arg1.v = v5
	return v4
end
return v_u1