-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u3 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u4 = require(v_replicatedstorage.Components.Common.GetPreferenceColor)
local v_u5 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u6 = require(v_replicatedstorage.Controllers.DataController)
local v_u7 = require(v_replicatedstorage.Database.Components.GameState)
local v_u8 = require(v_replicatedstorage.Packages.Observers)
local v9 = require(v_replicatedstorage.Shared.Janitor)
local v_u10 = nil
local v_u11 = nil
local v_u12 = nil
local v_u13 = nil
local v_u_http = game:GetService("HttpService")
local v_u_new = v9.new()
function v_u1.tweenAnimation(arg1)
	-- upvalues: (ref) v_u10, (ref) v_u12, (ref) v_u11
	if v_u10 ~= arg1.Identifier then
		v_u10 = arg1.Identifier
		v_u12.Size = UDim2.new(v_u12.Size.X.Scale, -25, v_u12.Size.Y.Scale, -25)
		if v_u11 then
			v_u11:Play()
		end
	end
end
function v_u1.updateFrame(arg1)
	-- upvalues: (ref) v_u12, (copy) v_u1, (copy) v_u4, (ref) v_u11, (ref) v_u13
	local v_properties = arg1.Properties
	v_u12.Visible = v_properties.Class == "Weapon"
	if v_u12.Visible then
		v_u1.tweenAnimation(arg1)
		local v_rounds = arg1.Rounds
		v_u12.Capacity.Amount.Text = tostring(arg1.Capacity)
		v_u12.Rounds.Amount.Text = tostring(v_rounds)
		local v1 = v_u4()
		v_u12.Capacity.Amount.TextColor3 = v1
		v_u12.Rounds.Amount.TextColor3 = v1
		v_u12.Divider.BackgroundColor3 = v1
		v_u12.SemiAuto.ImageColor3 = v1
		v_u12.Auto.ImageColor3 = v1
		local v2 = v_rounds / v_properties.Rounds
		v_u12.Rounds.Glow.ImageTransparency = 1
		if v2 <= 0.2 then
			v_u12.Rounds.Glow.ImageTransparency = math.max(v2, 0.3)
		end
		if v_properties.ShootingOptions == "Default" then
			v_u12.SemiAuto.Visible = not v_properties.Automatic
			v_u12.Auto.Visible = v_properties.Automatic
		elseif v_properties.ShootingOptions == "Burst" then
			v_u12.SemiAuto.Visible = arg1.AlternativeShootingOption == "Default"
			v_u12.Auto.Visible = arg1.AlternativeShootingOption == "Burst"
		end
	elseif v_u11 then
		v_u11:Cancel()
	end
	local v3 = v_u12
	local v_visible = v_u12.Visible
	if v_visible then
		v_visible = not v_u13.Gameplay.Middle.BuyMenu.Visible
	end
	v3.Visible = v_visible
end
local function v_u14()
	-- upvalues: (copy) v_u2, (ref) v_u12, (copy) v_u1
	local v_getcurrentequipped = v_u2.getCurrentEquipped()
	if v_getcurrentequipped then
		if v_getcurrentequipped.Rounds ~= (tonumber(v_u12.Rounds.Amount.Text) or 0) or v_getcurrentequipped.Capacity ~= (tonumber(v_u12.Capacity.Amount.Text) or 0) then
			v_u1.updateFrame(v_getcurrentequipped)
		end
	end
end
function v_u1.characterAdded(_, arg2)
	-- upvalues: (copy) v_u_new, (copy) v_u_localplayer, (copy) v_u_run, (copy) v_u2, (copy) v_u1, (copy) v_u14, (copy) v_u8, (copy) v_u_http, (copy) v_u5, (ref) v_u12
	v_u_new:Cleanup()
	if arg2 == v_u_localplayer then
		v_u_new:Add(v_u_run.Stepped:Connect(function(_, _)
			-- upvalues: (ref) v_u2, (ref) v_u1
			local v_getcurrentequipped = v_u2.getCurrentEquipped()
			if v_getcurrentequipped then
				v_u1.updateFrame(v_getcurrentequipped)
			end
		end))
		task.wait(0.1)
		v_u14()
		task.delay(3, function()
			-- upvalues: (ref) v_u_localplayer, (ref) v_u14
			if v_u_localplayer.Character and v_u_localplayer.Character:IsDescendantOf(workspace) then
				v_u14()
			end
		end)
		return
	else
		v_u_new:Add(v_u8.observeAttribute(arg2, "CurrentEquipped", function(arg1)
			-- upvalues: (ref) v_u_http, (ref) v_u5, (ref) v_u1, (ref) v_u12
			if arg1 then
				local v_jsondecode = v_u_http:JSONDecode(arg1)
				if v_jsondecode and v_jsondecode.Name then
					local v1 = {
						["Properties"] = v_u5(v_jsondecode.Name),
						["Identifier"] = v_jsondecode.Identifier or "",
						["Rounds"] = v_jsondecode.Rounds or 0,
						["Capacity"] = v_jsondecode.Capacity or 0,
						["AlternativeShootingOption"] = "Default"
					}
					if v1.Properties and v1.Properties.Class == "Weapon" then
						v_u1.updateFrame(v1)
					else
						v_u12.Visible = false
					end
				else
					v_u12.Visible = false
					return
				end
			else
				v_u12.Visible = false
				return
			end
		end))
		local v_currentequipped = arg2:GetAttribute("CurrentEquipped")
		if v_currentequipped then
			local v_jsondecode = v_u_http:JSONDecode(v_currentequipped)
			if v_jsondecode and v_jsondecode.Name then
				local v1 = {
					["Properties"] = v_u5(v_jsondecode.Name),
					["Identifier"] = v_jsondecode.Identifier or "",
					["Rounds"] = v_jsondecode.Rounds or 0,
					["Capacity"] = v_jsondecode.Capacity or 0,
					["AlternativeShootingOption"] = "Default"
				}
				if v1.Properties and v1.Properties.Class == "Weapon" then
					v_u1.updateFrame(v1)
				else
					v_u12.Visible = false
				end
			else
				v_u12.Visible = false
				return
			end
		else
			v_u12.Visible = false
			return
		end
	end
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u13, (ref) v_u12, (ref) v_u11, (copy) v_u_tween, (copy) v_u_localplayer, (copy) v_u_new, (copy) v_u8, (copy) v_u6, (copy) v_u2, (copy) v_u1
	v_u13 = arg1
	v_u12 = arg2
	v_u11 = v_u_tween:Create(v_u12, TweenInfo.new(0.25), {
		["Size"] = UDim2.fromScale(v_u12.Size.X.Scale, v_u12.Size.Y.Scale)
	})
	v_u_localplayer.CharacterRemoving:Connect(function()
		-- upvalues: (ref) v_u_new
		v_u_new:Cleanup()
	end)
	v_u8.observeProperty(v_u12.Rounds.Amount, "Text", function(_)
		-- upvalues: (ref) v_u_tween, (ref) v_u12
		local v_create = v_u_tween:Create(v_u12.Rounds.Amount.UIScale, TweenInfo.new(0.05), {
			["Scale"] = 1.2
		})
		v_create:Play()
		v_create.Completed:Once(function()
			-- upvalues: (ref) v_u_tween, (ref) v_u12
			v_u_tween:Create(v_u12.Rounds.Amount.UIScale, TweenInfo.new(0.05, Enum.EasingStyle.Elastic), {
				["Scale"] = 1
			}):Play()
		end)
	end)
	v_u6.CreateListener(v_u_localplayer, "Settings.Game.HUD.Color", function()
		-- upvalues: (ref) v_u2, (ref) v_u1
		local v_getcurrentequipped = v_u2.getCurrentEquipped()
		if v_getcurrentequipped then
			v_u1.updateFrame(v_getcurrentequipped)
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u_new, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u3, (copy) v_u7
	local v_u1 = nil
	local function v_u2(self)
		-- upvalues: (ref) v_u_new, (ref) v_u1, (ref) v_u1, (ref) v_u_localplayer
		v_u_new:Cleanup()
		v_u1 = self
		local v_character = self.Character
		if v_character and v_character:IsDescendantOf(workspace) then
			v_u1.characterAdded(v_character, self)
		elseif self ~= v_u_localplayer then
			local v_u1 = nil
			v_u1 = self.CharacterAdded:Connect(function(arg1)
				-- upvalues: (ref) v_u1, (copy) self, (ref) v_u1, (ref) v_u1
				if v_u1 == self and arg1:IsDescendantOf(workspace) then
					v_u1.characterAdded(arg1, self)
					v_u1:Disconnect()
				end
			end)
			v_u_new:Add(v_u1)
		end
	end
	v_u_localplayer.CharacterAdded:Connect(function()
		-- upvalues: (copy) v_u2, (ref) v_u_localplayer
		v_u2(v_u_localplayer)
	end)
	v_u3.ListenToSpectate:Connect(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (copy) v_u2
		if v_u_localplayer:GetAttribute("IsSpectating") and arg1 then
			v_u2(arg1)
		end
	end)
	v_u_localplayer:GetAttributeChangedSignal("IsSpectating"):Connect(function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u3, (copy) v_u2
		if v_u_localplayer:GetAttribute("IsSpectating") then
			local v_getplayer = v_u3.GetPlayer()
			if v_getplayer then
				v_u2(v_getplayer)
			end
		else
			v_u2(v_u_localplayer)
		end
	end)
	if v_u_localplayer:GetAttribute("IsSpectating") then
		local v_getplayer = v_u3.GetPlayer()
		if v_getplayer then
			v_u2(v_getplayer)
		end
	else
		v_u2(v_u_localplayer)
	end
	v_u7.ListenToState(function(_, arg2)
		-- upvalues: (copy) v_u2, (ref) v_u_localplayer
		if arg2 == "Buy Period" or arg2 == "Round In Progress" then
			v_u2(v_u_localplayer)
		end
	end)
end
return v_u1