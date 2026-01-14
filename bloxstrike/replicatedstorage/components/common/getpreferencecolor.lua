-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u1 = require(v_replicatedstorage.Controllers.DataController)
local v_u2 = require(v_replicatedstorage.Database.Custom.GameStats.Settings.Colors)
local v_u_counter-terrorists = v_u2["Team Color"]["Counter-Terrorists"]
return function()
	-- upvalues: (copy) v_u1, (copy) v_u_localplayer, (copy) v_u2, (copy) v_u_counter-terrorists
	local v_get = v_u1.Get(v_u_localplayer, "Settings.Game.HUD.Color")
	local v_team = v_u_localplayer:GetAttribute("Team")
	return v_u2[v_get] and v_u2[v_get][v_team] or v_u_counter-terrorists
end