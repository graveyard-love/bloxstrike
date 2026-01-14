-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
function v_u1.new()
	-- upvalues: (copy) v_u1
	local v1 = setmetatable({}, v_u1)
	v1._connections = {}
	return v1
end
function v_u1.trackConnection(arg1, arg2, arg3)
	if arg1._connections[arg2] then
		arg1._connections[arg2]()
	end
	arg1._connections[arg2] = function()
		-- upvalues: (copy) arg3
		arg3:Disconnect()
	end
end
function v_u1.trackBoundFunction(arg1, arg2, arg3)
	if arg1._connections[arg2] then
		arg1._connections[arg2]()
	end
	arg1._connections[arg2] = arg3
end
function v_u1.disconnect(arg1, arg2)
	if arg1._connections[arg2] then
		arg1._connections[arg2]()
		arg1._connections[arg2] = nil
	end
end
function v_u1.disconnectAll(arg1)
	for _, v1 in pairs(arg1._connections) do
		v1()
	end
	arg1._connections = {}
end
return v_u1