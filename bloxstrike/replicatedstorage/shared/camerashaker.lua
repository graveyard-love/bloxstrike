-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_u_profilebegin = debug.profilebegin
local v_u_profileend = debug.profileend
local v_u_new = CFrame.new
local v_u_angles = CFrame.Angles
local v_u_rad = math.rad
local v_u_new = Vector3.new()
local v_u2 = require(script.CameraShakeInstance)
local v_u_camerashakestate = v_u2.CameraShakeState
v_u1.CameraShakeInstance = v_u2
v_u1.Presets = require(script.CameraShakePresets)
function v_u1.new(arg1, arg2)
	-- upvalues: (copy) v_u_new, (copy) v_u1
	assert(type(arg1) == "number", "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
	assert(type(arg2) == "function", "Callback must be a function")
	return setmetatable({
		["_running"] = false,
		["_renderName"] = "CameraShaker",
		["_renderPriority"] = arg1,
		["_posAddShake"] = v_u_new,
		["_rotAddShake"] = v_u_new,
		["_camShakeInstances"] = {},
		["_removeInstances"] = {},
		["_callback"] = arg2
	}, v_u1)
end
function v_u1.Start(self)
	-- upvalues: (copy) v_u_profilebegin, (copy) v_u_profileend
	if not self._running then
		self._running = true
		local v_u__callback = self._callback
		game:GetService("RunService"):BindToRenderStep(self._renderName, self._renderPriority, function(arg1)
			-- upvalues: (ref) v_u_profilebegin, (copy) self, (ref) v_u_profileend, (copy) v_u__callback
			v_u_profilebegin("CameraShakerUpdate")
			local v_update = self:Update(arg1)
			v_u_profileend()
			v_u__callback(v_update)
		end)
	end
end
function v_u1.Stop(arg1)
	if arg1._running then
		game:GetService("RunService"):UnbindFromRenderStep(arg1._renderName)
		arg1._running = false
	end
end
function v_u1.StopSustained(arg1, arg2)
	for _, v1 in pairs(arg1._camShakeInstances) do
		if v1.fadeOutDuration == 0 then
			v1:StartFadeOut(arg2 or v1.fadeInDuration)
		end
	end
end
function v_u1.Update(arg1, arg2)
	-- upvalues: (copy) v_u_new, (copy) v_u_camerashakestate, (copy) v_u_new, (copy) v_u_angles, (copy) v_u_rad
	local v1 = v_u_new
	local v2 = v_u_new
	local v__camshakeinstances = arg1._camShakeInstances
	for v3 = 1, #v__camshakeinstances do
		local v4 = v__camshakeinstances[v3]
		local v_getstate = v4:GetState()
		if v_getstate == v_u_camerashakestate.Inactive and v4.DeleteOnInactive then
			arg1._removeInstances[#arg1._removeInstances + 1] = v3
		elseif v_getstate ~= v_u_camerashakestate.Inactive then
			local v_updateshake = v4:UpdateShake(arg2)
			v1 = v1 + v_updateshake * v4.PositionInfluence
			v2 = v2 + v_updateshake * v4.RotationInfluence
		end
	end
	for v5 = #arg1._removeInstances, 1, -1 do
		table.remove(v__camshakeinstances, arg1._removeInstances[v5])
		arg1._removeInstances[v5] = nil
	end
	return v_u_new(v1) * v_u_angles(0, v_u_rad(v2.Y), 0) * v_u_angles(v_u_rad(v2.X), 0, (v_u_rad(v2.Z)))
end
function v_u1.Shake(arg1, arg2)
	local v1
	if type(arg2) == "table" then
		v1 = arg2._camShakeInstance
	else
		v1 = false
	end
	assert(v1, "ShakeInstance must be of type CameraShakeInstance")
	arg1._camShakeInstances[#arg1._camShakeInstances + 1] = arg2
	return arg2
end
function v_u1.ShakeSustain(arg1, arg2)
	local v1
	if type(arg2) == "table" then
		v1 = arg2._camShakeInstance
	else
		v1 = false
	end
	assert(v1, "ShakeInstance must be of type CameraShakeInstance")
	arg1._camShakeInstances[#arg1._camShakeInstances + 1] = arg2
	arg2:StartFadeIn(arg2.fadeInDuration)
	return arg2
end
function v_u1.ShakeOnce(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	-- upvalues: (copy) v_u2
	local v_new = v_u2.new(arg2, arg3, arg4, arg5)
	v_new.PositionInfluence = typeof(arg6) == "Vector3" and arg6 and arg6 or Vector3.new(0.15, 0.15, 0.15)
	v_new.RotationInfluence = typeof(arg7) == "Vector3" and arg7 and arg7 or Vector3.new(1, 1, 1)
	arg1._camShakeInstances[#arg1._camShakeInstances + 1] = v_new
	return v_new
end
function v_u1.StartShake(arg1, arg2, arg3, arg4, arg5, arg6)
	-- upvalues: (copy) v_u2
	local v_new = v_u2.new(arg2, arg3, arg4)
	v_new.PositionInfluence = typeof(arg5) == "Vector3" and arg5 and arg5 or Vector3.new(0.15, 0.15, 0.15)
	v_new.RotationInfluence = typeof(arg6) == "Vector3" and arg6 and arg6 or Vector3.new(1, 1, 1)
	v_new:StartFadeIn(arg4)
	arg1._camShakeInstances[#arg1._camShakeInstances + 1] = v_new
	return v_new
end
return v_u1