-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.Parent.Array.toSet)
return function(arg1, ...)
	-- upvalues: (copy) v_u1
	local v1 = v_u1({ ... })
	local v2 = {}
	for v3, v4 in pairs(arg1) do
		if not v1[v4] then
			v2[v3] = v4
		end
	end
	return v2
end