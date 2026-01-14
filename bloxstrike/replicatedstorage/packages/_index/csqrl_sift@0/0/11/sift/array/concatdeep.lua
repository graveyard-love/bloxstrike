-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.copyDeep)
local v_u2 = require(script.Parent.Parent.None)
return function(...)
	-- upvalues: (copy) v_u2, (copy) v_u1
	local v1 = {}
	for v2 = 1, select("#", ...) do
		local v3 = select(v2, ...)
		if type(v3) == "table" then
			for _, v4 in ipairs(v3) do
				if v4 ~= v_u2 then
					if type(v4) == "table" then
						table.insert(v1, v_u1(v4))
					else
						table.insert(v1, v4)
					end
				end
			end
		end
	end
	return v1
end