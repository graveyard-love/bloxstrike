-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
require(v_replicatedstorage.Shared.Promise)
local v_u2 = {}
local function v_u3(arg1, arg2)
	-- upvalues: (copy) v_u2
	local v1 = 0
	while v_u2[arg1] == nil do
		v1 = v1 + task.wait()
		if arg2 < v1 then
			break
		end
	end
	return v_u2[arg1]
end
function v1.broadcastRouter(arg1, ...)
	-- upvalues: (copy) v_u3
	local v1 = v_u3(arg1, 1)
	if v1 then
		return v1(...)
	end
	warn((("%* is not cached in local copy."):format(arg1)))
end
function v1.observerRouter(arg1, arg2)
	-- upvalues: (copy) v_u2
	if v_u2[arg1] then
		warn((("%* already has a router cached in local copy."):format(arg1)))
	else
		v_u2[arg1] = arg2
	end
end
return v1