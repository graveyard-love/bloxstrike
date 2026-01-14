-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Classes.Sound)
local v_u3 = require(v_replicatedstorage.Shared.Janitor)
local v_u4 = require(v_replicatedstorage.Database.Security.Router)
local v_u5 = require(v_replicatedstorage.Components.Common.VFXLibary.CreateImpact.Components.Materials)
local v_u6 = require(v_replicatedstorage.Components.Common.GetRayIgnore)
local v_u7 = require(v_replicatedstorage.Components.Common.VFXLibary.FlashEffect)
local v_u8 = {
	["Concrete"] = "LandingConcrete",
	["Brick"] = "LandingConcrete",
	["Cobblestone"] = "LandingConcrete",
	["Basalt"] = "LandingConcrete",
	["Limestone"] = "LandingConcrete",
	["Pavement"] = "LandingConcrete",
	["Asphalt"] = "LandingConcrete",
	["Rock"] = "LandingConcrete",
	["Slate"] = "LandingConcrete",
	["Granite"] = "LandingConcrete",
	["Marble"] = "LandingConcrete",
	["Pebble"] = "LandingConcrete",
	["CeramicTiles"] = "LandingConcrete",
	["Ground"] = "LandingDirt",
	["Mud"] = "LandingDirt",
	["Glass"] = "LandingGlass",
	["Gravel"] = "LandingGravel",
	["Rubber"] = "LandingRubber",
	["Plastic"] = "LandingRubber",
	["Sand"] = "LandingSand",
	["Snow"] = "LandingSand",
	["Grass"] = "LandingGrass",
	["LeafyGrass"] = "LandingGrass",
	["Metal"] = "LandingMetal",
	["DiamondPlate"] = "LandingMetal",
	["CorrodedMetal"] = "LandingMetal",
	["Corroded Metal"] = "LandingMetal",
	["Wood"] = "LandingConcrete",
	["WoodPlanks"] = "LandingConcrete",
	["Fabric"] = "LandingDirt",
	["Carpet"] = "LandingDirt",
	["Cardboard"] = "LandingDirt"
}
local v_u9 = nil
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local function v_u10(arg1, arg2, _)
	-- upvalues: (copy) v_u6, (copy) v_u_new
	local v1 = v_u6()
	if not table.find(v1, arg1) then
		table.insert(v1, arg1)
	end
	v_u_new.FilterDescendantsInstances = v1
	local v_position = arg2.Position
	for _, v2 in ipairs({
		Vector3.new(0, 0, 0),
		Vector3.new(0.8, 0, 0),
		Vector3.new(-0.8, 0, 0),
		Vector3.new(0, 0, 0.8),
		Vector3.new(0, 0, -0.8)
	}) do
		local v_raycast = workspace:Raycast(v_position + v2, Vector3.new(0, -3.1, 0), v_u_new)
		if v_raycast and v_raycast.Normal.Y > 0.7 then
			return v_raycast.Material.Name
		end
	end
	return "Air"
end
local function v_u11(arg1, arg2, arg3)
	-- upvalues: (ref) v_u9, (copy) v_u5
	if not v_u9 or (arg2 == "" or arg2 == "Air") then
		return nil
	end
	local v1 = v_u5[arg2] or "Ground"
	if not v_u9.Sounds or v_u9.Sounds:FindFirstChild(v1) then
		return v_u9:play({
			["Parent"] = arg1,
			["Name"] = v1
		}, arg3)
	end
	warn(string.format("[FloorSound] Missing sound for category: \'%s\' (material: %s)", v1, arg2))
	return nil
end
function v_u1.SetCharacter(arg1, arg2)
	arg1.Janitor:Cleanup()
	if arg2 then
		local v_humanoidrootpart = arg2:WaitForChild("HumanoidRootPart", 5)
		local v_humanoid = arg2:WaitForChild("Humanoid", 5)
		if v_humanoid and (v_humanoidrootpart and arg2.Parent) then
			arg1.PrimaryPart = v_humanoidrootpart
			arg1.Humanoid = v_humanoid
			arg1.Character = arg2
			arg1.TimePassed = 0.25
			arg1.Janitor:Add(v_humanoid.StateChanged:Connect(function(arg1, arg2)
				-- upvalues: (copy) arg1
				arg1:OnStateChanged(arg1, arg2)
			end))
		end
	else
		local v_currentfootstepsound = arg1.CurrentFootstepSound
		if v_currentfootstepsound and v_currentfootstepsound.Playing then
			v_currentfootstepsound:Stop()
		end
		arg1.CurrentFootstepSound = nil
		arg1.PrimaryPart = nil
		arg1.TimePassed = 0.25
		arg1.Character = nil
		arg1.Humanoid = nil
		return
	end
end
function v_u1.OnStateChanged(arg1, arg2, arg3)
	-- upvalues: (copy) v_u7, (copy) v_u10, (copy) v_u8, (copy) v_u11, (copy) v_u4
	local v_primarypart = arg1.PrimaryPart
	local v_character = arg1.Character
	local v_humanoid = arg1.Humanoid
	if v_humanoid and (v_primarypart and v_character) then
		if arg3 == Enum.HumanoidStateType.Jumping or arg3 == Enum.HumanoidStateType.Freefall then
			local v_currentfootstepsound = arg1.CurrentFootstepSound
			if v_currentfootstepsound and v_currentfootstepsound.Playing then
				v_currentfootstepsound:Stop()
			end
			arg1.CurrentFootstepSound = nil
		end
		local v1 = tick()
		if v1 - arg1.LastFloorSoundTime < 0.1 then
			return
		elseif arg2 == Enum.HumanoidStateType.Freefall or arg3 == Enum.HumanoidStateType.Landed then
			if not (arg1.IsLocalPlayer and v_u7.IsFlashed()) then
				arg1.LastFloorSoundTime = v1
				local v_iscrouching = arg1.Player:GetAttribute("IsCrouching")
				local v2 = v_u10(v_character, v_primarypart, v_humanoid)
				v_u11(v_primarypart, v_u8[v2] or "LandingConcrete", v_iscrouching and 0.4 or 1)
				if arg1.IsLocalPlayer then
					v_u4.broadcastRouter("UpdatePlayerNoiseCone", "Landing", v_primarypart.Position, v2, v_iscrouching)
				end
			end
		else
			if arg3 == Enum.HumanoidStateType.Jumping then
				if arg1.IsLocalPlayer and v_u7.IsFlashed() then
					return
				end
				arg1.LastFloorSoundTime = v1
				local v_iscrouching = arg1.Player:GetAttribute("IsCrouching")
				local v3 = v_u10(v_character, v_primarypart, v_humanoid)
				local v4 = v_iscrouching and 0.4 or 1
				v_u11(v_primarypart, "Jump", v4)
				v_u11(v_primarypart, v3, v4)
				if arg1.IsLocalPlayer then
					v_u4.broadcastRouter("UpdatePlayerNoiseCone", "Jump", v_primarypart.Position, v3, v_iscrouching)
				end
			end
			return
		end
	else
		warn("[FloorSound] Character validation failed in OnStateChanged")
		return
	end
end
function v_u1.Update(arg1, arg2, arg3)
	-- upvalues: (copy) v_u7, (copy) v_u10, (copy) v_u11, (copy) v_u4
	local v_primarypart = arg1.PrimaryPart
	local v_character = arg1.Character
	local v_humanoid = arg1.Humanoid
	local v_player = arg1.Player
	if v_primarypart and (v_character and (v_character.Parent and (v_humanoid and v_humanoid.Health > 0))) then
		if arg3 and not arg1.IsLocalPlayer then
			local v1 = v_primarypart.Position.X - arg3.X
			local v2 = v_primarypart.Position.Y - arg3.Y
			local v3 = v_primarypart.Position.Z - arg3.Z
			if v1 * v1 + v2 * v2 + v3 * v3 > 5625 then
				return
			end
		end
		local v_iscrouching = v_player:GetAttribute("IsCrouching")
		if not (v_player:GetAttribute("IsWalking") or v_iscrouching) then
			local v4 = v_iscrouching and 3.5 or 7.5
			local v5 = v_iscrouching and 0.55 or 0.3
			arg1.TimePassed = arg1.TimePassed + arg2
			if v5 <= arg1.TimePassed then
				arg1.TimePassed = arg1.TimePassed - v5
				if arg1.IsLocalPlayer and v_u7.IsFlashed() then
					return
				end
				local v6 = tick()
				if v6 - arg1.LastFloorSoundTime < 0.1 then
					return
				end
				local v_assemblylinearvelocity = v_primarypart.AssemblyLinearVelocity
				if v4 <= (v_assemblylinearvelocity.X * v_assemblylinearvelocity.X + v_assemblylinearvelocity.Z * v_assemblylinearvelocity.Z) ^ 0.5 then
					arg1.LastFloorSoundTime = v6
					local v7 = v_u10(v_character, v_primarypart, v_humanoid)
					arg1.CurrentFootstepSound = v_u11(v_primarypart, v7, v_iscrouching and 0.4 or 1)
					if arg1.IsLocalPlayer then
						v_u4.broadcastRouter("UpdatePlayerNoiseCone", "Footstep", v_primarypart.Position, v7, v_iscrouching)
					end
				end
			end
		end
	else
		return
	end
end
function v_u1.new(arg1)
	-- upvalues: (copy) v_u1, (copy) v_u3, (copy) v_u_localplayer, (ref) v_u9, (copy) v_u2
	local v1 = setmetatable({}, v_u1)
	v1.Janitor = v_u3.new()
	v1.IsLocalPlayer = arg1 == v_u_localplayer
	v1.Player = arg1
	v1.PrimaryPart = nil
	v1.Character = nil
	v1.Humanoid = nil
	v1.TimePassed = 0.25
	v1.CurrentFootstepSound = nil
	v1.LastFloorSoundTime = 0
	if not v_u9 then
		v_u9 = v_u2.new("FloorSounds")
	end
	return v1
end
function v_u1.Destroy(arg1)
	arg1.Janitor:Destroy()
end
return v_u1