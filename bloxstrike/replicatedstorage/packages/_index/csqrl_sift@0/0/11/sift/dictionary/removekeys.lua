-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.copy)
return function(arg1, ...)
	-- upvalues: (copy) v_u1
	local v1 = v_u1(arg1)
	for _, v2 in ipairs({ ... }) do
		v1[v2] = nil
	end
	return v1
end