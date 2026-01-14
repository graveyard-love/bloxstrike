-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Database.Components.GameState)
local v_u3 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u_localplayer = v_u_players.LocalPlayer
local v_u4 = nil
local v_u5 = nil
local v_u6 = nil
local v_u7 = nil
local function v_u8(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_players
	local v_mvp = arg1:FindFirstChild("MVP")
	local v1 = v_mvp and v_mvp:FindFirstChild("Text")
	if v1 then
		v1.Text = arg2
	end
	local v_name = arg1:FindFirstChild("Name")
	if v_name then
		v_name.Text = arg3
	end
	local v_player = arg1:FindFirstChild("Player")
	if v_player then
		local v_player = v_player:FindFirstChild("Player")
		local v2 = v_player and v_u_players:FindFirstChild(arg3)
		if v2 then
			v_player.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(v2.UserId)
		end
	end
end
function v1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u4, (ref) v_u5, (ref) v_u6, (ref) v_u7, (copy) v_u2, (copy) v_u3, (copy) v_u_localplayer, (copy) v_u_players, (copy) v_u8
	v_u4 = arg2
	v_u5 = arg1
	v_u6 = v_u5.Gameplay.Middle:FindFirstChild("PlayerMVPCT")
	v_u7 = v_u5.Gameplay.Middle:FindFirstChild("PlayerMVPT")
	v_u2.ListenToState(function(arg1, arg2)
		-- upvalues: (ref) v_u4, (ref) v_u6, (ref) v_u7
		if arg1 == "Intermission" and arg2 == "Buy Period" or arg2 == "Round In Progress" then
			v_u4.Visible = false
			if v_u6 then
				v_u6.Visible = false
			end
			if v_u7 then
				v_u7.Visible = false
			end
		end
	end)
	v_u3.UI.RoundWinner.Listen(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u4
		local v_team = v_u_localplayer:GetAttribute("Team")
		if arg1 == "Counter-Terrorists" and v_team == arg1 then
			v_u4.Visible = true
		end
	end)
	v_u3.UI.RoundMVP.Listen(function(arg1)
		-- upvalues: (ref) v_u_players, (ref) v_u6, (ref) v_u8, (ref) v_u7
		if arg1 and (arg1.Team and (arg1.PlayerName and arg1.Reason)) then
			local v_team = arg1.Team
			local v_playername = arg1.PlayerName
			local v_reason = arg1.Reason
			if v_team == "Counter-Terrorists" or v_team == "Terrorists" then
				if v_u_players:FindFirstChild(v_playername) then
					local v1 = v_reason == "Rescued a hostage" and "MVP | Rescued a hostage" or (v_reason == "Defused the bomb" and "MVP | Defused the bomb" or (v_reason == "Planted the bomb" and "MVP | Planted the bomb" or (v_reason == "Most eliminations" and "MVP | Most eliminations" or "MVP")))
					if v_team == "Counter-Terrorists" and v_u6 then
						v_u8(v_u6, v1, v_playername)
						v_u6.Visible = true
						if v_u7 then
							v_u7.Visible = false
							return
						end
					elseif v_team == "Terrorists" and v_u7 then
						v_u8(v_u7, v1, v_playername)
						v_u7.Visible = true
						if v_u6 then
							v_u6.Visible = false
						end
					end
				end
			else
				return
			end
		else
			return
		end
	end)
end
return v1