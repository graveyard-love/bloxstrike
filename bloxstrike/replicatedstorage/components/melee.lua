-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_http = game:GetService("HttpService")
local v_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Controllers.HapticsController)
local v_u3 = require(v_replicatedstorage.Controllers.SoundController)
local v_u4 = require(v_replicatedstorage.Components.Common.GetRayIgnore)
local v_u5 = require(v_replicatedstorage.Components.Common.VFXLibary.CreateMarker)
local v_u6 = require(v_replicatedstorage.Components.Common.VFXLibary.CreateImpact)
local v_u7 = require(v_replicatedstorage.Components.Common.VFXLibary.BreakGlass)
local v_u8 = require(v_replicatedstorage.Classes.WeaponComponent)
local v_u9 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u10 = require(v_replicatedstorage.Database.Security.Router)
local v_u_localplayer = v_players.LocalPlayer
local v_u_current_camera = workspace.CurrentCamera
local function v_u11(arg1, arg2)
	local v_humanoidrootpart = arg1:WaitForChild("HumanoidRootPart")
	local v_humanoidrootpart = arg2:WaitForChild("HumanoidRootPart")
	if not (v_humanoidrootpart and v_humanoidrootpart) then
		return nil
	end
	local v_dot = v_humanoidrootpart.CFrame.LookVector:Dot((v_humanoidrootpart.Position - v_humanoidrootpart.Position).Unit)
	local v_acos = math.acos(v_dot)
	return math.deg(v_acos) > 100
end
function v_u1.stopAllAnimations(arg1)
	if arg1.CharacterAnimator then
		if arg1.Viewmodel and arg1.Viewmodel.Animation then
			for v1, v2 in pairs(arg1.CharacterAnimator.Animations) do
				if v2.IsPlaying and v2.Name ~= "Idle" then
					arg1.CharacterAnimator:stop(v1)
				end
			end
			for v3, v4 in pairs(arg1.Viewmodel.Animation.Animations) do
				if v4.IsPlaying and v4.Name ~= "Idle" then
					arg1.Viewmodel.Animation:stop(v3)
				end
			end
		end
	else
		return
	end
end
function v_u1.reload(_) end
function v_u1.shoot(arg1, arg2)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u10, (copy) v_u3, (copy) v_u4, (copy) v_u_current_camera, (copy) v_u9, (copy) v_u6, (copy) v_u11, (copy) v_u7, (copy) v_u5, (copy) v_u2, (copy) v_u_http, (copy) v_u_userinput
	if tick() - arg1.WeaponEquippedTick <= 1 or v_u_localplayer:GetAttribute("Dead") then
		return
	elseif arg1.Properties.FireRate then
		if arg1.IsShooting then
			return
		else
			local v_player = arg1.Player
			if v_player then
				v_player = arg1.Player.Character
			end
			if v_player then
				arg1:stopAllAnimations()
				arg1.IsInspecting = false
				arg1.IsShooting = true
				v_u10.broadcastRouter("UpdatePlayerNoiseCone", "Melee", v_player.PrimaryPart.Position, v_u3.GetMeleeRange(arg1.Name), nil)
				local v_new = RaycastParams.new()
				v_new.FilterType = Enum.RaycastFilterType.Exclude
				v_new.FilterDescendantsInstances = v_u4()
				v_new.IgnoreWater = true
				local v1 = v_u_current_camera.CFrame.LookVector * arg1.Properties.Range
				local v_position = v_u_current_camera.CFrame.Position
				local v2 = workspace:Raycast(v_position, v1, v_new) or workspace:Spherecast(v_position, 1.5, v1, v_new)
				local v3 = arg2 and "Heavy Swing" or ("Swing%*"):format((math.random(1, 2)))
				v_u9.Spectate.ReplicateSpectateEvent.Send(v3)
				if v2 then
					local v_instance = v2.Instance
					local v_position = v2.Position
					local v_material = v2.Material
					local v_normal = v2.Normal
					local v4 = v_instance and v_instance.Parent
					if v4 then
						v4 = v_instance.Parent:FindFirstChild("Humanoid")
					end
					if v4 then
						v_u6(v_instance, "Blood Splatter", v_position, v_normal, false, true)
						v3 = arg2 and v_u11(v_u_localplayer.Character, v_instance.Parent) and "BackStab" or v3
					else
						local v_parent = v_instance.Parent
						v_u6(v_instance, v_material.Name, v_position, v_normal, false, true)
						if v_parent and v_parent:HasTag("BreakableGlass") then
							v_u7(v_instance, v_position, v1.Unit)
						else
							v_u5(v_instance, "Melee", v_position, v_normal)
						end
					end
					v_u9.Melee.MeleeAttack.Send({
						["Direction"] = v_u_current_camera.CFrame.LookVector * arg1.Properties.Range,
						["Material"] = v2.Material.Name,
						["Distance"] = v2.Distance,
						["Instance"] = v2.Instance,
						["Position"] = v2.Position,
						["Normal"] = v2.Normal,
						["MeleeAttack"] = v3,
						["Identifier"] = arg1.Identifier
					})
				end
				local v_play = arg1.Viewmodel.Animation:play(v3)
				v_u2.vibrate(Enum.VibrationMotor.Small, 1.15, 0.2)
				arg1.CharacterAnimator:play((v3 == "Swing1" or v3 == "Swing") and "Swing" or v3)
				task.delay(arg1.Properties.FireRate * (arg2 and 2.05 or 1) or v_play.Length, function()
					-- upvalues: (copy) arg1, (ref) v_u_http, (ref) v_u_localplayer, (ref) v_u_userinput
					if arg1.Identifier == v_u_http:JSONDecode(v_u_localplayer:GetAttribute("CurrentEquipped") or "[]").Identifier then
						arg1.IsShooting = false
						local v1 = v_u_userinput:IsKeyDown(Enum.KeyCode.ButtonL2) or v_u_userinput:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
						if v_u_userinput:IsKeyDown(Enum.KeyCode.ButtonR2) or v_u_userinput:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or v1 then
							arg1:shoot(v1)
						end
					end
				end)
			end
		end
	else
		return
	end
end
function v_u1.inspect(self)
	-- upvalues: (copy) v_u9
	if not (self.IsInspecting or self.IsShooting) then
		self.IsInspecting = true
		self.IsShooting = false
		self:stopAllAnimations()
		local v_inspect = self.Viewmodel.Animation:play("Inspect")
		v_u9.Spectate.ReplicateSpectateEvent.Send("Inspect")
		task.delay(v_inspect.Length, function()
			-- upvalues: (copy) self
			self.IsInspecting = false
		end)
	end
end
function v_u1.drop(_)
	return false
end
function v_u1.equip(arg1)
	arg1.Viewmodel.Animation:stopAnimations()
	arg1.CharacterAnimator:stopAnimations()
	arg1.CharacterAnimator:play("Idle")
	arg1.CharacterAnimator:play("Equip")
	arg1.WeaponEquippedTick = tick()
	arg1.Viewmodel:equip(false)
	arg1.IsInspecting = false
	arg1.IsShooting = false
end
function v_u1.unequip(arg1)
	arg1.CharacterAnimator:stopAnimations()
	arg1.Viewmodel:unequip()
	arg1.IsInspecting = false
	arg1.IsShooting = false
end
function v_u1.new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, _)
	-- upvalues: (copy) v_u8, (copy) v_u1
	local v_new = v_u8.new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
	local v1 = setmetatable(v_new, v_u1)
	v1.IsInspecting = false
	v1.IsShooting = false
	v1.AlternativeSwitchTick = 0
	v1.WeaponEquippedTick = 0
	return v1
end
function v_u1.destroy(arg1)
	-- upvalues: (copy) v_u8
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		if arg1.Janitor then
			arg1.Janitor:Destroy()
			arg1.Janitor = nil
		end
		arg1.IsInspecting = nil
		arg1.IsShooting = nil
		arg1.AlternativeSwitchTick = nil
		arg1.WeaponEquippedTick = nil
		v_u8.destroy(arg1)
	end
end
return v_u1