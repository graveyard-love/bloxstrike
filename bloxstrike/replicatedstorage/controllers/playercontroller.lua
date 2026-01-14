-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_userinput = game:GetService("UserInputService")
local v_u_run = game:GetService("RunService")
local v_u2 = tick()
local v_u3 = require(v_replicatedstorage.Database.Security.Remotes)
function v1.Initialize()
	-- upvalues: (copy) v_u_userinput, (ref) v_u2, (copy) v_u3
	v_u_userinput.InputBegan:Connect(function()
		-- upvalues: (ref) v_u2
		v_u2 = tick()
	end)
	v_u_userinput.InputChanged:Connect(function()
		-- upvalues: (ref) v_u2
		v_u2 = tick()
	end)
	v_u3.Player.BlankRequest.Listen(function(arg1)
		-- upvalues: (ref) v_u3
		local v_floor = math.floor((tick() - arg1) * 1000)
		v_u3.Player.ReportPlayerConnect.Send((tostring(v_floor)))
	end)
end
function v1.Start()
	-- upvalues: (copy) v_u_run, (copy) v_u3, (ref) v_u2
	local v_u1 = 0
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u3, (ref) v_u2
		if v_u1 + arg1 >= 5 then
			v_u1 = v_u1 - 5
			local v1 = tick()
			v_u3.Player.BlankRequest.Send(v1)
			if v1 - v_u2 >= 900 then
				v_u3.Player.AFKTeleport.Send()
				v_u2 = v1
				return
			end
		end
	end)
end
return v1