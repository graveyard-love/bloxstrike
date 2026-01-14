-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u3 = require(v_replicatedstorage.Database.Security.Router)
local v_u4 = require(v_replicatedstorage.Database.Components.GameState)
local v_u5 = require(v_replicatedstorage.Shared.Janitor)
local v_u6 = require(v_replicatedstorage.Packages.Signal)
local v_u7 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u_localplayer = v_players.LocalPlayer
local v_u_fromrgb = Color3.fromRGB(219, 159, 47)
local v_u_fromrgb = Color3.fromRGB(43, 172, 43)
local v_u_fromrgb = Color3.fromRGB(182, 45, 45)
local v_u8 = nil
local v_u9 = nil
function v_u1.InitializeProgressBar(arg1)
	-- upvalues: (copy) v_u_fromrgb
	if arg1.Frame and arg1.Frame.ProgressBar then
		local v_progressbar = arg1.Frame.ProgressBar
		local v_leftgradient = v_progressbar:FindFirstChild("LeftGradient")
		local v_rightgradient = v_progressbar:FindFirstChild("RightGradient")
		local v_progressbarimage = v_leftgradient:FindFirstChild("ProgressBarImage")
		local v_progressbarimage = v_rightgradient:FindFirstChild("ProgressBarImage")
		local v_uigradient = v_progressbarimage:FindFirstChild("UIGradient")
		local v_uigradient = v_progressbarimage:FindFirstChild("UIGradient")
		arg1.LeftProgressImage = v_progressbarimage
		arg1.RightProgressImage = v_progressbarimage
		arg1.LeftGradient = v_uigradient
		arg1.RightGradient = v_uigradient
		v_progressbarimage.ImageColor3 = v_u_fromrgb
		v_progressbarimage.ImageColor3 = v_u_fromrgb
		v_progressbarimage.ImageTransparency = 0
		v_progressbarimage.ImageTransparency = 0
		v_leftgradient.Visible = true
		v_rightgradient.Visible = true
		v_progressbarimage.Visible = true
		v_progressbarimage.Visible = true
		v_uigradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(0.501, 1),
			NumberSequenceKeypoint.new(1, 1)
		})
		v_uigradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(0.501, 1),
			NumberSequenceKeypoint.new(1, 1)
		})
		v_uigradient.Rotation = 0
		v_uigradient.Rotation = 0
	else
		warn("RescueHostage: Frame or ProgressBar not found")
	end
end
function v_u1.UpdateProgressBar(arg1, arg2)
	-- upvalues: (copy) v_u_fromrgb, (copy) v_u_fromrgb, (copy) v_u_fromrgb
	if arg1.Frame and arg1.Frame.ProgressBar then
		if arg1.LeftGradient and arg1.RightGradient then
			if arg1.LeftProgressImage and arg1.RightProgressImage then
				local v_clamp = math.clamp(arg2, 0, 1)
				local v_clamp = math.clamp(v_clamp, 0, 1)
				local v1
				if v_clamp <= 0.5 then
					v1 = v_u_fromrgb:Lerp(v_u_fromrgb, v_clamp * 2)
				else
					v1 = v_u_fromrgb:Lerp(v_u_fromrgb, (v_clamp - 0.5) * 2)
				end
				arg1.LeftProgressImage.ImageColor3 = v1
				arg1.RightProgressImage.ImageColor3 = v1
				local v2 = v_clamp * 180
				arg1.RightGradient.Rotation = 360 - v2
				arg1.LeftGradient.Rotation = v2 + 180
				arg1:AnimateRescue(v_clamp)
				if arg1.Frame.UIGradient then
					local v_clamp = math.clamp(v_clamp, 0, 1)
					local v3
					if v_clamp <= 0.5 then
						v3 = v_u_fromrgb:Lerp(v_u_fromrgb, v_clamp * 2)
					else
						v3 = v_u_fromrgb:Lerp(v_u_fromrgb, (v_clamp - 0.5) * 2)
					end
					local v_lerp = v3:Lerp(Color3.new(0, 0, 0), 0.3)
					arg1.Frame.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v3), ColorSequenceKeypoint.new(1, v_lerp) })
				end
				local v_clamp = math.clamp(v_clamp, 0, 1)
				local v4
				if v_clamp <= 0.5 then
					v4 = v_u_fromrgb:Lerp(v_u_fromrgb, v_clamp * 2)
				else
					v4 = v_u_fromrgb:Lerp(v_u_fromrgb, (v_clamp - 0.5) * 2)
				end
				local v_lerp = v4:Lerp(Color3.new(0, 0, 0), 0.2)
				if arg1.Frame.Frame1 then
					arg1.Frame.Frame1.BackgroundColor3 = v_lerp
				end
				if arg1.Frame.Frame2 then
					arg1.Frame.Frame2.BackgroundColor3 = v_lerp
				end
			end
		else
			return
		end
	else
		return
	end
end
function v_u1.AnimateRescue(arg1, arg2)
	if arg1.Frame and arg1.Frame.ProgressBar then
		local v_hostage = arg1.Frame.ProgressBar:FindFirstChild("Hostage")
		if v_hostage then
			local v_sin = math.sin(tick() * (arg2 * 0.5 + 0.5) * 3.141592653589793 * 2)
			local v_new = Vector2.new(0.85, 0.85)
			local v1 = v_sin * 0.05 + 1
			local v_new = UDim2.new(v_new.X * v1, 0, v_new.Y * v1, 0)
			local v_lerp = Color3.fromRGB(255, 200, 0):Lerp(Color3.fromRGB(255, 255, 255), (v_sin + 1) / 2)
			v_hostage.Size = v_new
			v_hostage.ImageColor3 = v_lerp
		end
	else
		return
	end
end
function v_u1.UpdateTimer(arg1, arg2)
	if arg1.Frame and arg1.Frame.Timer then
		local v_floor = math.floor(arg2 / 60)
		local v_floor = math.floor(arg2 % 60)
		local v_floor = math.floor((UNNAMED_1728996528568 - v_floor) * 1000)
		arg1.Frame.Timer.Text = string.format("%02d:%02d.%03d", v_floor, v_floor, v_floor)
		arg1.Frame.Timer.TextStrokeColor3 = Color3.new(0, 0, 0)
		arg1.Frame.Timer.TextColor3 = Color3.new(1, 1, 1)
		arg1.Frame.Timer.TextStrokeTransparency = 0
	end
end
function v_u1.UpdateTitle(arg1)
	if arg1.Frame and arg1.Frame.Title then
		arg1.Frame.Title.Text = string.format("%s is rescuing the hostage %s a kit.", arg1.PlayerName, arg1.HasRescueKit and "with" or "without")
		arg1.Frame.Title.TextStrokeColor3 = Color3.new(0, 0, 0)
		arg1.Frame.Title.TextColor3 = Color3.new(1, 1, 1)
		arg1.Frame.Title.TextStrokeTransparency = 0
	end
end
function v_u1.StartRescue(arg1, arg2)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u7, (copy) v_u_run, (copy) v_u2
	if not arg1.IsRescuing then
		local v_isspectating = v_u_localplayer:GetAttribute("IsSpectating")
		local v_getcurrentspectateinstance = v_u7.GetCurrentSpectateInstance()
		local v1 = arg2 or (v_isspectating and (v_getcurrentspectateinstance and v_getcurrentspectateinstance.Player) or v_u_localplayer)
		arg1.HasRescueKit = v1:GetAttribute("HasRescueKit")
		arg1.PlayerName = v1.Name
		arg1.RescueTime = arg1.HasRescueKit and 1 or 4
		local v_rescuestarttime = v1:GetAttribute("RescueStartTime")
		if v_rescuestarttime and (v_isspectating or v1 ~= v_u_localplayer) then
			local v2 = tick()
			if v_rescuestarttime <= v2 and v2 - v_rescuestarttime <= arg1.RescueTime then
				arg1.RescueStartTime = v_rescuestarttime
			else
				arg1.RescueStartTime = v2
			end
		else
			arg1.RescueStartTime = tick()
		end
		arg1.RescueProgress = 0
		arg1.IsRescuing = true
		if arg1.Frame then
			arg1.Frame.Visible = true
		end
		arg1:UpdateProgressBar(0)
		arg1:UpdateTimer(arg1.RescueTime)
		arg1:UpdateTitle()
		arg1.Janitor:Add(v_u_run.Heartbeat:Connect(function()
			-- upvalues: (copy) arg1, (ref) v_u_localplayer, (ref) v_u7
			if arg1.IsRescuing and not arg1.IsFinished then
				local v_isspectating = v_u_localplayer:GetAttribute("IsSpectating")
				local v_getcurrentspectateinstance = v_u7.GetCurrentSpectateInstance()
				if v_isspectating then
					if v_getcurrentspectateinstance then
						v_isspectating = arg1.PlayerName ~= v_u_localplayer.Name
					else
						v_isspectating = v_getcurrentspectateinstance
					end
				end
				if v_isspectating and v_getcurrentspectateinstance then
					local v_player = v_getcurrentspectateinstance.Player
					if not v_player:GetAttribute("IsRescuingHostage") then
						if arg1.RescueProgress >= 0.95 then
							arg1:FinishRescue()
						else
							arg1:CancelRescue()
						end
					end
					local v_rescuestarttime = v_player:GetAttribute("RescueStartTime")
					if v_rescuestarttime then
						local v1 = tick()
						if v_rescuestarttime < arg1.RescueStartTime and (v_rescuestarttime <= v1 and v1 - v_rescuestarttime <= arg1.RescueTime) then
							arg1.RescueStartTime = v_rescuestarttime
						end
					end
				end
				local v2 = tick() - arg1.RescueStartTime
				arg1.RescueProgress = math.min(v2 / arg1.RescueTime, 1)
				local v_max = math.max(arg1.RescueTime - v2, 0)
				arg1:UpdateProgressBar(arg1.RescueProgress)
				arg1:UpdateTimer(v_max)
				if arg1.RescueProgress >= 1 and not (arg1.IsFinished or v_isspectating) then
					arg1:FinishRescue()
				end
			else
				return
			end
		end), "Disconnect", "ProgressConnection")
		if not v_isspectating or v1 == v_u_localplayer then
			v_u2.Hostage.StartRescue.Send()
		end
		arg1.RescueStarted:Fire()
	end
end
function v_u1.CancelRescue(self)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u7, (copy) v_u2
	if self.IsRescuing then
		local v_isspectating = v_u_localplayer:GetAttribute("IsSpectating")
		local v_getcurrentspectateinstance = v_u7.GetCurrentSpectateInstance()
		if v_isspectating then
			if v_getcurrentspectateinstance then
				v_getcurrentspectateinstance = self.PlayerName ~= v_u_localplayer.Name
			end
		else
			v_getcurrentspectateinstance = v_isspectating
		end
		self.IsRescuing = false
		self.IsFinished = true
		self:UpdateProgressBar(0)
		if self.Frame then
			self.Frame.Visible = false
		end
		if not v_getcurrentspectateinstance then
			v_u2.Hostage.CancelRescue.Send()
		end
		self.RescueCancelled:Fire()
		task.defer(function()
			-- upvalues: (copy) self
			self:Destroy()
		end)
	end
end
function v_u1.FinishRescue(self)
	-- upvalues: (copy) v_u_localplayer, (copy) v_u7, (copy) v_u2
	if self.IsRescuing and not self.IsFinished then
		local v_isspectating = v_u_localplayer:GetAttribute("IsSpectating")
		local v_getcurrentspectateinstance = v_u7.GetCurrentSpectateInstance()
		if v_isspectating then
			if v_getcurrentspectateinstance then
				v_getcurrentspectateinstance = self.PlayerName ~= v_u_localplayer.Name
			end
		else
			v_getcurrentspectateinstance = v_isspectating
		end
		self.IsFinished = true
		self.IsRescuing = false
		if not v_getcurrentspectateinstance then
			v_u2.Hostage.PickedUp.Send()
		end
		self.RescueFinished:Fire()
		task.delay(0.5, function()
			-- upvalues: (copy) self
			self:Destroy()
		end)
	end
end
function v_u1.new(arg1)
	-- upvalues: (copy) v_u1, (copy) v_u5, (copy) v_u6
	local v1 = setmetatable({}, v_u1)
	v1.Janitor = v_u5.new()
	v1.Frame = arg1
	v1.RightProgressImage = nil
	v1.LeftProgressImage = nil
	v1.RightGradient = nil
	v1.LeftGradient = nil
	v1.RescueTime = 4
	v1.HasRescueKit = false
	v1.RescueStartTime = 0
	v1.RescueProgress = 0
	v1.IsRescuing = false
	v1.IsFinished = false
	v1.PlayerName = ""
	v1.RescueCancelled = v1.Janitor:Add(v_u6.new())
	v1.RescueFinished = v1.Janitor:Add(v_u6.new())
	v1.RescueStarted = v1.Janitor:Add(v_u6.new())
	if v1.Frame then
		v1.Frame.Visible = false
	end
	v1:InitializeProgressBar()
	return v1
end
function v_u1.Destroy(arg1)
	-- upvalues: (ref) v_u9
	if v_u9 == arg1 then
		v_u9 = nil
	end
	if arg1.Frame then
		arg1.Frame.Visible = false
	end
	arg1.Janitor:Destroy()
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u8, (copy) v_u4, (ref) v_u9, (copy) v_u3, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u7
	v_u8 = arg2
	v_u4.ListenToState(function(_, arg2)
		-- upvalues: (ref) v_u9
		if (arg2 == "Buy Period" or arg2 == "Warmup") and v_u9 then
			v_u9:Destroy()
			v_u9 = nil
		end
	end)
	v_u3.observerRouter("Start Rescue Hostage", function()
		-- upvalues: (ref) v_u9, (ref) v_u1, (ref) v_u8
		if not v_u9 then
			v_u9 = v_u1.new(v_u8)
		end
		if v_u9 then
			v_u9:StartRescue()
		end
		return nil
	end)
	v_u3.observerRouter("Cancel Rescue Hostage", function()
		-- upvalues: (ref) v_u9
		if v_u9 then
			v_u9:CancelRescue()
			v_u9 = nil
		end
		return nil
	end)
	local v_u1 = nil
	local function v_u2()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u7, (ref) v_u9, (ref) v_u1, (ref) v_u8
		local v_isspectating = v_u_localplayer:GetAttribute("IsSpectating")
		local v_getcurrentspectateinstance = v_u7.GetCurrentSpectateInstance()
		if v_isspectating and v_getcurrentspectateinstance then
			local v_player = v_getcurrentspectateinstance.Player
			if v_player:GetAttribute("IsRescuingHostage") then
				if not v_u9 then
					v_u9 = v_u1.new(v_u8)
				end
				if v_u9 then
					v_u9:StartRescue(v_player)
					return
				end
			elseif v_u9 then
				v_u9:CancelRescue()
				v_u9 = nil
				return
			end
		elseif v_u9 and not v_u_localplayer:GetAttribute("IsRescuingHostage") then
			v_u9:CancelRescue()
			v_u9 = nil
		end
	end
	v_u_localplayer:GetAttributeChangedSignal("IsSpectating"):Connect(function()
		-- upvalues: (copy) v_u2
		v_u2()
	end)
	local function v_u3()
		-- upvalues: (ref) v_u1, (ref) v_u7, (copy) v_u2
		if v_u1 then
			v_u1:Disconnect()
			v_u1 = nil
		end
		local v_getcurrentspectateinstance = v_u7.GetCurrentSpectateInstance()
		if v_getcurrentspectateinstance then
			v_u1 = v_getcurrentspectateinstance.Player:GetAttributeChangedSignal("IsRescuingHostage"):Connect(function()
				-- upvalues: (ref) v_u2
				v_u2()
			end)
			v_u2()
		end
	end
	v_u7.ListenToSpectate:Connect(function(_)
		-- upvalues: (copy) v_u3
		v_u3()
	end)
	task.wait(0.1)
	v_u3()
end
return v_u1