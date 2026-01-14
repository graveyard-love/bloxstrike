-- Decompiled with Bunni.lol Decompiler

require(script.Parent.Parent.Types)
local function v_u1(arg1, arg2)
	-- upvalues: (copy) v_u1
	local v1 = type(arg2) ~= "number" and (1 / 0) or arg2
	local v2 = {}
	for v3, v4 in pairs(arg1) do
		if type(v4) == "table" and v1 > 0 then
			local v5 = v_u1(v4, v1 - 1)
			for v6, v7 in pairs(v2) do
				v5[v6] = v7
			end
			v2 = v5
		else
			v2[v3] = v4
		end
	end
	return v2
end
return v_u1