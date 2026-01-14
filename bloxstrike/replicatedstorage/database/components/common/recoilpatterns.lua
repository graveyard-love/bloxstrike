-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
require(v_replicatedstorage.Database.Custom.Types)
local v_u_spraypatterns = v_replicatedstorage.Database.Custom.Weapons.SprayPatterns
local function v_u1(arg1, arg2)
	-- upvalues: (copy) v_u_spraypatterns
	local v_firerate = arg2.FireRate
	local v_rounds = arg2.Rounds
	local v1 = {}
	local v2 = v_u_spraypatterns:FindFirstChild(arg1)
	if not v2 then
		warn(string.format("%s has no spray pattern part", arg1))
		return nil
	end
	if #v2:GetChildren() ~= v_rounds then
		warn(string.format("%s spray pattern points not equal to magazine size", arg1), v_rounds, #v2:GetChildren())
	end
	local v3 = v2[tostring(1)]
	for v4 = 1, v_rounds do
		local v5 = v2[tostring(v4)]
		local v_zero = Vector2.zero
		local v_zero = Vector2.zero
		if v4 > 1 then
			local v_position = (v3.WorldCFrame:Inverse() * v2[tostring(v4 - 1)].WorldCFrame).Position
			v_zero = Vector2.new(v_position.X, v_position.Y)
			local v_position = (v3.WorldCFrame:Inverse() * v5.WorldCFrame).Position
			v_zero = Vector2.new(v_position.X, v_position.Y)
		end
		table.insert(v1, {
			["Duration"] = 1 * v_firerate,
			["EasingStyle"] = Enum.EasingStyle.Linear,
			["EasingDirection"] = Enum.EasingDirection.In,
			["Path"] = { v_zero * 0.5, v_zero * 0.5 }
		})
	end
	return v1
end
local function v_u2(arg1, arg2)
	local v1 = 0
	for _, v2 in ipairs(arg1) do
		local v3 = v1 + v2.Duration
		if arg2 <= v3 then
			return v2, math.clamp((arg2 - v1) / UNNAMED_1728996361320, 0, 1)
		end
		v1 = v3
	end
	return nil, nil
end
local function v_u3(arg1, arg2)
	if #arg1 == 2 then
		return arg1[1]:Lerp(arg1[2], arg2)
	elseif #arg1 == 3 then
		local v1 = 1 - arg2
		return v1 * v1 * arg1[1] + v1 * 2 * arg2 * arg1[2] + arg2 * arg2 * arg1[3]
	elseif #arg1 == 4 then
		return (1 - arg2) * (1 - arg2) * (1 - arg2) * arg1[1] + (1 - arg2) * (1 - arg2) * 3 * arg2 * arg1[2] + (1 - arg2) * 3 * (arg2 * arg2) * arg1[3] + arg2 * arg2 * arg2 * arg1[4]
	else
		return Vector2.zero
	end
end
local v4 = {}
for _, v5 in ipairs(v_u_spraypatterns:GetChildren()) do
	local v_u_name = v5.Name
	v4[v_u_name] = function(arg1)
		-- upvalues: (copy) v_u1, (copy) v_u_name, (copy) v_u2, (copy) v_u_tween, (copy) v_u3
		local _ = arg1.FireRate * arg1.Rounds
		local v_u1 = v_u1(v_u_name, arg1)
		local v_u2 = 0
		for _, v3 in ipairs(v_u1) do
			v_u2 = v_u2 + v3.Duration
		end
		return function(arg1)
			-- upvalues: (copy) v_u2, (ref) v_u2, (copy) v_u1, (ref) v_u_tween, (ref) v_u3
			local v1, v2 = v_u2(v_u1, (math.clamp(arg1, 0, v_u2)))
			local v_getvalue = v_u_tween:GetValue(v2, v1.EasingStyle, v1.EasingDirection)
			return v_u3(v1.Path, v_getvalue)
		end
	end
end
return v4