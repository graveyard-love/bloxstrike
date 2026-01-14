-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_assets = v_replicatedstorage:WaitForChild("Assets")
local v_u1 = require(v_replicatedstorage.Shared.Janitor)
local v_u_other = v_assets:WaitForChild("Other")
local v_u_debris = workspace:WaitForChild("Debris")
local v_u2 = {
	["Bullet"] = require(script.Components.Bullet),
	["Melee"] = require(script.Components.Melee)
}
local v_u3 = {}
local function v_u4(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_other, (copy) v_u2, (copy) v_u_debris
	local v1 = v_u_other:FindFirstChild(arg1)
	local v_format = ("%* is not apart of Assets.Miscellaneous"):format(arg1)
	assert(v1, v_format)
	local v2 = v_u2[arg2]
	local v_format = ("%* is not apart of library \"MarkerInfo\""):format(arg2)
	assert(v_u2, v_format)
	local v_clone = v1:Clone()
	local v_sizerange = v2.Properties.SizeRange()
	local v_sizerange = v2.Properties.SizeRange()
	v_clone.Size = Vector3.new(v_sizerange, v_sizerange, 0.001)
	v_clone.CollisionGroup = "Debris"
	v_clone.CanCollide = false
	v_clone.CanQuery = false
	v_clone.CanTouch = false
	v_clone.Anchored = true
	v_clone.CFrame = CFrame.new(arg3, arg3 + arg4) * CFrame.Angles(0, 0, v2.Properties.Rotation() * 3.141592653589793 / 180)
	v_clone.Parent = v_u_debris
	v_clone.Anchored = false
	for _, v3 in ipairs(v_clone:GetDescendants()) do
		local v_random = math.random(1, #v2.Images)
		if v3:IsA("Decal") then
			v3.Transparency = v2.Properties.Transparency()
			v3.Texture = v2.Images[v_random]
			v3.Color3 = v2.Properties.Color3
		end
	end
	return v_clone
end
return function(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u3, (copy) v_u1, (copy) v_u4
	local v1 = #v_u3 >= 20 and table.remove(v_u3, 1)
	if v1 then
		v1:Destroy()
	end
	local v_u_new = v_u1.new()
	table.insert(v_u3, v_u_new)
	local v_hitmarker = v_u4("HitMarker", arg2, arg3, arg4)
	v_u_new:Add(v_hitmarker)
	local v_weldconstraint = Instance.new("WeldConstraint", v_hitmarker)
	v_weldconstraint.Part0 = v_hitmarker
	v_weldconstraint.Part1 = arg1
	if arg1 and arg1:IsDescendantOf(workspace) then
		v_u_new:Add(arg1.Destroying:Once(function()
			-- upvalues: (copy) v_u_new
			v_u_new:Cleanup()
		end))
		v_u_new:Add(arg1:GetPropertyChangedSignal("Transparency"):Connect(function()
			-- upvalues: (copy) arg1, (copy) v_u_new
			if arg1.Transparency == 1 then
				v_u_new:Cleanup()
			end
		end))
	end
	v_u_new:Add(task.delay(15, function()
		-- upvalues: (copy) v_u_new, (ref) v_u3
		v_u_new:Destroy()
		for v1, v2 in v_u3 do
			if v2 == v_u_new then
				table.remove(v_u3, v1)
				return
			end
		end
	end))
end