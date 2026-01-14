-- Decompiled with Bunni.lol Decompiler

local v_commonutils = script.Parent.Parent:WaitForChild("CommonUtils")
local v1 = require(v_commonutils:WaitForChild("FlagUtil"))
local v_u2 = require(script.Parent:WaitForChild("ZoomController"))
local v_u_userfixcamerafperror = v1.getUserFlag("UserFixCameraFPError")
local v_u3 = {}
v_u3.__index = v_u3
local v_u_new = CFrame.new()
function v_u3.new()
	-- upvalues: (copy) v_u3
	return setmetatable({
		["lastCFrame"] = nil
	}, v_u3)
end
function v_u3.Step(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_new
	arg1.lastCFrame = arg3
	local v_u_position = arg3.Position
	local _, _, _, v1, v2, v3, v4, v5, v6, v7, v8, v9 = arg3:GetComponents()
	local v_u_new = CFrame.new(0, 0, 0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
	local _, _, _, v10, v11, v12, v13, v14, v15, v16, v17, v18 = (arg1.lastCFrame or arg3):GetComponents()
	local v_new = CFrame.new(0, 0, 0, v10, v11, v12, v13, v14, v15, v16, v17, v18)
	local v_u19 = (v_u_position - UNNAMED_1728996635384.p) / arg2
	local v_toaxisangle, v20 = (v_u_new * v_new:inverse()):ToAxisAngle()
	local v_u21 = v_toaxisangle * v20 / arg2
	return {
		["extrapolate"] = function(arg1)
			-- upvalues: (copy) v_u19, (copy) v_u_position, (copy) v_u21, (ref) v_u_new, (copy) v_u_new
			local v1 = v_u19 * arg1 + v_u_position
			local v2 = v_u21 * arg1
			local v_magnitude = v2.Magnitude
			local v3
			if v_magnitude > 0.00001 then
				v3 = CFrame.fromAxisAngle(v2, v_magnitude)
			else
				v3 = v_u_new
			end
			return v3 * v_u_new + v1
		end,
		["posVelocity"] = v_u19,
		["rotVelocity"] = v_u21
	}
end
function v_u3.Reset(arg1)
	arg1.lastCFrame = nil
end
local v_u4 = require(script.Parent:WaitForChild("BaseOcclusion"))
local v_u5 = setmetatable({}, v_u4)
v_u5.__index = v_u5
function v_u5.new()
	-- upvalues: (copy) v_u4, (copy) v_u5, (copy) v_u3
	local v_new = v_u4.new()
	local v1 = setmetatable(v_new, v_u5)
	v1.focusExtrapolator = v_u3.new()
	return v1
end
function v_u5.GetOcclusionMode(_)
	return Enum.DevCameraOcclusionMode.Zoom
end
function v_u5.Enable(arg1, _)
	arg1.focusExtrapolator:Reset()
end
function v_u5.Update(arg1, arg2, arg3, arg4, _)
	-- upvalues: (copy) v_u_userfixcamerafperror, (copy) v_u2
	local v1
	if v_u_userfixcamerafperror then
		v1 = CFrame.lookAlong(arg4.p, -arg3.LookVector) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	else
		v1 = CFrame.new(arg4.p, arg3.p) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	end
	local v_step = arg1.focusExtrapolator:Step(arg2, v1)
	local v_update = v_u2.Update(arg2, v1, v_step)
	return v1 * CFrame.new(0, 0, v_update), arg4
end
function v_u5.CharacterAdded(_, _, _) end
function v_u5.CharacterRemoving(_, _, _) end
function v_u5.OnCameraSubjectChanged(_, _) end
return v_u5