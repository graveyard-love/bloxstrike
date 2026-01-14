-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_lighting = game:GetService("Lighting")
local v_u_workspace = game:GetService("Workspace")
local v_players = game:GetService("Players")
local v_u1 = require(v_u_replicatedstorage.Database.Components.GameState)
local v_u2 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u3 = require(v_u_replicatedstorage.Packages.Observers)
local v_u4 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u_localplayer = v_players.LocalPlayer
local v_u5 = {
	["WarmupColorCorrection"] = true,
	["FlashbangColorCorrection"] = true
}
local v6 = {}
local function v_u7()
	-- upvalues: (copy) v_u_lighting, (copy) v_u5
	local v1 = nil
	local v2 = nil
	for _, v3 in ipairs(v_u_lighting:GetDescendants()) do
		if v3:IsA("ColorCorrectionEffect") and not v_u5[v3.Name] then
			if v3.Enabled then
				v1 = v1 or v3
			end
			if not v2 then
				v2 = v3
			end
		end
	end
	return v1 or v2
end
local function v_u8()
	-- upvalues: (copy) v_u_workspace
	local v_current_camera = v_u_workspace.CurrentCamera
	if not v_current_camera then
		return nil
	end
	for _, v1 in ipairs(v_current_camera:GetChildren()) do
		if v1:IsA("Model") and v1:FindFirstChild("Stats") then
			return v1
		end
	end
	for _, v2 in ipairs(v_current_camera:GetDescendants()) do
		if v2:IsA("Model") and v2:FindFirstChild("Stats") then
			return v2
		end
	end
	return nil
end
function v6.Start()
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u4, (copy) v_u_localplayer, (copy) v_u7, (copy) v_u_tween, (copy) v_u2, (copy) v_u_workspace, (copy) v_u8, (copy) v_u1, (copy) v_u3
	local v_assets = v_u_replicatedstorage:FindFirstChild("Assets")
	local v1
	if v_assets then
		v1 = v_assets:FindFirstChild("Warmup")
		if not (v1 and v1:IsA("Folder")) then
			v1 = nil
		end
	else
		v1 = nil
	end
	if v1 then
		local v_u_colorcorrection = v1:FindFirstChild("ColorCorrection")
		local v_u_viewmodelhighlight = v1:FindFirstChild("ViewmodelHighlight")
		if v_u_colorcorrection and v_u_colorcorrection:IsA("ColorCorrectionEffect") then
			if v_u_viewmodelhighlight and v_u_viewmodelhighlight:IsA("Highlight") then
				local v_u2 = 0
				local v_u3 = nil
				local v_u4 = false
				local v_u5 = false
				local function v_u6()
					-- upvalues: (ref) v_u2, (ref) v_u3, (ref) v_u7, (copy) v_u_colorcorrection, (ref) v_u_tween, (ref) v_u2, (ref) v_u_workspace, (ref) v_u8, (copy) v_u_viewmodelhighlight
					v_u2 = v_u2 + 1
					if v_u3 then
						v_u3()
						v_u3 = nil
					end
					local v_u1 = v_u2 + 1
					local v_u2 = false
					local v_u3 = false
					local v_u4 = nil
					local v_u5 = nil
					local v_u6 = v_u7()
					local v_u7 = nil
					local v_u8
					if v_u6 then
						v_u8 = v_u6.Enabled or false
					else
						v_u8 = false
					end
					local v_u9 = v_u6 and {
						["Brightness"] = v_u6.Brightness,
						["Contrast"] = v_u6.Contrast,
						["Saturation"] = v_u6.Saturation,
						["TintColor"] = v_u6.TintColor
					} or nil
					if v_u6 then
						v_u6.Enabled = true
						v_u6.Brightness = v_u_colorcorrection.Brightness
						v_u6.Contrast = v_u_colorcorrection.Contrast
						v_u6.Saturation = v_u_colorcorrection.Saturation
						v_u6.TintColor = v_u_colorcorrection.TintColor
					else
						warn("[WarmupEffectsController] No map ColorCorrectionEffect found under Lighting; warmup CC tween skipped")
					end
					local function v_u10(arg1)
						-- upvalues: (ref) v_u2, (ref) v_u4, (ref) v_u5, (copy) v_u6, (copy) v_u9, (ref) v_u7, (ref) v_u_tween
						if v_u2 then
							return
						elseif arg1 > 0 then
							v_u2 = true
							v_u4 = os.clock()
							v_u5 = arg1
							if v_u6 and v_u9 then
								if v_u7 then
									v_u7:Cancel()
									v_u7 = nil
								end
								local v_create = v_u_tween:Create(v_u6, TweenInfo.new(arg1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["Brightness"] = v_u9.Brightness,
									["Contrast"] = v_u9.Contrast,
									["Saturation"] = v_u9.Saturation,
									["TintColor"] = v_u9.TintColor
								})
								v_u7 = v_create
								v_create:Play()
							end
						end
					end
					local v_u11 = nil
					local v_u12 = nil
					local v_u13 = nil
					local v_u14 = nil
					local v_u15 = nil
					local v_u16 = nil
					local function v_u17(self)
						-- upvalues: (ref) v_u11, (ref) v_u2, (ref) v_u4, (ref) v_u5, (ref) v_u12, (ref) v_u_tween
						if v_u11 then
							return
						elseif v_u2 then
							local v1 = not (v_u2 and (v_u4 and v_u5)) and 0 or math.max(0, v_u5 - (os.clock() - v_u4))
							if v1 <= 0 then
								self.FillTransparency = 1
								self.OutlineTransparency = 1
								self:Destroy()
								if v_u12 == self then
									v_u12 = nil
								end
							else
								local v_create = v_u_tween:Create(self, TweenInfo.new(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									["FillTransparency"] = 1,
									["OutlineTransparency"] = 1
								})
								v_u11 = v_create
								v_create.Completed:Connect(function()
									-- upvalues: (copy) self, (ref) v_u12
									if self.Parent then
										self:Destroy()
									end
									if v_u12 == self then
										v_u12 = nil
									end
								end)
								v_create:Play()
							end
						else
							return
						end
					end
					local function v_u18()
						-- upvalues: (ref) v_u2, (copy) v_u1, (ref) v_u_workspace, (ref) v_u16, (ref) v_u8, (ref) v_u12, (ref) v_u_viewmodelhighlight, (ref) v_u11, (copy) v_u17
						if v_u2 == v_u1 then
							local v_current_camera = v_u_workspace.CurrentCamera
							if v_current_camera then
								local v1 = v_u16
								if not (v1 and v1:IsDescendantOf(v_current_camera)) then
									v1 = v_u8()
									v_u16 = v1
								end
								if v1 then
									local v2 = v_u12
									if not v2 or v2.Parent == nil then
										v2 = v_u_viewmodelhighlight:Clone()
										v_u12 = v2
										v_u11 = nil
									end
									if v2.Parent ~= v1 then
										v2.Parent = v1
									end
									v2.Adornee = v1
									v_u17(v2)
								end
							else
								return
							end
						else
							return
						end
					end
					v_u18()
					local v_u19 = false
					local function v_u20(self)
						-- upvalues: (ref) v_u13, (ref) v_u14, (ref) v_u15, (ref) v_u16, (copy) v_u18, (ref) v_u19, (ref) v_u12, (ref) v_u_viewmodelhighlight, (ref) v_u8
						if v_u13 then
							v_u13:Disconnect()
							v_u13 = nil
						end
						if v_u14 then
							v_u14:Disconnect()
							v_u14 = nil
						end
						if v_u15 then
							v_u15:Disconnect()
							v_u15 = nil
						end
						if self then
							v_u13 = self.ChildAdded:Connect(function()
								-- upvalues: (copy) self, (ref) v_u16, (ref) v_u18
								for _, v1 in ipairs(self:GetChildren()) do
									if v1:IsA("Model") and v1:FindFirstChild("Stats") then
										v_u16 = v1
									end
								end
								v_u18()
							end)
							v_u15 = self.ChildRemoved:Connect(function(arg1)
								-- upvalues: (ref) v_u16, (ref) v_u18
								if v_u16 == arg1 then
									v_u16 = nil
								end
								v_u18()
							end)
							v_u14 = self.DescendantAdded:Connect(function(arg1)
								-- upvalues: (ref) v_u19, (ref) v_u12, (ref) v_u_viewmodelhighlight, (ref) v_u8, (ref) v_u16, (ref) v_u18
								if v_u19 then
									return
								elseif arg1 ~= v_u12 and (not arg1:IsA("Highlight") or arg1.Name ~= v_u_viewmodelhighlight.Name) then
									local v1 = v_u8()
									if v1 then
										v_u16 = v1
									end
									v_u19 = true
									v_u18()
									v_u19 = false
								end
							end)
						end
					end
					v_u20(v_u_workspace.CurrentCamera)
					local v_u_connection = v_u_workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
						-- upvalues: (copy) v_u20, (ref) v_u_workspace, (copy) v_u18
						v_u20(v_u_workspace.CurrentCamera)
						v_u18()
					end)
					local v_u_connection = v_u_workspace:GetAttributeChangedSignal("Timer"):Connect(function()
						-- upvalues: (ref) v_u2, (copy) v_u1, (ref) v_u_workspace, (ref) v_u3, (ref) v_u2, (ref) v_u2, (copy) v_u10, (ref) v_u12, (copy) v_u17, (copy) v_u18
						if v_u2 == v_u1 then
							local v_timer = v_u_workspace:GetAttribute("Timer")
							if typeof(v_timer) == "number" then
								if v_timer > 0 then
									if not v_u3 and v_timer <= 2 then
										v_u3 = true
										v_u2.broadcastRouter("RunRoundSound", "Round Start Countdown")
									end
									if not v_u2 and v_timer <= 3 then
										v_u10((math.min(3, v_timer)))
										local v1 = v_u12
										if v1 then
											v_u17(v1)
											return
										end
										v_u18()
									end
								end
							else
								return
							end
						else
							return
						end
					end)
					local v_timer = v_u_workspace:GetAttribute("Timer")
					if typeof(v_timer) == "number" then
						if v_timer > 0 and (not v_u3 and v_timer <= 2) then
							local _ = true
							v_u2.broadcastRouter("RunRoundSound", "Round Start Countdown")
						end
						if v_timer > 0 and v_timer <= 3 then
							v_u10((math.min(3, v_timer)))
							local v21 = v_u12
							if v21 then
								v_u17(v21)
							else
								v_u18()
							end
						end
					end
					v_u3 = function()
						-- upvalues: (ref) v_u7, (ref) v_u11, (ref) v_u13, (ref) v_u14, (ref) v_u15, (ref) v_u_connection, (ref) v_u_connection, (ref) v_u12, (copy) v_u6, (copy) v_u9, (copy) v_u8
						if v_u7 then
							v_u7:Cancel()
							v_u7 = nil
						end
						if v_u11 then
							v_u11:Cancel()
							v_u11 = nil
						end
						if v_u13 then
							v_u13:Disconnect()
							v_u13 = nil
						end
						if v_u14 then
							v_u14:Disconnect()
							v_u14 = nil
						end
						if v_u15 then
							v_u15:Disconnect()
							v_u15 = nil
						end
						if v_u_connection then
							v_u_connection:Disconnect()
							v_u_connection = nil
						end
						if v_u_connection then
							v_u_connection:Disconnect()
							v_u_connection = nil
						end
						if v_u12 then
							v_u12:Destroy()
							v_u12 = nil
						end
						if v_u6 and v_u9 then
							v_u6.Brightness = v_u9.Brightness
							v_u6.Contrast = v_u9.Contrast
							v_u6.Saturation = v_u9.Saturation
							v_u6.TintColor = v_u9.TintColor
							v_u6.Enabled = v_u8
						end
					end
				end
				v_u1.ListenToState(function(_, arg2)
					-- upvalues: (ref) v_u4, (ref) v_u1, (ref) v_u4, (ref) v_u_localplayer, (ref) v_u5, (copy) v_u6, (ref) v_u2, (ref) v_u3
					v_u4 = arg2 == "Buy Period"
					v_u4 = v_u1.GetState() == "Buy Period"
					local v1
					if v_u4.IsInspectActive() or v_u4.IsCaseSceneActive() then
						v1 = false
					else
						local v_getmenuframe = v_u4.GetMenuFrame()
						if v_getmenuframe and v_getmenuframe.Visible then
							v1 = false
						else
							local v2 = v_u_localplayer:GetAttribute("IsSpectating") == true
							local v3 = v_u_localplayer.Character ~= nil
							v1 = v3 or v2
						end
					end
					if v_u4 and v1 then
						if not v_u5 then
							v_u5 = true
							v_u6()
							return
						end
					elseif v_u5 then
						v_u5 = false
						v_u2 = v_u2 + 1
						if v_u3 then
							v_u3()
							v_u3 = nil
						end
					end
				end)
				v_u4.OnScreenChanged:Connect(function()
					-- upvalues: (ref) v_u1, (ref) v_u4, (ref) v_u4, (ref) v_u_localplayer, (ref) v_u5, (copy) v_u6, (ref) v_u2, (ref) v_u3
					v_u4 = v_u1.GetState() == "Buy Period"
					local v1
					if v_u4.IsInspectActive() or v_u4.IsCaseSceneActive() then
						v1 = false
					else
						local v_getmenuframe = v_u4.GetMenuFrame()
						if v_getmenuframe and v_getmenuframe.Visible then
							v1 = false
						else
							local v2 = v_u_localplayer:GetAttribute("IsSpectating") == true
							local v3 = v_u_localplayer.Character ~= nil
							v1 = v3 or v2
						end
					end
					if v_u4 and v1 then
						if not v_u5 then
							v_u5 = true
							v_u6()
							return
						end
					elseif v_u5 then
						v_u5 = false
						v_u2 = v_u2 + 1
						if v_u3 then
							v_u3()
							v_u3 = nil
						end
					end
				end)
				v_u4.OnInspectStateChanged:Connect(function()
					-- upvalues: (ref) v_u1, (ref) v_u4, (ref) v_u4, (ref) v_u_localplayer, (ref) v_u5, (copy) v_u6, (ref) v_u2, (ref) v_u3
					v_u4 = v_u1.GetState() == "Buy Period"
					local v1
					if v_u4.IsInspectActive() or v_u4.IsCaseSceneActive() then
						v1 = false
					else
						local v_getmenuframe = v_u4.GetMenuFrame()
						if v_getmenuframe and v_getmenuframe.Visible then
							v1 = false
						else
							local v2 = v_u_localplayer:GetAttribute("IsSpectating") == true
							local v3 = v_u_localplayer.Character ~= nil
							v1 = v3 or v2
						end
					end
					if v_u4 and v1 then
						if not v_u5 then
							v_u5 = true
							v_u6()
							return
						end
					elseif v_u5 then
						v_u5 = false
						v_u2 = v_u2 + 1
						if v_u3 then
							v_u3()
							v_u3 = nil
						end
					end
				end)
				v_u4.OnCaseSceneStateChanged:Connect(function()
					-- upvalues: (ref) v_u1, (ref) v_u4, (ref) v_u4, (ref) v_u_localplayer, (ref) v_u5, (copy) v_u6, (ref) v_u2, (ref) v_u3
					v_u4 = v_u1.GetState() == "Buy Period"
					local v1
					if v_u4.IsInspectActive() or v_u4.IsCaseSceneActive() then
						v1 = false
					else
						local v_getmenuframe = v_u4.GetMenuFrame()
						if v_getmenuframe and v_getmenuframe.Visible then
							v1 = false
						else
							local v2 = v_u_localplayer:GetAttribute("IsSpectating") == true
							local v3 = v_u_localplayer.Character ~= nil
							v1 = v3 or v2
						end
					end
					if v_u4 and v1 then
						if not v_u5 then
							v_u5 = true
							v_u6()
							return
						end
					elseif v_u5 then
						v_u5 = false
						v_u2 = v_u2 + 1
						if v_u3 then
							v_u3()
							v_u3 = nil
						end
					end
				end)
				v_u_localplayer.CharacterAdded:Connect(function()
					-- upvalues: (ref) v_u1, (ref) v_u4, (ref) v_u4, (ref) v_u_localplayer, (ref) v_u5, (copy) v_u6, (ref) v_u2, (ref) v_u3
					v_u4 = v_u1.GetState() == "Buy Period"
					local v1
					if v_u4.IsInspectActive() or v_u4.IsCaseSceneActive() then
						v1 = false
					else
						local v_getmenuframe = v_u4.GetMenuFrame()
						if v_getmenuframe and v_getmenuframe.Visible then
							v1 = false
						else
							local v2 = v_u_localplayer:GetAttribute("IsSpectating") == true
							local v3 = v_u_localplayer.Character ~= nil
							v1 = v3 or v2
						end
					end
					if v_u4 and v1 then
						if not v_u5 then
							v_u5 = true
							v_u6()
							return
						end
					elseif v_u5 then
						v_u5 = false
						v_u2 = v_u2 + 1
						if v_u3 then
							v_u3()
							v_u3 = nil
						end
					end
				end)
				v_u_localplayer.CharacterRemoving:Connect(function()
					-- upvalues: (ref) v_u1, (ref) v_u4, (ref) v_u4, (ref) v_u_localplayer, (ref) v_u5, (copy) v_u6, (ref) v_u2, (ref) v_u3
					v_u4 = v_u1.GetState() == "Buy Period"
					local v1
					if v_u4.IsInspectActive() or v_u4.IsCaseSceneActive() then
						v1 = false
					else
						local v_getmenuframe = v_u4.GetMenuFrame()
						if v_getmenuframe and v_getmenuframe.Visible then
							v1 = false
						else
							local v2 = v_u_localplayer:GetAttribute("IsSpectating") == true
							local v3 = v_u_localplayer.Character ~= nil
							v1 = v3 or v2
						end
					end
					if v_u4 and v1 then
						if not v_u5 then
							v_u5 = true
							v_u6()
							return
						end
					elseif v_u5 then
						v_u5 = false
						v_u2 = v_u2 + 1
						if v_u3 then
							v_u3()
							v_u3 = nil
						end
					end
				end)
				v_u3.observeAttribute(v_u_localplayer, "IsSpectating", function()
					-- upvalues: (ref) v_u1, (ref) v_u4, (ref) v_u4, (ref) v_u_localplayer, (ref) v_u5, (copy) v_u6, (ref) v_u2, (ref) v_u3
					v_u4 = v_u1.GetState() == "Buy Period"
					local v1
					if v_u4.IsInspectActive() or v_u4.IsCaseSceneActive() then
						v1 = false
					else
						local v_getmenuframe = v_u4.GetMenuFrame()
						if v_getmenuframe and v_getmenuframe.Visible then
							v1 = false
						else
							local v2 = v_u_localplayer:GetAttribute("IsSpectating") == true
							local v3 = v_u_localplayer.Character ~= nil
							v1 = v3 or v2
						end
					end
					if v_u4 and v1 then
						if not v_u5 then
							v_u5 = true
							v_u6()
						end
					elseif v_u5 then
						v_u5 = false
						v_u2 = v_u2 + 1
						if v_u3 then
							v_u3()
							v_u3 = nil
						end
					end
					return function() end
				end)
				local v7
				if v_u1.GetState() == "Buy Period" then
					v_u4 = true
					v7 = v_u4
				else
					v_u4 = false
					v7 = v_u4
				end
				local v8
				if v_u4.IsInspectActive() or v_u4.IsCaseSceneActive() then
					v8 = false
				else
					local v_getmenuframe = v_u4.GetMenuFrame()
					if v_getmenuframe and v_getmenuframe.Visible then
						v8 = false
					else
						local v9 = v_u_localplayer:GetAttribute("IsSpectating") == true
						local v10 = v_u_localplayer.Character ~= nil
						v8 = v10 or v9
					end
				end
				if v7 and v8 then
					if not v_u5 then
						v_u5 = true
						v_u6()
					end
				elseif v_u5 then
					v_u5 = false
					v_u2 = v_u2 + 1
					if v_u3 then
						v_u3()
						v_u3 = nil
					end
				end
			else
				warn("[WarmupEffectsController] Missing Assets.Warmup.ViewmodelHighlight (Highlight)")
			end
		else
			warn("[WarmupEffectsController] Missing Assets.Warmup.ColorCorrection (ColorCorrectionEffect)")
			return
		end
	else
		warn("[WarmupEffectsController] Missing ReplicatedStorage.Assets.Warmup")
		return
	end
end
return v6