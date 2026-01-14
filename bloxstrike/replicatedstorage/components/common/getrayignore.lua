-- Decompiled with Bunni.lol Decompiler

local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u_current_camera = workspace.CurrentCamera
local v_u_debris = workspace:WaitForChild("Debris")
return function()
	-- upvalues: (copy) v_u_debris, (copy) v_u_current_camera, (copy) v_u_localplayer
	local v1 = {}
	table.insert(v1, v_u_debris)
	table.insert(v1, v_u_current_camera)
	local v_map = workspace:FindFirstChild("Map")
	if v_map then
		local v_cameras = v_map:FindFirstChild("Cameras")
		local v_barriers = v_map:FindFirstChild("Barriers")
		local v_ambience = v_map:FindFirstChild("Ambience")
		if v_cameras then
			table.insert(v1, v_cameras)
		end
		if v_barriers then
			table.insert(v1, v_barriers)
		end
		if v_ambience then
			table.insert(v1, v_ambience)
		end
		local v_zones = v_map:FindFirstChild("Zones")
		if v_zones then
			local v_spawns = v_zones:FindFirstChild("Spawns")
			local v_sites = v_zones:FindFirstChild("Sites")
			if v_spawns then
				table.insert(v1, v_spawns)
			end
			if v_sites then
				table.insert(v1, v_sites)
			end
		end
	end
	if v_u_localplayer and (v_u_localplayer.Character and v_u_localplayer.Character:IsDescendantOf(workspace)) then
		table.insert(v1, v_u_localplayer.Character)
	end
	return v1
end