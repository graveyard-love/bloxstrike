-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.Parent.Set.fromArray)
local v_u2 = require(script.Parent.Parent.Set.toArray)
return function(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u1
	return v_u2(v_u1(arg1))
end