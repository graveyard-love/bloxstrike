-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_players = game:GetService("Players")
local v_u_debris = game:GetService("Debris")
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Database.Components.GameState)
local v_u3 = require(v_u_replicatedstorage.Components.Common.GetPreferenceColor)
local v_u4 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u5 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u6 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u_localplayer = v_players.LocalPlayer
local v_u7 = nil
local function v_u8(arg1)
	-- upvalues: (copy) v_u_tween, (copy) v_u_debris
	v_u_tween:Create(arg1, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		["Size"] = UDim2.fromScale(0, 0.12)
	}):Play()
	v_u_debris:AddItem(arg1, 0.35)
end
function v_u1.createNotification(arg1, arg2, arg3)
	-- upvalues: (ref) v_u7, (copy) v_u_localplayer, (copy) v_u_replicatedstorage, (copy) v_u_tween, (copy) v_u3
	local v1 = v_u7:FindFirstChild(arg1)
	if v_u_localplayer:GetAttribute("Team") then
		if not v1 then
			v1 = v_u_replicatedstorage.Assets.UI.Notification.Template:Clone()
			v1.LayoutOrder = arg3 or 0
			v1.Parent = v_u7
			v1.Name = arg1
			v1.Size = UDim2.fromScale(0, 0.12)
			v_u_tween:Create(v1, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Size"] = UDim2.fromScale(0.9, 0.12)
			}):Play()
		end
		v1:SetAttribute("Timestamp", tick())
		v1.Right.BackgroundColor3 = v_u3()
		v1.Left.BackgroundColor3 = v_u3()
		v1.TextLabel.Text = arg2
		return v1
	end
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u7, (copy) v_u_localplayer, (copy) v_u1, (copy) v_u2, (copy) v_u4, (copy) v_u3
	v_u7 = arg2
	v_u_localplayer.CharacterAdded:Connect(function(_)
		-- upvalues: (ref) v_u1, (ref) v_u7
		if workspace:GetAttribute("GameState") == "Warmup" then
			v_u1.createNotification("GameState", "Warmup", 1)
		else
			local v_gamestate = v_u7:FindFirstChild("GameState")
			if v_gamestate then
				v_gamestate:Destroy()
			end
		end
	end)
	v_u2.ListenToState(function(arg1, _)
		-- upvalues: (ref) v_u7
		local v1 = arg1 == "Warmup" and v_u7:FindFirstChild("GameState")
		if v1 then
			v1:Destroy()
		end
	end)
	v_u4.CreateListener(v_u_localplayer, "Settings.Game.HUD.Color", function()
		-- upvalues: (ref) v_u7, (ref) v_u3
		for _, v1 in ipairs(v_u7:GetChildren()) do
			if v1:IsA("Frame") then
				v1.Right.BackgroundColor3 = v_u3()
				v1.Left.BackgroundColor3 = v_u3()
			end
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u5, (copy) v_u1, (copy) v_u8, (copy) v_u6
	v_u5.UI.ShowNotification.Listen(function(arg1, _)
		-- upvalues: (ref) v_u1, (ref) v_u8
		local v_u_createnotification = v_u1.createNotification(arg1.header, arg1.message, 0)
		task.delay(arg1.timeLength, function()
			-- upvalues: (copy) v_u_createnotification, (copy) arg1, (ref) v_u8
			if v_u_createnotification and v_u_createnotification.Parent then
				local v1 = v_u_createnotification
				if arg1.timeLength <= tick() - v1:GetAttribute("Timestamp") then
					v_u8(v1)
					return
				end
			end
		end)
	end)
	v_u6.observerRouter("CreateNotification", function(arg1, arg2, arg3)
		-- upvalues: (ref) v_u1, (ref) v_u8
		local v_u_createnotification = v_u1.createNotification(arg1, arg2, 0)
		task.delay(arg3, function()
			-- upvalues: (copy) v_u_createnotification, (copy) arg3, (ref) v_u8
			if v_u_createnotification and v_u_createnotification.Parent then
				local v1 = v_u_createnotification
				if arg3 <= tick() - v1:GetAttribute("Timestamp") then
					v_u8(v1)
					return
				end
			end
		end)
	end)
end
return v_u1