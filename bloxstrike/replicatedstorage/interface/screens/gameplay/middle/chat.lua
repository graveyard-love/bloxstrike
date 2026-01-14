-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_run = game:GetService("RunService")
local v_u_players = game:GetService("Players")
local v_u_textchat = game:GetService("TextChatService")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_u_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u3 = require(v_u_replicatedstorage.Controllers.InputController)
local v_u4 = require(v_u_replicatedstorage.Interface.Screens.Gameplay.Middle.BuyMenu)
local v_u5 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u6 = require(v_u_replicatedstorage.Database.Components.Common.Roblox.CanPlayerUseChatService)
local v_u7 = require(v_u_replicatedstorage.Components.Common.GetUserPlatform)
local v_u8 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u9 = require(v_u_replicatedstorage.Database.Custom.GameStats.UI.Chat.ChatModes)
local v_u10 = require(v_u_replicatedstorage.Database.Custom.GameStats.UI.Chat.Platforms)
local v_u11 = require(v_u_replicatedstorage.Database.Custom.GameStats.UI.Chat.HTML)
local v_u12 = require(v_u_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u13 = nil
local v_u14 = nil
local v_u15 = { v_u10.PC }
local v_u_all = v_u9.Modes.All
local v_u16 = false
local v_u17 = false
local v_u18 = {}
local v_u19 = {}
local function v_u20()
	-- upvalues: (ref) v_u15, (copy) v_u10, (copy) v_u3
	return table.find(v_u15, v_u10.Mobile) and "Tap to chat" or ((table.find(v_u15, v_u10.Console) or table.find(v_u15, v_u10.VR)) and "" or string.format("Team Chat (%s) | All Chat (%s)", v_u3.GetActionKeybind("Team Message") or "U", v_u3.GetActionKeybind("Chat Message") or "Y"))
end
local function v_u21(self)
	-- upvalues: (ref) v_u17, (copy) v_u_run
	if self.frame and self.frame.Parent then
		if v_u17 then
			return
		elseif not self.fadeConnection and self.frame.Message.TextTransparency < 1 then
			local v_u_texttransparency = self.frame.Message.TextTransparency
			local v_u_clock = os.clock()
			local v_u1 = nil
			v_u1 = v_u_run.Heartbeat:Connect(function()
				-- upvalues: (copy) self, (ref) v_u1, (ref) v_u17, (copy) v_u_clock, (copy) v_u_texttransparency
				if self.frame and self.frame.Parent then
					if v_u17 then
						v_u1:Disconnect()
						self.fadeConnection = nil
						self.frame.Message.TextTransparency = 0
					else
						local v_min = math.min((os.clock() - v_u_clock) / 3, 1)
						self.frame.Message.TextTransparency = v_u_texttransparency + (1 - v_u_texttransparency) * v_min
						if v_min >= 1 then
							v_u1:Disconnect()
							self.fadeConnection = nil
						end
					end
				else
					v_u1:Disconnect()
					self.fadeConnection = nil
					return
				end
			end)
			self.fadeConnection = v_u1
		end
	else
		return
	end
end
local function v_u22(arg1)
	-- upvalues: (ref) v_u17, (ref) v_u14, (copy) v_u20, (copy) v_u18, (copy) v_u21
	v_u17 = arg1
	v_u14.Chat.ScrollingFrame.ScrollBarImageTransparency = arg1 and 0 or 1
	v_u14.Chat.BackgroundTransparency = arg1 and 0.55 or 1
	v_u14.Type.BackgroundTransparency = arg1 and 0.55 or 1
	v_u14.BackgroundTransparency = arg1 and 0.55 or 1
	v_u14.Type.TextBox.PlaceholderColor3 = arg1 and Color3.fromRGB(141, 141, 141) or Color3.new(1, 1, 1)
	if not arg1 then
		v_u14.Type.TextBox.PlaceholderText = v_u20()
	end
	local v_clock = os.clock()
	for _, v1 in ipairs(v_u18) do
		if arg1 then
			if v1.fadeConnection then
				v1.fadeConnection:Disconnect()
				v1.fadeConnection = nil
			end
			v1.frame.Message.TextTransparency = 0
		elseif v_clock - v1.timestamp > 10 then
			v1.frame.Message.TextTransparency = 1
		else
			task.delay(10 - UNNAMED_1729005889096, v_u21, v1)
		end
	end
end
local function v_u23(arg1)
	-- upvalues: (copy) v_u18, (ref) v_u17, (copy) v_u21, (ref) v_u14
	local v1 = #v_u18 >= 15 and v_u18[15]
	if v1 then
		v1.frame:Destroy()
		table.remove(v_u18, 15)
	end
	table.insert(v_u18, 1, arg1)
	for v2, v3 in ipairs(v_u18) do
		v3.frame.LayoutOrder = #v_u18 - v2
	end
	arg1.frame.Message.TextTransparency = 0
	if not v_u17 then
		task.delay(10, v_u21, arg1)
	end
	arg1.frame.Parent = v_u14.Chat.ScrollingFrame
	task.defer(function()
		-- upvalues: (ref) v_u14
		v_u14.Chat.ScrollingFrame.CanvasPosition = Vector2.new(0, v_u14.Chat.ScrollingFrame.AbsoluteCanvasSize.Y)
	end)
end
local function v_u24()
	-- upvalues: (ref) v_u16, (copy) v_u19, (ref) v_u13, (copy) v_u23
	if not v_u16 and #v_u19 ~= 0 then
		local v1 = 0
		v_u16 = true
		while #v_u19 > 0 and v1 < 2 do
			local v_remove = table.remove(v_u19, 1)
			if v_remove then
				local v_clone = v_u13:Clone()
				v_clone.Message.Text = v_remove.text
				v_u23({
					["frame"] = v_clone,
					["timestamp"] = v_remove.timestamp,
					["text"] = v_remove.text,
					["fadeConnection"] = nil
				})
				v1 = v1 + 1
			end
		end
		v_u16 = false
	end
end
function v_u1.OpenChat(arg1)
	-- upvalues: (ref) v_u17, (copy) v_u6, (copy) v_u_localplayer, (ref) v_u15, (copy) v_u10, (copy) v_u4, (ref) v_u_all, (ref) v_u14, (copy) v_u9, (copy) v_u22, (copy) v_u2
	if v_u17 then
		return
	elseif v_u6(v_u_localplayer) then
		if not table.find(v_u15, v_u10.Mobile) then
			v_u4.closeFrame()
			v_u_all = arg1
			v_u14.Visible = true
			v_u14.Type.TextBox.PlaceholderText = v_u9.Labels[arg1]
			v_u14.Type.TextBox.TextTransparency = 0
			v_u14.Type.TextBox.Text = ""
			v_u22(true)
			v_u2.setMouseEnabled(true)
			v_u_localplayer:SetAttribute("IsPlayerChatting", true)
			v_u14.Type.TextBox:CaptureFocus()
			task.delay(0, function()
				-- upvalues: (ref) v_u14
				v_u14.Type.TextBox.Text = ""
			end)
		end
	else
		return
	end
end
function v_u1.ProcessChatData(arg1, arg2)
	-- upvalues: (copy) v_u11, (copy) v_u19, (ref) v_u16, (copy) v_u24
	local v1 = not (arg1.role and v_u11.Roles[arg1.role]) and "" or v_u11.Roles[arg1.role]
	local v2
	if arg2 then
		v2 = v_u11.Prefixes.Team
	else
		v2 = v_u11.Prefixes.All
	end
	local v_format = string.format(v_u11.TeamColors[arg1.team] or "", arg1.displayName)
	table.insert(v_u19, {
		["text"] = v1 .. v2 .. v_format .. (not arg1.verified and "" or v_u11.Badges.Verified .. " ") .. (arg1.alive and "" or v_u11.Suffixes.Dead) .. ": " .. arg1.message,
		["timestamp"] = os.clock()
	})
	if not v_u16 then
		v_u24()
	end
end
function v_u1.ProcessTeamJoin(arg1, arg2)
	-- upvalues: (copy) v_u11, (copy) v_u19, (ref) v_u16, (copy) v_u24
	if v_u11.TeamJoinMessages[arg2] then
		table.insert(v_u19, {
			["text"] = string.format(UNNAMED_1728998831048, arg1),
			["timestamp"] = os.clock()
		})
		if not v_u16 then
			v_u24()
		end
	end
end
function v_u1.ProcessPlayerLeave(arg1)
	-- upvalues: (copy) v_u11, (copy) v_u19, (ref) v_u16, (copy) v_u24
	table.insert(v_u19, {
		["text"] = string.format(v_u11.PlayerLeave, arg1),
		["timestamp"] = os.clock()
	})
	if not v_u16 then
		v_u24()
	end
end
function v_u1.ProcessKillMessage(arg1)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u11, (copy) v_u19, (ref) v_u16, (copy) v_u24
	if arg1.Killer == v_u_localplayer.UserId then
		table.insert(v_u19, {
			["text"] = string.format(v_u11.Points.Deathmatch, 11, arg1.Weapon),
			["timestamp"] = os.clock()
		})
		if not v_u16 then
			v_u24()
		end
	end
end
function v_u1.ProcessMoneyReward(arg1)
	-- upvalues: (copy) v_u11, (copy) v_u19, (ref) v_u16, (copy) v_u24
	if v_u11.Money[arg1.source] then
		local v1 = tonumber(arg1.amount)
		if v1 then
			if arg1.source == "Kill" and arg1.weaponName then
				table.insert(v_u19, {
					["text"] = string.format(UNNAMED_1728994291720, tostring(v1), arg1.weaponName, (arg1.weaponName == "Knife" or v1 > 300) and " (bonus)" or ""),
					["timestamp"] = os.clock()
				})
				if not v_u16 then
					v_u24()
				end
			else
				local v_abs = math.abs(v1)
				table.insert(v_u19, {
					["text"] = string.format(UNNAMED_1728994291720, (tostring(v_abs))),
					["timestamp"] = os.clock()
				})
				if not v_u16 then
					v_u24()
				end
			end
		else
			return
		end
	else
		return
	end
end
function v_u1.ProcessCaseOpened(arg1)
	-- upvalues: (copy) v_u11, (copy) v_u12, (copy) v_u19, (ref) v_u16, (copy) v_u24
	local v1 = v_u11.TeamColors[arg1.team] or ""
	local v_gsub = arg1.displayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
	local v2
	if v1 == "" then
		v2 = v_gsub .. " "
	else
		v2 = string.format(v1, v_gsub)
	end
	local v_color = (v_u12[arg1.rarity] or v_u12.Stock).Color
	local v_floor = math.floor(v_color.R * 255 + 0.5)
	local v_floor = math.floor(v_color.G * 255 + 0.5)
	local v_floor = math.floor(v_color.B * 255 + 0.5)
	local v_format = string.format("rgb(%d,%d,%d)", v_floor, v_floor, v_floor)
	local v_gsub = arg1.weaponName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
	local v_gsub = arg1.skinName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
	table.insert(v_u19, {
		["text"] = v2 .. "<font color=\"rgb(255,255,255)\">opened a case and found: </font>" .. string.format("<font color=\"%s\">%s</font>", v_format, (arg1.statTrak and "KillTrak\226\132\162 " or "") .. v_gsub .. " | " .. v_gsub),
		["timestamp"] = os.clock()
	})
	if not v_u16 then
		v_u24()
	end
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u14, (ref) v_u15, (copy) v_u7, (ref) v_u13, (ref) v_u17, (copy) v_u4, (copy) v_u_localplayer, (copy) v_u22, (copy) v_u9, (ref) v_u_all, (copy) v_u5, (copy) v_u2, (copy) v_u_textchat, (copy) v_u6, (copy) v_u10
	v_u14 = arg2
	v_u15 = v_u7()
	v_u13 = v_u14.Chat.ScrollingFrame.Template
	v_u13.Message.RichText = true
	v_u13.Parent = nil
	for _, v1 in ipairs(v_u14.Chat.ScrollingFrame:GetChildren()) do
		if v1:IsA("Frame") then
			v1:Destroy()
		end
	end
	v_u14.Type.TextBox.ClearTextOnFocus = false
	v_u14.Type.TextBox.Focused:Connect(function()
		-- upvalues: (ref) v_u17, (ref) v_u14, (ref) v_u4, (ref) v_u_localplayer, (ref) v_u22, (ref) v_u9, (ref) v_u_all
		if v_u17 then
			v_u4.closeFrame()
			v_u_localplayer:SetAttribute("IsPlayerChatting", true)
			v_u14.Type.TextBox.TextTransparency = 0
			v_u22(true)
			task.delay(0, function()
				-- upvalues: (ref) v_u14
				v_u14.Type.TextBox.Text = ""
			end)
			if v_u9.Labels[v_u_all] then
				v_u14.Type.TextBox.PlaceholderText = v_u9.Labels[v_u_all]
			end
		else
			v_u14.Type.TextBox:ReleaseFocus()
		end
	end)
	v_u14.Type.TextBox.FocusLost:Connect(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u5, (ref) v_u2, (ref) v_u14, (ref) v_u_all, (ref) v_u9, (ref) v_u_textchat, (ref) v_u22
		v_u_localplayer:SetAttribute("IsPlayerChatting", nil)
		local v_maingui = v_u_localplayer.PlayerGui:FindFirstChild("MainGui")
		if v_maingui then
			v_maingui = v_u_localplayer.PlayerGui.MainGui:FindFirstChild("Menu")
		end
		if v_maingui then
			v_maingui = v_maingui.Visible
		end
		if not (v_maingui or (v_u5.IsCaseSceneActive() or v_u5.IsInspectActive())) then
			v_u2.setMouseEnabled(false)
		end
		if arg1 and string.len(v_u14.Type.TextBox.Text) > 0 then
			local v_text = v_u14.Type.TextBox.Text
			if #v_text <= 100 and #v_text > 0 then
				local v1
				if v_u_localplayer.Character and v_u_localplayer.Character:FindFirstChild("Humanoid") then
					v1 = v_u_localplayer.Character:FindFirstChild("Humanoid").Health > 0
				else
					v1 = false
				end
				local v_team = v_u_localplayer:GetAttribute("Team")
				local v2 = not v_team or v_team == "Spectators"
				local v3
				if v_u_all == v_u9.Modes.All then
					v3 = (v1 or v2) and "All" or "AllDead"
				else
					v3 = v1 and "Team" or "TeamDead"
				end
				print("[ChatClient] Sending to channel:", v3, "isAlive:", v1, "isSpectator:", v2, "team:", v_team)
				local v4 = v_u_textchat:FindFirstChild(v3)
				if v4 then
					v4:SendAsync(v_text)
				else
					print("[ChatClient] Channel not found:", v3)
				end
			end
		end
		v_u14.Type.TextBox.TextTransparency = 1
		v_u14.Type.TextBox.Text = ""
		v_u22(false)
	end)
	v_u22(false)
	local v2 = v_u6(v_u_localplayer)
	local v3 = v_u14
	if v2 then
		v2 = not table.find(v_u15, v_u10.Mobile)
	end
	v3.Visible = v2
end
function v_u1.Start()
	-- upvalues: (copy) v_u_textchat, (copy) v_u_localplayer, (copy) v_u_players, (copy) v_u_replicatedstorage, (copy) v_u1, (copy) v_u8, (copy) v_u_run, (copy) v_u19, (copy) v_u24, (copy) v_u_userinput, (copy) v_u9
	local v_all = v_u_textchat:WaitForChild("All", 10)
	local v_alldead = v_u_textchat:WaitForChild("AllDead", 10)
	local v_team = v_u_textchat:WaitForChild("Team", 10)
	local v_teamdead = v_u_textchat:WaitForChild("TeamDead", 10)
	local v_u1 = true
	local function v_u2()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u1
		if v_u_localplayer.Character and v_u_localplayer.Character:FindFirstChild("Humanoid") then
			v_u1 = v_u_localplayer.Character.Humanoid.Health > 0
		else
			v_u1 = false
		end
	end
	v_u_localplayer.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u1, (copy) v_u2
		local v_humanoid = v_u_localplayer.Character:WaitForChild("Humanoid", 10)
		if v_humanoid then
			if v_u_localplayer.Character and v_u_localplayer.Character:FindFirstChild("Humanoid") then
				v_u1 = v_u_localplayer.Character.Humanoid.Health > 0
			else
				v_u1 = false
			end
			v_humanoid.HealthChanged:Connect(v_u2)
			v_humanoid.Died:Connect(function()
				-- upvalues: (ref) v_u1
				v_u1 = false
			end)
		end
	end)
	if v_u_localplayer.Character and v_u_localplayer.Character:FindFirstChild("Humanoid") then
		if v_u_localplayer.Character.Humanoid.Health > 0 then
			v_u1 = true
		else
			v_u1 = false
		end
	else
		v_u1 = false
	end
	local v_u3 = {}
	local function v_u4(arg1, arg2, arg3)
		-- upvalues: (ref) v_u3, (ref) v_u_players, (ref) v_u_localplayer, (ref) v_u1, (ref) v_u_replicatedstorage, (ref) v_u1
		if arg1.Status == Enum.TextChatMessageStatus.Success then
			local v_messageid = arg1.MessageId
			if v_messageid and v_u3[v_messageid] then
				return
			else
				if v_messageid then
					v_u3[v_messageid] = true
					local v1 = 0
					for _ in v_u3 do
						v1 = v1 + 1
					end
					if v1 > 100 then
						v_u3 = {
							[v_messageid] = true
						}
					end
				end
				local v_textsource = arg1.TextSource
				if v_textsource then
					local v_userid = v_textsource.UserId
					if v_userid then
						local v_u_getplayerbyuserid = v_u_players:GetPlayerByUserId(v_userid)
						if v_u_getplayerbyuserid then
							local v_getplayerbyuserid = v_u_players:GetPlayerByUserId(v_userid)
							local v2
							if v_getplayerbyuserid and v_getplayerbyuserid.Character then
								local v_humanoid = v_getplayerbyuserid.Character:FindFirstChild("Humanoid")
								v2 = v_humanoid and v_humanoid.Health > 0 and true or false
							else
								v2 = false
							end
							local v_team = v_u_getplayerbyuserid:GetAttribute("Team")
							local v_team = v_u_localplayer:GetAttribute("Team")
							if arg2 == "All" or arg2 == "AllDead" then
								if v_u1 and (not v2 and arg2 == "All") then
									return
								end
							elseif arg2 == "Team" or arg2 == "TeamDead" then
								if v_team ~= v_team then
									return
								end
								if arg2 == "Team" and (v_u1 and not v2) then
									return
								end
							end
							require(v_u_replicatedstorage.Database.Custom.GameStats.UI.Chat.HTML)
							local v3 = 0
							local v4, v5 = pcall(function()
								-- upvalues: (copy) v_u_getplayerbyuserid
								return v_u_getplayerbyuserid:GetRankInGroup(33751825)
							end)
							if v4 then
								v3 = v5 or v3
							end
							v_u1.ProcessChatData({
								["displayName"] = v_u_getplayerbyuserid.DisplayName,
								["team"] = v_team or "Spectators",
								["message"] = arg1.Text,
								["alive"] = v2,
								["role"] = v3,
								["verified"] = v_u_getplayerbyuserid.HasVerifiedBadge
							}, arg3)
						end
					else
						return
					end
				else
					return
				end
			end
		else
			return
		end
	end
	if v_all then
		function v_all.OnIncomingMessage(arg1)
			-- upvalues: (copy) v_u4
			v_u4(arg1, "All", false)
			return nil
		end
	end
	if v_alldead then
		function v_alldead.OnIncomingMessage(arg1)
			-- upvalues: (copy) v_u4
			v_u4(arg1, "AllDead", false)
			return nil
		end
	end
	if v_team then
		function v_team.OnIncomingMessage(arg1)
			-- upvalues: (copy) v_u4
			v_u4(arg1, "Team", true)
			return nil
		end
	end
	if v_teamdead then
		function v_teamdead.OnIncomingMessage(arg1)
			-- upvalues: (copy) v_u4
			v_u4(arg1, "TeamDead", true)
			return nil
		end
	end
	v_u8.Chat.ChatTeamJoin.Listen(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.ProcessTeamJoin(arg1.name, arg1.team)
	end)
	v_u8.Chat.ChatPlayerLeave.Listen(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.ProcessPlayerLeave(arg1.name)
	end)
	v_u8.Chat.ChatPlayerKilled.Listen(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.ProcessKillMessage(arg1)
	end)
	v_u8.Chat.ChatMoneyReward.Listen(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.ProcessMoneyReward(arg1)
	end)
	v_u8.Chat.ChatCaseOpened.Listen(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.ProcessCaseOpened(arg1)
	end)
	v_u_run.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u19, (ref) v_u24
		if #v_u19 > 0 then
			v_u24()
		end
	end)
	v_u_userinput.InputBegan:Connect(function(arg1, arg2)
		-- upvalues: (ref) v_u1, (ref) v_u9
		if not arg2 and (arg1.UserInputType == Enum.UserInputType.Keyboard and arg1.KeyCode == Enum.KeyCode.Slash) then
			v_u1.OpenChat(v_u9.Modes.All)
		end
	end)
end
return v_u1