-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.Parent.Parent.process.bufferWriter)
local v_u2 = require(script.Parent.Parent.process.readRefs)
require(script.Parent.Parent.types)
local v_u_writereference = v1.writeReference
local v_u_alloc = v1.alloc
return function()
	-- upvalues: (copy) v_u_alloc, (copy) v_u_writereference, (copy) v_u2
	return {
		["Write"] = function(arg1)
			-- upvalues: (ref) v_u_alloc, (ref) v_u_writereference
			v_u_alloc(1)
			v_u_writereference(arg1)
		end,
		["Read"] = function(arg1, arg2)
			-- upvalues: (ref) v_u2
			local v_get = v_u2.get()
			if v_get then
				return v_get[buffer.readu8(arg1, arg2)], 1
			else
				return nil, 1
			end
		end
	}
end