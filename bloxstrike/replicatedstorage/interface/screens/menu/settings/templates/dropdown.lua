-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u1 = require(v_replicatedstorage.Shared.Janitor)
require(v_replicatedstorage.Database.Custom.GameStats.UI.Settings.Pages)
local v_u_fromrgb = Color3.fromRGB(255, 255, 255)
Color3.fromRGB(255, 201, 14)
return function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
	-- upvalues: (copy) v_u1, (copy) v_u_fromrgb
	local v_u_new = v_u1.new()
	local v_u1 = arg6
	arg5:SetAttribute("IsDropdown", true)
	arg5.LayoutOrder = arg4
	arg5.Title.Text = arg1
	arg5.Name = arg1
	local v_u_frame = arg5.Options.Frame
	arg5.Options.Button.Title.Text = v_u1
	v_u_frame.Visible = false
	local function v_u2()
		-- upvalues: (copy) v_u_new, (copy) v_u_frame
		v_u_new:Cleanup()
		for _, v1 in ipairs(v_u_frame:GetChildren()) do
			if v1:IsA("TextButton") then
				v1:Destroy()
			end
		end
	end
	local v_u_new = v_u1.new()
	v_u_new:Add(arg5, "Destroy")
	v_u_new:Add(v_u2)
	v_u_new:Add(arg5.Options.Button.MouseButton1Click:Connect(function()
		-- upvalues: (copy) arg10, (copy) v_u_frame, (copy) arg5, (copy) v_u2, (copy) arg2, (copy) arg9, (ref) v_u_fromrgb, (copy) v_u_new, (ref) v_u1, (copy) arg11, (copy) arg7, (copy) arg8, (copy) arg1
		local v1 = arg10()
		local v2 = not v_u_frame.Visible
		if v1 and v1 ~= v_u_frame then
			v1.Visible = false
			for _, v3 in ipairs(v1:GetChildren()) do
				if v3:IsA("TextButton") then
					v3:Destroy()
				end
			end
		end
		for _, v4 in ipairs(arg5.Parent:GetChildren()) do
			if v4:GetAttribute("IsDropdown") then
				if v2 and v4.Name == arg5.Name then
					v4.ZIndex = 11
				else
					v4.ZIndex = 10
				end
			end
		end
		v_u2()
		if v2 and arg2.Enums then
			for v5, v_u6 in ipairs(arg2.Enums) do
				local v_u_clone = arg9:WaitForChild("OptionTemplate"):Clone()
				v_u_clone.Size = UDim2.fromScale(1, 1 / #arg2.Enums)
				v_u_clone.Name = ("Option_%*"):format(v_u6)
				v_u_clone.Title.Text = v_u6
				v_u_clone.LayoutOrder = v5
				v_u_clone.Visible = true
				v_u_clone.Parent = v_u_frame
				local v_u7 = arg5.Options.Button.Title.Text == v_u6
				v_u_clone.Frame.BackgroundTransparency = v_u7 and 0.3 or 1
				v_u_clone.TextColor3 = v_u_fromrgb
				v_u_new:Add(v_u_clone.MouseEnter:Connect(function()
					-- upvalues: (copy) v_u_clone, (copy) v_u7
					v_u_clone.Frame.BackgroundTransparency = v_u7 and 0.3 or 0.65
				end), "Disconnect", (("Option_%*_1"):format(v_u6)))
				v_u_new:Add(v_u_clone.MouseLeave:Connect(function()
					-- upvalues: (copy) v_u_clone, (copy) v_u7
					v_u_clone.Frame.BackgroundTransparency = v_u7 and 0.3 or 1
				end), "Disconnect", (("Option_%*_2"):format(v_u6)))
				v_u_new:Add(v_u_clone.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u1, (copy) v_u6, (ref) arg5, (ref) v_u_frame, (ref) arg11, (ref) arg7, (ref) arg8, (ref) arg1, (ref) v_u2
					arg5.Options.Button.Title.Text = v_u6
					v_u_frame.Visible = false
					arg11(nil)
					arg7(arg8, arg1, v_u6)
					v_u2()
				end), "Disconnect", (("Option_%*_3"):format(v_u6)))
				v_u_new:Add(v_u_clone, "Destroy")
			end
			local v8 = #arg2.Enums
			v_u_frame.Size = UDim2.new(1, 0, 0, v8 * 30 + (v8 - 1) * 5)
			v_u_frame.Visible = true
			arg11(v_u_frame)
		else
			v_u_frame.Visible = false
			arg11(nil)
		end
	end), "Disconnect")
	arg5.Parent = arg3
	return function()
		-- upvalues: (copy) v_u_new, (copy) v_u_new
		v_u_new:Cleanup()
		v_u_new:Cleanup()
	end
end