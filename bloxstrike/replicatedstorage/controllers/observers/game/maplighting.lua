-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_lighting = game:GetService("Lighting")
local v_u_maps = v_u_replicatedstorage.Database.Custom.GameStats.Maps
local v_u1 = nil
local v_u2 = nil
local v_u3 = nil
local function v_u4(arg1)
	-- upvalues: (copy) v_u_maps, (copy) v_u_lighting
	local v1 = v_u_maps:FindFirstChild(arg1)
	if v1 and v1:IsA("ModuleScript") then
		local v2 = require(v1)
		if v2.Lighting then
			local v_properties = v2.Lighting.Properties
			if v_properties then
				v_u_lighting.Ambient = v_properties.Ambient
				v_u_lighting.Brightness = v_properties.Brightness
				v_u_lighting.ColorShift_Bottom = v_properties.ColorShift_Bottom
				v_u_lighting.ColorShift_Top = v_properties.ColorShift_Top
				v_u_lighting.EnvironmentDiffuseScale = v_properties.EnvironmentDiffuseScale
				v_u_lighting.EnvironmentSpecularScale = v_properties.EnvironmentSpecularScale
				v_u_lighting.GlobalShadows = v_properties.GlobalShadows
				v_u_lighting.OutdoorAmbient = v_properties.OutdoorAmbient
				v_u_lighting.ShadowSoftness = v_properties.ShadowSoftness
				v_u_lighting.ClockTime = v_properties.ClockTime
				v_u_lighting.GeographicLatitude = v_properties.GeographicLatitude
				v_u_lighting.ExposureCompensation = v_properties.ExposureCompensation
			end
			for _, v3 in ipairs(v_u_lighting:GetChildren()) do
				if v3.Name ~= "Menu" then
					v3:Destroy()
				end
			end
			local v_assets = v2.Lighting.Assets
			if v_assets then
				for _, v4 in ipairs(v_assets:GetChildren()) do
					v4:Clone().Parent = v_u_lighting
				end
			end
		else
			warn((("[MapLighting]: Map \"%*\" has no lighting configuration"):format(arg1)))
		end
	else
		warn((("[MapLighting]: Map \"%*\" not found in database"):format(arg1)))
		return
	end
end
local function v_u5()
	-- upvalues: (ref) v_u1, (copy) v_u_replicatedstorage, (ref) v_u2, (ref) v_u3
	if not v_u1 then
		v_u1 = require(v_u_replicatedstorage.Controllers.MenuSceneController)
	end
	if not v_u2 then
		v_u2 = require(v_u_replicatedstorage.Controllers.CaseSceneController)
	end
	if not v_u3 then
		v_u3 = require(v_u_replicatedstorage.Controllers.InspectController)
	end
	local v1 = not (v_u1.IsActive() or v_u2.IsActive())
	if v1 then
		v1 = not v_u3.IsActive()
	end
	return v1
end
local function v_u6(self)
	-- upvalues: (copy) v_u5, (copy) v_u4
	if v_u5() then
		local v_mapname = self:GetAttribute("MapName")
		if not v_mapname or typeof(v_mapname) ~= "string" then
			v_mapname = nil
		end
		if v_mapname then
			v_u4(v_mapname)
		else
			local v_u1 = nil
			v_u1 = self:GetAttributeChangedSignal("MapName"):Connect(function()
				-- upvalues: (ref) v_u5, (ref) v_u1, (copy) self, (ref) v_u4
				if v_u5() then
					local v_mapname = self:GetAttribute("MapName")
					if not v_mapname or typeof(v_mapname) ~= "string" then
						v_mapname = nil
					end
					if v_mapname then
						v_u1:Disconnect()
						v_u4(v_mapname)
					end
				else
					v_u1:Disconnect()
				end
			end)
		end
	else
		return
	end
end
workspace.ChildAdded:Connect(function(self)
	-- upvalues: (copy) v_u6
	if self.Name == "Map" then
		task.defer(function()
			-- upvalues: (ref) v_u6, (copy) self
			v_u6(self)
		end)
	end
end)
local v_u_map = workspace:FindFirstChild("Map")
if v_u_map then
	task.defer(function()
		-- upvalues: (copy) v_u6, (copy) v_u_map
		v_u6(v_u_map)
	end)
end
return nil