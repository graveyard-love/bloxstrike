-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_u_replicatedstorage.Database.Custom.Types)
return function(arg1)
	-- upvalues: (copy) v_u_replicatedstorage
	local v1 = v_u_replicatedstorage.Database.Custom.Weapons:FindFirstChild(arg1)
	local v_format = ("\"%*\" is not a valid member of database.custom.weapons"):format(arg1)
	assert(v1, v_format)
	return require(v1)
end