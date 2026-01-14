-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_collection = game:GetService("CollectionService")
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Controllers.CharacterController)
local v_u3 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u4 = require(v_replicatedstorage.Controllers.DataController)
local v_u5 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u6 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
local v_u7 = require(v_replicatedstorage.Database.Components.GameState)
local v_u8 = require(v_replicatedstorage.Database.Components.Common.IsInBuyArea)
local v9 = require(v_replicatedstorage.Components.Common.GetUserPlatform)
local v_u10 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u11 = require(v_replicatedstorage.Database.Security.Router)
local v_u12 = require(v_replicatedstorage.Shared.Promise)
local v_u13 = require(v_replicatedstorage.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u14 = require(v_replicatedstorage.Interface.Screens.Gameplay.Middle.BuyMenu)
local v_u15 = require(v_replicatedstorage.Interface.Screens.Menu.Top)
local v_u16 = require(v_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u_localplayer = v_players.LocalPlayer
local v_u_current_camera = workspace.CurrentCamera
local v_u_new = RaycastParams.new()
v_u_new.FilterType = Enum.RaycastFilterType.Exclude
v_u_new.IgnoreWater = true
local v_u_find = table.find(v9(), "Mobile")
if v_u_find then
	v_u_find = #v9() <= 1
end
local v_u17 = nil
local v_u18 = nil
local v_u19 = nil
local v_u20 = nil
local v_u21 = nil
local v_u22 = nil
local v_u23 = false
local v_u24 = nil
local v_u_new = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
local function v_u25()
	-- upvalues: (copy) v_u_current_camera, (copy) v_u_localplayer, (copy) v_u_new
	if not (v_u_current_camera and v_u_localplayer.Character) then
		return nil
	end
	if v_u_localplayer:GetAttribute("Team") ~= "Counter-Terrorists" then
		return nil
	end
	v_u_new.FilterDescendantsInstances = { v_u_localplayer.Character, v_u_current_camera }
	local v_raycast = workspace:Raycast(v_u_current_camera.CFrame.Position, v_u_current_camera.CFrame.LookVector * 5, v_u_new)
	if v_raycast then
		local v_instance = v_raycast.Instance
		if v_instance and (v_instance.Parent and v_instance.Parent:HasTag("Hostage")) or false then
			local v_parent = v_raycast.Instance.Parent
			if v_parent and v_parent:GetAttribute("CanRescue") == true then
				local v_rescuingplayer = v_parent:GetAttribute("RescuingPlayer")
				if v_rescuingplayer and v_rescuingplayer ~= v_u_localplayer.Name then
					return nil
				elseif v_parent:GetAttribute("CarryingPlayer") then
					return nil
				else
					return v_parent
				end
			end
		end
	end
	return nil
end
local function v_u26()
	-- upvalues: (ref) v_u17, (copy) v_u_collection
	if v_u17 then
		local v1 = v_u_collection:GetTagged("Bomb")[1]
		if v1 then
			v1 = v1:GetAttribute("CanDefuse")
		end
		local v2 = #v_u_collection:GetTagged("IsHoveringInteractable") > 0
		if v1 then
			v_u17.Interact.Defuse.Visible = true
			v_u17.Interact.Use.Visible = false
			return
		elseif v2 then
			v_u17.Interact.Defuse.Visible = false
			v_u17.Interact.Use.Visible = true
		else
			v_u17.Interact.Defuse.Visible = false
			v_u17.Interact.Use.Visible = false
		end
	else
		return
	end
end
local function v_u27()
	-- upvalues: (ref) v_u17, (copy) v_u10
	local v1 = {}
	if v_u17 then
		for _, v2 in ipairs(v_u17:GetChildren()) do
			if v2:IsA("TextButton") and v2.Name ~= "Configure" then
				local v3 = {
					["Position"] = {
						["X"] = v2.Position.X.Scale,
						["Y"] = v2.Position.Y.Scale
					},
					["Size"] = {
						["X"] = v2.Size.X.Scale,
						["Y"] = v2.Size.Y.Scale
					}
				}
				v1[v2.Name] = v3
			end
		end
		v_u10.Player.UpdateMobileButtons.Send({
			["Value"] = v1
		})
	end
end
local function v_u28()
	-- upvalues: (ref) v_u23, (ref) v_u17
	if not v_u23 then
		v_u23 = true
		for _, v1 in ipairs(v_u17:GetChildren()) do
			if v1:IsA("TextButton") and v1.Name ~= "Configure" then
				v1.Active = false
			end
		end
	end
end
local function v_u29()
	-- upvalues: (ref) v_u23, (ref) v_u20, (ref) v_u21, (ref) v_u22, (ref) v_u24, (ref) v_u18, (ref) v_u17, (copy) v_u27
	if v_u23 then
		v_u23 = false
		v_u20 = nil
		v_u21 = nil
		v_u22 = nil
		v_u24 = nil
		v_u18 = nil
		for _, v1 in ipairs(v_u17:GetChildren()) do
			if v1:IsA("TextButton") and (v1.Name ~= "Shoot" and v1.Name ~= "Aim") then
				v1.Active = true
			end
		end
		v_u27()
	end
end
local function v_u30(arg1)
	-- upvalues: (ref) v_u20, (ref) v_u22, (ref) v_u17
	if v_u20 and v_u22 then
		local v_absolutesize = v_u17.AbsoluteSize
		local v1 = arg1 - v_u22
		local v_absolutesize = v_u20.AbsoluteSize
		local v_clamp = math.clamp(v1.X, 0, v_absolutesize.X - v_absolutesize.X)
		local v_new = Vector2.new(v_clamp, (math.clamp(v1.Y, 0, v_absolutesize.Y - v_absolutesize.Y)))
		v_u20.Position = UDim2.fromScale(v_new.X / v_absolutesize.X, v_new.Y / v_absolutesize.Y)
	end
end
local function v_u31(arg1)
	-- upvalues: (ref) v_u21, (ref) v_u24, (ref) v_u18, (ref) v_u17
	if v_u21 and (v_u24 and v_u18) then
		local v1 = v_u24 + (arg1 - v_u18)
		local v_max = math.max(v1.X, 50)
		local v_new = Vector2.new(v_max, (math.max(v1.Y, 50)))
		local v2 = v_u17.AbsoluteSize * 0.8
		local v_min = math.min(v_new.X, v2.X)
		local v_new = Vector2.new(v_min, (math.min(v_new.Y, v2.Y)))
		v_u21.Size = UDim2.fromScale(v_new.X / UNNAMED_1728994806696.X, v_new.Y / UNNAMED_1728994806696.Y)
	end
end
local function v_u32(arg1, arg2)
	-- upvalues: (ref) v_u23, (ref) v_u22, (ref) v_u20
	if (arg1.UserInputType == Enum.UserInputType.Touch and true or arg1.UserInputType == Enum.UserInputType.MouseButton1) and v_u23 then
		local v_position = arg1.Position
		local v_new = Vector2.new(v_position.X, v_position.Y)
		if v_u23 then
			v_u22 = v_new - arg2.AbsolutePosition
			v_u20 = arg2
		end
	end
end
local function v_u33(arg1)
	-- upvalues: (ref) v_u23, (ref) v_u20, (copy) v_u30, (ref) v_u21, (copy) v_u31
	if (arg1.UserInputType == Enum.UserInputType.Touch and true or arg1.UserInputType == Enum.UserInputType.MouseMovement) and v_u23 then
		local v_position = arg1.Position
		local v_new = Vector2.new(v_position.X, v_position.Y)
		if v_u20 then
			v_u30(v_new)
			return
		elseif v_u21 then
			v_u31(v_new)
		end
	else
		return
	end
end
local function v_u34(arg1)
	-- upvalues: (ref) v_u23, (ref) v_u20, (ref) v_u22, (ref) v_u21, (ref) v_u18, (ref) v_u24
	if (arg1.UserInputType == Enum.UserInputType.Touch and true or arg1.UserInputType == Enum.UserInputType.MouseButton1) and v_u23 then
		if v_u20 then
			v_u22 = nil
			v_u20 = nil
			return
		elseif v_u21 then
			v_u18 = nil
			v_u24 = nil
			v_u21 = nil
		end
	else
		return
	end
end
function v_u1.setupButton(self)
	-- upvalues: (ref) v_u23, (copy) v_u_tween, (copy) v_u_new
	local v_u_size = self.Size
	self.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u23, (ref) v_u_tween, (copy) self, (ref) v_u_new, (copy) v_u_size
		if not v_u23 then
			local v1 = {}
			local v2 = v_u_size
			v1.Size = UDim2.fromScale(v2.X.Scale * 0.9, v2.Y.Scale * 0.9)
			v_u_tween:Create(self, v_u_new, v1):Play()
		end
	end)
	self.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u23, (ref) v_u_tween, (copy) self, (ref) v_u_new, (copy) v_u_size
		if not v_u23 then
			local v1 = {}
			local v2 = v_u_size
			v1.Size = UDim2.fromScale(v2.X.Scale * 1, v2.Y.Scale * 1)
			v_u_tween:Create(self, v_u_new, v1):Play()
		end
	end)
end
function v_u1.setupDraggableButton(self)
	-- upvalues: (ref) v_u23, (ref) v_u21, (ref) v_u20, (ref) v_u24, (ref) v_u18, (copy) v_u32, (ref) v_u22
	local v_u1 = nil
	local v_u2 = nil
	self.InputBegan:Connect(function(arg1)
		-- upvalues: (ref) v_u23, (ref) v_u1, (ref) v_u2
		if (arg1.UserInputType == Enum.UserInputType.Touch and true or arg1.UserInputType == Enum.UserInputType.MouseButton1) and v_u23 then
			local v_position = arg1.Position
			v_u1 = Vector2.new(v_position.X, v_position.Y)
			v_u2 = tick()
		end
	end)
	self.InputChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u23, (ref) v_u2, (ref) v_u1, (ref) v_u21, (ref) v_u20, (copy) self, (ref) v_u24, (ref) v_u18, (ref) v_u32
		if v_u23 then
			local v_position = arg1.Position
			local v_new = Vector2.new(v_position.X, v_position.Y)
			if v_u2 and v_u1 then
				local v_magnitude = (v_new - v_u1).Magnitude
				if tick() - v_u2 >= 0.5 and v_magnitude < 10 then
					if not (v_u21 or v_u20) then
						local v1 = self
						if v_u23 then
							v_u24 = v1.AbsoluteSize
							v_u18 = v_new
							v_u21 = v1
						end
						return
					end
				elseif v_magnitude >= 10 and not (v_u20 or v_u21) then
					v_u32(arg1, self)
					return
				end
			end
		end
	end)
	self.InputEnded:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u2, (ref) v_u23, (ref) v_u20, (copy) self, (ref) v_u22, (ref) v_u21, (ref) v_u18, (ref) v_u24
		if arg1.UserInputType == Enum.UserInputType.Touch and true or arg1.UserInputType == Enum.UserInputType.MouseButton1 then
			v_u1 = nil
			v_u2 = nil
			if v_u23 and v_u20 == self and ((arg1.UserInputType == Enum.UserInputType.Touch or arg1.UserInputType == Enum.UserInputType.MouseButton1) and v_u23) then
				if v_u20 then
					v_u22 = nil
					v_u20 = nil
				elseif v_u21 then
					v_u18 = nil
					v_u24 = nil
					v_u21 = nil
				end
			end
			if v_u21 == self then
				v_u18 = nil
				v_u24 = nil
				v_u21 = nil
			end
		end
	end)
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u17, (copy) v_u_find, (ref) v_u23, (copy) v_u2, (copy) v_u12, (copy) v_u3, (copy) v_u6, (copy) v_u16, (copy) v_u11, (copy) v_u_localplayer, (copy) v_u5, (copy) v_u7, (copy) v_u_tween, (copy) v_u_new, (ref) v_u19, (copy) v_u_collection, (copy) v_u25, (copy) v_u10, (copy) v_u14, (copy) v_u15, (copy) v_u13, (copy) v_u29, (copy) v_u28, (copy) v_u1, (copy) v_u_run, (copy) v_u8, (copy) v_u26, (copy) v_u_userinput, (copy) v_u33, (copy) v_u34
	v_u17 = arg2
	if v_u_find then
		local v_top = v_u17.Parent.Parent:FindFirstChild("Top")
		local v1 = v_top and v_top:FindFirstChild("Bomb Defusal")
		if v1 then
			v1.Size = UDim2.new(0.6, 0, 0.75, 0)
		end
		v_u17.Jump.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u23, (ref) v_u2
			if not v_u23 then
				v_u2.jump()
			end
		end)
		v_u17.Crouch.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u23, (ref) v_u2
			if not v_u23 then
				v_u2.crouch(not v_u2.GetCrouchState())
			end
		end)
		v_u17.Drop.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u23, (ref) v_u12, (ref) v_u3, (ref) v_u6, (ref) v_u16, (ref) v_u11
			if not v_u23 then
				v_u12.new(function(arg1, arg2)
					-- upvalues: (ref) v_u3
					local v_getcurrentequipped = v_u3.getCurrentEquipped()
					if v_getcurrentequipped then
						arg1(v_getcurrentequipped)
					else
						arg2("Failed to fetch current equipped")
					end
				end):catch(warn):andThen(function(arg1)
					-- upvalues: (ref) v_u6, (ref) v_u16, (ref) v_u11
					if arg1 then
						local v_getskininformation = v_u6.GetSkinInformation(arg1.Name, arg1.Skin)
						assert(v_getskininformation, "Skin data not found for weapon: " .. arg1.Name .. " and skin: " .. arg1.Skin)
						local v1 = v_u16[v_getskininformation.rarity]
						local v_floor = math.floor(v1.Color.R * 255)
						local v_floor = math.floor(v1.Color.G * 255)
						local v_floor = math.floor(v1.Color.B * 255)
						if arg1:drop() then
							v_u11.broadcastRouter("CreateNotification", "Item Dropped", ("You dropped your <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v_floor, v_floor, v_floor, arg1.Name, arg1.Skin), 2)
						end
					end
				end)
			end
		end)
		v_u17.Reload.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u23, (ref) v_u12, (ref) v_u3
			if not v_u23 then
				v_u12.new(function(arg1, arg2)
					-- upvalues: (ref) v_u3
					local v_getcurrentequipped = v_u3.getCurrentEquipped()
					if v_getcurrentequipped then
						arg1(v_getcurrentequipped)
					else
						arg2("Failed to fetch current equipped")
					end
				end):catch(warn):andThen(function(arg1)
					if arg1 then
						arg1:reload()
					end
				end)
			end
		end)
		local v_u_size = v_u17.Shoot.Size
		v_u17.Shoot.Active = false
		local v_u2 = false
		v_u17.Shoot.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u23, (ref) v_u2, (ref) v_u_localplayer, (ref) v_u5, (ref) v_u7, (ref) v_u11, (ref) v_u_tween, (ref) v_u17, (ref) v_u_new, (copy) v_u_size, (ref) v_u12, (ref) v_u3
			if v_u23 or v_u2 then
				return
			elseif v_u_localplayer:GetAttribute("IsPlayerChatting") then
				return
			elseif v_u5.IsLocalPlayerDead() then
				return
			elseif v_u_localplayer.Character then
				if v_u7.GetState() ~= "Buy Period" then
					v_u11.broadcastRouter("Cancel Defuse Bomb")
					v_u2 = true
					local v1 = {}
					local v2 = v_u_size
					v1.Size = UDim2.fromScale(v2.X.Scale * 0.9, v2.Y.Scale * 0.9)
					v_u_tween:Create(v_u17.Shoot, v_u_new, v1):Play()
					v_u12.new(function(arg1, arg2)
						-- upvalues: (ref) v_u3
						local v_getcurrentequipped = v_u3.getCurrentEquipped()
						if v_getcurrentequipped then
							arg1(v_getcurrentequipped)
						else
							arg2("Failed to fetch current equipped")
						end
					end):catch(warn):andThen(function(arg1)
						if arg1 then
							if arg1.Properties.Class == "C4" then
								arg1:shoot()
								return
							elseif arg1.Properties.Slot == "Grenade" then
								arg1:StartThrow()
							else
								arg1:shoot()
							end
						else
							return
						end
					end)
				end
			else
				return
			end
		end)
		v_u17.Shoot.InputEnded:Connect(function(arg1)
			-- upvalues: (ref) v_u2, (ref) v_u_tween, (ref) v_u17, (ref) v_u_new, (copy) v_u_size, (ref) v_u23, (ref) v_u12, (ref) v_u3
			if arg1.UserInputType == Enum.UserInputType.Touch or arg1.UserInputType == Enum.UserInputType.MouseButton1 then
				if v_u2 then
					v_u2 = false
					local v1 = {}
					local v2 = v_u_size
					v1.Size = UDim2.fromScale(v2.X.Scale * 1, v2.Y.Scale * 1)
					v_u_tween:Create(v_u17.Shoot, v_u_new, v1):Play()
					if not v_u23 then
						v_u12.new(function(arg1, arg2)
							-- upvalues: (ref) v_u3
							local v_getcurrentequipped = v_u3.getCurrentEquipped()
							if v_getcurrentequipped then
								arg1(v_getcurrentequipped)
							else
								arg2("Failed to fetch current equipped")
							end
						end):catch(warn):andThen(function(arg1)
							if arg1 then
								if arg1.Properties.Class == "C4" then
									arg1:cancel()
									return
								elseif arg1.Properties.Slot == "Grenade" then
									arg1:Throw("Far")
								end
							else
								return
							end
						end)
					end
				else
					return
				end
			else
				return
			end
		end)
		local v_u_size = v_u17.Aim.Size
		v_u17.Aim.Active = false
		v_u17.Aim.InputBegan:Connect(function(arg1)
			-- upvalues: (ref) v_u23, (ref) v_u19, (ref) v_u_tween, (ref) v_u17, (ref) v_u_new, (copy) v_u_size, (ref) v_u12, (ref) v_u3
			if arg1.UserInputType == Enum.UserInputType.Touch or arg1.UserInputType == Enum.UserInputType.MouseButton1 then
				if not (v_u23 or v_u19) then
					v_u19 = arg1
					local v1 = {}
					local v2 = v_u_size
					v1.Size = UDim2.fromScale(v2.X.Scale * 0.9, v2.Y.Scale * 0.9)
					v_u_tween:Create(v_u17.Aim, v_u_new, v1):Play()
					v_u12.new(function(arg1, arg2)
						-- upvalues: (ref) v_u3
						local v_getcurrentequipped = v_u3.getCurrentEquipped()
						if v_getcurrentequipped then
							arg1(v_getcurrentequipped)
						else
							arg2("Failed to fetch current equipped")
						end
					end):catch(warn):andThen(function(arg1)
						if arg1 then
							if arg1.Properties.HasScope then
								arg1:scope(true)
								return
							elseif arg1.Properties.HasSuppressor then
								if arg1.IsSuppressed then
									arg1:removeSuppressor()
								else
									arg1:addSuppressor()
								end
							elseif arg1.Properties.ShootingOptions == "Burst" then
								arg1:updateFireMode()
							end
						else
							return
						end
					end)
				end
			else
				return
			end
		end)
		v_u17.Aim.InputEnded:Connect(function(arg1)
			-- upvalues: (ref) v_u19, (ref) v_u_tween, (ref) v_u17, (ref) v_u_new, (copy) v_u_size, (ref) v_u23, (ref) v_u12, (ref) v_u3
			if arg1 == v_u19 then
				v_u19 = nil
				local v1 = {}
				local v2 = v_u_size
				v1.Size = UDim2.fromScale(v2.X.Scale * 1, v2.Y.Scale * 1)
				v_u_tween:Create(v_u17.Aim, v_u_new, v1):Play()
				if not v_u23 then
					v_u12.new(function(arg1, arg2)
						-- upvalues: (ref) v_u3
						local v_getcurrentequipped = v_u3.getCurrentEquipped()
						if v_getcurrentequipped then
							arg1(v_getcurrentequipped)
						else
							arg2("Failed to fetch current equipped")
						end
					end):catch(warn):andThen(function(arg1)
						if arg1 then
							if arg1.Properties.HasScope then
								arg1:unscope()
							end
						else
							return
						end
					end)
				end
			else
				return
			end
		end)
		v_u17.Interact.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u_collection, (ref) v_u23, (ref) v_u11, (ref) v_u25, (ref) v_u_localplayer, (ref) v_u6, (ref) v_u16, (ref) v_u10
			local v1 = v_u_collection:GetTagged("Bomb")[1]
			if v_u23 then
				return
			elseif v1 and (v1:GetAttribute("CanDefuse") and not v1:GetAttribute("Defused")) then
				v_u11.broadcastRouter("Start Defuse Bomb")
				return
			else
				local v2 = v_u25()
				if v2 then
					local v_team = v_u_localplayer:GetAttribute("Team")
					if not v_u_localplayer:GetAttribute("IsCarryingHostage") and (not v_u_localplayer:GetAttribute("IsRescuingHostage") and v_team == "Counter-Terrorists") then
						local v_rescuingplayer = v2:GetAttribute("RescuingPlayer")
						local v_carryingplayer = v2:GetAttribute("CarryingPlayer")
						if (not v_rescuingplayer or v_rescuingplayer == v_u_localplayer.Name) and not v_carryingplayer then
							v_u11.broadcastRouter("Start Rescue Hostage")
							return
						end
					end
				end
				local v_gettagged = v_u_collection:GetTagged("IsHoveringInteractable")
				if #v_gettagged == 0 then
					return
				else
					local v3 = v_gettagged[1]
					local v_weapon = v3:GetAttribute("Weapon")
					local v_skin = v3:GetAttribute("Skin")
					if v_weapon ~= "C4" or v_u_localplayer:GetAttribute("Team") == "Terrorists" then
						if v3:GetAttribute("CanPickup") then
							local v_getskininformation = v_u6.GetSkinInformation(v_weapon, v_skin)
							if v_getskininformation then
								local v4 = v_u16[v_getskininformation.rarity]
								local v_floor = math.floor(v4.Color.R * 255)
								local v_floor = math.floor(v4.Color.G * 255)
								local v_floor = math.floor(v4.Color.B * 255)
								v_u11.broadcastRouter("CreateNotification", "Item Picked Up", ("You picked up a <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v_floor, v_floor, v_floor, v_weapon, v_skin), 2)
							end
							v_u10.Inventory.PickupWeapon.Send({
								["Identity"] = v3.Name
							})
						end
					end
				end
			end
		end)
		v_u17.Interact.MouseButton1Up:Connect(function()
			-- upvalues: (ref) v_u_collection, (ref) v_u23, (ref) v_u_localplayer, (ref) v_u11
			local v1 = v_u_collection:GetTagged("Bomb")[1]
			if v_u23 then
				return
			elseif v1 and v_u_localplayer:GetAttribute("IsDefusingBomb") then
				v_u11.broadcastRouter("Cancel Defuse Bomb")
				return
			elseif v_u_localplayer:GetAttribute("IsRescuingHostage") then
				v_u11.broadcastRouter("Cancel Rescue Hostage")
			end
		end)
		v_u17.Shop.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u23, (ref) v_u14
			if not v_u23 then
				v_u14.toggleFrame()
			end
		end)
		v_u17.Menu.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u23, (ref) v_u15
			if not v_u23 then
				v_u15.ToggleMenu()
			end
		end)
		v_u17.SwapTeam.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u23, (ref) v_u_localplayer, (ref) v_u13
			if v_u23 then
				return
			elseif v_u_localplayer:GetAttribute("IsSpectating") then
				v_u13.openFrame()
				return
			elseif v_u_localplayer.Character then
				v_u13.ToggleTeamSelection()
			end
		end)
		v_u17.Configure.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u23, (ref) v_u29, (ref) v_u28
			if v_u23 then
				v_u29()
			else
				v_u28()
			end
		end)
		for _, v3 in ipairs(v_u17:GetChildren()) do
			if v3:IsA("TextButton") then
				if v3.Name ~= "Shoot" and v3.Name ~= "Aim" then
					v_u1.setupButton(v3)
				end
				if v3.Name ~= "Configure" then
					v_u1.setupDraggableButton(v3)
				end
			end
		end
		v_u_run.Heartbeat:Connect(function()
			-- upvalues: (ref) v_u17, (ref) v_u_localplayer, (ref) v_u8, (ref) v_u26
			local v_shop = v_u17.Shop
			local v_buymenu = v_u_localplayer:GetAttribute("BuyMenu")
			if v_buymenu then
				v_buymenu = v_u8(v_u_localplayer)
			end
			v_shop.Visible = v_buymenu
			v_u26()
		end)
		v_u_userinput.InputChanged:Connect(v_u33)
		v_u_userinput.InputEnded:Connect(v_u34)
	else
		v_u17.Visible = false
	end
end
function v_u1.Start()
	-- upvalues: (ref) v_u17, (copy) v_u_localplayer, (copy) v_u_find, (ref) v_u19, (copy) v_u4, (ref) v_u23
	v_u17.Visible = false
	v_u_localplayer.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u17, (ref) v_u_find
		v_u17.Visible = v_u_find
	end)
	v_u_localplayer.CharacterRemoving:Connect(function()
		-- upvalues: (ref) v_u17, (ref) v_u19
		v_u17.Visible = false
		v_u19 = nil
	end)
	v_u4.CreateListener(v_u_localplayer, "MobileButtons", function(arg1)
		-- upvalues: (ref) v_u23, (ref) v_u17
		if not v_u23 then
			for v1, v2 in pairs(arg1) do
				local v3 = v_u17:FindFirstChild(v1)
				if v3 then
					v3.Position = UDim2.fromScale(v2.Position.X, v2.Position.Y)
					v3.Size = UDim2.fromScale(v2.Size.X, v2.Size.Y)
				end
			end
		end
	end)
end
return v_u1