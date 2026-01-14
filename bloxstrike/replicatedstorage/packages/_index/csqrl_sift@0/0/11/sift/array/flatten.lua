-- Decompiled with Bunni.lol Decompiler

local function v_u1(arg1, arg2)
	-- upvalues: (copy) v_u1
	local v1 = type(arg2) ~= "number" and (1 / 0) or arg2
	local v2 = {}
	for _, v3 in ipairs(arg1) do
		if type(v3) == "table" and v1 > 0 then
			local v4 = v_u1(v3, v1 - 1)
			for _, v5 in ipairs(v4) do
				table.insert(v2, v5)
			end
		else
			table.insert(v2, v3)
		end
	end
	return v2
end
return v_u1