-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_writebool = v1.writebool
return function(arg1)
	-- upvalues: (copy) v_u_writebool
	local v_u_read = arg1.Read
	local v_u_write = arg1.Write
	return {
		["Read"] = function(arg1, arg2)
			-- upvalues: (copy) v_u_read
			if buffer.readu8(arg1, arg2) == 0 then
				return nil, 1
			end
			local v1, v2 = v_u_read(arg1, arg2 + 1)
			return v1, v2 + 1
		end,
		["Write"] = function(arg1)
			-- upvalues: (ref) v_u_writebool, (copy) v_u_write
			local v1 = arg1 ~= nil
			v_u_writebool(v1)
			if v1 then
				v_u_write(arg1)
			end
		end
	}
end