-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_players = game:GetService("Players")
local v_u_run = game:GetService("RunService")
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_collection = game:GetService("CollectionService")
local v_u_localplayer = v_players.LocalPlayer
local v_u_current_camera = workspace.CurrentCamera
local v_u2 = require(v_replicatedstorage.Database.Components.GameState)
local v3 = require(v_replicatedstorage.Packages.ByteNet)
local v_u4 = require(script.Parent.InputController)
local v_u5 = require(v_replicatedstorage.Components.Common.GetPreferenceColor)
local v6 = require(v_replicatedstorage.Database.Security.Remotes)
local _ = v3.Hints
local v_u7 = nil
local v_u8 = nil
local v_hints = v_replicatedstorage:WaitForChild("Assets"):WaitForChild("UI"):WaitForChild("Hints")
local v_u_static = v_hints:WaitForChild("Static")
local v_u_ranged = v_hints:WaitForChild("Ranged")
local v_u9 = {
	["Inspect"] = {
		["Type"] = "Static",
		["Action"] = "Inspect",
		["Blurb"] = "Inspect"
	},
	["Reload"] = {
		["Type"] = "Static",
		["Action"] = "Reload",
		["Blurb"] = "Reload your Weapon!"
	},
	["Use"] = {
		["Type"] = "Static",
		["Action"] = "Use"
	},
	["Plant"] = {
		["Type"] = "Ranged",
		["Action"] = "Plant",
		["Blurb"] = "Plant the Bomb!",
		["HideDistance"] = 5
	},
	["Defuse"] = {
		["Type"] = "Ranged",
		["Action"] = "Defuse",
		["Blurb"] = "Defuse the Bomb!",
		["HideDistance"] = 5
	},
	["Rescue"] = {
		["Type"] = "Ranged",
		["Action"] = "Rescue",
		["Blurb"] = "Rescue the Hostage!",
		["HideDistance"] = 5
	}
}
local function v_u10(arg1, arg2)
	local v1 = {}
	for _, v2 in ipairs(arg1:GetDescendants()) do
		if v2:IsA("BasePart") and v2:GetAttribute("Site") == arg2 then
			table.insert(v1, v2)
		end
	end
	return v1
end
function isOnScreen(arg1)
	-- upvalues: (copy) v_u_current_camera
	local v_worldtoviewportpoint, v1 = v_u_current_camera:WorldToViewportPoint(arg1)
	local v_viewportsize = v_u_current_camera.ViewportSize
	if v1 then
		if v_worldtoviewportpoint.X < 100 or (v_worldtoviewportpoint.X > v_viewportsize.X - 100 or (v_worldtoviewportpoint.Y < 100 or v_worldtoviewportpoint.Y > v_viewportsize.Y - 100)) then
			return false, v_worldtoviewportpoint
		else
			return true, v_worldtoviewportpoint
		end
	else
		return false, v_worldtoviewportpoint
	end
end
local function v_u11()
	-- upvalues: (ref) v_u7, (copy) v_u_current_camera, (copy) v_u_localplayer, (copy) v_u1
	if v_u7 and (v_u7.ui and v_u7.target) then
		local v_icon = v_u7.ui:FindFirstChild("Icon")
		local v_arrow = v_u7.ui:FindFirstChild("Arrow")
		local v_attention = v_u7.ui:FindFirstChild("Attention")
		if v_icon and (v_arrow and v_attention) then
			local v_cframe = v_u_current_camera.CFrame
			local v_viewportsize = v_u_current_camera.ViewportSize
			if v_u7.target and v_u7.target.Parent then
				local v_position = v_u7.target.Position
				local v_character = v_u_localplayer.Character
				if v_character then
					local v_humanoidrootpart = v_character:FindFirstChild("HumanoidRootPart")
					if v_humanoidrootpart and (v_humanoidrootpart.Position - v_position).Magnitude <= (v_u7.hideDistance or 5) then
						local v1 = v_u7 and v_u7.ui
						if v1 then
							v1 = v_u7.ui:GetAttribute("Type")
						end
						v_u1:clearHint()
						if v1 then
							if v1 == "Defuse" then
								v_u1:createHint("Use", nil, "Defuse the Bomb!")
								task.delay(3, function()
									-- upvalues: (ref) v_u1
									v_u1:clearHint("Use")
								end)
							elseif v1 == "Rescue" then
								v_u1:createHint("Use", nil, "Rescue the Hostage!")
								task.delay(3, function()
									-- upvalues: (ref) v_u1
									v_u1:clearHint("Use")
								end)
							end
						else
							return
						end
					end
				end
				local v2, v3 = isOnScreen(v_position)
				if v2 then
					v_u7.ui.BackgroundTransparency = 0.5
					v_u7.ui.Position = UDim2.new(0, v3.X, 0, v3.Y - 60)
					v_u7.ui.AnchorPoint = Vector2.new(0.5, 0.5)
					v_attention.Size = UDim2.new(0.75, 0, 0.75, 0)
					v_attention.Visible = true
					v_arrow.Visible = false
					v_icon.Visible = false
					v_u7.ui.Visible = true
				else
					v_u7.ui.BackgroundTransparency = 1
					local v_new = Vector2.new(v_viewportsize.X / 2, v_viewportsize.Y / 2)
					local v_dot = (v_position - v_cframe.Position).Unit:Dot(v_cframe.RightVector)
					local v_atan2 = math.atan2(-UNNAMED_1728994319112:Dot(v_cframe.UpVector), v_dot)
					local v4 = math.min(v_viewportsize.X, v_viewportsize.Y) / 2 - 60
					v_u7.ui.Position = UDim2.new(0, v_new.X + math.cos(v_atan2) * v4, 0, v_new.Y + math.sin(v_atan2) * v4)
					v_u7.ui.AnchorPoint = Vector2.new(0.5, 0.5)
					v_arrow.Visible = true
					v_arrow.Position = UDim2.new(0.5, 0, 0.5, 0)
					v_arrow.AnchorPoint = Vector2.new(0.5, 0.5)
					v_arrow.Rotation = math.deg(v_atan2) - 90
					local v5 = v_atan2 + 3.141592653589793
					v_icon.Position = UDim2.new(0.5, math.cos(v5) * 55, 0.5, math.sin(v5) * 55)
					v_icon.Visible = true
					v_attention.Visible = false
					v_u7.ui.Visible = true
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
local function v_u12(arg1, arg2, arg3, arg4, arg5)
	-- upvalues: (copy) v_u5, (ref) v_u8, (copy) v_u_run, (copy) v_u11
	if arg1 and arg2 then
		if arg1:FindFirstChild("Left") and arg1:FindFirstChild("Right") then
			arg1.Left.BackgroundColor3 = v_u5()
			arg1.Right.BackgroundColor3 = v_u5()
			if arg2.Type == "Static" then
				local v_controlicon = arg1:FindFirstChild("ControlIcon")
				local v_instructions = arg1:FindFirstChild("Instructions")
				if v_controlicon and v_instructions then
					local v_keycapicon = v_controlicon:FindFirstChild("KeycapIcon")
					if v_keycapicon then
						local v_control = v_keycapicon:FindFirstChild("Control")
						if v_control then
							arg1:SetAttribute("Type", arg2.Action)
							v_instructions.Text = arg5 or arg2.Blurb
							v_control.Text = arg3 or "???"
						end
					else
						return
					end
				else
					return
				end
			else
				if arg2.Type == "Ranged" then
					local v_icon = arg1:FindFirstChild("Icon")
					local v_arrow = arg1:FindFirstChild("Arrow")
					local v_attention = arg1:FindFirstChild("Attention")
					local v_instructions = v_attention:FindFirstChild("Instructions")
					if not (v_icon and (v_arrow and (v_attention and (arg4 and v_instructions)))) then
						return
					end
					v_instructions.Text = arg2.Blurb
					if v_u8 then
						v_u8:Disconnect()
						v_u8 = nil
					end
					v_u8 = v_u_run.RenderStepped:Connect(v_u11)
				end
				return
			end
		else
			arg1:Destroy()
			return
		end
	else
		return
	end
end
function v_u1.getKeyOfAction(_, arg2)
	-- upvalues: (copy) v_u4
	if arg2 then
		return v_u4.GetActionKeybind(arg2)
	end
end
function v_u1.createHint(_, arg2, arg3, arg4)
	-- upvalues: (copy) v_u2, (copy) v_u9, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u_static, (copy) v_u12, (ref) v_u7, (copy) v_u_ranged
	v_u2.GetState()
	if v_u2.GetState() == "Round In Progress" then
		if arg2 and v_u9[arg2] then
			v_u1:clearHint()
			local v1 = v_u9[arg2]
			local v_playergui = v_u_localplayer:FindFirstChild("PlayerGui")
			if v_playergui then
				local v_maingui = v_playergui:FindFirstChild("MainGui")
				if v_maingui then
					local v_gameplay = v_maingui:WaitForChild("Gameplay")
					if v_gameplay then
						local v_middle = v_gameplay:WaitForChild("Middle")
						if v_middle then
							if v1.Type == "Static" then
								local v_clone = v_u_static:Clone()
								v_u12(v_clone, v1, v_u1:getKeyOfAction(arg2), nil, arg4)
								v_u7 = {
									["ui"] = v_clone,
									["target"] = nil,
									["hintType"] = arg2
								}
								v_clone:SetAttribute("Type", arg2)
								v_clone.Parent = v_middle
								v_clone.Visible = true
								v_clone:SetAttribute("Type", arg2)
								v_clone.Parent = v_middle
								v_clone.Visible = true
							elseif v1.Type == "Ranged" and arg3 then
								local v_clone = v_u_ranged:Clone()
								v_u7 = {
									["ui"] = v_clone,
									["target"] = arg3,
									["hintType"] = arg2,
									["hideDistance"] = v1.HideDistance or 5
								}
								v_u12(v_clone, v1, nil, arg3)
								v_clone:SetAttribute("Type", arg2)
								v_clone.Parent = v_middle
								v_clone.Visible = true
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
function v_u1.clearHint(_, arg2)
	-- upvalues: (ref) v_u7, (ref) v_u8
	if arg2 then
		if v_u7 and v_u7.hintType == arg2 then
			if v_u7.ui then
				v_u7.ui:Destroy()
			end
			if v_u8 then
				v_u8:Disconnect()
				v_u8 = nil
			end
			v_u7 = nil
		end
	elseif v_u7 then
		if v_u7.ui then
			v_u7.ui:Destroy()
		end
		if v_u8 then
			v_u8:Disconnect()
			v_u8 = nil
		end
		v_u7 = nil
	end
end
v6.Hints.BombSiteEntered.Listen(function(arg1)
	-- upvalues: (copy) v_u10, (copy) v_u_collection, (copy) v_u1
	if arg1 and (arg1.action and arg1.site) then
		local v_map = workspace:FindFirstChild("Map")
		if v_map then
			local v_zones = v_map:FindFirstChild("Zones")
			if v_zones then
				local v_sites = v_zones:FindFirstChild("Sites")
				if v_sites then
					local v1 = v_u10(v_sites, arg1.site)
					if arg1.action == "Defuse" then
						local v_bomb = v_u_collection:GetTagged("Bomb")
						if #v_bomb == 1 and (v1 and #v1 > 0) then
							local v2 = v1[math.random(1, #v1)]
							local v3 = v_bomb[1].PrimaryPart or v2
							if v2 then
								v_u1:createHint(arg1.action, v3)
							end
						end
					end
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
end)
v6.Hints.ClearHint.Listen(function()
	-- upvalues: (copy) v_u1
	v_u1:clearHint("Rescue")
	v_u1:clearHint("UseRescue")
end)
v6.Character.CharacterDied.Listen(function()
	-- upvalues: (copy) v_u1
	v_u1:clearHint()
end)
local function v_u13()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u_collection
	if v_u_localplayer and (v_u_localplayer.Character and v_u_localplayer.Character.PrimaryPart) then
		local v_hostage = v_u_collection:GetTagged("Hostage")
		if not v_hostage or #v_hostage <= 0 then
			return nil, (1 / 0)
		end
		local v_position = v_u_localplayer.Character.PrimaryPart.Position
		local v1 = (1 / 0)
		local v2 = nil
		for _, v3 in ipairs(v_hostage) do
			if v3.PrimaryPart and v3:GetAttribute("CanRescue") then
				local v_magnitude = (v3.PrimaryPart.Position - v_position).Magnitude
				if v_magnitude < v1 then
					v2 = v3
					v1 = v_magnitude
				end
			end
		end
		return v2, v1
	end
end
local function v_u14()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u_collection, (ref) v_u7, (copy) v_u1, (copy) v_u13
	if v_u2.GetState() == "Round In Progress" then
		local v_team = v_u_localplayer:GetAttribute("Team")
		if v_team then
			v_team = v_u_localplayer:GetAttribute("Team") == "Counter-Terrorists"
		end
		if v_team then
			local v_hostage = v_u_collection:GetTagged("Hostage")
			if v_hostage and #v_hostage > 0 then
				local v1, v2 = v_u13()
				if v_u7 and (v_u7.hintType == "Rescue" or v_u7.hintType == "UseRescue") then
					if v_u7.target and v1 then
						if v2 >= 50 then
							print("No hostage within range, clearing hint")
							v_u1:clearHint()
							return
						end
						if v_u7.target ~= v1.PrimaryPart and (v2 < (v_u_localplayer.Character.PrimaryPart.Position - v_u7.target.Position).Magnitude - 10 and v2 < 50) then
							print("Found closer hostage, switching target")
							v_u1:clearHint()
							v_u1:createHint("Rescue", v1.PrimaryPart)
							return
						end
					elseif not v1 or v2 >= 50 then
						v_u1:clearHint()
					end
				elseif v1 and v2 < 50 then
					v_u1:createHint("Rescue", v1.PrimaryPart)
				end
			else
				if v_u7 and (v_u7.hintType == "Rescue" or v_u7.hintType == "UseRescue") then
					v_u1:clearHint()
				end
				return
			end
		else
			return
		end
	else
		return
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u14
	while true do
		v_u14()
		task.wait(2)
	end
end)
return v_u1