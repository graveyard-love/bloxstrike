-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.Parent.Util)
local v_u2 = require(script.Parent.copy)
return function(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u2, (copy) v_u1
	local v1 = #arg1
	local v2 = v_u2(arg1)
	if arg2 < 1 then
		arg2 = arg2 + v1
	end
	if type(arg3) ~= "function" then
		arg3 = v_u1.func.returned
	end
	if v2[arg2] ~= nil then
		v2[arg2] = arg3(v2[arg2], arg2)
		return v2
	end
	local v3
	if type(arg4) == "function" then
		v3 = arg4(arg2)
	else
		v3 = nil
	end
	v2[arg2] = v3
	return v2
end