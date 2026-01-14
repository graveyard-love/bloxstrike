-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u3 = require(v_replicatedstorage.Components.Common.GetBadgeIcon)
local v_u4 = require(v_replicatedstorage.Packages.Observers)
local v5 = require(v_replicatedstorage.Shared.Janitor)
local v_u6 = require(v_replicatedstorage.Database.Custom.GameStats.Settings.Colors)
local v_u7 = nil
local v_u8 = nil
local v_u_new = v5.new()
local function v_u9(arg1, arg2)
	-- upvalues: (copy) v_u6, (ref) v_u7
	local v_team = arg1:GetAttribute("Team")
	if v_team then
		local v1 = v_u6["Team Color"][v_team]
		local v_floor = math.floor(v1.R * 255)
		local v_floor = math.floor(v1.G * 255)
		local v_floor = math.floor(v1.B * 255)
		v_u7.ADR.Text = ("<font color=\"rgb(%*, %*, %*)\">ADR:</font> %*"):format(v_floor, v_floor, v_floor, math.floor((arg2 or (arg1:GetAttribute("ADR") or 0)) * 10) / 10)
	end
end
function v_u1.UpdateFrame(self)
	-- upvalues: (copy) v_u2, (ref) v_u7, (copy) v_u6, (copy) v_u3, (copy) v_u_new, (copy) v_u4, (copy) v_u9
	local v_getcurrentspectateinstance = v_u2.GetCurrentSpectateInstance()
	v_u7.Player.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(self.UserId)
	v_u7.Username.Text = self.Name
	local v_team = self:GetAttribute("Team")
	if v_team then
		local v1 = v_u6["Team Color"][v_team]
		v_u7.Username.TextColor3 = v1
		v_u7.Badge.Image = v_u3(self, v_team)
		v_u7.Frame1.BackgroundColor3 = v1
		v_u7.Frame2.BackgroundColor3 = v1
		v_u7.Player.Outline.ImageColor3 = v1
	end
	v_u_new:Cleanup()
	v_u_new:Add(v_u4.observeAttribute(self, "ADR", function(arg1)
		-- upvalues: (ref) v_u9, (copy) self
		if typeof(arg1) == "number" then
			v_u9(self, arg1)
		end
	end))
	v_u9(self)
	if v_getcurrentspectateinstance and v_getcurrentspectateinstance.CurrentEquipped then
		local v_currentequipped = v_getcurrentspectateinstance.CurrentEquipped
		v_u7.Weapon.Text = v_currentequipped.Name
		v_u7.Skin.Text = v_currentequipped.Skin
	end
	if v_getcurrentspectateinstance then
		v_u_new:Add(v_getcurrentspectateinstance.CurrentEquippedChanged:Connect(function(arg1)
			-- upvalues: (ref) v_u7
			if arg1 then
				v_u7.Weapon.Text = arg1.Name
				v_u7.Skin.Text = arg1.Skin
			end
		end))
	end
end
function v_u1.OpenFrame()
	-- upvalues: (ref) v_u8, (ref) v_u7
	v_u8.Gameplay.Bottom.Middle.Team.Visible = false
	v_u7.Visible = true
end
function v_u1.CloseFrame()
	-- upvalues: (ref) v_u7, (copy) v_u_new
	v_u7.Visible = false
	v_u_new:Cleanup()
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u8, (ref) v_u7
	v_u8 = arg1
	v_u7 = arg2
end
function v_u1.Start()
	-- upvalues: (copy) v_u2, (copy) v_u1
	v_u2.ListenToSpectate:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		if arg1 then
			v_u1.UpdateFrame(arg1)
			v_u1.OpenFrame()
		else
			v_u1.CloseFrame()
		end
	end)
end
return v_u1