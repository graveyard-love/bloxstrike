-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u3 = require(v_replicatedstorage.Database.Components.Common.IsInBuyArea)
local v_u4 = require(v_replicatedstorage.Database.Components.GameState)
local v_u5 = require(v_replicatedstorage.Components.Common.GetPreferenceColor)
local v_u6 = require(v_replicatedstorage.Database.Security.Router)
local v_u7 = require(v_replicatedstorage.Packages.Observers)
local v8 = require(v_replicatedstorage.Shared.Janitor)
local v9 = require(v_replicatedstorage.Shared.Spring)
local v_u_new = v8.new()
local v_u_new = v9.new(1, 8, 0)
local v_u10 = nil
function v_u1.CreatePlayerObserver(arg1)
	-- upvalues: (copy) v_u_new, (copy) v_u7, (copy) v_u_new
	v_u_new:Cleanup()
	v_u_new:Add(v_u7.observeAttribute(arg1, "Money", function(arg1)
		-- upvalues: (ref) v_u_new
		v_u_new:setGoal(arg1)
		return function()
			-- upvalues: (ref) v_u_new
			v_u_new:setGoal(0)
		end
	end))
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u10, (copy) v_u_localplayer, (copy) v_u_new
	v_u10 = arg2
	v_u_localplayer.CharacterRemoving:Connect(function()
		-- upvalues: (ref) v_u_new
		v_u_new:Cleanup()
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u_new, (copy) v_u1, (copy) v_u_localplayer, (copy) v_u2, (copy) v_u4, (copy) v_u_run, (copy) v_u_new, (ref) v_u10, (copy) v_u5, (copy) v_u3, (copy) v_u6
	v_u_localplayer.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u_new, (ref) v_u1
		v_u_new:Cleanup()
		v_u1.CreatePlayerObserver(v_u_localplayer)
	end)
	v_u2.ListenToSpectate:Connect(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u_new, (ref) v_u1
		if v_u_localplayer:GetAttribute("IsSpectating") and arg1 then
			v_u_new:Cleanup()
			v_u1.CreatePlayerObserver(arg1)
		end
	end)
	v_u_localplayer:GetAttributeChangedSignal("IsSpectating"):Connect(function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u2, (ref) v_u_new, (ref) v_u1
		if v_u_localplayer:GetAttribute("IsSpectating") then
			local v_getplayer = v_u2.GetPlayer()
			if v_getplayer then
				v_u_new:Cleanup()
				v_u1.CreatePlayerObserver(v_getplayer)
			end
		else
			v_u_new:Cleanup()
			v_u1.CreatePlayerObserver(v_u_localplayer)
		end
	end)
	if v_u_localplayer:GetAttribute("IsSpectating") then
		local v_getplayer = v_u2.GetPlayer()
		if v_getplayer then
			v_u_new:Cleanup()
			v_u1.CreatePlayerObserver(v_getplayer)
		end
	else
		v_u_new:Cleanup()
		v_u1.CreatePlayerObserver(v_u_localplayer)
	end
	v_u4.ListenToState(function(_, arg2)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u_new, (ref) v_u1
		if arg2 == "Buy Period" or arg2 == "Round In Progress" then
			v_u_new:Cleanup()
			v_u1.CreatePlayerObserver(v_u_localplayer)
		end
	end)
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u_new, (ref) v_u10, (ref) v_u5, (ref) v_u_localplayer, (ref) v_u3, (ref) v_u6
		local v_getposition = v_u_new:getPosition()
		local v_round = math.round(v_getposition)
		local v_gsub = tostring(v_round):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
		v_u10.Amount.TextColor3 = v_u5()
		v_u10.Amount.Text = ("$%*"):format(v_gsub)
		v_u_new:update(arg1)
		if v_u_localplayer:GetAttribute("BuyMenu") then
			v_u10.Buy.Visible = v_u3(v_u_localplayer)
			if v_u10.Buy.Visible and not v_u10.Buy.Visible then
				v_u6.broadcastRouter("CreateNotification", "You have left the buy zone", "You have left the buy zone", 2)
			end
		else
			v_u10.Buy.Visible = false
			return
		end
	end)
end
return v_u1