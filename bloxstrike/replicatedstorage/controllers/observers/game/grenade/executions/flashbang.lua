-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_u_replicatedstorage.Shared.Janitor)
local v_u_debris = workspace:WaitForChild("Debris")
return function(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_debris
	for _, v1 in ipairs(arg3:GetDescendants()) do
		if v1:IsA("BasePart") then
			v1.CollisionGroup = "Debris"
			v1.Transparency = 1
			v1.CanCollide = false
			v1.CanTouch = false
			v1.CanQuery = false
		end
	end
	local v_flashbang = v_u_replicatedstorage.Assets.GrenadeParticles:FindFirstChild("Flashbang")
	if v_flashbang then
		local v_add = arg1:Add(v_flashbang:Clone())
		v_add.CFrame = CFrame.new(arg2)
		v_add.Parent = v_u_debris
		v_add.Anchored = true
		for _, v_u2 in ipairs(v_add:GetDescendants()) do
			if v_u2:IsA("ParticleEmitter") then
				task.delay(v_u2:GetAttribute("EmitDelay") or 0, function()
					-- upvalues: (copy) v_u2
					v_u2:Emit(v_u2:GetAttribute("EmitCount") or 1)
				end)
			end
		end
	end
end