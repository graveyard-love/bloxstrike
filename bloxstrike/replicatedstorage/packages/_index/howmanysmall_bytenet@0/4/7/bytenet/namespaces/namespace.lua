-- Decompiled with Bunni.lol Decompiler

local v_run = game:GetService("RunService")
local v_u1 = require(script.Parent.namespacesDependencies)
local v_u2 = require(script.Parent.packetIDs)
require(script.Parent.Parent.types)
local v_u3 = require(script.Parent.Parent.replicated.values)
local v_u4 = v_run:IsServer() and "server" or "client"
local v_u5 = 0
return function(arg1, arg2)
	-- upvalues: (copy) v_u3, (copy) v_u1, (copy) v_u4, (ref) v_u5, (copy) v_u2
	local v_access = v_u3.access(arg1)
	v_u1.start(arg1)
	local v1 = arg2()
	local v_empty = v_u1.empty()
	local v2 = {}
	if v_u4 ~= "server" then
		if v_u4 == "client" then
			local v_read = v_access:read()
			for v3, v4 in v1 do
				v2[v3] = v4(v_read.packets[v3])
				v_u2.set(v_read.packets[v3], v2[v3])
			end
		end
		return v2
	end
	local v5 = {
		["structs"] = {},
		["packets"] = {}
	}
	for v6 in v1 do
		v_u5 = v_u5 + 1
		v5.packets[v6] = v_u5
		v2[v6] = v1[v6](v_u5)
		v_u2.set(v_u5, v2[v6])
	end
	for v7, v8 in v_empty do
		v5.structs[v7] = v8
	end
	v_access:write(v5)
	return v2
end