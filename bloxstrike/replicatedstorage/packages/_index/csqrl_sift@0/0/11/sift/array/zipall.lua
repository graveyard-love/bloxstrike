-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.reduce)
local v_u2 = require(script.Parent.Parent.None)
return function(...)
	-- upvalues: (copy) v_u1, (copy) v_u2
	local v1 = { ... }
	local v2 = {}
	if select("#", ...) == 0 then
		return v2
	end
	for v3 = 1, v_u1(v1, function(arg1, arg2)
		return math.max(arg1, #arg2)
	end, #v1[1]) do
		local v4 = {}
		for _, v5 in ipairs(v1) do
			local v6 = v5[v3]
			if v6 == nil then
				v6 = v_u2
			end
			table.insert(v4, v6)
		end
		table.insert(v2, v4)
	end
	return v2
end