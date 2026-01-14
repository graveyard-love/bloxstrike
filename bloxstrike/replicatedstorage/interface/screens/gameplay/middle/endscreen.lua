-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Components.Common.GetTimerFormat)
require(v_u_replicatedstorage.Database.Components.GameState)
local v_u3 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u4 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u5 = require(v_u_replicatedstorage.Packages.Observers)
local v_u6 = nil
local v_u7 = nil
local v_u8 = nil
local function v_u9(arg1, arg2)
	local v_getchildren = arg1:GetChildren()
	for _, v1 in ipairs(v_getchildren) do
		if v1.ClassName == arg2 then
			v1:Destroy()
		end
	end
end
local function v_u10(arg1)
	-- upvalues: (ref) v_u7, (copy) v_u_players
	local v_getchildren = v_u7.MapVote:GetChildren()
	for _, v1 in ipairs(v_getchildren) do
		if v1:IsA("ImageButton") then
			local v2 = arg1 and arg1[v1.Name] or v1:GetAttribute("Amount")
			if v2 then
				v1.Main.Amount.Text = ("<font color=\"rgb(219,199,126)\">%*</font>/%*"):format(v2, #v_u_players:GetPlayers())
				v1:SetAttribute("Amount", v2)
			end
		end
	end
end
local function v_u11(arg1, arg2)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_players, (ref) v_u7, (ref) v_u6, (copy) v_u4, (copy) v_u_tween
	local v1 = v_u_replicatedstorage.Database.Custom.GameStats.Maps:FindFirstChild(arg2)
	local v_format = ("%* is not apart of Database.GameStats.Maps"):format(arg2)
	assert(v1, v_format)
	local v2 = require(v1)
	local v_u_clone = v_u_replicatedstorage.Assets.UI.EndScreen.VoteTemplate:Clone()
	v_u_clone.Main.Amount.Text = ("<font color=\"rgb(219,199,126)\">0</font>/%*"):format(#v_u_players:GetPlayers())
	v_u_clone.Main.Icon.Image = v2.Icon
	v_u_clone.Parent = v_u7.MapVote
	v_u_clone.Main.Selection.Text = arg2
	v_u_clone:SetAttribute("Amount", 0)
	v_u_clone.Title.Visible = arg1 == 1
	v_u_clone.Voted.Visible = false
	v_u_clone.Name = arg2
	v_u_clone.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u6, (copy) arg2, (ref) v_u4, (ref) v_u_tween, (copy) v_u_clone, (ref) v_u7
		if v_u6 ~= arg2 then
			v_u4.Map.SubmitMapVote.Send(arg2)
			v_u_tween:Create(v_u_clone.Main.UIStroke, TweenInfo.new(0.5), {
				["Transparency"] = 0
			}):Play()
			v_u_tween:Create(v_u_clone.Main.UIStroke, TweenInfo.new(0.5), {
				["Thickness"] = 5.5
			}):Play()
			if v_u6 then
				local v1 = v_u7.MapVote:FindFirstChild(v_u6)
				v_u_tween:Create(v1.Main.UIStroke, TweenInfo.new(0.5), {
					["Transparency"] = 0.75
				}):Play()
				v_u_tween:Create(v1.Main.UIStroke, TweenInfo.new(0.5), {
					["Thickness"] = 1.5
				}):Play()
			end
			v_u6 = arg2
		end
	end)
	v_u_clone.Button.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) v_u_clone
		v_u_tween:Create(v_u_clone.Main.Icon.UIScale, TweenInfo.new(0.5), {
			["Scale"] = 1.1
		}):Play()
	end)
	v_u_clone.Button.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) v_u_clone
		v_u_tween:Create(v_u_clone.Main.Icon.UIScale, TweenInfo.new(0.5), {
			["Scale"] = 1
		}):Play()
	end)
end
function v_u1.CloseFrame()
	-- upvalues: (ref) v_u7, (copy) v_u3, (copy) v_u_replicatedstorage, (ref) v_u8
	local v_visible = v_u7.Visible
	v_u7.Visible = false
	v_u3.disableForceLockOverride()
	if require(v_u_replicatedstorage.Controllers.MenuSceneController).IsActive() then
		require(v_u_replicatedstorage.Interface.Screens.Menu.Top).ResetToMainMenu()
		if not v_u8.Menu.Visible then
			v_u3.enableForceLockOverride()
			v_u8.Menu.Visible = true
		end
		v_u8.Gameplay.Visible = false
	elseif v_visible then
		require(v_u_replicatedstorage.Interface.Screens.Gameplay.Middle.TeamSelection).openFrame()
	end
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u7, (ref) v_u8, (copy) v_u5, (copy) v_u10, (copy) v_u2
	v_u7 = arg2
	v_u8 = arg1
	v_u5.observePlayer(function()
		-- upvalues: (ref) v_u10
		v_u10()
		return function()
			-- upvalues: (ref) v_u10
			v_u10()
		end
	end)
	v_u5.observeAttribute(workspace, "Timer", function(arg1)
		-- upvalues: (ref) v_u7, (ref) v_u2
		v_u7.Top.Timer.Text = v_u2(arg1)
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u4, (copy) v_u9, (ref) v_u7, (ref) v_u6, (copy) v_u11, (copy) v_u10, (copy) v_u1
	v_u4.Map.StartMapVote.Listen(function(arg1)
		-- upvalues: (ref) v_u9, (ref) v_u7, (ref) v_u6, (ref) v_u11
		v_u9(v_u7.MapVote, "ImageButton")
		v_u6 = nil
		for v1, v2 in ipairs(arg1) do
			v_u11(v1, v2)
		end
	end)
	v_u4.Map.UpdateMapVote.Listen(function(arg1)
		-- upvalues: (ref) v_u10
		v_u10(arg1)
	end)
	v_u4.Map.EndMapVote.Listen(function(_)
		-- upvalues: (ref) v_u1
		v_u1.CloseFrame()
	end)
end
return v_u1