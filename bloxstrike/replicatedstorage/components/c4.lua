-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Classes.WeaponComponent)
local v_u3 = require(v_replicatedstorage.Database.Components.GameState)
local v_u4 = require(v_replicatedstorage.Classes.Sound)
local v_u5 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u6 = require(v_replicatedstorage.Database.Security.Router)
local v_u_current_camera = workspace.CurrentCamera
local v_u_debris = workspace:WaitForChild("Debris")
local v_u7 = nil
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local function v_u8()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_new, (copy) v_u_current_camera, (copy) v_u_debris
	local v_character = v_u_localplayer.Character
	v_u_new.FilterDescendantsInstances = { v_character, v_u_current_camera, v_u_debris }
	local v1
	if v_character and v_character:IsDescendantOf(workspace) then
		local v_humanoid = v_character:FindFirstChild("Humanoid")
		v1 = v_humanoid and v_humanoid.Health > 0 and true or false
	else
		v1 = false
	end
	if v1 then
		local v_humanoid = v_character:FindFirstChild("Humanoid")
		if v_humanoid then
			local v_getstate = v_humanoid:GetState()
			if v_getstate == Enum.HumanoidStateType.Freefall or v_getstate == Enum.HumanoidStateType.Jumping then
				return false
			end
		end
		local v_primarypart = v_character.PrimaryPart
		local v2 = v_primarypart and (v_primarypart.Position and workspace:Raycast(v_primarypart.Position, Vector3.new(-0, -5, -0), v_u_new))
		if v2 then
			local v_instance = v2.Instance
			if v_instance:HasTag("PlantArea") and v_instance:GetAttribute("Site") then
				return true
			end
		end
	end
	return false
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
function v_u1.shoot(self)
	-- upvalues: (copy) v_u8, (copy) v_u5, (copy) v_u6, (copy) v_u_localplayer, (copy) v_u4
	local v1 = tick()
	if self.Janitor:Get("BombAnimationEnded") then
		self.Janitor:Remove("BombAnimationEnded")
	end
	if v1 - self.PlantStartedTick > 1.5 then
		if v_u8() then
			self.IsInspecting = false
			self.IsPlanting = true
			self.PlantStartedTick = v1
			self:stopAllAnimations()
			v_u5.Spectate.ReplicateSpectateEvent.Send("Use")
			local v_use = self.Viewmodel.Animation:play("Use")
			v_u5.Spectate.ReplicateSpectateEvent.Send("Use")
			self.CharacterAnimator:play("Use")
			v_u5.C4.Start.Send(self.Identifier)
			v_u6.broadcastRouter("Plant Bomb")
			self.Viewmodel.Sound:play({
				["Parent"] = v_u_localplayer.PlayerGui,
				["Name"] = "Planting"
			})
			v_u4.new("Terrorists"):playOneTime({
				["Parent"] = v_u_localplayer.PlayerGui,
				["Name"] = "Planting bomb"
			})
			self.Janitor:Add(v_use.Ended:Connect(function()
				-- upvalues: (copy) self, (ref) v_u8, (ref) v_u5, (ref) v_u6
				if self.IsPlanting then
					if v_u8() then
						v_u5.C4.Planted.Send(self.Identifier)
						self.IsPlanting = false
					end
					v_u6.broadcastRouter("Cancel Bomb Plant")
				end
			end), "Disconnect", "BombAnimationEnded")
		end
	end
end
function v_u1.cancel(arg1)
	-- upvalues: (copy) v_u5, (copy) v_u6
	if arg1.IsPlanting then
		arg1.Viewmodel.Model.Weapon.Interactive.SurfaceGui.TextLabel.Text = "*******"
		arg1.IsPlanting = false
		arg1:stopAllAnimations()
		v_u5.Spectate.ReplicateSpectateEvent.Send("Cancel Plant")
		v_u5.C4.Cancel.Send(arg1.Identifier)
		v_u6.broadcastRouter("Cancel Bomb Plant")
		if arg1.Janitor:Get("BombAnimationEnded") then
			arg1.Janitor:Remove("BombAnimationEnded")
		end
	end
end
function v_u1.inspect(self)
	-- upvalues: (copy) v_u5
	if not (self.IsInspecting or self.IsPlanting) then
		self.IsInspecting = true
		self:stopAllAnimations()
		local v_inspect = self.Viewmodel.Animation:play("Inspect")
		v_u5.Spectate.ReplicateSpectateEvent.Send("Inspect")
		task.delay(v_inspect.Length, function()
			-- upvalues: (copy) self
			self.IsInspecting = false
		end)
	end
end
function v_u1.drop(arg1)
	-- upvalues: (copy) v_u3, (copy) v_u5, (copy) v_u_current_camera
	if workspace:GetAttribute("Gamemode") == "Deathmatch" then
		return false
	end
	if v_u3.GetState() == "Warmup" then
		return false
	end
	if arg1.IsPlanting then
		return false
	end
	if not arg1.Properties.Droppable then
		return false
	end
	arg1:unequip()
	v_u5.Inventory.DropWeapon.Send({
		["Direction"] = v_u_current_camera.CFrame.LookVector,
		["Identifier"] = arg1.Identifier
	})
	return true
end
function v_u1.equip(arg1)
	-- upvalues: (ref) v_u7
	arg1.Viewmodel.Animation:stopAnimations()
	arg1.CharacterAnimator:stopAnimations()
	arg1.CharacterAnimator:play("Idle")
	arg1.CharacterAnimator:play("Equip")
	arg1.Viewmodel:equip(false)
	v_u7 = arg1
end
function v_u1.unequip(arg1)
	-- upvalues: (ref) v_u7
	if arg1.IsPlanting then
		arg1:cancel()
	end
	arg1.CharacterAnimator:stopAnimations()
	arg1.Viewmodel:unequip()
	if v_u7 and v_u7 == arg1 then
		v_u7 = nil
	end
end
function v_u1.new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, _)
	-- upvalues: (copy) v_u2, (copy) v_u1, (copy) v_u_run, (copy) v_u8
	local v_new = v_u2.new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
	local v_u1 = setmetatable(v_new, v_u1)
	v_u1.IsInspecting = false
	v_u1.IsPlanting = false
	v_u1.PlantStartedTick = 0
	v_u1.Janitor:Add(v_u_run.Heartbeat:Connect(function(_)
		-- upvalues: (copy) v_u1, (ref) v_u8
		if v_u1.IsPlanting and not v_u8() then
			v_u1:cancel()
		end
	end))
	return v_u1
end
function v_u1.destroy(arg1)
	-- upvalues: (ref) v_u7, (copy) v_u2
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		if arg1.IsPlanting then
			arg1:cancel()
		end
		if v_u7 and v_u7 == arg1 then
			v_u7 = nil
		end
		if arg1.Janitor then
			arg1.Janitor:Destroy()
			arg1.Janitor = nil
		end
		arg1.PlantStartedTick = nil
		arg1.IsInspecting = nil
		arg1.IsPlanting = nil
		v_u2.destroy(arg1)
	end
end
v_u5.C4.ForceCancel.Listen(function()
	-- upvalues: (ref) v_u7
	if v_u7 and v_u7.IsPlanting then
		v_u7:cancel()
	end
end)
return v_u1