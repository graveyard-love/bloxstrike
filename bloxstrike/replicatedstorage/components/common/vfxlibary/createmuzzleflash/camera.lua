-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_debris = game:GetService("Debris")
require(v_replicatedstorage.Database.Custom.Types)
local v_u1 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u_muzzleflashes = v_replicatedstorage:WaitForChild("Assets"):WaitForChild("MuzzleFlashes")
local v_u_debris = workspace:WaitForChild("Debris")
return function(arg1, arg2, arg3)
	-- upvalues: (copy) v_u1, (copy) v_u_muzzleflashes, (copy) v_u_debris, (copy) v_u_debris
	local v1 = v_u1(arg2)
	if v1 then
		local v2 = v_u_muzzleflashes.Camera:FindFirstChild(arg3 or v1.MuzzleType)
		local v3
		if v2 then
			v3 = v2:Clone()
			v3.CollisionGroup = "Debris"
			v3.CanCollide = false
			v3.CanQuery = false
			v3.CanTouch = false
			v3.Anchored = false
		else
			v3 = nil
		end
		if v3 then
			v3.Parent = v_u_debris
			local v_motor6d = Instance.new("Motor6D")
			v_motor6d.Part0 = arg1
			v_motor6d.Part1 = v3
			v_motor6d.Parent = v3
			for _, v_u4 in ipairs(v3:GetDescendants()) do
				if v_u4:IsA("ParticleEmitter") then
					task.delay(v_u4:GetAttribute("EmitDelay") or 0, function()
						-- upvalues: (copy) v_u4
						v_u4:Emit(v_u4:GetAttribute("EmitCount") or 1)
					end)
				end
			end
			v_u_debris:AddItem(v3, 5)
			return arg1.Position
		end
	end
	return nil
end