-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_run = game:GetService("RunService")
local v_u1 = require(v_replicatedstorage.Database.Security.Router)
local v_u_isserver = v_run:IsServer()
local v2 = {
	["Purchase Featured Bundle"] = {
		["GamepassId"] = 1616058274,
		["OnPurchased"] = function(arg1)
			-- upvalues: (copy) v_u_isserver, (copy) v_u1
			assert(v_u_isserver, "This function should only be called in studio.")
			return v_u1.broadcastRouter("Purchase Featured Bundle", arg1)
		end
	}
}
return table.freeze(v2)