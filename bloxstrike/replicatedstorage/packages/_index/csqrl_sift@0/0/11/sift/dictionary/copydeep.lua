-- Decompiled with Bunni.lol Decompiler

local function v_u1(arg1)
	-- upvalues: (copy) v_u1
	local v_clone = table.clone(arg1)
	for v1, v2 in pairs(arg1) do
		if type(v2) == "table" then
			v_clone[v1] = v_u1(v2)
		end
	end
	return v_clone
end
return v_u1