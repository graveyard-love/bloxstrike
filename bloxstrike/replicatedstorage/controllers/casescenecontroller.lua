-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_contextaction = game:GetService("ContextActionService")
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_tween = game:GetService("TweenService")
local v_u_lighting = game:GetService("Lighting")
local v_u_run = game:GetService("RunService")
local v_u_maingui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")
require(script:WaitForChild("Types"))
local v2 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u3 = require(v_u_replicatedstorage.Controllers.MenuSceneController)
local v_u4 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u5 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u6 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u7 = require(v_u_replicatedstorage.Database.Custom.Constants)
local v_u_current_camera = workspace.CurrentCamera
local v_u8 = false
local v_u9 = nil
local v_u10 = nil
local v_u11 = nil
local v_u12 = nil
local v_u_new = v2.new()
local v_u13 = false
local v_u14 = nil
local v_u15 = {}
local v_u16 = false
local v_u17 = nil
local v_u18 = nil
local v_u19 = 0
local v_u20 = nil
local v_u21 = {
	["CaseOpening"] = "rbxassetid://100000665946048",
	["CaseFall"] = "rbxassetid://91366765923171",
	["OpenIdle"] = "rbxassetid://127592440292292",
	["CloseIdle"] = "rbxassetid://96896409518629"
}
local v_u22 = {
	["PackOpening"] = "rbxassetid://97837283629886"
}
local v_u23 = nil
local v_u24 = {}
local v_u25 = nil
local v_u26 = {}
local v_u27 = nil
local v_u28 = false
local v_u29 = nil
local v_u30 = nil
local v_u31 = nil
local v_u32 = 0
local v_u33 = 1
local v_u34 = 0
local v_u35 = nil
local v_u36 = false
local v_u37 = false
local function v_u38()
	-- upvalues: (copy) v_u6, (ref) v_u8, (copy) v_u3
	v_u6.EnterCaseScene()
	local v_getmenuframe = v_u6.GetMenuFrame()
	if v_getmenuframe then
		v_u8 = v_u3.IsActive()
		if v_u8 then
			v_u3.HideMenuScene(true, true)
			v_u3.SetMusicVolumeMultiplier(0.5, 0.5)
		end
		v_u6.SetBlurEnabled(false)
		v_getmenuframe.BackgroundTransparency = 1
		local v_pattern = v_getmenuframe:FindFirstChild("Pattern")
		if v_pattern then
			v_pattern.Visible = false
		end
		local v_top = v_getmenuframe:FindFirstChild("Top")
		if v_top then
			v_top.Visible = false
		end
		local v_store = v_getmenuframe:FindFirstChild("Store")
		if v_store then
			v_store.Visible = true
		end
		for _, v1 in ipairs(v_getmenuframe:GetChildren()) do
			if v1:IsA("Frame") and (v1.Name ~= "Top" and (v1.Name ~= "Store" and v1.Name ~= "OpenCase")) then
				v1.Visible = false
			end
		end
	end
end
local function v_u39(arg1)
	-- upvalues: (ref) v_u15
	for _, v1 in ipairs(arg1:GetDescendants()) do
		if v1:IsA("BasePart") then
			if v1.Transparency < 1 then
				v1:SetAttribute("_CaseScenePrevTransparency", v1.Transparency)
				v1.Transparency = 1
			end
		elseif v1:IsA("SurfaceGui") and v1.Enabled then
			v1:SetAttribute("_CaseScenePrevSurfaceGuiEnabled", true)
			v1.Enabled = false
		end
	end
	table.insert(v_u15, arg1)
end
local function v_u40()
	-- upvalues: (ref) v_u15, (copy) v_u_current_camera, (copy) v_u39
	v_u15 = {}
	for _, v1 in ipairs(v_u_current_camera:GetChildren()) do
		if v1:IsA("Model") and (v1.Name ~= "CaseScene" and (v1.Name ~= "CharmScene" and v1.Name ~= "PackScene")) then
			v_u39(v1)
		end
	end
end
local function v_u41()
	-- upvalues: (ref) v_u15
	for _, v1 in ipairs(v_u15) do
		if v1 and v1.Parent then
			for _, v2 in ipairs(v1:GetDescendants()) do
				if v2:IsA("BasePart") then
					local v_getattribute = v2:GetAttribute("_CaseScenePrevTransparency")
					if v_getattribute ~= nil then
						v2.Transparency = v_getattribute
						v2:SetAttribute("_CaseScenePrevTransparency", nil)
					end
				elseif v2:IsA("SurfaceGui") and v2:GetAttribute("_CaseScenePrevSurfaceGuiEnabled") ~= nil then
					v2.Enabled = true
					v2:SetAttribute("_CaseScenePrevSurfaceGuiEnabled", nil)
				end
			end
		end
	end
	v_u15 = {}
end
local function v_u42()
	-- upvalues: (copy) v_u6, (ref) v_u8, (copy) v_u3
	local v_getmenuframe = v_u6.GetMenuFrame()
	if v_getmenuframe and v_getmenuframe.Visible then
		local v_getscreenbeforecasescene = v_u6.GetScreenBeforeCaseScene()
		v_u8 = false
		v_u6.ExitCaseScene()
		if v_u8 then
			v_u3.ShowMenuScene()
			v_u3.SetMusicVolumeMultiplier(1, 0.5)
		else
			v_u3.ApplyMapLighting()
		end
		local v_top = v_getmenuframe:FindFirstChild("Top")
		if v_top then
			v_top.Visible = true
		end
		if v_getscreenbeforecasescene then
			local v1 = v_getmenuframe:FindFirstChild(v_getscreenbeforecasescene)
			if v1 then
				v1.Visible = true
				local v2
				if v_getscreenbeforecasescene == "Dashboard" then
					v2 = false
				else
					v2 = v_getscreenbeforecasescene ~= "Play"
				end
				v_u6.SetBlurEnabled(v2)
				v_getmenuframe.BackgroundTransparency = v2 and 0.15 or 1
				local v_pattern = v_getmenuframe:FindFirstChild("Pattern")
				if v_pattern then
					v_pattern.Visible = not v2
					return
				end
			end
		else
			local v_dashboard = v_getmenuframe:FindFirstChild("Dashboard")
			if v_dashboard then
				v_dashboard.Visible = true
			end
			v_u6.SetBlurEnabled(false)
			v_getmenuframe.BackgroundTransparency = 1
			local v_pattern = v_getmenuframe:FindFirstChild("Pattern")
			if v_pattern then
				v_pattern.Visible = true
			end
		end
	else
		v_u8 = false
		v_u6.ExitCaseScene()
		v_u3.ApplyMapLighting()
	end
end
local function v_u43(arg1, arg2)
	-- upvalues: (copy) v_u_replicatedstorage
	local v_casemod = arg1:FindFirstChild("CaseMod")
	if v_casemod and v_casemod:GetAttribute("IsDynamicModel") then
		v_casemod:Destroy()
	end
	local v_casemodels = v_u_replicatedstorage.Assets:FindFirstChild("CaseModels")
	if v_casemodels then
		local v1 = v_casemodels:FindFirstChild(arg2)
		if v1 then
			local v_clone = v1:Clone()
			v_clone.Name = "CaseMod"
			v_clone:SetAttribute("IsDynamicModel", true)
			local v_casepivot = arg1:FindFirstChild("CasePivot")
			if v_casepivot then
				v_clone:PivotTo(v_casepivot.CFrame)
				v_clone.Parent = arg1
				return v_clone
			else
				warn("[CaseSceneController]: CasePivot not found in CaseScene")
				v_clone.Parent = arg1
				return v_clone
			end
		else
			warn("[CaseSceneController]: Case model not found for case: " .. arg2)
			return nil
		end
	else
		warn("[CaseSceneController]: CaseModels folder not found in ReplicatedStorage.Assets")
		return nil
	end
end
local function v_u44(arg1)
	-- upvalues: (ref) v_u11, (ref) v_u10, (ref) v_u9
	local v1 = nil
	if v_u11 == "Charm" and v_u10 then
		v1 = v_u10
	elseif v_u9 then
		v1 = v_u9
	end
	if v1 then
		local v_camera = v1:FindFirstChild("Camera")
		if v_camera then
			if arg1 == "Inspecting" then
				return v_camera:FindFirstChild("Inspecting")
			elseif arg1 == "Unboxing" then
				return v_camera:FindFirstChild("Unboxing")
			else
				return nil
			end
		else
			return nil
		end
	else
		return nil
	end
end
local function v_u45(arg1, arg2)
	-- upvalues: (ref) v_u23, (copy) v_u21, (ref) v_u24
	local v_casemod = arg1:FindFirstChild("CaseMod")
	if v_casemod then
		local v_animationcontroller = (arg2 or v_casemod):FindFirstChildOfClass("AnimationController")
		if v_animationcontroller then
			local v_animator = v_animationcontroller:FindFirstChildOfClass("Animator")
			if not v_animator then
				v_animator = Instance.new("Animator")
				v_animator.Parent = v_animationcontroller
			end
			v_u23 = v_animator
			for v1, v2 in pairs(v_u21) do
				local v_animation = Instance.new("Animation")
				v_animation.AnimationId = v2
				v_u24[v1] = v_animator:LoadAnimation(v_animation)
				v_animation:Destroy()
			end
		else
			warn("[CaseSceneController]: AnimationController not found in CaseMod")
		end
	else
		warn("[CaseSceneController]: CaseMod not found in CaseScene")
		return
	end
end
local function v_u46(arg1)
	-- upvalues: (ref) v_u25, (copy) v_u22, (ref) v_u26
	local v_pack = arg1:FindFirstChild("Pack")
	if v_pack then
		local v_animationcontroller = v_pack:FindFirstChildOfClass("AnimationController")
		if v_animationcontroller then
			local v_animator = v_animationcontroller:FindFirstChildOfClass("Animator")
			if not v_animator then
				v_animator = Instance.new("Animator")
				v_animator.Parent = v_animationcontroller
			end
			v_u25 = v_animator
			for v1, v2 in pairs(v_u22) do
				local v_animation = Instance.new("Animation")
				v_animation.AnimationId = v2
				v_u26[v1] = v_animator:LoadAnimation(v_animation)
				v_animation:Destroy()
			end
		else
			warn("[CaseSceneController]: AnimationController not found in Pack")
		end
	else
		warn("[CaseSceneController]: Pack not found in CharmScene")
		return
	end
end
local function v_u47()
	-- upvalues: (ref) v_u9
	if v_u9 then
		local v_casemod = v_u9:FindFirstChild("CaseMod")
		if v_casemod then
			local v_idleeffect = v_casemod:FindFirstChild("IdleEffect")
			if v_idleeffect then
				for _, v1 in ipairs(v_idleeffect:GetDescendants()) do
					if v1:IsA("Beam") or v1:IsA("ParticleEmitter") then
						v1.Enabled = true
					end
				end
			end
			local v_openingeffect = v_casemod:FindFirstChild("OpeningEffect")
			if v_openingeffect then
				for _, v2 in ipairs(v_openingeffect:GetDescendants()) do
					if v2:IsA("Beam") or v2:IsA("ParticleEmitter") then
						v2.Enabled = false
					end
				end
			end
			local v_effectspart = v_casemod:FindFirstChild("EffectsPart")
			if v_effectspart then
				for _, v3 in ipairs(v_effectspart:GetDescendants()) do
					if v3:IsA("Beam") or v3:IsA("ParticleEmitter") then
						v3.Enabled = true
					end
				end
			end
		end
	else
		return
	end
end
local function v_u48()
	-- upvalues: (ref) v_u9
	if v_u9 then
		local v_casemod = v_u9:FindFirstChild("CaseMod")
		if v_casemod then
			local v_idleeffect = v_casemod:FindFirstChild("IdleEffect")
			if v_idleeffect then
				for _, v1 in ipairs(v_idleeffect:GetDescendants()) do
					if v1:IsA("Beam") or v1:IsA("ParticleEmitter") then
						v1.Enabled = false
					end
				end
			end
			local v_openingeffect = v_casemod:FindFirstChild("OpeningEffect")
			if v_openingeffect then
				for _, v2 in ipairs(v_openingeffect:GetDescendants()) do
					if v2:IsA("Beam") or v2:IsA("ParticleEmitter") then
						v2.Enabled = false
					end
				end
			end
			local v_effectspart = v_casemod:FindFirstChild("EffectsPart")
			if v_effectspart then
				for _, v3 in ipairs(v_effectspart:GetDescendants()) do
					if v3:IsA("Beam") or v3:IsA("ParticleEmitter") then
						v3.Enabled = false
					end
				end
			end
		end
	else
		return
	end
end
local function v_u49()
	-- upvalues: (ref) v_u9
	if v_u9 then
		local v_casemod = v_u9:FindFirstChild("CaseMod")
		if v_casemod then
			local v_openingeffect = v_casemod:FindFirstChild("OpeningEffect")
			if v_openingeffect then
				for _, v1 in ipairs(v_openingeffect:GetDescendants()) do
					if v1:IsA("Beam") or v1:IsA("ParticleEmitter") then
						v1.Enabled = true
					end
				end
			end
			local v_idleeffect = v_casemod:FindFirstChild("IdleEffect")
			if v_idleeffect then
				for _, v2 in ipairs(v_idleeffect:GetDescendants()) do
					if v2:IsA("Beam") or v2:IsA("ParticleEmitter") then
						v2.Enabled = false
					end
				end
			end
		end
	else
		return
	end
end
local function v_u50()
	-- upvalues: (ref) v_u24, (copy) v_u47, (copy) v_u5, (ref) v_u9, (copy) v_u_new
	if v_u24.CaseFall and v_u24.CloseIdle then
		v_u47()
		local v_casefall = v_u24.CaseFall
		v_u_new:Add((v_casefall:GetMarkerReachedSignal("Dropped"):Connect(function()
			-- upvalues: (ref) v_u5, (ref) v_u9
			v_u5.broadcastRouter("RunStoreSound", "Case Fall")
			local v1 = v_u9 and v_u9:FindFirstChild("DropParticle")
			if v1 then
				for _, v2 in ipairs(v1:GetChildren()) do
					if v2:IsA("ParticleEmitter") then
						local v_emitcount = v2:GetAttribute("EmitCount")
						if typeof(v_emitcount) == "number" and v_emitcount > 0 then
							v2:Emit(v_emitcount)
						end
					end
				end
			end
		end)))
		v_casefall:Play()
		v_u24.CloseIdle.Looped = true
		v_u24.CloseIdle:Play()
	end
end
local function v_u51()
	-- upvalues: (ref) v_u24, (copy) v_u5, (copy) v_u49
	if v_u24.CaseOpening and v_u24.OpenIdle then
		if v_u24.CloseIdle then
			v_u24.CloseIdle:Stop()
		end
		v_u5.broadcastRouter("RunStoreSound", "Case Opening")
		v_u49()
		v_u24.CaseOpening:Play()
		v_u24.OpenIdle.Looped = true
		v_u24.OpenIdle:Play()
	end
end
local function v_u52()
	-- upvalues: (ref) v_u24, (ref) v_u26, (ref) v_u27
	for _, v1 in pairs(v_u24) do
		if v1.IsPlaying then
			v1:Stop()
		end
	end
	for _, v2 in pairs(v_u26) do
		if v2.IsPlaying then
			v2:Stop()
		end
	end
	if v_u27 then
		v_u27:Stop()
		v_u27:Destroy()
		v_u27 = nil
	end
end
local function v_u53()
	-- upvalues: (ref) v_u27, (ref) v_u31, (ref) v_u35, (copy) v_u_maingui, (ref) v_u26, (ref) v_u29, (copy) v_u5
	if v_u27 then
		v_u27:Stop()
	end
	v_u31 = nil
	if v_u35 then
		v_u35.Enabled = false
	end
	local v_cameraperspective = v_u_maingui:FindFirstChild("CameraPerspective")
	if v_cameraperspective then
		v_cameraperspective.Interactable = true
	end
	local v_u_packopening = v_u26.PackOpening
	if v_u_packopening then
		v_u5.broadcastRouter("RunStoreSound", "Charm Drag Loop")
		if not v_u_packopening.IsPlaying then
			v_u_packopening:Play()
		end
		v_u_packopening:AdjustSpeed(1)
		v_u_packopening.Looped = false
		local v_max = math.max(0, v_u_packopening.Length - v_u_packopening.TimePosition - 0.1)
		task.delay(v_max, function()
			-- upvalues: (copy) v_u_packopening, (ref) v_u29
			if v_u_packopening.IsPlaying then
				v_u_packopening:AdjustSpeed(0)
				v_u_packopening.TimePosition = v_u_packopening.Length * 0.99
				if v_u29 then
					v_u29 = nil
					v_u29()
				end
			end
		end)
	elseif v_u29 then
		v_u29 = nil
		v_u29()
	end
end
local function v_u54(arg1, arg2)
	-- upvalues: (ref) v_u26, (ref) v_u34, (ref) v_u28, (copy) v_u53, (ref) v_u27, (ref) v_u31, (ref) v_u32
	local v_packopening = v_u26.PackOpening
	if v_packopening then
		local v_clamp = math.clamp(arg1, 0, 1)
		local v1
		if v_u34 > 0 then
			v1 = v_u34
		else
			v1 = v_packopening.Length
		end
		local v2 = v1 * v_clamp
		if not v_packopening.IsPlaying then
			v_packopening:Play()
			v_packopening:AdjustSpeed(0)
		end
		v_packopening.TimePosition = v2
		if v_clamp >= 1 then
			v_u28 = false
			v_u53()
		end
		if v_u27 and arg2 then
			local v3 = not v_u31 and 0 or (arg2 - v_u31).Magnitude
			v_u31 = arg2
			if v3 > 0.001 then
				v_u32 = tick()
				if not v_u27.IsPlaying then
					v_u27:Play()
				end
				v_u27.PlaybackSpeed = math.clamp(v3 * 20, 0, 0.7) + 0.8
			end
		end
	end
end
local function v_u55(arg1)
	-- upvalues: (ref) v_u10, (copy) v_u_contextaction, (ref) v_u36, (ref) v_u29, (ref) v_u28, (ref) v_u30, (ref) v_u33, (ref) v_u26, (ref) v_u34, (copy) v_u_maingui, (ref) v_u35, (copy) v_u_new, (ref) v_u37, (copy) v_u_run, (ref) v_u31, (ref) v_u32, (ref) v_u27, (copy) v_u_replicatedstorage, (copy) v_u53, (copy) v_u54, (copy) v_u_userinput, (ref) v_u13, (ref) v_u14, (copy) v_u5
	if v_u10 then
		local v_u_pack = v_u10:FindFirstChild("Pack")
		if v_u_pack then
			local v_u_drag = v_u_pack:FindFirstChild("Drag")
			if v_u_drag then
				local v_u_dragdetector = v_u_drag:FindFirstChildOfClass("DragDetector")
				if v_u_dragdetector then
					v_u_contextaction:UnbindAction("Fire")
					v_u_contextaction:UnbindAction("Secondary Fire")
					v_u36 = true
					v_u29 = arg1
					v_u28 = false
					v_u30 = v_u_drag.Position
					if v_u_dragdetector.MaxDragTranslation.Magnitude <= 0 then
						v_u33 = 1
					end
					local v_u_packopening = v_u26.PackOpening
					if v_u_packopening then
						local v1, v2 = pcall(function()
							-- upvalues: (copy) v_u_packopening
							return v_u_packopening:GetTimeOfKeyframe("DragEndPoint")
						end)
						if v1 and v2 then
							v_u34 = v2
						else
							v_u34 = v_u_packopening.Length
							warn("[CaseSceneController]: DragEndPoint keyframe not found, using full animation length")
						end
					end
					v_u_dragdetector.Enabled = true
					local v_cameraperspective = v_u_maingui:FindFirstChild("CameraPerspective")
					if v_cameraperspective then
						v_cameraperspective.Interactable = false
					end
					local v_surfacegui = v_u_drag:FindFirstChildOfClass("SurfaceGui")
					if v_surfacegui then
						v_surfacegui.Enabled = true
						v_u35 = v_surfacegui
						local v_frame = v_surfacegui:FindFirstChildOfClass("Frame")
						local v_u3 = v_frame and v_frame:FindFirstChildOfClass("ImageLabel")
						if v_u3 then
							v_u_new:Add(v_frame.MouseEnter:Connect(function()
								-- upvalues: (ref) v_u37, (copy) v_u3
								v_u37 = true
								v_u3.ImageTransparency = 1
							end), "Disconnect", "CharmImageHoverEnter")
							v_u_new:Add(v_frame.MouseLeave:Connect(function()
								-- upvalues: (ref) v_u37, (copy) v_u3
								v_u37 = false
								v_u3.ImageTransparency = 0
							end), "Disconnect", "CharmImageHoverLeave")
							local v_u4 = 0
							v_u_new:Add(v_u_run.RenderStepped:Connect(function(arg1)
								-- upvalues: (ref) v_u37, (ref) v_u4, (copy) v_u3
								if not v_u37 then
									v_u3.ImageTransparency = (math.sin(v_u4 + arg1 * 2) + 1) / 2 * 0.2
								end
							end), "Disconnect", "CharmImageBreathing")
						end
					end
					v_u_new:Add(v_u_dragdetector.DragStart:Connect(function()
						-- upvalues: (ref) v_u28, (ref) v_u31, (copy) v_u_drag, (ref) v_u32, (ref) v_u27, (ref) v_u_replicatedstorage, (copy) v_u_pack, (ref) v_u_new
						warn("CharmDragStart")
						v_u28 = true
						v_u31 = v_u_drag.Position
						v_u32 = tick()
						if not v_u27 then
							local v_charm drag start = require(v_u_replicatedstorage.Database.Audio.Store)["Charm Drag Start"]
							if v_charm drag start and (v_charm drag start.Identifiers and v_charm drag start.Identifiers[1]) then
								local v_sound = Instance.new("Sound")
								v_sound.Name = "CharmDragProgress"
								v_sound.SoundId = "rbxassetid://" .. v_charm drag start.Identifiers[1]
								v_sound.Volume = v_charm drag start.Properties.Volume or 1
								v_sound.Looped = true
								v_sound.PlaybackSpeed = 0.8
								v_sound.Parent = v_u_pack
								v_u27 = v_sound
								v_u_new:Add(v_sound, "Destroy")
							end
						end
					end), "Disconnect", "CharmDragStart")
					v_u_new:Add(v_u_run.Heartbeat:Connect(function()
						-- upvalues: (ref) v_u28, (ref) v_u27, (ref) v_u32
						if v_u28 and (v_u27 and (v_u27.IsPlaying and tick() - v_u32 > 0.05)) then
							v_u27:Stop()
						end
					end), "Disconnect", "CharmDragSoundCheck")
					v_u_new:Add(v_u_dragdetector.DragContinue:Connect(function()
						-- upvalues: (ref) v_u28, (ref) v_u30, (copy) v_u_drag, (ref) v_u33, (copy) v_u_dragdetector, (ref) v_u53, (ref) v_u54
						if v_u28 and v_u30 then
							local v_clamp = math.clamp((v_u_drag.Position - v_u30).Magnitude / v_u33, 0, 1)
							if v_clamp >= 0.5 then
								v_u28 = false
								v_u_dragdetector.Enabled = false
								if v_u30 then
									v_u_drag.Position = v_u30
								end
								v_u53()
							else
								v_u54(v_clamp, v_u_drag.Position)
							end
						else
							return
						end
					end), "Disconnect", "CharmDragContinue")
					v_u_new:Add(v_u_dragdetector.DragEnd:Connect(function()
						-- upvalues: (ref) v_u28, (ref) v_u27, (copy) v_u_drag, (ref) v_u30, (ref) v_u33, (copy) v_u_dragdetector, (ref) v_u53, (ref) v_u26, (ref) v_u31
						if v_u28 then
							v_u28 = false
							if v_u27 then
								v_u27:Stop()
							end
							local v_clamp = math.clamp((v_u_drag.Position - v_u30).Magnitude / v_u33, 0, 1)
							if v_u30 then
								v_u_drag.Position = v_u30
							end
							if v_clamp >= 0.8 then
								v_u_dragdetector.Enabled = false
								v_u53()
								return
							end
							local v_packopening = v_u26.PackOpening
							if v_packopening then
								v_packopening.TimePosition = 0
							end
							v_u31 = nil
						end
					end), "Disconnect", "CharmDragEnd")
					v_u_new:Add(v_u_userinput.InputBegan:Connect(function(arg1, arg2)
						-- upvalues: (ref) v_u13, (ref) v_u14, (copy) v_u_dragdetector, (ref) v_u28, (ref) v_u30, (copy) v_u_drag, (ref) v_u27, (ref) v_u5, (ref) v_u53
						if arg2 then
							if (arg1.KeyCode == Enum.KeyCode.ButtonX or arg1.KeyCode == Enum.KeyCode.ButtonA) and (v_u13 and v_u14 == "Unboxing") then
								v_u_dragdetector.Enabled = false
								if v_u28 then
									v_u28 = false
									if v_u30 then
										v_u_drag.Position = v_u30
									end
								end
								if v_u27 then
									v_u27:Stop()
								end
								v_u5.broadcastRouter("RunStoreSound", "Charm Drag Start")
								v_u53()
							end
						end
					end), "Disconnect", "CharmControllerSkip")
				else
					warn("[CaseSceneController]: DragDetector not found on Drag part")
				end
			else
				warn("[CaseSceneController]: Drag part not found in Pack")
				return
			end
		else
			warn("[CaseSceneController]: Pack not found in CharmScene")
			return
		end
	else
		return
	end
end
function v_u1.ShowCaseScene(arg1, arg2)
	-- upvalues: (ref) v_u13, (ref) v_u11, (ref) v_u12, (ref) v_u10, (ref) v_u9, (ref) v_u14, (copy) v_u_current_camera, (copy) v_u38, (ref) v_u8, (copy) v_u3, (copy) v_u_lighting, (copy) v_u40, (copy) v_u_new, (copy) v_u39, (copy) v_u43, (copy) v_u46, (copy) v_u45, (copy) v_u50, (copy) v_u4, (copy) v_u_run, (ref) v_u16, (ref) v_u17, (ref) v_u18, (ref) v_u19, (copy) v_u_tween, (ref) v_u20, (copy) v_u44, (copy) v_u48, (ref) v_u36, (copy) v_u5, (ref) v_u28, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u33, (ref) v_u34, (ref) v_u35, (ref) v_u37, (copy) v_u52, (ref) v_u24, (ref) v_u26, (ref) v_u23, (ref) v_u25
	if v_u13 then
		return
	else
		local v1 = arg1 or "Case"
		v_u11 = v1
		v_u12 = arg2
		if v1 == "Charm" then
			local v_charmscene = workspace:FindFirstChild("CharmScene")
			if not v_charmscene then
				warn("[CaseSceneController]: CharmScene not found in workspace")
				v_u11 = nil
				v_u12 = nil
				return
			end
			v_u10 = v_charmscene
			local v_pack = v_charmscene:FindFirstChild("Pack")
			if v_pack then
				local v_drag = v_pack:FindFirstChild("Drag")
				local v2 = v_drag and v_drag:FindFirstChildOfClass("SurfaceGui")
				if v2 then
					v2.Enabled = false
				end
			end
		elseif v1 == "Pack" then
			local v_packscene = workspace:FindFirstChild("PackScene")
			if not v_packscene then
				warn("[CaseSceneController]: PackScene not found in workspace")
				v_u11 = nil
				v_u12 = nil
				return
			end
			v_u9 = v_packscene
		else
			local v_casescene = workspace:FindFirstChild("CaseScene")
			if not v_casescene then
				warn("[CaseSceneController]: CaseScene not found in workspace")
				v_u11 = nil
				v_u12 = nil
				return
			end
			v_u9 = v_casescene
		end
		v_u14 = "Inspecting"
		local v3 = nil
		if v_u11 == "Charm" and v_u10 then
			v3 = v_u10
		elseif v_u9 then
			v3 = v_u9
		end
		local v4
		if v3 then
			local v_camera = v3:FindFirstChild("Camera")
			if v_camera then
				v4 = v_camera:FindFirstChild("Inspecting")
			else
				v4 = nil
			end
		else
			v4 = nil
		end
		if v4 then
			v_u_current_camera.CameraType = Enum.CameraType.Scriptable
			v_u_current_camera.CFrame = v4.CFrame
			v_u_current_camera.Focus = v4.CFrame
			v_u38()
			if not v_u8 then
				v_u3.ApplyMenuSceneLighting()
			end
			local v5 = v_u9 or v_u10
			if v5 then
				local v_casefog = v5:FindFirstChild("CaseFog", true)
				if v_casefog and v_casefog:IsA("Atmosphere") then
					for _, v6 in ipairs(v_u_lighting:GetChildren()) do
						if v6:IsA("Atmosphere") then
							v6:Destroy()
						end
					end
					v_casefog:Clone().Parent = v_u_lighting
				end
			end
			v_u_current_camera.CameraType = Enum.CameraType.Scriptable
			v_u_current_camera.CFrame = v4.CFrame
			v_u_current_camera.Focus = v4.CFrame
			v_u40()
			v_u_new:Add(v_u_current_camera.ChildAdded:Connect(function(arg1)
				-- upvalues: (ref) v_u39
				if arg1:IsA("Model") and (arg1.Name ~= "CaseScene" and (arg1.Name ~= "CharmScene" and arg1.Name ~= "PackScene")) then
					v_u39(arg1)
				end
			end), "Disconnect", "ViewmodelListener")
			local v7
			if arg2 and v_u9 then
				v7 = v_u43(v_u9, arg2)
			else
				v7 = nil
			end
			if v1 == "Charm" and v_u10 then
				v_u46(v_u10)
			elseif v_u9 then
				v_u45(v_u9, v7)
				v_u50()
			end
			v_u4.updateCameraFOV(50)
			v_u4.enableForceLockOverride()
			v_u_run:BindToRenderStep("CaseSceneCameraUpdate", Enum.RenderPriority.Camera.Value + 10, function()
				-- upvalues: (ref) v_u11, (ref) v_u10, (ref) v_u9, (ref) v_u_current_camera, (ref) v_u16, (ref) v_u17, (ref) v_u18, (ref) v_u19, (ref) v_u_tween, (ref) v_u20, (ref) v_u44, (ref) v_u14
				local v1 = v_u11 == "Charm" and v_u10 or v_u11 == "Case" and v_u9
				if not v1 then
					if v_u11 == "Pack" then
						v1 = v_u9
					else
						v1 = false
					end
				end
				if v1 then
					v_u_current_camera.CameraType = Enum.CameraType.Scriptable
					if v_u16 and (v_u17 and v_u18) then
						local v_min = math.min((tick() - v_u19) / 0.8, 1)
						v_u_current_camera.CFrame = v_u17:Lerp(v_u18, (v_u_tween:GetValue(v_min, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)))
						v_u_current_camera.Focus = v_u_current_camera.CFrame
						if v_min >= 1 then
							v_u16 = false
							v_u_current_camera.CFrame = v_u18
							if v_u20 then
								v_u20 = nil
								v_u20()
							end
							v_u17 = nil
							v_u18 = nil
							return
						end
					else
						local v2 = v_u44(v_u14)
						if v2 then
							v_u_current_camera.CFrame = v2.CFrame
							v_u_current_camera.Focus = v2.CFrame
						end
					end
				end
			end)
			v_u_new:Add(function()
				-- upvalues: (ref) v_u_run
				v_u_run:UnbindFromRenderStep("CaseSceneCameraUpdate")
			end, true, "CameraUpdate")
			v_u_new:Add(function()
				-- upvalues: (ref) v_u14, (ref) v_u11, (ref) v_u12, (ref) v_u16, (ref) v_u17, (ref) v_u18, (ref) v_u20, (ref) v_u48, (ref) v_u36, (ref) v_u5, (ref) v_u28, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u33, (ref) v_u34, (ref) v_u35, (ref) v_u37, (ref) v_u9, (ref) v_u52, (ref) v_u24, (ref) v_u26, (ref) v_u23, (ref) v_u25
				v_u14 = nil
				v_u11 = nil
				v_u12 = nil
				v_u16 = false
				v_u17 = nil
				v_u18 = nil
				v_u20 = nil
				v_u48()
				if v_u36 then
					v_u5.broadcastRouter("RebindKeybinds")
					v_u36 = false
				end
				v_u28 = false
				v_u29 = nil
				v_u30 = nil
				v_u31 = nil
				v_u32 = 0
				v_u33 = 1
				v_u34 = 0
				v_u35 = nil
				v_u37 = false
				if v_u9 then
					local v_casemod = v_u9:FindFirstChild("CaseMod")
					if v_casemod and v_casemod:GetAttribute("IsDynamicModel") then
						v_casemod:Destroy()
					end
				end
				v_u52()
				v_u24 = {}
				v_u26 = {}
				v_u23 = nil
				v_u25 = nil
			end, true, "CaseSceneCleanup")
			v_u13 = true
		else
			warn("[CaseSceneController]: Scene missing Camera.Inspecting")
			v_u9 = nil
			v_u10 = nil
			v_u14 = nil
			v_u11 = nil
		end
	end
end
function v_u1.TransitionToUnboxing(self)
	-- upvalues: (ref) v_u11, (ref) v_u10, (ref) v_u9, (ref) v_u13, (ref) v_u14, (copy) v_u51, (copy) v_u44, (copy) v_u_current_camera, (ref) v_u16, (ref) v_u17, (ref) v_u18, (ref) v_u19, (ref) v_u20, (copy) v_u55
	local v1 = v_u11 == "Charm" and v_u10 or v_u11 == "Case" and v_u9
	if not v1 then
		if v_u11 == "Pack" then
			v1 = v_u9
		else
			v1 = false
		end
	end
	if v_u13 and v1 then
		if v_u14 == "Unboxing" then
			return
		else
			local v2 = nil
			if v_u11 == "Charm" and v_u10 then
				v2 = v_u10
			elseif v_u9 then
				v2 = v_u9
			end
			local v3
			if v2 then
				local v_camera = v2:FindFirstChild("Camera")
				if v_camera then
					v3 = v_camera:FindFirstChild("Unboxing")
				else
					v3 = nil
				end
			else
				v3 = nil
			end
			if v3 then
				if v_u11 == "Case" or v_u11 == "Pack" then
					v_u51()
					local v4 = v_u44(v_u14)
					local v5
					if v4 then
						v5 = v4.CFrame
					else
						v5 = v_u_current_camera.CFrame
					end
					v_u16 = true
					v_u17 = v5
					v_u18 = v3.CFrame
					v_u19 = tick()
					v_u20 = self
				elseif v_u11 == "Charm" then
					local function v6()
						-- upvalues: (ref) v_u55, (copy) self
						v_u55(self)
					end
					local v7 = v_u44(v_u14)
					local v8
					if v7 then
						v8 = v7.CFrame
					else
						v8 = v_u_current_camera.CFrame
					end
					v_u16 = true
					v_u17 = v8
					v_u18 = v3.CFrame
					v_u19 = tick()
					v_u20 = v6
				end
				v_u14 = "Unboxing"
			else
				warn("[CaseSceneController]: Scene missing Camera.Unboxing")
			end
		end
	else
		return
	end
end
function v_u1.TransitionToInspecting(arg1)
	-- upvalues: (ref) v_u11, (ref) v_u10, (ref) v_u9, (ref) v_u13, (ref) v_u14, (copy) v_u44, (copy) v_u_current_camera, (ref) v_u16, (ref) v_u17, (ref) v_u18, (ref) v_u19, (ref) v_u20
	local v1 = v_u11 == "Charm" and v_u10 or v_u11 == "Case" and v_u9
	if not v1 then
		if v_u11 == "Pack" then
			v1 = v_u9
		else
			v1 = false
		end
	end
	if v_u13 and v1 then
		if v_u14 == "Inspecting" then
			return
		else
			local v2 = nil
			if v_u11 == "Charm" and v_u10 then
				v2 = v_u10
			elseif v_u9 then
				v2 = v_u9
			end
			local v3
			if v2 then
				local v_camera = v2:FindFirstChild("Camera")
				if v_camera then
					v3 = v_camera:FindFirstChild("Inspecting")
				else
					v3 = nil
				end
			else
				v3 = nil
			end
			if v3 then
				local v4 = v_u44(v_u14)
				local v5
				if v4 then
					v5 = v4.CFrame
				else
					v5 = v_u_current_camera.CFrame
				end
				v_u16 = true
				v_u17 = v5
				v_u18 = v3.CFrame
				v_u19 = tick()
				v_u20 = arg1
				v_u14 = "Inspecting"
			else
				warn("[CaseSceneController]: Scene missing Camera.Inspecting")
			end
		end
	else
		return
	end
end
function v_u1.HideCaseScene()
	-- upvalues: (ref) v_u13, (copy) v_u_new, (copy) v_u_current_camera, (copy) v_u4, (copy) v_u7, (copy) v_u42, (copy) v_u41, (ref) v_u9, (ref) v_u10, (ref) v_u11, (ref) v_u12, (ref) v_u14
	if v_u13 then
		v_u_new:Cleanup()
		v_u_current_camera.CameraType = Enum.CameraType.Custom
		v_u4.updateCameraFOV(v_u7.DEFAULT_CAMERA_FOV)
		v_u4.disableForceLockOverride()
		v_u42()
		v_u41()
		v_u9 = nil
		v_u10 = nil
		v_u11 = nil
		v_u12 = nil
		v_u13 = false
		v_u14 = nil
	end
end
function v_u1.IsActive()
	-- upvalues: (ref) v_u13
	return v_u13
end
function v_u1.GetCurrentState()
	-- upvalues: (ref) v_u14
	return v_u14
end
function v_u1.GetSceneType()
	-- upvalues: (ref) v_u11
	return v_u11
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_userinput, (ref) v_u13, (copy) v_u1, (copy) v_u5
	local v_u_assets = v_u_replicatedstorage:FindFirstChild("Assets")
	if v_u_assets then
		local function v1(arg1, arg2)
			-- upvalues: (copy) v_u_assets
			local v1 = v_u_assets:FindFirstChild(arg1)
			if not v1 then
				return
			end
			local v2 = nil
			for _, v3 in ipairs(v1:GetChildren()) do
				if v3:IsA("Model") then
					v2 = v3
					break
				end
			end
			if v2 then
				local v_clone = v2:Clone()
				v_clone.Name = arg2
				v_clone.Parent = workspace
			else
				warn("[CaseSceneController]: No model found inside ReplicatedStorage.Assets." .. arg1)
			end
		end
		v1("CaseScene", "CaseScene")
		v1("CharmScene", "CharmScene")
		v1("PackScene", "PackScene")
		v_u_userinput.InputBegan:Connect(function(arg1, arg2)
			-- upvalues: (ref) v_u13, (ref) v_u1
			if not arg2 then
				if arg1.KeyCode == Enum.KeyCode.Escape and v_u13 then
					v_u1.HideCaseScene()
				end
			end
		end)
		v_u5.observerRouter("CaseSceneShow", function(arg1, arg2)
			-- upvalues: (ref) v_u1
			v_u1.ShowCaseScene(arg1, arg2)
		end)
		v_u5.observerRouter("PackSceneShow", function()
			-- upvalues: (ref) v_u1
			v_u1.ShowCaseScene("Pack")
		end)
		v_u5.observerRouter("CaseSceneUnboxing", function(arg1)
			-- upvalues: (ref) v_u1
			v_u1.TransitionToUnboxing(arg1)
		end)
		v_u5.observerRouter("CaseSceneClose", function()
			-- upvalues: (ref) v_u1
			v_u1.HideCaseScene()
		end)
	else
		warn("[CaseSceneController]: Assets folder not found in ReplicatedStorage")
	end
end
function v_u1.Start() end
return v_u1