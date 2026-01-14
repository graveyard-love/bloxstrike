-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.copy)
return function(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u1
	local v1 = v_u1(arg1)
	if v1[arg2] then
		if arg3 then
			v1[arg2] = arg3(v1[arg2], arg2)
			return v1
		end
	elseif typeof(arg4) == "function" then
		v1[arg2] = arg4(arg2)
	end
	return v1
end