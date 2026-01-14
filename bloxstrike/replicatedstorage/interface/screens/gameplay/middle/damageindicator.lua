-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u_current_camera = workspace.CurrentCamera
local v_u2 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u3 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u4 = nil
function v_u1.construct(self)
	-- upvalues: (copy) v_u_current_camera
	local v_position = v_u_current_camera.CFrame.Position
	local v_position = (v_u_current_camera.CFrame * CFrame.new(0, 0, -1)).Position
	local v_position = self.Position
	local v1 = math.atan2(v_position.Z - v_position.Z, v_position.X - v_position.X) - math.atan2(v_position.Z - v_position.Z, v_position.X - v_position.X)
	self.Template.Position = UDim2.new(0.5, -math.cos(v1 + 1.5707963267948966) * (self.ScreenSize / 3), 0.5, -math.sin(v1 + 1.5707963267948966) * (self.ScreenSize / 3))
	self.Template.Rotation = math.deg(v1) + 90
	task.delay(2, function()
		-- upvalues: (copy) self
		self:cleanup()
	end)
end
function v_u1.cleanup(arg1)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_tween
	if arg1.Template and arg1.Template:IsDescendantOf(v_u_localplayer.PlayerGui) then
		v_u_tween:Create(arg1.Template, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			["ImageTransparency"] = 1
		}):Play()
		task.wait(0.5)
		arg1:destroy()
	end
end
function v_u1.new(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u3, (copy) v_u_replicatedstorage, (ref) v_u4, (copy) v_u2, (copy) v_u_tween
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u3.new()
	v_u1.Template = v_u1.Janitor:Add(v_u_replicatedstorage.Assets.UI.DamageIndicator.Template:Clone())
	v_u1.Template.Parent = v_u4
	v_u1.Template.ImageTransparency = 1
	v_u1.Template.Name = "Indicator"
	v_u1.Character = arg1
	v_u1.ScreenSize = v_u4.AbsoluteSize.X
	v_u1.Position = arg2
	v_u1.Janitor:Add(v_u2.Character.CharacterDied.Listen(function()
		-- upvalues: (copy) v_u1
		v_u1:destroy()
	end))
	if not v_u4.Visible then
		v_u4.Visible = true
	end
	v_u1:construct()
	local v_new = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	v_u_tween:Create(v_u1.Template, v_new, {
		["Size"] = UDim2.fromOffset(v_u1.ScreenSize / 3, v_u1.ScreenSize / 3),
		["ImageTransparency"] = 0.2
	}):Play()
end
function v_u1.destroy(arg1)
	arg1.Janitor:Destroy()
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u4, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u1
	v_u4 = arg2
	v_u2.UI.CreateDamageIndicator.Listen(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u1
		if v_u_localplayer.Character then
			v_u1.new(v_u_localplayer.Character, arg1)
		end
	end)
end
return v_u1