-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_u_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_u_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Components.Common.GetTimerFormat)
local v_u3 = require(v_u_replicatedstorage.Classes.Sound)
local v_u4 = require(v_u_replicatedstorage.Packages.Observers)
local v_u5 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u6 = require(v_u_replicatedstorage.Database.Custom.GameStats.Settings.Colors)
local v_u7 = nil
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
function v_u1.createTemplate(arg1, _)
	-- upvalues: (copy) v_u1, (copy) v_u5, (copy) v_u9, (copy) v_u_replicatedstorage, (copy) v_u6, (ref) v_u7, (copy) v_u4
	local v_gamemode = workspace:GetAttribute("Gamemode")
	local v_team = arg1:GetAttribute("Team")
	v_u1.cleanupPlayerTemplate(arg1)
	if v_gamemode == "Deathmatch" and (v_team == "Terrorists" or v_team == "Counter-Terrorists") then
		local v_new = v_u5.new()
		v_u9[arg1] = v_new
		local v_u_clone = v_u_replicatedstorage.Assets.UI.Deathmatch.PlayerTemplate:Clone()
		v_u_clone.Player.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(arg1.UserId)
		v_u_clone.Info.UIStroke.Color = v_u6["Team Color"][v_team]
		v_u_clone.UIStroke.Color = v_u6["Team Color"][v_team]
		v_u_clone.Parent = v_u7.Players
		v_u_clone.Info.Amount.Text = "0"
		v_new:Add(function()
			-- upvalues: (copy) v_u_clone
			v_u_clone:Destroy()
		end)
		v_new:Add(v_u4.observeAttribute(arg1, "Score", function(arg1)
			-- upvalues: (copy) v_u_clone
			v_u_clone.Info.Amount.Text = tostring(arg1)
			v_u_clone.LayoutOrder = -arg1
		end))
		v_new:Add(v_u4.observeAttribute(arg1, "Team", function(arg1)
			-- upvalues: (ref) v_u1, (copy) arg1
			if arg1 ~= "Counter-Terrorists" and arg1 ~= "Terrorists" then
				v_u1.cleanupPlayerTemplate(arg1)
			end
			return function()
				-- upvalues: (ref) v_u1, (ref) arg1
				v_u1.cleanupPlayerTemplate(arg1)
			end
		end))
	end
end
function v_u1.cleanupPlayerTemplate(arg1)
	-- upvalues: (copy) v_u9
	local v1 = v_u9[arg1]
	v_u9[arg1] = nil
	if v1 then
		v1:Destroy()
	end
end
function v_u1.playerAdded(self)
	-- upvalues: (copy) v_u1
	if self.Character then
		v_u1.createTemplate(self, self.Character)
	end
	self.CharacterAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		v_u1.createTemplate(self, arg1)
	end)
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u8, (ref) v_u7, (copy) v_u4, (copy) v_u2, (copy) v_u3, (copy) v_u_localplayer, (copy) v_u_run
	v_u8 = arg1
	v_u7 = arg2
	v_u4.observeAttribute(workspace, "Timer", function(arg1)
		-- upvalues: (ref) v_u7, (ref) v_u2, (ref) v_u3, (ref) v_u_localplayer
		local v_gamemode = workspace:GetAttribute("Gamemode")
		v_u7.Time.Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
		v_u7.Time.Timer.Text = v_u2(arg1)
		if v_gamemode == "Deathmatch" and arg1 <= 10 then
			local v_interface = v_u3.new("Interface")
			v_u7.Time.Timer.TextColor3 = Color3.fromRGB(165, 20, 20)
			v_interface:playOneTime({
				["Parent"] = v_u_localplayer.PlayerGui,
				["Name"] = "Countdown Timer"
			})
		end
	end)
	v_u_run.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u7, (ref) v_u8
		local v1 = v_u7
		local v2 = workspace:GetAttribute("Gamemode") == "Deathmatch" and not v_u8.Gameplay.Middle.TeamSelection.Visible
		if v2 then
			v2 = not v_u8.Gameplay.Middle.SniperScope.Visible
		end
		v1.Visible = v2
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u10, (ref) v_u7, (copy) v_u_players, (copy) v_u1
	v_u10(v_u7.Players)
	for _, v1 in ipairs(v_u_players:GetPlayers()) do
		v_u1.playerAdded(v1)
	end
	v_u_players.PlayerAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.playerAdded(arg1)
	end)
	v_u_players.PlayerRemoving:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.cleanupPlayerTemplate(arg1)
	end)
end
return v_u1