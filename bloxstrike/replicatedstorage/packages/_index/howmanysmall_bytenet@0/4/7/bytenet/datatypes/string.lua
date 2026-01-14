-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_writeu16 = v1.writeu16
local v_u_writestring = v1.writestring
local v_u_dyn_alloc = v1.dyn_alloc
local v_u2 = {
	["Read"] = function(arg1, arg2)
		local v_readu16 = buffer.readu16(arg1, arg2)
		return buffer.readstring(arg1, arg2 + 2, v_readu16), v_readu16 + 2
	end,
	["Write"] = function(arg1)
		-- upvalues: (copy) v_u_writeu16, (copy) v_u_dyn_alloc, (copy) v_u_writestring
		local v1 = #arg1
		v_u_writeu16(v1)
		v_u_dyn_alloc(v1)
		v_u_writestring(arg1)
	end
}
return function()
	-- upvalues: (copy) v_u2
	return v_u2
end