-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u1 = require(v_replicatedstorage.Shared.Janitor)
require(v_replicatedstorage.Database.Custom.GameStats.UI.Settings.Pages)
return function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
	-- upvalues: (copy) v_u1
	arg5.LayoutOrder = arg4
	arg5.Title.Text = arg1
	arg5.Name = arg1
	local v_u1 = arg6.Computer == nil and "" or arg6.Computer
	local v_u2 = arg6.Console == nil and "" or arg6.Console
	local v_u_new = v_u1.new()
	v_u_new:Add(arg5, "Destroy")
	if arg6.Computer == nil and arg2.Default then
		local v_default = arg2.Default
		v_u1 = typeof(v_default) == "table" and (v_default.Computer or "") or ""
	end
	if arg6.Console == nil and arg2.Default then
		local v_default = arg2.Default
		v_u2 = typeof(v_default) == "table" and (v_default.Console or "") or ""
	end
	local function v_u3(arg1, arg2)
		local v_textbox = arg1:FindFirstChild("TextBox")
		local v_reset = arg1:FindFirstChild("Reset")
		if v_textbox then
			if arg2 == "" then
				v_textbox.Text = ""
				v_textbox.PlaceholderText = "None"
				v_textbox.TextEditable = false
				v_textbox.Active = true
				if v_reset then
					v_reset.Visible = false
					return
				end
			else
				v_textbox.Text = (arg2 == "" or arg2 == nil) and "" or arg2:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", "")
				v_textbox.PlaceholderText = ""
				v_textbox.TextEditable = false
				v_textbox.Active = true
				if v_reset then
					v_reset.Visible = true
				end
			end
		end
	end
	if arg5:FindFirstChild("Computer") then
		v_u3(arg5.Computer, v_u1)
		v_u_new:Add(arg5.Computer.TextBox.Focused:Connect(function()
			-- upvalues: (copy) arg9, (copy) arg5, (ref) v_u1
			local v1 = v_u1
			arg9(arg5.Computer.TextBox, (v1 == "" or v1 == nil) and "" or v1:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""), tick())
		end), "Disconnect")
		v_u_new:Add(arg5.Computer.Reset.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u3, (copy) arg5, (ref) v_u1, (copy) arg7, (copy) arg8, (copy) arg1, (ref) v_u2
			v_u3(arg5.Computer, v_u1)
			arg7(arg8, arg1, {
				["Computer"] = "",
				["Console"] = v_u2
			})
		end), "Disconnect")
		arg10("Computer", v_u1)
	end
	if arg5:FindFirstChild("Console") then
		v_u3(arg5.Console, v_u2)
		v_u_new:Add(arg5.Console.TextBox.Focused:Connect(function()
			-- upvalues: (copy) arg9, (copy) arg5, (ref) v_u2
			local v1 = v_u2
			arg9(arg5.Console.TextBox, (v1 == "" or v1 == nil) and "" or v1:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""), tick())
		end), "Disconnect")
		v_u_new:Add(arg5.Console.Reset.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u3, (copy) arg5, (ref) v_u2, (copy) arg7, (copy) arg8, (copy) arg1, (ref) v_u1
			v_u3(arg5.Console, v_u2)
			arg7(arg8, arg1, {
				["Computer"] = v_u1,
				["Console"] = ""
			})
		end), "Disconnect")
		arg10("Console", v_u2)
	end
	arg5.Parent = arg3
	return function()
		-- upvalues: (copy) v_u_new
		v_u_new:Cleanup()
	end
end