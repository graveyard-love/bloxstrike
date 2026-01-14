-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_debris = game:GetService("Debris")
local v_u_debris = workspace:WaitForChild("Debris")
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Database.Components.GameState)
local v_u3 = require(v_u_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u4 = require(script.Common.CustomPhysicalProperties)
local v_u5 = require(script.Common.MaxFrictionTorque)
local v_u6 = require(script.Common.PartMultipliers)
local v_u7 = require(script.Common.Constraints)
local v_u8 = {}
local v_u9 = {}
function v_u1.EnforceLimit()
	-- upvalues: (copy) v_u8
	while #v_u8 >= 8 do
		local v_remove = table.remove(v_u8, 1)
		if v_remove then
			v_remove:Destroy()
		end
	end
end
function v_u1.Track(self)
	-- upvalues: (copy) v_u8, (copy) v_u9
	table.insert(v_u8, self)
	v_u9[self.Name] = self
	self.Destroying:Once(function()
		-- upvalues: (ref) v_u9, (copy) self, (ref) v_u8
		v_u9[self.Name] = nil
		local v_find = table.find(v_u8, self)
		if v_find then
			table.remove(v_u8, v_find)
		end
	end)
end
function v_u1.Impulse(arg1, arg2)
	-- upvalues: (copy) v_u3, (copy) v_u6
	local v1 = arg1:FindFirstChild(arg2.Part)
	if v1 then
		local v2 = v_u3(arg2.Weapon)
		if v2 then
			local v3 = v2.RagdollMultiplier * 1.2
			local v4 = v_u6[arg2.Part]
			if v4 then
				v3 = v3 * (math.random(v4.Minimum, v4.Maximum) / 100)
			end
			local v_random = math.random(-20, 20)
			local v_random = math.random(10, 25)
			v1.AssemblyLinearVelocity = arg2.Direction.Unit * v3 * (1 + arg2.DirectionMultiplier) + Vector3.new(v_random, v_random, math.random(-20, 20))
			for _, v5 in ipairs(arg1:GetDescendants()) do
				if v5:IsA("BasePart") then
					local v_random = math.random(-10, 10)
					local v_random = math.random(-10, 10)
					v5.AssemblyAngularVelocity = Vector3.new(v_random, v_random, math.random(-10, 10))
				end
			end
		end
	else
		return
	end
end
function v_u1.CreateJoint(arg1)
	-- upvalues: (copy) v_u7, (copy) v_u5
	local v_part0 = arg1.Part0
	local v_part1 = arg1.Part1
	if v_part0 and v_part1 then
		if not (v_part0:HasTag("CharacterAccessory") or v_part1:HasTag("CharacterAccessory")) then
			local v_attachment = Instance.new("Attachment")
			v_attachment.CFrame = arg1.C0
			v_attachment.Parent = v_part0
			local v_attachment = Instance.new("Attachment")
			v_attachment.CFrame = arg1.C1
			v_attachment.Parent = v_part1
			local v_ballsocketconstraint = Instance.new("BallSocketConstraint")
			v_ballsocketconstraint.Attachment0 = v_attachment
			v_ballsocketconstraint.Attachment1 = v_attachment
			v_ballsocketconstraint.Parent = v_part0
			local v1 = v_u7[v_part1.Name] or v_u7.Default
			v_ballsocketconstraint.MaxFrictionTorque = (v_u5[v_part1.Name] or 0) * 0.1
			v_ballsocketconstraint.TwistLimitsEnabled = v1.TwistLimitsEnabled
			v_ballsocketconstraint.TwistLowerAngle = v1.TwistLowerAngle
			v_ballsocketconstraint.TwistUpperAngle = v1.TwistUpperAngle
			v_ballsocketconstraint.LimitsEnabled = v1.LimitsEnabled
			v_ballsocketconstraint.Restitution = v1.Restitution
			v_ballsocketconstraint.UpperAngle = v1.UpperAngle
			arg1:Destroy()
		end
	else
		return
	end
end
return function(self)
	-- upvalues: (copy) v_u9, (copy) v_u1, (copy) v_u_debris, (copy) v_u4, (copy) v_u_replicatedstorage, (copy) v_u2, (copy) v_u_debris
	debug.profilebegin("CreateRagdoll")
	local v_character = self.Character
	if v_character then
		debug.profilebegin("DestroySection")
		local v1 = v_u9[v_character.Name]
		if v1 then
			v1:Destroy()
		end
		debug.profileend()
		v_u1.EnforceLimit()
		v_character.Archivable = true
		debug.profilebegin("CloneSection")
		local v_u_clone = v_character:Clone()
		if v_u_clone then
			debug.profileend()
			v_u1.Track(v_u_clone)
			v_u_clone.Name = v_character.Name
			debug.profilebegin("CleanupSection")
			local v_weaponmodel = v_u_clone:FindFirstChild("WeaponModel")
			if v_weaponmodel then
				v_weaponmodel:Destroy()
			end
			local v_weaponattachments = v_u_clone:FindFirstChild("WeaponAttachments")
			if v_weaponattachments then
				v_weaponattachments:Destroy()
			end
			local v2 = v_u_debris:FindFirstChild(v_character.Name .. "_Weapon")
			if v2 then
				v2:Destroy()
			end
			local v3 = v_u_debris:FindFirstChild(v_character.Name .. "_WeaponAttachments")
			if v3 then
				v3:Destroy()
			end
			local v_charactermodel = v_u_clone:FindFirstChild("CharacterModel")
			if v_charactermodel then
				v_charactermodel:Destroy()
			end
			if v_character.PrimaryPart and v_u_clone.PrimaryPart then
				v_u_clone:PivotTo(v_character.PrimaryPart.CFrame)
			end
			v_u_clone.Parent = v_u_debris
			v_u_clone:AddTag("Ragdoll")
			if v_character.Parent then
				v_character:Destroy()
			end
			debug.profileend()
			debug.profilebegin("SetupSection")
			for _, v4 in ipairs(v_u_clone:GetDescendants()) do
				if v4:IsA("BasePart") then
					if v4.Name == "CollisionCapsule" or v4.Name == "HumanoidRootPart" then
						if v4.Name == "CollisionCapsule" then
							v4:Destroy()
						else
							v4.Transparency = 1
							v4.CanCollide = false
							v4.Massless = true
						end
					elseif v4.Name == "Hitbox" or v4.Name == "Insert" then
						v4.CanCollide = false
						v4.Transparency = 1
					else
						v4.CustomPhysicalProperties = v_u4[v4.Name] or v_u4.Default
						v4.CollisionGroup = "Debris"
						v4.CastShadow = false
						v4.CanCollide = true
						v4.Transparency = 0
						v4.Anchored = false
						v4.Massless = false
					end
				elseif v4:IsA("Motor6D") then
					v_u1.CreateJoint(v4)
				elseif v4:IsA("Humanoid") then
					v4:Destroy()
				elseif v4:IsA("Script") or v4:IsA("LocalScript") then
					v4:Destroy()
				elseif v4:IsA("BillboardGui") or (v4:IsA("Sound") or v4:IsA("ParticleEmitter")) then
					v4:Destroy()
				elseif v4:IsA("Decal") then
					v4.Transparency = 0
				end
			end
			task.defer(function()
				-- upvalues: (ref) v_u_replicatedstorage, (copy) v_u_clone, (ref) v_u1, (copy) self
				v_u_replicatedstorage.Assets.Other.Ragdoll.Humanoid:Clone().Parent = v_u_clone
				for _, v_u1 in ipairs(v_u_clone:GetChildren()) do
					if v_u1:IsA("Clothing") or v_u1:IsA("ShirtGraphic") then
						v_u1.Parent = nil
						task.defer(function()
							-- upvalues: (copy) v_u1, (ref) v_u_clone
							v_u1.Parent = v_u_clone
						end)
					end
				end
				v_u1.Impulse(v_u_clone, self)
			end)
			debug.profileend()
			debug.profileend()
			if v_u2.GetState() == "Warmup" and workspace:GetAttribute("Gamemode") == "Deathmatch" then
				v_u_debris:AddItem(v_u_clone, 10)
			else
				v_u_debris:AddItem(v_u_clone, 15)
			end
		else
			return
		end
	else
		return
	end
end