-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_lighting = game:GetService("Lighting")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u3 = require(v_u_replicatedstorage.Components.Common.GetUserPlatform)
local v_u4 = require(v_u_replicatedstorage.Database.Components.GameState)
local v_u5 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u6 = require(v_u_replicatedstorage.Packages.Observers)
local v_u7 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u8 = require(v_u_replicatedstorage.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u_current_camera = workspace.CurrentCamera
local v_u_blureffect = Instance.new("BlurEffect", v_lighting)
v_u_blureffect.Enabled = false
v_u_blureffect.Name = "Menu"
v_u_blureffect.Size = 20
local v_u9 = false
local v_u10 = nil
local v_u11 = nil
local v_u_fromrgb = Color3.fromRGB(255, 255, 255)
local v_u_fromrgb = Color3.fromRGB(150, 220, 239)
local v_u_fromrgb = Color3.fromRGB(175, 175, 175)
local v_u12 = nil
local v_u13 = nil
local function v_u14(arg1, arg2)
	-- upvalues: (copy) v_u_tween
	if arg1:IsA("ImageButton") then
		v_u_tween:Create(arg1, TweenInfo.new(0.15), {
			["ImageColor3"] = arg2
		}):Play()
	elseif arg1:IsA("TextButton") then
		v_u_tween:Create(arg1.TextLabel, TweenInfo.new(0.15), {
			["TextColor3"] = arg2
		}):Play()
	end
end
local function v_u15(self)
	-- upvalues: (copy) v_u_fromrgb, (ref) v_u11, (copy) v_u14, (copy) v_u5, (copy) v_u_fromrgb, (copy) v_u_fromrgb
	if self:IsA("ImageButton") then
		self.ImageColor3 = v_u_fromrgb
	elseif self:IsA("TextButton") then
		self.TextLabel.TextColor3 = v_u_fromrgb
	end
	self.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u11, (copy) self, (ref) v_u14, (ref) v_u_fromrgb
		if v_u11 ~= self then
			v_u14(self, v_u_fromrgb)
		end
	end)
	self.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u5, (ref) v_u11, (copy) self, (ref) v_u14, (ref) v_u_fromrgb
		v_u5.broadcastRouter("RunInterfaceSound", "UI Highlight")
		if v_u11 ~= self then
			v_u14(self, v_u_fromrgb)
		end
	end)
	self.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u11, (copy) self, (ref) v_u14, (ref) v_u_fromrgb, (ref) v_u_fromrgb
		local v1 = v_u11
		v_u11 = self
		if v1 ~= self then
			v_u14(self, v_u_fromrgb)
			if v1 then
				local v_alert = v1:FindFirstChild("Alert")
				v_u14(v1, v_u_fromrgb)
				if v_alert then
					v_alert.Visible = false
					return
				end
			end
		end
	end)
end
function v_u1.UpdateBackground(arg1)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_localplayer, (ref) v_u13, (copy) v_u_current_camera, (copy) v_u2
	if require(v_u_replicatedstorage.Controllers.MenuSceneController).IsActive() then
		return
	elseif not v_u_localplayer:GetAttribute("IsSpectating") then
		local v1 = v_u13.Menu.Visible and (not v_u_localplayer.Character and arg1:FindFirstChild("Cameras"))
		if v1 then
			local v_getchildren = v1:GetChildren()
			assert(v_getchildren[1], "Current map doesnt contain any cameras.")
			v_u_current_camera.CameraType = Enum.CameraType.Scriptable
			v_u_current_camera.CameraSubject = nil
			local v2 = v_getchildren[math.random(1, #v_getchildren)]
			v_u_localplayer.ReplicationFocus = v2
			v_u_current_camera.CFrame = v2.CFrame
			v_u2.updateCameraFOV(80)
		end
	end
end
function v_u1.ToggleMenu()
	-- upvalues: (copy) v_u7, (copy) v_u1, (copy) v_u4, (ref) v_u13, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u8, (ref) v_u10
	if v_u7.IsInspectActive() or v_u7.IsCaseSceneActive() then
		return
	else
		if workspace:FindFirstChild("Map") then
			v_u1.UpdateBackground(workspace:FindFirstChild("Map"))
		end
		local v_getstate = v_u4.GetState()
		if v_getstate and (v_getstate ~= "Map Voting" and v_getstate ~= "Game Ending") then
			if v_u13.Menu.Visible then
				v_u2.disableForceLockOverride()
				if not v_u_localplayer:GetAttribute("IsSpectating") then
					v_u2.setPerspective(true, false)
				end
				v_u7.SetBlurEnabled(false)
				v_u13.Gameplay.Visible = true
				v_u13.Menu.Visible = false
				v_u7.SetScreen(nil)
			else
				if v_u13.Gameplay.Middle.TeamSelection.Visible then
					v_u8.closeFrame()
				end
				v_u2.enableForceLockOverride()
				if not v_u_localplayer:GetAttribute("IsSpectating") then
					v_u2.setPerspective(true, true)
				end
				v_u13.Gameplay.Visible = false
				v_u13.Menu.Visible = true
				if v_u_localplayer.Character then
					v_u1.openFrame("GameDashboard")
				end
				if v_u10 and v_u10.Name ~= "Dashboard" then
					v_u7.SetBlurEnabled(true)
				end
			end
		else
			return
		end
	end
end
function v_u1.openFrame(arg1)
	-- upvalues: (copy) v_u7, (ref) v_u13, (copy) v_u4, (copy) v_u5, (copy) v_u2, (ref) v_u10, (copy) v_u_localplayer, (copy) v_u3, (ref) v_u9
	if v_u7.IsInspectActive() then
		return
	elseif v_u7.IsCaseSceneActive() then
		return
	else
		local v1
		if arg1 == "Dashboard" then
			v1 = false
		else
			v1 = arg1 ~= "Play"
		end
		v_u7.SetBlurEnabled(v1)
		local v_pattern = v_u13.Menu:FindFirstChild("Pattern")
		v_u13.Menu.BackgroundTransparency = v1 and 0.15 or 1
		if v_pattern then
			v_pattern.Visible = not v1
		end
		if arg1 == "Play" then
			local v_getstate = v_u4.GetState()
			if v_getstate and v_getstate ~= "Game Ending" then
				local v2 = nil
				v_u5.broadcastRouter("RunInterfaceSound", "UI Play Click")
				v_u2.resetForceLockOverride()
				v_u2.setPerspective(true, false)
				if v_u10 and v_u10.Name ~= "Dashboard" then
					v_u10.Visible = false
					local v_dashboard = v_u13.Menu:FindFirstChild("Dashboard")
					if v_dashboard then
						v_dashboard.Visible = true
						v_u10 = v_dashboard
					end
				end
				v_u13.Gameplay.Bottom.Visible = false
				v_u13.Gameplay.Visible = true
				v_u13.Menu.Visible = false
				v_u7.SetScreen(nil)
				local v3
				if v_getstate == "Map Voting" then
					v3 = "EndScreen"
				else
					local v_team = v_u_localplayer:GetAttribute("Team")
					v3 = (not v_u_localplayer.Character or (not v_team or v_team == "Spectators")) and "TeamSelection" or v2
				end
				if v3 then
					v_u2.enableForceLockOverride()
					v_u2.setPerspective(true, true)
					for _, v4 in ipairs(v_u13.Gameplay.Middle:GetChildren()) do
						if v4.Name == "Chat" then
							v4.Visible = not table.find(v_u3(), "Mobile")
						else
							v4.Visible = (v4.Name == "Notification" or v4.Name == "Votekick" and v4:GetAttribute("IsVoteKickActive") == true) and true or v4.Name == v3
						end
					end
					return
				end
				v_u13.Gameplay.Middle.TeamSelection.Visible = false
				v_u13.Gameplay.Middle.SessionStats.Visible = true
				v_u13.Gameplay.Middle.Crosshair.Visible = true
				v_u13.Gameplay.Bottom.Visible = true
				if v_u_localplayer.Character then
					v_u2.setPerspective(true, false)
					return
				end
			end
			return
		else
			local v5 = v_u13.Menu:FindFirstChild(arg1)
			if v5 and v5 ~= v_u10 then
				v5.Visible = true
				if v_u10 then
					v_u10.Visible = false
				end
				v_u10 = v5
				local v_setscreen = v_u7.SetScreen
				local v6
				if arg1 == "Dashboard" or (arg1 == "Inventory" or (arg1 == "Loadout" or (arg1 == "Settings" or (arg1 == "Store" or arg1 == "GameDashboard")))) then
					v6 = arg1
				else
					v6 = nil
				end
				v_setscreen(v6)
			end
			if v_u9 then
				v_u5.broadcastRouter("RunInterfaceSound", (("UI %* Click"):format(arg1)))
			else
				v_u9 = arg1 == "Dashboard"
			end
		end
	end
end
function v_u1.CloseTeamSelection()
	-- upvalues: (ref) v_u13, (copy) v_u_blureffect, (copy) v_u1
	v_u13.Gameplay.Middle.TeamSelection.Visible = false
	v_u13.Gameplay.Middle.Crosshair.Visible = true
	v_u13.Gameplay.Bottom.Visible = true
	if v_u_blureffect.Enabled then
		v_u1.UpdateBackground(workspace:FindFirstChild("Map"))
	end
end
function v_u1.ResetToMainMenu()
	-- upvalues: (ref) v_u13, (ref) v_u10, (copy) v_u7, (ref) v_u11, (copy) v_u14, (copy) v_u_fromrgb, (ref) v_u12, (copy) v_u_fromrgb
	for _, v1 in ipairs(v_u13.Menu:GetChildren()) do
		if v1:IsA("Frame") and (v1.Name ~= "Top" and v1.Name ~= "Dashboard") then
			v1.Visible = false
		end
	end
	local v_dashboard = v_u13.Menu:FindFirstChild("Dashboard")
	if v_dashboard then
		v_dashboard.Visible = true
		v_u10 = v_dashboard
	end
	local v_top = v_u13.Menu:FindFirstChild("Top")
	if v_top then
		v_top.Visible = true
	end
	v_u7.SetBlurEnabled(false)
	v_u13.Menu.BackgroundTransparency = 1
	local v_pattern = v_u13.Menu:FindFirstChild("Pattern")
	if v_pattern then
		v_pattern.Visible = true
	end
	v_u7.SetScreen("Dashboard")
	if v_u11 then
		v_u14(v_u11, v_u_fromrgb)
	end
	v_u14(v_u12.Other.Dashboard, v_u_fromrgb)
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u13, (ref) v_u12, (copy) v_u15, (copy) v_u1
	v_u13 = arg1
	for _, v_u1 in ipairs(arg2.Other:GetChildren()) do
		if v_u1:IsA("ImageButton") then
			v_u15(v_u1)
			v_u1.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u1, (copy) v_u1
				v_u1.openFrame(v_u1.Name)
			end)
		end
	end
	for _, v_u2 in ipairs(v_u12.Buttons:GetChildren()) do
		if v_u2:IsA("TextButton") then
			v_u15(v_u2)
			v_u2.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u1, (copy) v_u2
				v_u1.openFrame(v_u2.Name)
			end)
		end
	end
	if workspace:FindFirstChild("Map") then
		v_u1.UpdateBackground(workspace:FindFirstChild("Map"))
	end
	workspace.ChildAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		if arg1.Name == "Map" then
			task.delay(0.25, v_u1.UpdateBackground, arg1)
		end
	end)
end
function v_u1.Start()
	-- upvalues: (ref) v_u11, (ref) v_u12, (copy) v_u14, (copy) v_u_fromrgb, (ref) v_u13, (copy) v_u2, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u7, (copy) v_u6, (copy) v_u4, (copy) v_u5, (copy) v_u_replicatedstorage
	v_u14(v_u12.Other.Dashboard, v_u_fromrgb)
	local v_pattern = v_u13.Menu:FindFirstChild("Pattern")
	v_u13.Menu.BackgroundTransparency = 1
	if v_pattern then
		v_pattern.Visible = false
	end
	if v_u13.Menu.Visible then
		v_u2.enableForceLockOverride()
	end
	v_u1.openFrame("Dashboard")
	v_u_localplayer.CharacterAdded:Connect(function(_)
		-- upvalues: (ref) v_u13, (ref) v_u7, (ref) v_u2
		task.defer(function()
			-- upvalues: (ref) v_u13, (ref) v_u7, (ref) v_u2
			local v_iscasesceneactive = v_u7.IsCaseSceneActive()
			local v_isinspectactive = v_u7.IsInspectActive()
			if not (v_u13.Menu.Visible or (v_u13.Gameplay.Middle.TeamSelection.Visible or (v_iscasesceneactive or v_isinspectactive))) then
				v_u2.resetForceLockOverride()
				v_u2.setPerspective(true, false)
			end
		end)
	end)
	v_u6.observeAttribute(v_u_localplayer, "Team", function(arg1)
		-- upvalues: (ref) v_u1
		if arg1 == "Spectators" then
			v_u1.CloseTeamSelection()
		end
	end)
	v_u4.ListenToState(function(arg1, arg2)
		-- upvalues: (ref) v_u7, (ref) v_u13, (ref) v_u5, (ref) v_u1, (ref) v_u2, (ref) v_u_replicatedstorage, (ref) v_u_localplayer
		if v_u7.IsCaseSceneActive() then
			if arg2 == "Game Ending" or arg2 == "Map Voting" then
				v_u13.Gameplay.Visible = false
				v_u13.Gameplay.Bottom.Visible = false
			end
		else
			if arg2 == "Game Ending" or arg2 == "Map Voting" then
				v_u13.Gameplay.Visible = false
				v_u13.Gameplay.Bottom.Visible = false
				if v_u7.IsInspectActive() then
					v_u5.broadcastRouter("WeaponInspectCloseForGameEnd")
				end
				v_u1.ResetToMainMenu()
				if not v_u13.Menu.Visible then
					v_u2.enableForceLockOverride()
					v_u13.Menu.Visible = true
				end
			end
			if (arg1 == "Game Ending" or arg1 == "Map Voting") and (arg2 ~= "Game Ending" and arg2 ~= "Map Voting") then
				task.defer(function()
					-- upvalues: (ref) v_u_replicatedstorage, (ref) v_u13, (ref) v_u1, (ref) v_u2
					if require(v_u_replicatedstorage.Controllers.MenuSceneController).IsActive() and not v_u13.Menu.Visible then
						v_u1.ResetToMainMenu()
						v_u2.enableForceLockOverride()
						v_u13.Menu.Visible = true
						v_u13.Gameplay.Visible = false
					end
				end)
			end
			if arg2 == "Map Voting" then
				if v_u_localplayer:GetAttribute("FollowGamemode") or v_u_localplayer:GetAttribute("IsSpectating") then
					v_u1.openFrame("Play")
					return
				end
				if not v_u13.Menu.Visible then
					v_u1.openFrame("Dashboard")
					v_u1.ToggleMenu()
				end
			end
		end
	end)
end
return v_u1