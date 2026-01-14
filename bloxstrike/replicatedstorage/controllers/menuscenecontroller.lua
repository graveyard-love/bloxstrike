-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_u_tween = game:GetService("TweenService")
local v_u_lighting = game:GetService("Lighting")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Packages.Observers)
local v3 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u4 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u5 = require(v_u_replicatedstorage.Classes.Sound)
local v_u6 = require(v_u_replicatedstorage.Database.Custom.Constants)
local v_u_localplayer = v_players.LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u_current_camera = workspace.CurrentCamera
local v_u7 = nil
local v_u_lighting = v_u_replicatedstorage.Assets.Lighting
local v_u_maps = v_u_replicatedstorage.Database.Custom.GameStats.Maps
local v_u_characters = v_u_replicatedstorage.Assets.Characters
local v_u8 = {
	["CT"] = {
		["Entrance"] = "rbxassetid://140448509508633",
		["Idle"] = "rbxassetid://137360078752983"
	},
	["T"] = {
		["Entrance"] = "rbxassetid://100747011940776",
		["Idle"] = "rbxassetid://99540873384647"
	}
}
local v_u9 = {
	["CT"] = {
		["Character"] = "IDF",
		["Weapon"] = "M4A1-S",
		["Glove"] = "CT Glove"
	},
	["T"] = {
		["Character"] = "Anarchist",
		["Weapon"] = "AK-47",
		["Glove"] = "T Glove"
	}
}
local v_u10 = {
	["Right Arm"] = "RightGlove",
	["Left Arm"] = "LeftGlove"
}
local v_u11 = {
	["Right Arm"] = "RightHand",
	["Left Arm"] = "LeftHand"
}
local v_u12 = nil
local v_u13 = nil
local v_u14 = nil
local v_u_new = v3.new()
local v_u15 = false
local v_u16 = nil
local v_u17 = nil
local v_u18 = 1
local v_u19 = nil
local function v_u20()
	-- upvalues: (copy) v_u_maps, (copy) v_u_lighting
	local v_map = workspace:FindFirstChild("Map")
	if v_map then
		local v_mapname = v_map:GetAttribute("MapName")
		if v_mapname and typeof(v_mapname) == "string" then
			local v1 = v_u_maps:FindFirstChild(v_mapname)
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
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u21(arg1)
	-- upvalues: (copy) v_u_lighting, (copy) v_u_maps, (copy) v_u_lighting
	local v1 = v_u_lighting:FindFirstChild(arg1)
	if v1 then
		local v2 = v_u_maps:FindFirstChild(arg1)
		if v2 and v2:IsA("ModuleScript") then
			local v3 = require(v2)
			if v3.Lighting and v3.Lighting.Properties then
				local v_properties = v3.Lighting.Properties
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
		end
		for _, v4 in ipairs(v_u_lighting:GetChildren()) do
			if v4.Name ~= "Menu" then
				v4:Destroy()
			end
		end
		for _, v5 in ipairs(v1:GetChildren()) do
			v5:Clone().Parent = v_u_lighting
		end
	else
		warn((("[MenuSceneController]: No lighting found for scene \"%*\""):format(arg1)))
	end
end
local function v_u22()
	-- upvalues: (copy) v_u_playergui, (copy) v_u_localplayer, (copy) v_u_replicatedstorage
	local v_maingui = v_u_playergui:FindFirstChild("MainGui")
	if v_maingui then
		local v_gameplay = v_maingui:FindFirstChild("Gameplay")
		if v_gameplay then
			v_gameplay = v_gameplay:FindFirstChild("Middle")
		end
		if v_gameplay then
			v_gameplay = v_gameplay:FindFirstChild("TeamSelection")
		end
		if v_gameplay and v_gameplay.Visible then
			return false
		end
	end
	local v_isspectating = v_u_localplayer:GetAttribute("IsSpectating")
	local v_team = v_u_localplayer:GetAttribute("Team")
	local v_getstate = require(v_u_replicatedstorage.Database.Components.GameState).GetState()
	if v_getstate == "Game Ending" or v_getstate == "Map Voting" then
		if v_team == "Counter-Terrorists" or v_team == "Terrorists" then
			return false
		end
		local v_character = v_u_localplayer.Character
		local v1
		if v_character and v_character:IsDescendantOf(workspace) then
			local v_humanoid = v_character:FindFirstChild("Humanoid")
			v1 = v_humanoid and v_humanoid.Health > 0 and true or false
		else
			v1 = false
		end
		return not v1
	end
	if v_team == "Counter-Terrorists" or v_team == "Terrorists" then
		return false
	end
	local v_character = v_u_localplayer.Character
	local v2
	if v_character and v_character:IsDescendantOf(workspace) then
		local v_humanoid = v_character:FindFirstChild("Humanoid")
		v2 = v_humanoid and v_humanoid.Health > 0 and true or false
	else
		v2 = false
	end
	local v3 = not v2
	if v3 then
		v3 = not v_isspectating
	end
	return v3
end
local function v_u23(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_localplayer, (copy) v_u9, (copy) v_u11, (copy) v_u10
	local v1 = require(v_u_replicatedstorage.Controllers.DataController)
	local v2 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
	local v3 = nil
	local v4 = nil
	local v5 = nil
	if arg3 then
		local v6 = arg2 == "CT" and "Counter-Terrorists" or "Terrorists"
		v1.WaitForDataLoaded(v_u_localplayer)
		local v_get = v1.Get(v_u_localplayer, "Loadout")
		if v_get and (type(v_get) == "table" and v_get[v6]) then
			local v7 = v_get[v6]
			if v7 and (type(v7) == "table" and v7.Equipped) then
				local v_equipped gloves = v7.Equipped["Equipped Gloves"]
				if v_equipped gloves and (v_equipped gloves ~= "" and type(v_equipped gloves) == "string") then
					local v_get = v1.Get(v_u_localplayer, "Inventory")
					if v_get and type(v_get) == "table" then
						for _, v8 in ipairs(v_get) do
							if v8 and v8._id == v_equipped gloves then
								v3 = v8.Name
								v4 = v8.Skin
								v5 = v8.Float
								arg1:SetAttribute("EquippedGloves", game:GetService("HttpService"):JSONEncode({
									["SkinIdentifier"] = v_equipped gloves
								}))
								break
							end
						end
					end
				end
			end
		end
	end
	local v9 = v3 or v_u9[arg2].Glove
	local v10
	if v4 and (v5 and v9) then
		v10 = v2.GetGloves(v9, v4, v5)
	else
		v10 = nil
	end
	local v11 = v10 or v_u_replicatedstorage:WaitForChild("Assets"):WaitForChild("Weapons"):FindFirstChild(v9)
	if v11 then
		local v_characterarmor = arg1:FindFirstChild("CharacterArmor")
		if not v_characterarmor then
			v_characterarmor = Instance.new("Folder")
			v_characterarmor.Name = "CharacterArmor"
			v_characterarmor.Parent = arg1
		end
		local v12
		if v10 then
			v12 = v10:GetChildren()
		else
			if not v11 then
				warn((("[MenuSceneController]: No glove model or folder available for \"%*\""):format(v9)))
				return
			end
			v12 = v11:GetChildren()
		end
		for _, v13 in ipairs(v12) do
			if v13:IsA("BasePart") then
				local v14 = v_u11[v13.Name]
				if v14 then
					local v15 = arg1:FindFirstChild(v14)
					if v15 then
						local v_clone = v13:Clone()
						v_clone.Name = v_u10[v13.Name]
						v_clone.CastShadow = false
						v_clone.CanCollide = false
						v_clone.CanTouch = false
						v_clone.Anchored = false
						v_clone.CanQuery = false
						v_clone.CFrame = v15.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
						v_clone.Size = Vector3.new(v15.Size.X * 1.1, v15.Size.Z, v15.Size.Y) * 1.1
						v_clone.Parent = v_characterarmor
						local v_motor6d = Instance.new("Motor6D")
						v_motor6d.Name = "GloveAttachment"
						v_motor6d.Part0 = v15
						v_motor6d.Part1 = v_clone
						v_motor6d.C0 = CFrame.new(0, 0, -0.025)
						v_motor6d.C1 = v_clone.PivotOffset * CFrame.Angles(1.5707963267948966, 0, 0)
						v_motor6d.Parent = v_clone
					end
				end
			end
		end
		if v10 and v10.Name == "" then
			v10:Destroy()
		end
	else
		warn((("[MenuSceneController]: Glove folder not found for \"%*\""):format(v9)))
	end
end
local function v_u24(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_localplayer, (copy) v_u9
	local v1 = require(v_u_replicatedstorage.Controllers.DataController)
	local v2 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
	local v3 = nil
	local v4 = nil
	local v5 = nil
	local v6 = nil
	local v7 = nil
	if arg3 then
		local v8 = arg2 == "CT" and "Counter-Terrorists" or "Terrorists"
		local v9 = arg2 == "CT" and "M4A1-S" or "AK-47"
		v1.WaitForDataLoaded(v_u_localplayer)
		local v_get = v1.Get(v_u_localplayer, "Loadout")
		local v_get = v1.Get(v_u_localplayer, "Inventory")
		if v_get and (type(v_get) == "table" and v_get[v8]) then
			local v10 = v_get[v8]
			if v10 and (type(v10) == "table" and v10.Loadout) then
				local v_rifles = v10.Loadout.Rifles
				if v_rifles and (v_rifles.Options and (type(v_rifles.Options) == "table" and (v_get and type(v_get) == "table"))) then
					for _, v11 in ipairs(v_rifles.Options) do
						if v11 and (v11 ~= "" and type(v11) == "string") then
							for _, v12 in ipairs(v_get) do
								if v12 and (v12._id == v11 and v12.Name == v9) then
									v3 = v12.Name
									v4 = v12.Skin
									v5 = v12.Float
									v6 = v12.StatTrack
									v7 = v12.NameTag
									break
								end
							end
							if v3 then
								break
							end
						end
					end
				end
			end
		end
	end
	local v13 = v3 or v_u9[arg2].Weapon
	if v13 then
		local v14
		if v4 and (typeof(v4) == "string" and (v4 ~= "" and v13)) then
			v14 = v2.GetCharacterModel(v13, v4, v5, v6, v7)
		else
			v14 = nil
		end
		local v15 = v14 or v2.GetBaseWeaponModel(v13, "Character")
		if v15 then
			v15.Name = v13
			local v_righthand = arg1:FindFirstChild("RightHand")
			if v_righthand then
				if not v15.PrimaryPart then
					local v_weapon = v15:FindFirstChild("Weapon")
					if v_weapon then
						v_weapon = v_weapon:FindFirstChild("Insert")
					end
					if not v_weapon then
						warn("[MenuSceneController]: Weapon model has no PrimaryPart or Insert")
						v15:Destroy()
						return
					end
					v15.PrimaryPart = v_weapon
				end
				for _, v16 in ipairs(v15:GetDescendants()) do
					if v16:IsA("BasePart") then
						v16.CanCollide = false
						v16.CanQuery = false
						v16.CanTouch = false
						v16.Anchored = false
						v16.Massless = true
					end
				end
				v15.Parent = arg1
				local v_motor6d = Instance.new("Motor6D")
				v_motor6d.Name = "WeaponAttachment"
				v_motor6d.Part0 = v_righthand
				v_motor6d.Part1 = v15.PrimaryPart
				v_motor6d.Parent = v_righthand
				if v13 == "AK-47" then
					v_motor6d.C0 = CFrame.new(-0.251, 0.806, -0.406) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)
					return v15
				end
				local v_properties = v15:FindFirstChild("Properties")
				if v_properties then
					local v_c0 = v_properties:FindFirstChild("C0")
					if v_c0 then
						v_motor6d.C0 = v_c0.Value
					end
					local v_c1 = v_properties:FindFirstChild("C1")
					if v_c1 then
						v_motor6d.C1 = v_c1.Value
					end
				end
				return v15
			end
			warn("[MenuSceneController]: Character missing RightHand")
			v15:Destroy()
		else
			warn((("[MenuSceneController]: Failed to get weapon model for \"%*\""):format(v13)))
		end
	else
		warn("[MenuSceneController]: No weapon name available")
		return
	end
end
local function v_u25(arg1)
	-- upvalues: (copy) v_u9, (copy) v_u8, (copy) v_u_characters, (ref) v_u13, (ref) v_u14, (copy) v_u24, (copy) v_u23, (copy) v_u_new, (ref) v_u15
	local v_playerpart = arg1:FindFirstChild("PlayerPart")
	if v_playerpart then
		local v1 = math.random(1, 2) == 1 and "CT" or "T"
		local v2 = v_u9[v1]
		local v3 = v_u8[v1]
		local v4 = v_u_characters:FindFirstChild(v2.Character)
		if v4 then
			local v_clone = v4:Clone()
			v_clone.Name = "MenuCharacter"
			v_u13 = v_clone
			v_u14 = v1
			if v_clone:FindFirstChild("HumanoidRootPart") then
				v_clone:PivotTo(v_playerpart.CFrame)
			end
			v_clone.Parent = arg1
			v_u24(v_clone, v1, true)
			v_u23(v_clone, v1, true)
			local v_humanoid = v_clone:FindFirstChild("Humanoid")
			if v_humanoid then
				local v_animator = v_humanoid:FindFirstChildOfClass("Animator")
				if not v_animator then
					v_animator = Instance.new("Animator")
					v_animator.Parent = v_humanoid
				end
				local v_animation = Instance.new("Animation")
				v_animation.AnimationId = v3.Entrance
				local v_animation = Instance.new("Animation")
				v_animation.AnimationId = v3.Idle
				local v_loadanimation = v_animator:LoadAnimation(v_animation)
				local v_u_loadanimation = v_animator:LoadAnimation(v_animation)
				v_u_new:Add(v_animation, "Destroy", "EntranceAnimation")
				v_u_new:Add(v_animation, "Destroy", "IdleAnimation")
				v_u_new:Add(v_loadanimation, "Stop", "EntranceTrack")
				v_u_new:Add(v_u_loadanimation, "Stop", "IdleTrack")
				v_loadanimation.Priority = Enum.AnimationPriority.Action
				v_loadanimation:Play()
				v_loadanimation.Stopped:Once(function()
					-- upvalues: (ref) v_u15, (copy) v_u_loadanimation
					if v_u15 and v_u_loadanimation then
						v_u_loadanimation.Looped = true
						v_u_loadanimation.Priority = Enum.AnimationPriority.Idle
						v_u_loadanimation:Play()
					end
				end)
				v_u_new:Add(function()
					-- upvalues: (ref) v_u13, (ref) v_u14
					if v_u13 then
						v_u13:Destroy()
						v_u13 = nil
						v_u14 = nil
					end
				end, true, "MenuCharacterCleanup")
			else
				warn("[MenuSceneController]: Character missing Humanoid")
			end
		else
			warn((("[MenuSceneController]: Character \"%*\" not found"):format(v2.Character)))
			return
		end
	else
		return
	end
end
function v_u1.ShowMenuScene()
	-- upvalues: (ref) v_u15, (copy) v_u4, (copy) v_u_replicatedstorage, (ref) v_u7, (ref) v_u12, (copy) v_u21, (copy) v_u20, (copy) v_u_current_camera, (copy) v_u_new, (copy) v_u_run, (copy) v_u25, (ref) v_u17, (copy) v_u5, (ref) v_u16, (copy) v_u_playergui, (ref) v_u18
	if v_u15 then
		v_u4.updateCameraFOV(50)
		v_u4.setMouseEnabled(true)
		return
	elseif workspace:FindFirstChild("InspectScene") then
		return
	elseif require(v_u_replicatedstorage.Interface.MenuState).IsCaseSceneActive() then
		return
	else
		local v1
		if v_u7 then
			v1 = v_u7
		else
			local v_assets = v_u_replicatedstorage:FindFirstChild("Assets")
			if v_assets then
				v_u7 = v_assets:WaitForChild("MenuScenes", 10)
			end
			v1 = v_u7
		end
		local v2
		if v1 then
			local v_getchildren = v1:GetChildren()
			if #v_getchildren > 0 then
				v2 = v_getchildren[math.random(1, #v_getchildren)]
			else
				v2 = nil
			end
		else
			v2 = nil
		end
		if v2 then
			local v_clone = v2:Clone()
			v_clone.Parent = workspace
			v_u12 = v_clone
			v_u21(v2.Name)
			local v_u_campart = v_clone:FindFirstChild("CamPart")
			if v_u_campart then
				v_u_current_camera.CameraType = Enum.CameraType.Scriptable
				v_u_current_camera.CFrame = v_u_campart.CFrame
				v_u_current_camera.Focus = v_u_campart.CFrame
				v_u4.updateCameraFOV(50)
				v_u4.setMouseEnabled(true)
				v_u_new:Add(v_u_run.RenderStepped:Connect(function()
					-- upvalues: (ref) v_u12, (copy) v_u_campart, (ref) v_u_current_camera
					if v_u12 and v_u_campart then
						v_u_current_camera.CFrame = v_u_campart.CFrame
						v_u_current_camera.Focus = v_u_campart.CFrame
					end
				end), "Disconnect", "CameraUpdate")
				v_u_new:Add(function()
					-- upvalues: (ref) v_u12
					if v_u12 then
						v_u12:Destroy()
						v_u12 = nil
					end
				end, true, "MenuSceneCleanup")
				v_u15 = true
				v_u25(v_clone)
				if not (v_u17 and v_u17.IsPlaying) then
					local v_main_menu = v_u5.new("Main Menu")
					v_u16 = v_main_menu
					local v_play = v_main_menu:play({
						["Name"] = "Main Menu Music",
						["Parent"] = v_u_playergui
					})
					v_u17 = v_play
					if v_play then
						v_play:SetAttribute("BaseVolume", v_play.Volume)
						if v_u18 ~= 1 then
							v_play.Volume = v_play.Volume * v_u18
						end
					end
				end
			else
				warn("[MenuSceneController]: Menu scene missing CamPart")
				v_clone:Destroy()
				v_u12 = nil
				v_u20()
			end
		else
			return
		end
	end
end
function v_u1.HideMenuScene(arg1, arg2)
	-- upvalues: (ref) v_u15, (copy) v_u_new, (copy) v_u20, (copy) v_u_current_camera, (copy) v_u4, (copy) v_u6, (ref) v_u17, (ref) v_u16
	if v_u15 then
		v_u_new:Cleanup()
		if not arg2 then
			v_u20()
		end
		if not arg2 then
			v_u_current_camera.CameraType = Enum.CameraType.Custom
			v_u4.updateCameraFOV(v_u6.DEFAULT_CAMERA_FOV)
		end
		v_u15 = false
		if not arg1 then
			if v_u17 then
				v_u17:Stop()
				v_u17 = nil
			end
			if v_u16 then
				v_u16:destroy()
				v_u16 = nil
			end
		end
	end
end
function v_u1.IsActive()
	-- upvalues: (ref) v_u15
	return v_u15
end
function v_u1.StopMenuMusic()
	-- upvalues: (ref) v_u17, (ref) v_u16
	if v_u17 then
		v_u17:Stop()
		v_u17 = nil
	end
	if v_u16 then
		v_u16:destroy()
		v_u16 = nil
	end
end
function v_u1.IsMusicPlaying()
	-- upvalues: (ref) v_u17
	local v1
	if v_u17 == nil then
		v1 = false
	else
		v1 = v_u17.IsPlaying
	end
	return v1
end
function v_u1.SetMusicVolumeMultiplier(arg1, arg2)
	-- upvalues: (ref) v_u18, (ref) v_u17, (ref) v_u19, (copy) v_u_tween
	v_u18 = arg1
	if v_u17 then
		if v_u19 then
			v_u19:Cancel()
			v_u19 = nil
		end
		local v1 = (v_u17:GetAttribute("BaseVolume") or 0.1) * v_u18
		if arg2 and arg2 > 0 then
			v_u19 = v_u_tween:Create(v_u17, TweenInfo.new(arg2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["Volume"] = v1
			})
			v_u19:Play()
		else
			v_u17.Volume = v1
		end
	else
		return
	end
end
function v_u1.ApplyMapLighting()
	-- upvalues: (copy) v_u20
	v_u20()
end
function v_u1.ApplyMenuSceneLighting()
	-- upvalues: (ref) v_u7, (copy) v_u_replicatedstorage, (copy) v_u21, (copy) v_u_lighting
	local v1
	if v_u7 then
		v1 = v_u7
	else
		local v_assets = v_u_replicatedstorage:FindFirstChild("Assets")
		if v_assets then
			v_u7 = v_assets:WaitForChild("MenuScenes", 10)
		end
		v1 = v_u7
	end
	local v2
	if v1 then
		local v_getchildren = v1:GetChildren()
		if #v_getchildren > 0 then
			v2 = v_getchildren[math.random(1, #v_getchildren)]
		else
			v2 = nil
		end
	else
		v2 = nil
	end
	if v2 then
		v_u21(v2.Name)
		v_u_lighting.GlobalShadows = true
	end
end
function v_u1.GetMenuCharacter()
	-- upvalues: (ref) v_u13
	return v_u13
end
function v_u1.CreateStandaloneCharacter(arg1)
	-- upvalues: (copy) v_u9, (copy) v_u_characters, (copy) v_u_replicatedstorage, (copy) v_u23
	local v1 = arg1 or (math.random(1, 2) == 1 and "CT" or "T")
	local v2 = v_u9[v1]
	local v3 = v_u_characters:FindFirstChild(v2.Character)
	if not v3 then
		warn((("[MenuSceneController]: Character \"%*\" not found"):format(v2.Character)))
		return nil
	end
	local v_clone = v3:Clone()
	v_clone.Name = "StandaloneCharacter"
	v_clone.Parent = v_u_replicatedstorage
	v_u23(v_clone, v1, true)
	return v_clone
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u22, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u2, (ref) v_u13, (ref) v_u14, (copy) v_u24, (copy) v_u23, (copy) v_u_replicatedstorage, (copy) v_u_new
	if v_u22() then
		v_u1.ShowMenuScene()
	end
	v_u_localplayer.CharacterAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u22
		v_u1.HideMenuScene()
		arg1:WaitForChild("Humanoid").Died:Connect(function()
			-- upvalues: (ref) v_u22, (ref) v_u1
			task.delay(0.1, function()
				-- upvalues: (ref) v_u22, (ref) v_u1
				if v_u22() then
					v_u1.ShowMenuScene()
				end
			end)
		end)
	end)
	v_u_localplayer.CharacterRemoving:Connect(function()
		-- upvalues: (ref) v_u22, (ref) v_u1
		task.delay(0.1, function()
			-- upvalues: (ref) v_u22, (ref) v_u1
			if v_u22() then
				v_u1.ShowMenuScene()
			end
		end)
	end)
	v_u2.observeAttribute(v_u_localplayer, "IsSpectating", function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u22
		if arg1 then
			v_u1.HideMenuScene()
		elseif v_u22() then
			v_u1.ShowMenuScene()
		end
		return function()
			-- upvalues: (ref) v_u22, (ref) v_u1
			if v_u22() then
				v_u1.ShowMenuScene()
			end
		end
	end)
	v_u2.observeAttribute(v_u_localplayer, "Team", function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u22
		if arg1 == "Counter-Terrorists" or arg1 == "Terrorists" then
			v_u1.HideMenuScene()
		elseif v_u22() then
			v_u1.ShowMenuScene()
		end
		return function()
			-- upvalues: (ref) v_u22, (ref) v_u1
			task.delay(0.1, function()
				-- upvalues: (ref) v_u22, (ref) v_u1
				if v_u22() then
					v_u1.ShowMenuScene()
				end
			end)
		end
	end)
	local function v_u1()
		-- upvalues: (ref) v_u13, (ref) v_u14, (ref) v_u24, (ref) v_u23
		if v_u13 and v_u14 then
			local v_righthand = v_u13:FindFirstChild("RightHand")
			local v1 = v_righthand and v_righthand:FindFirstChild("WeaponAttachment")
			if v1 then
				local v_part1 = v1.Part1
				if v_part1 and v_part1.Parent then
					v_part1:Destroy()
				end
				v1:Destroy()
			end
			local v_characterarmor = v_u13:FindFirstChild("CharacterArmor")
			if v_characterarmor then
				for _, v2 in ipairs(v_characterarmor:GetChildren()) do
					if v2:IsA("BasePart") and v2:FindFirstChild("GloveAttachment") then
						v2:Destroy()
					end
				end
			end
			v_u24(v_u13, v_u14, true)
			v_u23(v_u13, v_u14, true)
		end
	end
	local v_u2 = require(v_u_replicatedstorage.Controllers.DataController)
	local v_u_createlistener = v_u2.CreateListener(v_u_localplayer, "Loadout", function()
		-- upvalues: (copy) v_u1
		v_u1()
	end)
	v_u_new:Add(function()
		-- upvalues: (copy) v_u2, (ref) v_u_localplayer, (copy) v_u_createlistener
		v_u2.RemoveListener(v_u_localplayer, "Loadout", v_u_createlistener)
	end, true, "LoadoutListener")
	local v3 = require(v_u_replicatedstorage.Database.Components.GameState)
	local v_u4 = require(v_u_replicatedstorage.Controllers.SpectateController)
	v3.ListenToState(function(_, arg2)
		-- upvalues: (ref) v_u_localplayer, (copy) v_u4, (ref) v_u22, (ref) v_u1
		if arg2 == "Game Ending" or arg2 == "Map Voting" then
			if v_u_localplayer:GetAttribute("IsSpectating") then
				v_u4.Stop(false, true)
			end
			if v_u22() then
				v_u1.ShowMenuScene()
			end
		end
	end)
end
function v_u1.Start() end
return v_u1