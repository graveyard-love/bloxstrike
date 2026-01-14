-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_players = game:GetService("Players")
local v_u_debris = game:GetService("Debris")
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u4 = require(v_replicatedstorage.Database.Components.GameState)
local v_u5 = require(v_replicatedstorage.Components.Common.GetPreferenceColor)
local v_u_new = require(v_replicatedstorage.Shared.Janitor).new()
local v_u6 = nil
local v_u7 = nil
local v_u8 = nil
function v_u1.animateFrame()
	-- upvalues: (ref) v_u8, (copy) v_u_tween, (copy) v_u_debris
	local v_clone = v_u8.Amount:Clone()
	v_clone.TextColor3 = Color3.fromRGB(255, 0, 4)
	v_clone.ZIndex = v_u8.ZIndex - 1
	v_clone.Parent = v_u8
	v_u_tween:Create(v_u8.Amount.UIScale, TweenInfo.new(0.07), {
		["Scale"] = 1.1
	}):Play()
	task.wait(0.07)
	v_u_tween:Create(v_u8.Amount.UIScale, TweenInfo.new(0.07, Enum.EasingStyle.Elastic), {
		["Scale"] = 1
	}):Play()
	v_u_tween:Create(v_clone, TweenInfo.new(0.5), {
		["Position"] = v_clone.Position + UDim2.fromScale(0, 0.25)
	}):Play()
	v_u_tween:Create(v_clone, TweenInfo.new(0.5), {
		["TextTransparency"] = 1
	}):Play()
	v_u_debris:AddItem(v_clone, 0.5)
end
function v_u1.updateFrame(arg1, arg2)
	-- upvalues: (ref) v_u8, (copy) v_u5, (copy) v_u_tween, (ref) v_u6, (copy) v_u1
	local v_round = math.round(arg1)
	v_u8.Amount.Text = tostring(v_round)
	v_u8.Frame.Bar.BackgroundColor3 = v_u5()
	v_u8.Amount.TextColor3 = v_u5()
	v_u8.Glow.ImageTransparency = 1
	local v_new = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	v_u_tween:Create(v_u8.Frame.Bar, v_new, {
		["Size"] = UDim2.fromScale(arg1 / arg2, 1)
	}):Play()
	if arg1 / arg2 <= 0.5 then
		v_u8.Glow.ImageTransparency = math.max((0.5 - UNNAMED_1728994621720) * 2, 0.3)
	end
	if arg1 < v_u6 then
		task.spawn(v_u1.animateFrame)
	end
	v_u6 = arg1
end
local function v_u9(arg1)
	-- upvalues: (ref) v_u8, (copy) v_u1
	if arg1 and v_u8 then
		local v_max = math.max(arg1.Health, 0)
		local v_maxhealth = arg1.MaxHealth
		local v_round = math.round(v_u8.Frame.Bar.Size.X.Scale * v_maxhealth)
		if math.abs(v_max - (tonumber(v_u8.Amount.Text) or 0)) > 1 or math.abs(v_max - v_round) > 1 then
			v_u1.updateFrame(v_max, v_maxhealth)
		end
	end
end
function v_u1.characterAdded(arg1, arg2)
	-- upvalues: (copy) v_u_new, (ref) v_u7, (ref) v_u6, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u9
	v_u_new:Cleanup()
	v_u7 = nil
	local v_u_humanoid = arg1:FindFirstChild("Humanoid")
	if not v_u_humanoid then
		local v1 = tick()
		repeat
			task.wait(0.1)
			v_u_humanoid = arg1:FindFirstChild("Humanoid")
		until v_u_humanoid or tick() - v1 > 5
	end
	if v_u_humanoid then
		v_u6 = v_u_humanoid.MaxHealth
		v_u7 = v_u_humanoid
		v_u1.updateFrame(math.max(v_u_humanoid.Health, 0), v_u_humanoid.MaxHealth)
		if arg2 == v_u_localplayer then
			task.wait(0.1)
			v_u9(v_u_humanoid)
			task.delay(3, function()
				-- upvalues: (ref) v_u_humanoid, (ref) v_u9
				if v_u_humanoid and (v_u_humanoid.Parent and v_u_humanoid.Parent:IsDescendantOf(workspace)) then
					v_u9(v_u_humanoid)
				end
			end)
		end
		v_u_new:Add(v_u_humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			-- upvalues: (ref) v_u1, (ref) v_u_humanoid
			v_u1.updateFrame(math.max(v_u_humanoid.Health, 0), v_u_humanoid.MaxHealth)
		end))
	end
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u8, (copy) v_u_localplayer, (copy) v_u_new, (ref) v_u7, (copy) v_u2, (copy) v_u1
	v_u8 = arg2
	v_u_localplayer.CharacterRemoving:Connect(function()
		-- upvalues: (ref) v_u_new, (ref) v_u7
		v_u_new:Cleanup()
		v_u7 = nil
	end)
	v_u2.CreateListener(v_u_localplayer, "Settings.Game.HUD.Color", function()
		-- upvalues: (ref) v_u7, (ref) v_u1
		if v_u7 then
			v_u1.updateFrame(math.max(v_u7.Health, 0), v_u7.MaxHealth)
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u_new, (ref) v_u7, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u3, (copy) v_u4
	local v_u1 = nil
	local function v_u2(self)
		-- upvalues: (ref) v_u_new, (ref) v_u7, (ref) v_u1, (ref) v_u1, (ref) v_u_localplayer
		v_u_new:Cleanup()
		v_u7 = nil
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
	v_u4.ListenToState(function(_, arg2)
		-- upvalues: (copy) v_u2, (ref) v_u_localplayer
		if arg2 == "Buy Period" or arg2 == "Round In Progress" then
			v_u2(v_u_localplayer)
		end
	end)
end
return v_u1