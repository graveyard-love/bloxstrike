-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.reduce)
return function(...)
	-- upvalues: (copy) v_u1
	local v1 = { ... }
	local v2 = {}
	if select("#", ...) == 0 then
		return v2
	end
	for v3 = 1, v_u1(v1, function(arg1, arg2)
		return math.min(arg1, #arg2)
	end, #v1[1]) do
		local v4 = {}
		for _, v5 in ipairs(v1) do
			table.insert(v4, v5[v3])
		end
		table.insert(v2, v4)
	end
	return v2
end