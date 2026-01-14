-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Components.Common.GetPreferenceColor)
local v_u3 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u4 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u5 = nil
local v_u6 = nil
local function v_u7(arg1, arg2)
	arg1.Amount.TextColor3 = arg2
	arg1.ImageColor3 = arg2
	for _, v1 in ipairs(arg1:GetDescendants()) do
		if v1:IsA("UIStroke") then
			v1.Color = arg2
		elseif v1:IsA("ImageLabel") then
			v1.ImageColor3 = arg2
		end
	end
end
function v_u1.createAnimationFrame(_)
	-- upvalues: (copy) v_u_localplayer, (ref) v_u5, (copy) v_u_replicatedstorage, (copy) v_u7, (copy) v_u2, (copy) v_u_tween
	local v_team = v_u_localplayer:GetAttribute("Team")
	if v_team and v_team ~= "Spectators" then
		local v1 = #v_u5.Cards:GetChildren() + 1
		if v1 <= 5 then
			local v2 = v_team == "Counter-Terrorists" and v_u_replicatedstorage.Assets.UI.Team.CTCard
			if not v2 then
				if v_team == "Terrorists" then
					v2 = v_u_replicatedstorage.Assets.UI.Team.TCard
				else
					v2 = false
				end
			end
			local v_u_clone = v2:Clone()
			v_u_clone.Amount.Text = tostring(v1)
			v_u_clone.Position = UDim2.fromScale(0.5, 1)
			v_u_clone.Name = tostring(v1)
			v_u_clone.Animation.ImageTransparency = 1
			v_u_clone.Animation.Visible = false
			v_u_clone.Parent = v_u5.Cards
			v_u_clone.Rotation = -10
			v_u_clone.Visible = true
			v_u7(v_u_clone, v_u2())
			for _, v3 in ipairs(v_u5.Cards:GetChildren()) do
				local v4 = v1 == 1 and 0 or ((tonumber(v3.Name) - math.floor((v1 + 1) / 2)) * 0.2617993877991494 or 0)
				v_u_tween:Create(v3, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["Position"] = UDim2.fromScale(math.sin(v4) * (v1 >= 3 and (v3.Name == "1" and 0.75 or (v3.Name == "2" and 0.75 or 0.85)) or 0.85) + 0.5, math.cos(v4) * (v1 >= 3 and (v3.Name == "1" and 0.25 or (v3.Name == "2" and 0.125 or 0.05)) or 0.05) + 0.45),
					["Rotation"] = math.deg(v4)
				}):Play()
			end
			v_u_tween:Create(v_u_clone.Animation, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["ImageTransparency"] = 0.2
			}):Play()
			local v_new = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			v_u_tween:Create(v_u5.Team.Team, v_new, {
				["ImageColor3"] = Color3.fromRGB(135, 155, 177)
			}):Play()
			task.delay(0.5, function()
				-- upvalues: (copy) v_u_clone, (ref) v_u_tween, (ref) v_u5
				if v_u_clone and v_u_clone:FindFirstChild("Animation") then
					v_u_tween:Create(v_u_clone.Animation, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["ImageTransparency"] = 1
					}):Play()
					local v_new = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
					v_u_tween:Create(v_u5.Team.Team, v_new, {
						["ImageColor3"] = Color3.fromRGB(36, 41, 47)
					}):Play()
				end
			end)
		end
	else
		return
	end
end
function v_u1.OpenFrame()
	-- upvalues: (copy) v_u2, (ref) v_u6, (ref) v_u5, (copy) v_u_localplayer
	local v1 = v_u2()
	v_u6.Gameplay.Bottom.Middle.Spectate.Visible = false
	v_u5.Team.Outline.ImageColor3 = v1
	v_u5.Line1.ImageColor3 = v1
	v_u5.Line2.ImageColor3 = v1
	v_u5.Cards.Visible = true
	v_u5.Visible = true
	local v_team = v_u_localplayer:GetAttribute("Team")
	v_u5.Team.Team.CT.Visible = v_team == "Counter-Terrorists"
	v_u5.Team.Team.T.Visible = v_team == "Terrorists"
	v_u5.Team.Team.ImageColor3 = v_team == "Terrorists" and Color3.fromRGB(89, 79, 50) or Color3.fromRGB(36, 41, 47)
end
function v_u1.CloseFrame()
	-- upvalues: (ref) v_u5
	v_u5.Cards:ClearAllChildren()
	v_u5.Cards.Visible = false
	v_u5.Visible = false
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u6, (ref) v_u5, (copy) v_u3, (copy) v_u_localplayer, (copy) v_u2, (copy) v_u7
	v_u6 = arg1
	v_u5 = arg2
	v_u3.CreateListener(v_u_localplayer, "Settings.Game.HUD.Color", function()
		-- upvalues: (ref) v_u5, (ref) v_u2, (ref) v_u7
		if v_u5.Visible then
			local v1 = v_u2()
			v_u5.Team.Outline.ImageColor3 = v1
			v_u5.Line1.ImageColor3 = v1
			v_u5.Line2.ImageColor3 = v1
			for _, v2 in ipairs(v_u5.Cards:GetChildren()) do
				if v2:IsA("ImageLabel") and (v2:FindFirstChild("Amount") and (v2:FindFirstChild("Skull1") and (v2:FindFirstChild("Skull2") and v2:FindFirstChild("Animation")))) then
					v_u7(v2, v1)
				end
			end
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u1, (copy) v_u4, (ref) v_u5
	v_u_localplayer.CharacterAdded:Connect(function(_)
		-- upvalues: (ref) v_u1
		v_u1.OpenFrame()
	end)
	v_u_localplayer.CharacterRemoving:Connect(function(_)
		-- upvalues: (ref) v_u1
		v_u1.CloseFrame()
	end)
	v_u4.UI.UIPlayerKilled.Listen(function(arg1)
		-- upvalues: (ref) v_u5, (ref) v_u_localplayer, (ref) v_u1
		if v_u5.Visible and v_u_localplayer.UserId == tonumber(arg1.Killer) then
			v_u1.createAnimationFrame(arg1)
		end
	end)
end
return v_u1