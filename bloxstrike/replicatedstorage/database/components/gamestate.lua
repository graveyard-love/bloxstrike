-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u1 = require(v_replicatedstorage.Packages.Observers)
local v_u2 = {
	"Map Voting",
	"Game Ending",
	"Warmup",
	"Round In Progress",
	"Buy Period",
	"Intermission"
}
return {
	["GetState"] = function()
		return workspace:GetAttribute("GameState")
	end,
	["SetState"] = function(arg1)
		-- upvalues: (copy) v_u_run, (copy) v_u2
		local v_isserver = v_u_run:IsServer()
		assert(v_isserver, "This method is only available to the server.")
		local v_find = table.find(v_u2, arg1)
		local v_format = ("\"%*\" is not a valid state!"):format(arg1)
		assert(v_find, v_format)
		if true then
			workspace:SetAttribute("GameState", arg1)
		end
	end,
	["ListenToState"] = function(self)
		-- upvalues: (copy) v_u1
		local v_u1 = nil
		return v_u1.observeAttribute(workspace, "GameState", function(arg1)
			-- upvalues: (copy) self, (ref) v_u1
			self(v_u1, arg1)
			v_u1 = arg1
		end)
	end
}