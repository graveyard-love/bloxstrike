-- Decompiled with Bunni.lol Decompiler

local v_u1 = nil
return {
	["set"] = function(arg1)
		-- upvalues: (ref) v_u1
		v_u1 = arg1
	end,
	["get"] = function()
		-- upvalues: (ref) v_u1
		return v_u1
	end
}