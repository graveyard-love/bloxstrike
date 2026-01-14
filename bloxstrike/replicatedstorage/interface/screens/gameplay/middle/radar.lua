-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_collection = game:GetService("CollectionService")
local v_u_tween = game:GetService("TweenService")
local v_u_http = game:GetService("HttpService")
local v_u_run = game:GetService("RunService")
local v_u_gui = game:GetService("GuiService")
local v_u_workspace = game:GetService("Workspace")
local v_u_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_u_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.CharacterController)
local v_u3 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u4 = require(v_replicatedstorage.Controllers.DataController)
local v_u5 = require(v_replicatedstorage.Database.Custom.GameStats.Settings.Colors)
local v_u6 = require(v_replicatedstorage.Components.Common.GetPreferenceColor)
local v7 = require(v_replicatedstorage.Components.Common.GetUserPlatform)
local v_u8 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u9 = require(v_replicatedstorage.Database.Security.Router)
local v_u10 = require(v_replicatedstorage.Shared.Janitor)
local v_find = table.find(v7(), "Mobile")
if v_find then
	v_find = #v7() <= 1
end
local v_u_radar = v_replicatedstorage.Assets.UI.Radar
local v_u_current_camera = workspace.CurrentCamera
local v_u11 = v_find and 135 or 200
local v_u_debris = v_u_workspace:WaitForChild("Debris")
local v_u12 = {
	["DeadTeammate"] = 13,
	["LocalPlayer"] = 15,
	["Teammate"] = 14,
	["Enemy"] = 17,
	["Bomb"] = 19,
	["Site"] = 16,
	["EnemyQuestionMark"] = 20,
	["Hostage"] = 18
}
local v_u_fromrgb = Color3.fromRGB(255, 0, 0)
local v_u13 = nil
local v_u14 = {
	["CentersPlayer"] = true,
	["Rotation"] = false,
	["Zoom"] = 0.7,
	["Scale"] = 1
}
local v_u15 = nil
local function v_u16()
	-- upvalues: (copy) v_u_collection
	local v_map = workspace:FindFirstChild("Map")
	if not v_map then
		return nil
	end
	local v_minimap = v_u_collection:GetTagged("Minimap")
	for _, v1 in ipairs(v_minimap) do
		if v1:IsA("BasePart") and v1:IsDescendantOf(v_map) then
			return {
				["Part"] = v1,
				["Lower"] = v1:FindFirstChild("Lower"),
				["Upper"] = v1:FindFirstChild("Upper"),
				["Size"] = v1.Size
			}
		end
	end
	return nil
end
local function v_u17(arg1, arg2, arg3)
	-- upvalues: (ref) v_u15, (copy) v_u1, (ref) v_u13
	if v_u15 then
		v_u15:Destroy()
		v_u15 = nil
	end
	v_u15 = v_u1.new(v_u13, arg1)
	if v_u15 then
		v_u15.LocalPlayer = arg2
		v_u15.Team = arg2:GetAttribute("Team")
		v_u15.IsSpectating = arg3 or false
		if arg3 then
			v_u15.MapImage.Rotation = 90
			if v_u15.UpperMapImage then
				v_u15.UpperMapImage.Rotation = 90
			end
		end
	end
	if v_u15 and arg1 then
		v_u15.Janitor:Add(arg1:GetAttributeChangedSignal("Dead"):Connect(function()
			-- upvalues: (ref) v_u15, (copy) arg1
			if v_u15 and arg1:GetAttribute("Dead") then
				v_u15:Destroy()
				v_u15 = nil
			end
		end))
	end
end
local function v_u18()
	-- upvalues: (copy) v_u_collection
	local v_plantarea = v_u_collection:GetTagged("PlantArea")
	local v1 = {}
	for _, v2 in ipairs(v_plantarea) do
		if v2:IsA("BasePart") then
			local v_site = v2:GetAttribute("Site")
			if v_site and (v_site == "A" or v_site == "B") then
				if not v1[v_site] then
					v1[v_site] = {}
				end
				table.insert(v1[v_site], v2.CFrame)
			end
		end
	end
	return v1
end
local function v_u19(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_debris
	local function v1(arg1, arg2, arg3, arg4, arg5)
		local v1 = 0
		local v2, v3
		if math.abs(arg2.X) < 0.0001 then
			if arg1.X < arg3.X or arg1.X > arg4.X then
				return false
			end
			v2 = arg5
			v3 = v1
		else
			local v4 = 1 / arg2.X
			v2 = (arg3.X - arg1.X) * v4
			v3 = (arg4.X - arg1.X) * v4
			if v3 >= v2 then
				local v5 = v2
				v2 = v3
				v3 = v5
			end
			if v1 >= v3 then
				v3 = v1
			end
			if v2 >= arg5 then
				v2 = arg5
			end
			if v2 < v3 then
				return false
			end
		end
		if math.abs(arg2.Y) < 0.0001 then
			if arg1.Y < arg3.Y or arg1.Y > arg4.Y then
				return false
			end
		else
			local v6 = 1 / arg2.Y
			local v7 = (arg3.Y - arg1.Y) * v6
			local v8 = (arg4.Y - arg1.Y) * v6
			if v8 >= v7 then
				local v9 = v7
				v7 = v8
				v8 = v9
			end
			if v3 >= v8 then
				v8 = v3
			end
			if v7 >= v2 then
				v7 = v2
			end
			if v7 < v8 then
				return false
			end
			v2 = v7
			v3 = v8
		end
		if math.abs(arg2.Z) < 0.0001 then
			if arg1.Z < arg3.Z or arg1.Z > arg4.Z then
				return false
			end
		else
			local v10 = 1 / arg2.Z
			local v11 = (arg3.Z - arg1.Z) * v10
			local v12 = (arg4.Z - arg1.Z) * v10
			if v12 >= v11 then
				local v13 = v11
				v11 = v12
				v12 = v13
			end
			if v3 >= v12 then
				v12 = v3
			end
			if v11 >= v2 then
				v11 = v2
			end
			if v11 < v12 then
				return false
			end
			v3 = v12
		end
		local v14
		if v3 >= 0 then
			v14 = v3 <= arg5
		else
			v14 = false
		end
		return v14
	end
	local v2 = v_u_debris
	if v2 then
		for _, v3 in ipairs(v2:GetChildren()) do
			if v3.Name:match("^VoxelSmoke_") and v3:IsA("Folder") then
				for _, v4 in ipairs(v3:GetChildren()) do
					if v4:IsA("BasePart") and v4.Name == "SmokeVoxel" then
						local v_size = v4.Size
						local v_position = v4.Position
						if v1(arg1, arg2, v_position - v_size / 2, v_position + v_size / 2, arg3) then
							return true
						end
					end
				end
			end
		end
	end
	return false
end
local function v_u20(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_players, (copy) v_u19, (copy) v_u_collection, (copy) v_u_workspace
	if not (arg1 and arg1.PrimaryPart) then
		return false
	end
	local v1 = arg1.PrimaryPart.Position + Vector3.new(0, 1.5, 0)
	for _, v2 in ipairs(v_u_players:GetPlayers()) do
		if v2 ~= arg2 and v2:GetAttribute("Team") == arg3 then
			local v_character = v2.Character
			if v_character and v_character.PrimaryPart then
				local v_primarypart = v_character.PrimaryPart
				local v3 = v_primarypart.Position + Vector3.new(0, 1.5, 0)
				local v_magnitude = (v1 - v3).Magnitude
				if v_magnitude <= 200 then
					local v_unit = (v1 - v3).Unit
					if v_unit:Dot(v_primarypart.CFrame.LookVector) > 0.5 and not v_u19(v3, v_unit, v_magnitude) then
						local v_hostage = v_u_collection:GetTagged("Hostage")
						local v4 = { v_character, arg1 }
						for _, v5 in ipairs(v_hostage) do
							if v5:IsA("Model") then
								table.insert(v4, v5)
							end
						end
						local v_new = RaycastParams.new()
						v_new.FilterType = Enum.RaycastFilterType.Exclude
						v_new.FilterDescendantsInstances = v4
						local v_raycast = v_u_workspace:Raycast(v3, v_unit * v_magnitude, v_new)
						if not v_raycast or v_raycast.Instance:IsDescendantOf(arg1) then
							return true
						end
					end
				end
			end
		end
	end
	return false
end
local function v_u21(arg1, arg2, _, arg4)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_players, (copy) v_u_current_camera, (copy) v_u_collection, (copy) v_u19, (copy) v_u_workspace
	local v1 = arg4 or v_u_localplayer
	for _, v2 in ipairs(v_u_players:GetPlayers()) do
		if v2:GetAttribute("Team") == "Counter-Terrorists" then
			local v_character = v2.Character
			if v_character and v_character.PrimaryPart then
				local v3, v4, v5
				if v2 == v1 then
					if v_u_current_camera then
						local v_cframe = v_u_current_camera.CFrame
						v3 = v_cframe.Position
						local v_lookvector = v_cframe.LookVector
						local v6 = arg1 - v3
						v4 = v6.Magnitude
						if v4 <= 200 and v4 > 0 then
							v5 = v6.Unit
							if v5:Dot(v_lookvector) > 0.5 then
								::l15::
								local v7 = { v_character }
								if arg2 then
									table.insert(v7, arg2)
								end
								local v_hostage = v_u_collection:GetTagged("Hostage")
								for _, v8 in ipairs(v_hostage) do
									if v8:IsA("Model") then
										table.insert(v7, v8)
									end
								end
								if not v_u19(v3, v5, v4) then
									local v_new = RaycastParams.new()
									v_new.FilterType = Enum.RaycastFilterType.Exclude
									v_new.FilterDescendantsInstances = v7
									local v_raycast = v_u_workspace:Raycast(v3, v5 * v4, v_new)
									if not v_raycast then
										return true
									end
									if arg2 and v_raycast.Instance:IsDescendantOf(arg2) then
										return true
									end
								end
							end
						end
					end
				else
					local v_primarypart = v_character.PrimaryPart
					v3 = v_primarypart.Position + Vector3.new(0, 1.5, 0)
					local v_lookvector = v_primarypart.CFrame.LookVector
					local v9 = arg1 - v3
					v4 = v9.Magnitude
					if v4 <= 200 and v4 > 0 then
						v5 = v9.Unit
						if v5:Dot(v_lookvector) > 0.5 then
							goto l15
						end
					end
				end
			end
		end
	end
	return false
end
local function v_u22(arg1, arg2, _, arg4)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_players, (copy) v_u_current_camera, (copy) v_u_collection, (copy) v_u19, (copy) v_u_workspace
	local v1 = arg4 or v_u_localplayer
	for _, v2 in ipairs(v_u_players:GetPlayers()) do
		if v2:GetAttribute("Team") == "Terrorists" then
			local v_character = v2.Character
			if v_character and v_character.PrimaryPart then
				local v3, v4, v5
				if v2 == v1 then
					if v_u_current_camera then
						local v_cframe = v_u_current_camera.CFrame
						v3 = v_cframe.Position
						local v_lookvector = v_cframe.LookVector
						local v6 = arg1 - v3
						v4 = v6.Magnitude
						if v4 <= 200 and v4 > 0 then
							v5 = v6.Unit
							if v5:Dot(v_lookvector) > 0.5 then
								::l15::
								local v_hostage = v_u_collection:GetTagged("Hostage")
								local v7 = { v_character }
								for _, v8 in ipairs(v_hostage) do
									if v8:IsA("Model") then
										table.insert(v7, v8)
									end
								end
								if not v_u19(v3, v5, v4) then
									local v_new = RaycastParams.new()
									v_new.FilterType = Enum.RaycastFilterType.Exclude
									v_new.FilterDescendantsInstances = v7
									local v_raycast = v_u_workspace:Raycast(v3, v5 * v4, v_new)
									if not v_raycast then
										return true
									end
									if arg2 and v_raycast.Instance:IsDescendantOf(arg2) then
										return true
									end
								end
							end
						end
					end
				else
					local v_primarypart = v_character.PrimaryPart
					v3 = v_primarypart.Position + Vector3.new(0, 1.5, 0)
					local v_lookvector = v_primarypart.CFrame.LookVector
					local v9 = arg1 - v3
					v4 = v9.Magnitude
					if v4 <= 200 and v4 > 0 then
						v5 = v9.Unit
						if v5:Dot(v_lookvector) > 0.5 then
							goto l15
						end
					end
				end
			end
		end
	end
	return false
end
local function v_u23(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_radar, (copy) v_u12
	local v1 = nil
	if arg2 == "Teammate" then
		v1 = v_u_radar.Player:Clone()
		v1.ZIndex = v_u12.Teammate
	elseif arg2 == "Enemy" then
		v1 = v_u_radar.Enemy:Clone()
		v1.ZIndex = v_u12.Enemy
	elseif arg2 == "DeadTeammate" then
		v1 = v_u_radar.Dead:Clone()
		v1.ZIndex = v_u12.DeadTeammate
	end
	if not v1 then
		error((("Invalid icon type: %*"):format(arg2)))
	end
	v1.Position = UDim2.fromScale(0.5, 0.5)
	v1.AnchorPoint = Vector2.new(0.5, 0.5)
	v1.Size = UDim2.fromOffset(arg3, arg3)
	v1.Parent = arg1
	for _, v2 in ipairs(v1:GetChildren()) do
		if v2.Name == "Direction" and v2:IsA("ImageLabel") then
			v2.Visible = false
		end
	end
	return v1
end
local function v_u24(arg1, arg2)
	local v_new = Vector3.new(arg1.X, 0, arg1.Z)
	local v1 = v_new.Magnitude < 1e-6 and Vector3.new(0, 0, 1) or v_new.Unit
	if arg2 then
		v1 = arg2.CFrame:VectorToObjectSpace(v1)
	end
	local v_atan2 = math.atan2(-v1.Z, -v1.X)
	return (math.deg(v_atan2) + 90) % 360
end
function v_u1.WorldToRadar(arg1, arg2)
	if not arg1.MinimapReference then
		return nil
	end
	if not (arg1.Character and arg1.Character.PrimaryPart) then
		return nil
	end
	local _ = arg1.Character.PrimaryPart.Position
	local v1 = arg1.ViewCenterLocal or Vector3.new(0, 0, 0)
	local _ = arg1.Settings.CentersPlayer
	local v_pointtoobjectspace = arg1.MinimapReference.Part.CFrame:PointToObjectSpace(arg2)
	local v_zoom = arg1.Settings.Zoom
	local v2 = -(v_pointtoobjectspace.X - v1.X) / v_zoom
	local v3 = -(v_pointtoobjectspace.Z - v1.Z) / v_zoom
	if arg1.MapImage.Rotation ~= 0 then
		local v_rad = math.rad(-arg1.MapImage.Rotation)
		local v_cos = math.cos(v_rad)
		local v_sin = math.sin(v_rad)
		v2 = v2 * v_cos - v3 * v_sin
		v3 = v2 * v_sin + v3 * v_cos
	end
	local v_size = UNNAMED_1728998336328.Size
	return Vector2.new(v2 / v_size.X + 0.5, v3 / v_size.Z + 0.5)
end
local function v_u25(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_current_camera, (copy) v_u_gui
	local v_viewportsize = v_u_current_camera.ViewportSize
	local v_x = v_viewportsize.X
	local v_y = v_viewportsize.Y
	local v_x = v_u_gui:GetGuiInset().X
	local v1 = v_x + 50
	local v2 = arg1.AnchorPoint or Vector2.new(0, 0)
	local v3
	if arg3.X.Scale == 0 then
		v3 = arg3.X.Offset
	else
		v3 = arg3.X.Scale * v_x + arg3.X.Offset
	end
	local v4
	if arg3.Y.Scale == 0 then
		v4 = arg3.Y.Offset
	else
		v4 = arg3.Y.Scale * v_y + arg3.Y.Offset
	end
	local v5, v6, v7, v8
	if v2.X == 0 and v2.Y == 0 then
		v5 = v3 + arg2
		v6 = v4 + arg2
		v7 = v4
		v8 = v3
	elseif v2.X == 0.5 and v2.Y == 0.5 then
		v8 = v3 - arg2 / 2
		v7 = v4 - arg2 / 2
		v5 = v3 + arg2 / 2
		v6 = v4 + arg2 / 2
	else
		v8 = v3 - v2.X * arg2
		v7 = v4 - v2.Y * arg2
		v5 = v8 + arg2
		v6 = v7 + arg2
	end
	local v9 = 0
	local v10 = v8 >= v_x + 10 and 0 or v_x + 10 - v8
	if v_x - 0 - 10 < v5 then
		v10 = v_x - 0 - 10 - v5
	end
	if v7 < v1 + 10 then
		v9 = v1 + 10 - v7
	end
	if v_y - 0 - 10 < v6 then
		v9 = v_y - 0 - 10 - v6
	end
	local v11 = v3 + v10
	local v12 = v4 + v9
	local v13
	if arg3.X.Scale == 0 then
		v13 = UDim.new(0, v11)
	else
		v13 = UDim.new(0, v11)
	end
	local v14
	if arg3.Y.Scale == 0 then
		v14 = UDim.new(0, v12)
	else
		v14 = UDim.new(0, v12)
	end
	return UDim2.new(v13, v14)
end
function v_u1.UpdateIcon(arg1, arg2, arg3, arg4)
	local v1 = arg1.Icons[arg2]
	if v1 then
		local v_worldtoradar = arg1:WorldToRadar(arg3)
		if v_worldtoradar then
			local v2 = v_worldtoradar.X - 0.5
			local v3 = v_worldtoradar.Y - 0.5
			local v_sqrt = math.sqrt(v2 * v2 + v3 * v3)
			local v_x = v_worldtoradar.X
			local v_y = v_worldtoradar.Y
			if v_sqrt > 0.5 then
				v_x = 0.5 + v2 / v_sqrt * 0.5
				v_y = 0.5 + v3 / v_sqrt * 0.5
			end
			v1.Instance.Visible = true
			v1.Instance.Position = UDim2.fromScale(v_x, v_y)
			if arg4 then
				v1.Instance.Rotation = math.deg(arg4)
			end
		else
			v1.Instance.Visible = false
		end
	else
		return
	end
end
function v_u1.UpdateTeammateIcon(arg1, arg2, arg3, arg4)
	local v1 = arg1.Icons[arg2]
	if v1 then
		local v_instance = v1.Instance
		if v_instance and v_instance:IsA("GuiObject") then
			if arg1.MinimapReference then
				local v_size = arg1.MinimapReference.Size
				local v_pointtoobjectspace = UNNAMED_1729000298744.Part.CFrame:PointToObjectSpace(arg3)
				local v_imagerectoffset = arg1.MapImage.ImageRectOffset
				local v_imagerectsize = arg1.MapImage.ImageRectSize
				local v2 = ((-v_pointtoobjectspace.X / v_size.X + 0.5) * 1024 - v_imagerectoffset.X) / v_imagerectsize.X
				local v3 = ((-v_pointtoobjectspace.Z / v_size.Z + 0.5) * 1024 - v_imagerectoffset.Y) / v_imagerectsize.Y
				if arg1.MapImage.Rotation ~= 0 then
					local v_rad = math.rad(arg1.MapImage.Rotation)
					local v_cos = math.cos(v_rad)
					local v_sin = math.sin(v_rad)
					local v4 = v2 - 0.5
					local v5 = v3 - 0.5
					v2 = 0.5 + (v4 * v_cos - v5 * v_sin)
					v3 = 0.5 + (v4 * v_sin + v5 * v_cos)
				end
				local v6 = v2 - 0.5
				local v7 = v3 - 0.5
				local v_sqrt = math.sqrt(v6 * v6 + v7 * v7)
				if v_sqrt > 0.5 then
					v2 = 0.5 + v6 / v_sqrt * 0.5
					v3 = 0.5 + v7 / v_sqrt * 0.5
				end
				v_instance.Position = UDim2.fromScale(v2, v3)
				v_instance.Visible = true
				if arg4 and v_instance:IsA("ImageLabel") then
					v_instance.Rotation = math.deg(arg4)
				end
			else
				v_instance.Visible = false
			end
		else
			return
		end
	else
		return
	end
end
function v_u1.CreatePlayerIcon(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_http, (copy) v_u_radar, (copy) v_u12, (copy) v_u23, (copy) v_u5
	local v1
	if arg3 == "Enemy" then
		local v_slot5 = arg2:GetAttribute("Slot5")
		local v2 = v_slot5 and v_u_http:JSONDecode(v_slot5 or "[]")
		if v2 then
			v2 = v2.Weapon == "C4"
		end
		local v3 = arg2:GetAttribute("IsCarryingHostage") == true
		if v2 then
			v1 = v_u_radar.Bomb:Clone()
			v1.Size = UDim2.fromOffset(14, 14)
		elseif v3 then
			local v_hostage = v_u_radar:FindFirstChild("Hostage")
			if v_hostage and v_hostage:IsA("ImageLabel") then
				v1 = v_hostage:Clone()
			else
				v1 = v_u_radar.Player:Clone()
			end
			v1.Size = UDim2.fromOffset(30, 30)
		else
			v1 = v_u_radar.Player:Clone()
			v1.Size = UDim2.fromOffset(12, 12)
		end
		v1.ImageColor3 = Color3.fromRGB(255, 0, 0)
		v1.ZIndex = v_u12.Enemy
		v1.Position = UDim2.fromScale(0.5, 0.5)
		v1.AnchorPoint = Vector2.new(0.5, 0.5)
		v1.Parent = arg1.RadarContainer
		for _, v4 in ipairs(v1:GetChildren()) do
			if v4.Name == "Direction" and v4:IsA("ImageLabel") then
				v4.Visible = false
			end
		end
	else
		v1 = v_u23(arg1.RadarContainer, arg3, 12)
		local v_team = arg2:GetAttribute("Team")
		local v5 = v_team and v_u5["Team Color"][v_team]
		if v5 then
			v1.ImageColor3 = v5
		end
		for _, v6 in ipairs(v1:GetChildren()) do
			if v6.Name == "Direction" and v6:IsA("ImageLabel") then
				v6.Visible = false
			end
		end
	end
	v1.Name = arg2.Name
	local v7 = arg2.UserId .. "_" .. arg3
	arg1.Icons[v7] = {
		["Instance"] = v1,
		["Player"] = arg2,
		["Target"] = nil,
		["Type"] = arg3
	}
	return v7
end
function v_u1.RemoveIcon(arg1, arg2)
	local v1 = arg1.Icons[arg2]
	if v1 then
		v1.Instance:Destroy()
		arg1.Icons[arg2] = nil
	end
end
function v_u1.RefreshPlayerIcon(arg1, arg2)
	local v1 = arg2.UserId .. "_Player"
	local v2 = arg2.UserId .. "_Dead"
	if arg1.Icons[v1] then
		arg1:RemoveIcon(v1)
	end
	if arg1.Icons[v2] then
		arg1:RemoveIcon(v2)
	end
	arg1.EnemyVisibilityState[v1] = nil
	arg1.EnemyLastSeenPositions[v1] = nil
	arg1.EnemyLastSeenPositions[v1 .. "_Frozen"] = nil
	arg1.DeadPlayerPositions[arg2.UserId] = nil
	arg1.FadedDeadIcons[v2] = nil
end
function v_u1.RefreshIconsOnTeamChange(arg1)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u5
	local v_team = arg1.Team
	local v_team = v_u_localplayer:GetAttribute("Team")
	if v_team then
		arg1.Team = v_team
		if arg1.Team ~= v_team then
			local v1 = {}
			for v2, v3 in pairs(arg1.Icons) do
				if v3.Player and v3.Player ~= v_u_localplayer then
					table.insert(v1, v2)
				end
			end
			for _, v4 in ipairs(v1) do
				arg1:RemoveIcon(v4)
			end
			arg1.EnemyVisibilityState = {}
			arg1.EnemyLastSeenPositions = {}
			arg1.DeadPlayerPositions = {}
			arg1.FadedDeadIcons = {}
			if arg1.Icons.LocalPlayer then
				local v_instance = arg1.Icons.LocalPlayer.Instance
				local v_team = arg1.Team
				local v5 = v_team and v_u5["Team Color"][v_team]
				if v5 then
					v_instance.ImageColor3 = v5
				end
			end
		end
	else
		return
	end
end
function v_u1.UpdatePlayerIcons(arg1, _)
	-- upvalues: (copy) v_u_radar, (copy) v_u12, (copy) v_u5, (copy) v_u_http, (copy) v_u24, (copy) v_u_players, (copy) v_u23, (copy) v_u_tween, (copy) v_u20
	local v_minimapreference = arg1.MinimapReference
	if v_minimapreference then
		v_minimapreference = arg1.MinimapReference.Part
	end
	if arg1.Character and arg1.Character.PrimaryPart then
		if not arg1.Icons.LocalPlayer then
			local v_clone = v_u_radar.Player:Clone()
			v_clone.Name = "LocalPlayer"
			v_clone.Position = UDim2.fromScale(0.5, 0.5)
			v_clone.AnchorPoint = Vector2.new(0.5, 0.5)
			v_clone.ZIndex = v_u12.LocalPlayer
			v_clone.Parent = arg1.RadarContainer
			local v_team = arg1.Team
			local v1 = v_team and v_u5["Team Color"][v_team]
			if v1 then
				v_clone.ImageColor3 = v1
			end
			arg1.Icons.LocalPlayer = {
				["Instance"] = v_clone,
				["Player"] = arg1.LocalPlayer,
				["Target"] = nil,
				["Type"] = "Teammate"
			}
		end
		local v_instance = arg1.Icons.LocalPlayer.Instance
		v_instance.Visible = true
		local v_slot5 = arg1.LocalPlayer:GetAttribute("Slot5")
		local v2 = v_slot5 and v_u_http:JSONDecode(v_slot5 or "[]")
		if v2 then
			v2 = v2.Weapon == "C4"
		end
		local v_imagecolor3 = v_instance.ImageColor3
		if v2 then
			v_instance.Image = v_u_radar.Bomb.Image
			v_instance.Size = UDim2.fromOffset(14, 14)
			v_instance.ImageColor3 = v_imagecolor3
		else
			v_instance.Image = v_u_radar.Player.Image
			v_instance.Size = UDim2.fromOffset(12, 12)
			v_instance.ImageColor3 = v_imagecolor3
		end
		local _ = arg1.Settings.CentersPlayer
		v_instance.Position = UDim2.fromScale(0.5, 0.5)
		v_instance.Rotation = not (v_minimapreference and (arg1.Character and arg1.Character.PrimaryPart)) and 0 or v_u24(arg1.Character.PrimaryPart.CFrame.LookVector, v_minimapreference) + arg1.MapImage.Rotation + 0
	end
	for _, v3 in ipairs(v_u_players:GetPlayers()) do
		if v3 ~= arg1.LocalPlayer then
			local v_character = v3.Character
			local v4
			if v_character then
				v4 = v_character.PrimaryPart
			else
				v4 = v_character
			end
			local v_team = v3:GetAttribute("Team")
			if v_team and v_team ~= "Spectators" then
				local v5 = arg1.DeadPlayerPositions[v3.UserId]
				local v6 = v5 ~= nil
				local v7
				if v_character then
					v7 = v_character:GetAttribute("Dead") == true
				else
					v7 = false
				end
				local v8 = v_team == arg1.Team
				local v_u9 = v3.UserId .. "_Player"
				if v7 or v6 then
					if arg1.Icons[v_u9] then
						local v_instance = arg1.Icons[v_u9].Instance
						if v_instance and v_instance:IsA("GuiObject") then
							v_instance.Visible = false
						end
						arg1:RemoveIcon(v_u9)
					end
					if not v5 and v4 then
						v5 = v4.Position
						arg1.DeadPlayerPositions[v3.UserId] = v5
					end
					if v5 then
						local v_u10 = v3.UserId .. "_Dead"
						if not (arg1.Icons[v_u10] or arg1.FadedDeadIcons[v_u10]) then
							local v_team = v3:GetAttribute("Team")
							local v11 = v_u23(arg1.RadarContainer, "DeadTeammate", 12)
							v11.Name = v3.Name .. "_Dead"
							v11.ImageTransparency = 0
							for _, v12 in ipairs(v11:GetChildren()) do
								if v12.Name == "Direction" and v12:IsA("ImageLabel") then
									v12.Visible = false
								end
							end
							if v8 then
								local v13 = v_u5["Team Color"][v_team]
								if v13 then
									v11.ImageColor3 = v13
								end
							else
								v11.ImageColor3 = Color3.fromRGB(255, 0, 0)
							end
							arg1.Icons[v_u10] = {
								["Instance"] = v11,
								["Player"] = v3,
								["Target"] = nil,
								["Type"] = "DeadTeammate",
								["DefaultSize"] = v_u_radar.Dead.Size
							}
							if v5 and arg1.MinimapReference then
								local v_size = arg1.MinimapReference.Size
								local v_pointtoobjectspace = UNNAMED_1728998338968.Part.CFrame:PointToObjectSpace(v5)
								local v_imagerectoffset = arg1.MapImage.ImageRectOffset
								local v_imagerectsize = arg1.MapImage.ImageRectSize
								local v14 = ((-v_pointtoobjectspace.X / v_size.X + 0.5) * 1024 - v_imagerectoffset.X) / v_imagerectsize.X
								local v15 = ((-v_pointtoobjectspace.Z / v_size.Z + 0.5) * 1024 - v_imagerectoffset.Y) / v_imagerectsize.Y
								if arg1.MapImage.Rotation ~= 0 then
									local v_rad = math.rad(arg1.MapImage.Rotation)
									local v_cos = math.cos(v_rad)
									local v_sin = math.sin(v_rad)
									local v16 = v14 - 0.5
									local v17 = v15 - 0.5
									v14 = 0.5 + (v16 * v_cos - v17 * v_sin)
									v15 = 0.5 + (v16 * v_sin + v17 * v_cos)
								end
								local v18 = v14 - 0.5
								local v19 = v15 - 0.5
								local v_sqrt = math.sqrt(v18 * v18 + v19 * v19)
								if v_sqrt > 0.5 then
									v14 = 0.5 + v18 / v_sqrt * 0.5
									v15 = 0.5 + v19 / v_sqrt * 0.5
								end
								v11.Position = UDim2.fromScale(v14, v15)
								v11.Visible = true
							end
							task.delay(2, function()
								-- upvalues: (copy) arg1, (copy) v_u10, (ref) v_u_tween
								local v1 = arg1.Icons[v_u10]
								if v1 and (v1.Instance and v1.Instance.Parent) then
									arg1.FadedDeadIcons[v_u10] = true
									local v_create = v_u_tween:Create(v1.Instance, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
										["ImageTransparency"] = 1
									})
									v_create:Play()
									v_create.Completed:Connect(function()
										-- upvalues: (ref) arg1, (ref) v_u10
										if arg1.Icons[v_u10] then
											arg1:RemoveIcon(v_u10)
										end
									end)
								end
							end)
						end
					end
					if not v8 then
						arg1.EnemyVisibilityState[v_u9] = nil
						arg1.EnemyLastSeenPositions[v_u9] = nil
						arg1.EnemyLastSeenPositions[v_u9 .. "_Frozen"] = nil
					end
				else
					if v_character and v4 then
						local v20 = v3.UserId .. "_Dead"
						if arg1.Icons[v20] then
							arg1:RemoveIcon(v20)
						end
						arg1.DeadPlayerPositions[v3.UserId] = nil
						arg1.FadedDeadIcons[v20] = nil
						if not arg1.Icons[v_u9] then
							if v8 then
								local v_createplayericon = arg1:CreatePlayerIcon(v3, "Teammate")
								arg1.Icons[v_u9] = arg1.Icons[v_createplayericon]
								arg1.Icons[v_createplayericon] = nil
							else
								local v_createplayericon = arg1:CreatePlayerIcon(v3, "Enemy")
								arg1.Icons[v_u9] = arg1.Icons[v_createplayericon]
								arg1.Icons[v_createplayericon] = nil
								if arg1.Icons[v_u9] then
									arg1.Icons[v_u9].Instance.Visible = false
								end
							end
						end
					end
					local v21
					if v_character then
						v21 = v_character:GetAttribute("Dead") == true
					else
						v21 = false
					end
					if not (arg1.DeadPlayerPositions[v3.UserId] or v21) then
						if v8 then
							if arg1.Icons[v_u9] and v4 then
								arg1:UpdateTeammateIcon(v_u9, v4.Position, nil)
							elseif arg1.Icons[v_u9] then
								arg1:RemoveIcon(v_u9)
							end
						elseif arg1.Icons[v_u9] then
							local v22
							if v_character then
								v22 = v_character:GetAttribute("Dead") == true
							else
								v22 = false
							end
							local v23 = arg1.DeadPlayerPositions[v3.UserId]
							if not v_character and true or (v23 and true or v22) then
								if arg1.Icons[v_u9] then
									arg1:RemoveIcon(v_u9)
								end
								if not v23 then
									if v4 then
										v23 = v4.Position
										arg1.DeadPlayerPositions[v3.UserId] = v23
									elseif arg1.EnemyLastSeenPositions[v_u9] then
										v23 = arg1.EnemyLastSeenPositions[v_u9]
										arg1.DeadPlayerPositions[v3.UserId] = v23
									elseif arg1.EnemyLastSeenPositions[v_u9 .. "_Frozen"] then
										v23 = arg1.EnemyLastSeenPositions[v_u9 .. "_Frozen"]
										arg1.DeadPlayerPositions[v3.UserId] = v23
									end
								end
								if v23 then
									local v_u24 = v3.UserId .. "_Dead"
									if not (arg1.Icons[v_u24] or arg1.FadedDeadIcons[v_u24]) then
										local v_team = v3:GetAttribute("Team")
										local v25 = v_team == arg1.Team
										local v26 = v_u23(arg1.RadarContainer, "DeadTeammate", 12)
										v26.Name = v3.Name .. "_Dead"
										v26.ImageTransparency = 0
										for _, v27 in ipairs(v26:GetChildren()) do
											if v27.Name == "Direction" and v27:IsA("ImageLabel") then
												v27.Visible = false
											end
										end
										if v25 then
											local v28 = v_u5["Team Color"][v_team]
											if v28 then
												v26.ImageColor3 = v28
											end
										else
											v26.ImageColor3 = Color3.fromRGB(255, 0, 0)
										end
										arg1.Icons[v_u24] = {
											["Instance"] = v26,
											["Player"] = v3,
											["Target"] = nil,
											["Type"] = "DeadTeammate",
											["DefaultSize"] = v_u_radar.Dead.Size
										}
										task.delay(2, function()
											-- upvalues: (copy) arg1, (copy) v_u24, (ref) v_u_tween
											local v1 = arg1.Icons[v_u24]
											if v1 and (v1.Instance and v1.Instance.Parent) then
												arg1.FadedDeadIcons[v_u24] = true
												local v_create = v_u_tween:Create(v1.Instance, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
													["ImageTransparency"] = 1
												})
												v_create:Play()
												v_create.Completed:Connect(function()
													-- upvalues: (ref) arg1, (ref) v_u24
													if arg1.Icons[v_u24] then
														arg1:RemoveIcon(v_u24)
													end
												end)
											end
										end)
									end
								end
								arg1.EnemyVisibilityState[v_u9] = nil
								arg1.EnemyLastSeenPositions[v_u9] = nil
								arg1.EnemyLastSeenPositions[v_u9 .. "_Frozen"] = nil
							else
								local v29 = v_u20(v_character, v3, arg1.Team)
								local v30 = arg1.EnemyVisibilityState[v_u9] or false
								if v29 then
									if arg1.Icons[v_u9] and arg1.Icons[v_u9].Type == "EnemyQuestionMark" then
										local v_fadetween = arg1.Icons[v_u9].FadeTween
										if v_fadetween then
											v_fadetween:Cancel()
											arg1.Icons[v_u9].FadeTween = nil
										end
										local v_instance = arg1.Icons[v_u9].Instance
										if v_instance:IsA("TextLabel") then
											local v_position = v_instance.Position
											local v_anchorpoint = v_instance.AnchorPoint
											v_instance:Destroy()
											local v_slot5 = v3:GetAttribute("Slot5")
											local v31 = v_slot5 and v_u_http:JSONDecode(v_slot5 or "[]")
											if v31 then
												v31 = v31.Weapon == "C4"
											end
											local v32 = v3:GetAttribute("IsCarryingHostage") == true
											local v_imagelabel = Instance.new("ImageLabel")
											v_imagelabel.Name = v3.Name .. "_Enemy"
											if v31 then
												v_imagelabel.Image = v_u_radar.Bomb.Image
												v_imagelabel.Size = UDim2.fromOffset(14, 14)
											elseif v32 then
												local v_hostage = v_u_radar:FindFirstChild("Hostage")
												if v_hostage and v_hostage:IsA("ImageLabel") then
													v_imagelabel.Image = v_hostage.Image
												else
													v_imagelabel.Image = v_u_radar.Player.Image
												end
												v_imagelabel.Size = UDim2.fromOffset(30, 30)
											else
												v_imagelabel.Image = v_u_radar.Player.Image
												v_imagelabel.Size = UDim2.fromOffset(12, 12)
											end
											v_imagelabel.ImageColor3 = Color3.fromRGB(255, 0, 0)
											v_imagelabel.BackgroundTransparency = 1
											v_imagelabel.BorderSizePixel = 0
											v_imagelabel.Position = v_position
											v_imagelabel.AnchorPoint = v_anchorpoint
											v_imagelabel.ZIndex = v_u12.Enemy
											v_imagelabel.Visible = true
											v_imagelabel.Parent = arg1.RadarContainer
											arg1.Icons[v_u9].Instance = v_imagelabel
											arg1.Icons[v_u9].Type = "Enemy"
											arg1.Icons[v_u9].FadeTween = nil
											arg1.EnemyLastSeenPositions[v_u9 .. "_Frozen"] = nil
										end
									end
									if arg1.Icons[v_u9] and v4 then
										local v_instance = arg1.Icons[v_u9].Instance
										v_instance.Visible = true
										local v_slot5 = v3:GetAttribute("Slot5")
										local v33 = v_slot5 and v_u_http:JSONDecode(v_slot5 or "[]")
										if v33 then
											v33 = v33.Weapon == "C4"
										end
										local v34 = v3:GetAttribute("IsCarryingHostage") == true
										v_instance.ImageColor3 = Color3.fromRGB(255, 0, 0)
										if v33 then
											v_instance.Image = v_u_radar.Bomb.Image
											v_instance.Size = UDim2.fromOffset(14, 14)
										elseif v34 then
											local v_hostage = v_u_radar:FindFirstChild("Hostage")
											if v_hostage and v_hostage:IsA("ImageLabel") then
												v_instance.Image = v_hostage.Image
											else
												v_instance.Image = v_u_radar.Player.Image
											end
											v_instance.Size = UDim2.fromOffset(30, 30)
										else
											v_instance.Image = v_u_radar.Player.Image
											v_instance.Size = UDim2.fromOffset(12, 12)
										end
										arg1:UpdateTeammateIcon(v_u9, v4.Position, nil)
										arg1.EnemyLastSeenPositions[v_u9] = v4.Position
									elseif arg1.Icons[v_u9] then
										arg1:RemoveIcon(v_u9)
									end
								else
									local v35
									if v_character then
										v35 = v_character:GetAttribute("Dead") == true
									else
										v35 = false
									end
									if not v_character and true or (arg1.DeadPlayerPositions[v3.UserId] and true or v35) then
										if arg1.Icons[v_u9] then
											arg1:RemoveIcon(v_u9)
										end
										arg1.EnemyVisibilityState[v_u9] = nil
										arg1.EnemyLastSeenPositions[v_u9] = nil
										arg1.EnemyLastSeenPositions[v_u9 .. "_Frozen"] = nil
									elseif v30 and arg1.Icons[v_u9] then
										local v_instance = arg1.Icons[v_u9].Instance
										local v36 = nil
										local v37 = nil
										local v_fadetween = arg1.Icons[v_u9].FadeTween
										if v_fadetween then
											v_fadetween:Cancel()
											arg1.Icons[v_u9].FadeTween = nil
										end
										if v_instance:IsA("ImageLabel") then
											v36 = v_instance.Position
											v37 = v_instance.AnchorPoint
											v_instance:Destroy()
										elseif v_instance:IsA("TextLabel") then
											v36 = v_instance.Position
											v37 = v_instance.AnchorPoint
											v_instance:Destroy()
										end
										local v_clone = v_u_radar.EnemySeen:Clone()
										v_clone.Name = v3.Name .. "_QuestionMark"
										v_clone.Position = v36
										v_clone.AnchorPoint = v37
										v_clone.ZIndex = v_u12.EnemyQuestionMark
										v_clone.TextTransparency = 0
										v_clone.Visible = true
										v_clone.Parent = arg1.RadarContainer
										arg1.Icons[v_u9].Instance = v_clone
										arg1.Icons[v_u9].Type = "EnemyQuestionMark"
										arg1.Icons[v_u9].FadeTween = nil
										if arg1.EnemyLastSeenPositions[v_u9] then
											arg1.EnemyLastSeenPositions[v_u9 .. "_Frozen"] = arg1.EnemyLastSeenPositions[v_u9]
										end
										task.delay(0.1, function()
											-- upvalues: (copy) arg1, (copy) v_u9, (ref) v_u_tween
											if arg1.Icons[v_u9] and arg1.Icons[v_u9].Instance:IsA("TextLabel") then
												local v_instance = arg1.Icons[v_u9].Instance
												v_instance.TextTransparency = 0
												local v_create = v_u_tween:Create(v_instance, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
													["TextTransparency"] = 1
												})
												v_create:Play()
												arg1.Icons[v_u9].FadeTween = v_create
												v_create.Completed:Connect(function()
													-- upvalues: (ref) arg1, (ref) v_u9
													if arg1.Icons[v_u9] then
														arg1:RemoveIcon(v_u9)
														arg1.EnemyLastSeenPositions[v_u9 .. "_Frozen"] = nil
													end
												end)
											end
										end)
									end
									if arg1.Icons[v_u9] and arg1.Icons[v_u9].Type == "EnemyQuestionMark" then
										local v38 = arg1.EnemyLastSeenPositions[v_u9 .. "_Frozen"]
										if v38 then
											arg1:UpdateQuestionMarkIcon(v_u9, v38)
										end
									elseif arg1.Icons[v_u9] then
										arg1.Icons[v_u9].Instance.Visible = false
									end
								end
								if arg1.Icons[v_u9] then
									arg1.EnemyVisibilityState[v_u9] = v29
								end
							end
						end
					end
				end
			else
				local v39 = v3.UserId .. "_Player"
				local v40 = v3.UserId .. "_Dead"
				if arg1.Icons[v39] then
					arg1:RemoveIcon(v39)
				end
				if arg1.Icons[v40] then
					arg1:RemoveIcon(v40)
				end
				arg1.EnemyVisibilityState[v39] = nil
				arg1.EnemyLastSeenPositions[v39] = nil
				arg1.EnemyLastSeenPositions[v39 .. "_Frozen"] = nil
				arg1.DeadPlayerPositions[v3.UserId] = nil
				arg1.FadedDeadIcons[v40] = nil
			end
		end
	end
	for v41, v42 in pairs(arg1.DeadPlayerPositions) do
		local v43 = arg1.Icons[v41 .. "_Dead"]
		if v43 and arg1.MinimapReference then
			local v_size = arg1.MinimapReference.Size
			local v_pointtoobjectspace = UNNAMED_1728994450392.Part.CFrame:PointToObjectSpace(v42)
			local v_imagerectoffset = arg1.MapImage.ImageRectOffset
			local v_imagerectsize = arg1.MapImage.ImageRectSize
			local v44 = ((-v_pointtoobjectspace.X / v_size.X + 0.5) * 1024 - v_imagerectoffset.X) / v_imagerectsize.X
			local v45 = ((-v_pointtoobjectspace.Z / v_size.Z + 0.5) * 1024 - v_imagerectoffset.Y) / v_imagerectsize.Y
			if arg1.MapImage.Rotation ~= 0 then
				local v_rad = math.rad(arg1.MapImage.Rotation)
				local v_cos = math.cos(v_rad)
				local v_sin = math.sin(v_rad)
				local v46 = v44 - 0.5
				local v47 = v45 - 0.5
				v44 = 0.5 + (v46 * v_cos - v47 * v_sin)
				v45 = 0.5 + (v46 * v_sin + v47 * v_cos)
			end
			local v48 = v44 - 0.5
			local v49 = v45 - 0.5
			local v_sqrt = math.sqrt(v48 * v48 + v49 * v49)
			if v_sqrt > 0.5 then
				v44 = 0.5 + v48 / v_sqrt * 0.5
				v45 = 0.5 + v49 / v_sqrt * 0.5
			end
			v43.Instance.Position = UDim2.fromScale(v44, v45)
			v43.Instance.Visible = true
		end
	end
end
function v_u1.UpdateBombIcon(arg1)
	-- upvalues: (copy) v_u_collection, (copy) v_u_radar, (copy) v_u12, (copy) v_u21, (copy) v_u_fromrgb
	local v1 = nil
	local v2 = arg1.Team == "Counter-Terrorists"
	local v3 = v_u_collection:GetTagged("Bomb")[1]
	if v3 and (v3:IsA("Model") and v3.PrimaryPart) then
		v1 = v3
	else
		local v_weapondropped = v_u_collection:GetTagged("WeaponDropped")
		for _, v4 in ipairs(v_weapondropped) do
			if v4:IsA("Model") and (v4.PrimaryPart and v4:GetAttribute("Weapon") == "C4") then
				v1 = v4
				break
			end
		end
	end
	if v1 then
		if not arg1.Icons.Bomb then
			local v_clone = v_u_radar.Bomb:Clone()
			v_clone.Position = UDim2.fromScale(0.5, 0.5)
			v_clone.AnchorPoint = Vector2.new(0.5, 0.5)
			v_clone.Parent = arg1.RadarContainer
			v_clone.Size = UDim2.fromOffset(14, 14)
			v_clone.ZIndex = v_u12.Bomb
			v_clone.Name = "Bomb"
			arg1.Icons.Bomb = {
				["Instance"] = v_clone,
				["Player"] = nil,
				["Target"] = v1.PrimaryPart,
				["Type"] = "Bomb"
			}
		end
		local v_bomb = arg1.Icons.Bomb
		if not arg1.MinimapReference then
			v_bomb.Instance.Visible = false
			return
		end
		local v_position = v1.PrimaryPart.Position
		local v_size = arg1.MinimapReference.Size
		local v_pointtoobjectspace = UNNAMED_1729000505256.Part.CFrame:PointToObjectSpace(v_position)
		local v_imagerectoffset = arg1.MapImage.ImageRectOffset
		local v_imagerectsize = arg1.MapImage.ImageRectSize
		local v5 = ((-v_pointtoobjectspace.X / v_size.X + 0.5) * 1024 - v_imagerectoffset.X) / v_imagerectsize.X
		local v6 = ((-v_pointtoobjectspace.Z / v_size.Z + 0.5) * 1024 - v_imagerectoffset.Y) / v_imagerectsize.Y
		if arg1.MapImage.Rotation ~= 0 then
			local v_rad = math.rad(arg1.MapImage.Rotation)
			local v_cos = math.cos(v_rad)
			local v_sin = math.sin(v_rad)
			local v7 = v5 - 0.5
			local v8 = v6 - 0.5
			v5 = 0.5 + (v7 * v_cos - v8 * v_sin)
			v6 = 0.5 + (v7 * v_sin + v8 * v_cos)
		end
		local v9 = v5 - 0.5
		local v10 = v6 - 0.5
		local v_sqrt = math.sqrt(v9 * v9 + v10 * v10)
		if v_sqrt > 0.5 then
			v5 = 0.5 + v9 / v_sqrt * 0.5
			v6 = 0.5 + v10 / v_sqrt * 0.5
		end
		v_bomb.Instance.Position = UDim2.fromScale(v5, v6)
		if v2 and not v3 then
			local v11 = v_u21(v_position, v1, arg1.Character, arg1.LocalPlayer)
			local v12 = tick()
			if v11 then
				if not arg1.BombIsVisible then
					arg1.BombFadeStartTime = nil
				end
				arg1.BombIsVisible = true
				v_bomb.Instance.Visible = true
				if v_bomb.Instance:IsA("ImageLabel") then
					local v_instance = v_bomb.Instance
					v_instance.ImageTransparency = 0
					v_instance.ImageColor3 = v_u_fromrgb
					return
				end
				if v_bomb.Instance:IsA("ImageButton") then
					local v_instance = v_bomb.Instance
					v_instance.ImageTransparency = 0
					v_instance.ImageColor3 = v_u_fromrgb
					return
				end
				if v_bomb.Instance:IsA("TextLabel") then
					v_bomb.Instance.TextTransparency = 0
					return
				end
				if v_bomb.Instance:IsA("TextButton") then
					v_bomb.Instance.TextTransparency = 0
					return
				end
			else
				if arg1.BombIsVisible then
					arg1.BombFadeStartTime = v12
				end
				arg1.BombIsVisible = false
				if not arg1.BombFadeStartTime then
					v_bomb.Instance.Visible = false
					return
				end
				local v_clamp = math.clamp((v12 - arg1.BombFadeStartTime) / 8, 0, 1)
				if v_clamp >= 1 then
					v_bomb.Instance.Visible = false
					return
				end
				v_bomb.Instance.Visible = true
				if v_bomb.Instance:IsA("ImageLabel") then
					v_bomb.Instance.ImageTransparency = v_clamp
					return
				end
				if v_bomb.Instance:IsA("ImageButton") then
					v_bomb.Instance.ImageTransparency = v_clamp
					return
				end
				if v_bomb.Instance:IsA("TextLabel") then
					v_bomb.Instance.TextTransparency = v_clamp
					return
				end
				if v_bomb.Instance:IsA("TextButton") then
					v_bomb.Instance.TextTransparency = v_clamp
					return
				end
			end
		else
			v_bomb.Instance.Visible = true
			if v_bomb.Instance:IsA("ImageLabel") then
				local v_instance = v_bomb.Instance
				v_instance.ImageTransparency = 0
				if v3 and (v2 and v_sqrt > 0.5) then
					v_instance.ImageColor3 = v_u_fromrgb
					return
				end
			elseif v_bomb.Instance:IsA("ImageButton") then
				local v_instance = v_bomb.Instance
				v_instance.ImageTransparency = 0
				if v3 and (v2 and v_sqrt > 0.5) then
					v_instance.ImageColor3 = v_u_fromrgb
					return
				end
			else
				if v_bomb.Instance:IsA("TextLabel") then
					v_bomb.Instance.TextTransparency = 0
					return
				end
				if v_bomb.Instance:IsA("TextButton") then
					v_bomb.Instance.TextTransparency = 0
					return
				end
			end
		end
	elseif arg1.Icons.Bomb then
		arg1.Icons.Bomb.Instance.Visible = false
		arg1.BombIsVisible = false
		arg1.BombFadeStartTime = nil
	end
end
function v_u1.UpdateQuestionMarkIcon(arg1, arg2, arg3)
	local v1 = arg1.Icons[arg2]
	if v1 and arg1.MinimapReference then
		local v_instance = v1.Instance
		if v_instance and v_instance:IsA("TextLabel") then
			local v_size = arg1.MinimapReference.Size
			local v_pointtoobjectspace = UNNAMED_1729000291784.Part.CFrame:PointToObjectSpace(arg3)
			local v_imagerectoffset = arg1.MapImage.ImageRectOffset
			local v_imagerectsize = arg1.MapImage.ImageRectSize
			local v2 = ((-v_pointtoobjectspace.X / v_size.X + 0.5) * 1024 - v_imagerectoffset.X) / v_imagerectsize.X
			local v3 = ((-v_pointtoobjectspace.Z / v_size.Z + 0.5) * 1024 - v_imagerectoffset.Y) / v_imagerectsize.Y
			if arg1.MapImage.Rotation ~= 0 then
				local v_rad = math.rad(arg1.MapImage.Rotation)
				local v_cos = math.cos(v_rad)
				local v_sin = math.sin(v_rad)
				local v4 = v2 - 0.5
				local v5 = v3 - 0.5
				v2 = 0.5 + (v4 * v_cos - v5 * v_sin)
				v3 = 0.5 + (v4 * v_sin + v5 * v_cos)
			end
			local v6 = v2 - 0.5
			local v7 = v3 - 0.5
			local v_sqrt = math.sqrt(v6 * v6 + v7 * v7)
			if v_sqrt > 0.5 then
				v2 = 0.5 + v6 / v_sqrt * 0.5
				v3 = 0.5 + v7 / v_sqrt * 0.5
			end
			v_instance.Position = UDim2.fromScale(v2, v3)
			v_instance.Visible = true
		end
	else
		return
	end
end
function v_u1.UpdateSiteIcons(arg1)
	-- upvalues: (copy) v_u_radar, (copy) v_u12
	for v1, v2 in pairs(arg1.SiteParts) do
		local v3 = "Site_" .. v1
		local v4
		if #v2 == 0 then
			v4 = Vector3.new(0, 0, 0)
		else
			local v5 = Vector3.new(0, 0, 0)
			for _, v6 in ipairs(v2) do
				v5 = v5 + v6.Position
			end
			v4 = v5 / #v2
		end
		if arg1.Icons[v3] then
			::l10::
			local v7 = arg1.Icons[v3]
			if arg1.MinimapReference then
				local v_size = arg1.MinimapReference.Size
				local v_pointtoobjectspace = UNNAMED_1728997931928.Part.CFrame:PointToObjectSpace(v4)
				local v8 = -v_pointtoobjectspace.X / v_size.X + 0.5
				local v9 = -v_pointtoobjectspace.Z / v_size.Z + 0.5
				local v_imagerectoffset = arg1.MapImage.ImageRectOffset
				local v_imagerectsize = arg1.MapImage.ImageRectSize
				local v10 = 0.5 / math.clamp(arg1.Settings.Zoom or 0.5, 0.1, 1)
				local v_map = workspace:GetAttribute("Map")
				if v_map == "Mirage" and true or v_map == "Winter Mirage" then
					if v1 == "A" then
						v8 = v8 + v10 * -0.02 * v_imagerectsize.X / 1024
						v9 = v9 + v10 * 0.04 * v_imagerectsize.Y / 1024
					elseif v1 == "B" then
						v8 = v8 + v10 * -0.015 * v_imagerectsize.X / 1024
						v9 = v9 + v10 * -0.005 * v_imagerectsize.Y / 1024
					end
				elseif v_map == "Vertigo" and true or v_map == "Winter Vertigo" then
					if v1 == "A" then
						v8 = v8 + v10 * 0.0425 * v_imagerectsize.X / 1024
						v9 = v9 + v10 * 0.005 * v_imagerectsize.Y / 1024
					elseif v1 == "B" then
						v8 = v8 + v10 * -0.01 * v_imagerectsize.X / 1024
						v9 = v9 + v10 * -0.01 * v_imagerectsize.Y / 1024
					end
				end
				local v11 = (v8 * 1024 - v_imagerectoffset.X) / v_imagerectsize.X
				local v12 = (v9 * 1024 - v_imagerectoffset.Y) / v_imagerectsize.Y
				if arg1.MapImage.Rotation ~= 0 then
					local v_rad = math.rad(arg1.MapImage.Rotation)
					local v_cos = math.cos(v_rad)
					local v_sin = math.sin(v_rad)
					local v13 = v11 - 0.5
					local v14 = v12 - 0.5
					v11 = 0.5 + (v13 * v_cos - v14 * v_sin)
					v12 = 0.5 + (v13 * v_sin + v14 * v_cos)
				end
				local v15 = v11 - 0.5
				local v16 = v12 - 0.5
				local v_sqrt = math.sqrt(v15 * v15 + v16 * v16)
				if v_sqrt > 0.5 then
					v11 = 0.5 + v15 / v_sqrt * 0.485
					v12 = 0.5 + v16 / v_sqrt * 0.485
				end
				v7.Instance.Position = UDim2.fromScale(v11, v12)
				v7.Instance.Visible = true
				local v17 = v_sqrt > 0.5
				local v_defaultsize = v7.DefaultSize
				if v_defaultsize then
					if v17 then
						v7.Instance.Size = v_defaultsize
					else
						v7.Instance.Size = UDim2.new(v_defaultsize.X.Scale * v10, v_defaultsize.X.Offset * v10, v_defaultsize.Y.Scale * v10, v_defaultsize.Y.Offset * v10)
					end
				end
			else
				v7.Instance.Visible = false
			end
		else
			local v18 = v_u_radar:FindFirstChild(v1)
			if v18 then
				local v_clone = v18:Clone()
				v_clone.Name = v1 .. "_Icon"
				v_clone.Position = UDim2.fromScale(0.5, 0.5)
				v_clone.AnchorPoint = Vector2.new(0.5, 0.5)
				v_clone.ZIndex = v_u12.Site
				v_clone.Visible = true
				if v_clone:IsA("TextLabel") then
					v_clone.TextXAlignment = Enum.TextXAlignment.Center
					v_clone.TextYAlignment = Enum.TextYAlignment.Center
				end
				v_clone.Parent = arg1.RadarContainer
				arg1.Icons[v3] = {
					["Instance"] = v_clone,
					["Player"] = nil,
					["Target"] = nil,
					["Type"] = "Site",
					["DefaultSize"] = v18.Size
				}
				goto l10
			end
			warn((("Site icon template not found for: %*"):format(v1)))
		end
	end
end
function v_u1.UpdateHostageIcons(arg1)
	-- upvalues: (copy) v_u_collection, (copy) v_u_radar, (copy) v_u12, (copy) v_u_players, (copy) v_u22
	local v_hostage = v_u_collection:GetTagged("Hostage")
	local v1 = {}
	for _, v2 in ipairs(v_hostage) do
		if v2:IsA("Model") and v2.PrimaryPart then
			local v_name = v2.Name
			local v3 = "Hostage_" .. v_name
			v1[v3] = true
			if not arg1.Icons[v3] then
				local v_hostage = v_u_radar:FindFirstChild("Hostage")
				if not (v_hostage and v_hostage:IsA("ImageLabel")) then
					v_hostage = v_u_radar.Player
				end
				local v_clone = v_hostage:Clone()
				v_clone.Position = UDim2.fromScale(0.5, 0.5)
				v_clone.AnchorPoint = Vector2.new(0.5, 0.5)
				v_clone.Parent = arg1.RadarContainer
				v_clone.Size = UDim2.fromOffset(30, 30)
				v_clone.ZIndex = v_u12.Hostage
				v_clone.Name = "Hostage_" .. v_name
				v_clone.Visible = true
				for _, v4 in ipairs(v_clone:GetChildren()) do
					if v4.Name == "Direction" and v4:IsA("ImageLabel") then
						v4.Visible = false
					end
				end
				arg1.Icons[v3] = {
					["Instance"] = v_clone,
					["Player"] = nil,
					["Target"] = v2.PrimaryPart,
					["Type"] = "Hostage"
				}
			end
			local v5 = arg1.Icons[v3]
			if arg1.MinimapReference then
				local v_carryingplayer = v2:GetAttribute("CarryingPlayer")
				local v6
				if v_carryingplayer then
					local v7 = v_u_players:FindFirstChild(v_carryingplayer)
					if v7 and (v7.Character and v7.Character.PrimaryPart) then
						v6 = v7.Character.PrimaryPart.Position
					else
						v6 = v2.PrimaryPart.Position
					end
				else
					v6 = v2.PrimaryPart.Position
				end
				local v_size = arg1.MinimapReference.Size
				local v_pointtoobjectspace = UNNAMED_1729000515480.Part.CFrame:PointToObjectSpace(v6)
				local v_imagerectoffset = arg1.MapImage.ImageRectOffset
				local v_imagerectsize = arg1.MapImage.ImageRectSize
				local v8 = ((-v_pointtoobjectspace.X / v_size.X + 0.5) * 1024 - v_imagerectoffset.X) / v_imagerectsize.X
				local v9 = ((-v_pointtoobjectspace.Z / v_size.Z + 0.5) * 1024 - v_imagerectoffset.Y) / v_imagerectsize.Y
				if arg1.MapImage.Rotation ~= 0 then
					local v_rad = math.rad(arg1.MapImage.Rotation)
					local v_cos = math.cos(v_rad)
					local v_sin = math.sin(v_rad)
					local v10 = v8 - 0.5
					local v11 = v9 - 0.5
					v8 = 0.5 + (v10 * v_cos - v11 * v_sin)
					v9 = 0.5 + (v10 * v_sin + v11 * v_cos)
				end
				local v12 = v8 - 0.5
				local v13 = v9 - 0.5
				local v_sqrt = math.sqrt(v12 * v12 + v13 * v13)
				if v_sqrt > 0.5 then
					v8 = 0.5 + v12 / v_sqrt * 0.5
					v9 = 0.5 + v13 / v_sqrt * 0.5
				end
				v5.Instance.Position = UDim2.fromScale(v8, v9)
				local v_team = arg1.Team
				if v_carryingplayer ~= nil then
					if v_team == "Counter-Terrorists" then
						v5.Instance.Visible = true
					elseif v_team == "Terrorists" then
						v5.Instance.Visible = v_u22(v6, v2, arg1.Character, arg1.LocalPlayer)
					else
						v5.Instance.Visible = true
					end
				else
					v5.Instance.Visible = true
				end
			else
				v5.Instance.Visible = false
			end
		end
	end
	for v14, v15 in pairs(arg1.Icons) do
		if v15.Type == "Hostage" and not v1[v14] then
			arg1:RemoveIcon(v14)
		end
	end
end
function v_u1.UpdateMinimapTexture(arg1)
	-- upvalues: (copy) v_u24, (copy) v_u_current_camera
	if arg1.MinimapReference then
		local v_minimapreference = arg1.MinimapReference
		local v1 = v_minimapreference.Lower or v_minimapreference.Upper
		if v1 then
			arg1.MapImage.Image = v1.Texture
			arg1.MapImage.ImageTransparency = 0
			if v1.Texture:match("%d+") then
				local v_map = workspace:GetAttribute("Map")
				local v2 = v_map == "Vertigo" and true or v_map == "Winter Vertigo"
				local v_upper = v_minimapreference.Upper
				local v_uppermapimage = arg1.UpperMapImage
				if v2 then
					if v_upper == nil then
						v2 = false
					else
						v2 = v_uppermapimage ~= nil
					end
				end
				if arg1.Character and arg1.Character.PrimaryPart then
					local v_y = arg1.Character.PrimaryPart.Position.Y
					if v2 and (v_uppermapimage and v_upper) then
						v_uppermapimage.Image = v_upper.Texture
						v_uppermapimage.ImageTransparency = v_y >= 222 and 0 or 1
					end
				else
					arg1.MapImage.ImageTransparency = 0
					if v2 and (v_uppermapimage and v_upper) then
						v_uppermapimage.Image = v_upper.Texture
					end
				end
				if arg1.Character and arg1.Character.PrimaryPart then
					local _ = arg1.Settings.CentersPlayer
					local v_part = v_minimapreference.Part
					local v_pointtoobjectspace = v_part.CFrame:PointToObjectSpace(arg1.Character.PrimaryPart.Position)
					local v_size = v_minimapreference.Size
					local v3 = math.clamp(arg1.Settings.Zoom or 0.7, 0.1, 1) * 1024 * 0.5
					local v_clamp = math.clamp((-v_pointtoobjectspace.X / v_size.X + 0.5) * 1024 - v3 / 2, 0, 1024 - v3)
					local v_clamp = math.clamp((-v_pointtoobjectspace.Z / v_size.Z + 0.5) * 1024 - v3 / 2, 0, 1024 - v3)
					arg1.ViewCenterLocal = Vector3.new(-(((v_clamp + v3 / 2) / 1024 - 0.5) * v_size.X), 0, -(((v_clamp + v3 / 2) / 1024 - 0.5) * v_size.Z))
					local v_new = Vector2.new(v_clamp, v_clamp)
					local v_new = Vector2.new(v3, v3)
					arg1.MapImage.ImageRectOffset = v_new
					arg1.MapImage.ImageRectSize = v_new
					if v2 and v_uppermapimage then
						v_uppermapimage.ImageRectOffset = v_new
						v_uppermapimage.ImageRectSize = v_new
					end
					local v4 = arg1.IsSpectating and 90 or (not arg1.Settings.Rotation and 90 or -v_u24(v_u_current_camera.CFrame.LookVector, v_part) + 90 - 90)
					arg1.MapImage.Rotation = v4
					if v2 and v_uppermapimage then
						v_uppermapimage.Rotation = v4
						return
					end
				else
					local v_new = Vector2.new(0, 0)
					local v_new = Vector2.new(1024, 1024)
					arg1.MapImage.ImageRectOffset = v_new
					arg1.MapImage.ImageRectSize = v_new
					arg1.MapImage.Rotation = 90
					if v2 and v_uppermapimage then
						v_uppermapimage.ImageRectOffset = v_new
						v_uppermapimage.ImageRectSize = v_new
						v_uppermapimage.Rotation = 90
					end
					arg1.ViewCenterLocal = Vector3.new(0, 0, 0)
				end
			end
		else
			return
		end
	else
		return
	end
end
function v_u1.ApplySettings(arg1)
	-- upvalues: (copy) v_u11, (copy) v_u25
	arg1.MapImage.Size = UDim2.fromScale(1, 1)
	if arg1.UpperMapImage then
		arg1.UpperMapImage.Size = UDim2.fromScale(1, 1)
	end
	local v1 = v_u11 * (arg1.Settings.Scale or 1)
	arg1.RadarContainer.Size = UDim2.fromOffset(v1, v1)
	local v_new = UDim2.new(0, 10, 0, 10)
	local v2 = v_u25(arg1.Frame, v1, v_new)
	arg1.Frame.Position = v2
	arg1:UpdateMinimapTexture()
end
function v_u1.CreateRunningCircle(arg1)
	-- upvalues: (copy) v_u12
	if not arg1.RunningCircle then
		local v_frame = Instance.new("Frame")
		v_frame.Name = "RunningCircle"
		v_frame.BackgroundTransparency = 1
		v_frame.Size = UDim2.fromScale(1, 1)
		v_frame.Position = UDim2.fromScale(0.5, 0.5)
		v_frame.AnchorPoint = Vector2.new(0.5, 0.5)
		v_frame.ZIndex = v_u12.LocalPlayer - 1
		v_frame.Parent = arg1.RadarContainer
		local v_uistroke = Instance.new("UIStroke")
		v_uistroke.Color = Color3.fromRGB(255, 255, 255)
		v_uistroke.Thickness = 2
		v_uistroke.Transparency = 1
		v_uistroke.Parent = v_frame
		local v_uicorner = Instance.new("UICorner")
		v_uicorner.CornerRadius = UDim.new(1, 0)
		v_uicorner.Parent = v_frame
		arg1.RunningCircle = v_frame
	end
end
function v_u1.CreateKnifeCircle(arg1)
	-- upvalues: (copy) v_u12
	if not arg1.KnifeCircle then
		local v_frame = Instance.new("Frame")
		v_frame.Name = "KnifeCircle"
		v_frame.BackgroundTransparency = 1
		v_frame.Size = UDim2.fromScale(1, 1)
		v_frame.Position = UDim2.fromScale(0.5, 0.5)
		v_frame.AnchorPoint = Vector2.new(0.5, 0.5)
		v_frame.ZIndex = v_u12.LocalPlayer - 1
		v_frame.Parent = arg1.RadarContainer
		v_frame.Visible = false
		local v_uistroke = Instance.new("UIStroke")
		v_uistroke.Color = Color3.fromRGB(255, 255, 255)
		v_uistroke.Thickness = 2
		v_uistroke.Transparency = 1
		v_uistroke.Parent = v_frame
		local v_uicorner = Instance.new("UICorner")
		v_uicorner.CornerRadius = UDim.new(1, 0)
		v_uicorner.Parent = v_frame
		arg1.KnifeCircle = v_frame
	end
end
function v_u1.CreateWeaponCircle(arg1)
	-- upvalues: (copy) v_u12
	if not arg1.WeaponCircle then
		local v_frame = Instance.new("Frame")
		v_frame.Name = "WeaponCircle"
		v_frame.BackgroundTransparency = 1
		v_frame.Size = UDim2.fromScale(1, 1)
		v_frame.Position = UDim2.fromScale(0.5, 0.5)
		v_frame.AnchorPoint = Vector2.new(0.5, 0.5)
		v_frame.ZIndex = v_u12.LocalPlayer - 1
		v_frame.Parent = arg1.RadarContainer
		v_frame.Visible = false
		local v_uistroke = Instance.new("UIStroke")
		v_uistroke.Color = Color3.fromRGB(255, 255, 255)
		v_uistroke.Thickness = 2
		v_uistroke.Transparency = 1
		v_uistroke.Parent = v_frame
		local v_uicorner = Instance.new("UICorner")
		v_uicorner.CornerRadius = UDim.new(1, 0)
		v_uicorner.Parent = v_frame
		arg1.WeaponCircle = v_frame
	end
end
function v_u1.FlashRadarBorder(self)
	-- upvalues: (ref) v_u13, (copy) v_u6
	if v_u13 and v_u13.Radar then
		local v_uistroke = v_u13.Radar.UIStroke
		if v_uistroke then
			if not self.OriginalBorderColor then
				self.OriginalBorderColor = v_uistroke.Color
			end
			v_uistroke.Color = Color3.fromRGB(255, 255, 255)
			if self.BorderRestoreTask then
				task.cancel(self.BorderRestoreTask)
				self.BorderRestoreTask = nil
			end
			self.BorderRestoreTask = task.delay(0.2, function()
				-- upvalues: (ref) v_u13, (ref) v_u6, (copy) self
				if v_u13 and (v_u13.Radar and v_u13.Radar.UIStroke) then
					v_u13.Radar.UIStroke.Color = v_u6()
				end
				self.BorderRestoreTask = nil
			end)
		end
	else
		return
	end
end
function v_u1.ShowWeaponCircle(self)
	-- upvalues: (copy) v_u11
	if not self.WeaponCircle then
		self:CreateWeaponCircle()
	end
	local v_u_weaponcircle = self.WeaponCircle
	if v_u_weaponcircle then
		local v_u_uistroke = v_u_weaponcircle:FindFirstChildOfClass("UIStroke")
		if v_u_uistroke then
			local v1 = v_u11 / 2 * (self.Settings.Scale or 1) * 2
			v_u_weaponcircle.Size = UDim2.fromOffset(v1, v1)
			v_u_uistroke.Thickness = 2
			v_u_uistroke.Transparency = 0
			v_u_weaponcircle.Visible = true
			if self.WeaponCircleHideTask then
				task.cancel(self.WeaponCircleHideTask)
				self.WeaponCircleHideTask = nil
			end
			self.WeaponCircleHideTask = task.delay(0.2, function()
				-- upvalues: (copy) v_u_weaponcircle, (copy) v_u_uistroke, (copy) self
				if v_u_weaponcircle and v_u_uistroke then
					v_u_uistroke.Transparency = 1
					v_u_weaponcircle.Visible = false
				end
				self.WeaponCircleHideTask = nil
			end)
		end
	else
		return
	end
end
function v_u1.ShowKnifeCircle(arg1)
	-- upvalues: (copy) v_u11
	if not arg1.KnifeCircle then
		arg1:CreateKnifeCircle()
	end
	local v_u_knifecircle = arg1.KnifeCircle
	if v_u_knifecircle then
		local v_u_uistroke = v_u_knifecircle:FindFirstChildOfClass("UIStroke")
		if v_u_uistroke then
			local v_clamp = math.clamp(arg1.Settings.Zoom or 0.5, 0.1, 1)
			local v1 = v_u11 / 2 * (arg1.Settings.Scale or 1)
			local v_min = math.min(0.5 / v_clamp * 35 * UNNAMED_1729000290968, v1)
			local v2 = v_min * 2
			v_u_knifecircle.Size = UDim2.fromOffset(v2, v2)
			if v_min == v1 then
				v_u_uistroke.Thickness = 2
				v_u_uistroke.Transparency = 0
			else
				v_u_uistroke.Thickness = 1
				v_u_uistroke.Transparency = 0.5
			end
			v_u_knifecircle.Visible = true
			task.delay(0.2, function()
				-- upvalues: (copy) v_u_knifecircle, (copy) v_u_uistroke
				if v_u_knifecircle and v_u_uistroke then
					v_u_uistroke.Transparency = 1
					v_u_knifecircle.Visible = false
				end
			end)
		end
	else
		return
	end
end
function v_u1.UpdateRunningCircle(self)
	-- upvalues: (copy) v_u2, (copy) v_u11
	if self.Character and self.Character.PrimaryPart then
		local v_humanoid = self.Character:FindFirstChildOfClass("Humanoid")
		if v_humanoid then
			local v1 = v_u2.GetWalkState() or false
			local v2 = v_humanoid.MoveDirection.Magnitude > 0
			if v2 then
				v2 = not v1
			end
			local v_getcurrentcharacter = v_u2.getCurrentCharacter()
			local v3 = v_getcurrentcharacter and v_getcurrentcharacter.IsJumping or false
			local v4 = v2 or v3
			if not self.RunningCircle then
				self:CreateRunningCircle()
			end
			local v_runningcircle = self.RunningCircle
			if v_runningcircle then
				local v_uistroke = v_runningcircle:FindFirstChildOfClass("UIStroke")
				if v_uistroke then
					local v_clamp = math.clamp(self.Settings.Zoom or 0.5, 0.1, 1)
					local v5 = v_u11 / 2 * (self.Settings.Scale or 1)
					local v_min = math.min(0.5 / v_clamp * 50 * UNNAMED_1729000287032, v5)
					local v6 = v_min * 2
					v_runningcircle.Size = UDim2.fromOffset(v6, v6)
					local v7 = v_min == v5
					if v7 then
						v_uistroke.Thickness = 2
					else
						v_uistroke.Thickness = 1
					end
					if v4 then
						if v7 then
							v_uistroke.Transparency = 0
						else
							v_uistroke.Transparency = 0.5
						end
						if v3 then
							if self.RunningCircleDelayTask then
								task.cancel(self.RunningCircleDelayTask)
								self.RunningCircleDelayTask = nil
							end
							v_runningcircle.Visible = true
						elseif v2 then
							if self.WasRunning then
								if not self.RunningCircleDelayTask then
									if v7 then
										v_uistroke.Transparency = 0
									else
										v_uistroke.Transparency = 0.5
									end
									v_runningcircle.Visible = true
								end
							else
								if self.RunningCircleDelayTask then
									task.cancel(self.RunningCircleDelayTask)
									self.RunningCircleDelayTask = nil
								end
								v_runningcircle.Visible = false
								v_uistroke.Transparency = 1
								self.RunningCircleDelayTask = task.delay(0.4, function()
									-- upvalues: (copy) self, (ref) v_u2, (ref) v_u11
									if self.Character and self.Character.PrimaryPart then
										local v_humanoid = self.Character:FindFirstChildOfClass("Humanoid")
										if v_humanoid then
											local v1 = v_u2.GetWalkState() or false
											local v2 = v_humanoid.MoveDirection.Magnitude > 0
											if v2 then
												v2 = not v1
											end
											if v2 and self.RunningCircle then
												local v_runningcircle = self.RunningCircle
												local v_uistroke = v_runningcircle:FindFirstChildOfClass("UIStroke")
												if v_uistroke then
													local v_clamp = math.clamp(self.Settings.Zoom or 0.5, 0.1, 1)
													local v3 = v_u11 / 2 * (self.Settings.Scale or 1)
													if math.min(0.5 / v_clamp * 50 * UNNAMED_1729000292456, v3) == v3 then
														v_uistroke.Transparency = 0
													else
														v_uistroke.Transparency = 0.5
													end
													v_runningcircle.Visible = true
												end
											end
											self.RunningCircleDelayTask = nil
										else
											self.RunningCircleDelayTask = nil
										end
									else
										self.RunningCircleDelayTask = nil
										return
									end
								end)
							end
						end
					else
						if self.RunningCircleDelayTask then
							task.cancel(self.RunningCircleDelayTask)
							self.RunningCircleDelayTask = nil
						end
						v_runningcircle.Visible = false
						v_uistroke.Transparency = 1
					end
					self.WasRunning = v4
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
function v_u1.CreateDeadIconForPlayer(arg1, arg2, arg3)
	-- upvalues: (copy) v_u23, (copy) v_u5, (copy) v_u_radar, (copy) v_u_tween
	local v1 = arg2.UserId .. "_Player"
	if arg1.Icons[v1] then
		arg1:RemoveIcon(v1)
	end
	local v_u2 = arg2.UserId .. "_Dead"
	if not (arg1.Icons[v_u2] or arg1.FadedDeadIcons[v_u2]) then
		local v_team = arg2:GetAttribute("Team")
		local v3 = v_team == arg1.Team
		local v4 = v_u23(arg1.RadarContainer, "DeadTeammate", 12)
		v4.Name = arg2.Name .. "_Dead"
		v4.ImageTransparency = 0
		for _, v5 in ipairs(v4:GetChildren()) do
			if v5.Name == "Direction" and v5:IsA("ImageLabel") then
				v5.Visible = false
			end
		end
		if v3 then
			local v6 = v_u5["Team Color"][v_team]
			if v6 then
				v4.ImageColor3 = v6
			end
		else
			v4.ImageColor3 = Color3.fromRGB(255, 0, 0)
		end
		arg1.Icons[v_u2] = {
			["Instance"] = v4,
			["Player"] = arg2,
			["Target"] = nil,
			["Type"] = "DeadTeammate",
			["DefaultSize"] = v_u_radar.Dead.Size
		}
		if arg3 and arg1.MinimapReference then
			local v_size = arg1.MinimapReference.Size
			local v_pointtoobjectspace = UNNAMED_1728998340744.Part.CFrame:PointToObjectSpace(arg3)
			local v_imagerectoffset = arg1.MapImage.ImageRectOffset
			local v_imagerectsize = arg1.MapImage.ImageRectSize
			local v7 = ((-v_pointtoobjectspace.X / v_size.X + 0.5) * 1024 - v_imagerectoffset.X) / v_imagerectsize.X
			local v8 = ((-v_pointtoobjectspace.Z / v_size.Z + 0.5) * 1024 - v_imagerectoffset.Y) / v_imagerectsize.Y
			if arg1.MapImage.Rotation ~= 0 then
				local v_rad = math.rad(arg1.MapImage.Rotation)
				local v_cos = math.cos(v_rad)
				local v_sin = math.sin(v_rad)
				local v9 = v7 - 0.5
				local v10 = v8 - 0.5
				v7 = 0.5 + (v9 * v_cos - v10 * v_sin)
				v8 = 0.5 + (v9 * v_sin + v10 * v_cos)
			end
			local v11 = v7 - 0.5
			local v12 = v8 - 0.5
			local v_sqrt = math.sqrt(v11 * v11 + v12 * v12)
			if v_sqrt > 0.5 then
				v7 = 0.5 + v11 / v_sqrt * 0.5
				v8 = 0.5 + v12 / v_sqrt * 0.5
			end
			v4.Position = UDim2.fromScale(v7, v8)
			v4.Visible = true
		end
		task.delay(2, function()
			-- upvalues: (copy) arg1, (copy) v_u2, (ref) v_u_tween
			local v1 = arg1.Icons[v_u2]
			if v1 and (v1.Instance and v1.Instance.Parent) then
				arg1.FadedDeadIcons[v_u2] = true
				local v_create = v_u_tween:Create(v1.Instance, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
					["ImageTransparency"] = 1
				})
				v_create:Play()
				v_create.Completed:Connect(function()
					-- upvalues: (ref) arg1, (ref) v_u2
					if arg1.Icons[v_u2] then
						arg1:RemoveIcon(v_u2)
					end
				end)
			end
		end)
	end
end
function v_u1.Render(arg1, _)
	arg1:UpdateMinimapTexture()
	arg1:UpdatePlayerIcons(arg1.Settings.Rotation)
	arg1:UpdateBombIcon()
	arg1:UpdateSiteIcons()
	arg1:UpdateHostageIcons()
	arg1:UpdateRunningCircle()
end
function v_u1.new(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u10, (copy) v_u_localplayer, (copy) v_u16, (copy) v_u14, (copy) v_u18, (copy) v_u9, (copy) v_u_run, (copy) v_u_players, (copy) v_u8
	local v_u1 = setmetatable({}, v_u1)
	v_u1.Janitor = v_u10.new()
	v_u1.Frame = arg1
	v_u1.RadarContainer = arg1.Radar
	v_u1.MapImage = arg1.Radar.Map
	v_u1.MapImage.AnchorPoint = Vector2.new(0.5, 0.5)
	v_u1.MapImage.Position = UDim2.fromScale(0.5, 0.5)
	v_u1.MapImage.ZIndex = 1
	v_u1.LocalPlayer = v_u_localplayer
	v_u1.Character = arg2
	v_u1.Team = v_u_localplayer:GetAttribute("Team")
	v_u1.MinimapReference = v_u16()
	local v_map = workspace:GetAttribute("Map")
	if (v_map == "Vertigo" and true or v_map == "Winter Vertigo") and (v_u1.MinimapReference and v_u1.MinimapReference.Upper) then
		local v_clone = v_u1.MapImage:Clone()
		v_clone.Name = "UpperMap"
		v_clone.ZIndex = 2
		v_clone.BackgroundTransparency = 1
		v_clone.Parent = v_u1.RadarContainer
		v_u1.UpperMapImage = v_clone
		v_u1.Janitor:Add(function()
			-- upvalues: (copy) v_u1
			if v_u1.UpperMapImage then
				v_u1.UpperMapImage:Destroy()
			end
		end)
	else
		v_u1.UpperMapImage = nil
	end
	v_u1.Frame.Visible = true
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1
		v_u1.Frame.Visible = true
	end)
	v_u1.Settings = v_u14
	v_u1.IsSpectating = false
	v_u1.Icons = {}
	v_u1.SiteParts = v_u18()
	v_u1.DeadPlayerPositions = {}
	v_u1.FadedDeadIcons = {}
	v_u1.EnemyVisibilityState = {}
	v_u1.EnemyLastSeenPositions = {}
	v_u1.RunningCircle = nil
	v_u1.RunningCircleDelayTask = nil
	v_u1.WasRunning = false
	v_u1.KnifeCircle = nil
	v_u1.WeaponCircle = nil
	v_u1.WeaponCircleHideTask = nil
	v_u1.OriginalBorderColor = nil
	v_u1.BorderRestoreTask = nil
	v_u1.BombIsVisible = false
	v_u1.BombFadeStartTime = nil
	v_u1:ApplySettings()
	local v_u_broadcastrouter = v_u9.broadcastRouter
	function v_u9.broadcastRouter(arg1, ...)
		-- upvalues: (copy) v_u_broadcastrouter, (copy) v_u1
		local v1 = v_u_broadcastrouter(arg1, ...)
		if arg1 == "UpdatePlayerNoiseCone" then
			local v2 = { ... }
			local v3 = v2[1]
			local v4 = v2[2]
			if v4 and (v_u1.Character and (v_u1.Character.PrimaryPart and (v4 - v_u1.Character.PrimaryPart.Position).Magnitude < 5)) then
				if v3 == "Melee" then
					v_u1:ShowKnifeCircle()
					return v1
				end
				if v3 == "Weapon" then
					v_u1:ShowWeaponCircle()
					v_u1:FlashRadarBorder()
				end
			end
		end
		return v1
	end
	v_u1.Janitor:Add(function()
		-- upvalues: (ref) v_u9, (copy) v_u_broadcastrouter
		v_u9.broadcastRouter = v_u_broadcastrouter
	end)
	local v_u2 = 0
	v_u1.Janitor:Add(v_u_run.RenderStepped:Connect(function(arg1)
		-- upvalues: (ref) v_u2, (copy) v_u1
		if v_u2 + arg1 >= 0.004166666666666667 then
			v_u1:Render(arg1)
			v_u2 = 0
		end
	end))
	v_u1.Janitor:Add(v_u_localplayer:GetAttributeChangedSignal("Team"):Connect(function()
		-- upvalues: (copy) v_u1
		v_u1:RefreshIconsOnTeamChange()
	end))
	for _, v_u3 in ipairs(v_u_players:GetPlayers()) do
		if v_u3 ~= v_u1.LocalPlayer then
			v_u1.Janitor:Add(v_u3:GetAttributeChangedSignal("Team"):Connect(function()
				-- upvalues: (copy) v_u1, (copy) v_u3
				v_u1:RefreshPlayerIcon(v_u3)
			end))
		end
	end
	v_u1.Janitor:Add(v_u_players.PlayerAdded:Connect(function(self)
		-- upvalues: (copy) v_u1
		if self ~= v_u1.LocalPlayer then
			v_u1.Janitor:Add(self:GetAttributeChangedSignal("Team"):Connect(function()
				-- upvalues: (ref) v_u1, (copy) self
				v_u1:RefreshPlayerIcon(self)
			end))
		end
	end))
	v_u1.Janitor:Add(v_u_players.PlayerRemoving:Connect(function(arg1)
		-- upvalues: (copy) v_u1
		for v1, v2 in pairs(v_u1.Icons) do
			if v2.Player == arg1 then
				v_u1:RemoveIcon(v1)
			end
		end
		v_u1.DeadPlayerPositions[arg1.UserId] = nil
		v_u1.FadedDeadIcons[arg1.UserId .. "_Dead"] = nil
	end))
	v_u1.Janitor:Add(v_u8.UI.UIPlayerKilled.Listen(function(arg1)
		-- upvalues: (ref) v_u_players, (ref) v_u_localplayer, (copy) v_u1
		local v_getplayerbyuserid = v_u_players:GetPlayerByUserId((tonumber(arg1.Victim)))
		if v_getplayerbyuserid and v_getplayerbyuserid ~= v_u_localplayer then
			local v_deathposition = arg1.DeathPosition
			if v_deathposition then
				v_u1.DeadPlayerPositions[v_getplayerbyuserid.UserId] = v_deathposition
				v_u1:CreateDeadIconForPlayer(v_getplayerbyuserid, v_deathposition)
			end
		else
			return
		end
	end))
	v_u1.Janitor:Add(workspace:GetAttributeChangedSignal("Map"):Connect(function()
		-- upvalues: (copy) v_u1, (ref) v_u16, (ref) v_u18
		v_u1.MinimapReference = v_u16()
		v_u1.SiteParts = v_u18()
		local v_map = workspace:GetAttribute("Map")
		local v1 = v_map == "Vertigo" and true or v_map == "Winter Vertigo"
		if v_u1.UpperMapImage then
			v_u1.UpperMapImage:Destroy()
			v_u1.UpperMapImage = nil
		end
		for _, v2 in ipairs(v_u1.RadarContainer:GetChildren()) do
			if v2.Name == "UpperMap" and v2:IsA("ImageLabel") then
				v2:Destroy()
			end
		end
		v_u1.MapImage.Image = ""
		v_u1.MapImage.ImageTransparency = 0
		v_u1.MapImage.ImageRectOffset = Vector2.new(0, 0)
		v_u1.MapImage.ImageRectSize = Vector2.new(0, 0)
		v_u1.MapImage.Rotation = 0
		v_u1.MapImage.Visible = true
		v_u1.MapImage.Size = UDim2.fromScale(1, 1)
		if v1 and (v_u1.MinimapReference and v_u1.MinimapReference.Upper) then
			local v_clone = v_u1.MapImage:Clone()
			v_clone.Name = "UpperMap"
			v_clone.ZIndex = 2
			v_clone.Parent = v_u1.RadarContainer
			v_u1.UpperMapImage = v_clone
		else
			v_u1.UpperMapImage = nil
		end
		v_u1:UpdateMinimapTexture()
		for v3, _ in pairs(v_u1.Icons) do
			v_u1:RemoveIcon(v3)
		end
		table.clear(v_u1.EnemyVisibilityState)
		table.clear(v_u1.EnemyLastSeenPositions)
		table.clear(v_u1.DeadPlayerPositions)
		table.clear(v_u1.FadedDeadIcons)
	end))
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1
		for _, v1 in pairs(v_u1.Icons) do
			if v1.Instance and v1.Instance.Parent then
				v1.Instance:Destroy()
			end
		end
		table.clear(v_u1.Icons)
		table.clear(v_u1.EnemyVisibilityState)
		table.clear(v_u1.EnemyLastSeenPositions)
		if v_u1.UpperMapImage then
			v_u1.UpperMapImage:Destroy()
			v_u1.UpperMapImage = nil
		end
		if v_u1.RadarContainer then
			for _, v2 in ipairs(v_u1.RadarContainer:GetChildren()) do
				if v2.Name == "UpperMap" and v2:IsA("ImageLabel") then
					v2:Destroy()
				end
			end
		end
		if v_u1.RunningCircleDelayTask then
			task.cancel(v_u1.RunningCircleDelayTask)
			v_u1.RunningCircleDelayTask = nil
		end
		if v_u1.RunningCircle then
			v_u1.RunningCircle:Destroy()
			v_u1.RunningCircle = nil
		end
		if v_u1.KnifeCircle then
			v_u1.KnifeCircle:Destroy()
			v_u1.KnifeCircle = nil
		end
		if v_u1.WeaponCircleHideTask then
			task.cancel(v_u1.WeaponCircleHideTask)
			v_u1.WeaponCircleHideTask = nil
		end
		if v_u1.WeaponCircle then
			v_u1.WeaponCircle:Destroy()
			v_u1.WeaponCircle = nil
		end
		local v3 = v_u1
		if v3.BorderRestoreTask then
			task.cancel(v3.BorderRestoreTask)
			v3.BorderRestoreTask = nil
		end
		if v_u1.RunningCircle then
			v_u1.RunningCircle:Destroy()
			v_u1.RunningCircle = nil
		end
	end)
	return v_u1
end
function v_u1.Destroy(arg1)
	arg1.Janitor:Destroy()
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u13, (copy) v_u4, (copy) v_u_localplayer, (copy) v_u14, (ref) v_u15, (copy) v_u6
	v_u13 = arg2
	v_u4.CreateListener(v_u_localplayer, "Settings.Game.Radar/Tablet.Radar Centers The Player", function(arg1)
		-- upvalues: (ref) v_u14, (ref) v_u15
		v_u14.CentersPlayer = arg1
		if v_u15 then
			v_u15:ApplySettings()
		end
	end)
	v_u4.CreateListener(v_u_localplayer, "Settings.Game.Radar/Tablet.Radar Hud Size", function(arg1)
		-- upvalues: (ref) v_u14, (ref) v_u15
		v_u14.Scale = arg1
		if v_u15 then
			v_u15:ApplySettings()
		end
	end)
	v_u4.CreateListener(v_u_localplayer, "Settings.Game.Radar/Tablet.Radar Is Rotating", function(arg1)
		-- upvalues: (ref) v_u14, (ref) v_u15
		v_u14.Rotation = arg1
		if v_u15 then
			v_u15:ApplySettings()
		end
	end)
	v_u4.CreateListener(v_u_localplayer, "Settings.Game.Radar/Tablet.Radar Map Zoom", function(arg1)
		-- upvalues: (ref) v_u14, (ref) v_u15
		v_u14.Zoom = arg1
		if v_u15 then
			v_u15:ApplySettings()
		end
	end)
	v_u13.Radar.UIStroke.Color = v_u6()
	v_u_localplayer.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u13, (ref) v_u6
		v_u13.Radar.UIStroke.Color = v_u6()
	end)
	v_u4.CreateListener(v_u_localplayer, "Settings.Game.HUD.Color", function()
		-- upvalues: (ref) v_u13, (ref) v_u15, (ref) v_u6
		if v_u13 and (v_u13.Radar and v_u13.Radar.UIStroke) then
			local v_uistroke = v_u13.Radar.UIStroke
			local v1
			if v_u15 then
				v1 = v_u15.BorderRestoreTask ~= nil
			else
				v1 = false
			end
			if not v1 or v_uistroke.Color ~= Color3.fromRGB(255, 255, 255) then
				v_uistroke.Color = v_u6()
			end
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u17, (copy) v_u3
	v_u_localplayer.CharacterAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u17, (ref) v_u_localplayer
		v_u17(arg1, v_u_localplayer, false)
	end)
	v_u3.ListenToSpectate:Connect(function(arg1)
		-- upvalues: (ref) v_u17, (ref) v_u_localplayer
		if arg1 then
			local v_character = arg1.Character
			if v_character and v_character:IsDescendantOf(workspace) then
				v_u17(v_character, arg1, true)
				return
			end
		else
			local v_character = v_u_localplayer.Character
			if v_character and v_character:IsDescendantOf(workspace) then
				v_u17(v_character, v_u_localplayer, false)
			end
		end
	end)
end
return v_u1