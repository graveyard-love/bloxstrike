-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_players = game:GetService("Players")
local v_u_debris = game:GetService("Debris")
require(v_replicatedstorage.Database.Custom.Types)
local v_u1 = require(v_replicatedstorage.Shared.DebugFlags)
local v_u2 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u_muzzleflashes = v_replicatedstorage:WaitForChild("Assets"):WaitForChild("MuzzleFlashes")
local v_u_debris = workspace:WaitForChild("Debris")
function executeMuzzleFlash(arg1, arg2, arg3)
	-- upvalues: (copy) v_u2, (copy) v_u_muzzleflashes, (copy) v_u_debris, (copy) v_u_debris
	local v1 = v_u2(arg2)
	if v1 then
		local v2 = arg3 or v1.MuzzleType
		if not v2 then
			return nil
		end
		local v3 = v_u_muzzleflashes.Character:FindFirstChild(v2)
		local v4
		if v3 then
			v4 = v3:Clone()
			v4.CollisionGroup = "Debris"
			v4.CanCollide = false
			v4.CanQuery = false
			v4.CanTouch = false
			v4.Anchored = false
		else
			v4 = nil
		end
		if v4 then
			v4.Parent = v_u_debris
			local v_motor6d = Instance.new("Motor6D")
			v_motor6d.Part0 = arg1
			v_motor6d.Part1 = v4
			v_motor6d.Parent = v4
			for _, v_u5 in ipairs(v4:GetDescendants()) do
				if v_u5:IsA("ParticleEmitter") then
					task.delay(v_u5:GetAttribute("EmitDelay") or 0, function()
						-- upvalues: (copy) v_u5
						v_u5:Emit(v_u5:GetAttribute("EmitCount") or 1)
					end)
				end
			end
			v_u_debris:AddItem(v4, 5)
			return arg1.Position
		end
	end
	return nil
end
local function v_u3(arg1, ...)
	-- upvalues: (copy) v_u1
	if v_u1.IsEnabled("WeaponFX") then
		warn(("[WeaponFX][MuzzleFlash.Character] " .. arg1):format(...))
	end
end
local function v_u4(arg1, arg2, arg3, arg4, arg5)
	-- upvalues: (copy) v_u_players, (copy) v_u3, (copy) v_u2, (copy) v_u_debris, (copy) v_u4
	local v1 = v_u_players:FindFirstChild(arg1)
	if v1 then
		local v2 = v_u2(arg2)
		if v2 then
			if v1.Character then
				local v3 = v_u_debris:FindFirstChild(v1.Name .. "_Weapon")
				if v3 then
					local v_interactables = v3:FindFirstChild("Interactables")
					if v_interactables then
						local v_muzzlepart = v_interactables:FindFirstChild("MuzzlePart")
						if v2.ShootingOptions == "Dual" then
							v_muzzlepart = v_interactables:FindFirstChild("MuzzlePart" .. (arg3 == "Left" and "L" or "R"))
						end
						if v_muzzlepart then
							if not executeMuzzleFlash(v_muzzlepart, arg2, arg4) then
								v_u3("executeMuzzleFlash failed player=%s weapon=%s override=%s attempt=%d", v1.Name, tostring(arg2), tostring(arg4), arg5)
							end
						else
							v_u3("missing muzzle part player=%s weapon=%s shootingHand=%s attempt=%d", v1.Name, tostring(arg2), tostring(arg3), arg5)
						end
					else
						if arg5 < 3 then
							task.delay(0.05, function()
								-- upvalues: (ref) v_u4, (copy) arg1, (copy) arg2, (copy) arg3, (copy) arg4, (copy) arg5
								v_u4(arg1, arg2, arg3, arg4, arg5 + 1)
							end)
						end
						v_u3("missing Interactables on %s_Weapon (retry=%s) player=%s weapon=%s attempt=%d", v1.Name, tostring(arg5 < 3), v1.Name, tostring(arg2), arg5)
						return
					end
				else
					if arg5 < 3 then
						task.delay(0.05, function()
							-- upvalues: (ref) v_u4, (copy) arg1, (copy) arg2, (copy) arg3, (copy) arg4, (copy) arg5
							v_u4(arg1, arg2, arg3, arg4, arg5 + 1)
						end)
					end
					v_u3("missing %s_Weapon in Debris (retry=%s) player=%s weapon=%s attempt=%d", v1.Name, tostring(arg5 < 3), v1.Name, tostring(arg2), arg5)
					return
				end
			else
				v_u3("character missing player=%s weapon=%s attempt=%d", v1.Name, tostring(arg2), arg5)
				return
			end
		else
			v_u3("weapon properties missing player=%s weapon=%s attempt=%d", v1.Name, tostring(arg2), arg5)
			return
		end
	else
		v_u3("player not found username=%s weapon=%s attempt=%d", tostring(arg1), tostring(arg2), arg5)
		return
	end
end
return function(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u4
	v_u4(arg1, arg2, arg3, arg4, 0)
end