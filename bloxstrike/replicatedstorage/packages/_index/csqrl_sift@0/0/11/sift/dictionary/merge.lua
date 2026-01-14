-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.Parent.None)
return function(...)
	-- upvalues: (copy) v_u1
	local v1 = {}
	for v2 = 1, select("#", ...) do
		local v3 = select(v2, ...)
		if type(v3) == "table" then
			for v4, v6 in pairs(v3) do
				if v6 == v_u1 then
					local v6 = nil
				end
				v1[v4] = v6
			end
		end
	end
	return v1
end