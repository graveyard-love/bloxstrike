-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Controllers.CameraController)
local v_u3 = require(v_replicatedstorage.Components.Common.GetBadgeIcon)
local v_u4 = require(v_replicatedstorage.Components.Common.GetBadgeName)
local v_u5 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u_debris = workspace:WaitForChild("Debris")
local v_u_current_camera = workspace.CurrentCamera
local v_u_localplayer = v_u_players.LocalPlayer
local v_u6 = nil
local v_u7 = nil
local v_u8 = nil
local function v_u9()
	-- upvalues: (copy) v_u_debris, (copy) v_u_localplayer
	for _, v1 in ipairs(v_u_debris:GetChildren()) do
		if v1:HasTag("Ragdoll") and v1.Name == v_u_localplayer.Name then
			return v1:WaitForChild("Humanoid")
		end
	end
	return nil
end
function v_u1.updateFrame(arg1)
	-- upvalues: (copy) v_u_players, (ref) v_u8, (copy) v_u4, (copy) v_u3
	local v_getplayerbyuserid = v_u_players:GetPlayerByUserId((tonumber(arg1.Killer)))
	if v_getplayerbyuserid and v_getplayerbyuserid:IsDescendantOf(v_u_players) then
		v_u8.Killed.Text = ("<font color=\"rgb(255,34,16)\">Killed you with their</font> <b>%* | %*</b>"):format(arg1.Weapon, arg1.Skin)
		v_u8.BadgeFrame.TextLabel.Text = v_u4(v_getplayerbyuserid, (v_getplayerbyuserid:GetAttribute("Team")))
		v_u8.BadgeIcon.Image = v_u3(v_getplayerbyuserid, (v_getplayerbyuserid:GetAttribute("Team")))
		v_u8.Profile.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v_getplayerbyuserid.UserId)
		v_u8.Username.Text = v_getplayerbyuserid.DisplayName
	end
end
function v_u1.openFrame()
	-- upvalues: (copy) v_u9, (copy) v_u_current_camera, (copy) v_u2, (ref) v_u6, (ref) v_u8, (ref) v_u7, (copy) v_u_tween, (copy) v_u1
	v_u_current_camera.CameraSubject = v_u9()
	v_u_current_camera.CameraType = Enum.CameraType.Follow
	v_u2.setPerspective(false, false)
	task.wait(0.15)
	v_u6.ImageLabel.ImageTransparency = 1
	v_u6.BackgroundTransparency = 1
	v_u6.Visible = true
	v_u8.Position = UDim2.fromScale(0.5, -v_u8.Size.Y.Scale)
	v_u8.Visible = true
	v_u7.BackgroundTransparency = 1
	v_u7.Visible = true
	v_u_tween:Create(v_u6, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["BackgroundTransparency"] = 0.75
	}):Play()
	v_u_tween:Create(v_u6.ImageLabel, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["ImageTransparency"] = 0
	}):Play()
	task.wait(0.25)
	v_u_tween:Create(v_u8, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["Position"] = UDim2.fromScale(0.5, 0.7)
	}):Play()
	task.wait(0.35)
	v_u_tween:Create(v_u7, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["BackgroundTransparency"] = 0
	}):Play()
	v_u_tween:Create(v_u6, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["BackgroundTransparency"] = 1
	}):Play()
	v_u_tween:Create(v_u6.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["ImageTransparency"] = 1
	}):Play()
	if workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
		task.delay(2, function()
			-- upvalues: (ref) v_u1
			v_u1.closeFrame()
		end)
	end
end
function v_u1.closeFrame()
	-- upvalues: (ref) v_u6, (ref) v_u8, (copy) v_u_tween, (ref) v_u7
	v_u6.ImageLabel.ImageTransparency = 1
	v_u6.BackgroundTransparency = 1
	v_u6.Visible = false
	v_u8.Position = UDim2.fromScale(0.5, -v_u8.Size.Y.Scale)
	v_u8.Visible = false
	local v_create = v_u_tween:Create(v_u7, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["BackgroundTransparency"] = 1
	})
	v_create:Play()
	v_create.Completed:Connect(function()
		-- upvalues: (ref) v_u7
		v_u7.BackgroundTransparency = 1
		v_u7.Visible = false
	end)
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u6, (ref) v_u7, (ref) v_u8, (copy) v_u_localplayer, (copy) v_u1
	v_u6 = arg1.Gameplay.Middle.BloodScreen
	v_u7 = arg1.Gameplay.Middle.Transition
	v_u8 = arg2
	v_u_localplayer.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u8, (ref) v_u1
		if v_u8.Visible then
			v_u1.closeFrame()
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u5, (copy) v_u_localplayer, (copy) v_u1
	v_u5.UI.UIPlayerKilled.Listen(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u1
		if v_u_localplayer.UserId == tonumber(arg1.Victim) then
			v_u1.updateFrame(arg1)
			v_u1.openFrame()
		end
	end)
	v_u5.UI.ShowDeathCard.Listen(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u1
		if v_u_localplayer.UserId == tonumber(arg1.Victim) then
			v_u1.updateFrame(arg1)
		end
	end)
end
return v_u1