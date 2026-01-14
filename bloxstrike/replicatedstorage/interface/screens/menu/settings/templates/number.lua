-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u1 = require(v_replicatedstorage.Shared.Janitor)
require(v_replicatedstorage.Database.Custom.GameStats.UI.Settings.Pages)
return function(arg1, _, arg3, arg4, arg5, arg6, arg7, arg8)
	-- upvalues: (copy) v_u1
	arg5.Name = arg1
	arg5.Title.Text = arg1
	arg5.LayoutOrder = arg4
	local v_u_new = v_u1.new()
	v_u_new:Add(arg5, "Destroy")
	local v_u_floor = math.floor(arg6)
	local v_floor = math.floor(v_u_floor)
	arg5.Frame.TextBox.Text = tostring(v_floor)
	v_u_new:Add(arg5.Frame.TextBox.FocusLost:Connect(function()
		-- upvalues: (copy) arg5, (ref) v_u_floor, (copy) arg7, (copy) arg8, (copy) arg1
		local v1 = tonumber(arg5.Frame.TextBox.Text)
		if v1 then
			v_u_floor = math.floor(v1)
			local v_floor = math.floor(v_u_floor)
			arg5.Frame.TextBox.Text = tostring(v_floor)
			arg7(arg8, arg1, v_u_floor)
		else
			local v_floor = math.floor(v_u_floor)
			arg5.Frame.TextBox.Text = tostring(v_floor)
		end
	end), "Disconnect")
	arg5.Parent = arg3
	return function()
		-- upvalues: (copy) v_u_new
		v_u_new:Cleanup()
	end
end