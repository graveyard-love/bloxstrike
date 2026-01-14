-- Decompiled with Bunni.lol Decompiler

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v1 = require(script.Parent.bufferWriter)
local v_u2 = require(script.Parent.read)
require(script.Parent.Parent.types)
local v_u_writepacket = v1.writePacket
local v_u_create = buffer.create
local function v_u3(arg1, arg2)
	-- upvalues: (copy) v_u2
	v_u2(arg1, arg2)
end
local function v4()
	-- upvalues: (copy) v_u_create
	return {
		["cursor"] = 0,
		["size"] = 256,
		["references"] = {},
		["buff"] = v_u_create(256)
	}
end
local v_u5 = v4()
local v_u6 = v4()
return {
	["sendReliable"] = function(arg1, arg2, arg3)
		-- upvalues: (ref) v_u5, (copy) v_u_writepacket
		v_u5 = v_u_writepacket(v_u5, arg1, arg2, arg3)
	end,
	["sendUnreliable"] = function(arg1, arg2, arg3)
		-- upvalues: (ref) v_u6, (copy) v_u_writepacket
		v_u6 = v_u_writepacket(v_u6, arg1, arg2, arg3)
	end,
	["start"] = function()
		-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u3, (copy) v_u_run, (ref) v_u5, (copy) v_u_create, (ref) v_u6
		local v_u_bytenetreliable = v_u_replicatedstorage:WaitForChild("ByteNetReliable")
		v_u_bytenetreliable.OnClientEvent:Connect(v_u3)
		local v_u_bytenetunreliable = v_u_replicatedstorage:WaitForChild("ByteNetUnreliable")
		v_u_bytenetunreliable.OnClientEvent:Connect(v_u3)
		v_u_run.PostSimulation:Connect(function()
			-- upvalues: (ref) v_u5, (ref) v_u_create, (copy) v_u_bytenetreliable, (ref) v_u6, (copy) v_u_bytenetunreliable
			if v_u5.cursor > 0 then
				local v1 = v_u5
				local v_cursor = v1.cursor
				local v2 = v_u_create(v_cursor)
				buffer.copy(v2, 0, v1.buff, 0, v_cursor)
				local v3
				if #v1.references > 0 then
					v3 = v1.references
				else
					v3 = nil
				end
				v_u_bytenetreliable:FireServer(v2, v3)
				v_u5.cursor = 0
				table.clear(v_u5.references)
			end
			if v_u6.cursor > 0 then
				local v4 = v_u6
				local v_cursor = v4.cursor
				local v5 = v_u_create(v_cursor)
				buffer.copy(v5, 0, v4.buff, 0, v_cursor)
				local v6
				if #v4.references > 0 then
					v6 = v4.references
				else
					v6 = nil
				end
				v_u_bytenetunreliable:FireServer(v5, v6)
				v_u6.cursor = 0
				table.clear(v_u6.references)
			end
		end)
	end
}