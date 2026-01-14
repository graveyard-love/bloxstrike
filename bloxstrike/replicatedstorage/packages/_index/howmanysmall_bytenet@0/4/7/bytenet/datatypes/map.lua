-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_writeu16 = v1.writeu16
return function(arg1, arg2)
	-- upvalues: (copy) v_u_writeu16
	local v_u_write = arg1.Write
	local v_u_write = arg2.Write
	return {
		["Read"] = function(arg1, arg2)
			-- upvalues: (copy) arg1, (copy) arg2
			local v_readu16 = buffer.readu16(arg1, arg2)
			local v1 = arg2 + 2
			local v2 = {}
			for _ = 1, v_readu16 do
				local v_read, v3 = arg1.Read(arg1, v1)
				local v4 = v1 + v3
				local v_read, v5 = arg2.Read(arg1, v4)
				v1 = v4 + v5
				v2[v_read] = v_read
			end
			return v2, v1 - arg2
		end,
		["Write"] = function(arg1)
			-- upvalues: (ref) v_u_writeu16, (copy) v_u_write, (copy) v_u_write
			local v1 = 0
			for _ in arg1 do
				v1 = v1 + 1
			end
			v_u_writeu16(v1)
			for v2, v3 in arg1 do
				v_u_write(v2)
				v_u_write(v3)
			end
		end
	}
end