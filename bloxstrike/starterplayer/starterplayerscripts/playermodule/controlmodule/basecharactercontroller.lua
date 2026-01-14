-- Decompiled with Bunni.lol Decompiler

local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u1 = require(v_commonutils:WaitForChild("ConnectionUtil"))
local v_u_new = Vector3.new()
local v_u2 = {}
v_u2.__index = v_u2
function v_u2.new()
	-- upvalues: (copy) v_u2, (copy) v_u_new, (copy) v_u1
	local v1 = setmetatable({}, v_u2)
	v1.enabled = false
	v1.moveVector = v_u_new
	v1.moveVectorIsCameraRelative = true
	v1.isJumping = false
	v1._connectionUtil = v_u1.new()
	return v1
end
function v_u2.GetMoveVector(arg1)
	return arg1.moveVector
end
function v_u2.IsMoveVectorCameraRelative(arg1)
	return arg1.moveVectorIsCameraRelative
end
function v_u2.GetIsJumping(arg1)
	return arg1.isJumping
end
function v_u2.Enable(_, _)
	error("BaseCharacterController:Enable must be overridden in derived classes and should not be called.")
	return false
end
return v_u2