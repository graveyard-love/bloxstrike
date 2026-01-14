-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_u_new = Vector3.new
local v_u_noise = math.noise
v_u1.CameraShakeState = {
	["FadingIn"] = 0,
	["FadingOut"] = 1,
	["Sustained"] = 2,
	["Inactive"] = 3
}
function v_u1.new(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_new, (copy) v_u1
	assert(type(arg1) == "number", "Magnitude must be a number")
	assert(type(arg2) == "number", "Roughness must be a number")
	assert(type(arg3 == nil and 0 or arg3) == "number", "FadeInTime must be a number")
	assert(type(arg4 == nil and 0 or arg4) == "number", "FadeOutTime must be a number")
	return setmetatable({
		["Magnitude"] = arg1,
		["Roughness"] = arg2,
		["PositionInfluence"] = v_u_new(),
		["RotationInfluence"] = v_u_new(),
		["DeleteOnInactive"] = true,
		["roughMod"] = 1,
		["magnMod"] = 1,
		["fadeOutDuration"] = UNNAMED_1728994412088,
		["fadeInDuration"] = UNNAMED_1728994412232,
		["sustain"] = UNNAMED_1728994412232 > 0,
		["currentFadeTime"] = UNNAMED_1728994412232 > 0 and 0 or 1,
		["tick"] = Random.new():NextNumber(-100, 100),
		["_camShakeInstance"] = true
	}, v_u1)
end
function v_u1.UpdateShake(arg1, arg2)
	-- upvalues: (copy) v_u_noise, (copy) v_u_new
	local v_tick = arg1.tick
	local v_currentfadetime = arg1.currentFadeTime
	local v1 = v_u_new(v_u_noise(v_tick, 0) * 0.5, v_u_noise(0, v_tick) * 0.5, v_u_noise(v_tick, v_tick) * 0.5)
	if arg1.fadeInDuration > 0 and arg1.sustain then
		if v_currentfadetime < 1 then
			v_currentfadetime = v_currentfadetime + arg2 / arg1.fadeInDuration
		elseif arg1.fadeOutDuration > 0 then
			arg1.sustain = false
		end
	end
	if not arg1.sustain then
		v_currentfadetime = v_currentfadetime - arg2 / arg1.fadeOutDuration
	end
	if arg1.sustain then
		arg1.tick = v_tick + arg2 * arg1.Roughness * arg1.roughMod
	else
		arg1.tick = v_tick + arg2 * arg1.Roughness * arg1.roughMod * v_currentfadetime
	end
	arg1.currentFadeTime = v_currentfadetime
	return v1 * arg1.Magnitude * arg1.magnMod * v_currentfadetime
end
function v_u1.StartFadeOut(arg1, arg2)
	if arg2 == 0 then
		arg1.currentFadeTime = 0
	end
	arg1.fadeOutDuration = arg2
	arg1.fadeInDuration = 0
	arg1.sustain = false
end
function v_u1.StartFadeIn(arg1, arg2)
	if arg2 == 0 then
		arg1.currentFadeTime = 1
	end
	arg1.fadeInDuration = arg2 or arg1.fadeInDuration
	arg1.fadeOutDuration = 0
	arg1.sustain = true
end
function v_u1.GetScaleRoughness(arg1)
	return arg1.roughMod
end
function v_u1.SetScaleRoughness(arg1, arg2)
	arg1.roughMod = arg2
end
function v_u1.GetScaleMagnitude(arg1)
	return arg1.magnMod
end
function v_u1.SetScaleMagnitude(arg1, arg2)
	arg1.magnMod = arg2
end
function v_u1.GetNormalizedFadeTime(arg1)
	return arg1.currentFadeTime
end
function v_u1.IsShaking(arg1)
	return arg1.currentFadeTime > 0 and true or arg1.sustain
end
function v_u1.IsFadingOut(arg1)
	local v1 = not arg1.sustain
	if v1 then
		v1 = arg1.currentFadeTime > 0
	end
	return v1
end
function v_u1.IsFadingIn(arg1)
	local v1 = arg1.currentFadeTime < 1 and arg1.sustain
	if v1 then
		v1 = arg1.fadeInDuration > 0
	end
	return v1
end
function v_u1.GetState(arg1)
	-- upvalues: (copy) v_u1
	if arg1:IsFadingIn() then
		return v_u1.CameraShakeState.FadingIn
	elseif arg1:IsFadingOut() then
		return v_u1.CameraShakeState.FadingOut
	elseif arg1:IsShaking() then
		return v_u1.CameraShakeState.Sustained
	else
		return v_u1.CameraShakeState.Inactive
	end
end
return v_u1