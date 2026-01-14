-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
return {
	["IsEnabled"] = function(arg1)
		-- upvalues: (copy) v_u_replicatedstorage
		return v_u_replicatedstorage:GetAttribute("Debug_" .. arg1) == true
	end,
	["SetEnabled"] = function(arg1, arg2)
		-- upvalues: (copy) v_u_run, (copy) v_u_replicatedstorage
		if v_u_run:IsServer() or v_u_run:IsClient() then
			v_u_replicatedstorage:SetAttribute("Debug_" .. arg1, arg2)
		end
	end,
	["GetAttributeName"] = function(arg1)
		return "Debug_" .. arg1
	end
}