-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.Parent.Util)
return function(arg1, arg2)
	-- upvalues: (copy) v_u1
	local v1 = {}
	if type(arg2) ~= "function" then
		arg2 = v_u1.func.truthy
	end
	for v2, v3 in ipairs(arg1) do
		if arg2(v3, v2, arg1) then
			table.insert(v1, v3)
		end
	end
	return v1
end