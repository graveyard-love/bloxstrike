-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("Workspace")
local v_grenadeparticles = v_replicatedstorage:WaitForChild("Assets"):WaitForChild("GrenadeParticles")
local v_u_innerfire = v_grenadeparticles:WaitForChild("InnerFire")
local v_u_outerfire = v_grenadeparticles:WaitForChild("OuterFire")
local v_u1 = {}
local function v_u2(arg1, arg2)
	if math.abs(arg2.Unit.Y) > 0.99 then
		return CFrame.new(arg1)
	end
	local v1
	if math.abs(UNNAMED_1728997352872.X) >= math.abs(UNNAMED_1728997352872.Z) then
		v1 = Vector3.new(UNNAMED_1728997352872.X, UNNAMED_1728997352872.Y, 0).Unit
	else
		v1 = Vector3.new(0, UNNAMED_1728997352872.Y, UNNAMED_1728997352872.Z).Unit
	end
	local v_new = Vector3.new(v1.X, 0, v1.Z)
	if v_new.Magnitude < 0.01 then
		return CFrame.new(arg1)
	end
	local v_unit = v_new.Unit
	local v_new = Vector3.new(v_unit.Z, 0, -v_unit.X)
	return CFrame.fromMatrix(arg1, v_new, v1, -v_new:Cross(v1).Unit)
end
local function v_u3(arg1, arg2, arg3, arg4, arg5, arg6)
	-- upvalues: (copy) v_u_innerfire, (copy) v_u_outerfire, (copy) v_u2
	local v_clone = (arg5 and v_u_innerfire or v_u_outerfire):Clone()
	v_clone.Name = arg5 and "InnerFireVoxel" or "OuterFireVoxel"
	v_clone.Size = Vector3.new(arg2, 0.2, arg3)
	v_clone.CFrame = v_u2(arg1, arg4)
	v_clone.Anchored = true
	v_clone.CanCollide = false
	v_clone.CanQuery = false
	v_clone.CanTouch = false
	v_clone.CastShadow = false
	v_clone.Parent = arg6
	for _, v1 in ipairs(v_clone:GetDescendants()) do
		if v1:IsA("ParticleEmitter") then
			v1.Enabled = true
		end
	end
	return v_clone
end
local v_u4 = {
	["Create"] = function(self)
		-- upvalues: (copy) v_u1, (copy) v_u3, (copy) v_u4
		local v_folder = Instance.new("Folder")
		v_folder.Name = "VoxelFire_" .. self.FireId
		v_folder.Parent = workspace:WaitForChild("Debris")
		v_u1[self.FireId] = v_folder
		local v1 = Vector3.new(0, 0, 0)
		for _, v2 in ipairs(self.Voxels) do
			v1 = v1 + v2.Position
		end
		if #self.Voxels > 0 then
			v1 = v1 / #self.Voxels
		end
		for _, v3 in ipairs(self.Voxels) do
			v_u3(v3.Position, v3.SizeX, v3.SizeZ, v3.Normal, (Vector3.new(v3.Position.X, 0, v3.Position.Z) - Vector3.new(v1.X, 0, v1.Z)).Magnitude <= 4, v_folder)
		end
		task.delay(self.Duration, function()
			-- upvalues: (ref) v_u1, (copy) self, (ref) v_u4
			if v_u1[self.FireId] then
				v_u4.Destroy(self.FireId)
			end
		end)
	end,
	["Destroy"] = function(arg1)
		-- upvalues: (copy) v_u1
		local v_u1 = v_u1[arg1]
		if v_u1 then
			for _, v2 in ipairs(v_u1:GetChildren()) do
				if v2:IsA("BasePart") then
					for _, v3 in ipairs(v2:GetDescendants()) do
						if v3:IsA("ParticleEmitter") then
							v3.Enabled = false
						end
					end
				end
			end
			task.delay(2, function()
				-- upvalues: (copy) v_u1
				if v_u1 and v_u1.Parent then
					v_u1:Destroy()
				end
			end)
			v_u1[arg1] = nil
		end
	end,
	["Update"] = function(self)
		-- upvalues: (copy) v_u1, (copy) v_u3
		local v_u1 = v_u1[self.FireId]
		if v_u1 then
			for _, v2 in ipairs(v_u1:GetChildren()) do
				if v2:IsA("BasePart") then
					for _, v3 in ipairs(v2:GetDescendants()) do
						if v3:IsA("ParticleEmitter") then
							v3.Enabled = false
						end
					end
				end
			end
			task.delay(0.3, function()
				-- upvalues: (copy) v_u1, (copy) self, (ref) v_u3
				if v_u1 and v_u1.Parent then
					for _, v1 in ipairs(v_u1:GetChildren()) do
						if v1:IsA("BasePart") then
							v1:Destroy()
						end
					end
					if #self.Voxels ~= 0 then
						local v2 = Vector3.new(0, 0, 0)
						for _, v3 in ipairs(self.Voxels) do
							v2 = v2 + v3.Position
						end
						local v4 = v2 / #self.Voxels
						for _, v5 in ipairs(self.Voxels) do
							v_u3(v5.Position, v5.SizeX, v5.SizeZ, v5.Normal, (Vector3.new(v5.Position.X, 0, v5.Position.Z) - Vector3.new(v4.X, 0, v4.Z)).Magnitude <= 4, v_u1)
						end
					end
				else
					return
				end
			end)
		end
	end,
	["DestroyAll"] = function()
		-- upvalues: (copy) v_u1
		for v1, v2 in pairs(v_u1) do
			if v2 and v2.Parent then
				v2:Destroy()
			end
			v_u1[v1] = nil
		end
	end
}
return v_u4