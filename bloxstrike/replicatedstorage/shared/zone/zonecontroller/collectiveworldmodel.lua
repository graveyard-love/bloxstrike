-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_u2 = nil
local v_u_run = game:GetService("RunService")
function v1.setupWorldModel(_)
	-- upvalues: (ref) v_u2, (copy) v_u_run
	if v_u2 then
		return v_u2
	end
	v_u2 = Instance.new("WorldModel")
	v_u2.Name = "ZonePlusWorldModel"
	v_u2.Parent = game:GetService(v_u_run:IsClient() and "ReplicatedStorage" or "ServerStorage")
	return v_u2
end
function v1._getCombinedResults(_, arg2, ...)
	-- upvalues: (ref) v_u2
	local v1 = workspace[arg2](workspace, ...)
	if v_u2 then
		local v2 = v_u2[arg2](v_u2, ...)
		for _, v3 in pairs(v2) do
			table.insert(v1, v3)
		end
	end
	return v1
end
function v1.GetPartBoundsInBox(arg1, arg2, arg3, arg4)
	return arg1:_getCombinedResults("GetPartBoundsInBox", arg2, arg3, arg4)
end
function v1.GetPartBoundsInRadius(arg1, arg2, arg3, arg4)
	return arg1:_getCombinedResults("GetPartBoundsInRadius", arg2, arg3, arg4)
end
function v1.GetPartsInPart(arg1, arg2, arg3)
	return arg1:_getCombinedResults("GetPartsInPart", arg2, arg3)
end
return v1