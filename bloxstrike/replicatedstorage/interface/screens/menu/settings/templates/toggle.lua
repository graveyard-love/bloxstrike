-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u1 = require(v_replicatedstorage.Shared.Janitor)
require(v_replicatedstorage.Database.Custom.GameStats.UI.Settings.Pages)
local v_u_fromrgb = Color3.fromRGB(255, 255, 255)
return function(arg1, _, arg3, arg4, arg5, arg6, arg7, arg8)
	-- upvalues: (copy) v_u1, (copy) v_u_fromrgb
	arg5.Name = arg1
	arg5.Title.Text = arg1
	arg5.LayoutOrder = arg4
	arg5.Button.Selectable = false
	local v_u1 = arg6
	local v_u_new = v_u1.new()
	v_u_new:Add(arg5, "Destroy")
	local v2 = v_u1
	arg5.Button.ImageLabel.Visible = v2
	local v_uistroke = arg5.Button.Border.UIStroke
	local v3
	if v2 then
		v3 = Color3.fromRGB(255, 255, 255)
	else
		v3 = Color3.fromRGB(100, 100, 100)
	end
	v_uistroke.Color = v3
	arg5.Title.TextColor3 = v_u_fromrgb
	v_u_new:Add(arg5.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1, (copy) arg5, (ref) v_u_fromrgb, (copy) arg7, (copy) arg8, (copy) arg1
		local v1 = not v_u1
		arg5.Button.ImageLabel.Visible = v1
		local v_uistroke = arg5.Button.Border.UIStroke
		local v2
		if v1 then
			v2 = Color3.fromRGB(255, 255, 255)
		else
			v2 = Color3.fromRGB(100, 100, 100)
		end
		v_uistroke.Color = v2
		arg5.Title.TextColor3 = v_u_fromrgb
		arg7(arg8, arg1, v_u1)
	end), "Disconnect")
	arg5.Parent = arg3
	return function()
		-- upvalues: (copy) v_u_new
		v_u_new:Cleanup()
	end
end