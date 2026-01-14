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
function v_u4.Disconnect(arg1)
	if arg1.Connected then
		arg1.Connected = false
		if arg1._signal._handlerListHead == arg1 then
			arg1._signal._handlerListHead = arg1._next
		else
			local v__handlerlisthead = arg1._signal._handlerListHead
			while v__handlerlisthead and v__handlerlisthead._next ~= arg1 do
				v__handlerlisthead = v__handlerlisthead._next
			end
			if v__handlerlisthead then
				v__handlerlisthead._next = arg1._next
			end
		end
	else
		return
	end
end
v_u4.Destroy = v_u4.Disconnect
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
function v_u5.new()
	-- upvalues: (copy) v_u5
	return setmetatable({
		["_handlerListHead"] = false,
		["_proxyHandler"] = nil,
		["_yieldedThreads"] = nil
	}, v_u5)
end
function v_u5.Wrap(arg1)
	-- upvalues: (copy) v_u5
	assert(typeof(arg1) == "RBXScriptSignal", "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(arg1))
	local v_u_new = v_u5.new()
	v_u_new._proxyHandler = arg1:Connect(function(...)
		-- upvalues: (copy) v_u_new
		v_u_new:Fire(...)
	end)
	return v_u_new
end
function v_u5.Is(arg1)
	-- upvalues: (copy) v_u5
	local v1
	if type(arg1) == "table" then
		v1 = getmetatable(arg1) == v_u5
	else
		v1 = false
	end
	return v1
end
function v_u5.Connect(arg1, arg2)
	-- upvalues: (copy) v_u4
	local v1 = setmetatable({
		["Connected"] = true,
		["_signal"] = arg1,
		["_fn"] = arg2,
		["_next"] = false
	}, v_u4)
	if not arg1._handlerListHead then
		arg1._handlerListHead = v1
		return v1
	end
	v1._next = arg1._handlerListHead
	arg1._handlerListHead = v1
	return v1
end
function v_u5.ConnectOnce(arg1, arg2)
	return arg1:Once(arg2)
end
function v_u5.Once(arg1, arg2)
	local v_u1 = nil
	local v_u2 = false
	v_u1 = arg1:Connect(function(...)
		-- upvalues: (ref) v_u2, (ref) v_u1, (copy) arg2
		if not v_u2 then
			v_u2 = true
			v_u1:Disconnect()
			arg2(...)
		end
	end)
	return v_u1
end
function v_u5.GetConnections(arg1)
	local v__handlerlisthead = arg1._handlerListHead
	local v1 = {}
	while v__handlerlisthead do
		table.insert(v1, v__handlerlisthead)
		v__handlerlisthead = v__handlerlisthead._next
	end
	return v1
end
function v_u5.DisconnectAll(arg1)
	local v__handlerlisthead = arg1._handlerListHead
	while v__handlerlisthead do
		v__handlerlisthead.Connected = false
		v__handlerlisthead = v__handlerlisthead._next
	end
	arg1._handlerListHead = false
	local v1 = rawget(arg1, "_yieldedThreads")
	if v1 then
		for v2 in v1 do
			if coroutine.status(v2) == "suspended" then
				warn(debug.traceback(v2, "signal disconnected; yielded thread cancelled", 2))
				task.cancel(v2)
			end
		end
		table.clear(arg1._yieldedThreads)
	end
end
function v_u5.Fire(arg1, ...)
	-- upvalues: (ref) v_u1, (copy) v_u3
	local v__handlerlisthead = arg1._handlerListHead
	while v__handlerlisthead do
		if v__handlerlisthead.Connected then
			if not v_u1 then
				v_u1 = coroutine.create(v_u3)
			end
			task.spawn(v_u1, v__handlerlisthead._fn, ...)
		end
		v__handlerlisthead = v__handlerlisthead._next
	end
end
function v_u5.FireDeferred(arg1, ...)
	local v_u__handlerlisthead = arg1._handlerListHead
	while v_u__handlerlisthead do
		task.defer(function(...)
			-- upvalues: (copy) v_u__handlerlisthead
			if v_u__handlerlisthead.Connected then
				v_u__handlerlisthead._fn(...)
			end
		end, ...)
		v_u__handlerlisthead = v_u__handlerlisthead._next
	end
end
function v_u5.Wait(arg1)
	local v_u1 = rawget(arg1, "_yieldedThreads")
	if not v_u1 then
		v_u1 = {}
		rawset(arg1, "_yieldedThreads", v_u1)
	end
	local v_u_running = coroutine.running()
	v_u1[v_u_running] = true
	arg1:Once(function(...)
		-- upvalues: (ref) v_u1, (copy) v_u_running
		v_u1[v_u_running] = nil
		if coroutine.status(v_u_running) == "suspended" then
			task.spawn(v_u_running, ...)
		end
	end)
	return coroutine.yield()
end
function v_u5.Destroy(arg1)
	arg1:DisconnectAll()
	local v1 = rawget(arg1, "_proxyHandler")
	if v1 then
		v1:Disconnect()
	end
end
setmetatable(v_u5, {
	["__index"] = function(_, arg2)
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(arg2))), 2)
	end,
	["__newindex"] = function(_, arg2, _)
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(arg2))), 2)
	end
})
return table.freeze({
	["new"] = v_u5.new,
	["Wrap"] = v_u5.Wrap,
	["Is"] = v_u5.Is
})