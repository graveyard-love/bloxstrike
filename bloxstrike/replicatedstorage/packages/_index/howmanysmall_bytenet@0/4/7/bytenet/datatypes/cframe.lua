-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_writef32noalloc = v1.writef32NoAlloc
local v_u_alloc = v1.alloc
local v_u2 = {
	["Read"] = function(arg1, arg2)
		local v_readf32 = buffer.readf32(arg1, arg2)
		local v_readf32 = buffer.readf32(arg1, arg2 + 4)
		local v_readf32 = buffer.readf32(arg1, arg2 + 8)
		local v_readf32 = buffer.readf32(arg1, arg2 + 12)
		local v_readf32 = buffer.readf32(arg1, arg2 + 16)
		local v_readf32 = buffer.readf32(arg1, arg2 + 20)
		return CFrame.new(v_readf32, v_readf32, v_readf32) * CFrame.Angles(v_readf32, v_readf32, v_readf32), 24
	end,
	["Write"] = function(arg1)
		-- upvalues: (copy) v_u_alloc, (copy) v_u_writef32noalloc
		local v_toeuleranglesxyz, v1, v2 = arg1:ToEulerAnglesXYZ()
		v_u_alloc(24)
		v_u_writef32noalloc(arg1.X)
		v_u_writef32noalloc(arg1.Y)
		v_u_writef32noalloc(arg1.Z)
		v_u_writef32noalloc(v_toeuleranglesxyz)
		v_u_writef32noalloc(v1)
		v_u_writef32noalloc(v2)
	end
}
return function()
	-- upvalues: (copy) v_u2
	return v_u2
end