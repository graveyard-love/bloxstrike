-- Decompiled with Bunni.lol Decompiler

local v_u_http = game:GetService("HttpService")
local v_u_heartbeat = game:GetService("RunService").Heartbeat
local v_u1 = {}
v_u1.__index = v_u1
v_u1.ClassName = "Signal"
v_u1.totalConnections = 0
function v_u1.new(arg1)
	-- upvalues: (copy) v_u1
	local v1 = setmetatable({}, v_u1)
	if arg1 then
		v1.connectionsChanged = v_u1.new()
	end
	v1.connections = {}
	v1.totalConnections = 0
	v1.waiting = {}
	v1.totalWaiting = 0
	return v1
end
function v_u1.Fire(arg1, ...)
	for _, v1 in pairs(arg1.connections) do
		task.spawn(v1.Handler, ...)
	end
	if arg1.totalWaiting > 0 then
		local v_pack = table.pack(...)
		for v2, _ in pairs(arg1.waiting) do
			arg1.waiting[v2] = v_pack
		end
	end
end
v_u1.fire = v_u1.Fire
function v_u1.Connect(arg1, arg2)
	-- upvalues: (copy) v_u_http
	if type(arg2) ~= "function" then
		error(("connect(%s)"):format((typeof(arg2))), 2)
	end
	local v_u_generateguid = v_u_http:GenerateGUID(false)
	local v_u1 = {
		["Connected"] = true,
		["ConnectionId"] = v_u_generateguid,
		["Handler"] = arg2
	}
	arg1.connections[v_u_generateguid] = v_u1
	function v_u1.Disconnect(_)
		-- upvalues: (copy) arg1, (copy) v_u_generateguid, (copy) v_u1
		arg1.connections[v_u_generateguid] = nil
		v_u1.Connected = false
		local v1 = arg1
		v1.totalConnections = v1.totalConnections - 1
		if arg1.connectionsChanged then
			arg1.connectionsChanged:Fire(-1)
		end
	end
	v_u1.Destroy = v_u1.Disconnect
	v_u1.destroy = v_u1.Disconnect
	v_u1.disconnect = v_u1.Disconnect
	arg1.totalConnections = arg1.totalConnections + 1
	if arg1.connectionsChanged then
		arg1.connectionsChanged:Fire(1)
	end
	return v_u1
end
v_u1.connect = v_u1.Connect
function v_u1.Wait(arg1)
	-- upvalues: (copy) v_u_http, (copy) v_u_heartbeat
	local v_generateguid = v_u_http:GenerateGUID(false)
	arg1.waiting[v_generateguid] = true
	arg1.totalWaiting = arg1.totalWaiting + 1
	repeat
		v_u_heartbeat:Wait()
	until arg1.waiting[v_generateguid] ~= true
	arg1.totalWaiting = arg1.totalWaiting - 1
	arg1.waiting[v_generateguid] = nil
	return unpack(arg1.waiting[v_generateguid])
end
v_u1.wait = v_u1.Wait
function v_u1.Destroy(arg1)
	if arg1.bindableEvent then
		arg1.bindableEvent:Destroy()
		arg1.bindableEvent = nil
	end
	if arg1.connectionsChanged then
		arg1.connectionsChanged:Fire(-arg1.totalConnections)
		arg1.connectionsChanged:Destroy()
		arg1.connectionsChanged = nil
	end
	arg1.totalConnections = 0
	for v1, _ in pairs(arg1.connections) do
		arg1.connections[v1] = nil
	end
end
v_u1.destroy = v_u1.Destroy
v_u1.Disconnect = v_u1.Destroy
v_u1.disconnect = v_u1.Destroy
return v_u1