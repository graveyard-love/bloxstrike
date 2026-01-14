-- Decompiled with Bunni.lol Decompiler

local v_run = game:GetService("RunService")
local v_u1 = require(script.Parent.Parent.namespaces.namespacesDependencies)
require(script.Parent.Parent.types)
local v_u2 = require(script.Parent.Parent.replicated.values)
local v_u3 = v_run:IsServer() and "server" or "client"
return function(self)
	-- upvalues: (copy) v_u3, (copy) v_u1, (copy) v_u2
	local v_u1 = {}
	local v_u2 = {}
	if v_u3 == "server" then
		local v3 = 0
		local v4 = {}
		for v5 in self do
			v3 = v3 + 1
			v4[v5] = v3
			v_u1[v3] = self[v5]
			v_u2[v3] = v5
		end
		v_u1.add(v4)
	elseif v_u3 == "client" then
		v_u1.add(self)
		local v_currentname = v_u1.currentName()
		for v6, v7 in v_u2.access(v_currentname):read().structs[v_u1.currentLength()] do
			v_u1[v7] = self[v6]
			v_u2[v7] = v6
		end
	end
	return {
		["Read"] = function(arg1, arg2)
			-- upvalues: (copy) self, (copy) v_u1, (copy) v_u2
			local v_clone = table.clone(self)
			local v1 = arg2
			for v2, v3 in v_u1 do
				local v_read, v4 = v3.Read(arg1, arg2)
				v_clone[v_u2[v2]] = v_read
				arg2 = arg2 + v4
			end
			return v_clone, arg2 - v1
		end,
		["Write"] = function(arg1)
			-- upvalues: (copy) v_u1, (copy) v_u2
			for v1, v2 in v_u1 do
				v2.Write(arg1[v_u2[v1]])
			end
		end
	}
end