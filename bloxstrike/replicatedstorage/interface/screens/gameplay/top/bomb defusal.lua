-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_collection = game:GetService("CollectionService")
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_http = game:GetService("HttpService")
local v_u_run = game:GetService("RunService")
local v_u_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_u_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Database.Components.Common.RemoveFromArray)
local v_u3 = require(v_u_replicatedstorage.Components.Common.GetTimerFormat)
local v_u4 = require(v_u_replicatedstorage.Classes.Sound)
local v_u5 = require(v_u_replicatedstorage.Packages.Observers)
local v_u6 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u7 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u8 = 0
local v_u9 = {}
local v_u10 = {}
local v_u11 = nil
local v_u12 = nil
local function v_u13(arg1)
	local v_getchildren = arg1:GetChildren()
	for _, v1 in ipairs(v_getchildren) do
		if v1.ClassName == "Frame" then
			v1:Destroy()
		end
	end
end
local function v_u14(arg1)
	-- upvalues: (copy) v_u_players
	local v1 = {}
	for _, v2 in ipairs(v_u_players:GetPlayers()) do
		if v2:GetAttribute("Team") == arg1 then
			table.insert(v1, v2)
		end
	end
	return v1
end
function v_u1.CharacterAdded(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_tween, (copy) v_u5
	local v_u_humanoid = arg4:FindFirstChild("Humanoid")
	if not v_u_humanoid then
		local v1 = tick()
		repeat
			task.wait(0.1)
			v_u_humanoid = arg4:FindFirstChild("Humanoid")
		until v_u_humanoid or tick() - v1 > 5
	end
	local v_u_team = arg3:GetAttribute("Team")
	local function v_u2()
		-- upvalues: (copy) arg3, (copy) arg2, (ref) v_u_localplayer, (copy) v_u_team
		local v_character = arg3.Character
		local v1
		if v_character then
			v1 = v_character:GetAttribute("Dead") == true
		else
			v1 = v_character
		end
		if v1 == true and true or arg3:GetAttribute("IsSpectating") == true == true then
			arg2.Health.Bar.Size = UDim2.fromScale(0, 1)
			arg2.Player.ImageTransparency = 0.5
			arg2.Player.X.Visible = true
			arg2.Health.Visible = false
			arg2.Transparency = 0.5
		else
			arg2.Player.ImageTransparency = 0
			arg2.Player.X.Visible = false
			arg2.Transparency = 0
			local v2 = v_u_localplayer:GetAttribute("Team") == v_u_team and (v_character and v_character:FindFirstChild("Humanoid"))
			if v2 then
				arg2.Health.Bar.Size = UDim2.fromScale(math.clamp(math.floor(v2.Health) / v2.MaxHealth, 0, 1), 1)
				arg2.Health.Visible = true
			end
		end
	end
	v_u2()
	if v_u_humanoid then
		arg1:Add(v_u_humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			-- upvalues: (copy) arg3, (ref) v_u_humanoid, (ref) v_u_localplayer, (ref) v_u_tween, (copy) arg2
			local v_character = arg3.Character
			if v_character then
				v_character = v_character:GetAttribute("Dead") == true
			end
			if not v_character and (arg3:GetAttribute("IsSpectating") ~= true and (v_u_humanoid and (v_u_humanoid.Parent and arg3:GetAttribute("Team") == v_u_localplayer:GetAttribute("Team")))) then
				local v_new = TweenInfo.new(0.25)
				v_u_tween:Create(arg2.Health.Bar, v_new, {
					["Size"] = UDim2.fromScale(math.clamp(math.floor(v_u_humanoid.Health) / v_u_humanoid.MaxHealth, 0, 1), 1)
				}):Play()
			end
		end))
	end
	arg1:Add(arg4:GetAttributeChangedSignal("Dead"):Connect(function()
		-- upvalues: (copy) v_u2
		v_u2()
	end))
	arg1:Add(v_u5.observeAttribute(arg3, "IsSpectating", function(_)
		-- upvalues: (copy) v_u2
		v_u2()
		return function() end
	end))
end
function v_u1.CreateTemplate(self)
	-- upvalues: (copy) v_u1, (copy) v_u6, (copy) v_u9, (copy) v_u_replicatedstorage, (copy) v_u_localplayer, (ref) v_u11, (copy) v_u10, (copy) v_u5, (copy) v_u_http
	local v_gamemode = workspace:GetAttribute("Gamemode")
	local v_team = self:GetAttribute("Team")
	v_u1.CleanupTemplate(self)
	if v_gamemode == "Bomb Defusal" or v_gamemode == "Hostage Rescue" then
		local v_u_new = v_u6.new()
		v_u9[self] = v_u_new
		local v_u_add = v_u_new:Add((v_u_replicatedstorage.Assets.UI.BombDefusal:FindFirstChild(v_team):Clone()))
		v_u_add.Player.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(self.UserId)
		v_u_add.Health.Visible = v_u_localplayer:GetAttribute("Team") == v_team
		v_u_add.Parent = v_u11:FindFirstChild(v_team)
		v_u10[self.UserId] = v_u_add
		if self.Character then
			v_u1.CharacterAdded(v_u_new, v_u_add, self, self.Character)
		else
			v_u_add.Health.Bar.Size = UDim2.fromScale(0, 1)
			v_u_add.Player.ImageTransparency = 0.5
			v_u_add.Player.X.Visible = true
			v_u_add.Health.Visible = false
			v_u_add.Transparency = 0.5
		end
		if v_team == "Terrorists" then
			v_u_new:Add(v_u5.observeAttribute(self, "Slot5", function(arg1)
				-- upvalues: (copy) self, (ref) v_u_localplayer, (ref) v_u_http, (copy) v_u_add
				local v_team = self:GetAttribute("Team")
				local v_team = v_u_localplayer:GetAttribute("Team")
				local v_jsondecode = v_u_http:JSONDecode(arg1 or "[]")
				local v_bomb = v_u_add:FindFirstChild("Bomb")
				if v_bomb then
					if v_team == v_team then
						if v_jsondecode then
							v_jsondecode = v_jsondecode.Weapon == "C4"
						end
					else
						v_jsondecode = false
					end
					v_bomb.Visible = v_jsondecode
				end
				return function()
					-- upvalues: (ref) v_u_add
					if v_u_add and v_u_add:FindFirstChild("Bomb") then
						v_u_add.Bomb.Visible = false
					end
				end
			end))
		elseif v_team == "Counter-Terrorists" then
			v_u_new:Add(v_u5.observeAttribute(self, "HasDefuseKit", function(arg1)
				-- upvalues: (ref) v_u_localplayer, (copy) self, (copy) v_u_add
				local v_team = v_u_localplayer:GetAttribute("Team")
				local v_team = self:GetAttribute("Team")
				local v_defusekit = v_u_add:FindFirstChild("DefuseKit")
				if v_defusekit then
					if arg1 then
						arg1 = v_team == v_team
					end
					v_defusekit.Visible = arg1
				end
				return function()
					-- upvalues: (ref) v_u_add
					if v_u_add and v_u_add:FindFirstChild("DefuseKit") then
						v_u_add.DefuseKit.Visible = false
					end
				end
			end))
		end
		v_u_new:Add(self.CharacterAdded:Connect(function(arg1)
			-- upvalues: (ref) v_u1, (copy) v_u_new, (copy) v_u_add, (copy) self
			v_u1.CharacterAdded(v_u_new, v_u_add, self, arg1)
		end))
	end
end
function v_u1.CleanupTemplate(arg1)
	-- upvalues: (copy) v_u9, (copy) v_u10
	local v1 = v_u9[arg1]
	v_u9[arg1] = nil
	v_u10[arg1.UserId] = nil
	if v1 then
		v1:Destroy()
	end
end
function v_u1.PlayerAdded(self)
	-- upvalues: (copy) v_u5, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u_players
	v_u5.observeAttribute(self, "Team", function(arg1)
		-- upvalues: (ref) v_u1, (copy) self, (ref) v_u_localplayer, (ref) v_u_players
		if arg1 ~= "Counter-Terrorists" and arg1 ~= "Terrorists" then
			v_u1.CleanupTemplate(self)
			return function()
				-- upvalues: (ref) v_u1, (ref) self
				v_u1.CleanupTemplate(self)
			end
		end
		v_u1.CreateTemplate(self)
		if self == v_u_localplayer then
			for _, v1 in ipairs(v_u_players:GetPlayers()) do
				if v1 ~= v_u_localplayer and v1:GetAttribute("Team") == arg1 then
					v_u1.CreateTemplate(v1)
				end
			end
		end
		return function()
			-- upvalues: (ref) v_u1, (ref) self
			v_u1.CleanupTemplate(self)
		end
	end)
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u12, (ref) v_u11, (copy) v_u5, (copy) v_u7, (copy) v_u_players, (copy) v_u10, (copy) v_u3, (copy) v_u4, (copy) v_u_localplayer, (copy) v_u_run, (ref) v_u8, (copy) v_u_collection, (copy) v_u14, (copy) v_u2, (copy) v_u_tween
	v_u12 = arg1
	v_u11 = arg2
	v_u5.observeAttribute(workspace, "CTScore", function(arg1)
		-- upvalues: (ref) v_u11
		v_u11.Time["Counter-Terrorists"].Score.Text = tostring(arg1)
		return function() end
	end)
	v_u5.observeAttribute(workspace, "TScore", function(arg1)
		-- upvalues: (ref) v_u11
		v_u11.Time.Terrorists.Score.Text = tostring(arg1)
		return function() end
	end)
	v_u7.UI.UIPlayerKilled.Listen(function(arg1)
		-- upvalues: (ref) v_u_players, (ref) v_u10
		local v1 = tonumber(arg1.Victim)
		if v1 then
			local v_getplayerbyuserid = v_u_players:GetPlayerByUserId(v1)
			local v2 = v_getplayerbyuserid and v_u10[v1]
			if v2 then
				local v_character = v_getplayerbyuserid.Character
				if v_character then
					v_character = v_character:GetAttribute("Dead") == true
				end
				if v_character == true and true or v_getplayerbyuserid:GetAttribute("IsSpectating") == true == true then
					v2.Health.Bar.Size = UDim2.fromScale(0, 1)
					v2.Player.ImageTransparency = 0.5
					v2.Player.X.Visible = true
					v2.Health.Visible = false
					v2.Transparency = 0.5
				end
			end
		end
	end)
	workspace:GetAttributeChangedSignal("Timer"):Connect(function()
		-- upvalues: (ref) v_u11, (ref) v_u3, (ref) v_u4, (ref) v_u_localplayer
		local v_timer = workspace:GetAttribute("Timer")
		if v_timer then
			local v_gamemode = workspace:GetAttribute("Gamemode")
			v_u11.Time.Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
			v_u11.Time.Timer.Text = v_u3(v_timer)
			if v_gamemode == "Deathmatch" and v_timer <= 10 then
				local v_interface = v_u4.new("Interface")
				v_u11.Time.Timer.TextColor3 = Color3.fromRGB(165, 20, 20)
				v_interface:playOneTime({
					["Parent"] = v_u_localplayer.PlayerGui,
					["Name"] = "Countdown Timer"
				})
			end
		end
	end)
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u8, (ref) v_u11, (ref) v_u12, (ref) v_u_collection, (ref) v_u14, (ref) v_u2, (ref) v_u_tween
		local v_gamemode = workspace:GetAttribute("Gamemode")
		v_u8 = v_u8 + arg1
		local v1 = v_u11
		local v2 = (v_gamemode == "Hostage Rescue" or v_gamemode == "Bomb Defusal") and not v_u12.Gameplay.Middle.TeamSelection.Visible
		if v2 then
			v2 = not v_u12.Gameplay.Middle.SniperScope.Visible
		end
		v1.Visible = v2
		if v_u11.Visible then
			local v_bomb = v_u_collection:GetTagged("Bomb")
			v_u11.Time["Counter-Terrorists"].Players.Text = tostring(#v_u2(v_u14("Counter-Terrorists"), function(_, arg2)
				local v_character = arg2.Character
				if v_character and v_character:IsDescendantOf(workspace) then
					local v_humanoid = v_character:FindFirstChild("Humanoid")
					if v_humanoid and v_humanoid.Health > 0 then
						return false
					end
				end
				return true
			end))
			v_u11.Time.Terrorists.Players.Text = tostring(#v_u2(v_u14("Terrorists"), function(_, arg2)
				local v_character = arg2.Character
				if v_character and v_character:IsDescendantOf(workspace) then
					local v_humanoid = v_character:FindFirstChild("Humanoid")
					if v_humanoid and v_humanoid.Health > 0 then
						return false
					end
				end
				return true
			end))
			if #v_bomb <= 0 or not v_bomb[1] then
				v_u11.Time.Timer.Visible = true
				v_u11.Time.Bomb.Visible = false
				return
			end
			v_u11.Time.Timer.Visible = false
			v_u11.Time.Bomb.Visible = true
			if v_u8 >= 1 then
				v_u8 = 0
				local v_new = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
				v_u_tween:Create(v_u11.Time.Bomb.Glow, v_new, {
					["ImageTransparency"] = v_u11.Time.Bomb.Glow.ImageTransparency < 0.5 and 0.75 or 0
				}):Play()
				return
			end
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u13, (ref) v_u11, (copy) v_u_players, (copy) v_u1
	v_u13(v_u11["Counter-Terrorists"])
	v_u13(v_u11.Terrorists)
	for _, v1 in ipairs(v_u_players:GetPlayers()) do
		v_u1.PlayerAdded(v1)
	end
	v_u_players.PlayerAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.PlayerAdded(arg1)
	end)
	v_u_players.PlayerRemoving:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.CleanupTemplate(arg1)
	end)
end
return v_u1