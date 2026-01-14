-- Decompiled with Bunni.lol Decompiler

local function v_u1(arg1)
	-- upvalues: (copy) v_u1
	local v1 = {}
	for v2 = 1, #arg1 do
		local v3 = arg1[v2]
		if type(v3) == "table" then
			table.insert(v1, v_u1(v3))
		else
			table.insert(v1, v3)
		end
	end
	table.freeze(v1)
	return v1
end
return v_u1