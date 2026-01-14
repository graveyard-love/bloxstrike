-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.copy)
return function(arg1, arg2)
	-- upvalues: (copy) v_u1
	local v1 = v_u1(arg1)
	table.sort(v1, arg2)
	return v1
end