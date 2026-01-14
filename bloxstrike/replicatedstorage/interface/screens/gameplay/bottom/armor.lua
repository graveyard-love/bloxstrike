-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
local v_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Components.Common.GetPreferenceColor)
local v_u3 = require(v_replicatedstorage.Controllers.DataController)
local v_u4 = require(v_replicatedstorage.Controllers.SpectateController)
local v_u5 = require(v_replicatedstorage.Database.Components.GameState)
local v_u6 = require(v_replicatedstorage.Packages.Observers)
local v7 = require(v_replicatedstorage.Shared.Janitor)
local v_u8 = nil
local v_u_new = v7.new()
function v_u1.updateFrame(arg1)
	-- upvalues: (copy) v_u2, (ref) v_u8
	local v1 = v_u2()
	v_u8.Helmet.Visible = arg1.Type == "Kevlar + Helmet"
	local v_round = math.round(arg1.Health)
	v_u8.Amount.Text = tostring(v_round)
	v_u8.Helmet.ImageColor3 = v1
	v_u8.Amount.TextColor3 = v1
	v_u8.Armor.ImageColor3 = v1
end
local function v_u9(arg1)
	-- upvalues: (copy) v_u_new, (copy) v_u6, (ref) v_u8, (copy) v_u1, (copy) v_u_http
	v_u_new:Cleanup()
	v_u_new:Add(v_u6.observeAttribute(arg1, "Armor", function(arg1)
		-- upvalues: (ref) v_u8, (ref) v_u1, (ref) v_u_http
		v_u8.Visible = arg1 and true
		if arg1 then
			v_u1.updateFrame(v_u_http:JSONDecode(arg1))
		end
	end))
	local v_armor = arg1:GetAttribute("Armor")
	if v_armor then
		v_u8.Visible = true
		v_u1.updateFrame(v_u_http:JSONDecode(v_armor))
	else
		v_u8.Visible = false
	end
end
function v_u1.Initialize(_, arg2)
	-- upvalues: (ref) v_u8, (copy) v_u_localplayer, (copy) v_u9, (copy) v_u3, (copy) v_u1, (copy) v_u_http
	v_u8 = arg2
	v_u_localplayer.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u9, (ref) v_u_localplayer
		v_u9(v_u_localplayer)
	end)
	v_u3.CreateListener(v_u_localplayer, "Settings.Game.HUD.Color", function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u1, (ref) v_u_http
		local v_armor = v_u_localplayer:GetAttribute("Armor")
		if v_armor then
			v_u1.updateFrame(v_u_http:JSONDecode(v_armor))
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u_new, (copy) v_u9, (copy) v_u_localplayer, (copy) v_u4, (copy) v_u5
	v_u_localplayer.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u_new, (ref) v_u9
		v_u_new:Cleanup()
		v_u9(v_u_localplayer)
	end)
	v_u4.ListenToSpectate:Connect(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u_new, (ref) v_u9
		if v_u_localplayer:GetAttribute("IsSpectating") and arg1 then
			v_u_new:Cleanup()
			v_u9(arg1)
		end
	end)
	v_u_localplayer:GetAttributeChangedSignal("IsSpectating"):Connect(function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u4, (ref) v_u_new, (ref) v_u9
		if v_u_localplayer:GetAttribute("IsSpectating") then
			local v_getplayer = v_u4.GetPlayer()
			if v_getplayer then
				v_u_new:Cleanup()
				v_u9(v_getplayer)
			end
		else
			v_u_new:Cleanup()
			v_u9(v_u_localplayer)
		end
	end)
	if v_u_localplayer:GetAttribute("IsSpectating") then
		local v_getplayer = v_u4.GetPlayer()
		if v_getplayer then
			v_u_new:Cleanup()
			v_u9(v_getplayer)
		end
	else
		v_u_new:Cleanup()
		v_u9(v_u_localplayer)
	end
	v_u5.ListenToState(function(_, arg2)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u_new, (ref) v_u9
		if arg2 == "Buy Period" or arg2 == "Round In Progress" then
			v_u_new:Cleanup()
			v_u9(v_u_localplayer)
		end
	end)
end
return v_u1