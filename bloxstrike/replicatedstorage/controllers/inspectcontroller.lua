-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_run = game:GetService("RunService")
local v_u_tween = game:GetService("TweenService")
local v_u_text = game:GetService("TextService")
local v_u_lighting = game:GetService("Lighting")
local v_players = game:GetService("Players")
require(v_u_replicatedstorage.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v2 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u3 = require(v_u_replicatedstorage.Controllers.MenuSceneController)
local v_u4 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u5 = require(v_u_replicatedstorage.Controllers.InputController)
local v_u6 = require(v_u_replicatedstorage.Classes.WeaponComponent.Classes.Viewmodel)
local v_u7 = require(v_u_replicatedstorage.Components.Common.InterfaceAnimations.ActivateButton)
local v_u8 = require(v_u_replicatedstorage.Database.Components.Libraries.Collections)
local v_u9 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
local v_u10 = require(v_u_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u11 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u12 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u13 = require(v_u_replicatedstorage.Database.Custom.Constants)
local v_u_localplayer = v_players.LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u_current_camera = workspace.CurrentCamera
local v_u14 = nil
local v_u_lighting = v_u_replicatedstorage.Assets.Lighting
local v_u_maps = v_u_replicatedstorage.Database.Custom.GameStats.Maps
local v_u15 = nil
local v_u16 = nil
local v_u17 = false
local v_u_default_camera_fov = v_u13.DEFAULT_CAMERA_FOV
local v_u18 = nil
local v_u19 = nil
local v_u20 = nil
local v_u21 = nil
local v_u22 = nil
local v_u_new = v2.new()
local v_u23 = false
local v_u_weapon = "Weapon"
local v_u24 = {}
local v_u25 = false
local v_u_zero = Vector2.zero
local v_u26 = 0
local v_u27 = 0
local v_u28 = 0
local v_u29 = 0
local v_u30 = 40
local v_u31 = 40
local v_u32 = nil
local v_u33 = {}
local v_u34 = nil
local v_u35 = 1
local v_u36 = nil
local function v_u37()
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
local function v_u38(arg1)
	-- upvalues: (copy) v_u_lighting, (copy) v_u_maps, (copy) v_u_lighting
	local v1 = v_u_lighting:FindFirstChild(arg1) or v_u_lighting:FindFirstChild("Menu")
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
	end
end
local function v_u39()
	-- upvalues: (ref) v_u14, (copy) v_u_replicatedstorage
	local v1
	if v_u14 then
		v1 = v_u14
	else
		local v_assets = v_u_replicatedstorage:FindFirstChild("Assets")
		if v_assets then
			v_u14 = v_assets:WaitForChild("InspectScenes", 10)
		end
		v1 = v_u14
	end
	if v1 then
		local v2 = {}
		for _, v3 in ipairs(v1:GetChildren()) do
			if v3:IsA("Model") then
				table.insert(v2, v3)
			end
		end
		if #v2 > 0 then
			return v2[math.random(1, #v2)]
		else
			return nil
		end
	else
		return nil
	end
end
local function v_u40()
	-- upvalues: (ref) v_u19, (ref) v_u18, (ref) v_u27, (ref) v_u26, (ref) v_u32
	if v_u19 and v_u18 then
		local v_weaponpart = v_u18:FindFirstChild("WeaponPart")
		if v_weaponpart then
			local v_angles = CFrame.Angles(0, -1.5707963267948966, 0)
			local v_angles = CFrame.Angles(0, math.rad(v_u27), (math.rad(v_u26)))
			if v_u32 then
				local v_toobjectspace = v_u19:GetPivot():ToObjectSpace(v_u32.WorldCFrame)
				v_u19:PivotTo(v_weaponpart.CFrame * v_angles * v_angles * v_toobjectspace:Inverse())
			else
				v_u19:PivotTo(v_weaponpart.CFrame * v_angles * v_angles)
			end
		else
			return
		end
	else
		return
	end
end
local function v_u41()
	-- upvalues: (ref) v_u33
	local v1 = {}
	for _, v2 in pairs(v_u33) do
		table.insert(v1, v2)
	end
	if #v1 >= 2 then
		return (v1[1] - v1[2]).Magnitude
	else
		return nil
	end
end
local function v_u42()
	-- upvalues: (copy) v_u12, (ref) v_u17, (copy) v_u3
	v_u12.EnterInspect()
	local v_getmenuframe = v_u12.GetMenuFrame()
	if v_getmenuframe then
		v_u17 = v_u3.IsActive()
		if v_u17 then
			v_u3.HideMenuScene(true)
			v_u3.SetMusicVolumeMultiplier(0.5, 0.5)
		end
		v_u12.SetBlurEnabled(false)
		v_getmenuframe.BackgroundTransparency = 1
		local v_pattern = v_getmenuframe:FindFirstChild("Pattern")
		if v_pattern then
			v_pattern.Visible = false
		end
		local v_top = v_getmenuframe:FindFirstChild("Top")
		if v_top then
			v_top.Visible = false
		end
		for _, v1 in ipairs(v_getmenuframe:GetChildren()) do
			if v1:IsA("Frame") and v1.Name ~= "Top" then
				if v1.Name == "Inspect" or v1.Name == "InspectFrame" then
					v1.Visible = true
				else
					v1.Visible = false
				end
			end
		end
	end
end
local function v_u43()
	-- upvalues: (copy) v_u12, (copy) v_u7, (copy) v_u1, (copy) v_u_new, (copy) v_u11
	local v_getmenuframe = v_u12.GetMenuFrame()
	if v_getmenuframe then
		local v1 = v_getmenuframe:FindFirstChild("Inspect") or v_getmenuframe:FindFirstChild("InspectFrame")
		if v1 then
			local v_bottom = v1:FindFirstChild("Bottom")
			if v_bottom then
				local v_close = v_bottom:FindFirstChild("Close")
				if v_close and v_close:IsA("GuiButton") then
					v_u7(v_close)
					v_u_new:Add(v_close.MouseButton1Click:Connect(function()
						-- upvalues: (ref) v_u1
						v_u1.HideInspect()
					end), "Disconnect", "CloseButtonConnection")
					local v_broadcastrouter = v_u11.broadcastRouter("HasPendingCharmAttachment")
					local v_charm = v_bottom:FindFirstChild("Charm")
					if v_charm then
						v_charm.Visible = v_broadcastrouter or false
						if v_broadcastrouter then
							local v_next = v_charm:FindFirstChild("Next")
							if v_next and v_next:IsA("GuiButton") then
								v_u7(v_next)
								v_u_new:Add(v_next.MouseButton1Click:Connect(function()
									-- upvalues: (ref) v_u1
									v_u1.CycleCharmPosition()
								end), "Disconnect", "NextCharmButtonConnection")
							end
							local v_confirm = v_charm:FindFirstChild("Confirm")
							if v_confirm and v_confirm:IsA("GuiButton") then
								v_u7(v_confirm)
								v_u_new:Add(v_confirm.MouseButton1Click:Connect(function()
									-- upvalues: (ref) v_u11
									v_u11.broadcastRouter("ConfirmCharmAttachment")
								end), "Disconnect", "ConfirmCharmButtonConnection")
							end
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
local function v_u44(arg1)
	-- upvalues: (ref) v_u18, (copy) v_u9, (ref) v_u19, (ref) v_u32
	if v_u18 then
		local v_weaponpart = v_u18:FindFirstChild("WeaponPart")
		if v_weaponpart then
			local v1 = nil
			local v2 = arg1.Type == "Charm"
			if arg1.Type == "Glove" then
				local v_getgloves = v_u9.GetGloves(arg1.Name, arg1.Skin, arg1.Float)
				if v_getgloves then
					if v_getgloves:IsA("BasePart") then
						v1 = Instance.new("Model")
						v1.Name = arg1.Name
						v_getgloves.Parent = v1
						v1.PrimaryPart = v_getgloves
					else
						v1 = v_getgloves
					end
				end
			elseif v2 then
				v1 = v_u9.GetCharmModel(arg1.Skin, arg1.Pattern or 1) or v1
			else
				v1 = v_u9.GetCharacterModel(arg1.Name, arg1.Skin, arg1.Float, arg1.StatTrack, arg1.NameTag, arg1.Charm, arg1.Stickers)
			end
			if v1 then
				v1.Name = "InspectWeapon"
				v_u19 = v1
				v_u32 = v1:FindFirstChild("InspectPivot", true)
				if v_u32 then
					warn((("[InspectController]: Found InspectPivot at %*"):format((v_u32:GetFullName()))))
				else
					warn((("[InspectController]: No InspectPivot found for %*"):format(arg1.Name)))
				end
				local v_charmbase = v1:FindFirstChild("CharmBase", true)
				for _, v3 in ipairs(v1:GetDescendants()) do
					if v3:IsA("BasePart") then
						local v4
						if v_charmbase then
							v4 = v3:IsDescendantOf(v_charmbase)
						else
							v4 = v_charmbase
						end
						if v2 then
							if v1.PrimaryPart == v3 then
								v3.CanCollide = false
								v3.CanQuery = false
								v3.CanTouch = false
								v3.Anchored = true
							else
								v3.CanCollide = false
								v3.CanQuery = false
								v3.CanTouch = false
								v3.Anchored = false
							end
						elseif v4 then
							v3.Anchored = false
						else
							v3.CanCollide = v3:IsA("MeshPart") and true or false
							v3.CanQuery = false
							v3.CanTouch = false
							v3.Anchored = true
						end
					end
				end
				v1.Parent = v_u18
				local v_angles = CFrame.Angles(0, -1.5707963267948966, 0)
				if v_u32 then
					local v_toobjectspace = v1:GetPivot():ToObjectSpace(v_u32.WorldCFrame)
					v1:PivotTo(v_weaponpart.CFrame * v_angles * v_toobjectspace:Inverse())
				else
					v1:PivotTo(v_weaponpart.CFrame * v_angles)
				end
			else
				warn(("[InspectController]: Failed to get model for \"%*\""):format(arg1.Name), arg1)
				return
			end
		else
			warn("[InspectController]: Inspect scene missing WeaponPart")
			return
		end
	else
		return
	end
end
local function v_u45(self)
	-- upvalues: (copy) v_u3, (ref) v_u21, (copy) v_u_localplayer, (copy) v_u6, (ref) v_u20, (copy) v_u5
	local v_createstandalonecharacter = v_u3.CreateStandaloneCharacter()
	if v_createstandalonecharacter then
		v_u21 = v_createstandalonecharacter
		local v_u1 = {
			["Player"] = v_u_localplayer,
			["Character"] = v_createstandalonecharacter,
			["StatTrack"] = self.StatTrack,
			["Stickers"] = self.Stickers,
			["NameTag"] = self.NameTag,
			["Float"] = self.Float,
			["Charm"] = self.Charm
		}
		local v2, v3 = pcall(function()
			-- upvalues: (ref) v_u6, (copy) v_u1, (copy) self
			return v_u6.new(v_u1, self.Name, self.Skin)
		end)
		if v2 and v3 then
			if v3 then
				v_u20:equip(false)
			end
		else
			warn("[InspectController]: Failed to create viewmodel:", v3)
			if v_u20 then
				v_u20:destroy()
				v_u20 = nil
			end
			if v_u21 then
				v_u21:Destroy()
				v_u21 = nil
			end
			v_u5.enableGroup("Gameplay")
		end
	else
		warn("[InspectController]: Failed to create standalone character for viewmodel")
		return
	end
end
local function v_u46(arg1)
	-- upvalues: (ref) v_u_weapon, (ref) v_u22, (ref) v_u19, (ref) v_u32, (ref) v_u20, (ref) v_u21, (copy) v_u5, (copy) v_u44, (ref) v_u31, (copy) v_u45, (copy) v_u_default_camera_fov
	if v_u_weapon == arg1 then
		return
	else
		local v1 = v_u22
		if v1 then
			if v_u_weapon == "Weapon" then
				if v_u19 then
					v_u19:Destroy()
					v_u19 = nil
				end
				v_u32 = nil
			elseif v_u_weapon == "Viewmodel" then
				if v_u20 then
					v_u20:destroy()
					v_u20 = nil
				end
				if v_u21 then
					v_u21:Destroy()
					v_u21 = nil
				end
				v_u5.enableGroup("Gameplay")
			end
			v_u_weapon = arg1
			if arg1 == "Weapon" then
				v_u44(v1)
				v_u31 = 40
				v_u5.enableGroup("Gameplay")
			elseif arg1 == "Viewmodel" then
				v_u5.disableGroup("Gameplay")
				v_u45(v1)
				v_u31 = v_u_default_camera_fov
			end
		else
			return
		end
	end
end
local function v_u47(arg1, arg2, arg3)
	-- upvalues: (ref) v_u_weapon, (copy) v_u_tween
	local v_hoverframe = arg2:FindFirstChild("HoverFrame")
	local v_selectframe = arg2:FindFirstChild("SelectFrame")
	local v_imagelabel = arg2:FindFirstChild("ImageLabel")
	local v1
	if v_u_weapon == arg1 then
		v1 = arg1 ~= "Info"
	else
		v1 = false
	end
	if v1 then
		local v2 = {
			["BackgroundTransparency"] = 1
		}
		if v_hoverframe then
			v_u_tween:Create(v_hoverframe, TweenInfo.new(0.2), v2):Play()
		end
		local v3 = {
			["BackgroundTransparency"] = 0
		}
		if v_selectframe then
			v_u_tween:Create(v_selectframe, TweenInfo.new(0.2), v3):Play()
		end
		if v_imagelabel then
			local v4 = {
				["ImageColor3"] = Color3.fromRGB(0, 0, 0)
			}
			if v_imagelabel then
				v_u_tween:Create(v_imagelabel, TweenInfo.new(0.2), v4):Play()
				return
			end
		end
	else
		local v5 = {
			["BackgroundTransparency"] = 1
		}
		if v_selectframe then
			v_u_tween:Create(v_selectframe, TweenInfo.new(0.2), v5):Play()
		end
		if v_imagelabel then
			local v6 = {
				["ImageColor3"] = Color3.fromRGB(255, 255, 255)
			}
			if v_imagelabel then
				v_u_tween:Create(v_imagelabel, TweenInfo.new(0.2), v6):Play()
			end
		end
		local v7 = {
			["BackgroundTransparency"] = arg3 and 0 or 1
		}
		if v_hoverframe then
			v_u_tween:Create(v_hoverframe, TweenInfo.new(0.2), v7):Play()
		end
	end
end
local function v_u48(arg1, arg2)
	-- upvalues: (copy) v_u47
	for v1, v2 in pairs(arg1) do
		if v2 and v2:IsA("GuiButton") then
			v_u47(v1, v2, v1 == arg2)
		end
	end
end
local function v_u49(arg1, arg2)
	-- upvalues: (copy) v_u_current_camera, (copy) v_u_text
	local v_floor = math.floor(v_u_current_camera.ViewportSize.Y * 0.025)
	local v_min = math.min(v_floor, 32)
	local v_max = math.max(8, v_min)
	local v_gotham = Enum.Font.Gotham
	local v1 = 0
	for _, v2 in ipairs(arg2) do
		if v2 and (v2:IsA("TextLabel") and v2.Text ~= "") then
			v2.TextScaled = false
			local v_gettextsize = v_u_text:GetTextSize(v2.Text:gsub("<[^>]*>", ""), v_max, v_gotham, Vector2.new((1 / 0), (1 / 0)))
			if v1 < v_gettextsize.X then
				v1 = v_gettextsize.X
			end
			v2.TextSize = v_max
			v2.TextWrapped = false
		end
	end
	if v1 > 0 then
		arg1.Size = UDim2.new(0.05, v1, arg1.Size.Y.Scale, arg1.Size.Y.Offset)
	end
end
local function v_u50(arg1, arg2, arg3)
	-- upvalues: (copy) v_u9, (copy) v_u49
	local v_u_information = arg1:FindFirstChild("Information")
	if v_u_information then
		if arg3 then
			v_u_information.Position = UDim2.new(0, arg3.AbsolutePosition.X + arg3.AbsoluteSize.X / 2 - v_u_information.Parent.AbsolutePosition.X + v_u_information.AbsoluteSize.X / 2, v_u_information.Position.Y.Scale, v_u_information.Position.Y.Offset)
		end
		v_u_information.Visible = true
		local v_getskininformation = v_u9.GetSkinInformation(arg2.Name, arg2.Skin)
		local v_factory_new = "Factory New"
		if v_getskininformation then
			v_factory_new = v_u9.GetWearNameForFloat(v_getskininformation, arg2.Float or 0) or v_factory_new
		end
		local v_u_exterior = v_u_information:FindFirstChild("Exterior")
		if v_u_exterior then
			v_u_exterior.RichText = true
			v_u_exterior.Text = ("<b><font color=\"rgb(175,175,175)\">Exterior</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(v_factory_new)
		end
		local v_u_tradeable = v_u_information:FindFirstChild("Tradeable")
		if v_u_tradeable then
			v_u_tradeable.RichText = true
			v_u_tradeable.Text = ("<b><font color=\"rgb(175,175,175)\">Tradeable</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(arg2.IsTradeable and "Yes" or "No")
		end
		local v_u_serial = v_u_information:FindFirstChild("Serial")
		if v_u_serial then
			v_u_serial.RichText = true
			v_u_serial.Text = ("<b><font color=\"rgb(175,175,175)\">Serial</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(not arg2.Serial and "N/A" or "#" .. tostring(arg2.Serial))
		end
		local v_u_pattern = v_u_information:FindFirstChild("Pattern")
		if v_u_pattern then
			v_u_pattern.RichText = true
			v_u_pattern.Text = ("<b><font color=\"rgb(175,175,175)\">Pattern</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format((tostring(arg2.Pattern or 0)))
		end
		local v_u_float = v_u_information:FindFirstChild("Float")
		if v_u_float then
			v_u_float.RichText = true
			v_u_float.Text = ("<b><font color=\"rgb(175,175,175)\">Float</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format((string.format("%.14f", arg2.Float or 0)))
		end
		task.defer(function()
			-- upvalues: (copy) v_u_exterior, (copy) v_u_tradeable, (copy) v_u_serial, (copy) v_u_pattern, (copy) v_u_float, (ref) v_u49, (copy) v_u_information
			local v1 = {}
			if v_u_exterior then
				table.insert(v1, v_u_exterior)
			end
			if v_u_tradeable then
				table.insert(v1, v_u_tradeable)
			end
			if v_u_serial then
				table.insert(v1, v_u_serial)
			end
			if v_u_pattern then
				table.insert(v1, v_u_pattern)
			end
			if v_u_float then
				table.insert(v1, v_u_float)
			end
			v_u49(v_u_information, v1)
		end)
	end
end
local function v_u51(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_new, (copy) v_u47, (ref) v_u22, (copy) v_u50, (ref) v_u_weapon, (copy) v_u46, (copy) v_u48
	v_u_new:Add(arg1.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u47, (copy) arg2, (copy) arg1, (copy) arg4, (ref) v_u22, (ref) v_u50
		v_u47(arg2, arg1, true)
		if arg2 == "Info" and (arg4 and v_u22) then
			v_u50(arg4, v_u22, arg1)
		end
	end), "Disconnect", "InspectButton_Enter_" .. arg2)
	v_u_new:Add(arg1.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u47, (copy) arg2, (copy) arg1, (copy) arg4
		v_u47(arg2, arg1, false)
		local v1 = arg2 == "Info" and (arg4 and arg4:FindFirstChild("Information"))
		if v1 then
			v1.Visible = false
		end
	end), "Disconnect", "InspectButton_Leave_" .. arg2)
	if arg2 ~= "Info" then
		v_u_new:Add(arg1.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_weapon, (copy) arg2, (ref) v_u46, (ref) v_u48, (copy) arg3
			if v_u_weapon ~= arg2 then
				v_u46(arg2)
				v_u48(arg3, arg2)
			end
		end), "Disconnect", "InspectButton_Click_" .. arg2)
	end
end
local function v_u52(arg1, arg2)
	-- upvalues: (copy) v_u47, (copy) v_u51
	local v_bottom = arg1:FindFirstChild("Bottom")
	if v_bottom then
		v_bottom = v_bottom:FindFirstChild("Frame")
	end
	if v_bottom then
		local v1 = arg2.Type == "Weapon" and true or arg2.Type == "Melee"
		local v2 = {
			["Info"] = v_bottom:FindFirstChild("Info"),
			["Viewmodel"] = v_bottom:FindFirstChild("Viewmodel"),
			["Weapon"] = v_bottom:FindFirstChild("Weapon")
		}
		for v3, v4 in pairs(v2) do
			if v4 and v4:IsA("GuiButton") then
				v4.Visible = v1 or v3 == "Info"
				v_u47(v3, v4, false)
				v_u51(v4, v3, v2, arg1)
			end
		end
	end
end
local function v_u53(arg1)
	-- upvalues: (copy) v_u_playergui, (copy) v_u52, (copy) v_u9, (copy) v_u8, (copy) v_u10
	local v_maingui = v_u_playergui:FindFirstChild("MainGui")
	if v_maingui then
		local v_menu = v_maingui:FindFirstChild("Menu")
		if v_menu then
			local v1 = v_menu:FindFirstChild("Inspect") or v_menu:FindFirstChild("InspectFrame")
			if v1 then
				v_u52(v1, arg1)
				local v_getskininformation = v_u9.GetSkinInformation(arg1.Name, arg1.Skin)
				local v_weaponname = v1:FindFirstChild("WeaponName")
				if v_weaponname and v_weaponname:IsA("TextLabel") then
					local v_skin = arg1.Skin
					v_weaponname.Text = (v_getskininformation.type == "Melee" and "\226\152\133 " or "") .. arg1.Name .. " | " .. (v_skin and v_skin == "Vanilla" and "" or v_skin)
				end
				if v_getskininformation then
					local v_u_collection = v_getskininformation.collection
					local v_collectionname = v1:FindFirstChild("CollectionName")
					if v_collectionname and v_collectionname:IsA("TextLabel") then
						v_collectionname.Text = v_u_collection or ""
					end
					local v_u_collectionicon = v1:FindFirstChild("CollectionIcon")
					if v_u_collectionicon and (v_u_collectionicon:IsA("ImageLabel") and v_u_collection) then
						local v_getcollectionbyname = v_u8.GetCollectionByName(v_u_collection)
						if v_getcollectionbyname then
							v_u_collectionicon.Image = v_getcollectionbyname.imageAssetId
							v_u8.ObserveAvailableCollections(function(arg1)
								-- upvalues: (copy) v_u_collection, (copy) v_u_collectionicon
								for _, v1 in ipairs(arg1) do
									if v1.name == v_u_collection then
										v_u_collectionicon.Image = v1.imageAssetId
										return
									end
								end
							end)
						else
							v_u_collectionicon.Image = ""
						end
					end
					local v_rarity = v1:FindFirstChild("Rarity")
					local v2 = v_rarity and (v_rarity:IsA("Frame") and (v_getskininformation.rarity and v_u10[v_getskininformation.rarity]))
					if v2 then
						v_rarity.BackgroundColor3 = v2.Color
					end
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u54()
	-- upvalues: (ref) v_u24, (copy) v_u_current_camera
	v_u24 = {}
	for _, v1 in ipairs(v_u_current_camera:GetChildren()) do
		if v1:IsA("Model") and v1.Name ~= "InspectScene" then
			for _, v2 in ipairs(v1:GetDescendants()) do
				if v2:IsA("BasePart") then
					if v2.Transparency < 1 then
						v2:SetAttribute("_InspectPrevTransparency", v2.Transparency)
						v2.Transparency = 1
					end
				elseif v2:IsA("SurfaceGui") and v2.Enabled then
					v2:SetAttribute("_InspectPrevSurfaceGuiEnabled", true)
					v2.Enabled = false
				end
			end
			table.insert(v_u24, v1)
		end
	end
end
local function v_u55()
	-- upvalues: (ref) v_u24
	for _, v1 in ipairs(v_u24) do
		if v1 and v1.Parent then
			for _, v2 in ipairs(v1:GetDescendants()) do
				if v2:IsA("BasePart") then
					local v_getattribute = v2:GetAttribute("_InspectPrevTransparency")
					if v_getattribute ~= nil then
						v2.Transparency = v_getattribute
						v2:SetAttribute("_InspectPrevTransparency", nil)
					end
				elseif v2:IsA("SurfaceGui") and v2:GetAttribute("_InspectPrevSurfaceGuiEnabled") ~= nil then
					v2.Enabled = true
					v2:SetAttribute("_InspectPrevSurfaceGuiEnabled", nil)
				end
			end
		end
	end
	v_u24 = {}
end
local function v_u56()
	-- upvalues: (copy) v_u12, (ref) v_u17, (copy) v_u3
	local v_getmenuframe = v_u12.GetMenuFrame()
	if v_getmenuframe and v_getmenuframe.Visible then
		local v1 = v_getmenuframe:FindFirstChild("Inspect") or v_getmenuframe:FindFirstChild("InspectFrame")
		if v1 and v1:IsA("GuiObject") then
			v1.Visible = false
		end
		if v_u17 then
			v_u3.ShowMenuScene()
			v_u3.SetMusicVolumeMultiplier(1, 0.5)
		end
		v_u17 = false
		local v_getscreenbeforeinspect = v_u12.GetScreenBeforeInspect()
		v_u12.ExitInspect()
		local v_top = v_getmenuframe:FindFirstChild("Top")
		if v_top then
			v_top.Visible = true
		end
		if v_getscreenbeforeinspect then
			local v2 = v_getmenuframe:FindFirstChild(v_getscreenbeforeinspect)
			if v2 then
				v2.Visible = true
				local v3
				if v_getscreenbeforeinspect == "Dashboard" then
					v3 = false
				else
					v3 = v_getscreenbeforeinspect ~= "Play"
				end
				v_u12.SetBlurEnabled(v3)
				v_getmenuframe.BackgroundTransparency = v3 and 0.15 or 1
				local v_pattern = v_getmenuframe:FindFirstChild("Pattern")
				if v_pattern then
					v_pattern.Visible = not v3
					return
				end
			end
		else
			local v_dashboard = v_getmenuframe:FindFirstChild("Dashboard")
			if v_dashboard then
				v_dashboard.Visible = true
			end
			v_u12.SetBlurEnabled(false)
			v_getmenuframe.BackgroundTransparency = 1
			local v_pattern = v_getmenuframe:FindFirstChild("Pattern")
			if v_pattern then
				v_pattern.Visible = true
			end
		end
	else
		v_u17 = false
		v_u12.ExitInspect()
	end
end
function v_u1.ShowInspect(arg1)
	-- upvalues: (ref) v_u23, (copy) v_u1, (copy) v_u11, (ref) v_u36, (ref) v_u35, (ref) v_u22, (ref) v_u_weapon, (copy) v_u42, (copy) v_u54, (copy) v_u43, (copy) v_u53, (ref) v_u15, (copy) v_u56, (ref) v_u18, (ref) v_u16, (copy) v_u38, (copy) v_u_replicatedstorage, (copy) v_u37, (copy) v_u44, (ref) v_u26, (ref) v_u27, (ref) v_u28, (ref) v_u29, (ref) v_u30, (ref) v_u31, (copy) v_u_current_camera, (copy) v_u4, (copy) v_u_new, (copy) v_u_run, (ref) v_u20, (copy) v_u40, (copy) v_u_userinput, (ref) v_u25, (ref) v_u_zero, (copy) v_u5, (copy) v_u_localplayer, (ref) v_u33, (ref) v_u34, (copy) v_u41, (ref) v_u19, (ref) v_u32
	if v_u23 then
		v_u1.HideInspect()
	end
	if v_u11.broadcastRouter("HasPendingCharmAttachment") then
		v_u36 = arg1
		v_u35 = 1
	else
		v_u36 = nil
	end
	v_u22 = arg1
	v_u_weapon = "Weapon"
	v_u42()
	v_u54()
	v_u43()
	v_u53(arg1)
	if v_u15 then
		if v_u15 and v_u15.Parent ~= workspace then
			v_u15.Parent = workspace
		end
		v_u18 = v_u15
		if v_u16 then
			v_u38(v_u16)
		end
		local v_u1
		if v_u18 then
			v_u1 = v_u18:FindFirstChild("CamPart")
		else
			v_u1 = nil
		end
		if v_u1 then
			local v2
			if v_u18 then
				v2 = v_u18:FindFirstChild("WeaponPart")
			else
				v2 = nil
			end
			if v2 then
				v_u44(arg1)
				v_u26 = 0
				v_u27 = 0
				v_u28 = 0
				v_u29 = 0
				v_u30 = 40
				v_u31 = 40
				v_u_current_camera.CameraType = Enum.CameraType.Scriptable
				v_u_current_camera.CFrame = v_u1.CFrame
				v_u_current_camera.Focus = v_u1.CFrame
				v_u4.updateCameraFOV(40)
				v_u4.enableForceLockOverride()
				v_u_new:Add(v_u_run.RenderStepped:Connect(function(arg1)
					-- upvalues: (ref) v_u30, (ref) v_u31, (ref) v_u18, (copy) v_u1, (ref) v_u_current_camera, (ref) v_u_weapon, (ref) v_u20, (ref) v_u26, (ref) v_u28, (ref) v_u27, (ref) v_u29, (ref) v_u40
					local v_min = math.min(1, arg1 * 8)
					v_u30 = v_u30 + (v_u31 - v_u30) * v_min
					if v_u18 and v_u1 then
						v_u_current_camera.CameraType = Enum.CameraType.Scriptable
						v_u_current_camera.CFrame = v_u1.CFrame
						v_u_current_camera.Focus = v_u1.CFrame
						v_u_current_camera.FieldOfView = v_u30
					end
					if v_u_weapon == "Viewmodel" and v_u20 then
						v_u20:render(arg1)
					elseif v_u_weapon == "Weapon" then
						local v_min = math.min(1, arg1 * 10)
						v_u26 = v_u26 + (v_u28 - v_u26) * v_min
						v_u27 = v_u27 + (v_u29 - v_u27) * v_min
						v_u40()
					end
				end), "Disconnect", "CameraUpdate")
				v_u_new:Add(v_u_userinput.InputBegan:Connect(function(arg1, _)
					-- upvalues: (ref) v_u25, (ref) v_u_zero, (ref) v_u5, (ref) v_u_localplayer, (ref) v_u_weapon, (ref) v_u20, (ref) v_u33, (ref) v_u34, (ref) v_u41
					if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
						v_u25 = true
						v_u_zero = Vector2.new(arg1.Position.X, arg1.Position.Y)
					end
					local v_inspect = v_u5.getActionKeybinds("Inspect")
					if table.find(v_inspect, arg1.KeyCode) then
						if v_u_localplayer:GetAttribute("IsPlayerChatting") then
							return
						end
						if v_u_weapon == "Viewmodel" and (v_u20 and v_u20.Animation) then
							v_u20.Animation:stopAnimations()
							v_u20.Animation:play("Idle")
							v_u20.Animation:play("Inspect")
						end
					end
					if arg1.UserInputType == Enum.UserInputType.Touch then
						v_u33[arg1] = Vector2.new(arg1.Position.X, arg1.Position.Y)
						local v1 = 0
						for _ in pairs(v_u33) do
							v1 = v1 + 1
						end
						if v1 == 1 then
							v_u25 = true
							v_u_zero = Vector2.new(arg1.Position.X, arg1.Position.Y)
						end
						v_u34 = v_u41()
					end
				end), "Disconnect", "InputBegan")
				v_u_new:Add(v_u_userinput.InputChanged:Connect(function(arg1, _)
					-- upvalues: (ref) v_u25, (ref) v_u_zero, (ref) v_u29, (ref) v_u28, (ref) v_u33, (ref) v_u41, (ref) v_u34, (ref) v_u_weapon, (ref) v_u31
					if arg1.UserInputType == Enum.UserInputType.MouseMovement and v_u25 then
						local v_new = Vector2.new(arg1.Position.X, arg1.Position.Y)
						local v1 = v_new - v_u_zero
						v_u29 = v_u29 + v1.X * 0.5
						v_u28 = math.clamp(v_u28 + v1.Y * 0.5, -80, 80)
						v_u_zero = v_new
					end
					if arg1.UserInputType == Enum.UserInputType.Touch then
						local v_new = Vector2.new(arg1.Position.X, arg1.Position.Y)
						v_u33[arg1] = v_new
						local v2 = 0
						for _ in pairs(v_u33) do
							v2 = v2 + 1
						end
						if v2 == 1 and v_u25 then
							local v3 = v_new - v_u_zero
							v_u29 = v_u29 + v3.X * 0.5
							v_u28 = math.clamp(v_u28 + v3.Y * 0.5, -80, 80)
							v_u_zero = v_new
						end
						if v2 >= 2 then
							local v4 = v_u41()
							if v4 and v_u34 then
								local v5 = (v4 - v_u34) * 0.01
								if v_u_weapon ~= "Viewmodel" then
									v_u31 = math.clamp(v_u31 - v5 * 2, 20, 70)
								end
							end
							v_u34 = v4
						end
					end
					if arg1.UserInputType == Enum.UserInputType.MouseWheel then
						local v_z = arg1.Position.Z
						if v_u_weapon == "Viewmodel" then
							return
						end
						v_u31 = math.clamp(v_u31 - v_z * 2, 20, 70)
					end
				end), "Disconnect", "InputChanged")
				v_u_new:Add(v_u_userinput.InputEnded:Connect(function(arg1, _)
					-- upvalues: (ref) v_u25, (ref) v_u33, (ref) v_u34, (ref) v_u41
					if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
						v_u25 = false
					end
					if arg1.UserInputType == Enum.UserInputType.Touch then
						v_u33[arg1] = nil
						local v1 = 0
						for _ in pairs(v_u33) do
							v1 = v1 + 1
						end
						if v1 == 0 then
							v_u25 = false
						end
						v_u34 = v_u41()
					end
				end), "Disconnect", "InputEnded")
				v_u_new:Add(function()
					-- upvalues: (ref) v_u19, (ref) v_u18, (ref) v_u15, (ref) v_u_replicatedstorage, (ref) v_u25, (ref) v_u33, (ref) v_u34, (ref) v_u26, (ref) v_u27, (ref) v_u28, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32
					if v_u19 then
						v_u19:Destroy()
						v_u19 = nil
					end
					if v_u18 and v_u18 == v_u15 then
						v_u18.Parent = v_u_replicatedstorage
						v_u18 = nil
					elseif v_u18 then
						v_u18:Destroy()
						v_u18 = nil
					end
					v_u25 = false
					v_u33 = {}
					v_u34 = nil
					v_u26 = 0
					v_u27 = 0
					v_u28 = 0
					v_u29 = 0
					v_u30 = 40
					v_u31 = 40
					v_u32 = nil
				end, true, "InspectCleanup")
				v_u23 = true
			else
				warn("[InspectController]: Inspect scene missing WeaponPart")
				if v_u18 then
					v_u18.Parent = v_u_replicatedstorage
					v_u18 = nil
				end
				v_u37()
				v_u56()
			end
		else
			warn("[InspectController]: Inspect scene missing CamPart")
			if v_u18 then
				v_u18.Parent = v_u_replicatedstorage
				v_u18 = nil
			end
			v_u37()
			v_u56()
			return
		end
	else
		warn("[InspectController]: No preloaded inspect scene available")
		v_u56()
		return
	end
end
function v_u1.HideInspect(arg1)
	-- upvalues: (ref) v_u23, (copy) v_u_new, (ref) v_u20, (ref) v_u21, (copy) v_u5, (ref) v_u19, (ref) v_u32, (copy) v_u37, (copy) v_u_current_camera, (copy) v_u4, (copy) v_u13, (copy) v_u56, (copy) v_u12, (ref) v_u17, (copy) v_u55, (ref) v_u36, (ref) v_u35
	if v_u23 then
		v_u_new:Cleanup()
		if v_u20 then
			v_u20:destroy()
			v_u20 = nil
		end
		if v_u21 then
			v_u21:Destroy()
			v_u21 = nil
		end
		v_u5.enableGroup("Gameplay")
		if v_u19 then
			v_u19:Destroy()
			v_u19 = nil
		end
		v_u32 = nil
		v_u37()
		v_u_current_camera.CameraType = Enum.CameraType.Custom
		v_u4.updateCameraFOV(v_u13.DEFAULT_CAMERA_FOV)
		v_u4.disableForceLockOverride()
		if arg1 then
			v_u12.ExitInspect()
			v_u17 = false
		else
			v_u56()
		end
		v_u55()
		v_u36 = nil
		v_u35 = 1
		v_u23 = false
	end
end
function v_u1.IsActive()
	-- upvalues: (ref) v_u23
	return v_u23
end
function v_u1.ToggleInspect(arg1)
	-- upvalues: (ref) v_u23, (copy) v_u1
	if v_u23 then
		v_u1.HideInspect()
	elseif arg1 then
		v_u1.ShowInspect(arg1)
	end
end
function v_u1.CycleCharmPosition()
	-- upvalues: (ref) v_u23, (ref) v_u36, (ref) v_u35, (copy) v_u1
	if v_u23 and v_u36 then
		v_u1.RefreshWeaponWithCharm((tostring(v_u35 % 4 + 1)))
	end
end
function v_u1.RefreshWeaponWithCharm(arg1)
	-- upvalues: (ref) v_u23, (ref) v_u18, (ref) v_u36, (ref) v_u26, (ref) v_u27, (ref) v_u28, (ref) v_u29, (ref) v_u19, (copy) v_u9, (ref) v_u32, (copy) v_u40
	if v_u23 and (v_u18 and v_u36) then
		local v1 = v_u18
		local v2 = v_u36
		if v1:FindFirstChild("WeaponPart") then
			local v3 = v_u26
			local v4 = v_u27
			local v5 = v_u28
			local v6 = v_u29
			if v_u19 then
				v_u19:Destroy()
				v_u19 = nil
			end
			local v_charm = v2.Charm
			local v_getcharactermodel = v_u9.GetCharacterModel(v2.Name, v2.Skin, v2.Float, v2.StatTrack, v2.NameTag, type(v_charm) == "table" and {
				["_id"] = v_charm._id,
				["Position"] = arg1
			} or arg1, v2.Stickers)
			if v_getcharactermodel then
				v_getcharactermodel.Name = "InspectWeapon"
				v_u19 = v_getcharactermodel
				v_u32 = v_getcharactermodel:FindFirstChild("InspectPivot", true)
				local v_charmbase = v_getcharactermodel:FindFirstChild("CharmBase", true)
				for _, v7 in ipairs(v_getcharactermodel:GetDescendants()) do
					if v7:IsA("BasePart") then
						local v8
						if v_charmbase then
							v8 = v7:IsDescendantOf(v_charmbase)
						else
							v8 = v_charmbase
						end
						if v8 then
							v7.Anchored = false
						else
							v7.CanCollide = v7:IsA("MeshPart") and true or false
							v7.CanQuery = false
							v7.CanTouch = false
							v7.Anchored = true
						end
					end
				end
				v_getcharactermodel.Parent = v1
				v_u26 = v3
				v_u27 = v4
				v_u28 = v5
				v_u29 = v6
				v_u40()
			else
				warn((("[InspectController]: Failed to refresh weapon model for charm position %*"):format(arg1)))
			end
		else
			return
		end
	else
		return
	end
end
function v_u1.GetCurrentCharmPosition()
	-- upvalues: (ref) v_u35
	return v_u35
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u39, (ref) v_u16, (ref) v_u15, (copy) v_u_replicatedstorage, (copy) v_u_userinput, (ref) v_u23, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u11, (ref) v_u35
	local v1 = v_u39()
	if v1 then
		v_u16 = v1.Name
		if v1 then
			v_u15.Name = "InspectScene"
			v_u15.Parent = v_u_replicatedstorage
		end
	else
		warn("[InspectController]: No inspect scene found to preload in ReplicatedStorage.Assets.InspectScenes")
	end
	v_u_userinput.InputBegan:Connect(function(arg1, arg2)
		-- upvalues: (ref) v_u23, (ref) v_u1
		if not arg2 then
			if arg1.KeyCode == Enum.KeyCode.Escape and v_u23 then
				v_u1.HideInspect()
			end
		end
	end)
	v_u_localplayer.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u23, (ref) v_u1
		if v_u23 then
			v_u1.HideInspect()
		end
	end)
	v_u11.observerRouter("WeaponInspect", function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
		-- upvalues: (ref) v_u1
		v_u1.ShowInspect({
			["_id"] = arg10 or "inspect_" .. arg1 .. "_" .. arg2,
			["Name"] = arg1,
			["Skin"] = arg2,
			["Float"] = arg3,
			["StatTrack"] = arg4,
			["NameTag"] = arg5,
			["Charm"] = arg6,
			["Stickers"] = arg7,
			["Type"] = arg8,
			["Pattern"] = arg9,
			["Serial"] = arg11,
			["IsTradeable"] = arg12
		})
	end)
	v_u11.observerRouter("WeaponInspectClose", function()
		-- upvalues: (ref) v_u1
		v_u1.HideInspect()
	end)
	v_u11.observerRouter("WeaponInspectCloseForGameEnd", function()
		-- upvalues: (ref) v_u1
		v_u1.HideInspect(true)
	end)
	v_u11.observerRouter("IsInspectActive", function()
		-- upvalues: (ref) v_u1
		return v_u1.IsActive()
	end)
	v_u11.observerRouter("GetCurrentCharmPosition", function()
		-- upvalues: (ref) v_u35
		return v_u35
	end)
end
function v_u1.Start() end
return v_u1