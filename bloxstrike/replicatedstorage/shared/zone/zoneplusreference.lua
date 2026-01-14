-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
return {
	["addToReplicatedStorage"] = function()
		-- upvalues: (copy) v_u_replicatedstorage
		if v_u_replicatedstorage:FindFirstChild(script.Name) then
			return false
		end
		local v_objectvalue = Instance.new("ObjectValue")
		v_objectvalue.Name = script.Name
		v_objectvalue.Value = script.Parent
		v_objectvalue.Parent = v_u_replicatedstorage
		local v_boolvalue = Instance.new("BoolValue")
		v_boolvalue.Name = game:GetService("RunService"):IsClient() and "Client" or "Server"
		v_boolvalue.Value = true
		v_boolvalue.Parent = v_objectvalue
		return v_objectvalue
	end,
	["getObject"] = function()
		-- upvalues: (copy) v_u_replicatedstorage
		return v_u_replicatedstorage:FindFirstChild(script.Name) or false
	end
}