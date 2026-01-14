-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Database.Components.GameState)
local v_u3 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u_localplayer = v_players.LocalPlayer
local v_u4 = nil
function v1.Initialize(_, arg2)
	-- upvalues: (ref) v_u4, (copy) v_u2, (copy) v_u3, (copy) v_u_localplayer
	v_u4 = arg2
	v_u2.ListenToState(function(arg1, arg2)
		-- upvalues: (ref) v_u4
		if arg1 == "Intermission" and arg2 == "Buy Period" then
			v_u4.Visible = false
			return
		elseif arg2 == "Round In Progress" then
			v_u4.Visible = false
		end
	end)
	v_u3.UI.RoundWinner.Listen(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u4
		if v_u_localplayer:GetAttribute("Team") ~= arg1 then
			v_u4.Visible = true
		end
	end)
end
return v1