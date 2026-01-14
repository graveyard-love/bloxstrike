-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.Parent.Parent.namespaces.packetIDs)
local v_u2 = require(script.Parent.readRefs)
local v_u_ref = v1.ref()
local v_u3 = nil
local function v_u4(arg1, ...)
	-- upvalues: (ref) v_u3
	v_u3 = nil
	arg1(...)
	v_u3 = v_u3
end
local function v_u5()
	-- upvalues: (copy) v_u4
	while true do
		v_u4(coroutine.yield())
	end
end
local function v_u6(arg1, ...)
	-- upvalues: (ref) v_u3, (copy) v_u5
	if v_u3 == nil then
		v_u3 = coroutine.create(v_u5)
		coroutine.resume(v_u3)
	end
	task.spawn(v_u3, arg1, ...)
end
return function(arg1, arg2, arg3)
	-- upvalues: (copy) v_u2, (copy) v_u_ref, (copy) v_u6
	local v_len = buffer.len(arg1)
	v_u2.set(arg2)
	local v1 = 0
	while v1 < v_len do
		local v2 = v_u_ref[buffer.readu8(arg1, v1)]
		local v3 = v1 + 1
		local v_reader, v4 = v2.Reader(arg1, v3)
		v1 = v3 + v4
		for _, v5 in v2.GetListeners() do
			v_u6(v5, v_reader, arg3)
		end
	end
end