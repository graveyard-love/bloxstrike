-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_replicatedstorage.Components.Common.InterfaceAnimations.ActivateButton)
local v_u4 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u5 = require(v_replicatedstorage.Database.Security.Router)
local v_u6 = { "News", "RedeemCode", "Verify" }
local v_u7 = nil
function v1.Initialize(_, arg2)
	-- upvalues: (ref) v_u7, (copy) v_u3, (copy) v_u4, (copy) v_u5, (copy) v_u6
	v_u7 = arg2
	v_u3(v_u7.Container.Reward.Frame.Button)
	v_u7.Container.Reward.Frame.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u4
		v_u4.Dashboard.RedeemLikeAndFavoriteReward.Send()
	end)
	v_u3(v_u7.Container.RedeemCode.Frame.Button)
	v_u7.Container.RedeemCode.Frame.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u7, (ref) v_u4, (ref) v_u5
		local v_text = v_u7.Container.RedeemCode.Frame.Container.Holder.TextBox.Text
		if tostring(v_text) == "" then
			v_u5.broadcastRouter("CreateMenuNotification", "Error", "Invalid code. Please try again.")
		else
			v_u7.Container.RedeemCode.Frame.Container.Holder.TextBox.Text = ""
			v_u4.Dashboard.RedeemCode.Send(v_text)
		end
	end)
	for _, v1 in ipairs(v_u7.Container:GetChildren()) do
		if v1:IsA("Frame") then
			v1.Visible = table.find(v_u6, v1.Name)
		end
	end
end
function v1.Start()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (ref) v_u7
	v_u2.CreateListener(v_u_localplayer, "LikeAndFavoriteReward", function(arg1)
		-- upvalues: (ref) v_u7
		v_u7.Container.Reward.Visible = not arg1
	end)
end
return v1