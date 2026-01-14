-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u2 = require(v_replicatedstorage.Database.Custom.Constants)
local v_u3 = require(v_replicatedstorage.Packages.Observers)
local v_u_clock = os.clock()
local v_u4 = {}
local v_u5 = nil
local function v_u6(arg1, arg2)
	-- upvalues: (copy) v_u4, (ref) v_u_clock, (ref) v_u5
	local v_clock = os.clock()
	table.insert(v_u4, arg1)
	if v_clock - v_u_clock >= 1 then
		local v_player = v_u5.Player
		local v1 = 0
		local v2 = "Ping: %*ms, Fps: %*"
		for _, v3 in ipairs(v_u4) do
			v1 = v1 + v3
		end
		local v_round = math.round(v1 / #v_u4)
		v_player.Text = v2:format(arg2, (tostring(v_round)))
		v_u_clock = v_clock
		table.clear(v_u4)
	end
end
function v1.Initialize(_, arg2)
	-- upvalues: (ref) v_u5, (copy) v_u_run, (copy) v_u_localplayer, (copy) v_u6, (copy) v_u3, (copy) v_u2
	v_u5 = arg2
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u5, (ref) v_u_localplayer, (ref) v_u6
		if v_u5.Visible then
			local v_ping = v_u_localplayer:GetAttribute("Ping")
			v_u6(math.round(1 / arg1), tonumber(v_ping) or 999)
		end
	end)
	return v_u3.observeAttribute(workspace, "Timezone", function(arg1)
		-- upvalues: (ref) v_u5, (ref) v_u2
		v_u5.Server.Text = ("Location: %*, Version: %*"):format(arg1, v_u2.VERSION)
		return function()
			-- upvalues: (ref) v_u5, (ref) v_u2
			v_u5.Server.Text = ("Location: Unknown, Version: %*"):format(v_u2.VERSION)
		end
	end)
end
return v1