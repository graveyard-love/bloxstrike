-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u2 = require(v_replicatedstorage.Database.Security.Router)
local v_u3 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u4 = nil
function v_u1.CreateNotification(arg1, arg2)
	-- upvalues: (copy) v_u2, (ref) v_u4
	v_u2.broadcastRouter("RunInterfaceSound", "Notification " .. arg1)
	v_u4.TextLabel.Text = arg2
	v_u4.Visible = true
end
function v_u1.CloseNotification()
	-- upvalues: (ref) v_u4
	v_u4.Visible = false
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u4, (copy) v_u1, (copy) v_u2, (copy) v_u3
	arg2.Footer.Close.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1
		v_u1.CloseNotification()
	end)
	v_u2.observerRouter("CreateMenuNotification", function(arg1, arg2)
		-- upvalues: (ref) v_u1
		v_u1.CreateNotification(arg1, arg2)
		return nil
	end)
	v_u3.UI.CreateMenuNotification.Listen(function(arg1, _)
		-- upvalues: (ref) v_u1
		v_u1.CreateNotification(arg1.notificationType, arg1.text)
	end)
end
return v_u1