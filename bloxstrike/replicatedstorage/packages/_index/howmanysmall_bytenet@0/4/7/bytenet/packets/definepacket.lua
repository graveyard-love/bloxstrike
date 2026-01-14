-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.packet)
require(script.Parent.Parent.types)
return function(self)
	-- upvalues: (copy) v_u1
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		return v_u1(self, arg1)
	end
end