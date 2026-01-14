-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script:WaitForChild("Popper"))
local v_u_clamp = math.clamp
local v_u_exp = math.exp
local v_u_min = math.min
local v_u_max = math.max
local v_u2 = nil
local v_u3 = nil
local v_u_localplayer = game:GetService("Players").LocalPlayer
assert(v_u_localplayer)
local function v4()
	-- upvalues: (ref) v_u2, (copy) v_u_localplayer, (ref) v_u3
	v_u2 = v_u_localplayer.CameraMinZoomDistance
	v_u3 = v_u_localplayer.CameraMaxZoomDistance
end
v_u2 = v_u_localplayer.CameraMinZoomDistance
v_u3 = v_u_localplayer.CameraMaxZoomDistance
v_u_localplayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(v4)
v_u_localplayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(v4)
local v_u5 = {}
v_u5.__index = v_u5
function v_u5.new(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_clamp, (copy) v_u5
	local v1 = v_u_clamp(arg2, arg3, arg4)
	return setmetatable({
		["freq"] = arg1,
		["x"] = v1,
		["v"] = 0,
		["minValue"] = arg3,
		["maxValue"] = arg4,
		["goal"] = v1
	}, v_u5)
end
function v_u5.Step(arg1, arg2)
	-- upvalues: (copy) v_u_exp
	local v1 = arg1.freq * 2 * 3.141592653589793
	local v_v = arg1.v
	local v_minvalue = arg1.minValue
	local v_maxvalue = arg1.maxValue
	local v_goal = arg1.goal
	local v2 = v_goal - arg1.x
	local v3 = v1 * arg2
	local v4 = v_u_exp(-v3)
	local v5 = v_goal + (v_v * arg2 - v2 * (v3 + 1)) * v4
	local v6 = ((v2 * v1 - v_v) * v3 + v_v) * v4
	if v5 < v_minvalue then
		v_maxvalue = v_minvalue
		v6 = 0
	elseif v_maxvalue < v5 then
		v6 = 0
	else
		v_maxvalue = v5
	end
	arg1.x = v_maxvalue
	arg1.v = v6
	return v_maxvalue
end
local v_u_new = v_u5.new(4.5, 12.5, 0.5, v_u3)
local v_u6 = 0
return {
	["Update"] = function(arg1, arg2, arg3)
		-- upvalues: (copy) v_u_new, (ref) v_u6, (ref) v_u2, (ref) v_u3, (copy) v_u_clamp, (copy) v_u_max, (copy) v_u1, (copy) v_u_min
		local v1
		if v_u_new.goal > 1 then
			local v_goal = v_u_new.goal
			local v2 = v_u6
			local v3 = v_u2
			local v4 = v_u_clamp(v_goal + v2 * (v_goal * 0.0375 + 1), v3, v_u3)
			local v5 = v_u_max(v_u_new.x, v4 < 1 and (v2 <= 0 and v3 and v3 or 1) or v4)
			v1 = v_u1(arg2 * CFrame.new(0, 0, 0.5), v5 - 0.5, arg3) + 0.5
		else
			v1 = (1 / 0)
		end
		v_u_new.minValue = 0.5
		v_u_new.maxValue = v_u_min(v_u3, v1)
		return v_u_new:Step(arg1)
	end,
	["GetZoomRadius"] = function()
		-- upvalues: (copy) v_u_new
		return v_u_new.x
	end,
	["SetZoomParameters"] = function(arg1, arg2)
		-- upvalues: (copy) v_u_new, (ref) v_u6
		v_u_new.goal = arg1
		v_u6 = arg2
	end,
	["ReleaseSpring"] = function()
		-- upvalues: (copy) v_u_new
		v_u_new.x = v_u_new.goal
		v_u_new.v = 0
	end
}