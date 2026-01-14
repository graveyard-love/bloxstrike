-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
local v_u_run = game:GetService("RunService")
local v_u_players = game:GetService("Players")
require(v_u_replicatedstorage.Database.Custom.Types)
local v_u_localplayer = v_u_players.LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u1 = require(v_u_replicatedstorage.Controllers.SpectateController)
local v_u2 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u3 = require(v_u_replicatedstorage.Controllers.InputController)
local v_u4 = require(v_u_replicatedstorage.Packages.Observers)
local v_u5 = require(v_u_replicatedstorage.Shared.Janitor)
local v_u6 = require(v_u_replicatedstorage.Classes.CharacterHighlight)
local v_u7 = require(v_u_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u8 = require(script.Components.CharacterKinematics)
local v_u9 = {
	["Counter-Terrorists"] = Color3.fromRGB(25, 80, 170),
	["Terrorists"] = Color3.fromRGB(255, 215, 70)
}
local v_u10 = {}
local v_u11 = {}
local function v_u12(arg1, arg2, arg3)
	-- upvalues: (copy) v_u11, (copy) v_u5, (copy) v_u_replicatedstorage, (copy) v_u9, (copy) v_u_playergui, (copy) v_u4, (copy) v_u_http, (copy) v_u7
	local v_u_humanoid = arg2:WaitForChild("Humanoid")
	local v_head = arg2:WaitForChild("Head")
	if not (v_head and (v_u_humanoid and arg2:IsDescendantOf(workspace))) then
		return nil
	end
	if v_u11[arg1] then
		v_u11[arg1]:Destroy()
		v_u11[arg1] = nil
	end
	local v_new = v_u5.new()
	local v_add = v_new:Add(v_u_replicatedstorage.Assets.Other.Character.Arrow:Clone())
	v_add.Arrow.ImageColor3 = v_u9[arg3]
	v_add.Adornee = v_head
	v_add.Parent = v_u_playergui
	local v_u_add = v_new:Add(v_u_replicatedstorage.Assets.Other.Character.NameTag:Clone())
	v_u_add.Info.PlayerName.Text = ("%*"):format(arg1.DisplayName)
	v_u_add.Info.Weapons.Bomb.Visible = false
	v_u_add.Adornee = v_head
	v_u_add.Parent = v_u_playergui
	v_u_add.Info.PlayerName.TextColor3 = v_u9[arg3]
	v_u_add.Info.Health.TextColor3 = v_u9[arg3]
	v_u_add.Info.Money.TextColor3 = v_u9[arg3]
	v_u_add.Info.Health.Text = ("%*%%"):format((math.ceil(v_u_humanoid.Health / v_u_humanoid.MaxHealth * 100)))
	v_new:Add(v_u_humanoid:GetPropertyChangedSignal("Health"):Connect(function()
		-- upvalues: (copy) v_u_add, (copy) v_u_humanoid
		if v_u_add and (v_u_add.Parent and v_u_add:FindFirstChild("Info")) then
			v_u_add.Info.Health.Text = ("%*%%"):format((math.ceil(v_u_humanoid.Health / v_u_humanoid.MaxHealth * 100)))
		end
	end))
	v_new:Add(v_u4.observeAttribute(arg1, "CurrentEquipped", function(arg1)
		-- upvalues: (copy) v_u_add, (ref) v_u_http, (ref) v_u7, (copy) arg1
		if not (v_u_add and (v_u_add.Parent and v_u_add:FindFirstChild("Info"))) then
			return function() end
		end
		local v_jsondecode = v_u_http:JSONDecode(arg1 or "[]")
		if v_jsondecode and v_jsondecode.Name then
			local v1 = v_u7(v_jsondecode.Name)
			if v_u_add.Info and (v_u_add.Info.Weapons and v_u_add.Info.Weapons.Gun) then
				v_u_add.Info.Weapons.Gun.Image = v1 and (v1.Icon or "") or ""
				v_u_add.Info.Weapons.Gun.Visible = v1 or false
			end
		elseif v_u_add.Info and (v_u_add.Info.Weapons and v_u_add.Info.Weapons.Gun) then
			v_u_add.Info.Weapons.Gun.Visible = false
		end
		if v_jsondecode then
			v_jsondecode = v_jsondecode.Name == "C4"
		end
		if v_u_add.Info and (v_u_add.Info.Weapons and v_u_add.Info.Weapons.Bomb) then
			local v_slot5 = arg1:GetAttribute("Slot5")
			local v2
			if v_slot5 then
				v2 = v_u_http:JSONDecode(v_slot5)
				if v2 then
					v2 = v2.Weapon == "C4"
				end
			else
				v2 = false
			end
			local v_bomb = v_u_add.Info.Weapons.Bomb
			if v2 then
				v2 = not v_jsondecode
			end
			v_bomb.Visible = v2
		end
		return function()
			-- upvalues: (ref) v_u_add
			if v_u_add and (v_u_add:FindFirstChild("Info") and (v_u_add.Info.Weapons and v_u_add.Info.Weapons.Gun)) then
				v_u_add.Info.Weapons.Gun.Visible = false
			end
		end
	end))
	v_new:Add(v_u4.observeAttribute(arg1, "Slot5", function(arg1)
		-- upvalues: (copy) v_u_add, (ref) v_u_http, (copy) arg1
		if not (v_u_add and (v_u_add.Parent and v_u_add:FindFirstChild("Info"))) then
			return function() end
		end
		local v_jsondecode = v_u_http:JSONDecode(arg1 or "[]")
		if v_jsondecode then
			v_jsondecode = v_jsondecode.Weapon == "C4"
		end
		local v_currentequipped = arg1:GetAttribute("CurrentEquipped")
		local v1
		if v_currentequipped then
			v1 = v_u_http:JSONDecode(v_currentequipped)
			if v1 then
				v1 = v1.Name == "C4"
			end
		else
			v1 = false
		end
		if v_u_add.Info and (v_u_add.Info.Weapons and v_u_add.Info.Weapons.Bomb) then
			local v_bomb = v_u_add.Info.Weapons.Bomb
			if v_jsondecode then
				v_jsondecode = not v1
			end
			v_bomb.Visible = v_jsondecode
		end
		return function()
			-- upvalues: (ref) v_u_add
			if v_u_add and (v_u_add:FindFirstChild("Info") and (v_u_add.Info.Weapons and v_u_add.Info.Weapons.Bomb)) then
				v_u_add.Info.Weapons.Bomb.Visible = false
			end
		end
	end))
	v_u11[arg1] = v_new
	return v_new
end
local function v_u13(_, arg2, arg3)
	-- upvalues: (copy) v_u2, (copy) v_u3
	local v_humanoid = arg2:WaitForChild("Humanoid")
	v_u2.setPerspective(true, false)
	arg3:Add(function()
		-- upvalues: (ref) v_u2
		v_u2.setPerspective(false, true)
	end)
	v_u3.enableGroup("Gameplay")
	arg3:Add(function()
		-- upvalues: (ref) v_u3
		v_u3.disableGroup("Gameplay")
	end)
	arg3:Add(v_humanoid.StateChanged:Connect(function(arg1, arg2)
		-- upvalues: (ref) v_u2
		v_u2.StateChanged(arg1, arg2)
	end))
end
return v_u4.observeCharacter(function(arg1, arg2)
	-- upvalues: (copy) v_u10, (copy) v_u5, (copy) v_u11, (copy) v_u_localplayer, (copy) v_u13, (copy) v_u_players, (copy) v_u12, (copy) v_u6, (copy) v_u4, (copy) v_u8, (copy) v_u_run, (copy) v_u1
	if v_u10[arg1] then
		v_u10[arg1]:Destroy()
		v_u10[arg1] = nil
	end
	local v_u_new = v_u5.new()
	v_u10[arg1] = v_u_new
	if v_u11[arg1] then
		v_u11[arg1]:Destroy()
		v_u11[arg1] = nil
	end
	if v_u_localplayer == arg1 then
		v_u13(arg1, arg2, v_u_new)
		for v1, _ in pairs(v_u11) do
			if v_u11[v1] then
				v_u11[v1]:Destroy()
				v_u11[v1] = nil
			end
		end
		for _, v_u2 in ipairs(v_u_players:GetPlayers()) do
			if v_u2 ~= v_u_localplayer then
				local v_character = v_u2.Character
				if v_character and v_character:IsDescendantOf(workspace) then
					local v_team = v_u_localplayer:GetAttribute("Team")
					local v_team = v_u2:GetAttribute("Team")
					if v_team == v_team and workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
						v_u12(v_u2, v_character, v_team)
						if v_u10[v_u2] then
							v_u10[v_u2]:Add(function()
								-- upvalues: (copy) v_u2, (ref) v_u11
								local v1 = v_u2
								if v_u11[v1] then
									v_u11[v1]:Destroy()
									v_u11[v1] = nil
								end
							end)
						end
					end
				end
			end
		end
	else
		local v_team = arg1:GetAttribute("Team")
		local v_u_add = v_u_new:Add(v_u6.new(arg2, {
			["DepthMode"] = Enum.HighlightDepthMode.Occluded,
			["FillColor"] = Color3.fromRGB(255, 255, 255),
			["OutlineColor"] = v_team == "Counter-Terrorists" and Color3.fromRGB(0, 75, 200) or (v_team == "Terrorists" and Color3.fromRGB(255, 220, 50) or Color3.fromRGB(255, 255, 255)),
			["OutlineTransparency"] = 0.75,
			["FillTransparency"] = 0.95
		}))
		v_u_new:Add(v_u4.observeAttribute(arg2, "CameraCFrame", function(arg1)
			-- upvalues: (ref) v_u8, (copy) arg1, (copy) arg2
			v_u8.updateKinematics(arg1, arg2, arg1)
			return function() end
		end))
		v_u_new:Add(function()
			-- upvalues: (ref) v_u8, (copy) arg1
			v_u8.cleanup(arg1)
		end)
		v_u_new:Add(v_u4.observeAttribute(arg2, "Invincible", function(arg1)
			-- upvalues: (copy) v_u_add
			v_u_add:UpdateState(arg1 or false)
			return function()
				-- upvalues: (ref) v_u_add
				v_u_add:UpdateState(false)
				v_u_add:Destroy()
			end
		end))
		v_u_add.Janitor:Add(v_u_run.Heartbeat:Connect(function()
			-- upvalues: (copy) arg2, (copy) v_u_add
			if arg2 and arg2:IsDescendantOf(workspace) then
				local v_invincible = arg2:GetAttribute("Invincible")
				v_u_add:UpdateState(v_invincible or false)
				if not v_invincible then
					v_u_add:Destroy()
				end
			end
		end))
		local v_gamemode = workspace:GetAttribute("Gamemode")
		if v_u_localplayer:GetAttribute("Team") == v_team and v_gamemode ~= "Deathmatch" then
			v_u12(arg1, arg2, v_team)
			v_u_new:Add(function()
				-- upvalues: (copy) arg1, (ref) v_u11
				local v1 = arg1
				if v_u11[v1] then
					v_u11[v1]:Destroy()
					v_u11[v1] = nil
				end
			end)
		end
		if v_u_localplayer:GetAttribute("IsSpectating") and not v_u1.GetCurrentSpectateInstance() then
			v_u1.Next()
		end
	end
	return function()
		-- upvalues: (copy) v_u_new
		v_u_new:Destroy()
	end
end)