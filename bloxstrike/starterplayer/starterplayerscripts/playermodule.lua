-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
function v_u1.new()
	-- upvalues: (copy) v_u1
	local v1 = setmetatable({}, v_u1)
	v1.cameras = require(script:WaitForChild("CameraModule"))
	v1.controls = require(script:WaitForChild("ControlModule"))
	return v1
end
function v_u1.GetCameras(arg1)
	return arg1.cameras
end
function v_u1.GetControls(arg1)
	return arg1.controls
end
function v_u1.GetClickToMoveController(arg1)
	return arg1.controls:GetClickToMoveController()
end
return v_u1.new()