-- Decompiled with Bunni.lol Decompiler

local v_u_heartbeat = game:GetService("RunService").Heartbeat
local v_u1 = newproxy(true)
getmetatable(v_u1).__tostring = function()
	return "IndicesReference"
end
local v_u2 = newproxy(true)
getmetatable(v_u2).__tostring = function()
	return "LinkToInstanceIndex"
end
local v_u3 = {
	["ClassName"] = "Janitor",
	["__index"] = {
		["CurrentlyCleaning"] = true,
		[v_u1] = nil
	}
}
local v_u4 = {
	["function"] = true,
	["RBXScriptConnection"] = "Disconnect"
}
function v_u3.new()
	-- upvalues: (copy) v_u1, (copy) v_u3
	return setmetatable({
		["CurrentlyCleaning"] = false,
		[v_u1] = nil
	}, v_u3)
end
function v_u3.Is(arg1)
	-- upvalues: (copy) v_u3
	local v1
	if type(arg1) == "table" then
		v1 = getmetatable(arg1) == v_u3
	else
		v1 = false
	end
	return v1
end
v_u3.is = v_u3.Is
function v_u3.__index.Add(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u1, (copy) v_u4
	if arg4 == nil then
		arg4 = newproxy(false)
	end
	if arg4 then
		arg1:Remove(arg4)
		local v1 = arg1[v_u1]
		if not v1 then
			v1 = {}
			arg1[v_u1] = v1
		end
		v1[arg4] = arg2
	end
	local v2 = arg3 or (v_u4[typeof(arg2)] or "Destroy")
	if type(arg2) ~= "function" and not arg2[v2] then
		warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(arg2), tostring(v2), debug.traceback(nil, 2)))
	end
	arg1[arg2] = v2
	return arg2, arg4
end
v_u3.__index.Give = v_u3.__index.Add
function v_u3.__index.AddObject(arg1, arg2)
	local v1 = newproxy(false)
	return arg1:Add(arg2, false, v1), v1
end
v_u3.__index.GiveObject = v_u3.__index.AddObject
function v_u3.__index.Remove(arg1, arg2)
	-- upvalues: (copy) v_u1
	local v1 = arg1[v_u1]
	local v2 = v1 and v1[arg2]
	if v2 then
		local v3 = arg1[v2]
		if v3 then
			if v3 == true then
				v2()
			else
				local v4 = v2[v3]
				if v4 then
					v4(v2)
				end
			end
			arg1[v2] = nil
		end
		v1[arg2] = nil
	end
	return arg1
end
function v_u3.__index.Get(arg1, arg2)
	-- upvalues: (copy) v_u1
	local v1 = arg1[v_u1]
	if v1 then
		return v1[arg2]
	end
end
function v_u3.__index.Cleanup(arg1)
	-- upvalues: (copy) v_u1
	if not arg1.CurrentlyCleaning then
		arg1.CurrentlyCleaning = nil
		for v1, v2 in next, arg1 do
			if v1 ~= v_u1 then
				local v3 = type(v1)
				if v3 == "string" or v3 == "number" then
					arg1[v1] = nil
				else
					if v2 == true then
						v1()
					else
						local v4 = v1[v2]
						if v4 then
							v4(v1)
						end
					end
					arg1[v1] = nil
				end
			end
		end
		local v5 = arg1[v_u1]
		if v5 then
			for v6 in next, v5 do
				v5[v6] = nil
			end
			arg1[v_u1] = {}
		end
		arg1.CurrentlyCleaning = false
	end
end
v_u3.__index.Clean = v_u3.__index.Cleanup
function v_u3.__index.Destroy(arg1)
	arg1:Cleanup()
end
v_u3.__call = v_u3.__index.Cleanup
local v_u5 = {
	["Connected"] = true
}
v_u5.__index = v_u5
function v_u5.Disconnect(arg1)
	if arg1.Connected then
		arg1.Connected = false
		arg1.Connection:Disconnect()
	end
end
function v_u5.__tostring(arg1)
	return "Disconnect<" .. tostring(arg1.Connected) .. ">"
end
function v_u3.__index.LinkToInstance(arg1, arg2, arg3)
	-- upvalues: (copy) v_u2, (copy) v_u5, (copy) v_u_heartbeat
	local v_u1 = nil
	local v2 = arg3 and newproxy(false) or v_u2
	local v_u3 = arg2.Parent == nil
	local v_u4 = setmetatable({}, v_u5)
	local function v5(_, arg2)
		-- upvalues: (copy) v_u4, (ref) v_u3, (ref) v_u_heartbeat, (ref) v_u1, (copy) arg1
		if v_u4.Connected and arg2 == nil then
			coroutine.wrap(function()
				-- upvalues: (ref) v_u_heartbeat, (ref) v_u4, (ref) v_u1, (ref) arg1, (ref) v_u3
				v_u_heartbeat:Wait()
				if v_u4.Connected then
					if v_u1.Connected then
						while v_u3 and (v_u1.Connected and v_u4.Connected) do
							v_u_heartbeat:Wait()
						end
						if v_u4.Connected and v_u3 then
							arg1:Cleanup()
						end
					else
						arg1:Cleanup()
					end
				else
					return
				end
			end)()
		end
	end
	local v_u_connection = arg2.AncestryChanged:Connect(v5)
	v_u4.Connection = v_u_connection
	if v_u3 then
		local v_parent = arg2.Parent
		if v_u4.Connected then
			if v_parent == nil then
				v_u3 = true
			else
				v_u3 = false
			end
			if v_u3 then
				coroutine.wrap(function()
					-- upvalues: (ref) v_u_heartbeat, (copy) v_u4, (ref) v_u_connection, (copy) arg1, (ref) v_u3
					v_u_heartbeat:Wait()
					if v_u4.Connected then
						if v_u_connection.Connected then
							while v_u3 and (v_u_connection.Connected and v_u4.Connected) do
								v_u_heartbeat:Wait()
							end
							if v_u4.Connected and v_u3 then
								arg1:Cleanup()
							end
						else
							arg1:Cleanup()
						end
					else
						return
					end
				end)()
			end
		end
	end
	return arg1:Add(v_u4, "Disconnect", v2)
end
function v_u3.__index.LinkToInstances(arg1, ...)
	-- upvalues: (copy) v_u3
	local v_new = v_u3.new()
	for _, v1 in ipairs({ ... }) do
		v_new:Add(arg1:LinkToInstance(v1, true), "Disconnect")
	end
	return v_new
end
for v6, v7 in next, v_u3.__index do
	local v_lower = string.lower(v6)
	v_u3.__index[string.sub(v_lower, 1, 1) .. string.sub(v6, 2)] = v7
end
return v_u3