-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_u_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_u_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Database.Components.Common.RemoveFromArray)
local v_u3 = require(v_u_replicatedstorage.Components.Common.GetBadgeIcon)
local v_u4 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u5 = require(v_u_replicatedstorage.Packages.Observers)
local v_u6 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u7 = require(v_u_replicatedstorage.Components.Common.GetTimerFormat)
local v_u_fromscale = UDim2.fromScale(0.582, 0.782)
local v_u_fromscale = UDim2.fromScale(0.582, 0.355)
local v_u_fromscale = UDim2.fromScale(0.282, 0.85)
local v_u_fromscale = UDim2.fromScale(0.82, 0.9)
local v_u_fromscale = UDim2.fromScale(0.758, 0.9)
local v_u_fromscale = UDim2.fromScale(0.638, 0.9)
local v_u_fromscale = UDim2.fromScale(0.937, 0.9)
local v_u_fromscale = UDim2.fromScale(0.702, 0.9)
local v_u_fromscale = UDim2.fromScale(0.882, 0.9)
local v_u_fromscale = UDim2.fromScale(0.762, 0.365)
local v_u_fromscale = UDim2.fromScale(0.503, 0.785)
local v_u_fromscale = UDim2.fromScale(0.503, 0.364)
local v_u_fromscale = UDim2.fromScale(0.135, 0.85)
local v_u_fromscale = UDim2.fromScale(0.79, 0.9)
local v_u_fromscale = UDim2.fromScale(0.715, 0.9)
local v_u_fromscale = UDim2.fromScale(0.57, 0.9)
local v_u_fromscale = UDim2.fromScale(0.932, 0.9)
local v_u_fromscale = UDim2.fromScale(0.648, 0.9)
local v_u_fromscale = UDim2.fromScale(0.866, 0.9)
local v_u_fromscale = UDim2.fromScale(0.921, 0.365)
local v_u8 = nil
local v_u9 = {}
local function v_u10(arg1)
	local v_getchildren = arg1:GetChildren()
	for _, v1 in ipairs(v_getchildren) do
		if v1.ClassName == "Frame" then
			v1:Destroy()
		end
	end
end
local function v_u11(arg1)
	-- upvalues: (copy) v_u_players
	local v1 = {}
	for _, v2 in ipairs(v_u_players:GetPlayers()) do
		if v2:GetAttribute("Team") == arg1 then
			table.insert(v1, v2)
		end
	end
	return v1
end
local function v_u12()
	-- upvalues: (ref) v_u8, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale, (copy) v_u_fromscale
	local v_gamemode = workspace:GetAttribute("Gamemode")
	v_u8.Team.CT.Score.Visible = v_gamemode ~= "Deathmatch"
	v_u8.Team.T.Score.Visible = v_gamemode ~= "Deathmatch"
	local v_map = workspace:GetAttribute("Map")
	v_u8.TopInfo.Gamemode.Text = ("%* | %*"):format(v_gamemode, v_map)
	if v_gamemode == "Deathmatch" then
		v_u8["Counter-Terrorists"].Position = v_u_fromscale
		v_u8.Terrorists.Position = v_u_fromscale
		v_u8.TopInfo.Assists.Position = v_u_fromscale
		v_u8.TopInfo.Deaths.Position = v_u_fromscale
		v_u8.TopInfo.Money.Position = v_u_fromscale
		v_u8.TopInfo.Score.Position = v_u_fromscale
		v_u8.TopInfo.Kills.Position = v_u_fromscale
		v_u8.TopInfo.MVPs.Position = v_u_fromscale
		v_u8.TopInfo.Ping.Position = v_u_fromscale
		v_u8["Counter-Terrorists"].Size = v_u_fromscale
		v_u8.Terrorists.Size = v_u_fromscale
		v_u8.DeathmatchDivider.Visible = true
		v_u8.Team.Visible = false
	elseif v_gamemode == "Bomb Defusal" or v_gamemode == "Hostage Rescue" then
		v_u8["Counter-Terrorists"].Position = v_u_fromscale
		v_u8.Terrorists.Position = v_u_fromscale
		v_u8.TopInfo.Assists.Position = v_u_fromscale
		v_u8.TopInfo.Deaths.Position = v_u_fromscale
		v_u8.TopInfo.Score.Position = v_u_fromscale
		v_u8.TopInfo.Kills.Position = v_u_fromscale
		v_u8.TopInfo.Money.Position = v_u_fromscale
		v_u8.TopInfo.MVPs.Position = v_u_fromscale
		v_u8.TopInfo.Ping.Position = v_u_fromscale
		v_u8["Counter-Terrorists"].Size = v_u_fromscale
		v_u8.Terrorists.Size = v_u_fromscale
		v_u8.DeathmatchDivider.Visible = false
		v_u8.Team.Visible = true
	end
end
function v_u1.createTemplate(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u3, (copy) v_u_localplayer, (copy) v_u5, (copy) v_u4
	local v_u_clone = v_u_replicatedstorage.Assets.UI.Leaderboard[arg2]:Clone()
	v_u_clone.Player.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(arg1.UserId)
	v_u_clone.PlayerName.Text = ("%* (@%*)"):format(arg1.DisplayName, arg1.Name)
	local v1 = v_u3(arg1, arg2)
	v_u_clone.Badge.Visible = v1 ~= ""
	v_u_clone.Badge.Image = v1
	v_u_clone.LayoutOrder = 0
	v_u_clone.Assists.Amount.Text = "0"
	v_u_clone.Deaths.Amount.Text = "0"
	v_u_clone.Score.Amount.Text = "0"
	v_u_clone.Kills.Amount.Text = "0"
	v_u_clone.Money.Amount.Text = ""
	v_u_clone.LayoutOrder = 1
	v_u_clone.Ping.Text = "0"
	local v_u2 = {}
	local function v_u3(arg1)
		-- upvalues: (copy) v_u2, (copy) v_u3
		if arg1:IsA("Frame") then
			v_u2[arg1] = {
				["BackgroundTransparency"] = arg1.BackgroundTransparency
			}
		elseif arg1:IsA("TextLabel") then
			v_u2[arg1] = {
				["TextTransparency"] = arg1.TextTransparency,
				["BackgroundTransparency"] = arg1.BackgroundTransparency
			}
		elseif arg1:IsA("TextButton") then
			v_u2[arg1] = {
				["TextTransparency"] = arg1.TextTransparency,
				["BackgroundTransparency"] = arg1.BackgroundTransparency
			}
		elseif arg1:IsA("ImageLabel") then
			v_u2[arg1] = {
				["ImageTransparency"] = arg1.ImageTransparency,
				["BackgroundTransparency"] = arg1.BackgroundTransparency
			}
		elseif arg1:IsA("ImageButton") then
			v_u2[arg1] = {
				["ImageTransparency"] = arg1.ImageTransparency,
				["BackgroundTransparency"] = arg1.BackgroundTransparency
			}
		end
		for _, v1 in ipairs(arg1:GetChildren()) do
			v_u3(v1)
		end
	end
	v_u2[v_u_clone] = {
		["BackgroundTransparency"] = v_u_clone.BackgroundTransparency
	}
	for _, v4 in ipairs(v_u_clone:GetChildren()) do
		v_u3(v4)
	end
	if arg1 == v_u_localplayer then
		v_u_clone.BackgroundColor3 = Color3.fromRGB(139, 128, 98)
	end
	arg3:Add(v_u5.observeAttribute(arg1, "Money", function(arg1)
		-- upvalues: (copy) arg1, (ref) v_u_localplayer, (copy) v_u_clone
		local v_gamemode = workspace:GetAttribute("Gamemode")
		if arg1:GetAttribute("Team") == v_u_localplayer:GetAttribute("Team") or v_gamemode == "Deathmatch" then
			v_u_clone.Money.Amount.Text = ("$%*"):format((tostring(arg1):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
		else
			v_u_clone.Money.Amount.Text = ""
		end
	end))
	arg3:Add(v_u5.observeAttribute(arg1, "Kills", function(arg1)
		-- upvalues: (copy) v_u_clone
		v_u_clone.Kills.Amount.Text = tostring(arg1):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
		v_u_clone.LayoutOrder = -arg1
	end))
	arg3:Add(v_u5.observeAttribute(arg1, "Deaths", function(arg1)
		-- upvalues: (copy) v_u_clone
		v_u_clone.Deaths.Amount.Text = tostring(arg1):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end))
	arg3:Add(v_u5.observeAttribute(arg1, "Assists", function(arg1)
		-- upvalues: (copy) v_u_clone
		v_u_clone.Assists.Amount.Text = tostring(arg1):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end))
	arg3:Add(v_u5.observeAttribute(arg1, "Score", function(arg1)
		-- upvalues: (copy) v_u_clone
		v_u_clone.Score.Amount.Text = tostring(arg1):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end))
	arg3:Add(v_u5.observeAttribute(arg1, "Ping", function(arg1)
		-- upvalues: (copy) v_u_clone
		v_u_clone.Ping.Text = arg1
	end))
	local function v_u5()
		-- upvalues: (copy) arg1, (copy) v_u_clone, (copy) v_u2
		local v_character = arg1.Character
		if v_character then
			v_character = v_character:GetAttribute("Dead") == true
		end
		local v1 = v_character == true and true or arg1:GetAttribute("IsSpectating") == true == true
		if v_u_clone and v_u_clone:FindFirstChild("Dead") then
			v_u_clone.Dead.Visible = v1
		end
		if v1 then
			v_u_clone.BackgroundTransparency = 1
			local function v_u2(arg1)
				-- upvalues: (copy) v_u2
				if arg1:IsA("Frame") then
					arg1.BackgroundTransparency = 1
				elseif arg1:IsA("TextLabel") then
					arg1.TextTransparency = 0.5
					arg1.BackgroundTransparency = 1
				elseif arg1:IsA("TextButton") then
					arg1.TextTransparency = 0.5
					arg1.BackgroundTransparency = 1
				elseif arg1:IsA("ImageLabel") then
					arg1.ImageTransparency = 0.5
					arg1.BackgroundTransparency = 1
				elseif arg1:IsA("ImageButton") then
					arg1.ImageTransparency = 0.5
					arg1.BackgroundTransparency = 1
				end
				for _, v1 in ipairs(arg1:GetChildren()) do
					v_u2(v1)
				end
			end
			for _, v3 in ipairs(v_u_clone:GetChildren()) do
				v_u2(v3)
			end
		else
			local function v_u4(arg1)
				-- upvalues: (ref) v_u2, (copy) v_u4
				local v1 = v_u2[arg1]
				if v1 then
					if arg1:IsA("Frame") then
						arg1.BackgroundTransparency = v1.BackgroundTransparency
					elseif arg1:IsA("TextLabel") then
						arg1.TextTransparency = v1.TextTransparency
						arg1.BackgroundTransparency = v1.BackgroundTransparency
					elseif arg1:IsA("TextButton") then
						arg1.TextTransparency = v1.TextTransparency
						arg1.BackgroundTransparency = v1.BackgroundTransparency
					elseif arg1:IsA("ImageLabel") then
						arg1.ImageTransparency = v1.ImageTransparency
						arg1.BackgroundTransparency = v1.BackgroundTransparency
					elseif arg1:IsA("ImageButton") then
						arg1.ImageTransparency = v1.ImageTransparency
						arg1.BackgroundTransparency = v1.BackgroundTransparency
					end
				end
				for _, v2 in ipairs(arg1:GetChildren()) do
					v_u4(v2)
				end
			end
			local v5 = v_u2[v_u_clone]
			if v5 then
				v_u_clone.BackgroundTransparency = v5.BackgroundTransparency
			end
			for _, v6 in ipairs(v_u_clone:GetChildren()) do
				v_u4(v6)
			end
		end
	end
	arg3:Add(v_u5.observeAttribute(arg1, "IsSpectating", function(_)
		-- upvalues: (copy) v_u5
		v_u5()
	end))
	local v_connection = arg1.CharacterAdded:Connect(function(_)
		-- upvalues: (copy) arg1, (copy) v_u5, (copy) arg3
		task.wait(0.1)
		local v_character = arg1.Character
		local v1
		if v_character then
			v_u5()
			v1 = v_character:GetAttributeChangedSignal("Dead"):Connect(v_u5)
		else
			v_u5()
			v1 = nil
		end
		if v1 then
			arg3:Add(v1)
		end
	end)
	local v_connection = arg1.CharacterRemoving:Connect(function(_)
		-- upvalues: (copy) v_u5
		v_u5()
	end)
	arg3:Add(v_connection)
	arg3:Add(v_connection)
	if arg1.Character then
		local v_character = arg1.Character
		local v6
		if v_character then
			v_u5()
			v6 = v_character:GetAttributeChangedSignal("Dead"):Connect(v_u5)
		else
			v_u5()
			v6 = nil
		end
		if v6 then
			arg3:Add(v6)
		end
	else
		v_u5()
	end
	local v_u_createlistener = v_u4.CreateListener(arg1, ("Loadout.%*.Equipped.Equipped Badge"):format(arg2), function()
		-- upvalues: (ref) v_u3, (copy) arg1, (copy) arg2, (copy) v_u_clone
		local v1 = v_u3(arg1, arg2)
		v_u_clone.Badge.Image = v1
		v_u_clone.Badge.Visible = v1 ~= ""
	end)
	arg3:Add(function()
		-- upvalues: (ref) v_u4, (copy) arg1, (copy) arg2, (copy) v_u_createlistener
		v_u4.RemoveListener(arg1, ("Loadout.%*.Equipped.Equipped Badge"):format(arg2), v_u_createlistener)
	end)
	return v_u_clone
end
function v_u1.openFrame()
	-- upvalues: (ref) v_u8
	v_u8.Visible = true
end
function v_u1.closeFrame()
	-- upvalues: (ref) v_u8
	v_u8.Visible = false
end
function v_u1.characterAdded(arg1, arg2)
	-- upvalues: (copy) v_u6, (copy) v_u1, (ref) v_u8, (copy) v_u9
	local v_new = v_u6.new()
	v_u1.cleanup(arg1)
	local v_u_createtemplate = v_u1.createTemplate(arg1, arg2, v_new)
	v_u_createtemplate.Parent = v_u8:FindFirstChild(arg2)
	v_new:Add(function()
		-- upvalues: (copy) v_u_createtemplate
		v_u_createtemplate:Destroy()
	end)
	v_u9[arg1] = v_new
end
function v_u1.observePlayer(self)
	-- upvalues: (copy) v_u5, (copy) v_u1
	v_u5.observeAttribute(self, "Team", function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		if arg1 == "Terrorists" or arg1 == "Counter-Terrorists" then
			v_u1.characterAdded(self, arg1)
		end
		return function()
			-- upvalues: (ref) v_u1, (ref) self
			v_u1.cleanup(self)
		end
	end)
end
function v_u1.cleanup(arg1)
	-- upvalues: (copy) v_u9
	local v1 = v_u9[arg1]
	v_u9[arg1] = nil
	if v1 then
		v1:Destroy()
	end
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u8, (copy) v_u5, (copy) v_u12, (copy) v_u7, (copy) v_u1
	v_u8 = arg2
	v_u5.observeAttribute(workspace, "Gamemode", v_u12)
	v_u5.observeAttribute(workspace, "Map", v_u12)
	v_u5.observeAttribute(workspace, "CTScore", function(arg1)
		-- upvalues: (ref) v_u8
		v_u8.Team.CT.Score.Text = tostring(arg1)
		return function()
			-- upvalues: (ref) v_u8
			v_u8.Team.CT.Score.Text = ""
		end
	end)
	v_u5.observeAttribute(workspace, "TScore", function(arg1)
		-- upvalues: (ref) v_u8
		v_u8.Team.T.Score.Text = tostring(arg1)
		return function()
			-- upvalues: (ref) v_u8
			v_u8.Team.T.Score.Text = ""
		end
	end)
	v_u5.observeAttribute(workspace, "Timer", function(arg1)
		-- upvalues: (ref) v_u8, (ref) v_u7
		v_u8.TopInfo.Timer.Text = v_u7(arg1)
	end)
	v_u5.observePlayer(function(self)
		-- upvalues: (ref) v_u1
		v_u1.observePlayer(self)
		return function()
			-- upvalues: (ref) v_u1, (copy) self
			v_u1.cleanup(self)
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u10, (ref) v_u8, (copy) v_u_run, (copy) v_u11, (copy) v_u2
	v_u10((v_u8:WaitForChild("Counter-Terrorists")))
	v_u10((v_u8:WaitForChild("Terrorists")))
	v_u_run.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u11, (ref) v_u2, (ref) v_u8
		local v_gamemode = workspace:GetAttribute("Gamemode")
		if v_gamemode == "Bomb Defusal" or v_gamemode == "Hostage Rescue" then
			local v1 = v_u11("Counter-Terrorists")
			local v_terrorists = v_u11("Terrorists")
			local v2 = v_u2(v1, function(_, arg2)
				local v_character = arg2.Character
				if v_character and v_character:IsDescendantOf(workspace) then
					local v_humanoid = v_character:FindFirstChild("Humanoid")
					if v_humanoid and v_humanoid.Health > 0 then
						return false
					end
				end
				return true
			end)
			local v3 = v_u2(v_terrorists, function(_, arg2)
				local v_character = arg2.Character
				if v_character and v_character:IsDescendantOf(workspace) then
					local v_humanoid = v_character:FindFirstChild("Humanoid")
					if v_humanoid and v_humanoid.Health > 0 then
						return false
					end
				end
				return true
			end)
			local v4 = tostring(#v2)
			v_u8.Team.CT.Alive.Text = ("ALIVE %*/%*"):format(v4, (tostring(#v1)))
			local v5 = tostring(#v3)
			v_u8.Team.T.Alive.Text = ("ALIVE %*/%*"):format(v5, (tostring(#v_terrorists)))
		end
	end)
end
return v_u1