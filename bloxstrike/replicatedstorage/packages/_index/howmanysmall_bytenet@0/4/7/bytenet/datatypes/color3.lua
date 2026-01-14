-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_writeu8noalloc = v1.writeu8NoAlloc
local v_u_alloc = v1.alloc
local v_u2 = {
	["Write"] = function(arg1)
		-- upvalues: (copy) v_u_alloc, (copy) v_u_writeu8noalloc
		v_u_alloc(3)
		v_u_writeu8noalloc(arg1.R * 255)
		v_u_writeu8noalloc(arg1.G * 255)
		v_u_writeu8noalloc(arg1.B * 255)
	end,
	["Read"] = function(arg1, arg2)
		local v_readu8 = buffer.readu8(arg1, arg2)
		local v_readu8 = buffer.readu8(arg1, arg2 + 1)
		return Color3.fromRGB(v_readu8, v_readu8, (buffer.readu8(arg1, arg2 + 2))), 3
	end
}
return function()
	-- upvalues: (copy) v_u2
	return v_u2
end