-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_writeu16 = v1.writeu16
local v_u_writecopy = v1.writecopy
local v_u_dyn_alloc = v1.dyn_alloc
local v_u_create = buffer.create
local v_u2 = {
	["Read"] = function(arg1, arg2)
		-- upvalues: (copy) v_u_create
		local v_readu16 = buffer.readu16(arg1, arg2)
		local v1 = v_u_create(v_readu16)
		buffer.copy(v1, 0, arg1, arg2 + 2, v_readu16)
		return v1, v_readu16 + 2
	end,
	["Write"] = function(arg1)
		-- upvalues: (copy) v_u_writeu16, (copy) v_u_dyn_alloc, (copy) v_u_writecopy
		local v_len = buffer.len(arg1)
		v_u_writeu16(v_len)
		v_u_dyn_alloc(v_len)
		v_u_writecopy(arg1)
	end
}
return function()
	-- upvalues: (copy) v_u2
	return v_u2
end