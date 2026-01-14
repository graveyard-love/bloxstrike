-- Decompiled with Bunni.lol Decompiler

local v_u_players = game:GetService("Players")
local v_run = game:GetService("RunService")
local v_u1 = require(script.Parent.Parent.process.client)
local v_u2 = require(script.Parent.Parent.process.server)
require(script.Parent.Parent.types)
local v_u3 = v_run:IsServer() and "server" or "client"
return function(arg1, arg2)
	-- upvalues: (copy) v_u2, (copy) v_u1, (copy) v_u3, (copy) v_u_players
	local v1 = arg1.ReliabilityType or "Reliable"
	local v_u2 = {}
	local v_u3
	if v1 == "Reliable" then
		v_u3 = v_u2.sendPlayerReliable
	else
		v_u3 = v_u2.sendPlayerUnreliable
	end
	local v_u4
	if v1 == "Reliable" then
		v_u4 = v_u2.sendAllReliable
	else
		v_u4 = v_u2.sendAllUnreliable
	end
	local v_u5
	if v1 == "Reliable" then
		v_u5 = v_u1.sendReliable
	else
		v_u5 = v_u1.sendUnreliable
	end
	local v_u_write = arg1.Value.Write
	local v6 = {}
	setmetatable(v6, {
		["__index"] = function(arg1)
			-- upvalues: (ref) v_u3
			if (arg1 == "SendTo" or (arg1 == "SendToAllExcept" or arg1 == "SendToAll")) and v_u3 == "client" then
				error("You cannot use SendTo, SendToAllExcept, or SendToAll on the client")
			elseif arg1 == "Send" and v_u3 == "server" then
				error("You cannot use Send on the server")
			end
		end
	})
	v6.Reader = arg1.Value.Read
	v6.reader = arg1.Value.Read
	if v_u3 == "server" then
		function v6.SendToList(arg1, arg2)
			-- upvalues: (copy) v_u3, (copy) arg2, (copy) v_u_write
			for _, v1 in arg2 do
				v_u3(v1, arg2, v_u_write, arg1)
			end
		end
		function v6.SendTo(arg1, arg2)
			-- upvalues: (copy) v_u3, (copy) arg2, (copy) v_u_write
			v_u3(arg2, arg2, v_u_write, arg1)
		end
		function v6.SendToAllExcept(arg1, arg2)
			-- upvalues: (ref) v_u_players, (copy) v_u3, (copy) arg2, (copy) v_u_write
			for _, v1 in v_u_players:GetPlayers() do
				if v1 ~= arg2 then
					v_u3(v1, arg2, v_u_write, arg1)
				end
			end
		end
		function v6.SendToAll(arg1)
			-- upvalues: (copy) v_u4, (copy) arg2, (copy) v_u_write
			v_u4(arg2, v_u_write, arg1)
		end
	elseif v_u3 == "client" then
		function v6.Send(arg1)
			-- upvalues: (copy) v_u5, (copy) arg2, (copy) v_u_write
			v_u5(arg2, v_u_write, arg1)
		end
	end
	function v6.Wait()
		-- upvalues: (copy) v_u2
		local v_u1 = nil
		local v_u_running = coroutine.running()
		local function v2(arg1, arg2)
			-- upvalues: (copy) v_u_running, (ref) v_u2, (ref) v_u1
			task.spawn(v_u_running, arg1, arg2)
			table.remove(v_u2, v_u1)
		end
		table.insert(v_u2, v2)
		v_u1 = #v_u2
		return coroutine.yield()
	end
	function v6.Listen(self)
		-- upvalues: (copy) v_u2
		table.insert(v_u2, self)
		return function()
			-- upvalues: (ref) v_u2, (copy) self
			local v_find = table.find(v_u2, self)
			if v_find then
				table.remove(v_u2, v_find)
			end
		end
	end
	v6.Connect = v6.Listen
	function v6.GetListeners()
		-- upvalues: (copy) v_u2
		return v_u2
	end
	return v6
end