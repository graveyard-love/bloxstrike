-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u3 = require(v_u_replicatedstorage.Database.Components.GameState)
local v_u4 = require(v_u_replicatedstorage.Components.Common.GetTimerFormat)
local v_u5 = require(v_u_replicatedstorage.Components.Common.GetUserPlatform)
local v_u6 = require(v_u_replicatedstorage.Packages.Observers)
local v_u7 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u8 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u_localplayer = v_u_players.LocalPlayer
local v_u9 = false
local v_u10 = 0
local v_u11 = nil
local v_u12 = nil
local function v_u13(arg1, arg2)
	-- upvalues: (copy) v_u_players
	local v1 = 0
	for _, v2 in ipairs(v_u_players:GetPlayers()) do
		if v2 ~= arg2 and v2:GetAttribute("Team") == arg1 then
			v1 = v1 + 1
		end
	end
	return v1
end
local function v_u14(self)
	-- upvalues: (copy) v_u_tween
	self.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self
		v_u_tween:Create(self, TweenInfo.new(0.1), {
			["BackgroundTransparency"] = 0.85
		}):Play()
	end)
	self.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self
		v_u_tween:Create(self, TweenInfo.new(0.1), {
			["BackgroundTransparency"] = 1
		}):Play()
	end)
end
function v_u1.ToggleTeamSelection()
	-- upvalues: (ref) v_u11, (copy) v_u1
	if v_u11.Visible then
		v_u1.closeFrame()
	else
		v_u1.openFrame()
	end
end
function v_u1.openFrame()
	-- upvalues: (copy) v_u8, (ref) v_u11, (copy) v_u_replicatedstorage, (ref) v_u12, (copy) v_u2, (ref) v_u9, (copy) v_u_localplayer, (copy) v_u5
	if v_u8.IsCaseSceneActive() or v_u8.IsInspectActive() then
		return
	elseif not v_u11.Visible then
		local v1 = require(v_u_replicatedstorage.Controllers.MenuSceneController)
		if v1.IsActive() then
			v1.HideMenuScene(true, false)
		end
		if v_u12.Menu.Visible then
			v_u2.disableForceLockOverride()
			v_u8.SetBlurEnabled(false)
		end
		local v_buymenu = v_u12.Gameplay.Middle:FindFirstChild("BuyMenu")
		if v_buymenu and v_buymenu.Visible or false then
			require(v_u_replicatedstorage.Interface.Screens.Gameplay.Middle.BuyMenu).closeFrame()
		end
		v_u2.enableForceLockOverride()
		if not v_u_localplayer:GetAttribute("IsSpectating") then
			v_u2.setPerspective(true, true)
		end
		v_u12.Gameplay.Bottom.Visible = false
		v_u12.Gameplay.Visible = true
		v_u12.Menu.Visible = false
		for _, v2 in ipairs(v_u12.Gameplay.Middle:GetChildren()) do
			local v_find = table.find(v_u5(), "Mobile")
			if v2.Name == "Chat" then
				v2.Visible = not v_find
			elseif v2.Name == "MobileButtons" then
				local v_character = v_u_localplayer.Character
				if v_character and v_character:IsDescendantOf(workspace) then
					v2.Visible = v_find
				else
					v2.Visible = false
				end
			else
				v2.Visible = v2.Name == "Notification" and true or v2.Name == "TeamSelection"
			end
		end
	end
end
function v_u1.closeFrame()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (ref) v_u11, (ref) v_u12, (copy) v_u5, (ref) v_u9, (copy) v_u_replicatedstorage
	v_u2.disableForceLockOverride()
	if not v_u_localplayer:GetAttribute("IsSpectating") then
		v_u2.setPerspective(true, false)
	end
	v_u11.Visible = false
	v_u12.Gameplay.Middle.Crosshair.Visible = true
	v_u12.Gameplay.Bottom.Visible = true
	local v_find = table.find(v_u5(), "Mobile")
	local v_character = v_u_localplayer.Character
	for _, v1 in ipairs(v_u12.Gameplay.Middle:GetChildren()) do
		local v2
		if v_character then
			v2 = v_character:IsDescendantOf(workspace)
		else
			v2 = v_character
		end
		local v_name = v1.Name
		if v_name == "Chat" then
			v1.Visible = not v_find
		elseif v_name == "MobileButtons" then
			v1.Visible = v_find and v2 and v2 or false
		elseif v_name == "Votekick" then
			v1.Visible = v1:GetAttribute("IsVoteKickActive") == true
		elseif v_name == "Notification" or v_name == "SessionStats" then
			v1.Visible = true
		elseif v_name == "Radar" or v_name == "Crosshair" then
			v1.Visible = v2
		else
			v1.Visible = false
		end
	end
	if v_u9 then
		local v3 = require(v_u_replicatedstorage.Interface.Screens.Gameplay.Middle.BuyMenu)
		v_u9 = false
		v3.openFrame()
	end
end
function v_u1.chooseTeam(arg1)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u1, (copy) v_u13, (ref) v_u10, (copy) v_u7
	if v_u_localplayer:GetAttribute("Team") == arg1 then
		v_u1.closeFrame()
		return
	end
	local v1 = v_u_localplayer
	local v2 = v_u13("Counter-Terrorists", v1)
	local v_terrorists = v_u13("Terrorists", v1)
	local v3
	if arg1 == "Terrorists" then
		if v_terrorists >= v2 then
			::l6::
			v3 = arg1 == "Spectators" and true or v2 == v_terrorists
			goto l8
		end
		v3 = true
	else
		if arg1 ~= "Counter-Terrorists" or v2 >= v_terrorists then
			goto l6
		end
		v3 = true
	end
	::l8::
	if v3 and tick() - v_u10 >= 1 then
		v_u7.TeamSelection.SelectTeam.Send(arg1)
		v_u10 = tick()
	end
end
function v_u1.createTeamButtonAnimation(arg1, arg2)
	-- upvalues: (ref) v_u11
	local v_u1 = v_u11:FindFirstChild(arg2)
	if v_u1 then
		arg1.MouseEnter:Connect(function()
			-- upvalues: (copy) v_u1, (copy) arg2
			local v_outline = v_u1.Icon.Outline
			local v1 = arg2 == "Counter-Terrorists" and Color3.fromRGB(165, 183, 212)
			if not v1 then
				if arg2 == "Terrorists" then
					v1 = Color3.fromRGB(219, 199, 126)
				else
					v1 = false
				end
			end
			v_outline.ImageColor3 = v1
			local v_icon = v_u1.Icon.Team.Icon
			local v2 = arg2 == "Counter-Terrorists" and Color3.fromRGB(255, 255, 255)
			if not v2 then
				if arg2 == "Terrorists" then
					v2 = Color3.fromRGB(255, 255, 255)
				else
					v2 = false
				end
			end
			v_icon.ImageColor3 = v2
			local v_team = v_u1.Icon.Team
			local v3 = arg2 == "Counter-Terrorists" and Color3.fromRGB(36, 41, 47)
			if not v3 then
				if arg2 == "Terrorists" then
					v3 = Color3.fromRGB(89, 79, 50)
				else
					v3 = false
				end
			end
			v_team.ImageColor3 = v3
			v_u1.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.14375), NumberSequenceKeypoint.new(0.318, 1), NumberSequenceKeypoint.new(1, 1) })
			for _, v4 in ipairs(v_u1.Container:GetChildren()) do
				if v4:IsA("Frame") then
					local v5 = arg2 == "Counter-Terrorists" and Color3.fromRGB(126, 140, 187)
					if not v5 then
						if arg2 == "Terrorists" then
							v5 = Color3.fromRGB(219, 188, 110)
						else
							v5 = false
						end
					end
					v4.BackgroundColor3 = v5
					local v_uistroke = v4.Player.UIStroke
					local v6 = arg2 == "Counter-Terrorists" and Color3.fromRGB(165, 183, 212)
					if not v6 then
						if arg2 == "Terrorists" then
							v6 = Color3.fromRGB(219, 199, 126)
						else
							v6 = false
						end
					end
					v_uistroke.Color = v6
					v4.Player.Avatar.ImageColor3 = Color3.fromRGB(255, 255, 255)
				end
			end
		end)
		arg1.MouseLeave:Connect(function()
			-- upvalues: (copy) v_u1, (copy) arg2
			local v_outline = v_u1.Icon.Outline
			local v1 = arg2 == "Counter-Terrorists" and Color3.fromRGB(107, 119, 138)
			if not v1 then
				if arg2 == "Terrorists" then
					v1 = Color3.fromRGB(127, 115, 73)
				else
					v1 = false
				end
			end
			v_outline.ImageColor3 = v1
			local v_icon = v_u1.Icon.Team.Icon
			local v2 = arg2 == "Counter-Terrorists" and Color3.fromRGB(131, 131, 131)
			if not v2 then
				if arg2 == "Terrorists" then
					v2 = Color3.fromRGB(182, 182, 182)
				else
					v2 = false
				end
			end
			v_icon.ImageColor3 = v2
			local v_team = v_u1.Icon.Team
			local v3 = arg2 == "Counter-Terrorists" and Color3.fromRGB(20, 24, 27)
			if not v3 then
				if arg2 == "Terrorists" then
					v3 = Color3.fromRGB(58, 51, 33)
				else
					v3 = false
				end
			end
			v_team.ImageColor3 = v3
			v_u1.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.14375), NumberSequenceKeypoint.new(0.183193, 1), NumberSequenceKeypoint.new(1, 1) })
			for _, v4 in ipairs(v_u1.Container:GetChildren()) do
				if v4:IsA("Frame") then
					local v5 = arg2 == "Counter-Terrorists" and Color3.fromRGB(109, 121, 140)
					if not v5 then
						if arg2 == "Terrorists" then
							v5 = Color3.fromRGB(131, 111, 66)
						else
							v5 = false
						end
					end
					v4.BackgroundColor3 = v5
					local v_uistroke = v4.Player.UIStroke
					local v6 = arg2 == "Counter-Terrorists" and Color3.fromRGB(50, 56, 65)
					if not v6 then
						if arg2 == "Terrorists" then
							v6 = Color3.fromRGB(94, 85, 54)
						else
							v6 = false
						end
					end
					v_uistroke.Color = v6
					v4.Player.Avatar.ImageColor3 = Color3.fromRGB(138, 138, 138)
				end
			end
		end)
	end
end
function v_u1.updatePlayerList(arg1, arg2)
	-- upvalues: (ref) v_u11, (copy) v_u_replicatedstorage, (copy) v_u_players, (copy) v_u13
	local v_team = arg1:GetAttribute("Team")
	if v_team == "Counter-Terrorists" or v_team == "Terrorists" then
		local v1 = v_u11:FindFirstChild(tostring(arg1.UserId), true)
		if v1 then
			v1:Destroy()
		end
		local v2 = v_u_replicatedstorage.Assets.UI.TeamSelection:FindFirstChild(v_team)
		if v2 and not arg2 then
			local v3 = v_u11:WaitForChild(v_team)
			local _, v4 = pcall(function()
				-- upvalues: (ref) v_u_players, (copy) arg1
				return v_u_players:GetUserThumbnailAsync(arg1.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			end)
			local v_clone = v2:Clone()
			v_clone.Parent = v3.Container
			v_clone.Team.Text = arg1.DisplayName
			v_clone.Player.Avatar.Image = v4
			v_clone.Name = tostring(arg1.UserId)
			v_clone.Visible = true
		end
	else
		local v5 = v_u11:FindFirstChild(tostring(arg1.UserId), true)
		if v5 then
			v5:Destroy()
		end
	end
	v_u11["Counter-Terrorists"].Players.Text = ("%* Player(s)"):format((v_u13("Counter-Terrorists")))
	v_u11.Terrorists.Players.Text = ("%* Player(s)"):format((v_u13("Terrorists")))
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u11, (ref) v_u12, (copy) v_u6, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u3, (copy) v_u4
	v_u11 = arg2
	v_u12 = arg1
	v_u6.observePlayer(function(self)
		-- upvalues: (ref) v_u1, (ref) v_u6, (ref) v_u_localplayer, (ref) v_u11
		v_u1.updatePlayerList(self)
		local v_u_observeattribute = v_u6.observeAttribute(self, "Team", function(_)
			-- upvalues: (ref) v_u1, (copy) self, (ref) v_u_localplayer, (ref) v_u11
			v_u1.updatePlayerList(self)
			if v_u_localplayer == self then
				v_u1.closeFrame()
			end
			return function()
				-- upvalues: (ref) v_u11, (ref) self
				local v1 = v_u11:FindFirstChild(tostring(self.UserId), true)
				if v1 then
					v1:Destroy()
				end
			end
		end)
		return function()
			-- upvalues: (ref) v_u1, (copy) self, (copy) v_u_observeattribute
			v_u1.updatePlayerList(self, true)
			v_u_observeattribute()
		end
	end)
	v_u6.observeAttribute(v_u_localplayer, "Team", function(_)
		-- upvalues: (ref) v_u3, (ref) v_u1
		if v_u3.GetState() == "Round In Progress" then
			v_u1.closeFrame()
		end
	end)
	v_u6.observeAttribute(workspace, "Timer", function(arg1)
		-- upvalues: (ref) v_u11, (ref) v_u4
		v_u11.ProgressBar.Timer.Text = v_u4(arg1)
	end)
end
function v_u1.Start()
	-- upvalues: (ref) v_u11, (copy) v_u1, (copy) v_u14, (copy) v_u_localplayer, (copy) v_u13
	local v_button = v_u11["Counter-Terrorists"].Button
	local v_u1 = "Counter-Terrorists"
	v_button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1, (copy) v_u1
		v_u1.chooseTeam(v_u1)
	end)
	v_u1.createTeamButtonAnimation(v_button, "Counter-Terrorists")
	local v_spectate = v_u11.Bottom.Buttons.Spectate
	local v_u_spectators = "Spectators"
	v_spectate.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1, (copy) v_u_spectators
		v_u1.chooseTeam(v_u_spectators)
	end)
	v_u14(v_spectate)
	local v_button = v_u11.Terrorists.Button
	local v_u_terrorists = "Terrorists"
	v_button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1, (copy) v_u_terrorists
		v_u1.chooseTeam(v_u_terrorists)
	end)
	v_u1.createTeamButtonAnimation(v_button, "Terrorists")
	v_u14(v_u11.Bottom.Buttons.AutoSelect)
	v_u11.Bottom.Buttons.AutoSelect.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1, (ref) v_u_localplayer, (ref) v_u13
		local v_chooseteam = v_u1.chooseTeam
		local v1 = v_u_localplayer
		local v2 = v_u13("Counter-Terrorists", v1)
		local v_terrorists = v_u13("Terrorists", v1)
		local v3
		if v2 == v_terrorists then
			local v_team = v1:GetAttribute("Team")
			v3 = v_team == "Counter-Terrorists" and "Terrorists" or (v_team == "Terrorists" and "Counter-Terrorists" or "Terrorists")
		else
			v3 = v2 < v_terrorists and "Counter-Terrorists" or "Terrorists"
		end
		v_chooseteam(v3)
	end)
end
return v_u1