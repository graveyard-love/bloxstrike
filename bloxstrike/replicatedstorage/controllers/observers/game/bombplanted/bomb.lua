-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.HapticsController)
local v_u3 = require(v_replicatedstorage.Controllers.CameraController)
local v_u4 = require(v_replicatedstorage.Classes.Sound)
local v_u5 = require(v_replicatedstorage.Database.Security.Router)
local v_u6 = require(v_replicatedstorage.Shared.Janitor)
local v_u_current_camera = workspace.CurrentCamera
function v_u1.updateHeartbeat(arg1, arg2)
	-- upvalues: (copy) v_u_current_camera
	if arg1.Model:GetAttribute("IsGettingDefused") then
		return
	elseif arg2.PrimaryPart and arg1.Model.PrimaryPart then
		if (arg2.PrimaryPart.Position - arg1.Model.PrimaryPart.Position).Magnitude > 5 then
			arg1.Model:SetAttribute("CanDefuse", false)
			return
		elseif (arg1.Model.PrimaryPart.Position - v_u_current_camera.CFrame.Position).Magnitude > 0 then
			if v_u_current_camera.CFrame.LookVector:Dot(UNNAMED_1729001169496 / UNNAMED_1729001171464) >= 0.966 then
				arg1.Model:SetAttribute("CanDefuse", true)
			else
				arg1.Model:SetAttribute("CanDefuse", false)
			end
		else
			arg1.Model:SetAttribute("CanDefuse", false)
			return
		end
	else
		return
	end
end
function v_u1.new(arg1)
	-- upvalues: (copy) v_u1, (copy) v_u6, (copy) v_u4, (copy) v_u_http, (copy) v_u5, (copy) v_u_localplayer, (copy) v_u3, (copy) v_u2, (copy) v_u_run
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u6.new()
	v_u1.Sound = v_u4.new("C4")
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1
		v_u1.Sound:destroy()
	end)
	v_u1.Model = arg1
	v_u1.Data = v_u_http:JSONDecode(arg1:GetAttribute("BombPlanted"))
	v_u1.ExplodeAt = v_u1.Data.Time + v_u1.Data.TimeUntilExplode
	v_u1.TimeUntilExplode = v_u1.Data.TimeUntilExplode
	v_u1.MinimumInterval = 0.15
	v_u1.NextBeepAt = 0
	v_u1.Elapsed = 0
	v_u1.IsDefused = false
	v_u5.broadcastRouter("CreateNotification", "Bomb", "The bomb has been planted.", 2.5)
	for _, v2 in ipairs(v_u1.Model:GetDescendants()) do
		if v2:IsA("BasePart") then
			v2.CanQuery = true
		end
	end
	v_u1.Janitor:Add(v_u1.Model:GetAttributeChangedSignal("Defused"):Connect(function()
		-- upvalues: (ref) v_u5, (copy) v_u1
		v_u5.broadcastRouter("CreateNotification", "Bomb", "The bomb has been defused.", 2.5)
		v_u1.IsDefused = true
	end))
	v_u1.Janitor:Add(v_u1.Model:GetAttributeChangedSignal("Exploding"):Connect(function()
		-- upvalues: (ref) v_u5
		v_u5.broadcastRouter("Cancel Defuse Bomb")
	end))
	v_u1.Janitor:Add(v_u1.Model:GetAttributeChangedSignal("Exploded"):Connect(function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u3, (copy) v_u1, (ref) v_u2
		local v_character = v_u_localplayer.Character
		if v_character and v_character:IsDescendantOf(workspace) then
			local v_humanoid = v_character:FindFirstChild("Humanoid")
			if v_humanoid and v_humanoid.Health > 0 then
				v_u3.BombExploded((v_u1.Model.PrimaryPart.Position - v_character.PrimaryPart.Position).Magnitude)
				v_u2.vibrate(Enum.VibrationMotor.Large, 1.5, 0.25)
			end
		end
	end))
	v_u1.Janitor:Add(v_u_run.Heartbeat:Connect(function(_)
		-- upvalues: (ref) v_u_localplayer, (copy) v_u1
		local v_character = v_u_localplayer.Character
		if v_character and v_character:IsDescendantOf(workspace) then
			local v_humanoid = v_character:FindFirstChild("Humanoid")
			if v_humanoid and (v_humanoid.Health > 0 and v_u_localplayer:GetAttribute("Team") == "Counter-Terrorists") then
				v_u1:updateHeartbeat(v_character)
			end
		end
	end))
	v_u1.Janitor:Add(v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		local v1 = v_u1
		v1.Elapsed = v1.Elapsed + arg1
		local v_weapon = v_u1.Model:FindFirstChild("Weapon")
		if v_weapon then
			v_weapon = v_u1.Model.Weapon:FindFirstChild("FlashingLight")
		end
		if v_u1.IsDefused or v_u1.Elapsed >= v_u1.TimeUntilExplode then
			if v_weapon and (v_weapon:FindFirstChild("Attachment") and v_weapon.Attachment:FindFirstChild("PointLight")) then
				v_weapon.Attachment.PointLight.Enabled = not v_weapon.Attachment.PointLight.Enabled
			end
		elseif v_u1.Elapsed >= v_u1.NextBeepAt then
			local v2 = v_u1
			local v_elapsed = v_u1.Elapsed
			local v_max = math.max(v_u1.TimeUntilExplode - v_u1.Elapsed, 0)
			local v_minimuminterval = v_u1.MinimumInterval
			local v3 = v_max / v_u1.TimeUntilExplode * 0.9 + 0.1
			if v3 > v_minimuminterval then
				v_minimuminterval = v3
			end
			v2.NextBeepAt = v_elapsed + v_minimuminterval
			if v_weapon and (v_weapon:FindFirstChild("Attachment") and v_weapon.Attachment:FindFirstChild("PointLight")) then
				v_weapon.Attachment.PointLight.Enabled = not v_weapon.Attachment.PointLight.Enabled
			end
			local v_model = v_u1.Model
			if v_model then
				v_model = v_u1.Model.PrimaryPart
			end
			if not v_model then
				return
			end
			v_u1.Sound:play({
				["Parent"] = v_model,
				["Name"] = "Beep"
			})
		end
	end))
	return v_u1
end
function v_u1.destroy(arg1)
	arg1.Janitor:Destroy()
end
return v_u1