-- Decompiled with Bunni.lol Decompiler

local v_u1 = nil
local function v_u2(arg1, ...)
	-- upvalues: (ref) v_u1
	v_u1 = nil
	arg1(...)
	v_u1 = v_u1
end
local function v_u3(...)
	-- upvalues: (copy) v_u2
	v_u2(...)
	while true do
		v_u2(coroutine.yield())
	end
end
local v_u4 = {}
v_u4.__index = v_u4
function v_u4.new(arg1, arg2)
	-- upvalues: (copy) v_u4
	return setmetatable({
		["_connected"] = true,
		["_signal"] = arg1,
		["_fn"] = arg2,
		["_next"] = false
	}, v_u4)
end
function v_u4.Disconnect(arg1)
	assert(arg1._connected, "Can\'t disconnect a connection twice.", 2)
	arg1._connected = false
	local v__signal = arg1._signal
	if v__signal._handlerListHead == arg1 then
		v__signal._handlerListHead = arg1._next
	else
		local v__handlerlisthead = v__signal._handlerListHead
		while v__handlerlisthead and v__handlerlisthead._next ~= arg1 do
			v__handlerlisthead = v__handlerlisthead._next
		end
		if v__handlerlisthead then
			v__handlerlisthead._next = arg1._next
		end
	end
	if v__signal.connectionsChanged then
		v__signal.totalConnections = v__signal.totalConnections - 1
		v__signal.connectionsChanged:Fire(-1)
	end
end
setmetatable(v_u4, {
	["__index"] = function(_, arg2)
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(arg2))), 2)
	end,
	["__newindex"] = function(_, arg2, _)
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(arg2))), 2)
	end
})
local v_u5 = {}
v_u5.__index = v_u5
function v_u5.new(arg1)
	-- upvalues: (copy) v_u5
	local v1 = setmetatable({
		["_handlerListHead"] = false
	}, v_u5)
	if arg1 then
		v1.totalConnections = 0
		v1.connectionsChanged = v_u5.new()
	end
	return v1
end
function v_u5.Connect(arg1, arg2)
	-- upvalues: (copy) v_u4
	local v_new = v_u4.new(arg1, arg2)
	if arg1._handlerListHead then
		v_new._next = arg1._handlerListHead
		arg1._handlerListHead = v_new
	else
		arg1._handlerListHead = v_new
	end
	if arg1.connectionsChanged then
		arg1.totalConnections = arg1.totalConnections + 1
		arg1.connectionsChanged:Fire(1)
	end
	return v_new
end
function v_u5.DisconnectAll(arg1)
	arg1._handlerListHead = false
	if arg1.connectionsChanged then
		arg1.connectionsChanged:Fire(-arg1.totalConnections)
		arg1.connectionsChanged:Destroy()
		arg1.connectionsChanged = nil
		arg1.totalConnections = 0
	end
end
v_u5.Destroy = v_u5.DisconnectAll
v_u5.destroy = v_u5.DisconnectAll
function v_u5.Fire(arg1, ...)
	-- upvalues: (ref) v_u1, (copy) v_u3
	local v__handlerlisthead = arg1._handlerListHead
	while v__handlerlisthead do
		if v__handlerlisthead._connected then
			if not v_u1 then
				v_u1 = coroutine.create(v_u3)
			end
			task.spawn(v_u1, v__handlerlisthead._fn, ...)
		end
		v__handlerlisthead = v__handlerlisthead._next
	end
end
function v_u5.Wait(arg1)
	local v_u_running = coroutine.running()
	local v_u1 = nil
	v_u1 = arg1:Connect(function(...)
		-- upvalues: (ref) v_u1, (copy) v_u_running
		v_u1:Disconnect()
		task.spawn(v_u_running, ...)
	end)
	return coroutine.yield()
end
return v_u5