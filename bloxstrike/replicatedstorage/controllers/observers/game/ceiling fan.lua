-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v1 = require(v_replicatedstorage.Packages.Observers)
local v_u_animation = Instance.new("Animation")
v_u_animation.AnimationId = "rbxassetid://82806563298602"
return v1.observeTag("Ceiling Fan", function(arg1)
	-- upvalues: (copy) v_u_animation
	arg1:WaitForChild("AnimationController"):WaitForChild("Animator")
	if arg1:IsDescendantOf(workspace) then
		local v_u_loadanimation = arg1.AnimationController.Animator:LoadAnimation(v_u_animation)
		v_u_loadanimation:Play()
		return function()
			-- upvalues: (copy) v_u_loadanimation
			v_u_loadanimation:Destroy()
		end
	end
end)