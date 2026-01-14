-- Decompiled with Bunni.lol Decompiler

require(script.Parent.Parent.types)
local v_u1 = nil
local v_u2 = nil
local v_u3 = nil
local v_u4 = nil
local v_u_create = buffer.create
return {
	["alloc"] = function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) v_u_create, (ref) v_u3
		if v_u2 + arg1 >= v_u1 then
			local v1 = v_u_create(v_u1 * 2)
			buffer.copy(v1, 0, v_u3)
			v_u3 = v1
		end
	end,
	["dyn_alloc"] = function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) v_u_create, (ref) v_u3
		while v_u1 <= v_u2 + arg1 do
			v_u1 = v_u1 * 2
		end
		local v1 = v_u_create(v_u1)
		buffer.copy(v1, 0, v_u3)
		v_u3 = v1
	end,
	["writeu8NoAlloc"] = function(arg1)
		-- upvalues: (ref) v_u3, (ref) v_u2
		buffer.writeu8(v_u3, v_u2, arg1)
		v_u2 = v_u2 + 1
	end,
	["writeu8"] = function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) v_u_create, (ref) v_u3
		if v_u2 + 1 >= v_u1 then
			local v1 = v_u_create(v_u1 * 2)
			buffer.copy(v1, 0, v_u3)
			v_u3 = v1
		end
		buffer.writeu8(v_u3, v_u2, arg1)
		v_u2 = v_u2 + 1
	end,
	["writei8"] = function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) v_u_create, (ref) v_u3
		if v_u2 + 1 >= v_u1 then
			local v1 = v_u_create(v_u1 * 2)
			buffer.copy(v1, 0, v_u3)
			v_u3 = v1
		end
		buffer.writei8(v_u3, v_u2, arg1)
		v_u2 = v_u2 + 1
	end,
	["writeReference"] = function(arg1)
		-- upvalues: (ref) v_u4, (ref) v_u3, (ref) v_u2
		table.insert(v_u4, arg1)
		buffer.writeu8(v_u3, v_u2, #v_u4)
		v_u2 = v_u2 + 1
	end,
	["writeu16"] = function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) v_u_create, (ref) v_u3
		if v_u2 + 2 >= v_u1 then
			local v1 = v_u_create(v_u1 * 2)
			buffer.copy(v1, 0, v_u3)
			v_u3 = v1
		end
		buffer.writeu16(v_u3, v_u2, arg1)
		v_u2 = v_u2 + 2
	end,
	["writei16"] = function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) v_u_create, (ref) v_u3
		if v_u2 + 2 >= v_u1 then
			local v1 = v_u_create(v_u1 * 2)
			buffer.copy(v1, 0, v_u3)
			v_u3 = v1
		end
		buffer.writeu16(v_u3, v_u2, arg1)
		v_u2 = v_u2 + 2
	end,
	["writeu32"] = function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) v_u_create, (ref) v_u3
		if v_u2 + 4 >= v_u1 then
			local v1 = v_u_create(v_u1 * 2)
			buffer.copy(v1, 0, v_u3)
			v_u3 = v1
		end
		buffer.writeu32(v_u3, v_u2, arg1)
		v_u2 = v_u2 + 4
	end,
	["writestring"] = function(arg1)
		-- upvalues: (ref) v_u3, (ref) v_u2
		buffer.writestring(v_u3, v_u2, arg1)
		v_u2 = v_u2 + #arg1
	end,
	["writei32"] = function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) v_u_create, (ref) v_u3
		if v_u2 + 4 >= v_u1 then
			local v1 = v_u_create(v_u1 * 2)
			buffer.copy(v1, 0, v_u3)
			v_u3 = v1
		end
		buffer.writei32(v_u3, v_u2, arg1)
		v_u2 = v_u2 + 4
	end,
	["writef32NoAlloc"] = function(arg1)
		-- upvalues: (ref) v_u3, (ref) v_u2
		buffer.writef32(v_u3, v_u2, arg1)
		v_u2 = v_u2 + 4
	end,
	["writef64NoAlloc"] = function(arg1)
		-- upvalues: (ref) v_u3, (ref) v_u2
		buffer.writef64(v_u3, v_u2, arg1)
		v_u2 = v_u2 + 4
	end,
	["writef32"] = function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) v_u_create, (ref) v_u3
		if v_u2 + 4 >= v_u1 then
			local v1 = v_u_create(v_u1 * 2)
			buffer.copy(v1, 0, v_u3)
			v_u3 = v1
		end
		buffer.writef32(v_u3, v_u2, arg1)
		v_u2 = v_u2 + 4
	end,
	["writef64"] = function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) v_u_create, (ref) v_u3
		if v_u2 + 8 >= v_u1 then
			local v1 = v_u_create(v_u1 * 2)
			buffer.copy(v1, 0, v_u3)
			v_u3 = v1
		end
		buffer.writef64(v_u3, v_u2, arg1)
		v_u2 = v_u2 + 8
	end,
	["writecopy"] = function(arg1)
		-- upvalues: (ref) v_u3, (ref) v_u2
		buffer.copy(v_u3, v_u2, arg1)
		v_u2 = v_u2 + buffer.len(arg1)
	end,
	["writebool"] = function(arg1)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) v_u_create, (ref) v_u3
		if v_u2 + 1 >= v_u1 then
			local v1 = v_u_create(v_u1 * 2)
			buffer.copy(v1, 0, v_u3)
			v_u3 = v1
		end
		buffer.writeu8(v_u3, v_u2, arg1 and 1 or 0)
		v_u2 = v_u2 + 1
	end,
	["writePacket"] = function(arg1, arg2, arg3, arg4)
		-- upvalues: (ref) v_u1, (ref) v_u2, (ref) v_u4, (ref) v_u3, (copy) v_u_create
		v_u4 = arg1.references
		v_u3 = arg1.buff
		if arg1.cursor + 1 >= arg1.size then
			local v1 = v_u_create(v_u1 * 2)
			buffer.copy(v1, 0, v_u3)
			v_u3 = v1
		end
		buffer.writeu8(v_u3, v_u2, arg2)
		arg3(arg4)
		arg1.size = v_u1
		arg1.cursor = v_u2 + 1
		arg1.references = v_u4
		arg1.buff = v_u3
		return arg1
	end
}