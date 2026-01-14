-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_tween = game:GetService("TweenService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u_settings = v_replicatedstorage:WaitForChild("Assets"):WaitForChild("UI"):WaitForChild("Settings")
local v_u2 = require(v_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_replicatedstorage.Components.Common.GetUserPlatform)
local v_u4 = require(v_replicatedstorage.Shared.Janitor)
local v_u5 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u6 = require(v_replicatedstorage.Database.Custom.GameStats.UI.Settings.Pages)
local v_u7 = require(script.Templates.CrosshairPreview)
local v_u8 = require(script.Templates.Dropdown)
local v_u9 = require(script.Templates.Keybind)
local v_u10 = require(script.Templates.Number)
local v_u11 = require(script.Templates.Toggle)
local v_u12 = require(script.Templates.Slider)
local v_u_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v_u_fromrgb = Color3.fromRGB(53, 83, 99)
local v_u_fromrgb = Color3.fromRGB(243, 243, 243)
local v_u_fromrgb = Color3.fromRGB(125, 206, 243)
local v_u13 = {
	"Keyboard & Mouse Settings",
	"Movement Keys",
	"Weapon Keys",
	"UI Keys",
	"Communication Options"
}
local v_u14 = {
	"Item",
	"HUD",
	"Crosshair",
	"Viewmodel",
	"Radar/Tablet",
	"Other"
}
local v_u15 = {
	["Video"] = "Video",
	["Audio"] = "Audio",
	["Game"] = "Game",
	["Keybinds"] = "Keyboard/Mouse"
}
local v_u16 = nil
local v_u17 = {}
local v_u18 = {}
local v_u19 = {}
local v_u20 = {}
local v_u21 = {}
local v_u22 = nil
local v_u23 = nil
local v_u24 = nil
local v_u25 = nil
local v_u26 = nil
local v_u27 = 0
local v_u_video = "Video"
local v_u28 = {
	["CrosshairPreviewTemplate"] = nil,
	["DropdownTemplate"] = nil,
	["KeybindTemplate"] = nil,
	["NumberTemplate"] = nil,
	["ToggleTemplate"] = nil,
	["SliderTemplate"] = nil
}
local function v_u29(arg1, arg2)
	-- upvalues: (copy) v_u29
	if arg1 == arg2 then
		return true
	end
	if type(arg1) ~= type(arg2) then
		return false
	end
	if type(arg1) ~= "table" then
		return false
	end
	local v1 = {}
	for v2, v3 in pairs(arg1) do
		if not v_u29(v3, arg2[v2]) then
			return false
		end
		v1[v2] = true
	end
	for v4 in pairs(arg2) do
		if not v1[v4] then
			return false
		end
	end
	return true
end
local function v_u30(arg1)
	-- upvalues: (ref) v_u_video, (copy) v_u20, (copy) v_u21, (ref) v_u16
	local v1 = v_u_video
	if v_u20[v1] then
		v_u20[v1]:Cleanup()
		v_u20[v1] = nil
	end
	if v1 == "Keybinds" then
		table.clear(v_u21)
		v_u16 = nil
	end
	for _, v2 in ipairs(arg1:GetChildren()) do
		if v2:IsA("GuiObject") and (v2.Name ~= "Header" and v2.Name ~= "Title") then
			v2:Destroy()
		end
	end
end
local function v_u31(arg1, arg2)
	-- upvalues: (copy) v_u4, (copy) v_u_tween, (copy) v_u_new
	local v_u_frame = arg1.Frame
	local v_u_size = arg1.Size
	local v_u_new = v_u4.new()
	v_u_new:Add(arg1.MouseEnter:Connect(function()
		-- upvalues: (copy) arg1, (copy) arg2, (ref) v_u_tween, (ref) v_u_new, (copy) v_u_size, (copy) v_u_frame
		if not arg1:GetAttribute("Selected") then
			if not arg2 then
				v_u_tween:Create(arg1, v_u_new, {
					["Size"] = UDim2.new(v_u_size.X.Scale * 0.98, 0, v_u_size.Y.Scale, 0)
				}):Play()
			end
			if arg2 and v_u_frame then
				v_u_tween:Create(v_u_frame, v_u_new, {
					["BackgroundTransparency"] = 0.85
				}):Play()
			end
		end
	end), "Disconnect", "HoverEnter")
	v_u_new:Add(arg1.MouseLeave:Connect(function()
		-- upvalues: (copy) arg1, (copy) arg2, (ref) v_u_tween, (ref) v_u_new, (copy) v_u_size, (copy) v_u_frame
		if not arg1:GetAttribute("Selected") then
			if not arg2 then
				v_u_tween:Create(arg1, v_u_new, {
					["Size"] = v_u_size
				}):Play()
			end
			if arg2 and v_u_frame then
				v_u_tween:Create(v_u_frame, v_u_new, {
					["BackgroundTransparency"] = 1
				}):Play()
			end
		end
	end), "Disconnect", "HoverLeave")
	v_u_new:Add(arg1.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) arg1, (ref) v_u_new, (copy) v_u_size
		v_u_tween:Create(arg1, v_u_new, {
			["Size"] = UDim2.new(v_u_size.X.Scale * 0.95, 0, v_u_size.Y.Scale, 0)
		}):Play()
	end), "Disconnect", "MouseDown")
	v_u_new:Add(arg1.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) arg1, (ref) v_u_new, (copy) v_u_size
		local v1 = v_u_tween
		local v2 = arg1
		local v3 = v_u_new
		local v4 = {}
		local v5
		if arg1:GetAttribute("Selected") then
			v5 = v_u_size
		else
			v5 = UDim2.new(v_u_size.X.Scale * 0.98, 0, v_u_size.Y.Scale, 0)
		end
		v4.Size = v5
		v1:Create(v2, v3, v4):Play()
	end), "Disconnect", "MouseUp")
	return function()
		-- upvalues: (copy) v_u_new
		v_u_new:Cleanup()
	end
end
local function v_u32(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_fromrgb
	local v_textlabel = Instance.new("TextLabel")
	v_textlabel.Name = ("Category_%*"):format(arg1)
	v_textlabel.Text = string.upper(arg1)
	v_textlabel.Font = Enum.Font.GothamBold
	v_textlabel.TextSize = 14
	v_textlabel.TextColor3 = v_u_fromrgb
	v_textlabel.TextXAlignment = Enum.TextXAlignment.Left
	v_textlabel.TextYAlignment = Enum.TextYAlignment.Bottom
	v_textlabel.BackgroundTransparency = 1
	v_textlabel.Size = UDim2.new(1, 0, 0, 35)
	v_textlabel.LayoutOrder = arg3
	v_textlabel.Parent = arg2
	return v_textlabel
end
local function v_u33(arg1, arg2)
	-- upvalues: (copy) v_u18
	if v_u18.Keybinds and v_u18.Keybinds[arg1] then
		local v1 = v_u18.Keybinds[arg1]:FindFirstChild(arg2)
		if v1 and v1.TextBox then
			v1.TextBox.TextColor3 = Color3.fromRGB(255, 90, 90)
		end
	else
		return
	end
end
local function v_u34(arg1, arg2)
	-- upvalues: (copy) v_u18, (copy) v_u_tween, (copy) v_u_fromrgb
	if v_u18.Keybinds and v_u18.Keybinds[arg1] then
		local v1 = v_u18.Keybinds[arg1]:FindFirstChild(arg2)
		if v1 and v1.TextBox then
			v_u_tween:Create(v1.TextBox, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["TextColor3"] = v_u_fromrgb
			}):Play()
		end
	else
		return
	end
end
local function v_u35(arg1)
	-- upvalues: (copy) v_u18, (copy) v_u_tween
	if v_u18.Keybinds and v_u18.Keybinds[arg1] then
		local v1 = v_u18.Keybinds[arg1]
		if v1.Parent and UNNAMED_1728997485288:IsA("ScrollingFrame") then
			local v_y = UNNAMED_1728997485288.AbsoluteSize.Y
			local v_max = math.max(0, v1.AbsolutePosition.Y - UNNAMED_1728997485288.AbsolutePosition.Y + UNNAMED_1728997485288.CanvasPosition.Y - v_y / 2 + v1.AbsoluteSize.Y / 2)
			local v_min = math.min(v_max, UNNAMED_1728997485288.CanvasSize.Y.Offset - v_y)
			v_u_tween:Create(UNNAMED_1728997485288, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				["CanvasPosition"] = Vector2.new(0, v_min)
			}):Play()
		end
	else
		return
	end
end
local function v_u36(arg1, arg2, arg3, arg4)
	-- upvalues: (ref) v_u22, (copy) v_u15, (copy) v_u1, (copy) v_u21, (copy) v_u18, (copy) v_u33, (copy) v_u35
	local v1
	if v_u22 then
		local v2 = v_u22[v_u15.Keybinds or "Keybinds"]
		if v2 then
			local function v_u3(arg1)
				-- upvalues: (copy) arg1, (copy) v_u3
				for v1, v2 in pairs(arg1) do
					if v1 == arg1 then
						return v2
					end
					if type(v2) == "table" then
						local v3 = v_u3(v2)
						if v3 ~= nil then
							return v3
						end
					end
				end
				return nil
			end
			v1 = v_u3(v2)
		else
			v1 = nil
		end
	else
		v1 = nil
	end
	local v4 = v1 or {}
	local v5
	if type(v4) == "table" then
		v5 = v4[arg4]
	else
		v5 = nil
	end
	local v6
	if v_u22 then
		local v7 = v_u22[v_u15.Keybinds or "Keybinds"]
		if v7 then
			local function v_u8(arg1)
				-- upvalues: (copy) arg2, (copy) v_u8
				for v1, v2 in pairs(arg1) do
					if v1 == arg2 then
						return v2
					end
					if type(v2) == "table" then
						local v3 = v_u8(v2)
						if v3 ~= nil then
							return v3
						end
					end
				end
				return nil
			end
			v6 = v_u8(v7)
		else
			v6 = nil
		end
	else
		v6 = nil
	end
	local v9 = v6 or {}
	local v10 = type(v9) ~= "table" and {} or v9
	v10[arg4] = v5 or ""
	v_u1.SettingChanged("Keybinds", arg2, v10)
	if arg3 ~= "" and arg3 ~= "None" then
		v_u21[("%*:%*"):format(arg4, arg3)] = nil
	end
	if v5 and (v5 ~= "" and (v5 ~= "" and v5 ~= "None")) then
		v_u21[("%*:%*"):format(arg4, v5)] = arg2
	end
	if v_u18.Keybinds and v_u18.Keybinds[arg2] then
		local v11 = v_u18.Keybinds[arg2]:FindFirstChild(arg4)
		if v11 and v11.TextBox then
			v11.TextBox.Text = v5 and v5 ~= "" and (v5:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", "") or "None") or "None"
		end
	end
	v_u33(arg1, arg4)
	v_u33(arg2, arg4)
	v_u35(arg2)
end
local function v_u37(arg1, arg2)
	-- upvalues: (ref) v_u26, (copy) v_u21, (ref) v_u_video, (ref) v_u22, (copy) v_u15, (copy) v_u_fromrgb, (copy) v_u34, (copy) v_u1, (copy) v_u36, (ref) v_u23, (ref) v_u24
	if v_u26 then
		local v_u_name = arg1.Parent.Name
		local v_name = arg1.Name
		local v1
		if arg2 == "" or arg2 == "None" then
			v1 = nil
		else
			v1 = v_u21[("%*:%*"):format(v_name, arg2)]
			if not v1 or v1 == v_u_name then
				v1 = nil
			end
		end
		local v2 = v1 ~= nil
		local v3 = v_u_video
		local v4
		if v_u22 then
			local v5 = v_u22[v_u15[v3] or v3]
			if v5 then
				local function v_u6(arg1)
					-- upvalues: (copy) v_u_name, (copy) v_u6
					for v1, v2 in pairs(arg1) do
						if v1 == v_u_name then
							return v2
						end
						if type(v2) == "table" then
							local v3 = v_u6(v2)
							if v3 ~= nil then
								return v3
							end
						end
					end
					return nil
				end
				v4 = v_u6(v5)
			else
				v4 = nil
			end
		else
			v4 = nil
		end
		local v7 = v4 or {}
		local v8 = {
			["Computer"] = type(v7) ~= "table" and "" or v7.Computer,
			["Console"] = type(v7) ~= "table" and "" or v7.Console
		}
		local v9 = v8[v_name]
		if v9 and (v9 ~= "" and (v9 ~= "" and v9 ~= "None")) then
			v_u21[("%*:%*"):format(v_name, v9)] = nil
		end
		v8[v_name] = arg2
		if arg2 ~= "" and arg2 ~= "None" then
			v_u21[("%*:%*"):format(v_name, arg2)] = v_u_name
		end
		v_u26.Text = arg2:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", "")
		local v_reset = arg1:FindFirstChild("Reset")
		if v_reset then
			v_reset.Visible = true
		end
		if v2 then
			v_u26.TextColor3 = Color3.fromRGB(255, 90, 90)
		else
			v_u26.TextColor3 = v_u_fromrgb
			v_u34(v_u_name, v_name)
		end
		v_u1.SettingChanged(v_u_video, v_u_name, v8, false, v2)
		if v2 and v1 then
			v_u36(v_u_name, v1, arg2, v_name)
		end
		v_u26:ReleaseFocus()
		v_u23 = nil
		v_u26 = nil
		if v_u_video == "Keybinds" then
			local v_keybinds = v_u24.Options:FindFirstChild("Keybinds")
			local v10 = v_keybinds and v_keybinds.Container
			if v10 then
				v10.ScrollingEnabled = true
			end
		end
	end
end
local function v_u38(arg1, arg2, arg3)
	-- upvalues: (copy) v_u17
	table.insert(v_u17, {
		["path"] = arg1,
		["oldValue"] = arg2,
		["newValue"] = arg3
	})
	while #v_u17 > 50 do
		table.remove(v_u17, 1)
	end
end
function v_u1.RenderPage(arg1)
	-- upvalues: (copy) v_u6, (ref) v_u24, (copy) v_u30, (copy) v_u13, (copy) v_u14, (copy) v_u18, (copy) v_u20, (copy) v_u4, (copy) v_u32, (copy) v_u3, (copy) v_u15, (copy) v_u19, (copy) v_u28, (copy) v_u7, (ref) v_u22, (ref) v_u_video, (copy) v_u11, (copy) v_u1, (copy) v_u10, (copy) v_u12, (copy) v_u8, (copy) v_u_settings, (ref) v_u25, (copy) v_u21, (ref) v_u16, (copy) v_u9, (ref) v_u26, (ref) v_u23, (ref) v_u27, (copy) v_u_fromrgb, (copy) v_u33
	if not v_u6.GetPage(arg1) then
		warn((("[Settings] Page \'%*\' not found in configuration"):format(arg1)))
		return
	end
	local v1 = v_u24.Options:FindFirstChild(arg1)
	if not v1 then
		warn((("[Settings] Page frame \'%*\' not found in UI"):format(arg1)))
		return
	end
	local v_u_container = v1.Container
	v_u30(v_u_container)
	local v_header = v_u_container:FindFirstChild("Header")
	if v_header then
		v_header.Text = string.upper(arg1) .. " SETTINGS"
	end
	local v_title = v_u_container:FindFirstChild("Title")
	if v_title then
		v_title.Text = v_u6.Descriptions[arg1] or ""
	end
	local v_getcategories = v_u6.GetCategories(arg1)
	if arg1 == "Keybinds" then
		table.sort(v_getcategories, function(arg1, arg2)
			-- upvalues: (ref) v_u13
			return (table.find(v_u13, arg1) or 999) < (table.find(v_u13, arg2) or 999)
		end)
	elseif arg1 == "Game" then
		table.sort(v_getcategories, function(arg1, arg2)
			-- upvalues: (ref) v_u14
			return (table.find(v_u14, arg1) or 999) < (table.find(v_u14, arg2) or 999)
		end)
	end
	v_u18[arg1] = {}
	if not v_u20[arg1] then
		v_u20[arg1] = v_u4.new()
	end
	local v2 = 0
	for _, v3 in ipairs(v_getcategories) do
		v_u32(v3, v_u_container, v2)
		v2 = v2 + 1
		local v_getcategory = v_u6.GetCategory(arg1, v3)
		local v4 = {}
		for v5, v6 in pairs(v_getcategory) do
			if not v5:match("^_Divider_") then
				table.insert(v4, {
					["name"] = v5,
					["config"] = v6
				})
			end
		end
		table.sort(v4, function(arg1, arg2)
			local v1 = arg1.config.Order or 999
			local v2 = arg2.config.Order or 999
			if v1 == v2 then
				return arg1.name < arg2.name
			else
				return v1 < v2
			end
		end)
		for _, v7 in ipairs(v4) do
			local v_config = v7.config
			local v_u_name = v7.name
			local v8 = nil
			local v9 = nil
			if v_config.Platform then
				local v10 = v_u3()
				if table.find(v10, v_config.Platform) ~= nil then
					goto l24
				end
			else
				::l24::
				v_u19[v_u_name] = {
					["pageName"] = arg1,
					["categoryName"] = v3,
					["settingName"] = v_u_name,
					["settingPath"] = ("Settings.%*.%*.%*"):format(v_u15[arg1] or arg1, v3, v_u_name)
				}
				if v_config.Type ~= "CrosshairPreview" then
					if v_config.Type == "Toggle" then
						assert(v_u28.ToggleTemplate, "ToggleTemplate not loaded")
						v8 = v_u28.ToggleTemplate:Clone()
						local v11 = v_u_video
						local v12
						if v_u22 then
							local v13 = v_u22[v_u15[v11] or v11]
							if v13 then
								local function v_u14(arg1)
									-- upvalues: (copy) v_u_name, (copy) v_u14
									for v1, v2 in pairs(arg1) do
										if v1 == v_u_name then
											return v2
										end
										if type(v2) == "table" then
											local v3 = v_u14(v2)
											if v3 ~= nil then
												return v3
											end
										end
									end
									return nil
								end
								v12 = v_u14(v13)
							else
								v12 = nil
							end
						else
							v12 = nil
						end
						if v12 == nil then
							v12 = v_config.Default
						end
						v9 = v_u11(v_u_name, v_config, v_u_container, v2, v8, v12, v_u1.SettingChanged, v_u_video)
						v2 = v2 + 1
					elseif v_config.Type == "Number" then
						assert(v_u28.NumberTemplate, "NumberTemplate not loaded")
						v8 = v_u28.NumberTemplate:Clone()
						local v15 = v_u_video
						local v16
						if v_u22 then
							local v17 = v_u22[v_u15[v15] or v15]
							if v17 then
								local function v_u18(arg1)
									-- upvalues: (copy) v_u_name, (copy) v_u18
									for v1, v2 in pairs(arg1) do
										if v1 == v_u_name then
											return v2
										end
										if type(v2) == "table" then
											local v3 = v_u18(v2)
											if v3 ~= nil then
												return v3
											end
										end
									end
									return nil
								end
								v16 = v_u18(v17)
							else
								v16 = nil
							end
						else
							v16 = nil
						end
						v9 = v_u10(v_u_name, v_config, v_u_container, v2, v8, tonumber(v16 or v_config.Default) or v_config.Default, v_u1.SettingChanged, v_u_video)
						v2 = v2 + 1
					elseif v_config.Type == "Slider" then
						assert(v_u28.SliderTemplate, "SliderTemplate not loaded")
						v8 = v_u28.SliderTemplate:Clone()
						local v19 = nil
						local v20
						if v_config.HasEnabledToggle then
							local v21 = v_u_video
							local v22
							if v_u22 then
								local v23 = v_u22[v_u15[v21] or v21]
								if v23 then
									local function v_u24(arg1)
										-- upvalues: (copy) v_u_name, (copy) v_u24
										for v1, v2 in pairs(arg1) do
											if v1 == v_u_name then
												return v2
											end
											if type(v2) == "table" then
												local v3 = v_u24(v2)
												if v3 ~= nil then
													return v3
												end
											end
										end
										return nil
									end
									v22 = v_u24(v23)
								else
									v22 = nil
								end
							else
								v22 = nil
							end
							if type(v22) == "table" then
								v20 = tonumber(v22.Value) or v_config.Default
								v19 = v22.Enabled
								if v19 == nil then
									if v_config.DefaultEnabled == nil then
										v19 = true
									else
										v19 = v_config.DefaultEnabled
									end
								end
							else
								v20 = tonumber(v22) or v_config.Default
								if v_config.DefaultEnabled == nil then
									v19 = true
								else
									v19 = v_config.DefaultEnabled
								end
							end
						else
							local v25 = v_u_video
							local v26
							if v_u22 then
								local v27 = v_u22[v_u15[v25] or v25]
								if v27 then
									local function v_u28(arg1)
										-- upvalues: (copy) v_u_name, (copy) v_u28
										for v1, v2 in pairs(arg1) do
											if v1 == v_u_name then
												return v2
											end
											if type(v2) == "table" then
												local v3 = v_u28(v2)
												if v3 ~= nil then
													return v3
												end
											end
										end
										return nil
									end
									v26 = v_u28(v27)
								else
									v26 = nil
								end
							else
								v26 = nil
							end
							v20 = tonumber(v26 or v_config.Default) or v_config.Default
						end
						v9 = v_u12(v_u_name, v_config, v_u_container, v2, v8, v20, v19, v_u1.SettingChanged, v_u_video)
						v2 = v2 + 1
					elseif v_config.Type == "Dropdown" then
						assert(v_u28.DropdownTemplate, "DropdownTemplate not loaded")
						v8 = v_u28.DropdownTemplate:Clone()
						local v29 = v_u_video
						local v30
						if v_u22 then
							local v31 = v_u22[v_u15[v29] or v29]
							if v31 then
								local function v_u32(arg1)
									-- upvalues: (copy) v_u_name, (copy) v_u32
									for v1, v2 in pairs(arg1) do
										if v1 == v_u_name then
											return v2
										end
										if type(v2) == "table" then
											local v3 = v_u32(v2)
											if v3 ~= nil then
												return v3
											end
										end
									end
									return nil
								end
								v30 = v_u32(v31)
							else
								v30 = nil
							end
						else
							v30 = nil
						end
						v9 = v_u8(v_u_name, v_config, v_u_container, v2, v8, v30 or v_config.Default, v_u1.SettingChanged, v_u_video, v_u_settings, function()
							-- upvalues: (ref) v_u25
							return v_u25
						end, function(arg1)
							-- upvalues: (ref) v_u25
							v_u25 = arg1
						end)
						v2 = v2 + 1
					elseif v_config.Type == "Keybind" then
						assert(v_u28.KeybindTemplate, "KeybindTemplate not loaded")
						v8 = v_u28.KeybindTemplate:Clone()
						local v33 = v_u_video
						local v34
						if v_u22 then
							local v35 = v_u22[v_u15[v33] or v33]
							if v35 then
								local function v_u36(arg1)
									-- upvalues: (copy) v_u_name, (copy) v_u36
									for v1, v2 in pairs(arg1) do
										if v1 == v_u_name then
											return v2
										end
										if type(v2) == "table" then
											local v3 = v_u36(v2)
											if v3 ~= nil then
												return v3
											end
										end
									end
									return nil
								end
								v34 = v_u36(v35)
							else
								v34 = nil
							end
						else
							v34 = nil
						end
						local v37 = v34 or {}
						if type(v37) == "table" then
							for _, v38 in ipairs({ "Computer", "Console" }) do
								local v39 = v37[v38]
								if v39 and v39 ~= "" then
									local v40
									if v39 == "" or v39 == "None" then
										v40 = nil
									else
										v40 = v_u21[("%*:%*"):format(v38, v39)]
										if not v40 or v40 == v_u_name then
											v40 = nil
										end
									end
									if v40 then
										if not v_u16 then
											v_u16 = {}
										end
										local v41 = v_u16
										if not v41[v38] then
											v41[v38] = {}
										end
										table.insert(v41[v38], {
											["action"] = v_u_name,
											["keybind"] = v39
										})
										table.insert(v41[v38], {
											["action"] = v40,
											["keybind"] = v39
										})
									end
									if v39 ~= "" then
										if v39 ~= "None" then
											v_u21[("%*:%*"):format(v38, v39)] = v_u_name
										end
									end
								end
							end
						end
						v9 = v_u9(v_u_name, v_config, v_u_container, v2, v8, v37, v_u1.SettingChanged, v_u_video, function(arg1, arg2, arg3)
							-- upvalues: (ref) v_u26, (ref) v_u23, (ref) v_u27, (ref) v_u_fromrgb, (copy) v_u_container
							v_u26 = arg1
							v_u23 = arg2
							v_u27 = arg3
							arg1.Text = "Press a key..."
							arg1.TextColor3 = v_u_fromrgb
							v_u_container.ScrollingEnabled = false
						end, function(_, _) end)
						v2 = v2 + 1
					end
					goto l32
				end
				if v_u28.CrosshairPreviewTemplate then
					v8 = v_u28.CrosshairPreviewTemplate:Clone()
					v9 = v_u7(v_u_container, v2, v8, v_u24.Share, function()
						-- upvalues: (ref) v_u22
						local v1 = v_u22 and v_u22.Game
						if v1 then
							v1 = v_u22.Game.Crosshair
						end
						return v1
					end, function() end, function() end, function() end)
					v2 = v2 + 1
					::l32::
					if v8 then
						v_u18[arg1][v_u_name] = v8
					end
					if v9 then
						v_u20[arg1]:Add(v9, true, (("Template_%*"):format(v_u_name)))
					end
					local v_clone = v_u_settings:WaitForChild("Divider"):Clone()
					v_clone.LayoutOrder = v2
					v_clone.Parent = v_u_container
					v2 = v2 + 1
				else
					warn("[Settings] CrosshairPreviewTemplate not loaded")
				end
			end
		end
	end
	local v_uilistlayout = v_u_container:FindFirstChildOfClass("UIListLayout")
	if v_uilistlayout then
		v_u_container.CanvasSize = UDim2.new(0, 0, 0, v_uilistlayout.AbsoluteContentSize.Y + 50)
	end
	if arg1 == "Keybinds" and v_u16 then
		task.defer(function()
			-- upvalues: (ref) v_u16, (ref) v_u33
			local v1 = {}
			for v2, v3 in pairs(v_u16) do
				for _, v4 in ipairs(v3) do
					local v_format = ("%*:%*"):format(v4.action, v2)
					if not v1[v_format] then
						v_u33(v4.action, v2)
						v1[v_format] = true
					end
				end
			end
			v_u16 = nil
		end)
	end
end
function v_u1.Open(arg1)
	-- upvalues: (ref) v_u_video, (ref) v_u24, (copy) v_u18, (copy) v_u1, (copy) v_u_fromrgb, (copy) v_u_fromrgb, (copy) v_u_fromrgb
	v_u_video = arg1
	for _, v1 in ipairs(v_u24.Options:GetChildren()) do
		if v1:IsA("Frame") then
			v1.Visible = false
		end
	end
	local v2 = v_u24.Options:FindFirstChild(arg1)
	if v2 then
		v2.Visible = true
		if not v_u18[arg1] then
			v_u1.RenderPage(arg1)
		end
	end
	for _, v3 in ipairs(v_u24.Top.List:GetChildren()) do
		if v3:IsA("TextButton") then
			local v4 = v3.Name == arg1
			v3:SetAttribute("Selected", v4 and true or nil)
			local v_title = v3.Title
			local v_frame = v3.Frame
			if v4 then
				v_frame.BackgroundColor3 = v_u_fromrgb
				v_title.TextColor3 = v_u_fromrgb
				v_frame.BackgroundTransparency = 0
			else
				v_frame.BackgroundColor3 = v_u_fromrgb
				v_title.TextColor3 = v_u_fromrgb
				v_frame.BackgroundTransparency = 1
			end
		end
	end
end
function v_u1.SettingChanged(arg1, arg2, arg3, arg4, arg5)
	-- upvalues: (ref) v_u22, (copy) v_u19, (copy) v_u6, (copy) v_u15, (copy) v_u29, (copy) v_u21, (copy) v_u34, (copy) v_u38, (copy) v_u5
	if v_u22 then
		local v1 = v_u19[arg2]
		if not v1 then
			local v_getsetting = v_u6.GetSetting(arg1, arg2)
			if not (v_getsetting and v_getsetting.Category) then
				warn((("[Settings] Could not find metadata or config for setting: %*"):format(arg2)))
				return
			end
			v1 = {
				["pageName"] = arg1,
				["categoryName"] = v_getsetting.Category,
				["settingName"] = arg2,
				["settingPath"] = ("Settings.%*.%*.%*"):format(v_u15[arg1] or arg1, v_getsetting.Category, arg2)
			}
		end
		local v_settingpath = v1.settingPath
		if arg4 then
			return
		else
			local v2
			if v_u22 then
				local v3 = v_u22[v_u15[arg1] or arg1]
				if v3 then
					local function v_u4(arg1)
						-- upvalues: (copy) arg2, (copy) v_u4
						for v1, v2 in pairs(arg1) do
							if v1 == arg2 then
								return v2
							end
							if type(v2) == "table" then
								local v3 = v_u4(v2)
								if v3 ~= nil then
									return v3
								end
							end
						end
						return nil
					end
					v2 = v_u4(v3)
				else
					v2 = nil
				end
			else
				v2 = nil
			end
			if not v_u29(v2, arg3) or arg5 then
				local v5 = v_u22
				local v6 = v_u15[arg1] or arg1
				if not v5[v6] then
					v5[v6] = {}
				end
				local v7 = v5[v6]
				if not v7[v1.categoryName] then
					v7[v1.categoryName] = {}
				end
				v7[v1.categoryName][arg2] = arg3
				if arg1 == "Keybinds" and type(arg3) == "table" then
					for _, v_u8 in ipairs({ "Computer", "Console" }) do
						local v9 = arg3[v_u8]
						if v9 and v9 ~= "" then
							local v10
							if v9 == "" or v9 == "None" then
								v10 = nil
							else
								v10 = v_u21[("%*:%*"):format(v_u8, v9)]
								if not v10 or v10 == arg2 then
									v10 = nil
								end
							end
							if not v10 then
								task.defer(function()
									-- upvalues: (ref) v_u34, (copy) arg2, (copy) v_u8
									v_u34(arg2, v_u8)
								end)
							end
						else
							task.defer(function()
								-- upvalues: (ref) v_u34, (copy) arg2, (copy) v_u8
								v_u34(arg2, v_u8)
							end)
						end
					end
				end
				v_u38(v_settingpath, v2, arg3)
				v_u5.Player.UpdatePlayerSettings.Send({
					["Path"] = v_settingpath,
					["Value"] = arg3
				})
			end
		end
	else
		warn("[Settings] CurrentSettings is nil")
		return
	end
end
function v_u1.UpdateSettings(arg1)
	-- upvalues: (ref) v_u22, (ref) v_u_video, (copy) v_u18, (copy) v_u1
	v_u22 = arg1
	if v_u_video and v_u18[v_u_video] then
		v_u1.RenderPage(v_u_video)
	end
end
function v_u1.ResetCrosshair()
	-- upvalues: (copy) v_u1
	local v1 = {
		["Crosshair Style"] = "Classic",
		["Crosshair Image"] = 0,
		["Follow Recoil"] = true,
		["Center Dot"] = true,
		["T Style"] = false,
		["Red"] = 0,
		["Green"] = 255,
		["Blue"] = 0,
		["Length"] = 5,
		["Thickness"] = 1,
		["Gap"] = 0,
		["Outline"] = {
			["Enabled"] = true,
			["Value"] = 1
		},
		["Alpha"] = {
			["Enabled"] = false,
			["Value"] = 200
		},
		["Friendly Fire Reticle Warning"] = true,
		["Use Crosshair Color for Scope Dot"] = true,
		["Show my crosshair when spectating bots"] = false,
		["Show Player Crosshairs"] = false
	}
	for v2, v3 in pairs(v1) do
		v_u1.SettingChanged("Game", v2, v3)
	end
	v_u1.RenderPage("Game")
end
function v_u1.ShareCrosshair()
	-- upvalues: (ref) v_u22, (ref) v_u24
	if v_u22 and (v_u22.Game and v_u22.Game.Crosshair) then
		local v_u_http = game:GetService("HttpService")
		local v_u_crosshair = v_u22.Game.Crosshair
		local v1, v2 = pcall(function()
			-- upvalues: (copy) v_u_http, (copy) v_u_crosshair
			return v_u_http:JSONEncode(v_u_crosshair)
		end)
		if v1 and v2 then
			v_u24.Share.Visible = true
			v_u24.Share.TextBox.Text = v2
			v_u24.Share.TextBox:CaptureFocus()
			v_u24.Share.TextBox.CursorPosition = #v2 + 1
		else
			warn("[Settings] Failed to encode crosshair settings:", v2)
		end
	else
		warn("[Settings] No crosshair settings to share")
		return
	end
end
function v_u1.ImportCrosshair(self)
	-- upvalues: (copy) v_u1, (ref) v_u24
	local v_u_http = game:GetService("HttpService")
	local v1, v2 = pcall(function()
		-- upvalues: (copy) v_u_http, (copy) self
		return v_u_http:JSONDecode(self)
	end)
	if v1 and (v2 and type(v2) == "table") then
		for v3, v4 in pairs(v2) do
			v_u1.SettingChanged("Game", v3, v4)
		end
		v_u1.RenderPage("Game")
		v_u24.Share.Visible = false
	else
		warn("[Settings] Failed to import crosshair settings - invalid code")
	end
end
function v_u1.ResetPage(arg1)
	-- upvalues: (copy) v_u6, (copy) v_u1
	local v_getpage = v_u6.GetPage(arg1)
	if v_getpage then
		for v1, v2 in pairs(v_getpage) do
			if not v1:match("^_Divider_") and v2.Default ~= nil then
				v_u1.SettingChanged(arg1, v1, v2.HasEnabledToggle and {
					["Enabled"] = v2.DefaultEnabled or false,
					["Value"] = v2.Default
				} or v2.Default)
			end
		end
		v_u1.RenderPage(arg1)
	else
		warn((("[Settings] Page \'%*\' not found"):format(arg1)))
	end
end
function v_u1.UndoLastChange()
	-- upvalues: (copy) v_u17, (copy) v_u5, (ref) v_u22, (ref) v_u_video, (copy) v_u1
	if #v_u17 == 0 then
		warn("[Settings] No changes to undo")
		return
	else
		local v_remove = table.remove(v_u17)
		if v_remove then
			v_u5.Player.UpdatePlayerSettings.Send({
				["Path"] = v_remove.path,
				["Value"] = v_remove.oldValue
			})
			local v_split = string.split(v_remove.path, ".")
			if #v_split >= 3 then
				local v1 = v_u22
				for v2 = 2, #v_split - 1 do
					local v3 = v_split[v2]
					if not v1[v3] then
						return
					end
					v1 = v1[v3]
				end
				v1[v_split[#v_split]] = v_remove.oldValue
			end
			if v_u_video then
				v_u1.RenderPage(v_u_video)
			end
		end
	end
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u24, (copy) v_u28, (copy) v_u_settings, (copy) v_u31, (copy) v_u1, (ref) v_u_video, (copy) v_u_userinput, (ref) v_u26, (ref) v_u27, (ref) v_u23, (copy) v_u_fromrgb, (copy) v_u37, (ref) v_u25
	v_u28.CrosshairPreviewTemplate = v_u_settings:WaitForChild("CrosshairPreviewTemplate")
	v_u28.ToggleTemplate = v_u_settings:WaitForChild("ToggleTemplate")
	v_u28.DropdownTemplate = v_u_settings:WaitForChild("DropdownTemplate")
	v_u28.NumberTemplate = v_u_settings:WaitForChild("NumberTemplate")
	v_u28.SliderTemplate = v_u_settings:WaitForChild("SliderTemplate")
	v_u28.KeybindTemplate = v_u_settings:WaitForChild("KeybindTemplate")
	for _, v_u1 in ipairs(arg2.Top.List:GetChildren()) do
		if v_u1:IsA("TextButton") then
			v_u31(v_u1, true)
			v_u1.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u1, (copy) v_u1
				v_u1.Open(v_u1.Name)
			end)
		end
	end
	if v_u24.Reset and v_u24.Reset.Button then
		v_u24.Reset.Button.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u1, (ref) v_u_video
			v_u1.ResetPage(v_u_video)
		end)
	end
	if v_u24.Share then
		v_u24.Share.Visible = false
		v_u24.Share.List.Cancel.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u24
			v_u24.Share.Visible = false
		end)
		v_u24.Share.List.Copy.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u24
			v_u24.Share.TextBox:CaptureFocus()
			v_u24.Share.TextBox.CursorPosition = #v_u24.Share.TextBox.Text + 1
		end)
		v_u24.Share.List.Import.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u1, (ref) v_u24
			v_u1.ImportCrosshair(v_u24.Share.TextBox.Text)
		end)
	end
	v_u_userinput.InputBegan:Connect(function(arg1, _)
		-- upvalues: (ref) v_u26, (ref) v_u27, (ref) v_u23, (ref) v_u_video, (ref) v_u24, (ref) v_u_fromrgb, (ref) v_u37
		if v_u26 then
			if arg1.UserInputState == Enum.UserInputState.Begin then
				if tick() - v_u27 < 0.1 then
					return
				elseif v_u26.Parent then
					local v_parent = v_u26.Parent
					local v_name = v_parent.Name
					local v1 = ""
					if v_name == "Computer" then
						if arg1.UserInputType == Enum.UserInputType.Keyboard then
							if arg1.KeyCode == Enum.KeyCode.Escape then
								if v_u26 then
									v_u26.Text = v_u23 or "None"
									v_u26.TextColor3 = v_u_fromrgb
									v_u26:ReleaseFocus()
									v_u23 = nil
									v_u26 = nil
									if v_u_video == "Keybinds" then
										local v_keybinds = v_u24.Options:FindFirstChild("Keybinds")
										local v2 = v_keybinds and v_keybinds.Container
										if v2 then
											v2.ScrollingEnabled = true
										end
									end
								end
							end
							v1 = ("Enum.KeyCode.%*"):format(arg1.KeyCode.Name)
						else
							v1 = arg1.UserInputType == Enum.UserInputType.MouseButton1 and "Enum.UserInputType.MouseButton1" or (arg1.UserInputType == Enum.UserInputType.MouseButton2 and "Enum.UserInputType.MouseButton2" or (arg1.UserInputType == Enum.UserInputType.MouseButton3 and "Enum.UserInputType.MouseButton3" or v1))
						end
					elseif v_name == "Console" then
						if arg1.UserInputType == Enum.UserInputType.Keyboard and arg1.KeyCode == Enum.KeyCode.Escape then
							if v_u26 then
								v_u26.Text = v_u23 or "None"
								v_u26.TextColor3 = v_u_fromrgb
								v_u26:ReleaseFocus()
								v_u23 = nil
								v_u26 = nil
								if v_u_video == "Keybinds" then
									local v_keybinds = v_u24.Options:FindFirstChild("Keybinds")
									local v3 = v_keybinds and v_keybinds.Container
									if v3 then
										v3.ScrollingEnabled = true
									end
								end
							end
						end
						if arg1.UserInputType == Enum.UserInputType.Gamepad1 then
							v1 = ("Enum.KeyCode.%*"):format(arg1.KeyCode.Name)
						end
					end
					if v1 ~= "" then
						v_u37(v_parent, v1)
					end
				else
					v_u26 = nil
					v_u23 = nil
					if v_u_video == "Keybinds" then
						local v_keybinds = v_u24.Options:FindFirstChild("Keybinds")
						local v4 = v_keybinds and v_keybinds.Container
						if v4 then
							v4.ScrollingEnabled = true
						end
					end
				end
			else
				return
			end
		else
			return
		end
	end)
	v_u_userinput.InputChanged:Connect(function(arg1, _)
		-- upvalues: (ref) v_u26, (ref) v_u27, (ref) v_u23, (ref) v_u_video, (ref) v_u24, (ref) v_u37
		if v_u26 then
			if arg1.UserInputType == Enum.UserInputType.MouseWheel then
				if tick() - v_u27 < 0.1 then
					return
				elseif v_u26.Parent then
					local v_parent = v_u26.Parent
					if v_parent.Name == "Computer" then
						local v_z = arg1.Position.Z
						if v_z > 0 then
							v_u37(v_parent, "Enum.CustomInputType.ScrollWheelUp")
						elseif v_z < 0 then
							v_u37(v_parent, "Enum.CustomInputType.ScrollWheelDown")
						end
					else
						return
					end
				else
					v_u23 = nil
					v_u26 = nil
					if v_u_video == "Keybinds" then
						local v_keybinds = v_u24.Options:FindFirstChild("Keybinds")
						local v1 = v_keybinds and v_keybinds.Container
						if v1 then
							v1.ScrollingEnabled = true
						end
					end
					return
				end
			else
				return
			end
		else
			return
		end
	end)
	v_u_userinput.InputBegan:Connect(function(arg1, _)
		-- upvalues: (ref) v_u25
		if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
			local v1 = v_u25
			if v1 and v1.Visible then
				local v_position = arg1.Position
				if v1.Parent and v1.Parent.Parent then
					local v_options = v1.Parent.Parent:FindFirstChild("Options")
					if v_options then
						local v_button = v_options.Button
						if v_button then
							local v_absoluteposition = v_button.AbsolutePosition
							local v_absolutesize = v_button.AbsoluteSize
							local v_absoluteposition = v1.AbsolutePosition
							local v_absolutesize = v1.AbsoluteSize
							local v2
							if v_position.X >= v_absoluteposition.X and (v_position.X <= v_absoluteposition.X + v_absolutesize.X and v_position.Y >= v_absoluteposition.Y) then
								v2 = v_position.Y <= v_absoluteposition.Y + v_absolutesize.Y
							else
								v2 = false
							end
							local v3
							if v_position.X >= v_absoluteposition.X and (v_position.X <= v_absoluteposition.X + v_absolutesize.X and v_position.Y >= v_absoluteposition.Y) then
								v3 = v_position.Y <= v_absoluteposition.Y + v_absolutesize.Y
							else
								v3 = false
							end
							if not (v2 or v3) then
								v1.Visible = false
								v_u25 = nil
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
		else
			return
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u1, (copy) v_u2, (copy) v_u_localplayer
	v_u1.Open("Video")
	v_u2.CreateListener(v_u_localplayer, "Settings", function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.UpdateSettings(arg1)
	end)
end
return v_u1