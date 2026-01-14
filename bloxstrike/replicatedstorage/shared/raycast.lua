-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_workspace = game:GetService("Workspace")
game:GetService("Debris")
local v_u1 = require(v_replicatedstorage:WaitForChild("Packages"):WaitForChild("Sift"))
local v_u_freeze = table.freeze({
	["Sandy Brick"] = 0.25,
	["IndoorWall"] = 0.25
})
local v_u_freeze = table.freeze({
	[Enum.Material.Asphalt] = 0.25,
	[Enum.Material.Basalt] = 0.25,
	[Enum.Material.Brick] = 0.25,
	[Enum.Material.Cobblestone] = 0.25,
	[Enum.Material.Concrete] = 0.25,
	[Enum.Material.CrackedLava] = 0.25,
	[Enum.Material.DiamondPlate] = 0.25,
	[Enum.Material.Foil] = 0.25,
	[Enum.Material.Glacier] = 0.25,
	[Enum.Material.Granite] = 0.25,
	[Enum.Material.Grass] = 0.25,
	[Enum.Material.Ground] = 0.25,
	[Enum.Material.Ice] = 0.25,
	[Enum.Material.LeafyGrass] = 0.25,
	[Enum.Material.Limestone] = 0.25,
	[Enum.Material.Marble] = 0.25,
	[Enum.Material.Metal] = 0.25,
	[Enum.Material.Mud] = 0.25,
	[Enum.Material.Pavement] = 0.25,
	[Enum.Material.Rock] = 0.25,
	[Enum.Material.Salt] = 0.25,
	[Enum.Material.Sand] = 0.25,
	[Enum.Material.Sandstone] = 0.25,
	[Enum.Material.Slate] = 0.25,
	[Enum.Material.Snow] = 0.25,
	[Enum.Material.ForceField] = 0.25,
	[Enum.Material.Neon] = 0.25,
	[Enum.Material.CorrodedMetal] = 0.25,
	[Enum.Material.Pebble] = 0.25,
	[Enum.Material.CeramicTiles] = 0.25,
	[Enum.Material.Plaster] = 0.25,
	[Enum.Material.Plastic] = 7,
	[Enum.Material.SmoothPlastic] = 7,
	[Enum.Material.Wood] = 7,
	[Enum.Material.WoodPlanks] = 7,
	[Enum.Material.Cardboard] = 7,
	[Enum.Material.Glass] = 100,
	[Enum.Material.Fabric] = 100
})
local v_u_folder = Instance.new("Folder")
v_u_folder.Parent = workspace:FindFirstChild("Debris") or workspace
v_u_folder.Name = "RaycastVisualizers"
local function v_u2(arg1)
	local v_model = arg1:FindFirstAncestorWhichIsA("Model")
	if v_model then
		local v1 = not v_model:FindFirstChildOfClass("Humanoid") and v_model.Parent
		if v1 then
			v1 = v_model.Parent:FindFirstChildOfClass("Humanoid")
		end
		if v1 then
			return true, v1
		end
	end
	return false, nil
end
local function v_u3(arg1, arg2)
	for _, v1 in pairs(arg2) do
		if arg1 == v1 or arg1:IsDescendantOf(v1) then
			return true
		end
	end
	return false
end
local function v_u4(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
	-- upvalues: (copy) v_u_workspace, (copy) v_u_freeze, (copy) v_u_freeze
	local v_new = RaycastParams.new()
	v_new.FilterType = Enum.RaycastFilterType.Include
	v_new.CollisionGroup = "Bullet"
	v_new.FilterDescendantsInstances = { arg3 }
	local v1 = arg1 + arg2 * 1000
	local v_raycast = v_u_workspace:Raycast(v1, arg1 - v1, v_new)
	if not v_raycast then
		return 0, Vector3.new(0, 0, 0), arg7, false
	end
	local v_magnitude = (arg1 - v_raycast.Position).Magnitude
	local v_position = v_raycast.Position
	local v2 = arg7 + v_magnitude
	local v3 = false
	local v_materialvariant = v_raycast.Instance.MaterialVariant
	local v4
	if v_materialvariant == "" then
		v4 = false
	else
		v4 = v_u_freeze[v_materialvariant] ~= nil
	end
	if v4 then
		arg6[v_materialvariant] = (arg6[v_materialvariant] or 0) + v_magnitude
		if arg6[v_materialvariant] > (v_u_freeze[v_materialvariant] or 20) + arg8 then
			return v_magnitude, v_position, v2, true
		end
		table.insert(arg4, {
			["instance"] = v_raycast.Instance,
			["position"] = v_raycast.Position,
			["normal"] = v_raycast.Normal,
			["material"] = v_raycast.Material
		})
		return v_magnitude, v_position, v2, v3
	end
	local v_material = v_raycast.Material
	arg5[v_material] = (arg5[v_material] or 0) + v_magnitude
	if arg5[v_material] > (v_u_freeze[v_material] or 20) + arg8 then
		return v_magnitude, v_position, v2, true
	end
	table.insert(arg4, {
		["instance"] = v_raycast.Instance,
		["position"] = v_raycast.Position,
		["normal"] = v_raycast.Normal,
		["material"] = v_raycast.Material
	})
	return v_magnitude, v_position, v2, v3
end
local function v_u5(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_workspace, (copy) v_u4
	local v_unit = arg2.Unit
	local v1 = {}
	local v2 = {}
	local v3 = 0
	local v4 = {}
	for _ = 1, 100 do
		local v_raycast = v_u_workspace:Raycast(arg1, v_unit * 1000, arg4)
		if not v_raycast then
			break
		end
		arg4:AddToFilter(v_raycast.Instance)
		table.insert(v4, {
			["instance"] = v_raycast.Instance,
			["position"] = v_raycast.Position,
			["normal"] = v_raycast.Normal,
			["material"] = v_raycast.Material
		})
		local v5, v6
		v5, arg1, v3, v6 = v_u4(v_raycast.Position, v_unit, v_raycast.Instance, v4, v1, v2, v3, arg3)
		if v6 then
			break
		end
	end
	return v4
end
return {
	["isPartOfHumanoid"] = function(arg1)
		-- upvalues: (copy) v_u2
		return v_u2(arg1)
	end,
	["cast"] = function(arg1, arg2, arg3, arg4, arg5)
		-- upvalues: (copy) v_u1, (copy) v_u_workspace, (copy) v_u3, (copy) v_u_folder
		local v1 = not arg4 and {} or v_u1.Array.copy(arg4)
		if not arg3 then
			arg3 = RaycastParams.new()
			arg3.FilterType = Enum.RaycastFilterType.Exclude
			arg3.IgnoreWater = false
			arg3.CollisionGroup = "Bullet"
		end
		arg3.FilterDescendantsInstances = v1
		while true do
			local v_raycast = v_u_workspace:Raycast(arg1, arg2, arg3)
			if not v_raycast then
				break
			end
			local v2
			if arg5 == nil then
				if arg3.FilterType == Enum.RaycastFilterType.Include then
					v2 = not v_u3(v_raycast.Instance, v1)
				else
					local v_instance = v_raycast.Instance
					local v_isdescendantof = v_instance:IsDescendantOf(v_u_folder)
					local v_model = v_instance:FindFirstAncestorWhichIsA("Model")
					if v_model then
						local v3 = not v_model:FindFirstChildOfClass("Humanoid") and v_model.Parent
						if v3 then
							v3 = v_model.Parent:FindFirstChildOfClass("Humanoid")
						end
					end
					v2 = v_isdescendantof or (v_instance:FindFirstAncestorWhichIsA("Accessory") ~= nil or v_instance.Name == "CollisionCapsule")
				end
			else
				v2 = arg5(v_raycast.Instance)
			end
			if not v2 then
				return {
					["instance"] = v_raycast.Instance,
					["position"] = v_raycast.Position,
					["normal"] = v_raycast.Normal,
					["material"] = v_raycast.Material
				}
			end
			table.insert(v1, v_raycast.Instance)
			arg3.FilterDescendantsInstances = v1
		end
		return {
			["position"] = arg1 + arg2
		}
	end,
	["castThrough"] = function(arg1, arg2, arg3, arg4)
		-- upvalues: (copy) v_u5
		local v_new = RaycastParams.new()
		v_new.CollisionGroup = "Bullet"
		if arg4 then
			v_new.FilterDescendantsInstances = arg4
		end
		return v_u5(arg1, arg2, arg3, v_new)
	end
}