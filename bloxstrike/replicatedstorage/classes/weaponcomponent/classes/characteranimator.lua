-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u3 = require(v_replicatedstorage.Shared.Janitor)
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
	if v_getanimation then
		v_getanimation:Play(...)
	end
	return v_getanimation
end
function v_u1.stop(arg1, arg2, arg3)
	local v_getanimation = arg1:getAnimation(arg2)
	if v_getanimation and v_getanimation.IsPlaying then
		v_getanimation:Stop(arg3)
	end
end
function v_u1.stopAnimations(arg1)
	for _, v1 in pairs(arg1.Animations) do
		if v1.IsPlaying then
			v1:Stop()
		end
	end
end
function v_u1.unregister(arg1, arg2)
	if arg1.Animations[arg2] then
		local v1 = arg1.Animations[arg2]
		if v1 then
			if v1.IsPlaying then
				v1:Stop()
			end
			v1:Destroy()
			arg1.Animations[arg2] = nil
		end
		arg1.Janitor:Remove(arg2)
	end
end
function v_u1.unregisterGroup(arg1, ...)
	for _, v1 in ipairs({ ... }) do
		arg1:unregister(v1)
	end
end
function v_u1.register(arg1, arg2, arg3)
	arg1:unregister(arg2)
	local v1, v2 = pcall(function()
		-- upvalues: (copy) arg1, (copy) arg3
		return arg1.Animator:LoadAnimation(arg3)
	end)
	if v1 then
		arg1.Animations[arg2] = v2
		arg1.Janitor:Add(function()
			-- upvalues: (copy) arg1, (copy) arg2
			if not arg1.IsDestroyed then
				arg1:unregister(arg2)
			end
		end, true, arg2)
	end
end
function v_u1.construct(arg1)
	-- upvalues: (copy) v_u2
	local v_character = arg1.Player.Character
	if v_character and v_character:IsDescendantOf(workspace) then
		arg1.Animator = v_character:WaitForChild("Humanoid"):WaitForChild("Animator")
		for _, v1 in ipairs(v_u2(arg1.Weapon).CharacterAnimations:GetChildren()) do
			if v1:IsA("Animation") then
				arg1:register(v1.Name, v1)
			end
		end
	end
end
function v_u1.new(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u3
	local v1 = setmetatable({}, v_u1)
	v1.Janitor = v_u3.new()
	v1.IsDestroyed = false
	v1.Player = arg1
	v1.Animator = nil
	v1.CurrentAnimation = nil
	v1.Weapon = arg2
	v1.Animations = {}
	v1:construct()
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
		for v4, v_u5 in pairs(arg1.Animations) do
			if v_u5 then
				if v_u5.IsPlaying then
					v_u5:Stop()
				end
				pcall(function()
					-- upvalues: (copy) v_u5
					v_u5:Destroy()
				end)
			end
			arg1.Animations[v4] = nil
		end
		table.clear(arg1.Animations)
		arg1.Player = nil
		arg1.Animator = nil
		arg1.CurrentAnimation = nil
		arg1.Weapon = nil
		arg1.Janitor:Destroy()
		arg1.Janitor = nil
	end
end
return v_u1