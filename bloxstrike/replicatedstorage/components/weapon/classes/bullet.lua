-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Components.Common.GetRayIgnore)
local v_u3 = require(v_replicatedstorage.Shared.Raycast)
local v_u4 = require(v_replicatedstorage.Shared.Janitor)
local v_u5 = require(v_replicatedstorage.Shared.Spring)
local v_u_current_camera = workspace.CurrentCamera
local function v_u6(arg1, arg2, arg3)
	local v_new = Random.new(arg3)
	local v_nextnumber = v_new:NextNumber(-3.141592653589793, 3.141592653589793)
	local v_nextnumber = v_new:NextNumber(0, (math.rad(arg2 / 2)))
	return (CFrame.lookAlong(Vector3.new(0, 0, 0), arg1) * CFrame.Angles(0, 0, v_nextnumber) * CFrame.Angles(v_nextnumber, 0, 0)).LookVector
end
function v_u1._performRaycast(arg1, arg2)
	-- upvalues: (copy) v_u2, (copy) v_u_current_camera, (copy) v_u6, (copy) v_u3
	local v1 = v_u2()
	local v2 = v_u_current_camera.ViewportSize / 2
	local v_viewportpointtoray = v_u_current_camera:ViewportPointToRay(v2.X, v2.Y)
	local v_min = math.min(arg2, 140)
	local v3 = v_u6(v_viewportpointtoray.Direction, v_min)
	local v_origin = v_viewportpointtoray.Origin
	local v4 = arg1.Properties.Penetration or 0
	local v5 = {
		["Origin"] = v_origin,
		["Direction"] = v3,
		["Distance"] = 0,
		["Hits"] = {}
	}
	local v_cast = v_u3.cast(v_origin, v3 * (arg1.Properties.Range or 500), nil, v1)
	if not v_cast.instance then
		v5.Distance = UNNAMED_1728998914008
		return v5
	end
	local v_position = v_cast.position
	v5.Distance = (v_position - v_origin).Magnitude
	local v_castthrough = v_u3.castThrough(v_position - v3 * 0.001, v3 * (v4 + 0.001), v4, v1)
	for v6, v7 in ipairs(v_castthrough) do
		if v7.instance and v7.material then
			table.insert(v5.Hits, {
				["Position"] = v7.position,
				["Instance"] = v7.instance,
				["Material"] = v7.material.Name,
				["Normal"] = v7.normal or Vector3.new(0, 0, 0),
				["Exit"] = v6 % 2 == 0
			})
		end
	end
	return v5
end
function v_u1.create(arg1, arg2, arg3)
	arg1.LastShotTick = tick()
	if arg2 == "SniperScope" and not arg3 then
		local v_spread = arg1.Properties.Spread
		local v1 = v_spread and v_spread.MovementMultiplier or 1
		local v2 = v1 == 2 and 6 or (v1 == 3 and 12 or 15)
		local v_getposition = arg1.Spread:getPosition()
		if (type(v_getposition) ~= "number" and 0 or v_getposition) < v2 then
			arg1.Spread:setPosition(v2)
		end
	end
	local v_gettruespread = arg1:getTrueSpread()
	arg1:_updateShotSpread(arg2, arg3)
	return arg1:_performRaycast(v_gettruespread)
end
function v_u1.getTrueSpread(arg1)
	local v_spread = arg1.Properties.Spread
	local v_getposition = arg1.Spread:getPosition()
	return (type(v_getposition) ~= "number" and 0 or v_getposition) + (arg1.CharacterSpeed < 6.4 and 0 or arg1.CharacterSpeed) * (not v_spread and 1 or v_spread.MovementMultiplier)
end
function v_u1.getBaseSpread(arg1)
	local v_getposition = arg1.Spread:getPosition()
	return type(v_getposition) ~= "number" and 0 or v_getposition
end
function v_u1.updateSpread(arg1, arg2)
	arg1.Spread:update(arg2)
end
function v_u1._updateShotSpread(arg1, arg2, arg3)
	local v_spread = arg1.Properties.Spread
	assert(v_spread, "Weapon properties missing spread configuration")
	local v_range = v_spread.Range
	local v_min = v_range.Min
	local v_max = v_range.Max
	if arg2 == "SniperScope" then
		if arg3 then
			v_min = 0
		else
			local v1 = v_spread.MovementMultiplier or 1
			v_min = v1 == 2 and 6 or (v1 == 3 and 12 or 15)
		end
	end
	local v_getposition = arg1.Spread:getPosition()
	local v_clamp = math.clamp((type(v_getposition) ~= "number" and 0 or v_getposition) + v_spread.PerShot, v_min, v_max)
	arg1.Spread:setPosition(v_clamp)
end
function v_u1.new(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u4, (copy) v_u5, (copy) v_u_localplayer, (copy) v_u_run
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u4.new()
	v_u1.IsDestroyed = false
	v_u1.Properties = arg2
	v_u1.Weapon = arg1
	v_u1.CharacterSpeed = 0
	v_u1.isInAir = false
	v_u1.jumpStartSpeed = nil
	v_u1.verticalVelocity = 0
	v_u1.isAtJumpPeak = false
	local v_spread = arg2.Spread
	assert(v_spread, "Weapon properties missing spread configuration")
	v_u1.Spread = v_u5.new(1, v_spread.RecoverySpeed, v_spread.Range.Min)
	v_u1.LastShotTick = 0
	local v_u_aimingoptions = arg2.AimingOptions
	local v_u_muzzletype = arg2.MuzzleType
	local v_u_spread = arg2.Spread
	local v_u2
	if v_u_spread then
		v_u2 = v_u_spread.Range
	else
		v_u2 = v_u_spread
	end
	if v_u2 then
		v_u2 = v_u2.Min
	end
	local v_u3
	if v_u_spread then
		v_u3 = v_u_spread.PerShot
	else
		v_u3 = v_u_spread
	end
	local v_u4
	if v_u_spread then
		v_u4 = v_u_spread.MovementMultiplier
	else
		v_u4 = v_u_spread
	end
	if v_u_spread then
		v_u_spread = v_u_spread.JumpShotMinimum
	end
	local v_u5 = v_u_localplayer
	v_u1.Janitor:Add(v_u_run.Heartbeat:Connect(function(_)
		-- upvalues: (copy) v_u5, (copy) v_u1, (copy) v_u_aimingoptions, (copy) v_u_muzzletype, (copy) v_u2, (copy) v_u3, (copy) v_u4, (copy) v_u_spread
		local v1 = v_u5
		if v1 then
			v1 = v_u5.Character
		end
		if v1 then
			local v_primarypart = v1.PrimaryPart
			if v_primarypart then
				local v_humanoid = v1:FindFirstChildOfClass("Humanoid")
				if v_humanoid then
					local v_assemblylinearvelocity = v_primarypart.AssemblyLinearVelocity
					local v_getstate = v_humanoid:GetState()
					v_u1.verticalVelocity = v_assemblylinearvelocity.Y
					local v_isinair = v_u1.isInAir
					v_u1.isInAir = v_getstate == Enum.HumanoidStateType.Jumping and true or v_getstate == Enum.HumanoidStateType.Freefall
					local v2
					if v_u_aimingoptions == "SniperScope" and (v_u_muzzletype == "Sniper" and (v_u2 == 0 and v_u3 == 0)) then
						v2 = v_u4 == 2
					else
						v2 = false
					end
					if v2 and v_u1.isInAir then
						v_u1.isAtJumpPeak = math.abs(v_u1.verticalVelocity) <= 3
					else
						v_u1.isAtJumpPeak = false
					end
					if v_u1.isInAir and not v_isinair then
						v_u1.jumpStartSpeed = v_assemblylinearvelocity.Magnitude + (v_u_spread or 100)
					elseif not v_u1.isInAir and v_isinair then
						v_u1.jumpStartSpeed = nil
						v_u1.isAtJumpPeak = false
					end
					if v_u1.isInAir and v_u1.jumpStartSpeed then
						if v2 and v_u1.isAtJumpPeak then
							v_u1.CharacterSpeed = Vector3.new(v_assemblylinearvelocity.X, 0, v_assemblylinearvelocity.Z).Magnitude
						else
							v_u1.CharacterSpeed = v_u1.jumpStartSpeed
						end
					else
						v_u1.CharacterSpeed = v_assemblylinearvelocity.Magnitude
						return
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	end))
	v_u1.Janitor:Add(v_u_run.Stepped:Connect(function(_, arg2)
		-- upvalues: (copy) v_u1
		v_u1:updateSpread(arg2)
	end))
	return v_u1
end
function v_u1.destroy(arg1)
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		arg1.Janitor:Destroy()
		arg1.Properties = nil
		arg1.Weapon = nil
		arg1.Spread = nil
		arg1.Janitor = nil
	end
end
return v_u1