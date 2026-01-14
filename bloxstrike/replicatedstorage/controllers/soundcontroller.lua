-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_contentprovider = game:GetService("ContentProvider")
local v_u_run = game:GetService("RunService")
local v_u_players = game:GetService("Players")
local v_workspace = game:GetService("Workspace")
local v_u_localplayer = v_u_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u3 = require(v_u_replicatedstorage.Packages.Observers)
local v_u4 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u5 = require(v_u_replicatedstorage.Classes.Sound)
local v_u6 = require(v_u_replicatedstorage.Shared.DebugFlags)
local v_u7 = require(v_u_replicatedstorage.Components.Common.VFXLibary.FlashEffect)
local v_u8 = require(script.MovementSounds)
local v_u9 = require(v_u_replicatedstorage.Database.Audio.Character)
local v_u10 = require(v_u_replicatedstorage.Database.Audio.FloorSounds)
local v_u_current_camera = v_workspace.CurrentCamera
local v_u11 = {
	["WeaponSuppressed"] = 50,
	["Footstep"] = 48,
	["Landing"] = 60,
	["Weapon"] = 120,
	["Melee"] = 50,
	["Jump"] = 40
}
local v_u12 = {}
local v_u13 = {}
local v_u14 = nil
function v_u1.GetPlayerNoiseCone()
	-- upvalues: (ref) v_u14
	if v_u14 and tick() - v_u14.Time >= 2 then
		v_u14 = nil
	end
	return v_u14
end
function v_u1.UpdatePlayerNoiseCone(arg1, arg2, arg3)
	-- upvalues: (ref) v_u14
	local v1 = arg2 * 0.5
	local v2 = tick()
	if arg3 then
		v1 = v1 * 0.5
	end
	if v_u14 and (v2 - v_u14.Time < 2 and v1 < v_u14.Range) then
		v_u14.Time = v2
	else
		v_u14 = {
			["Position"] = arg1,
			["Range"] = v1,
			["Time"] = v2
		}
	end
end
function v_u1.GetFootstepRange(arg1, arg2)
	-- upvalues: (copy) v_u10, (copy) v_u11
	local v1 = v_u10[arg1] or v_u10.Concrete
	local v_footstep = v_u11.Footstep
	if v1 and v1.Properties then
		v_footstep = v1.Properties.RollOffMaxDistance or v_footstep
	end
	if arg2 then
		v_footstep = v_footstep * 0.5 or v_footstep
	end
	return v_footstep
end
function v_u1.GetWeaponShootRange(arg1, arg2)
	-- upvalues: (copy) v_u13, (copy) v_u_replicatedstorage, (copy) v_u11
	local v1
	if v_u13[arg1] then
		v1 = v_u13[arg1]
	else
		local v2 = v_u_replicatedstorage.Database.Audio.Weapons:FindFirstChild(arg1)
		if v2 then
			local v3
			v3, v1 = pcall(require, v2)
			if v3 and v1 then
				v_u13[arg1] = v1
			else
				v1 = nil
			end
		else
			v1 = nil
		end
	end
	if v1 then
		if arg2 and v1.Silencer then
			local v_silencer = v1.Silencer
			local v_weaponsuppressed = v_u11.WeaponSuppressed
			if v_silencer and v_silencer.Properties then
				v_weaponsuppressed = v_silencer.Properties.RollOffMaxDistance or v_weaponsuppressed
			end
			return v_weaponsuppressed
		else
			local v_shoot = v1.Shoot
			local v_weapon = v_u11.Weapon
			if v_shoot and v_shoot.Properties then
				v_weapon = v_shoot.Properties.RollOffMaxDistance or v_weapon
			end
			return v_weapon
		end
	else
		return arg2 and v_u11.WeaponSuppressed or v_u11.Weapon
	end
end
function v_u1.GetMeleeRange(arg1)
	-- upvalues: (copy) v_u13, (copy) v_u_replicatedstorage, (copy) v_u11
	local v1
	if v_u13[arg1] then
		v1 = v_u13[arg1]
	else
		local v2 = v_u_replicatedstorage.Database.Audio.Weapons:FindFirstChild(arg1)
		if v2 then
			local v3
			v3, v1 = pcall(require, v2)
			if v3 and v1 then
				v_u13[arg1] = v1
			else
				v1 = nil
			end
		else
			v1 = nil
		end
	end
	if not v1 then
		return v_u11.Melee
	end
	local v_hitone = v1.HitOne
	local v_melee = v_u11.Melee
	if v_hitone and v_hitone.Properties then
		v_melee = v_hitone.Properties.RollOffMaxDistance or v_melee
	end
	return v_melee
end
function v_u1.GetMovementRange(arg1, arg2)
	-- upvalues: (copy) v_u11, (copy) v_u9
	local v1 = v_u11[arg1] or v_u11.Footstep
	if arg1 == "Landing" then
		local v_fall damage = v_u9["Fall Damage"]
		if v_fall damage and v_fall damage.Properties then
			v1 = v_fall damage.Properties.RollOffMaxDistance or v1
		end
	end
	if arg2 then
		v1 = v1 * 0.5 or v1
	end
	return v1
end
function v_u1.ClearPlayerNoiseCone()
	-- upvalues: (ref) v_u14
	v_u14 = nil
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u5, (copy) v_u_contentprovider, (copy) v_u4, (copy) v_u_current_camera, (copy) v_u2, (copy) v_u7, (copy) v_u6, (copy) v_u_players, (copy) v_u_localplayer, (copy) v_u1
	for _, v1 in ipairs(v_u_replicatedstorage.Database.Audio:GetDescendants()) do
		if v1:IsA("ModuleScript") then
			v_u5.createSoundGroup(v1)
		end
	end
	task.spawn(function()
		-- upvalues: (ref) v_u_contentprovider, (ref) v_u_replicatedstorage
		v_u_contentprovider:PreloadAsync({ v_u_replicatedstorage.Sounds })
	end)
	v_u4.observerRouter("RunRoundSound", function(arg1)
		-- upvalues: (ref) v_u5, (ref) v_u_current_camera
		return v_u5.new("Round"):playOneTime({
			["Parent"] = v_u_current_camera,
			["Name"] = arg1
		})
	end)
	v_u2.Sound.ReplicateSound.Listen(function(arg1)
		-- upvalues: (ref) v_u7, (ref) v_u6, (ref) v_u5, (ref) v_u_players, (ref) v_u_localplayer
		local v_isflashed = v_u7.IsFlashed()
		local v1 = v_isflashed and 0 or 1
		if v_u6.IsEnabled("WeaponFX") then
			local v2 = arg1 and arg1.Name and (tostring(arg1.Name) or "") or ""
			local v3 = arg1 and arg1.Class and (tostring(arg1.Class) or "") or ""
			local v_lower = string.lower(v2)
			if string.find(v_lower, "shoot", 1, true) or string.find(v_lower, "fire", 1, true) then
				local v4 = warn
				local v5 = "[WeaponFX][Client][Sound] recv class=%s name=%s flashed=%s parent=%s position=%s path=%s"
				local v6 = tostring(v_isflashed)
				local v7
				if arg1 then
					v7 = arg1.Parent
				else
					v7 = arg1
				end
				local v8 = tostring(v7)
				local v9
				if arg1 then
					v9 = arg1.Position
				else
					v9 = arg1
				end
				local v10 = tostring(v9)
				local v11
				if arg1 then
					v11 = arg1.Path
				else
					v11 = arg1
				end
				v4(v5:format(v3, v2, v6, v8, v10, (tostring(v11))))
			end
		end
		if arg1.Position then
			v_u5.new(arg1.Class):PlaySoundAtPosition({
				["Position"] = arg1.Position,
				["Class"] = arg1.Class,
				["Name"] = arg1.Name
			}, tonumber(arg1.Duration), v1)
		elseif arg1.Parent or arg1.Path then
			if arg1.Parent and arg1.Parent:IsA("BasePart") then
				local v_parent = arg1.Parent
				if v_parent and v_parent.Name == "Head" then
					local v_parent = v_parent.Parent
					if v_parent and (v_parent:IsA("Model") and (v_parent:IsDescendantOf(workspace) and v_u_players:GetPlayerFromCharacter(v_parent) == v_u_localplayer)) then
						if v_u6.IsEnabled("WeaponFX") then
							local v12 = tostring(arg1.Name)
							warn(("[WeaponFX][Client][Sound] skipped local duplicate head sound name=%s class=%s"):format(v12, (tostring(arg1.Class))))
						end
						return
					end
				end
			end
			v_u5.new(arg1.Class):playOneTime({
				["Parent"] = arg1.Parent,
				["Name"] = arg1.Name,
				["Path"] = arg1.Path
			}, v1)
		end
	end)
	v_u2.Sound.StopSoundAtPosition.Listen(function(arg1)
		local v_debris = workspace:FindFirstChild("Debris")
		if v_debris then
			for _, v1 in ipairs(v_debris:GetChildren()) do
				if v1.Name == "Sound" and (v1:IsA("BasePart") and (v1.Position - arg1.Position).Magnitude <= arg1.Radius) then
					v1:Destroy()
				end
			end
		end
	end)
	v_u4.observerRouter("UpdatePlayerNoiseCone", function(arg1, arg2, arg3, arg4)
		-- upvalues: (ref) v_u1
		if typeof(arg3) ~= "number" then
			arg3 = ({
				["Footstep"] = v_u1.GetFootstepRange(arg3 or "Concrete", arg4),
				["Landing"] = v_u1.GetMovementRange("Landing", arg4),
				["Jump"] = v_u1.GetMovementRange("Jump", arg4)
			})[arg1]
		end
		if not arg3 then
			return nil
		end
		v_u1.UpdatePlayerNoiseCone(arg2, arg3, arg4)
		return nil
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u3, (copy) v_u_localplayer, (copy) v_u12, (copy) v_u8, (copy) v_u1, (copy) v_u_players, (copy) v_u_run
	v_u3.observeCharacter(function(arg1, arg2)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u12, (ref) v_u8, (ref) v_u1
		local v1 = arg1 == v_u_localplayer
		local v_u2 = v_u12[arg1]
		if not v_u2 then
			v_u2 = v_u8.new(arg1)
			v_u12[arg1] = v_u2
		end
		if v1 then
			v_u1.ClearPlayerNoiseCone()
		end
		v_u2:SetCharacter(arg2)
		return function()
			-- upvalues: (ref) v_u2
			v_u2:SetCharacter(nil)
		end
	end)
	v_u_players.PlayerRemoving:Connect(function(arg1)
		-- upvalues: (ref) v_u12
		local v1 = v_u12[arg1]
		if v1 then
			v_u12[arg1] = nil
			v1:Destroy()
		end
	end)
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u12
		local v_character = v_u_localplayer.Character
		local v1
		if v_character and v_character:IsDescendantOf(workspace) then
			local v_humanoid = v_character:FindFirstChild("Humanoid")
			local v2 = v_humanoid and (v_humanoid.Health > 0 and v_character:FindFirstChild("HumanoidRootPart"))
			if v2 then
				v1 = v2.Position
			else
				v1 = nil
			end
		else
			v1 = nil
		end
		for _, v3 in pairs(v_u12) do
			v3:Update(arg1, v1)
		end
	end)
end
return v_u1