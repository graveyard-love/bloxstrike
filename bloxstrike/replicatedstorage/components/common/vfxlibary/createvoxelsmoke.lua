-- Decompiled with Bunni.lol Decompiler

game:GetService("Lighting")
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_u_workspace = game:GetService("Workspace")
local v_u_smoke = v_replicatedstorage:WaitForChild("Assets"):WaitForChild("GrenadeParticles"):WaitForChild("Smoke")
local _ = {
	["Color"] = Color3.new(1, 1, 1),
	["Decay"] = Color3.new(1, 1, 1),
	["Density"] = 1,
	["Glare"] = 1,
	["Haze"] = 2.5
}
local v_u1 = {}
local v_u2 = {}
local v_u3 = nil
local function v_u4(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_smoke, (copy) v_u2
	local v_clone = v_u_smoke:Clone()
	v_clone.Name = "SmokeVoxel"
	v_clone.Size = Vector3.new(arg2, arg2, arg2)
	v_clone.Position = arg1
	v_clone.Anchored = true
	v_clone.CanCollide = false
	v_clone.CanQuery = false
	v_clone.CanTouch = false
	v_clone.CastShadow = false
	v_clone.Parent = arg3
	local v1 = arg2 / 4
	local v2 = {}
	for _, v3 in ipairs(v_clone:GetDescendants()) do
		if v3:IsA("ParticleEmitter") then
			local v4 = {}
			for _, v5 in ipairs(v3.Size.Keypoints) do
				table.insert(v4, NumberSequenceKeypoint.new(v5.Time, v5.Value * v1, v5.Envelope * v1))
			end
			v3.Size = NumberSequence.new(v4)
			v3.Enabled = false
			table.insert(v2, v3)
		end
	end
	for _, v6 in ipairs(v_clone:GetChildren()) do
		if v6:IsA("BillboardGui") then
			v6:Destroy()
		end
	end
	v_u2[v_clone] = {
		["voxel"] = v_clone,
		["emitters"] = v2,
		["emitConnection"] = nil,
		["isActive"] = false,
		["lastEmitTime"] = 0,
		["scaleFactor"] = v1,
		["lifetimeExtended"] = false,
		["activatedTime"] = 0,
		["emissionStopped"] = false,
		["totalParticlesEmitted"] = 0
	}
	return v_clone
end
local function v_u5(arg1, arg2)
	-- upvalues: (ref) v_u3, (copy) v_u_run, (copy) v_u2
	local v_getchildren = arg1:GetChildren()
	if #v_getchildren == 0 then
		return
	else
		local v1 = Vector3.new(0, 0, 0)
		local v2 = {}
		for _, v3 in ipairs(v_getchildren) do
			if v3:IsA("BasePart") then
				v1 = v1 + v3.Position
				table.insert(v2, v3)
			end
		end
		if #v2 ~= 0 then
			local v4 = v1 / #v2
			local v5 = 0
			for _, v6 in ipairs(v2) do
				local v_magnitude = (v6.Position - v4).Magnitude
				if v5 < v_magnitude then
					v5 = v_magnitude
				end
			end
			local v7 = v5 == 0 and 1 or v5
			if not v_u3 then
				v_u3 = v_u_run.Heartbeat:Connect(function()
					-- upvalues: (ref) v_u2
					local v1 = tick()
					for _, v2 in pairs(v_u2) do
						if v2.voxel and (v2.voxel.Parent and (v2.isActive and not v2.emissionStopped)) then
							if not v2.lifetimeExtended then
								v2.lifetimeExtended = true
								v2.activatedTime = v1
								for _, v3 in ipairs(v2.emitters) do
									if v3 and v3.Parent then
										v3.Lifetime = NumberRange.new((1 / 0))
									end
								end
							end
							local v4 = v1 - v2.activatedTime
							if v4 >= 0.8 then
								v2.emissionStopped = true
							elseif 0.1 + 0.30000000000000004 * (v4 / 0.8) <= v1 - v2.lastEmitTime then
								v2.lastEmitTime = v1
								v2.totalParticlesEmitted = v2.totalParticlesEmitted + #v2.emitters * 1
								for _, v5 in ipairs(v2.emitters) do
									if v5 and v5.Parent then
										v5:Emit(1)
									end
								end
							end
						end
					end
				end)
			end
			for _, v_u8 in ipairs(v2) do
				task.delay((v_u8.Position - v4).Magnitude / v7 * arg2, function()
					-- upvalues: (copy) v_u8, (ref) v_u2
					if v_u8.Parent then
						local v1 = v_u2[v_u8]
						if v1 then
							v1.isActive = true
						end
					end
				end)
			end
		end
	end
end
local function v_u6(self)
	-- upvalues: (copy) v_u2, (ref) v_u3
	local v_u_getchildren = self:GetChildren()
	local v1 = 0
	local v2 = 0
	for _, v3 in ipairs(v_u_getchildren) do
		if v3:IsA("BasePart") then
			local v4 = v_u2[v3]
			if v4 then
				v1 = v1 + v4.totalParticlesEmitted
				v2 = v2 + 1
				v4.isActive = false
				for _, v5 in ipairs(v4.emitters) do
					if v5 and v5.Parent then
						v5.Enabled = false
					end
				end
			end
		end
	end
	print("[VoxelSmoke] Smoke fading out. Total particles emitted:", v1, "across", v2, "voxels")
	task.delay(6, function()
		-- upvalues: (copy) v_u_getchildren, (ref) v_u2, (ref) v_u3, (copy) self
		for _, v1 in ipairs(v_u_getchildren) do
			if v1:IsA("BasePart") then
				v_u2[v1] = nil
				v1:Destroy()
			end
		end
		local v2 = false
		for _, _ in pairs(v_u2) do
			v2 = true
			break
		end
		if not v2 and v_u3 then
			v_u3:Disconnect()
			v_u3 = nil
		end
		if self and self.Parent then
			self:Destroy()
		end
	end)
end
return {
	["Create"] = function(self)
		-- upvalues: (copy) v_u_workspace, (copy) v_u1, (copy) v_u4, (copy) v_u5, (copy) v_u6
		local v_u_folder = Instance.new("Folder")
		v_u_folder.Name = "VoxelSmoke_" .. self.SmokeId
		v_u_folder.Parent = v_u_workspace:WaitForChild("Debris")
		v_u1[self.SmokeId] = v_u_folder
		for _, v1 in ipairs(self.Voxels) do
			v_u4(v1.Position, v1.Size, v_u_folder)
		end
		v_u5(v_u_folder, self.DeployTime)
		task.delay(self.Duration, function()
			-- upvalues: (ref) v_u1, (copy) self, (ref) v_u6, (copy) v_u_folder
			if v_u1[self.SmokeId] then
				v_u6(v_u_folder)
				v_u1[self.SmokeId] = nil
			end
		end)
	end,
	["Destroy"] = function(arg1)
		-- upvalues: (copy) v_u1, (copy) v_u6
		local v1 = v_u1[arg1]
		if v1 then
			v_u6(v1)
			v_u1[arg1] = nil
		end
	end,
	["DestroyAll"] = function()
		-- upvalues: (copy) v_u1, (copy) v_u2, (ref) v_u3
		for v1, v2 in pairs(v_u1) do
			for _, v3 in ipairs(v2:GetChildren()) do
				if v3:IsA("BasePart") then
					v_u2[v3] = nil
					v3:Destroy()
				end
			end
			v2:Destroy()
			v_u1[v1] = nil
		end
		local v4 = false
		for _, _ in pairs(v_u2) do
			v4 = true
			break
		end
		if not v4 and v_u3 then
			v_u3:Disconnect()
			v_u3 = nil
		end
	end,
	["Disrupt"] = function(arg1, arg2, arg3)
		-- upvalues: (copy) v_u1, (copy) v_u2, (copy) v_u_smoke
		print("[VoxelSmoke] Disrupt called at", arg1, "radius:", arg2, "duration:", arg3)
		local v1 = 0
		for _, v2 in pairs(v_u1) do
			for _, v_u3 in ipairs(v2:GetChildren()) do
				if v_u3:IsA("BasePart") and arg2 >= (v_u3.Position - arg1).Magnitude then
					local v_u4 = v_u2[v_u3]
					if v_u4 and v_u4.isActive then
						v_u4.isActive = false
						local v_u_scalefactor = v_u4.scaleFactor
						for _, v5 in ipairs(v_u4.emitters) do
							if v5 and v5.Parent then
								v5:Destroy()
							end
						end
						v_u4.emitters = {}
						v1 = v1 + 1
						task.delay(arg3, function()
							-- upvalues: (copy) v_u4, (ref) v_u2, (copy) v_u3, (ref) v_u_smoke, (copy) v_u_scalefactor
							if v_u4 and v_u2[v_u3] then
								if v_u3 and v_u3.Parent then
									local v1 = {}
									for _, v2 in ipairs(v_u_smoke:GetDescendants()) do
										if v2:IsA("ParticleEmitter") then
											local v_clone = v2:Clone()
											local v3 = {}
											for _, v4 in ipairs(v_clone.Size.Keypoints) do
												table.insert(v3, NumberSequenceKeypoint.new(v4.Time, v4.Value * v_u_scalefactor, v4.Envelope * v_u_scalefactor))
											end
											v_clone.Size = NumberSequence.new(v3)
											v_clone.Enabled = false
											v_clone.Parent = v_u3
											table.insert(v1, v_clone)
										end
									end
									v_u4.emitters = v1
									v_u4.lastEmitTime = 0
									v_u4.isActive = true
									v_u4.lifetimeExtended = false
									v_u4.activatedTime = 0
									v_u4.emissionStopped = false
									v_u4.totalParticlesEmitted = 0
									print("[VoxelSmoke] Voxel re-enabled after disruption")
								end
							else
								return
							end
						end)
					end
				end
			end
		end
		print("[VoxelSmoke] Disrupted", v1, "voxels")
	end,
	["GetActiveVoxelCount"] = function()
		-- upvalues: (copy) v_u2
		local v1 = 0
		for _, _ in pairs(v_u2) do
			v1 = v1 + 1
		end
		return v1
	end
}