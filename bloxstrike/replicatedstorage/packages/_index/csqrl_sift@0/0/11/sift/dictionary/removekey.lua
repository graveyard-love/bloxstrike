-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.copy)
return function(arg1, arg2)
	-- upvalues: (copy) v_u1
	local v1 = v_u1(arg1)
	v1[arg2] = nil
	return v1
end