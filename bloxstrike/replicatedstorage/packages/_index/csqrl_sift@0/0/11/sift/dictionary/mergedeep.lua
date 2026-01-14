-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.Parent.None)
local v_u2 = require(script.Parent.copyDeep)
local function v_u3(...)
	-- upvalues: (copy) v_u1, (copy) v_u2, (copy) v_u3
	local v1 = {}
	for v2 = 1, select("#", ...) do
		local v3 = select(v2, ...)
		if type(v3) == "table" then
			for v4, v5 in pairs(v3) do
				if v5 == v_u1 then
					v1[v4] = nil
				elseif type(v5) == "table" then
					if v1[v4] == nil or type(v1[v4]) ~= "table" then
						v1[v4] = v_u2(v5)
					else
						v1[v4] = v_u3(v1[v4], v5)
					end
				else
					v1[v4] = v5
				end
			end
		end
	end
	return v1
end
return v_u3