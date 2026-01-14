-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_workspace = game:GetService("Workspace")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Controllers.InventoryController)
local v_u3 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u4 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u5 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u_current_camera = v_workspace.CurrentCamera
local v_u6 = require(script:WaitForChild("Settings"))
local v_u7 = nil
local function v_u8(arg1)
	-- upvalues: (copy) v_u_current_camera
	if arg1.getSpread then
		local v_clamp = math.clamp((arg1:getSpread() or 0) / 2, 0, 30)
		local v_viewportsize = v_u_current_camera.ViewportSize
		local v1, v2
		if v_viewportsize.X > v_viewportsize.Y then
			v1 = v_u_current_camera.MaxAxisFieldOfView
			v2 = v_u_current_camera.FieldOfView
		else
			v1 = v_u_current_camera.FieldOfView
			v2 = v_u_current_camera.MaxAxisFieldOfView
		end
		local v3
		if typeof(v_clamp) == "number" then
			v3 = v_clamp / v2 * v_viewportsize.Y
		else
			v3 = v_clamp / Vector2.new(v1, v2) * v_viewportsize
		end
		if typeof(v3) == "Vector2" then
			return math.max(v3.X, v3.Y) / 15 + 1
		else
			return 1 + v3 / 15
		end
	else
		return 1
	end
end
local function v_u9(arg1)
	-- upvalues: (ref) v_u6, (copy) v_u3, (copy) v_u_current_camera
	if not (arg1.Recoil and (arg1.Properties and (arg1.Properties.Recoil and v_u6["Follow Recoil"]))) then
		return UDim2.new()
	end
	local v1 = 1 - arg1.Properties.Recoil.CameraScale
	local v_getweaponkickrotation = v_u3.getWeaponKickRotation()
	local v_rotationvalue = arg1.Recoil.RotationValue
	local v2 = Vector2.new(v_rotationvalue.Y - v_getweaponkickrotation.Y, v_rotationvalue.X - v_getweaponkickrotation.X) * 57.29577951308232
	local v_viewportsize = v_u_current_camera.ViewportSize
	local v3, v4
	if v_viewportsize.X > v_viewportsize.Y then
		v3 = v_u_current_camera.MaxAxisFieldOfView
		v4 = v_u_current_camera.FieldOfView
	else
		v3 = v_u_current_camera.FieldOfView
		v4 = v_u_current_camera.MaxAxisFieldOfView
	end
	local v5
	if typeof(v2) == "number" then
		v5 = v2 / v4 * v_viewportsize.Y
	else
		v5 = v2 / Vector2.new(v3, v4) * v_viewportsize
	end
	if typeof(v5) ~= "Vector2" then
		return UDim2.new()
	end
	local v6 = v5 * -v1 / v_u_current_camera.ViewportSize
	return UDim2.fromScale(v6.X, v6.Y)
end
local function v_u10(arg1, arg2)
	-- upvalues: (copy) v_u_current_camera, (ref) v_u6
	if arg1.IsAiming and arg1.Properties.AimingOptions == "AutomaticScope" then
		if arg1.getBaseSpread then
			local v_frame = arg1.Viewmodel.Bobble.ScopeReticlePart.SurfaceGui.Frame.Frame
			local v_rad = math.rad(v_u_current_camera.FieldOfView / 2)
			local v1 = math.tan(v_rad) * 2 * 0.15
			local v_viewportsize = v_u_current_camera.ViewportSize
			local v2 = math.clamp(arg1:getBaseSpread() or 0, 0, 2) * 2
			v_frame.Size = UDim2.fromScale(v2 + 2.5, v2 + 2.5)
			v_frame.Position = UDim2.fromScale(0.5, 0.5) + UDim2.new(arg2.X.Scale * (v_viewportsize.X / v_viewportsize.Y * v1 / 0.15), 0, arg2.Y.Scale * (v1 / 0.15), 0)
			local _ = v_u6["Use Crosshair Color for Scope Dot"]
		end
	else
		return
	end
end
local function v_u11(arg1)
	-- upvalues: (ref) v_u6, (ref) v_u7
	local v1 = 5 + v_u6.Gap * 5 / 5 + (arg1 - 1) * 15
	v_u7.Ticks.Right.Position = UDim2.new(0.5, v1, 0.5, 0)
	v_u7.Ticks.Down.Position = UDim2.new(0.5, 0, 0.5, v1)
	v_u7.Ticks.Left.Position = UDim2.new(0.5, -v1, 0.5, 0)
	v_u7.Ticks.Up.Position = UDim2.new(0.5, 0, 0.5, -v1)
end
function v_u1.ResetCrosshair()
	-- upvalues: (ref) v_u7, (ref) v_u6, (copy) v_u2
	if v_u7 then
		v_u7.Position = UDim2.fromScale(0.5, 0.5)
		if v_u7.Ticks then
			local v1 = 5 + v_u6.Gap * 5 / 5
			v_u7.Ticks.Right.Position = UDim2.new(0.5, v1, 0.5, 0)
			v_u7.Ticks.Down.Position = UDim2.new(0.5, 0, 0.5, v1)
			v_u7.Ticks.Left.Position = UDim2.new(0.5, -v1, 0.5, 0)
			v_u7.Ticks.Up.Position = UDim2.new(0.5, 0, 0.5, -v1)
		end
		local v_getcurrentequipped = v_u2.getCurrentEquipped()
		if v_getcurrentequipped and typeof(v_getcurrentequipped) == "table" then
			if v_getcurrentequipped.IsAiming and (v_getcurrentequipped.Properties and v_getcurrentequipped.Properties.AimingOptions == "AutomaticScope") then
				local v_viewmodel = v_getcurrentequipped.Viewmodel
				if v_viewmodel and v_viewmodel.Bobble then
					local v_scopereticlepart = v_viewmodel.Bobble.ScopeReticlePart
					local v2 = v_scopereticlepart and (v_scopereticlepart.SurfaceGui and v_scopereticlepart.SurfaceGui.Frame) and v_scopereticlepart.SurfaceGui.Frame:FindFirstChild("Frame")
					if v2 then
						v2.Position = UDim2.fromScale(0.5, 0.5)
						v2.Size = UDim2.fromScale(2.5, 2.5)
					end
				end
			end
			local v_recoil = v_getcurrentequipped.Recoil
			if v_recoil then
				v_recoil.Value = Vector2.zero
				v_recoil.RecoveryStartTime = 0
				v_recoil.Time = 0
				v_recoil.RotationValue = Vector3.new(0, 0, 0)
			end
		end
	end
end
function v_u1.UpdateCrosshair(_)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_replicatedstorage, (ref) v_u7, (ref) v_u6, (copy) v_u2, (copy) v_u8, (copy) v_u9, (copy) v_u10, (copy) v_u11
	local v1 = v_u_localplayer:GetAttribute("IsSpectating") == true
	if v1 then
		local v_getcurrentspectateinstance = require(v_u_replicatedstorage.Controllers.SpectateController).GetCurrentSpectateInstance()
		if v_getcurrentspectateinstance and (v_getcurrentspectateinstance.PerspectiveState == "First-Person" and v_getcurrentspectateinstance.CurrentEquipped) then
			local v_name = v_getcurrentspectateinstance.CurrentEquipped.Name
			if v_name == "AWP" and true or v_name == "SSG 08" or (v_name == "AUG" and true or v_name == "SG 553") and (v_getcurrentspectateinstance.Player:GetAttribute("ScopeIncrement") or 0) > 0 then
				v_u7.Visible = false
				if v_u7.Ticks then
					for _, v2 in pairs(v_u7.Ticks:GetChildren()) do
						if v2:IsA("Frame") then
							v2.Visible = false
						end
					end
				end
				if v_u7.Dot then
					v_u7.Dot.Visible = false
				end
				if v_u7.Crosshair then
					v_u7.Crosshair.Visible = false
				end
				return
			end
			v_u7.Visible = true
			local v3 = v_u6["Crosshair Style"] == "Image"
			if v_u7.Ticks then
				v_u7.Ticks.Visible = not v3
				for _, v4 in pairs(v_u7.Ticks:GetChildren()) do
					if v4:IsA("Frame") then
						v4.Visible = true
					end
				end
			end
			if v_u7.Dot then
				local v_dot = v_u7.Dot
				local v5 = not v3
				if v5 then
					v5 = v_u6["Center Dot"]
				end
				v_dot.Visible = v5
			end
			if v_u7.Crosshair then
				v_u7.Crosshair.Visible = v3
			end
		elseif v_getcurrentspectateinstance and v_getcurrentspectateinstance.PerspectiveState == "First-Person" then
			v_u7.Visible = true
		end
	end
	local v_getcurrentequipped = v_u2.getCurrentEquipped()
	local v6 = v1 and not v_getcurrentequipped and {
		["Properties"] = {
			["ShowCrosshair"] = true,
			["AimingOptions"] = "None"
		},
		["IsAiming"] = false
	} or v_getcurrentequipped
	if v1 or v_u_localplayer.Character then
		if v6 or v1 then
			local v7 = v1 and not v6 and {
				["Properties"] = {
					["ShowCrosshair"] = true,
					["AimingOptions"] = "None"
				},
				["IsAiming"] = false
			} or v6
			local v8 = v_u6.Alpha.Enabled and v_u6.Alpha.Value / 255 or 1
			local v_fromrgb = Color3.fromRGB(v_u6.Red, v_u6.Green, v_u6.Blue)
			local v9 = v_u6["Crosshair Style"] == "Image"
			v_u7.Ticks.Visible = not v9
			local v_dot = v_u7.Dot
			local v10 = not v9
			if v10 then
				v10 = v_u6["Center Dot"]
			end
			v_dot.Visible = v10
			v_u7.Crosshair.Visible = v9
			if v9 then
				v_u7.Crosshair.Image = "rbxassetid://" .. tostring(v_u6["Crosshair Image"])
				v_u7.Crosshair.ImageColor3 = v_fromrgb
				v_u7.Crosshair.ImageTransparency = 1 - v8
			else
				for _, v11 in ipairs({
					"Up",
					"Down",
					"Left",
					"Right"
				}) do
					local v12 = v_u7.Ticks:FindFirstChild(v11)
					if v12 then
						v12.BackgroundColor3 = v_fromrgb
						v12.BackgroundTransparency = 1 - v8
						v12.Visible = true
						local v13 = 15 * (v_u6.Length / 5)
						local v14 = 2 * (v_u6.Thickness / 1)
						if v11 == "Up" or v11 == "Down" then
							v12.Size = UDim2.new(0, v14, 0, v13)
						else
							v12.Size = UDim2.new(0, v13, 0, v14)
						end
						if v_u6.Outline.Enabled then
							v12.BorderSizePixel = v_u6.Outline.Value
							v12.BorderColor3 = Color3.new(0, 0, 0)
						else
							v12.BorderSizePixel = 0
						end
					end
				end
				if v_u7.Ticks.Up then
					v_u7.Ticks.Up.Visible = not v_u6["T Style"]
				end
				if v_u7.Dot and v_u6["Center Dot"] then
					v_u7.Dot.BackgroundColor3 = v_fromrgb
					v_u7.Dot.BackgroundTransparency = 1 - v8
					if v_u6.Outline.Enabled then
						v_u7.Dot.BorderSizePixel = v_u6.Outline.Value
						v_u7.Dot.BorderColor3 = Color3.new(0, 0, 0)
					else
						v_u7.Dot.BorderSizePixel = 0
					end
				end
			end
			local v15 = v_u7
			local v_parent = v_u7.Parent
			local v16 = v7.Properties.ShowCrosshair and not (v_parent.TeamSelection.Visible or v_parent.Leaderboard.Visible or (v_parent.EndScreen.Visible or v_parent.BuyMenu.Visible))
			if v16 then
				v16 = not v7.IsAiming
			end
			v15.Visible = v16
			local v_new = UDim2.new()
			local v17 = 1
			if v_u7.Visible or v7.Properties.AimingOptions == "AutomaticScope" then
				if v_u6["Crosshair Style"] == "Classic Static" or v_u6["Crosshair Style"] == "Image" then
					v17 = 1
				elseif v_u6["Crosshair Style"] == "Classic" then
					v17 = v_u8(v7)
				end
				v_new = v_u9(v7)
			end
			v_u10(v7, v_new)
			v_u7.Position = UDim2.fromScale(0.5, 0.5) + v_new
			if not v9 then
				v_u11(v17)
			end
		end
	else
		return
	end
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u7, (copy) v_u4, (copy) v_u_localplayer, (ref) v_u6, (copy) v_u1, (copy) v_u_run, (copy) v_u5
	v_u7 = arg2
	v_u4.CreateListener(v_u_localplayer, "Settings.Game.Crosshair", function(arg1)
		-- upvalues: (ref) v_u6, (ref) v_u1
		v_u6 = arg1
		task.delay(0.1, function()
			-- upvalues: (ref) v_u1
			v_u1.UpdateCrosshair(0)
		end)
	end)
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.UpdateCrosshair(arg1)
	end)
	v_u5.Character.CharacterDied.Listen(function()
		-- upvalues: (ref) v_u1
		v_u1.ResetCrosshair()
	end)
end
return v_u1