-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_writeu16 = v1.writeu16
return function(arg1)
	-- upvalues: (copy) v_u_writeu16
	local v_u_write = arg1.Write
	local v_u_read = arg1.Read
	return {
		["Read"] = function(arg1, arg2)
			-- upvalues: (copy) v_u_read
			local v_readu16 = buffer.readu16(arg1, arg2)
			local v1 = arg2 + 2
			local v_create = table.create(v_readu16)
			for v2 = 1, v_readu16 do
				local v3, v4 = v_u_read(arg1, v1)
				v_create[v2] = v3
				v1 = v1 + v4
			end
			return v_create, v1 - arg2
		end,
		["Write"] = function(arg1)
			-- upvalues: (ref) v_u_writeu16, (copy) v_u_write
			v_u_writeu16(#arg1)
			for _, v1 in arg1 do
				v_u_write(v1)
			end
		end
	}
end