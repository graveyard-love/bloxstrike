-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
setmetatable(v_u1, {
	["__call"] = function(_, ...)
		-- upvalues: (copy) v_u1
		return v_u1.new(...)
	end
})
function v_u1.new()
	-- upvalues: (copy) v_u1
	return setmetatable({}, v_u1)
end
function v_u1.CharacterAdded(_, _, _) end
function v_u1.CharacterRemoving(_, _, _) end
function v_u1.OnCameraSubjectChanged(_, _) end
function v_u1.GetOcclusionMode(_)
	warn("BaseOcclusion GetOcclusionMode must be overridden by derived classes")
	return nil
end
function v_u1.Enable(_, _)
	warn("BaseOcclusion Enable must be overridden by derived classes")
end
function v_u1.Update(_, _, arg3, arg4)
	warn("BaseOcclusion Update must be overridden by derived classes")
	return arg3, arg4
end
return v_u1