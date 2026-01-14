-- Decompiled with Bunni.lol Decompiler

local v_u_tween = game:GetService("TweenService")
local v_u1 = {}
v_u1.__index = v_u1
function v_u1.new(arg1)
	-- upvalues: (copy) v_u1
	local v1 = setmetatable({}, v_u1)
	v1.value = arg1
	v1.lastValue = arg1
	v1.goal = arg1
	v1.timestamp = 0
	v1.rate = nil
	v1.tweenInfo = nil
	return v1
end
function v_u1.setGoal(arg1, arg2)
	arg1.lastValue = arg1.value
	arg1.goal = arg2
	arg1.timestamp = os.clock()
end
function v_u1.useFixedRate(arg1, arg2)
	arg1.rate = arg2
	arg1.tweenInfo = nil
end
function v_u1.useTween(arg1, arg2)
	arg1.rate = nil
	arg1.tweenInfo = arg2
end
function v_u1.get(arg1)
	return arg1.value
end
function v_u1.update(arg1, arg2)
	-- upvalues: (copy) v_u_tween
	if arg1.value == arg1.goal then
		return
	elseif arg1.tweenInfo then
		local v_getvalue = v_u_tween:GetValue(math.clamp((os.clock() - arg1.timestamp) / arg1.tweenInfo.Time, 0, 1), arg1.tweenInfo.EasingStyle, arg1.tweenInfo.EasingDirection)
		arg1.value = (1 - v_getvalue) * arg1.lastValue + arg1.goal * v_getvalue
	elseif arg1.rate then
		local v1 = arg1.rate * math.sign(arg1.goal - arg1.value) * arg2
		local v2 = arg1.value + v1
		if v1 < 0 then
			arg1.value = math.max(v2, arg1.goal)
			return
		end
		arg1.value = math.min(v2, arg1.goal)
	end
end
return v_u1