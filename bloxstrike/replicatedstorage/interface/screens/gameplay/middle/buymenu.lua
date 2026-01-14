-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_u_replicatedstorage.Controllers.InventoryController)
local v_u3 = require(v_u_replicatedstorage.Controllers.CameraController)
local v_u4 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u5 = require(v_u_replicatedstorage.Components.Common.GetPreferenceColor)
local v_u6 = require(v_u_replicatedstorage.Database.Components.Common.RemoveFromArray)
local v_u7 = require(v_u_replicatedstorage.Database.Components.Common.IsInBuyArea)
local v_u8 = require(v_u_replicatedstorage.Components.Common.GetTimerFormat)
local v_u9 = require(v_u_replicatedstorage.Database.Components.GameState)
local v_u10 = require(v_u_replicatedstorage.Packages.Observers)
local v11 = require(v_u_replicatedstorage.Shared.Janitor)
local v12 = require(v_u_replicatedstorage.Shared.Spring)
local v_u13 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u14 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u15 = require(v_u_replicatedstorage.Database.Custom.GameStats.Grenades)
local v_u16 = require(v_u_replicatedstorage.Database.Custom.GameStats.NumberSlots)
local v_u_new = v11.new()
local v_u_new = v12.new(1, 8, 0)
local v_u17 = {}
local v_u18 = nil
local v_u19 = nil
local function v_u20(arg1, arg2)
	for _, v1 in ipairs(arg1) do
		for _, v2 in ipairs(v1._items) do
			if v2.Name == arg2 then
				return v2
			end
		end
	end
	return false
end
local function v_u21(arg1, arg2)
	local v1 = 0
	for _, v2 in ipairs(arg1) do
		for _, v3 in ipairs(v2._items) do
			if v3.Name == arg2 then
				v1 = v1 + 1
			end
		end
	end
	return v1
end
local function v_u22(arg1, arg2)
	local v_getattribute = arg1:GetAttribute(arg2)
	while not v_getattribute do
		v_getattribute = arg1:GetAttribute(arg2)
		task.wait()
	end
	return v_getattribute
end
function v_u1.purchase(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u7, (copy) v_u15, (copy) v_u2, (copy) v_u16, (copy) v_u_replicatedstorage, (copy) v_u17, (copy) v_u14, (copy) v_u13
	local v_money = v_u_localplayer:GetAttribute("Money")
	if v_u7(v_u_localplayer) then
		local v1 = not arg4
		if v1 then
			v1 = v_u15[arg1] ~= nil
		end
		local v2 = v1 and v_u2.getCurrentInventory()
		if v2 then
			local v3 = v2[v_u16.Grenade]
			if v3 and #v3._items >= v3._settings._strict_slot_space then
				return
			end
		end
		if not arg4 then
			local v_gamemode = workspace:GetAttribute("Gamemode")
			if v_u_localplayer:GetAttribute("BuyMenu") and (v_gamemode == "Hostage Rescue" or v_gamemode == "Bomb Defusal") then
				local v_getcurrentinventory = v_u2.getCurrentInventory()
				local v4 = v_u_replicatedstorage.Database.Custom.Weapons:FindFirstChild(arg1) or v_u_replicatedstorage.Database.Custom.GameStats.Equipment:FindFirstChild(arg1)
				local v5
				if v4 then
					v5 = require(v4)
				else
					v5 = nil
				end
				local v6 = v_u16[v5.Slot]
				if v_getcurrentinventory and v5 then
					local v7 = v_getcurrentinventory[v6]
					if v7 and #v7._items > 0 then
						local v8 = v7._items[1]
						if table.find(v_u17, v8.Identifier) then
							local v_name = v8.Name
							local v9 = v_u_replicatedstorage.Database.Custom.Weapons:FindFirstChild(v_name) or v_u_replicatedstorage.Database.Custom.GameStats.Equipment:FindFirstChild(v_name)
							local v10
							if v9 then
								v10 = require(v9)
							else
								v10 = nil
							end
							if v10 then
								arg3 = arg3 - v10.Cost
							end
						end
					end
				end
			end
		end
		if v_money and arg3 <= v_money then
			v_u14.broadcastRouter("RunInterfaceSound", "Successful Buy Menu Purchase")
			v_u13.Inventory.BuyMenuPurchase.Send({
				["Equipment"] = arg4,
				["Name"] = arg1,
				["Path"] = arg2 or ""
			})
		end
	end
end
function v_u1.createTemplate(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_localplayer, (copy) v_u5, (copy) v_u2, (copy) v_u21, (copy) v_u15, (copy) v_u9, (copy) v_u_new, (copy) v_u14, (copy) v_u20, (copy) v_u_tween, (copy) v_u1, (copy) v_u7, (copy) v_u13
	local v_name = arg2.Name
	local v1 = v_u_replicatedstorage.Database.Custom.Weapons:FindFirstChild(v_name) or v_u_replicatedstorage.Database.Custom.GameStats.Equipment:FindFirstChild(v_name)
	local v_u2
	if v1 then
		v_u2 = require(v1)
	else
		v_u2 = nil
	end
	if arg3 or not v_u2 then
		arg1.Visible = false
	else
		local v_gamemode = workspace:GetAttribute("Gamemode")
		arg1.Icon.Image = v_u2.ReverseIcon or v_u2.Icon
		arg1.Cost.Text = "$" .. tostring(v_u2.Cost):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
		local v3 = tonumber(arg1.Name)
		arg1.Keybind.Text = tostring(v3)
		arg1.Cost.Visible = v_gamemode ~= "Deathmatch"
		arg1.LayoutOrder = tonumber(arg1.Name)
		arg1.ItemName.Text = arg2.Name
		arg1.Teammates.Visible = false
		arg1.Visible = true
		local v4 = v_u2.Cost > v_u_localplayer:GetAttribute("Money") and Color3.fromRGB(149, 149, 149) or v_u5()
		arg1.ItemName.TextColor3 = v4
		arg1.Keybind.TextColor3 = v4
		arg1.Icon.ImageColor3 = v4
		arg1.Cost.TextColor3 = v4
		arg1:SetAttribute("Weapon", arg2.Name)
		arg1:SetAttribute("IsEquipment", arg3)
		local v_getcurrentinventory = v_u2.getCurrentInventory()
		local v5, v6
		if v_getcurrentinventory then
			v5 = v_u21(v_getcurrentinventory, arg2.Name) > 0
			local v_name = arg2.Name
			local v7 = v_u21(v_getcurrentinventory, v_name)
			local v8 = v_u15[v_name]
			if v8 then
				v6 = v7 < v8
			else
				v6 = v7 == 0
			end
		else
			v5 = false
			v6 = true
		end
		local v_return = arg1.Return
		local v9
		if v5 then
			if v_u9.GetState() == "Warmup" or v_gamemode == "Deathmatch" then
				v9 = false
			else
				local v10
				if arg1.Parent.Name == "Pistols" then
					v10 = arg1.Name == "1"
				else
					v10 = false
				end
				v9 = not v10
			end
		else
			v9 = v5
		end
		v_return.Visible = v9
		arg1.Hover.Visible = v5
		arg1.Hover.UIStroke.Transparency = v5 and not v6 and 0 or 1
		v_u_new:Add(arg1.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u2, (ref) v_u14, (ref) v_u20, (copy) arg2, (copy) arg1, (ref) v_u_tween
			local v_getcurrentinventory = v_u2.getCurrentInventory()
			v_u14.broadcastRouter("RunInterfaceSound", "UI Highlight")
			if v_getcurrentinventory then
				if not v_u20(v_getcurrentinventory, arg2.Name) then
					arg1.Hover.UIStroke.Transparency = 1
					arg1.Hover.Visible = true
					v_u_tween:Create(arg1.Hover.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["Transparency"] = 0.8
					}):Play()
				end
				local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				v_u_tween:Create(arg1.Icon, v_new, {
					["Size"] = UDim2.fromScale(0.7, 0.7)
				}):Play()
			end
		end))
		v_u_new:Add(arg1.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u2, (ref) v_u20, (copy) arg2, (copy) arg1, (ref) v_u_tween
			local v_getcurrentinventory = v_u2.getCurrentInventory()
			if v_getcurrentinventory then
				if not v_u20(v_getcurrentinventory, arg2.Name) then
					arg1.Hover.UIStroke.Transparency = 1
					arg1.Hover.Visible = false
				end
				local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				v_u_tween:Create(arg1.Icon, v_new, {
					["Size"] = UDim2.fromScale(0.75, 0.75)
				}):Play()
			end
		end))
		v_u_new:Add(arg1.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u_tween, (copy) arg1
			local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			v_u_tween:Create(arg1.Icon, v_new, {
				["Size"] = UDim2.fromScale(0.65, 0.65)
			}):Play()
		end))
		v_u_new:Add(arg1.MouseButton1Up:Connect(function()
			-- upvalues: (ref) v_u_tween, (copy) arg1
			local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			v_u_tween:Create(arg1.Icon, v_new, {
				["Size"] = UDim2.fromScale(0.7, 0.7)
			}):Play()
		end))
		v_u_new:Add(arg1.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u1, (copy) arg2, (copy) arg4, (copy) v_u2, (copy) arg3
			v_u1.purchase(arg2.Name, arg4, v_u2.Cost, arg3)
		end))
		v_u_new:Add(arg1.Return.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u2, (ref) v_u20, (copy) arg2, (ref) v_u7, (ref) v_u_localplayer, (ref) v_u13, (copy) arg3
			local v_getcurrentinventory = v_u2.getCurrentInventory()
			if v_getcurrentinventory then
				local v1 = v_u20(v_getcurrentinventory, arg2.Name)
				if v1 and v_u7(v_u_localplayer) then
					v_u13.Inventory.ReturnBuyMenuPurchase.Send({
						["Identifier"] = v1.Identifier,
						["Equipment"] = arg3
					})
				end
			end
		end))
	end
end
function v_u1.setupTemplate(arg1, arg2)
	-- upvalues: (copy) v_u14, (copy) v_u_localplayer, (copy) v_u1
	local v_broadcastrouter = v_u14.broadcastRouter("GetEquippedInventoryItem", v_u_localplayer, arg2)
	if v_broadcastrouter and v_broadcastrouter.Name then
		v_u1.createTemplate(arg1, v_broadcastrouter, false, arg2)
	else
		arg1:SetAttribute("IsEquipment", nil)
		arg1:SetAttribute("Weapon", nil)
		arg1.Visible = false
	end
end
function v_u1.updateBuyMenuTemplate(arg1, arg2)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_localplayer, (copy) v_u5, (copy) v_u21, (copy) v_u15, (copy) v_u9, (copy) v_u_tween
	local v_isequipment = arg2:GetAttribute("IsEquipment")
	local v_weapon = arg2:GetAttribute("Weapon")
	if v_isequipment or not v_weapon then
		return
	else
		local v1 = v_u_replicatedstorage.Database.Custom.Weapons:FindFirstChild(v_weapon) or v_u_replicatedstorage.Database.Custom.GameStats.Equipment:FindFirstChild(v_weapon)
		local v2
		if v1 then
			v2 = require(v1)
		else
			v2 = nil
		end
		local v3 = v2 and v_u_localplayer:GetAttribute("Money")
		if v3 then
			local v4 = v3 < v2.Cost and Color3.fromRGB(149, 149, 149) or v_u5()
			arg2.ItemName.TextColor3 = v4
			arg2.Keybind.TextColor3 = v4
			arg2.Icon.ImageColor3 = v4
			arg2.Cost.TextColor3 = v4
		end
		if arg2.Visible then
			local v5 = v_u21(arg1, v_weapon) > 0
			local v6 = v_u21(arg1, v_weapon)
			local v7 = v_u15[v_weapon]
			local v8
			if v7 then
				v8 = v6 < v7
			else
				v8 = v6 == 0
			end
			local v_gamemode = workspace:GetAttribute("Gamemode")
			local v_return = arg2.Return
			local v9
			if v5 then
				if v_gamemode == "Deathmatch" or v_u9.GetState() == "Warmup" then
					v9 = false
				else
					local v10
					if arg2.Parent.Name == "Pistols" then
						v10 = arg2.Name == "1"
					else
						v10 = false
					end
					v9 = not v10
				end
			else
				v9 = v5
			end
			v_return.Visible = v9
			arg2.Hover.Visible = v5
			if v5 then
				v_u_tween:Create(arg2.Hover.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["Transparency"] = v8 and 1 or 0
				}):Play()
			else
				arg2.Hover.UIStroke.Transparency = 1
			end
		else
			return
		end
	end
end
function v_u1.openFrame()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u7, (ref) v_u18, (copy) v_u3, (ref) v_u19
	local v_buymenu = v_u_localplayer:GetAttribute("BuyMenu")
	if v_u7(v_u_localplayer) then
		if v_buymenu and not v_u18.Visible then
			v_u3.enableForceLockOverride()
			v_u3.setPerspective(true, true)
			v_u19.Gameplay.Bottom.Health.Visible = false
			v_u19.Gameplay.Bottom.Middle.Visible = false
			v_u19.Gameplay.Bottom.Armor.Visible = false
			v_u19.Gameplay.Bottom.Money.Visible = false
			v_u19.Gameplay.Bottom.Ammo.Visible = false
			v_u18.Visible = true
		end
	else
		return
	end
end
function v_u1.closeFrame()
	-- upvalues: (ref) v_u18, (copy) v_u3, (ref) v_u19
	if v_u18.Visible then
		v_u3.disableForceLockOverride()
		v_u3.setPerspective(true, false)
		v_u19.Gameplay.Bottom.Health.Visible = true
		v_u19.Gameplay.Bottom.Middle.Visible = true
		v_u19.Gameplay.Bottom.Armor.Visible = true
		v_u19.Gameplay.Bottom.Money.Visible = true
		v_u19.Gameplay.Bottom.Ammo.Visible = true
		v_u18.Visible = false
	end
end
function v_u1.toggleFrame()
	-- upvalues: (copy) v_u_localplayer, (ref) v_u18, (copy) v_u1
	if v_u_localplayer:GetAttribute("BuyMenu") and not v_u18.Visible then
		v_u1.openFrame()
		return
	elseif v_u18.Visible then
		v_u1.closeFrame()
	end
end
function v_u1.characterAdded(_)
	-- upvalues: (copy) v_u22, (copy) v_u_localplayer, (copy) v_u_new, (copy) v_u1, (ref) v_u18
	if v_u22(v_u_localplayer, "Money") then
		v_u_new:Cleanup()
		v_u1.createTemplate(v_u18.Menu.Container.Equipment["4"], {
			["Name"] = workspace:GetAttribute("ServerGamemode") == "Hostage Rescue" and "Rescue Kit" or "Defuse Kit"
		}, true, nil)
		v_u1.createTemplate(v_u18.Menu.Container.Equipment["2"], {
			["Name"] = "Kevlar + Helmet"
		}, true, nil)
		v_u1.createTemplate(v_u18.Menu.Container.Equipment["1"], {
			["Name"] = "Kevlar"
		}, true, nil)
		v_u1.setupTemplate(v_u18.Menu.Container.Equipment["3"], "Equipped.Equipped Zeus x27")
		for _, v1 in ipairs(v_u18.Menu.Container:GetDescendants()) do
			if v1:IsA("TextButton") and v1.Parent.Name ~= "Equipment" then
				v_u1.setupTemplate(v1, (("Loadout.%*.Options.%*"):format(v1.Parent.Name, (tonumber(v1.Name)))))
			end
		end
	end
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u19, (ref) v_u18, (copy) v_u13, (copy) v_u17, (copy) v_u6, (copy) v_u10, (copy) v_u_localplayer, (copy) v_u_new, (copy) v_u1, (copy) v_u8, (copy) v_u9, (copy) v_u_run, (copy) v_u5, (copy) v_u7, (copy) v_u2, (copy) v_u4, (copy) v_u_new
	v_u19 = arg1
	v_u18 = arg2
	v_u13.Inventory.NewInventoryItem.Listen(function(arg1)
		-- upvalues: (ref) v_u17
		table.insert(v_u17, arg1.identifier)
	end)
	v_u13.Inventory.RemoveInventoryItem.Listen(function(self)
		-- upvalues: (ref) v_u6, (ref) v_u17
		v_u6(v_u17, function(_, arg2)
			-- upvalues: (copy) self
			return arg2 == self
		end)
	end)
	v_u10.observeAttribute(v_u_localplayer, "MinimumNextRoundIncome", function(arg1)
		-- upvalues: (ref) v_u18
		v_u18.Menu.TopFrame.NextRoundMoney.Text = "Next Round Minimum:  $" .. tostring(arg1):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end)
	v_u10.observeAttribute(v_u_localplayer, "Money", function(arg1)
		-- upvalues: (ref) v_u_new
		v_u_new:setGoal(arg1)
	end)
	v_u10.observeAttribute(v_u_localplayer, "BuyMenu", function(_)
		-- upvalues: (ref) v_u1
		return function()
			-- upvalues: (ref) v_u1
			v_u1.closeFrame()
		end
	end)
	v_u10.observeAttribute(workspace, "Timer", function(arg1)
		-- upvalues: (ref) v_u18, (ref) v_u8
		v_u18.Menu.TopFrame.Timer.Text = v_u8(arg1)
	end)
	v_u9.ListenToState(function(_, arg2)
		-- upvalues: (ref) v_u17
		if arg2 == "Buy Period" then
			table.clear(v_u17)
		end
	end)
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u_new, (ref) v_u18, (ref) v_u5, (ref) v_u7, (ref) v_u_localplayer, (ref) v_u1
		local v_getposition = v_u_new:getPosition()
		local v_round = math.round(v_getposition)
		local v_gsub = tostring(v_round):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
		v_u18.Menu.TopFrame.Money.TextColor3 = v_u5()
		v_u18.Menu.TopFrame.Money.Text = "$" .. v_gsub
		v_u_new:update(arg1)
		if v_u18.Visible and not v_u7(v_u_localplayer) then
			local v_gamemode = workspace:GetAttribute("Gamemode")
			if v_gamemode == "Bomb Defusal" or v_gamemode == "Hostage Rescue" then
				v_u1.closeFrame()
				return
			end
		end
	end)
	v_u2.OnInventoryChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u18, (ref) v_u1
		for _, v1 in ipairs(v_u18.Menu.Container:GetDescendants()) do
			if v1:IsA("TextButton") then
				v_u1.updateBuyMenuTemplate(arg1, v1)
			end
		end
	end)
	v_u4.CreateListener(v_u_localplayer, "Settings.Game.HUD.Color", function()
		-- upvalues: (ref) v_u2, (ref) v_u18, (ref) v_u1
		local v_getcurrentinventory = v_u2.getCurrentInventory()
		if v_getcurrentinventory then
			for _, v1 in ipairs(v_u18.Menu.Container:GetDescendants()) do
				if v1:IsA("TextButton") then
					v_u1.updateBuyMenuTemplate(v_getcurrentinventory, v1)
				end
			end
		end
	end)
	v_u4.CreateListener(v_u_localplayer, "Loadout", function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u_new, (ref) v_u1, (ref) v_u18
		if v_u_localplayer.Character then
			v_u_new:Cleanup()
			v_u1.createTemplate(v_u18.Menu.Container.Equipment["4"], {
				["Name"] = workspace:GetAttribute("ServerGamemode") == "Hostage Rescue" and "Rescue Kit" or "Defuse Kit"
			}, true, nil)
			v_u1.setupTemplate(v_u18.Menu.Container.Equipment["3"], "Equipped.Equipped Zeus x27")
			v_u1.createTemplate(v_u18.Menu.Container.Equipment["2"], {
				["Name"] = "Kevlar + Helmet"
			}, true, nil)
			v_u1.createTemplate(v_u18.Menu.Container.Equipment["1"], {
				["Name"] = "Kevlar"
			}, true, nil)
			for _, v1 in ipairs(v_u18.Menu.Container:GetDescendants()) do
				if v1:IsA("TextButton") and v1.Parent.Name ~= "Equipment" then
					v_u1.setupTemplate(v1, (("Loadout.%*.Options.%*"):format(v1.Parent.Name, (tonumber(v1.Name)))))
				end
			end
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u_localplayer, (copy) v_u1
	if v_u_localplayer.Character then
		v_u1.characterAdded(v_u_localplayer.Character)
	end
	v_u_localplayer.CharacterAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u1
		v_u1.characterAdded(arg1)
	end)
end
return v_u1