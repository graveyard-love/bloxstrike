-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_players = game:GetService("Players")
local v_u_debris = game:GetService("Debris")
require(script:WaitForChild("Types"))
local v_u2 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u_localplayer = v_u_players.LocalPlayer
local v_u3 = nil
local function v_u4(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_players, (copy) v_u_localplayer
	if arg3 then
		local v_getplayerbyuserid = v_u_players:GetPlayerByUserId(arg3)
		if not (v_getplayerbyuserid and v_getplayerbyuserid:IsDescendantOf(v_u_players)) then
			arg2.Visible = false
			return
		end
		local v_team = v_getplayerbyuserid:GetAttribute("Team")
		arg2.Text = v_getplayerbyuserid.DisplayName
		arg2.Visible = true
		if v_u_localplayer.UserId == arg3 then
			arg1.UIStroke.Color = Color3.fromRGB(255, 0, 0)
		end
		if v_team == "Counter-Terrorists" then
			arg2.TextColor3 = Color3.fromRGB(165, 183, 212)
			return
		end
		if v_team == "Terrorists" then
			arg2.TextColor3 = Color3.fromRGB(219, 199, 126)
			return
		end
	end
end
function v_u1.createTemplate(arg1)
	-- upvalues: (copy) v_u_replicatedstorage, (ref) v_u3, (copy) v_u4, (copy) v_u_tween, (copy) v_u_debris
	local v1 = require(v_u_replicatedstorage.Database.Custom.Weapons[arg1.Weapon])
	v_u3.Visible = true
	local v_u_clone = v_u_replicatedstorage.Assets.UI.KillFeed.Kill:Clone()
	v_u_clone.Parent = v_u3
	local v_uipadding = v_u_clone.Contents:FindFirstChild("UIPadding")
	if not v_uipadding then
		v_uipadding = Instance.new("UIPadding")
		v_uipadding.Parent = v_u_clone.Contents
	end
	v_uipadding.PaddingLeft = UDim.new(0, 5)
	v_uipadding.PaddingRight = UDim.new(0, 5)
	v_u4(v_u_clone, v_u_clone.Contents.Player, (tonumber(arg1.Killer)))
	v_u4(v_u_clone, v_u_clone.Contents.Enemy, (tonumber(arg1.Victim)))
	if arg1.Assistor then
		v_u4(v_u_clone, v_u_clone.Contents.Assistor, (tonumber(arg1.Assistor)))
		v_u_clone.Contents.Addition.Visible = true
		v_u_clone.Contents.FlashAssist.Visible = arg1.FlashAssist == true
	else
		v_u_clone.Contents.Assistor.Visible = false
		v_u_clone.Contents.Addition.Visible = false
		v_u_clone.Contents.FlashAssist.Visible = false
	end
	v_u_clone.Contents.Weapon.Image = v1.ReverseIcon
	v_u_clone.Contents.Headshot.Visible = arg1.Headshot
	v_u_clone.Contents.NoScope.Visible = arg1.NoScope == true
	v_u_clone.Contents.Smoke.Visible = arg1.Smoke == true
	v_u_clone.Contents.Blind.Visible = arg1.Blind == true
	v_u_clone.Contents.Wallbang.Visible = arg1.Wallbang == true
	v_u_clone.Contents.Jump.Visible = arg1.Jump == true
	local function v2()
		-- upvalues: (copy) v_u_clone
		local v_player = v_u_clone.Contents.Player
		if v_player and v_player.AbsoluteSize.Y > 0 then
			local v1 = v_player.AbsoluteSize.Y * 0.84 * 1.67
			v_u_clone.Contents.Headshot.Size = UDim2.new(0, v1, 0, v1)
			v_u_clone.Contents.NoScope.Size = UDim2.new(0, v1 * 0.8333333333333334, 0, v1 * 0.8333333333333334)
			v_u_clone.Contents.Smoke.Size = UDim2.new(0, v1 * 1.1111111111111112, 0, v1 * 0.7777777777777778)
			v_u_clone.Contents.Wallbang.Size = UDim2.new(0, v1 * 1.1111111111111112, 0, v1 * 1.1111111111111112)
			v_u_clone.Contents.Blind.Size = UDim2.new(0, v1 * 0.8333333333333334, 0, v1 * 0.8333333333333334)
			v_u_clone.Contents.Jump.Size = UDim2.new(0, v1, 0, v1)
			v_u_clone.Contents.FlashAssist.Size = UDim2.new(0, v1, 0, v1)
		end
	end
	v2()
	v_u_clone.Contents:GetPropertyChangedSignal("AbsoluteSize"):Connect(v2)
	local v3 = 0
	if arg1.Blind == true then
		v_u_clone.Contents.Blind.LayoutOrder = v3
		v3 = v3 + 1
	end
	v_u_clone.Contents.Player.LayoutOrder = v3
	local v4 = v3 + 1
	if arg1.Assistor then
		v_u_clone.Contents.Addition.LayoutOrder = v4
		local v5 = v4 + 1
		if arg1.FlashAssist == true then
			v_u_clone.Contents.FlashAssist.LayoutOrder = v5
			v5 = v5 + 1
		end
		v_u_clone.Contents.Assistor.LayoutOrder = v5
		v4 = v5 + 1
	end
	if arg1.Jump == true then
		v_u_clone.Contents.Jump.LayoutOrder = v4
		v4 = v4 + 1
	end
	v_u_clone.Contents.Weapon.LayoutOrder = v4
	local v6 = v4 + 1
	if arg1.NoScope == true then
		v_u_clone.Contents.NoScope.LayoutOrder = v6
		v6 = v6 + 1
	end
	if arg1.Smoke == true then
		v_u_clone.Contents.Smoke.LayoutOrder = v6
		v6 = v6 + 1
	end
	if arg1.Wallbang == true then
		v_u_clone.Contents.Wallbang.LayoutOrder = v6
		v6 = v6 + 1
	end
	if arg1.Headshot == true then
		v_u_clone.Contents.Headshot.LayoutOrder = v6
		v6 = v6 + 1
	end
	v_u_clone.Contents.Enemy.LayoutOrder = v6
	v_u_clone.Visible = true
	task.delay(5, function()
		-- upvalues: (ref) v_u_tween, (copy) v_u_clone, (ref) v_u_debris
		v_u_tween:Create(v_u_clone, TweenInfo.new(1), {
			["GroupTransparency"] = 1
		}):Play()
		v_u_tween:Create(v_u_clone.UIStroke, TweenInfo.new(1), {
			["Transparency"] = 1
		}):Play()
		v_u_debris:AddItem(v_u_clone, 1)
	end)
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u3, (copy) v_u2, (copy) v_u1
	v_u3 = arg2
	v_u2.UI.UIPlayerKilled.Listen(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.createTemplate(arg1)
	end)
end
return v_u1