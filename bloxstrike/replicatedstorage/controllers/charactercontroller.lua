-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
local v_u2 = require(v_replicatedstorage.Classes.Character)
local v_u3 = require(v_replicatedstorage.Classes.Sound)
local v_u4 = require(v_replicatedstorage.Controllers.CameraController)
local v_u5 = require(v_replicatedstorage.Controllers.CaseSceneController)
local v_u6 = require(v_replicatedstorage.Controllers.Observers.Character.Components.CharacterKinematics)
local v_u7 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u8 = require(v_replicatedstorage.Database.Security.Router)
local v_u_localplayer = v_players.LocalPlayer
local v_u9 = require(v_u_localplayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local v_u_current_camera = workspace.CurrentCamera
local v_u10 = nil
local v_u11 = nil
local v_u12 = nil
local v_u13 = false
function v_u1.getCurrentCharacter()
	-- upvalues: (ref) v_u10
	return v_u10
end
function v_u1.GetWalkState()
	-- upvalues: (ref) v_u10
	local v1 = v_u10
	if v1 then
		v1 = v_u10.IsWalking
	end
	return v1
end
function v_u1.GetCrouchState()
	-- upvalues: (ref) v_u10
	local v1 = v_u10
	if v1 then
		v1 = v_u10.IsCrouching
	end
	return v1
end
function v_u1.walk(arg1)
	-- upvalues: (ref) v_u10
	if v_u10 then
		v_u10:ToggleWalkState(arg1)
	end
end
function v_u1.crouch(arg1)
	-- upvalues: (ref) v_u10
	if v_u10 then
		v_u10:ToggleCrouchInput(arg1)
	end
end
function v_u1.PlantBomb()
	-- upvalues: (ref) v_u10
	if v_u10 then
		v_u10:PlantBomb()
	end
end
function v_u1.CancelBombPlant()
	-- upvalues: (ref) v_u10
	if v_u10 then
		v_u10:CancelBombPlant()
	end
end
function v_u1.jump()
	-- upvalues: (ref) v_u10, (copy) v_u_localplayer
	if v_u10 then
		v_u10.IsJumpRequested = true
		v_u10:Jump()
	else
		local v_character = v_u_localplayer.Character
		if v_character then
			local v_humanoid = v_character:FindFirstChildOfClass("Humanoid")
			if v_humanoid and v_humanoid.Health > 0 then
				v_humanoid.Jump = true
			end
		end
	end
end
function v_u1.characterAdded(self)
	-- upvalues: (ref) v_u10, (copy) v_u5, (copy) v_u9, (copy) v_u_current_camera, (copy) v_u_localplayer, (ref) v_u12, (ref) v_u11, (ref) v_u13, (copy) v_u2, (copy) v_u7
	if v_u10 then
		v_u10:Destroy()
		v_u10 = nil
	end
	local v_isactive = v_u5.IsActive()
	local v_humanoidrootpart = self:WaitForChild("HumanoidRootPart", 20)
	local v_humanoid = self:WaitForChild("Humanoid", 20)
	if self:IsDescendantOf(workspace) then
		v_humanoidrootpart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		v_humanoidrootpart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		local v_activecontroller = v_u9:GetControls().activeController
		if v_activecontroller then
			v_activecontroller.moveVector = Vector3.new(0, 0, 0)
			v_activecontroller.backwardValue = 0
			v_activecontroller.forwardValue = 0
			v_activecontroller.rightValue = 0
			v_activecontroller.leftValue = 0
		end
		if not v_isactive then
			v_u_current_camera.CameraType = Enum.CameraType.Custom
			v_u_current_camera.CameraSubject = self.Humanoid
		end
		v_u_localplayer.ReplicationFocus = self.Humanoid
		if v_u12 then
			v_u12()
			v_u12 = nil
		end
		if v_u11 then
			v_u11:Disconnect()
			v_u11 = nil
		end
		v_u13 = false
		v_u10 = v_u2.new(self, v_humanoidrootpart, v_humanoid)
		v_u12 = v_u7.Character.CharacterDied.Listen(function()
			-- upvalues: (ref) v_u13, (ref) v_u10, (ref) v_u12, (ref) v_u11
			if not v_u13 then
				v_u13 = true
				if v_u10 then
					v_u10:Destroy()
					v_u10 = nil
				end
				if v_u12 then
					v_u12()
					v_u12 = nil
				end
				if v_u11 then
					v_u11:Disconnect()
					v_u11 = nil
				end
			end
		end)
		v_u11 = self:GetAttributeChangedSignal("Dead"):Connect(function()
			-- upvalues: (copy) self, (ref) v_u13, (ref) v_u10, (ref) v_u12, (ref) v_u11
			if self:GetAttribute("Dead") then
				if v_u13 then
					return
				end
				v_u13 = true
				if v_u10 then
					v_u10:Destroy()
					v_u10 = nil
				end
				if v_u12 then
					v_u12()
					v_u12 = nil
				end
				if v_u11 then
					v_u11:Disconnect()
					v_u11 = nil
				end
			end
		end)
	end
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u1, (ref) v_u10, (ref) v_u12, (ref) v_u11, (ref) v_u13, (copy) v_u7, (copy) v_u3, (copy) v_u4, (copy) v_u6
	v_u_localplayer.CharacterAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.characterAdded(arg1)
	end)
	v_u_localplayer.CharacterRemoving:Connect(function()
		-- upvalues: (ref) v_u10, (ref) v_u12, (ref) v_u11, (ref) v_u13
		if v_u10 then
			v_u10:Destroy()
			v_u10 = nil
		end
		if v_u12 then
			v_u12()
			v_u12 = nil
		end
		if v_u11 then
			v_u11:Disconnect()
			v_u11 = nil
		end
		v_u13 = false
	end)
	v_u7.Character.CharacterDamaged.Listen(function()
		-- upvalues: (ref) v_u10, (ref) v_u3, (ref) v_u_localplayer
		if v_u10 then
			v_u10.CharacterAnimator:play("Damaged")
			v_u3.new("Character"):playOneTime({
				["Parent"] = v_u_localplayer.PlayerGui,
				["Name"] = "Character Damaged"
			})
		end
	end)
	v_u7.Character.CharacterFlinch.Listen(function(arg1)
		-- upvalues: (ref) v_u4
		v_u4.flinch(arg1.Damage, arg1.Headshot)
	end)
	v_u7.Character.ReplicateLookAngle.Listen(function(arg1)
		-- upvalues: (ref) v_u6
		local v_player = arg1.Player
		local v_angle = arg1.Angle
		if v_player and v_angle == v_angle then
			v_u6.setTargetRotation(v_player, v_angle)
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u8, (copy) v_u1
	v_u8.observerRouter("Plant Bomb", function()
		-- upvalues: (ref) v_u1
		v_u1.PlantBomb()
	end)
	v_u8.observerRouter("Cancel Bomb Plant", function()
		-- upvalues: (ref) v_u1
		v_u1.CancelBombPlant()
	end)
end
return v_u1