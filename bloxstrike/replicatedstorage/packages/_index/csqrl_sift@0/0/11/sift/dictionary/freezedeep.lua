-- Decompiled with Bunni.lol Decompiler

require(script.Parent.Parent.Types)
local function v_u1(arg1)
	-- upvalues: (copy) v_u1
	local v1 = {}
	for v2, v3 in pairs(arg1) do
		if type(v3) == "table" then
			v1[v2] = v_u1(v3)
		else
			v1[v2] = v3
		end
	end
	table.freeze(v1)
	return v1
end
return v_u1