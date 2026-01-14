-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
require(v_replicatedstorage.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Classes.WeaponComponent)
local v_u3 = require(v_replicatedstorage.Database.Components.GameState)
local v_u4 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u_current_camera = workspace.CurrentCamera
local v_u_localplayer = game:GetService("Players").LocalPlayer
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
function v_u1.StartThrow(arg1)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_current_camera
	if arg1.IsDestroyed then
		return
	elseif arg1.ThrowStarted and not arg1.ThrowFinished then
		return
	else
		if arg1.ThrowFinished then
			arg1.ThrowFinished = false
			arg1.ThrowStarted = false
			if arg1.Janitor:Get("ThrowGrenadeFinished") then
				arg1.Janitor:Remove("ThrowGrenadeFinished")
			end
			if arg1.Janitor:Get("ThrowGrenadeStoppedFallback") then
				arg1.Janitor:Remove("ThrowGrenadeStoppedFallback")
			end
		end
		if v_u_localplayer and (v_u_localplayer.Character and v_u_localplayer.Character:GetAttribute("Dead")) then
			return
		else
			arg1.ThrowStarted = true
			if arg1.Viewmodel then
				if arg1.Viewmodel.IsDestroyed then
					return
				elseif arg1.Viewmodel.Model then
					if arg1.Viewmodel.Model.Parent ~= v_u_current_camera then
						if arg1.Viewmodel.IsDestroyed or not arg1.Viewmodel.equip then
							return
						end
						arg1.Viewmodel:equip(false)
					end
					if arg1.Viewmodel.Hidden then
						arg1.Viewmodel:unhide()
					end
					if not arg1.Viewmodel.IsDestroyed then
						local v_equip = arg1.Viewmodel.Animation.Animations.Equip
						if v_equip then
							v_equip = v_equip.IsPlaying
						end
						if v_equip then
							for v1, v2 in pairs(arg1.Viewmodel.Animation.Animations) do
								if v2.IsPlaying and (v2.Name ~= "Idle" and v2.Name ~= "Equip") then
									arg1.Viewmodel.Animation:stop(v1)
								end
							end
							for v3, v4 in pairs(arg1.CharacterAnimator.Animations) do
								if v4.IsPlaying and (v4.Name ~= "Idle" and v4.Name ~= "Equip") then
									arg1.CharacterAnimator:stop(v3)
								end
							end
						else
							arg1:stopAllAnimations()
						end
						arg1.CharacterAnimator:play("StartThrow")
						arg1.CharacterAnimator:play("ThrowIdle")
						if arg1.Viewmodel and (not arg1.Viewmodel.IsDestroyed and (arg1.Viewmodel.Model and arg1.Viewmodel.Model.Parent == v_u_current_camera)) then
							arg1.Viewmodel.Animation:play("StartThrow")
							arg1.Viewmodel.Animation:play("ThrowIdle")
						end
					end
				else
					return
				end
			else
				return
			end
		end
	end
end
function v_u1.Throw(arg1, arg2)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_current_camera, (copy) v_u_run, (copy) v_u4
	if arg1.ThrowFinished then
		return
	elseif v_u_localplayer and (v_u_localplayer.Character and v_u_localplayer.Character:GetAttribute("Dead")) then
		return
	elseif arg1.Viewmodel and (not arg1.Viewmodel.IsDestroyed and arg1.Viewmodel.Model) then
		if arg1.Viewmodel.Model.Parent ~= v_u_current_camera then
			if arg1.Viewmodel.IsDestroyed or not arg1.Viewmodel.equip then
				arg1.ThrowStarted = false
				return
			end
			arg1.Viewmodel:equip(false)
			v_u_run.Heartbeat:Wait()
			if arg1.Viewmodel.Model.Parent ~= v_u_current_camera then
				arg1.ThrowStarted = false
				return
			end
		end
		if arg1.Viewmodel.Hidden then
			arg1.Viewmodel:unhide()
		end
		if arg1.Viewmodel.Animation then
			if arg1.Janitor:Get("ThrowGrenadeFinished") then
				arg1.Janitor:Remove("ThrowGrenadeFinished")
			end
			if arg1.Janitor:Get("ThrowGrenadeStoppedFallback") then
				arg1.Janitor:Remove("ThrowGrenadeStoppedFallback")
			end
			local v_equip = arg1.Viewmodel.Animation.Animations.Equip
			if v_equip then
				v_equip = v_equip.IsPlaying
			end
			if v_equip then
				arg1.Viewmodel.Animation:stop("Equip")
				arg1.CharacterAnimator:stop("Equip")
				for v1, v2 in pairs(arg1.Viewmodel.Animation.Animations) do
					if v2.IsPlaying and v2.Name ~= "Idle" then
						arg1.Viewmodel.Animation:stop(v1)
					end
				end
				for v3, v4 in pairs(arg1.CharacterAnimator.Animations) do
					if v4.IsPlaying and v4.Name ~= "Idle" then
						arg1.CharacterAnimator:stop(v3)
					end
				end
				v_u_run.Heartbeat:Wait()
			else
				if arg1.Viewmodel.Animation.Animations.StartThrow then
					arg1.Viewmodel.Animation:stop("StartThrow")
				end
				if arg1.CharacterAnimator.Animations.StartThrow then
					arg1.CharacterAnimator:stop("StartThrow")
				end
			end
			if arg1.Viewmodel and (not arg1.Viewmodel.IsDestroyed and arg1.Viewmodel.Animation) then
				local v_play = arg1.Viewmodel.Animation:play(arg2)
				if v_play then
					local v5 = tick()
					while v_play.Length == 0 and tick() - v5 < 0.5 do
						v_u_run.Heartbeat:Wait()
					end
					if arg1.IsDestroyed or (not arg1.Viewmodel or arg1.Viewmodel.IsDestroyed) then
						arg1.ThrowStarted = false
						return
					else
						arg1.CharacterAnimator:play("Throw")
						arg1.ThrowCompleted = false
						local function v_u6()
							-- upvalues: (copy) arg1, (ref) v_u4, (ref) v_u_current_camera, (copy) arg2
							if arg1.ThrowCompleted then
								return
							else
								arg1.ThrowCompleted = true
								if not arg1.IsDestroyed and arg1.Identifier then
									arg1.ThrowFinished = true
									arg1.ThrowStarted = false
									v_u4.Inventory.ThrowGrenade.Send({
										["Direction"] = v_u_current_camera.CFrame.LookVector,
										["Position"] = v_u_current_camera.CFrame.Position,
										["Identifier"] = arg1.Identifier,
										["Animation"] = arg2
									})
								end
							end
						end
						if v_play and v_play.IsPlaying then
							arg1.Janitor:Add(v_play:GetMarkerReachedSignal("Throw"):Once(function()
								-- upvalues: (copy) v_u6
								v_u6()
							end), "Disconnect", "ThrowGrenadeFinished")
							arg1.Janitor:Add(v_play.Stopped:Once(function()
								-- upvalues: (copy) arg1, (copy) v_u6
								task.delay(0.05, function()
									-- upvalues: (ref) arg1, (ref) v_u6
									if not (arg1.ThrowCompleted or arg1.IsDestroyed) then
										v_u6()
									end
								end)
							end), "Disconnect", "ThrowGrenadeStoppedFallback")
							if v_play.Length > 0 then
								task.delay(v_play.Length * 0.7, function()
									-- upvalues: (copy) arg1, (copy) v_u6
									if not arg1.ThrowCompleted and (not arg1.IsDestroyed and (arg1.ThrowStarted and not arg1.ThrowFinished)) then
										v_u6()
									end
								end)
							end
							task.delay(2, function()
								-- upvalues: (copy) arg1, (copy) v_u6
								if not arg1.ThrowCompleted and (not arg1.IsDestroyed and (arg1.ThrowStarted and not arg1.ThrowFinished)) then
									v_u6()
								end
							end)
						else
							arg1.ThrowStarted = false
						end
					end
				else
					arg1.ThrowStarted = false
					return
				end
			else
				arg1.ThrowStarted = false
				return
			end
		else
			arg1.ThrowStarted = false
			return
		end
	else
		arg1.ThrowStarted = false
		return
	end
end
function v_u1.Cancel(arg1)
	if not arg1.ThrowFinished then
		if arg1.Janitor:Get("ThrowGrenadeFinished") then
			arg1.Janitor:Remove("ThrowGrenadeFinished")
		end
		if arg1.Janitor:Get("ThrowGrenadeStoppedFallback") then
			arg1.Janitor:Remove("ThrowGrenadeStoppedFallback")
		end
		arg1.ThrowFinished = false
		arg1.ThrowStarted = false
		arg1.ThrowCompleted = false
		arg1:stopAllAnimations()
	end
end
function v_u1.inspect(self)
	-- upvalues: (copy) v_u4
	if not self.IsInspecting then
		if self.ThrowStarted and not self.ThrowFinished then
			self:Cancel()
		end
		self.IsInspecting = true
		self:stopAllAnimations()
		local v_inspect = self.Viewmodel.Animation:play("Inspect")
		v_u4.Spectate.ReplicateSpectateEvent.Send("Inspect")
		task.delay(v_inspect.Length, function()
			-- upvalues: (copy) self
			self.IsInspecting = false
		end)
	end
end
function v_u1.reload(_) end
function v_u1.drop(arg1)
	-- upvalues: (copy) v_u3, (copy) v_u4, (copy) v_u_current_camera
	if workspace:GetAttribute("Gamemode") == "Deathmatch" then
		return false
	end
	if v_u3.GetState() == "Warmup" then
		return false
	end
	if not arg1.Properties.Droppable then
		return false
	end
	arg1:unequip()
	v_u4.Inventory.DropWeapon.Send({
		["Direction"] = v_u_current_camera.CFrame.LookVector,
		["Identifier"] = arg1.Identifier
	})
	return true
end
function v_u1.equip(arg1)
	arg1.Viewmodel.Animation:stopAnimations()
	arg1.CharacterAnimator:stopAnimations()
	arg1.ThrowStarted = false
	arg1.ThrowFinished = false
	arg1.ThrowCompleted = false
	arg1.CharacterAnimator:play("Idle")
	arg1.CharacterAnimator:play("Equip")
	arg1.Viewmodel:equip(false)
end
function v_u1.unequip(arg1)
	arg1.CharacterAnimator:stopAnimations()
	arg1.Viewmodel:unequip()
	arg1.IsInspecting = false
	if arg1.ThrowStarted and not arg1.ThrowFinished then
		arg1:Cancel()
	end
end
function v_u1.new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, _)
	-- upvalues: (copy) v_u2, (copy) v_u1
	local v_new = v_u2.new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
	local v1 = setmetatable(v_new, v_u1)
	v1.IsInspecting = false
	v1.ThrowStarted = false
	v1.ThrowFinished = false
	v1.ThrowCompleted = false
	return v1
end
function v_u1.destroy(arg1)
	-- upvalues: (copy) v_u2
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		if arg1.Janitor then
			arg1.Janitor:Destroy()
			arg1.Janitor = nil
		end
		arg1.ThrowFinished = nil
		arg1.ThrowStarted = nil
		arg1.ThrowCompleted = nil
		arg1.IsInspecting = nil
		v_u2.destroy(arg1)
	end
end
return v_u1