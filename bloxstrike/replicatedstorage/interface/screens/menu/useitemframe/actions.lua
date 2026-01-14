-- Decompiled with Bunni.lol Decompiler

local v1 = {}
game:GetService("ReplicatedStorage")
require(script.Types)
local v2 = require(script.AttachCharm)
local v_u3 = {}
function v1.Register(arg1)
	-- upvalues: (copy) v_u3
	if v_u3[arg1.ActionType] then
		warn((("[Actions] Action \"%*\" is already registered"):format(arg1.ActionType)))
	else
		v_u3[arg1.ActionType] = arg1
	end
end
function v1.Get(arg1)
	-- upvalues: (copy) v_u3
	return v_u3[arg1]
end
function v1.Has(arg1)
	-- upvalues: (copy) v_u3
	return v_u3[arg1] ~= nil
end
function v1.GetAllTypes()
	-- upvalues: (copy) v_u3
	local v1 = {}
	for v2, _ in pairs(v_u3) do
		table.insert(v1, v2)
	end
	return v1
end
function v1.InitializeAll()
	-- upvalues: (copy) v_u3
	for _, v1 in pairs(v_u3) do
		if v1.Initialize then
			v1.Initialize()
		end
	end
end
function v1.DestroyAll()
	-- upvalues: (copy) v_u3
	for _, v1 in pairs(v_u3) do
		if v1.Destroy then
			v1.Destroy()
		end
	end
end
v1.Register(v2)
return v1