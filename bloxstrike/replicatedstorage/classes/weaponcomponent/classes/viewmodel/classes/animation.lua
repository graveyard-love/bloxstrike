-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u2 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u3 = require(v_replicatedstorage.Components.Common.VFXLibary.FlashEffect)
local v_u4 = require(v_replicatedstorage.Shared.Janitor)
local v_u5 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u6 = {
	"7",
	"73",
	"735",
	"7355",
	"73556",
	"735560",
	"7355608"
}
function v_u1.getAnimation(arg1, arg2)
	return arg1.Animations[arg2]
end
function v_u1.adjustAnimationSpeed(arg1, arg2, arg3)
	local v_getanimation = arg1:getAnimation(arg2)
	if v_getanimation then
		v_getanimation:AdjustSpeed(v_getanimation.Length / arg3)
	end
end
function v_u1.play(arg1, arg2, ...)
	local v_getanimation = arg1:getAnimation(arg2)
	arg1.CurrentAnimation = arg2
	if not v_getanimation then
		return nil
	end
	v_getanimation:Play(...)
	return v_getanimation
end
function v_u1.stop(arg1, arg2)
	local v_getanimation = arg1:getAnimation(arg2)
	if v_getanimation and v_getanimation.IsPlaying then
		v_getanimation:Stop()
	end
end
function v_u1.stopAnimations(arg1)
	for _, v1 in pairs(arg1.Animations) do
		if v1.IsPlaying then
			v1:Stop()
		end
	end
	arg1:stopSounds()
end
function v_u1.stopSounds(arg1)
	for v1, v3 in pairs(arg1.ActiveSounds) do
		if v3 then
			local v3 = string.find(v3, "Shoot") ~= nil
		end
		if not v3 then
			arg1.ActiveSounds[v1] = nil
			if v1 and v1.Parent then
				v1:Destroy()
			end
		end
	end
end
function v_u1.unregister(arg1, arg2)
	if arg1.Animations[arg2] then
		arg1.Janitor:Remove("AnimationConnection_" .. arg2)
		arg1.Janitor:RemoveNoClean("AnimationCleanup_" .. arg2)
		if arg1.Animations[arg2] then
			local v1 = arg1.Animations[arg2]
			arg1.Animations[arg2] = nil
			if v1.IsPlaying then
				v1:Stop()
			end
			v1:Destroy()
		end
	end
end
function v_u1.unregisterGroup(arg1, ...)
	for _, v1 in ipairs({ ... }) do
		arg1:unregister(v1)
	end
end
function v_u1.register(arg1, arg2, arg3)
	-- upvalues: (copy) v_u3, (copy) v_u_playergui, (copy) v_u_localplayer, (copy) v_u5
	arg1:unregister(arg2)
	local v1, v2 = pcall(function()
		-- upvalues: (copy) arg1, (copy) arg3
		return arg1.Animator:LoadAnimation(arg3)
	end)
	if v1 then
		arg1.Animations[arg2] = v2
		local v_u_sound = arg1.Sound
		local v_u_soundgroupname = v_u_sound.SoundGroupName
		local v_u_sounds = v_u_sound.Sounds
		local v_u_player = arg1.Player
		local v_u3 = setmetatable({}, {
			["__mode"] = "v"
		})
		v_u3.instance = arg1
		arg1.Janitor:Add(function()
			-- upvalues: (copy) v_u3, (copy) arg2
			local v_instance = v_u3.instance
			if v_instance and not v_instance.IsDestroyed then
				v_instance:unregister(arg2)
			end
		end, true, "AnimationCleanup_" .. arg2)
		local v_connection = v2.KeyframeReached:Connect(function(arg1)
			-- upvalues: (copy) v_u_sounds, (copy) v_u3, (copy) v_u_player, (ref) v_u3, (copy) v_u_sound, (ref) v_u_playergui, (copy) arg2, (ref) v_u_localplayer, (ref) v_u5, (copy) v_u_soundgroupname
			local v1 = v_u_sounds:FindFirstChild(arg1)
			local v_u_instance = v_u3.instance
			if v_u_instance and not v_u_instance.IsDestroyed then
				local v_character = v_u_player.Character
				if v_character then
					if v1 and #v1:GetChildren() > 0 then
						local v_u_play = v_u_sound:play({
							["Parent"] = v_u_playergui,
							["Name"] = arg1
						}, v_u3.IsFlashed() and 0 or 1)
						if v_u_play then
							v_u_instance.ActiveSounds[v_u_play] = arg2
							v_u_play.Ended:Once(function()
								-- upvalues: (copy) v_u_instance, (copy) v_u_play
								if v_u_instance and not v_u_instance.IsDestroyed then
									v_u_instance.ActiveSounds[v_u_play] = nil
								end
							end)
						end
						if v_character:FindFirstChild("Head") then
							local v_head = v_character:WaitForChild("Head")
							if arg2 == "Equip" or arg2 == "Inspect" then
								return
							end
							if v_u_localplayer ~= v_u_player then
								return
							end
							v_u5.Sound.ReplicateSound.Send({
								["Parent"] = v_head,
								["Class"] = v_u_soundgroupname,
								["Name"] = arg1
							})
						end
					end
				end
			else
				return
			end
		end)
		arg1.Janitor:Add(v_connection, "Disconnect", "AnimationConnection_" .. arg2)
	end
end
function v_u1.construct(arg1)
	-- upvalues: (copy) v_u2
	local v1 = v_u2(arg1.Animation)
	for _, v2 in ipairs(v1.CameraAnimations:GetChildren()) do
		if v2:IsA("Animation") then
			arg1:register(v2.Name, v2)
		end
	end
end
function v_u1.new(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u1, (copy) v_u4, (copy) v_u6, (copy) v_u_localplayer
	local v1 = setmetatable({}, v_u1)
	v1.Janitor = v_u4.new()
	v1.IsDestroyed = false
	v1.Player = arg2
	v1.Animation = arg3.Name
	v1.ActiveSounds = {}
	v1.Animations = {}
	v1.Animator = arg3.AnimationController.Animator
	v1.CurrentAnimation = nil
	v1.Sound = arg4
	v1:construct()
	if v1.Animation == "C4" then
		arg1.Model.Weapon.Interactive.SurfaceGui.TextLabel.Text = "*******"
		for _, v2 in pairs(v1.Animations) do
			v1.Janitor:Add(v2.KeyframeReached:Connect(function(arg1)
				-- upvalues: (ref) v_u6, (copy) arg1, (ref) v_u_localplayer
				if table.find(v_u6, arg1) then
					arg1.Model.Weapon.Interactive.SurfaceGui.TextLabel.Text = string.rep("*", 7 - #arg1) .. arg1
					arg1.Sound:play({
						["Parent"] = v_u_localplayer.PlayerGui,
						["Name"] = arg1
					})
				end
			end))
		end
	end
	return v1
end
function v_u1.destroy(arg1)
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		arg1:stopAnimations()
		local v1 = {}
		for v2, _ in pairs(arg1.Animations) do
			table.insert(v1, v2)
		end
		for _, v3 in ipairs(v1) do
			arg1:unregister(v3)
		end
		arg1:stopSounds()
		table.clear(arg1.ActiveSounds)
		table.clear(arg1.Animations)
		arg1.CurrentAnimation = nil
		arg1.Animation = nil
		arg1.Animator = nil
		arg1.Player = nil
		arg1.Sound = nil
		arg1.Janitor:Destroy()
		arg1.Janitor = nil
	end
end
return v_u1