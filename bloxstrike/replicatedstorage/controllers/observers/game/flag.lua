-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v1 = require(v_replicatedstorage.Packages.Observers)
local v_u_animation = Instance.new("Animation", nil)
v_u_animation.AnimationId = "rbxassetid://103823379066850"
v_u_animation.Name = "FLAG_IDLE"
return v1.observeTag("Flag", function(arg1)
	-- upvalues: (copy) v_u_animation
	arg1:WaitForChild("csFlag"):WaitForChild("AnimationController"):WaitForChild("Animator")
	if not arg1:IsDescendantOf(workspace) then
		return function() end
	end
	local v_u_loadanimation = arg1.csFlag.AnimationController.Animator:LoadAnimation(v_u_animation)
	v_u_loadanimation:Play()
	return function()
		-- upvalues: (copy) v_u_loadanimation
		v_u_loadanimation:Destroy()
	end
end)