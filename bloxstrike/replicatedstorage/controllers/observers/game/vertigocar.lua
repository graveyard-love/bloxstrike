-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
require(script:WaitForChild("Types"))
local v1 = require(v_replicatedstorage.Packages.Observers)
local v_u2 = require(v_replicatedstorage.Shared.Janitor)
local function v_u3()
	-- upvalues: (copy) v_u_tween
	-- failed to decompile
end
return v1.observeTag("VertigoCar", function(self)
	-- upvalues: (copy) v_u2, (copy) v_u3
	self.Anchored = true
	if not self:IsDescendantOf(workspace) then
		return function() end
	end
	local v_u_new = v_u2.new()
	v_u_new:Add(self)
	v_u_new:Add(task.spawn(function()
		-- upvalues: (ref) v_u3, (copy) v_u_new, (copy) self
		v_u3(v_u_new, self)
	end))
	return function()
		-- upvalues: (copy) v_u_new
		v_u_new:Destroy()
	end
end)