-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.CharacterController)
local v_u3 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u4 = require(v_replicatedstorage.Controllers.SpectateController)
local v5 = require(v_replicatedstorage.Shared.Spring)
local v_u_new = v5.new(1, 2.5, 1)
local v_u_new = v5.new(0.85, 0.5, Vector2.zero)
local v_u_none = Enum.HumanoidStateType.None
local v_u6 = 0
local v_u7 = nil
function v_u1.toggle(arg1)
	-- upvalues: (ref) v_u7, (copy) v_u_new, (ref) v_u6
	v_u7.Visible = arg1
	v_u7.Blur.Visible = true
	if arg1 then
		v_u_new:setPosition(1)
		v_u_new:setGoal(0)
		v_u6 = tick()
	else
		v_u6 = 0
	end
end
function v_u1.updateMovementSharpness(arg1, arg2)
	-- upvalues: (copy) v_u3, (copy) v_u_new, (ref) v_u6
	local v1 = math.min(arg1.PrimaryPart and (Vector3.new(arg1.PrimaryPart.AssemblyLinearVelocity.X, 0, arg1.PrimaryPart.AssemblyLinearVelocity.Z).Magnitude or 0) or 0, 3) / 3
	local v_getcurrentequipped = v_u3.getCurrentEquipped()
	local v2 = v_getcurrentequipped and v_getcurrentequipped.Properties
	if v2 then
		if v_getcurrentequipped.Properties.AimingOptions == "SniperScope" and (v_getcurrentequipped.Properties.MuzzleType == "Sniper" and (v_getcurrentequipped.Properties.Spread.Range.Min == 0 and v_getcurrentequipped.Properties.Spread.PerShot == 0)) then
			v2 = v_getcurrentequipped.Properties.Spread.MovementMultiplier == 2
		else
			v2 = false
		end
	end
	local v3 = false
	if v2 then
		local v_humanoid = arg1:FindFirstChild("Humanoid")
		local v4
		if v_humanoid then
			local v_getstate = v_humanoid:GetState()
			v4 = v_getstate == Enum.HumanoidStateType.Jumping or v_getstate == Enum.HumanoidStateType.Freefall
		else
			v4 = false
		end
		if v4 and arg1.PrimaryPart then
			v3 = math.abs(arg1.PrimaryPart.AssemblyLinearVelocity.Y) <= 3
		end
	end
	if arg2 then
		v_u_new:setPosition(1)
		v_u_new:setGoal(0)
		v_u6 = tick()
		return
	else
		local v_humanoid = arg1:FindFirstChild("Humanoid")
		local v5
		if v_humanoid then
			local v_getstate = v_humanoid:GetState()
			v5 = v_getstate == Enum.HumanoidStateType.Jumping or v_getstate == Enum.HumanoidStateType.Freefall
		else
			v5 = false
		end
		if v5 then
			if v2 and v3 then
				v_u_new:setPosition(0)
				v_u_new:setGoal(0)
			else
				v_u_new:setPosition(1)
			end
		elseif v1 > 0.1 then
			v_u_new:setPosition(v1)
		elseif tick() - v_u6 > 1.2 then
			v_u_new:reset(0)
		end
	end
end
function v_u1.updateScope(arg1, _)
	-- upvalues: (ref) v_u_none, (copy) v_u1, (copy) v_u2, (copy) v_u_new, (ref) v_u7, (copy) v_u_new
	local v_humanoid = arg1:WaitForChild("Humanoid")
	if v_humanoid and v_humanoid.Health > 0 then
		local v_getstate = v_humanoid:GetState()
		local v1
		if v_u_none == Enum.HumanoidStateType.Freefall or v_u_none == Enum.HumanoidStateType.Jumping then
			v1 = v_getstate == Enum.HumanoidStateType.Running and true or v_getstate == Enum.HumanoidStateType.Landed
		else
			v1 = false
		end
		v_u1.updateMovementSharpness(arg1, v1)
		v_u_none = v_getstate
		if (arg1.PrimaryPart and (Vector3.new(arg1.PrimaryPart.AssemblyLinearVelocity.X, 0, arg1.PrimaryPart.AssemblyLinearVelocity.Z).Magnitude or 0) or 0) > 0.1 then
			local v_min = math.min(arg1.PrimaryPart and Vector3.new(arg1.PrimaryPart.AssemblyLinearVelocity.X, 0, arg1.PrimaryPart.AssemblyLinearVelocity.Z).Magnitude or 0, 3)
			local v2 = v_u2.GetCrouchState() and 0.5 or (v_u2.GetWalkState() and 0.75 or 1)
			local v_sin = math.sin(tick() * 3.141592653589793 * 1.75 * v2)
			v_u_new:setPosition(Vector2.new(v_sin, (math.sin(tick() * 3.141592653589793 * 2.75 * v2))) * v_min * 1.5)
			local v_getposition = v_u_new:getPosition()
			v_u7.Position = UDim2.new(0.5, v_getposition.X, 0.5, v_getposition.Y)
		else
			v_u_new:reset(Vector2.zero)
			v_u7.Position = UDim2.fromScale(0.5, 0.5)
		end
		v_u7.Blur.ImageTransparency = 1 - v_u_new:getPosition()
		v_u7.Sharp.ImageTransparency = v_u_new:getPosition()
	end
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u7, (copy) v_u_run, (copy) v_u_localplayer, (copy) v_u3, (copy) v_u4, (copy) v_u_new, (copy) v_u_new, (copy) v_u1
	v_u7 = arg2
	v_u_run.RenderStepped:Connect(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u3, (ref) v_u4, (ref) v_u_new, (ref) v_u_new, (ref) v_u1, (ref) v_u7
		local v1 = v_u_localplayer:GetAttribute("IsSpectating") == true
		local v_character = v_u_localplayer.Character
		local v2
		if v_character then
			v2 = v_character:FindFirstChild("Humanoid")
		else
			v2 = v_character
		end
		if v1 then
			v2 = v1
		elseif v_character then
			if v2 then
				v2 = v2.Health > 0
			end
		else
			v2 = v_character
		end
		if v2 then
			local v_getcurrentequipped = v_u3.getCurrentEquipped()
			local v_getcurrentspectateinstance = v_u4.GetCurrentSpectateInstance()
			local v3 = false
			if v1 and v_getcurrentspectateinstance then
				if v_getcurrentspectateinstance.CurrentEquipped then
					local v_name = v_getcurrentspectateinstance.CurrentEquipped.Name
					if (v_name == "AWP" and true or v_name == "SSG 08") and v_getcurrentspectateinstance.PerspectiveState == "First-Person" then
						v3 = (v_getcurrentspectateinstance.Player:GetAttribute("ScopeIncrement") or 0) > 0
						v_character = v_getcurrentspectateinstance.Character
					end
				end
			else
				v3 = v_getcurrentequipped and v_getcurrentequipped.IsAiming
				if v3 then
					v3 = v_getcurrentequipped.Properties.AimingOptions == "SniperScope"
				end
			end
			v_u_new:update(arg1)
			v_u_new:update(arg1)
			if v3 and v_character then
				v_u1.updateScope(v_character, arg1)
				if not v_u7.Visible then
					v_u1.toggle(true)
					return
				end
			elseif v_u7.Visible then
				v_u1.toggle(false)
				return
			end
		elseif v_u7.Visible then
			v_u1.toggle(false)
		end
	end)
end
return v_u1