-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v1 = require(v_replicatedstorage.Packages.Observers)
local v_u2 = require(script.Bomb)
return v1.observeTag("Bomb", function(arg1)
	-- upvalues: (copy) v_u2
	local v_u_new = v_u2.new(arg1)
	return function()
		-- upvalues: (copy) v_u_new
		if v_u_new then
			v_u_new:destroy()
		end
	end
end)