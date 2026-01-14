-- Decompiled with Bunni.lol Decompiler

local v_u_players = game:GetService("Players")
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_run = game:GetService("RunService")
local v1 = require(script.Parent.bufferWriter)
local v_u2 = require(script.Parent.read)
require(script.Parent.Parent.types)
local v_u_writepacket = v1.writePacket
local v_u3 = {}
local v_u4 = {}
local v_u_create = buffer.create
local function v_u5()
	-- upvalues: (copy) v_u_create
	return {
		["cursor"] = 0,
		["size"] = 256,
		["references"] = {},
		["buff"] = v_u_create(256)
	}
end
local v_u6 = v_u5()
local v_u7 = v_u5()
local function v_u8(arg1, arg2, arg3)
	-- upvalues: (copy) v_u2
	if type(arg2) == "buffer" then
		v_u2(arg2, arg3, arg1)
	end
end
local function v_u9(arg1)
	-- upvalues: (copy) v_u3, (copy) v_u5, (copy) v_u4
	if not v_u3[arg1] then
		v_u3[arg1] = v_u5()
	end
	if not v_u4[arg1] then
		v_u4[arg1] = v_u5()
	end
end
return {
	["sendAllReliable"] = function(arg1, arg2, arg3)
		-- upvalues: (ref) v_u6, (copy) v_u_writepacket
		v_u6 = v_u_writepacket(v_u6, arg1, arg2, arg3)
	end,
	["sendAllUnreliable"] = function(arg1, arg2, arg3)
		-- upvalues: (ref) v_u7, (copy) v_u_writepacket
		v_u7 = v_u_writepacket(v_u7, arg1, arg2, arg3)
	end,
	["sendPlayerReliable"] = function(arg1, arg2, arg3, arg4)
		-- upvalues: (copy) v_u3, (copy) v_u_writepacket
		v_u3[arg1] = v_u_writepacket(v_u3[arg1], arg2, arg3, arg4)
	end,
	["sendPlayerUnreliable"] = function(arg1, arg2, arg3, arg4)
		-- upvalues: (copy) v_u4, (copy) v_u_writepacket
		v_u4[arg1] = v_u_writepacket(v_u4[arg1], arg2, arg3, arg4)
	end,
	["start"] = function()
		-- upvalues: (copy) v_u8, (copy) v_u_replicatedstorage, (copy) v_u_players, (copy) v_u3, (copy) v_u5, (copy) v_u4, (copy) v_u9, (copy) v_u_run, (ref) v_u6, (copy) v_u_create, (ref) v_u7
		local v_u_remoteevent = Instance.new("RemoteEvent")
		v_u_remoteevent.Name = "ByteNetReliable"
		v_u_remoteevent.OnServerEvent:Connect(v_u8)
		v_u_remoteevent.Parent = v_u_replicatedstorage
		local v_u_new = Instance.new("UnreliableRemoteEvent")
		v_u_new.Name = "ByteNetUnreliable"
		v_u_new.OnServerEvent:Connect(v_u8)
		v_u_new.Parent = v_u_replicatedstorage
		for _, v1 in v_u_players:GetPlayers() do
			if not v_u3[v1] then
				v_u3[v1] = v_u5()
			end
			if not v_u4[v1] then
				v_u4[v1] = v_u5()
			end
		end
		v_u_players.PlayerAdded:Connect(v_u9)
		v_u_run.PostSimulation:Connect(function()
			-- upvalues: (ref) v_u6, (ref) v_u_create, (copy) v_u_remoteevent, (ref) v_u7, (copy) v_u_new, (ref) v_u_players, (ref) v_u3, (ref) v_u4
			if v_u6.cursor > 0 then
				local v1 = v_u6
				local v_cursor = v1.cursor
				local v2 = v_u_create(v_cursor)
				buffer.copy(v2, 0, v1.buff, 0, v_cursor)
				local v3
				if #v1.references > 0 then
					v3 = v1.references
				else
					v3 = nil
				end
				v_u_remoteevent:FireAllClients(v2, v3)
				v_u6.cursor = 0
				table.clear(v_u6.references)
			end
			if v_u7.cursor > 0 then
				local v4 = v_u7
				local v_cursor = v4.cursor
				local v5 = v_u_create(v_cursor)
				buffer.copy(v5, 0, v4.buff, 0, v_cursor)
				local v6
				if #v4.references > 0 then
					v6 = v4.references
				else
					v6 = nil
				end
				v_u_new:FireAllClients(v5, v6)
				v_u7.cursor = 0
				table.clear(v_u7.references)
			end
			for _, v7 in v_u_players:GetPlayers() do
				if v_u3[v7].cursor > 0 then
					local v8 = v_u3[v7]
					local v_cursor = v8.cursor
					local v9 = v_u_create(v_cursor)
					buffer.copy(v9, 0, v8.buff, 0, v_cursor)
					local v10
					if #v8.references > 0 then
						v10 = v8.references
					else
						v10 = nil
					end
					v_u_remoteevent:FireClient(v7, v9, v10)
					v_u3[v7].cursor = 0
					table.clear(v_u3[v7].references)
				end
				if v_u4[v7].cursor > 0 then
					local v11 = v_u4[v7]
					local v_cursor = v11.cursor
					local v12 = v_u_create(v_cursor)
					buffer.copy(v12, 0, v11.buff, 0, v_cursor)
					local v13
					if #v11.references > 0 then
						v13 = v11.references
					else
						v13 = nil
					end
					v_u_new:FireClient(v7, v12, v13)
					v_u4[v7].cursor = 0
					table.clear(v_u4[v7].references)
				end
			end
		end)
	end
}