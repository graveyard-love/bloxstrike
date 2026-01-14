-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.CameraController)
local v_u3 = require(v_replicatedstorage.Database.Custom.Constants)
local v_u4 = require(v_replicatedstorage.Database.Components.Common.RemoveFromArray)
local v_u5 = require(v_replicatedstorage.Components.Common.VFXLibary.CreateMuzzleFlash.Camera)
local v_u6 = require(v_replicatedstorage.Components.Common.VFXLibary.CreateTracer)
local v_u7 = require(v_replicatedstorage.Classes.WeaponComponent)
local v_u8 = require(v_replicatedstorage.Classes.Freecam)
local v_u9 = require(v_replicatedstorage.Components.Weapon.Classes.Bullet)
local v_u10 = require(v_replicatedstorage.Shared.Janitor)
local v_u11 = require(v_replicatedstorage.Packages.Signal)
local v_u12 = require(v_replicatedstorage.Shared.Spring)
local v_u13 = require(v_replicatedstorage.Packages.Sift)
local v_u14 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u_characters = workspace:WaitForChild("Characters")
local v_u_debris = workspace:WaitForChild("Debris")
local v_u_current_camera = workspace.CurrentCamera
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local v_u15 = {
	["Heavy Swing"] = true,
	["BackStab"] = true,
	["Swing1"] = true,
	["Swing2"] = true,
	["Inspect"] = true,
	["Reload"] = true,
	["Throw"] = true,
	["Use"] = true
}
local v_u16 = {
	["NoSuppressorShoot"] = true,
	["ShootRight"] = true,
	["ShootLeft"] = true,
	["Shoot"] = true
}
local function v_u17(arg1, arg2)
	if arg2:IsA("BasePart") then
		local v1 = arg1.Transparencies[arg2] or {
			["Transparency"] = arg2.Transparency,
			["Textures"] = {}
		}
		for _, v2 in ipairs(arg2:GetChildren()) do
			if v2:IsA("Texture") and not table.find(v1.Textures, v2) then
				table.insert(v1.Textures, v2)
				v2.Parent = nil
			end
		end
		if arg2.Transparency < 1 then
			arg2.Transparency = 1
		end
		arg1.Transparencies[arg2] = v1
	elseif arg2:IsA("Texture") then
		local v_parent = arg2.Parent
		if v_parent and v_parent:IsA("BasePart") then
			local v3 = arg1.Transparencies[v_parent] or {
				["Transparency"] = v_parent.Transparency,
				["Textures"] = {}
			}
			if not table.find(v3.Textures, arg2) then
				table.insert(v3.Textures, arg2)
			end
			arg2.Parent = nil
			arg1.Transparencies[v_parent] = v3
			return
		end
	elseif arg2:IsA("BillboardGui") then
		arg2.Enabled = false
	end
end
function v_u1.UpdateCameraCFrame(arg1, arg2)
	-- upvalues: (copy) v_u12
	if not (arg1.CameraPositionSpring and arg1.CameraRotationSpring) then
		arg1.CameraRotationSpring = v_u12.new(1, 35, arg2.LookVector)
		arg1.CameraPositionSpring = v_u12.new(1, 35, arg2.Position)
	end
	arg1.CameraRotationSpring:setGoal(arg2.LookVector)
	arg1.CameraPositionSpring:setGoal(arg2.Position)
end
function v_u1.UpdateSuppressorState(arg1, arg2)
	local v_silencer = arg2.Viewmodel.Model:FindFirstChild("Silencer", true)
	if v_silencer and arg2.Properties.HasSuppressor then
		v_silencer.Transparency = arg1.CurrentEquipped.IsSuppressed and 0 or 1
	end
end
function v_u1.UpdateSuppressor(arg1)
	if arg1.WeaponComponent and arg1.WeaponComponent.Viewmodel then
		local v_u_silencer = arg1.WeaponComponent.Viewmodel.Model:FindFirstChild("Silencer", true)
		if v_u_silencer then
			local v_freeze = table.freeze({
				{
					["AnimationTrack"] = arg1.WeaponComponent.Viewmodel.Animation:getAnimation("RemoveSuppressor"),
					["State"] = false,
					["Event"] = function(arg1)
						-- upvalues: (copy) v_u_silencer
						return arg1:GetMarkerReachedSignal("ScrewOnEnd"):Connect(function()
							-- upvalues: (ref) v_u_silencer
							v_u_silencer.Transparency = 1
						end)
					end
				},
				{
					["AnimationTrack"] = arg1.WeaponComponent.Viewmodel.Animation:getAnimation("AddSuppressor"),
					["State"] = true,
					["Event"] = function(self)
						-- upvalues: (copy) v_u_silencer
						return self:GetPropertyChangedSignal("IsPlaying"):Connect(function()
							-- upvalues: (copy) self, (ref) v_u_silencer
							if self.IsPlaying then
								task.delay(0.016666666666666666, function()
									-- upvalues: (ref) v_u_silencer
									v_u_silencer.Transparency = 0
								end)
							end
						end)
					end
				}
			})
			for _, v_u1 in ipairs(v_freeze) do
				if arg1.WeaponComponent and arg1.WeaponComponent.Janitor then
					arg1.WeaponComponent.Janitor:Add(v_u1.Event(v_u1.AnimationTrack))
					arg1.WeaponComponent.Janitor:Add(v_u1.AnimationTrack.Ended:Connect(function()
						-- upvalues: (copy) v_u_silencer, (copy) v_u1
						if v_u_silencer.Transparency < 1 == v_u1.State then
							v_u_silencer.Transparency = v_u1.State and 0 or 1
						end
					end))
				end
			end
			arg1:UpdateSuppressorState(arg1.WeaponComponent)
		end
	else
		return
	end
end
function v_u1.Switch(arg1, arg2)
	-- upvalues: (copy) v_u_current_camera, (copy) v_u2, (copy) v_u3, (copy) v_u8, (copy) v_u14
	if arg1.Humanoid and arg1.Humanoid.Health > 0 then
		arg1.PerspectiveState = arg2
		if arg1.FreecamInstance then
			arg1.FreecamInstance:Stop()
			arg1.FreecamInstance:Destroy()
			arg1.FreecamInstance = nil
		end
		if arg1.PerspectiveState == "First-Person" then
			arg1.TransparencyState = true
			arg1:SetCharacterTransparency(arg1.TransparencyState)
			v_u_current_camera.CameraType = Enum.CameraType.Scriptable
			v_u_current_camera.CameraSubject = arg1.Humanoid
			if arg1.CurrentEquipped then
				arg1:SetEquipped(arg1.CurrentEquipped, false)
			end
			arg1:UpdateScopeState()
			v_u2.setPerspective(true, false)
		elseif arg1.PerspectiveState == "Third-Person" then
			arg1.TransparencyState = false
			arg1:SetCharacterTransparency(arg1.TransparencyState)
			v_u_current_camera.CameraType = Enum.CameraType.Follow
			v_u_current_camera.CameraSubject = arg1.Humanoid
			if arg1.WeaponComponent then
				arg1.WeaponComponent.Janitor:Destroy()
				arg1.WeaponComponent = nil
			end
			v_u2.updateCameraFOV(v_u3.DEFAULT_CAMERA_FOV)
			v_u2.setPerspective(false, false)
		elseif arg1.PerspectiveState == "Free-Cam" then
			arg1.TransparencyState = false
			arg1:SetCharacterTransparency(arg1.TransparencyState)
			if arg1.WeaponComponent then
				arg1.WeaponComponent.Janitor:Destroy()
				arg1.WeaponComponent = nil
			end
			v_u2.updateCameraFOV(v_u3.DEFAULT_CAMERA_FOV)
			if not arg1.FreecamInstance then
				arg1.FreecamInstance = arg1.Janitor:Add(v_u8.new())
			end
			if arg1.FreecamInstance then
				arg1.FreecamInstance:Start()
			end
		end
		v_u14.Spectate.SetSpectatePerspective.Send(arg1.PerspectiveState)
	end
end
function v_u1.SetEquipped(arg1, arg2, arg3)
	-- upvalues: (copy) v_u7, (copy) v_u9
	local v_weaponcomponent = arg1.WeaponComponent
	if v_weaponcomponent then
		v_weaponcomponent = arg1.WeaponComponent.Identifier
	end
	arg1.CurrentEquipped = arg2
	if v_weaponcomponent == arg2.Identifier then
		arg1:UpdateSuppressorState(arg1.WeaponComponent)
	else
		if arg1.WeaponComponent then
			arg1:SetWeaponViewmodelTransparency(false)
			arg1.WeaponComponent.Janitor:Destroy()
			arg1.WeaponComponent = nil
		end
		if arg1.CurrentEquipped and arg1.PerspectiveState == "First-Person" then
			local v_new = v_u7.new(arg1.Player, arg1.CurrentEquipped.Identifier, arg1.CurrentEquipped._id, 1, arg1.CurrentEquipped.Name, arg1.CurrentEquipped.Skin, arg1.CurrentEquipped.Float, arg1.CurrentEquipped.StatTrack, arg1.CurrentEquipped.NameTag, arg1.CurrentEquipped.Charm, arg1.CurrentEquipped.Stickers)
			if v_new.Properties and v_new.Properties.Spread then
				v_new.Bullet = v_u9.new(v_new, v_new.Properties)
			end
			arg1.WeaponComponent = v_new
			arg1.TransparencyState = true
			arg1:SetCharacterTransparency(arg1.TransparencyState)
			if arg1.WeaponComponent and arg1.WeaponComponent.Viewmodel then
				arg1.WeaponComponent.Viewmodel:equip(not arg3)
				if arg1.WeaponComponent.Properties.HasSuppressor then
					arg1:UpdateSuppressor()
				end
			end
			arg1:UpdateScopeState()
		end
		arg1.CurrentEquippedChanged:Fire(arg1.CurrentEquipped)
	end
end
function v_u1.UpdateScopeState(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u3
	if arg1.PerspectiveState == "First-Person" then
		if arg1.CurrentEquipped then
			local v_name = arg1.CurrentEquipped.Name
			local v1 = v_name == "AUG" and true or v_name == "SG 553"
			local v2 = arg1.Player:GetAttribute("ScopeIncrement") or 0
			local v3 = v2 > 0
			if v_name == "AWP" and true or v_name == "SSG 08" then
				if arg1.WeaponComponent and (arg1.WeaponComponent.Viewmodel and arg1.WeaponComponent.Viewmodel.Bobble) then
					local v_scopereticlepart = arg1.WeaponComponent.Viewmodel.Bobble.ScopeReticlePart
					local v4 = v_scopereticlepart and v_scopereticlepart:FindFirstChildOfClass("SurfaceGui")
					if v4 then
						v4.Enabled = false
					end
				end
				if v3 and v2 <= 2 then
					v_u2.updateCameraFOV(v_u3.DEFAULT_CAMERA_FOV - ({ 37, 60 })[v2])
					if arg1.WeaponComponent and arg1.WeaponComponent.Viewmodel then
						arg1:SetWeaponViewmodelTransparency(true)
						return
					end
				else
					v_u2.updateCameraFOV(v_u3.DEFAULT_CAMERA_FOV)
					if arg1.WeaponComponent and arg1.WeaponComponent.Viewmodel then
						arg1:SetWeaponViewmodelTransparency(false)
						return
					end
				end
			elseif v1 then
				local v_weaponcomponent = arg1.WeaponComponent
				if v_weaponcomponent then
					v_weaponcomponent = arg1.WeaponComponent.Viewmodel
				end
				if v_weaponcomponent then
					if v3 then
						if not v_weaponcomponent.Hidden then
							v_weaponcomponent:hide()
						end
						if v_weaponcomponent.Bobble and (v_weaponcomponent.Bobble.Scope and v_weaponcomponent.Bobble.ScopeReticlePart) then
							v_weaponcomponent:aim()
						end
						v_u2.updateCameraFOV(v_u3.DEFAULT_CAMERA_FOV - 15)
					else
						if v_weaponcomponent.Hidden then
							v_weaponcomponent:unhide()
						end
						if v_weaponcomponent.Bobble and (v_weaponcomponent.Bobble.Scope and v_weaponcomponent.Bobble.ScopeReticlePart) then
							v_weaponcomponent:unaim()
						end
						v_u2.updateCameraFOV(v_u3.DEFAULT_CAMERA_FOV)
					end
				end
			else
				v_u2.updateCameraFOV(v_u3.DEFAULT_CAMERA_FOV)
				if arg1.WeaponComponent and arg1.WeaponComponent.Viewmodel then
					arg1:SetWeaponViewmodelTransparency(false)
				end
			end
		end
	else
		return
	end
end
function v_u1.SetWeaponViewmodelTransparency(arg1, arg2)
	if arg1.WeaponComponent and (arg1.WeaponComponent.Viewmodel and arg1.WeaponComponent.Viewmodel.Model) then
		local v_model = arg1.WeaponComponent.Viewmodel.Model
		if not arg1.WeaponTransparencyCache then
			arg1.WeaponTransparencyCache = {}
		end
		for _, v1 in ipairs(v_model:GetDescendants()) do
			if v1:IsA("BasePart") and (v1.Name ~= "Right Arm" and (v1.Name ~= "Left Arm" and (v1.Name ~= "HumanoidRootPart" and v1.Name ~= "ViewmodelLight"))) then
				if arg2 then
					if not arg1.WeaponTransparencyCache[v1] then
						arg1.WeaponTransparencyCache[v1] = v1.Transparency
					end
					v1.Transparency = 1
				else
					local v2 = arg1.WeaponTransparencyCache[v1]
					if v2 ~= nil then
						v1.Transparency = v2
						arg1.WeaponTransparencyCache[v1] = nil
					end
				end
			end
		end
	end
end
function v_u1.HideDebrisWeapons(arg1)
	-- upvalues: (copy) v_u_debris, (copy) v_u17
	if arg1.TransparencyState then
		local v_name = arg1.Player.Name
		local v1 = v_u_debris:FindFirstChild(v_name .. "_Weapon")
		if v1 then
			for _, v2 in ipairs(v1:GetDescendants()) do
				v_u17(arg1, v2)
			end
		end
		local v3 = v_u_debris:FindFirstChild(v_name .. "_WeaponAttachments")
		if v3 then
			for _, v4 in ipairs(v3:GetDescendants()) do
				v_u17(arg1, v4)
			end
		end
	end
end
function v_u1.SetCharacterTransparency(arg1, arg2)
	-- upvalues: (copy) v_u17, (copy) v_u10, (copy) v_u_debris, (copy) v_u4
	local v_getdescendants = arg1.Character:GetDescendants()
	local function v_u1(arg1)
		-- upvalues: (ref) v_u17, (copy) arg1
		for _, v1 in ipairs(arg1:GetDescendants()) do
			v_u17(arg1, v1)
		end
		if arg1.TransparencyJanitor then
			arg1.TransparencyJanitor:Add(arg1.DescendantAdded:Connect(function(arg1)
				-- upvalues: (ref) arg1, (ref) v_u17
				if arg1.TransparencyState then
					v_u17(arg1, arg1)
				end
			end))
		end
	end
	if arg2 then
		if not arg1.TransparencyJanitor then
			local v_add = arg1.Janitor:Add(v_u10.new())
			arg1.TransparencyJanitor = v_add
			v_add:Add(arg1.Character.DescendantAdded:Connect(function(arg1)
				-- upvalues: (copy) arg1, (ref) v_u17
				if arg1.TransparencyState then
					v_u17(arg1, arg1)
				end
			end))
			v_add:Add(v_u_debris.ChildAdded:Connect(function(arg1)
				-- upvalues: (copy) arg1, (copy) v_u1
				if arg1.TransparencyState then
					local v_name = arg1.Player.Name
					if arg1.Name == v_name .. "_Weapon" or arg1.Name == v_name .. "_WeaponAttachments" then
						v_u1(arg1)
					end
				end
			end))
		end
		for _, v2 in ipairs(v_getdescendants) do
			v_u17(arg1, v2)
		end
		local v_name = arg1.Player.Name
		local v3 = v_u_debris:FindFirstChild(v_name .. "_Weapon")
		if v3 then
			v_u1(v3)
		end
		local v4 = v_u_debris:FindFirstChild(v_name .. "_WeaponAttachments")
		if v4 then
			v_u1(v4)
			return
		end
	else
		if arg1.TransparencyJanitor then
			arg1.TransparencyJanitor:Destroy()
			arg1.TransparencyJanitor = nil
		end
		for v_u5, v6 in pairs(arg1.Transparencies) do
			if v_u5 and v_u5.Parent then
				v_u5.Transparency = v6.Transparency
				v_u4(v6.Textures, function(_, arg2)
					-- upvalues: (copy) v_u5
					arg2.Parent = v_u5
					return true
				end)
			end
		end
		for _, v7 in ipairs(v_getdescendants) do
			if v7:IsA("BillboardGui") then
				v7.Enabled = true
			end
		end
	end
end
function v_u1.AddSpectateEvent(arg1, arg2)
	-- upvalues: (copy) v_u16, (copy) v_u_current_camera, (copy) v_u_debris, (copy) v_u_new, (copy) v_u6, (copy) v_u5, (copy) v_u15
	if arg1.WeaponComponent and arg1.WeaponComponent.Viewmodel then
		local v_viewmodel = arg1.WeaponComponent.Viewmodel
		if v_viewmodel then
			v_viewmodel = arg1.WeaponComponent.Viewmodel.Animation
		end
		if v_u16[arg2] then
			v_u_new.FilterDescendantsInstances = { arg1.Player.Character, v_u_current_camera, v_u_debris }
			local v_weaponcomponent = arg1.WeaponComponent
			if v_weaponcomponent and v_weaponcomponent.Bullet then
				local v_aimingoptions = v_weaponcomponent.Properties.AimingOptions
				local v_isaiming = v_weaponcomponent.IsAiming
				if v_weaponcomponent.Bullet._updateShotSpread then
					v_weaponcomponent.Bullet:_updateShotSpread(v_aimingoptions, v_isaiming)
				end
			end
			v_viewmodel:stopAnimations()
			v_viewmodel:play(arg2)
			v_viewmodel:play("Idle")
			local v_raycast = workspace:Raycast(v_u_current_camera.CFrame.Position, v_u_current_camera.CFrame.LookVector * arg1.WeaponComponent.Properties.Range, v_u_new)
			local v1 = v_raycast and v_raycast.Distance or arg1.WeaponComponent.Properties.Range
			if arg1.WeaponComponent.Viewmodel.Model.Interactables:FindFirstChild("MuzzlePart") then
				v_u6(v1, arg1.WeaponComponent.Viewmodel.Model.Interactables.MuzzlePart.Position, v_u_current_camera.CFrame.LookVector)
				v_u5(arg1.WeaponComponent.Viewmodel.Model.Interactables.MuzzlePart, arg1.WeaponComponent.Name, arg1.WeaponComponent.Properties.HasSuppressor and arg1.CurrentEquipped.IsSuppressed and "Suppressor" or nil)
				return
			end
		else
			if arg2 == "Remove Suppressor" or arg2 == "Add Suppressor" then
				v_viewmodel:stopAnimations()
				v_viewmodel:play(string.gsub(arg2, " ", ""))
				v_viewmodel:play("Idle")
				return
			end
			if arg2 == "Cancel Plant" then
				v_viewmodel:stopAnimations()
				v_viewmodel:play("Idle")
				return
			end
			if arg2 == "Switch Fire Mode" then
				v_viewmodel:stopAnimations()
				v_viewmodel:play("Switch")
				v_viewmodel:play("Idle")
				return
			end
			if v_u15[arg2] then
				v_viewmodel:stopAnimations()
				v_viewmodel:play(arg2)
				v_viewmodel:play("Idle")
			end
		end
	end
end
local function v_u18(arg1)
	if arg1.PerspectiveState == "First-Person" then
		if arg1.CurrentEquipped then
			local v_name = arg1.CurrentEquipped.Name
			if v_name == "AUG" and true or v_name == "SG 553" then
				if (arg1.Player:GetAttribute("ScopeIncrement") or 0) > 0 then
					if arg1.WeaponComponent and arg1.WeaponComponent.Viewmodel then
						local v_viewmodel = arg1.WeaponComponent.Viewmodel
						if v_viewmodel.Bobble and v_viewmodel.Bobble.IsAiming then
							local v_weaponcomponent = arg1.WeaponComponent
							if v_weaponcomponent and v_weaponcomponent.Bullet then
								local v1 = v_weaponcomponent.Bullet:getBaseSpread() or 0
								local v_scopereticlepart = v_viewmodel.Bobble.ScopeReticlePart
								if v_scopereticlepart then
									local v_scopeuicache = arg1.ScopeUICache
									if v_scopeuicache and v_scopeuicache.SurfaceGui == v_scopereticlepart then
										local v_crosshair = v_scopeuicache.Crosshair
										if v_crosshair and v_crosshair.Parent then
											local v2 = math.clamp(v1, 0, 2) * 2
											v_crosshair.Size = UDim2.fromScale(v2 + 2.5, v2 + 2.5)
											v_crosshair.Position = UDim2.fromScale(0.5, 0.5)
											return
										end
										arg1.ScopeUICache = nil
									end
									local v_surfacegui = v_scopereticlepart:FindFirstChildOfClass("SurfaceGui")
									if v_surfacegui then
										local v_frame = v_surfacegui:FindFirstChild("Frame")
										if v_frame then
											local v_frame = v_frame:FindFirstChild("Frame")
											if v_frame then
												arg1.ScopeUICache = {
													["Crosshair"] = v_frame,
													["SurfaceGui"] = v_surfacegui,
													["Frame"] = v_frame
												}
												local v3 = math.clamp(v1, 0, 2) * 2
												v_frame.Size = UDim2.fromScale(v3 + 2.5, v3 + 2.5)
												v_frame.Position = UDim2.fromScale(0.5, 0.5)
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
							else
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
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
function v_u1.Render(arg1, arg2)
	-- upvalues: (copy) v_u_current_camera, (copy) v_u18
	if arg1.PerspectiveState ~= "Free-Cam" then
		if arg1.CameraPositionSpring and arg1.CameraRotationSpring then
			arg1.CameraPositionSpring:update(arg2)
			arg1.CameraRotationSpring:update(arg2)
			if arg1.PerspectiveState == "First-Person" then
				v_u_current_camera.CFrame = CFrame.lookAt(arg1.CameraPositionSpring:getPosition(), arg1.CameraPositionSpring:getPosition() + arg1.CameraRotationSpring:getPosition())
				if arg1.WeaponComponent and arg1.WeaponComponent.Viewmodel then
					arg1.WeaponComponent.Viewmodel:render(arg2)
				end
				local v_weaponcomponent = arg1.WeaponComponent
				if v_weaponcomponent and (v_weaponcomponent.Bullet and v_weaponcomponent.Bullet.updateSpread) then
					v_weaponcomponent.Bullet:updateSpread(arg2)
				end
				v_u18(arg1)
			end
		end
	end
end
function v_u1.new(arg1, arg2, arg3)
	-- upvalues: (copy) v_u1, (copy) v_u10, (copy) v_u11, (copy) v_u_localplayer, (copy) v_u_http, (copy) v_u14, (copy) v_u_characters, (copy) v_u13, (copy) v_u2, (copy) v_u3
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u10.new()
	v_u1.CurrentEquippedChanged = v_u1.Janitor:Add(v_u11.new())
	v_u1.StopSpectating = v_u1.Janitor:Add(v_u11.new())
	v_u1.Humanoid = arg3
	v_u1.Character = arg2
	v_u1.Player = arg1
	v_u1.CurrentPlayerTeam = arg1:GetAttribute("Team")
	v_u1.PerspectiveState = "First-Person"
	v_u1.TransparencyState = true
	v_u1.FreecamInstance = nil
	v_u1.Transparencies = {}
	v_u1.TransparencyJanitor = nil
	v_u1.WeaponTransparencyCache = {}
	v_u1.ScopeUICache = nil
	v_u1:SetCharacterTransparency(v_u1.TransparencyState)
	v_u1:Switch(v_u1.PerspectiveState)
	v_u_localplayer.ReplicationFocus = v_u1.Humanoid
	v_u1.Janitor:Add(function()
		-- upvalues: (ref) v_u_localplayer
		v_u_localplayer.ReplicationFocus = nil
	end)
	if v_u1.Player:GetAttribute("CurrentEquipped") then
		v_u1:SetEquipped(v_u_http:JSONDecode((v_u1.Player:GetAttribute("CurrentEquipped"))), false)
	end
	v_u1.Janitor:Add(v_u1.Player:GetAttributeChangedSignal("CurrentEquipped"):Connect(function()
		-- upvalues: (copy) v_u1, (ref) v_u_http
		local v_currentequipped = v_u1.Player:GetAttribute("CurrentEquipped")
		if v_currentequipped then
			v_u1:SetEquipped(v_u_http:JSONDecode(v_currentequipped), true)
			task.defer(function()
				-- upvalues: (ref) v_u1
				if v_u1.TransparencyState and v_u1.PerspectiveState == "First-Person" then
					v_u1:HideDebrisWeapons()
				end
			end)
		end
	end))
	if v_u1.Character:GetAttribute("CameraCFrame") then
		v_u1:UpdateCameraCFrame((v_u1.Character:GetAttribute("CameraCFrame")))
	end
	v_u1.Janitor:Add(v_u1.Character:GetAttributeChangedSignal("CameraCFrame"):Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:UpdateCameraCFrame((v_u1.Character:GetAttribute("CameraCFrame")))
	end))
	if v_u1.Player:GetAttribute("ScopeIncrement") then
		v_u1:UpdateScopeState()
	end
	v_u1.Janitor:Add(v_u1.Player:GetAttributeChangedSignal("ScopeIncrement"):Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:UpdateScopeState()
	end))
	if v_u1.Humanoid.Health <= 0 then
		task.defer(function()
			-- upvalues: (copy) v_u1
			v_u1.StopSpectating:Fire()
		end)
	end
	v_u1.Janitor:Add(v_u1.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
		-- upvalues: (copy) v_u1
		if v_u1.Humanoid and v_u1.Humanoid.Health <= 0 then
			v_u1.StopSpectating:Fire()
		end
	end))
	if v_u1.Character:GetAttribute("Dead") then
		task.defer(function()
			-- upvalues: (copy) v_u1
			v_u1.StopSpectating:Fire()
		end)
	end
	v_u1.Janitor:Add(v_u1.Character:GetAttributeChangedSignal("Dead"):Connect(function()
		-- upvalues: (copy) v_u1
		if v_u1.Character:GetAttribute("Dead") then
			v_u1.StopSpectating:Fire()
		end
	end))
	v_u1.Janitor:Add(v_u14.UI.UIPlayerKilled.Listen(function(arg1)
		-- upvalues: (copy) v_u1
		local v_victim = arg1.Victim
		if v_victim and tostring(v_u1.Player.UserId) == v_victim then
			v_u1.StopSpectating:Fire()
		end
	end))
	v_u1.Janitor:Add(v_u1.Character.AncestryChanged:Connect(function(_, arg2)
		-- upvalues: (ref) v_u_characters, (copy) v_u1
		if not (arg2 and arg2:IsDescendantOf(v_u_characters)) then
			v_u1.StopSpectating:Fire()
		end
	end))
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1, (ref) v_u13, (ref) v_u2, (ref) v_u3
		v_u1.TransparencyState = false
		if v_u13.Dictionary.count(v_u1.Transparencies) > 0 then
			v_u1:SetCharacterTransparency(v_u1.TransparencyState)
		end
		v_u2.updateCameraFOV(v_u3.DEFAULT_CAMERA_FOV)
	end)
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1
		if v_u1.WeaponComponent then
			v_u1.WeaponComponent.Janitor:Destroy()
			v_u1.WeaponComponent = nil
		end
		v_u1.WeaponTransparencyCache = {}
		v_u1.ScopeUICache = nil
	end)
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1
		if v_u1.FreecamInstance then
			v_u1.FreecamInstance:Stop()
			v_u1.FreecamInstance:Destroy()
			v_u1.FreecamInstance = nil
		end
	end)
	return v_u1
end
function v_u1.Destroy(arg1)
	arg1.Janitor:Destroy()
end
return v_u1