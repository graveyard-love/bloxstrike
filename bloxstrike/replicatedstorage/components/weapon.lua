-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_http = game:GetService("HttpService")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(v_u_replicatedstorage.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Classes.WeaponComponent)
local v3 = require(v_u_replicatedstorage.Classes.Sound)
local v_u4 = require(v_u_replicatedstorage.Components.Common.VFXLibary.CreateMuzzleFlash.Camera)
local v_u5 = require(v_u_replicatedstorage.Components.Common.VFXLibary.CreateMarker)
local v_u6 = require(v_u_replicatedstorage.Components.Common.VFXLibary.CreateImpact)
local v_u7 = require(v_u_replicatedstorage.Components.Common.VFXLibary.CreateTracer)
local v_u8 = require(v_u_replicatedstorage.Components.Common.VFXLibary.BreakGlass)
local v_u9 = require(v_u_replicatedstorage.Components.Common.GetUserPlatform)
local v_u10 = require(v_u_replicatedstorage.Controllers.HapticsController)
local v_u11 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u12 = require(v_u_replicatedstorage.Controllers.SoundController)
local v_u13 = require(v_u_replicatedstorage.Controllers.HintController)
local v_u14 = require(v_u_replicatedstorage.Database.Components.GameState)
local v_u15 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u16 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u17 = require(v_u_replicatedstorage.Database.Custom.Constants)
local v_u18 = require(script.Classes.Bullet)
local v_u_current_camera = workspace.CurrentCamera
local v_u_localplayer = v_players.LocalPlayer
local v_u_other = v3.new("Other")
local v_u19 = { 37, 60 }
local function v_u20(arg1)
	-- upvalues: (copy) v_u11
	local v_rotation = arg1.Rotation
	local v_position = arg1.Position
	local v_value = v_rotation.RotationDampen.Value
	local v_value = v_rotation.RotationSpeed.Value
	local v_value = v_rotation.RotationX.Value
	local v_value = v_rotation.RotationY.Value
	local v_value = v_rotation.RotationZ.Value
	v_u11.weaponKick({
		["Value"] = Vector3.new(v_value < 0.1 and 1 or v_value, v_value < 0.1 and 25 or v_value, v_value < 0.1 and 1 or v_value),
		["Damper"] = v_value >= 5 and 1 or v_value,
		["Speed"] = v_value >= 30 and 25 or v_value
	}, {
		["Value"] = Vector3.new(v_position.PositionX.Value, v_position.PositionY.Value, v_position.PositionZ.Value),
		["Damper"] = v_position.PositionDampen.Value,
		["Speed"] = v_position.PositionSpeed.Value
	})
end
function v_u1.isJumping(_)
	return false
end
function v_u1.getSpread(arg1)
	local v_gettruespread = arg1.Bullet:getTrueSpread()
	if arg1:isJumping() then
		return v_gettruespread + 0
	else
		return v_gettruespread
	end
end
function v_u1.getBaseSpread(arg1)
	local v_getbasespread = arg1.Bullet:getBaseSpread()
	if arg1:isJumping() then
		return v_getbasespread + 0
	else
		return v_getbasespread
	end
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
function v_u1.removeSuppressor(arg1)
	-- upvalues: (copy) v_u15
	if tick() - arg1.WeaponEquippedTick <= 1 then
		return
	elseif not (arg1.IsAdjustingSuppressor or (arg1.IsShooting or (arg1.IsReloading or arg1.IsAiming))) then
		arg1.IsAdjustingSuppressor = true
		arg1.IsBurstShooting = false
		arg1.IsInspecting = false
		arg1.IsReloading = false
		arg1.IsShooting = false
		arg1.IsAiming = false
		arg1:stopAllAnimations()
		arg1.Viewmodel.Animation:play("RemoveSuppressor")
		arg1.CharacterAnimator:play("RemoveSuppressor")
		v_u15.Spectate.ReplicateSpectateEvent.Send("Remove Suppressor")
	end
end
function v_u1.addSuppressor(arg1)
	-- upvalues: (copy) v_u15
	if tick() - arg1.WeaponEquippedTick <= 1 then
		return
	elseif not (arg1.IsAdjustingSuppressor or (arg1.IsShooting or (arg1.IsReloading or arg1.IsAiming))) then
		arg1.IsAdjustingSuppressor = true
		arg1.IsBurstShooting = false
		arg1.IsInspecting = false
		arg1.IsReloading = false
		arg1.IsShooting = false
		arg1.IsAiming = false
		arg1:stopAllAnimations()
		arg1.Viewmodel.Animation:play("AddSuppressor")
		arg1.CharacterAnimator:play("AddSuppressor")
		v_u15.Spectate.ReplicateSpectateEvent.Send("Add Suppressor")
	end
end
function v_u1.scope(arg1, arg2)
	-- upvalues: (copy) v_u_other, (copy) v_u_localplayer, (copy) v_u11, (copy) v_u17, (copy) v_u19, (copy) v_u15
	if arg1.Viewmodel then
		if tick() - arg1.WeaponEquippedTick <= 1 then
			return
		elseif arg1.IsAdjustingSuppressor or (arg1.IsReloading or arg1.IsShooting and not (arg1.Properties.AimingOptions == "AutomaticScope")) then
			return
		elseif not arg1.IsDestroyed then
			if arg1.Properties.HasScope then
				if not arg1.IsAiming then
					arg1:stopAllAnimations()
				end
				arg1.IsBurstShooting = false
				arg1.IsInspecting = false
				arg1.IsReloading = false
				arg1.IsShooting = false
				arg1.IsAiming = true
				local v_name = arg1.Name
				if v_name == "SSG 08" and true or v_name == "AWP" then
					arg1.IsSniperScoped = true
				end
				if arg1.Properties.AimingOptions == "SniperScope" then
					if not arg1.Viewmodel.Hidden then
						arg1.Viewmodel:hide()
					end
					v_u_other:play({
						["Parent"] = v_u_localplayer.PlayerGui,
						["Name"] = "Toggle Scope"
					})
					if arg2 then
						arg1.CurrentScopeIncrement = arg1.CurrentScopeIncrement + 1
						if arg1.CurrentScopeIncrement >= 3 then
							arg1:unscope()
						else
							v_u11.updateCameraFOV(v_u17.DEFAULT_CAMERA_FOV - v_u19[arg1.CurrentScopeIncrement])
							v_u15.Inventory.UpdateScopeIncrement.Send(arg1.CurrentScopeIncrement)
						end
					else
						v_u11.updateCameraFOV(v_u17.DEFAULT_CAMERA_FOV - v_u19[1])
						v_u15.Inventory.UpdateScopeIncrement.Send(1)
						return
					end
				end
				if arg1.Properties.AimingOptions == "AutomaticScope" then
					if arg1.CurrentScopeIncrement == 1 then
						arg1:unscope()
						return
					end
					arg1.CurrentScopeIncrement = 1
					if not arg1.Viewmodel.Hidden then
						arg1.Viewmodel:hide()
					end
					arg1.Viewmodel:aim()
					v_u11.updateCameraFOV(v_u17.DEFAULT_CAMERA_FOV - 15 * arg1.CurrentScopeIncrement)
					v_u15.Inventory.UpdateScopeIncrement.Send(arg1.CurrentScopeIncrement)
					v_u_other:play({
						["Parent"] = v_u_localplayer.PlayerGui,
						["Name"] = "Scope In"
					})
				end
			end
		end
	else
		return
	end
end
function v_u1.unscope(arg1, arg2)
	-- upvalues: (copy) v_u15, (copy) v_u_replicatedstorage, (copy) v_u11, (copy) v_u17, (copy) v_u_other, (copy) v_u_localplayer
	if tick() - arg1.WeaponEquippedTick <= 1 then
		return
	elseif arg1.IsAdjustingSuppressor then
		return
	elseif tick() - arg1.WeaponEquippedTick > 1 then
		if arg1.Properties.HasScope then
			if arg1.IsAiming then
				arg1:stopAllAnimations()
			end
			if arg1.CurrentScopeIncrement > 0 or arg1.IsAiming then
				v_u15.Inventory.UpdateScopeIncrement.Send(0)
			end
			if not arg2 then
				arg1.CurrentScopeIncrement = 0
			end
			arg1.IsInspecting = false
			arg1.IsReloading = false
			arg1.IsAiming = false
			local v_name = arg1.Name
			if v_name == "SSG 08" and true or v_name == "AWP" then
				arg1.IsSniperScoped = false
			end
			if arg1.Properties.AimingOptions == "SniperScope" then
				if arg1.Viewmodel.Hidden then
					arg1.Viewmodel:unhide()
				end
				local v1 = require(v_u_replicatedstorage.Controllers.CaseSceneController)
				local v2 = require(v_u_replicatedstorage.Controllers.MenuSceneController)
				if not (v1.IsActive() or v2.IsActive()) then
					v_u11.updateCameraFOV(v_u17.DEFAULT_CAMERA_FOV)
				end
				if arg2 then
					arg1.CurrentScopeIncrement = math.clamp(arg1.CurrentScopeIncrement - 1, 0, 3)
					return
				end
			elseif arg1.Properties.AimingOptions == "AutomaticScope" then
				arg1.CurrentScopeIncrement = 0
				arg1.Viewmodel:unaim()
				if arg1.Viewmodel.Hidden then
					arg1.Viewmodel:unhide()
				end
				v_u11.updateCameraFOV(v_u17.DEFAULT_CAMERA_FOV - 15 * arg1.CurrentScopeIncrement)
				v_u_other:play({
					["Parent"] = v_u_localplayer.PlayerGui,
					["Name"] = "Scope Out"
				})
			end
		end
	end
end
function v_u1.inspect(self)
	-- upvalues: (copy) v_u15
	if tick() - self.WeaponEquippedTick <= 1 then
		return
	elseif not (self.IsAdjustingSuppressor or (self.IsInspecting or (self.IsShooting or (self.IsReloading or self.IsAiming)))) then
		self.IsBurstShooting = false
		self.IsInspecting = true
		self.IsReloading = false
		self.IsShooting = false
		self.IsAiming = false
		self:stopAllAnimations()
		local v_inspect = self.Viewmodel.Animation:play("Inspect")
		v_u15.Spectate.ReplicateSpectateEvent.Send("Inspect")
		if self.InspectDelayThread then
			task.cancel(self.InspectDelayThread)
			self.InspectDelayThread = nil
		end
		self.InspectDelayThread = task.delay(v_inspect.Length, function()
			-- upvalues: (copy) self
			if not self.IsDestroyed then
				self.InspectDelayThread = nil
				self.IsInspecting = false
			end
		end)
	end
end
function v_u1.updateFireMode(arg1)
	-- upvalues: (copy) v_u_other, (copy) v_u_localplayer, (copy) v_u15, (copy) v_u16
	if tick() - arg1.WeaponEquippedTick <= 1 then
		return
	elseif not (arg1.IsShooting or (arg1.IsReloading or arg1.IsBurstShooting)) then
		v_u_other:play({
			["Name"] = "Switch Fire Mode",
			["Parent"] = v_u_localplayer.PlayerGui
		})
		arg1:stopAllAnimations()
		arg1.Viewmodel.Animation:play("Switch")
		arg1.AlternativeSwitchTick = tick()
		arg1.AlternativeShootingOption = arg1.AlternativeShootingOption == "Burst" and "Default" or "Burst"
		v_u15.Spectate.ReplicateSpectateEvent.Send("Switch Fire Mode")
		v_u16.broadcastRouter("CreateNotification", "Switched Fire Mode", arg1.AlternativeShootingOption == "Default" and "Switched to semi-automatic" or "Switched to burst-fire mode", 2.5)
	end
end
function v_u1.drop(arg1)
	-- upvalues: (copy) v_u14, (copy) v_u15, (copy) v_u_current_camera
	if workspace:GetAttribute("Gamemode") == "Deathmatch" then
		return false
	end
	if v_u14.GetState() == "Warmup" then
		return false
	end
	if not arg1.Properties.Droppable then
		return false
	end
	arg1:unequip()
	v_u15.Inventory.DropWeapon.Send({
		["Direction"] = v_u_current_camera.CFrame.LookVector,
		["Identifier"] = arg1.Identifier
	})
	return true
end
function v_u1.reload()
	-- upvalues: (copy) v_u_other, (copy) v_u_localplayer, (copy) v_u_http, (copy) v_u15, (copy) v_u13
	-- failed to decompile
end
function v_u1.shoot(self)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u11, (copy) v_u12, (copy) v_u16, (copy) v_u7, (copy) v_u4, (copy) v_u6, (copy) v_u8, (copy) v_u5, (copy) v_u20, (copy) v_u15, (copy) v_u10, (copy) v_u_userinput, (copy) v_u9
	local v_equip = self.Viewmodel.Animation:getAnimation("Equip")
	if tick() - self.WeaponEquippedTick <= v_equip.Length * 0.925 or v_u_localplayer and (v_u_localplayer.Character and v_u_localplayer.Character:GetAttribute("Dead")) then
		return
	elseif self.Properties.FireRate and self.Properties.BulletsPerShot then
		if self.IsAdjustingSuppressor then
			return
		elseif self.IsReloading and self.Properties.MuzzleType ~= "ShotGun" then
			return
		else
			local v_player = self.Player
			if v_player then
				v_player = self.Player.Character
			end
			if v_player then
				if self.CharacterAnimator then
					self.CharacterAnimator:adjustAnimationSpeed("Shoot", self.Properties.FireRate)
					if self.AlternativeShootingOption ~= "Burst" then
						self.ShootRequestTick = tick()
					end
					if self.IsShooting and self.AlternativeShootingOption == "Default" then
						return
					else
						local v_interactables = self.Viewmodel.Model:FindFirstChild("Interactables")
						if v_interactables then
							if self.Rounds <= 0 then
								self:reload()
								return
							else
								local v1 = self.IsAiming and self.Properties.AimingOptions == "AutomaticScope" and "AimShoot" or "Shoot"
								local v2 = self.Properties.HasSuppressor and not self.IsSuppressed and "NoSuppressorShoot" or "Shoot"
								v_u11.toWeaponFirePosition()
								self:stopAllAnimations()
								self.CurrentReloadIdentity = nil
								self.IsInspecting = false
								self.IsReloading = false
								self.IsShooting = true
								self.Rounds = self.Rounds - 1
								if self.Properties.ShootingOptions == "Dual" then
									self.ShootingHand = self.ShootingHand == "Left" and "Right" or "Left"
									v1 = "Shoot" .. self.ShootingHand
									v2 = "Shoot" .. self.ShootingHand
								end
								if self.Rounds <= 150 then
									local v_position = v_player.PrimaryPart.Position
									local v_hassuppressor = self.Properties.HasSuppressor
									if v_hassuppressor then
										v_hassuppressor = self.IsSuppressed
									end
									local v_getweaponshootrange = v_u12.GetWeaponShootRange(self.Name, v_hassuppressor == true)
									v_u16.broadcastRouter("UpdatePlayerNoiseCone", "Weapon", v_position, v_getweaponshootrange, nil)
									local v3 = self.Properties.ShootingOptions == "Dual" and (self.ShootingHand == "Left" and v_interactables:FindFirstChild("MuzzlePartL") or v_interactables:FindFirstChild("MuzzlePartR")) or v_interactables.MuzzlePart
									local v_position = v3.Position
									local v4 = {}
									for _ = 1, self.Properties.BulletsPerShot do
										local v_create = self.Bullet:create(self.Properties.AimingOptions, self.IsAiming)
										if v_create then
											v_u7(v_create.Distance, v_position, v_create.Direction)
											local v5
											if self.Properties.AimingOptions == "AutomaticScope" then
												v5 = self.IsAiming
											else
												v5 = false
											end
											if not v5 then
												v_u4(v3, self.Name, self.Properties.HasSuppressor and self.IsSuppressed and "Suppressor" or nil)
											end
											for _, v6 in ipairs(v_create.Hits) do
												local v_instance = v6.Instance
												local v_position = v6.Position
												local v_material = v6.Material
												local v_normal = v6.Normal
												local v_exit = v6.Exit
												local v7 = v_instance and v_instance.Parent
												if v7 then
													v7 = v_instance.Parent:FindFirstChild("Humanoid")
												end
												if v7 then
													v_u6(v_instance, "Blood Splatter", v_position, v_normal, v_exit, false)
												else
													v_u6(v_instance, v_material, v_position, v_normal, v_exit, false)
													local v_parent = v_instance.Parent
													if v_parent and (v_parent:HasTag("BreakableGlass") and not v_exit) then
														v_u8(v_instance, v_position, v_create.Direction)
													else
														v_u5(v_instance, "Bullet", v_position, v_normal)
													end
												end
											end
											table.insert(v4, v_create)
										end
									end
									if self.Viewmodel.Model.CameraShake then
										v_u20(self.Viewmodel.Model.CameraShake)
									end
									self.Viewmodel.Bobble:addScopeKick()
									if self.Viewmodel.applyCharmImpulse then
										self.Viewmodel:applyCharmImpulse(self.Viewmodel.Model.WorldPivot.LookVector * -1 + self.Viewmodel.Model.WorldPivot.UpVector * 0.3)
									end
									if self.Recoil then
										local v_recoil = self.Recoil
										v_recoil.Time = v_recoil.Time + self.Properties.FireRate
									end
									v_u15.Spectate.ReplicateSpectateEvent.Send(v2)
									local v8 = {}
									for _, v9 in ipairs(v4) do
										local v_origin = v9.Origin
										local v10 = {}
										for _, v11 in ipairs(v9.Hits) do
											table.insert(v10, {
												["Distance"] = (v11.Position - v_origin).Magnitude,
												["Instance"] = v11.Instance,
												["Position"] = v11.Position,
												["Normal"] = v11.Normal,
												["Material"] = v11.Material,
												["Exit"] = v11.Exit
											})
											v_origin = v11.Position
										end
										table.insert(v8, {
											["Direction"] = v9.Direction,
											["Origin"] = v9.Origin,
											["Hits"] = v10
										})
									end
									v_u15.Inventory.ShootWeapon.Send({
										["IsSniperScoped"] = self.IsSniperScoped,
										["ShootingHand"] = self.ShootingHand,
										["Identifier"] = self.Identifier,
										["Capacity"] = self.Capacity,
										["Bullets"] = v8,
										["Rounds"] = self.Rounds
									})
									local v_u_isaiming = self.IsAiming
									if v_u_isaiming then
										v_u_isaiming = self.Properties.AimingOptions == "SniperScope"
									end
									if v_u_isaiming then
										self:unscope(true)
									end
									local v_play = self.Viewmodel.Animation:play(v2)
									self.CharacterAnimator:play(v1)
									v_u10.vibrate(Enum.VibrationMotor.Small, 1.25, 0.225)
									if self.ShootDelayThread then
										task.cancel(self.ShootDelayThread)
										self.ShootDelayThread = nil
									end
									self.ShootDelayThread = task.delay(self.Properties.FireRate or v_play.Length, function()
										-- upvalues: (copy) self, (copy) v_u_isaiming, (ref) v_u_userinput, (ref) v_u9
										if self.IsDestroyed then
											return
										end
										self.IsShooting = false
										self.ShootDelayThread = nil
										local v1 = self
										local v2 = not v1.IsDestroyed
										if v2 then
											v2 = v1.IsEquipped == true
										end
										if not v2 then
											return
										end
										if v_u_isaiming and (self.ShootRequestTick > self.WeaponEquippedTick and self.Rounds > 0) then
											self:scope(true)
										end
										local v3 = tick()
										local v4 = math.min(0.15, self.Properties.FireRate) >= v3 - self.ShootRequestTick
										local v5 = v_u_userinput:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or v_u_userinput:IsKeyDown(Enum.KeyCode.ButtonR2)
										if not v5 and table.find(v_u9(), "Console") then
											local v_getgamepadstate = v_u_userinput:GetGamepadState(Enum.UserInputType.Gamepad1)
											for _, v6 in pairs(v_getgamepadstate) do
												if v6.KeyCode == Enum.KeyCode.ButtonR2 then
													v5 = v6.Position.Z > 0.3
													break
												end
											end
										end
										if self.Properties.Automatic and v5 and v5 or (not self.Properties.Automatic and (v4 and not v5) or false) then
											if self.Properties.ShootingOptions == "Burst" and self.AlternativeShootingOption == "Burst" then
												return
											elseif self.Rounds > 0 then
												self:shoot()
											else
												self:reload()
											end
										else
											return
										end
									end)
								end
							end
						else
							return
						end
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
function v_u1.equip(arg1)
	arg1.IsEquipped = true
	if arg1.Viewmodel.Hidden then
		arg1.Viewmodel:unhide()
	end
	arg1.Viewmodel.Animation:stopAnimations()
	arg1.CharacterAnimator:stopAnimations()
	arg1.CharacterAnimator:play("Idle")
	arg1.CharacterAnimator:play("Equip")
	arg1.WeaponEquippedTick = tick()
	arg1.Viewmodel:equip(false)
	arg1.CurrentScopeIncrement = 0
	arg1.IsBurstShooting = false
	arg1.IsInspecting = false
	arg1.IsReloading = false
	arg1.IsShooting = false
	arg1.IsAiming = false
	arg1.IsAdjustingSuppressor = false
	local v_name = arg1.Name
	if v_name == "SSG 08" and true or v_name == "AWP" then
		arg1.IsSniperScoped = false
	end
end
function v_u1.unequip(arg1)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u11, (copy) v_u17
	arg1.IsEquipped = false
	if arg1.ShootDelayThread then
		task.cancel(arg1.ShootDelayThread)
		arg1.ShootDelayThread = nil
	end
	local v1 = require(v_u_replicatedstorage.Controllers.CaseSceneController)
	local v2 = require(v_u_replicatedstorage.Controllers.MenuSceneController)
	if not (v1.IsActive() or v2.IsActive()) then
		v_u11.updateCameraFOV(v_u17.DEFAULT_CAMERA_FOV)
	end
	arg1.CharacterAnimator:stopAnimations()
	arg1.Viewmodel:unequip()
	if arg1.IsAiming then
		arg1:unscope()
	end
	if arg1.Viewmodel.Hidden then
		arg1.Viewmodel:unhide()
	end
	arg1.IsBurstShooting = false
	arg1.IsInspecting = false
	arg1.IsReloading = false
	arg1.IsShooting = false
	arg1.IsAiming = false
	arg1.IsAdjustingSuppressor = false
	local v_name = arg1.Name
	if v_name == "SSG 08" and true or v_name == "AWP" then
		arg1.IsSniperScoped = false
	end
	if arg1.Recoil then
		arg1.Recoil.Value = Vector2.zero
		arg1.Recoil.RecoveryStartTime = 0
		arg1.Recoil.Time = 0
	end
end
function v_u1.createSuppressor(self)
	-- upvalues: (copy) v_u15
	local v_u_silencer = self.Viewmodel.Model:FindFirstChild("Silencer", true)
	if v_u_silencer then
		v_u_silencer.Transparency = self.IsSuppressed and 0 or 1
		local v_u_identifier = self.Identifier
		local v_freeze = table.freeze({
			{
				["AnimationTrack"] = self.Viewmodel.Animation:getAnimation("RemoveSuppressor"),
				["State"] = false,
				["Event"] = function(arg1)
					-- upvalues: (copy) self, (copy) v_u_silencer, (ref) v_u15, (copy) v_u_identifier
					return arg1:GetMarkerReachedSignal("ScrewOnEnd"):Connect(function()
						-- upvalues: (ref) self, (ref) v_u_silencer, (ref) v_u15, (ref) v_u_identifier
						if not self.IsDestroyed then
							v_u_silencer.Transparency = 1
							v_u15.Inventory.UpdateWeaponSuppressor.Send({
								["Identifier"] = v_u_identifier,
								["State"] = false
							})
						end
					end)
				end
			},
			{
				["AnimationTrack"] = self.Viewmodel.Animation:getAnimation("AddSuppressor"),
				["State"] = true,
				["Event"] = function(self)
					-- upvalues: (copy) self, (copy) v_u_silencer, (ref) v_u15, (copy) v_u_identifier
					return self:GetPropertyChangedSignal("IsPlaying"):Connect(function()
						-- upvalues: (copy) self, (ref) self, (ref) v_u_silencer, (ref) v_u15, (ref) v_u_identifier
						if self.IsPlaying then
							if self.SuppressorDelayThread then
								task.cancel(self.SuppressorDelayThread)
							end
							self.SuppressorDelayThread = task.delay(0.016666666666666666, function()
								-- upvalues: (ref) self, (ref) v_u_silencer, (ref) v_u15, (ref) v_u_identifier
								if not self.IsDestroyed then
									if not self.IsDestroyed then
										v_u_silencer.Transparency = 0
										v_u15.Inventory.UpdateWeaponSuppressor.Send({
											["Identifier"] = v_u_identifier,
											["State"] = true
										})
									end
									self.SuppressorDelayThread = nil
								end
							end)
						end
					end)
				end
			}
		})
		for _, v_u1 in ipairs(v_freeze) do
			self.Janitor:Add(v_u1.Event(v_u1.AnimationTrack))
			self.Janitor:Add(v_u1.AnimationTrack.Ended:Connect(function()
				-- upvalues: (copy) v_u_silencer, (copy) self, (copy) v_u1, (ref) v_u15, (copy) v_u_identifier
				self.IsAdjustingSuppressor = false
				if v_u1.State == (v_u_silencer.Transparency < 1) then
					local v1 = v_u1.State and 0 or 1
					if not self.IsDestroyed then
						v_u_silencer.Transparency = v1
						v_u15.Inventory.UpdateWeaponSuppressor.Send({
							["Identifier"] = v_u_identifier,
							["State"] = v1 == 0
						})
					end
					self.IsSuppressed = v_u1.State
				end
			end))
		end
	end
end
function v_u1.setupRecoil(self)
	-- upvalues: (copy) v_u_run, (copy) v_u11
	local v_recoil = self.Properties.Recoil
	if self.Properties.Recoil then
		local v_u_recoveryspeed = v_recoil.RecoverySpeed
		local v_u_scale = v_recoil.Scale
		local v_u_damper = v_recoil.Damper
		local v_u_speed = v_recoil.Speed
		local v_u_camerascale = v_recoil.CameraScale
		local v_u_identifier = self.Identifier
		self.Recoil = {
			["Function"] = v_recoil.Pattern(self.Properties),
			["Value"] = Vector2.zero,
			["RotationValue"] = Vector3.new(0, 0, 0),
			["Time"] = 0,
			["RecoveryValue"] = Vector2.zero,
			["RecoveryTime"] = 0,
			["RecoveryStartTime"] = 0
		}
		local v_u_recoil = self.Recoil
		self.Janitor:Add(v_u_run.Stepped:Connect(function(_, arg2)
			-- upvalues: (copy) self, (copy) v_u_recoil, (copy) v_u_recoveryspeed, (copy) v_u_scale, (copy) v_u_identifier, (ref) v_u11, (copy) v_u_damper, (copy) v_u_speed, (copy) v_u_camerascale
			if not self.IsDestroyed and v_u_recoil then
				local v_function = v_u_recoil.Function(v_u_recoil.Time)
				if self.IsShooting then
					v_u_recoil.Value = v_function
					v_u_recoil.RecoveryValue = v_function
					v_u_recoil.RecoveryTime = v_u_recoil.Time
					v_u_recoil.RecoveryStartTime = os.clock()
				else
					local v1 = v_u_recoil.RecoveryValue.Magnitude / v_u_recoveryspeed
					if v_u_recoil.Value.Magnitude > 0 and v1 > 0 then
						v_u_recoil.Value = v_u_recoil.RecoveryValue:Lerp(Vector2.zero, (math.clamp((os.clock() - v_u_recoil.RecoveryStartTime) / v1, 0, 1)))
					end
					if v_u_recoil.Time > 0 then
						v_u_recoil.Time = math.max(v_u_recoil.Time - v_u_recoil.RecoveryTime * v_u_recoveryspeed * arg2, 0)
					end
				end
				v_u_recoil.RotationValue = Vector3.new(v_u_recoil.Value.Y, v_u_recoil.Value.X, 0) * math.rad(v_u_scale)
				if not self.IsDestroyed and (self.IsEquipped and self.Identifier == v_u_identifier) then
					v_u11.setWeaponRecoil({
						["Value"] = UNNAMED_1728996793208,
						["Damper"] = v_u_damper,
						["Speed"] = v_u_speed
					}, v_u_camerascale)
				end
			end
		end), "Disconnect", "RecoilConnection")
	end
end
function v_u1.new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
	-- upvalues: (copy) v_u2, (copy) v_u1, (copy) v_u18, (copy) v_u_replicatedstorage, (copy) v_u11, (copy) v_u17
	local v_new = v_u2.new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
	local v_u1 = setmetatable(v_new, v_u1)
	v_u1.IsEquipped = false
	local v2 = arg13 or {}
	v_u1.Bullet = v_u18.new(v_u1, v_u1.Properties)
	v_u1.Capacity = v2.Capacity or v_u1.Properties.Capacity
	v_u1.Rounds = v2.Rounds or v_u1.Properties.Rounds
	v_u1.CurrentReloadIdentity = nil
	v_u1.AlternativeShootingOption = "Default"
	v_u1.AlternativeSwitchTick = 0
	v_u1.IsBurstShooting = false
	v_u1.ShootingHand = "Right"
	v_u1.IsAdjustingSuppressor = false
	v_u1.IsInspecting = false
	v_u1.IsReloading = false
	v_u1.IsShooting = false
	v_u1.IsAiming = false
	v_u1.IsSuppressed = v2.IsSuppressed ~= nil and v2.IsSuppressed or v_u1.Properties.HasSuppressor
	v_u1.IsSniperScoped = false
	v_u1.ReloadTrackFinishedConnection = nil
	v_u1.ShootDelayThread = nil
	v_u1.InspectDelayThread = nil
	v_u1.SuppressorDelayThread = nil
	v_u1.CurrentScopeIncrement = 0
	v_u1.WeaponEquippedTick = 0
	v_u1.ShootRequestTick = 0
	v_u1.ReloadStartTick = 0
	v_u1:setupRecoil()
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1, (ref) v_u_replicatedstorage, (ref) v_u11, (ref) v_u17
		if v_u1.Bullet then
			v_u1.Bullet:destroy()
			v_u1.Bullet = nil
		end
		if v_u1.IsAiming then
			local v1 = require(v_u_replicatedstorage.Controllers.CaseSceneController)
			local v2 = require(v_u_replicatedstorage.Controllers.MenuSceneController)
			if not (v1.IsActive() or v2.IsActive()) then
				v_u11.updateCameraFOV(v_u17.DEFAULT_CAMERA_FOV)
			end
		end
	end)
	if v_u1.Properties.HasSuppressor then
		v_u1:createSuppressor()
	end
	return v_u1
end
function v_u1.destroy(arg1)
	-- upvalues: (copy) v_u2
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		if arg1.ReloadTrackFinishedConnection and arg1.ReloadTrackFinishedConnection.Connected then
			arg1.ReloadTrackFinishedConnection:Disconnect()
			arg1.ReloadTrackFinishedConnection = nil
		end
		if arg1.ShootDelayThread then
			task.cancel(arg1.ShootDelayThread)
			arg1.ShootDelayThread = nil
		end
		if arg1.InspectDelayThread then
			task.cancel(arg1.InspectDelayThread)
			arg1.InspectDelayThread = nil
		end
		if arg1.SuppressorDelayThread then
			task.cancel(arg1.SuppressorDelayThread)
			arg1.SuppressorDelayThread = nil
		end
		if arg1.Recoil then
			arg1.Recoil.RecoveryStartTime = nil
			arg1.Recoil.RotationValue = nil
			arg1.Recoil.RecoveryValue = nil
			arg1.Recoil.RecoveryTime = nil
			arg1.Recoil.Function = nil
			arg1.Recoil.Value = nil
			arg1.Recoil.Time = nil
			arg1.Recoil = nil
		end
		if arg1.Bullet then
			arg1.Bullet:destroy()
			arg1.Bullet = nil
		end
		arg1.Janitor:Destroy()
		arg1.Janitor = nil
		arg1.AlternativeShootingOption = nil
		arg1.AlternativeSwitchTick = nil
		arg1.CurrentReloadIdentity = nil
		arg1.CurrentScopeIncrement = nil
		arg1.WeaponEquippedTick = nil
		arg1.ShootRequestTick = nil
		arg1.ReloadStartTick = nil
		arg1.ShootingHand = nil
		v_u2.destroy(arg1)
	end
end
return v_u1