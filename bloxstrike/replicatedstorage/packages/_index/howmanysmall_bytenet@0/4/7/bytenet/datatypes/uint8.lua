-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u2 = {
	["Write"] = v1.writeu8,
	["Read"] = function(arg1, arg2)
		return buffer.readu8(arg1, arg2), 1
	end
}
return function()
	-- upvalues: (copy) v_u2
	return v_u2
end