-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_gui = game:GetService("GuiService")
require(script.Parent.Parent.Types)
local v_u1 = require(v_replicatedstorage.Shared.Janitor)
require(v_replicatedstorage.Database.Custom.GameStats.UI.Settings.Pages)
return function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	-- upvalues: (copy) v_u1, (copy) v_u_gui, (copy) v_u_userinput
	arg5.Name = arg1
	arg5.Title.Text = arg1
	arg5.LayoutOrder = arg4
	local v_u1 = arg2.HasEnabledToggle or false
	local v_u2 = arg2.Step or 1
	local v_u3 = arg2.Max or 100
	local v_u4 = arg2.Min or 0
	local v_u5 = arg6
	local v_u6 = false
	local v_u7 = arg7 == nil and true or (arg7 or true)
	local v_u_new = v_u1.new()
	v_u_new:Add(arg5, "Destroy")
	local v_u_slider = arg5.Slider
	local v_u_button = arg5.Slider.Button
	v_u_slider.AutoButtonColor = false
	v_u_slider.Active = false
	v_u_button.AutoButtonColor = false
	v_u_button.Active = false
	if arg5.Check and not v_u1 then
		arg5.Check.Visible = false
	end
	local function v_u8(arg1, arg2)
		-- upvalues: (copy) v_u4, (copy) v_u3, (copy) v_u2, (ref) v_u5, (copy) arg5, (copy) arg8, (copy) arg9, (copy) arg1
		local v1 = math.round(math.clamp(arg1, v_u4, v_u3) / v_u2) * v_u2
		v_u5 = v1
		local v2 = (v1 - v_u4) / (v_u3 - v_u4)
		arg5.Slider.Bar.Size = UDim2.new(v2, 0, 1, 0)
		arg5.Slider.Button.Position = UDim2.new(v2, 0, 0.5, 0)
		local v_textbox = arg5.Frame.TextBox
		local v3 = math.round(v1 * 100) / 100
		local v4
		if v3 == math.floor(v3) then
			local v_floor = math.floor(v3)
			v4 = tostring(v_floor)
		else
			v4 = string.format("%.2f", v3):gsub("%.?0+$", "")
		end
		v_textbox.Text = v4
		if arg2 then
			arg8(arg9, arg1, v_u5, true)
		end
	end
	v_u8(v_u5)
	v_u_new:Add(v_u_slider.InputBegan:Connect(function(arg1)
		-- upvalues: (ref) v_u7, (ref) v_u6, (ref) v_u_gui, (copy) v_u_slider, (copy) v_u4, (copy) v_u3, (copy) v_u8
		if (arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch) and v_u7 then
			v_u6 = true
			local v_getguiinset = v_u_gui:GetGuiInset()
			v_u8(v_u4 + math.clamp((arg1.Position.X - v_getguiinset.X - v_u_slider.AbsolutePosition.X) / v_u_slider.AbsoluteSize.X, 0, 1) * (v_u3 - v_u4), nil)
		end
	end), "Disconnect")
	v_u_new:Add(v_u_slider.InputEnded:Connect(function(arg1)
		-- upvalues: (ref) v_u6, (copy) v_u1, (copy) arg8, (copy) arg9, (copy) arg1, (ref) v_u7, (ref) v_u5
		if (arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch) and v_u6 then
			v_u6 = false
			if v_u1 then
				arg8(arg9, arg1, {
					["Enabled"] = v_u7,
					["Value"] = v_u5
				}, false)
			else
				arg8(arg9, arg1, v_u5, false)
			end
		else
			return
		end
	end), "Disconnect")
	v_u_new:Add(v_u_button.InputBegan:Connect(function(arg1)
		-- upvalues: (ref) v_u7, (ref) v_u6, (ref) v_u_gui, (copy) v_u_slider, (copy) v_u4, (copy) v_u3, (copy) v_u8
		if (arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch) and v_u7 then
			v_u6 = true
			local v_getguiinset = v_u_gui:GetGuiInset()
			v_u8(v_u4 + math.clamp((arg1.Position.X - v_getguiinset.X - v_u_slider.AbsolutePosition.X) / v_u_slider.AbsoluteSize.X, 0, 1) * (v_u3 - v_u4), nil)
		end
	end), "Disconnect")
	v_u_new:Add(v_u_button.InputEnded:Connect(function(arg1)
		-- upvalues: (ref) v_u6, (copy) v_u1, (copy) arg8, (copy) arg9, (copy) arg1, (ref) v_u7, (ref) v_u5
		if (arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch) and v_u6 then
			v_u6 = false
			if v_u1 then
				arg8(arg9, arg1, {
					["Enabled"] = v_u7,
					["Value"] = v_u5
				}, false)
			else
				arg8(arg9, arg1, v_u5, false)
			end
		else
			return
		end
	end), "Disconnect")
	v_u_new:Add(v_u_slider.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u6, (copy) v_u_new, (ref) v_u_userinput, (copy) v_u1, (copy) arg8, (copy) arg9, (copy) arg1, (ref) v_u7, (ref) v_u5
		if v_u6 then
			v_u_new:Remove("MouseLeaveRelease")
			v_u_new:Add(v_u_userinput.InputEnded:Connect(function(arg1)
				-- upvalues: (ref) v_u6, (ref) v_u1, (ref) arg8, (ref) arg9, (ref) arg1, (ref) v_u7, (ref) v_u5, (ref) v_u_new
				if arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch then
					v_u6 = false
					if v_u1 then
						arg8(arg9, arg1, {
							["Enabled"] = v_u7,
							["Value"] = v_u5
						}, false)
					else
						arg8(arg9, arg1, v_u5, false)
					end
					v_u_new:Remove("MouseLeaveRelease")
				end
			end), "Disconnect", "MouseLeaveRelease")
		end
	end), "Disconnect")
	v_u_new:Add(v_u_userinput.InputChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u6, (copy) v_u_slider, (copy) v_u4, (copy) v_u3, (copy) v_u8
		if v_u6 and (arg1.UserInputType == Enum.UserInputType.MouseMovement or arg1.UserInputType == Enum.UserInputType.Touch) then
			v_u8(v_u4 + math.clamp((arg1.Position.X - v_u_slider.AbsolutePosition.X) / v_u_slider.AbsoluteSize.X, 0, 1) * (v_u3 - v_u4), true)
		end
	end), "Disconnect")
	v_u_new:Add(arg5.Frame.TextBox.FocusLost:Connect(function()
		-- upvalues: (ref) v_u7, (copy) arg5, (copy) v_u8, (copy) v_u1, (copy) arg8, (copy) arg9, (copy) arg1, (ref) v_u5
		if v_u7 then
			local v1 = tonumber(arg5.Frame.TextBox.Text)
			if v1 then
				v_u8(v1)
				if v_u1 then
					arg8(arg9, arg1, {
						["Enabled"] = v_u7,
						["Value"] = v_u5
					}, false)
				else
					arg8(arg9, arg1, v_u5, false)
				end
			else
				local v_textbox = arg5.Frame.TextBox
				local v2 = math.round(v_u5 * 100) / 100
				local v3
				if v2 == math.floor(v2) then
					local v_floor = math.floor(v2)
					v3 = tostring(v_floor)
				else
					v3 = string.format("%.2f", v2):gsub("%.?0+$", "")
				end
				v_textbox.Text = v3
				return
			end
		else
			return
		end
	end), "Disconnect")
	if arg5.Check and v_u1 then
		arg5.Check.ImageLabel.Visible = v_u7
		arg5.Frame.TextBox.TextEditable = v_u7
		v_u_button.Active = v_u7
		v_u_slider.Active = v_u7
		arg5.Slider.Bar.BackgroundTransparency = v_u7 and 0 or 0.5
		arg5.Slider.Button.ImageTransparency = v_u7 and 0 or 0.5
		arg5.Frame.TextBox.TextTransparency = v_u7 and 0 or 0.5
		arg5.Slider.ImageTransparency = v_u7 and 0 or 0.5
		v_u_new:Add(arg5.Check.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u7, (copy) arg5, (copy) v_u_slider, (copy) v_u_button, (copy) arg8, (copy) arg9, (copy) arg1, (ref) v_u5
			v_u7 = not v_u7
			arg5.Check.ImageLabel.Visible = v_u7
			v_u_slider.Active = v_u7
			v_u_button.Active = v_u7
			arg5.Frame.TextBox.TextEditable = v_u7
			arg5.Slider.ImageTransparency = v_u7 and 0 or 0.5
			arg5.Slider.Bar.BackgroundTransparency = v_u7 and 0 or 0.5
			arg5.Slider.Button.ImageTransparency = v_u7 and 0 or 0.5
			arg5.Frame.TextBox.TextTransparency = v_u7 and 0 or 0.5
			arg8(arg9, arg1, {
				["Enabled"] = v_u7,
				["Value"] = v_u5
			}, false)
		end), "Disconnect")
	end
	arg5.Parent = arg3
	return function()
		-- upvalues: (ref) v_u6, (copy) v_u_new
		v_u6 = false
		v_u_new:Cleanup()
	end
end