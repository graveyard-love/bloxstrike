-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
local v_u_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
local v_u2 = require(v_replicatedstorage.Database.Components.Libraries.Stock)
local v_u3 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u4 = require(v_replicatedstorage.Shared.Promise)
local v_u5 = {}
local v_u6 = {}
local function v_u7(arg1)
	local v1 = {}
	local v2 = ""
	for v3, v4 in ipairs(arg1) do
		if v3 <= 1 then
			v2 = v4
		elseif v3 > 1 then
			v2 = ("%*.%*"):format(v2, v4)
		end
		table.insert(v1, v2)
	end
	return v1
end
local function v_u8(arg1, arg2)
	-- upvalues: (copy) v_u7, (copy) v_u6, (copy) v_u1, (copy) v_u4
	local v1 = v_u7(arg2)
	for _, v2 in ipairs(v1) do
		local v3 = v_u6[arg1]
		if v3 then
			local v4 = v3[v2]
			if v4 then
				local v_get = v_u1.Get(arg1, v2)
				for _, v5 in pairs(v4) do
					v_u4.try(v5, v_get)
				end
			end
		end
	end
end
function v_u1.WaitForDataLoaded(arg1)
	-- upvalues: (copy) v_u5
	local v1 = 0
	while not v_u5[arg1] do
		v1 = v1 + task.wait()
		if v1 >= 60 then
			error((("[DataController] Failed to load player profile for %* after 5 seconds"):format(arg1.Name)))
		end
	end
	return v_u5[arg1]
end
function v_u1.Get(arg1, ...)
	-- upvalues: (copy) v_u5
	local v1 = v_u5[arg1]
	if not v1 then
		return nil
	end
	local v2 = {}
	for _, v3 in table.pack(...) do
		local v4 = v1
		for _, v5 in string.split(v3, ".") do
			v1 = v1[v5]
			if not v1 then
				break
			end
		end
		table.insert(v2, v1)
		v1 = v4
	end
	return table.unpack(v2)
end
function v_u1.RemoveListener(arg1, arg2, arg3)
	-- upvalues: (copy) v_u6
	if v_u6[arg1] and v_u6[arg1][arg2] then
		v_u6[arg1][arg2][arg3] = nil
		if next(v_u6[arg1][arg2]) == nil then
			v_u6[arg1][arg2] = nil
		end
	end
end
function v_u1.CreateListener(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_http, (copy) v_u6, (copy) v_u1, (copy) v_u4
	local v_generateguid = v_u_http:GenerateGUID(false)
	v_u6[arg1] = v_u6[arg1] or {}
	v_u6[arg1][arg2] = v_u6[arg1][arg2] or {}
	v_u6[arg1][arg2][v_generateguid] = arg3
	local v_get = v_u1.Get(arg1, arg2)
	if v_get then
		v_u4.try(arg3, v_get)
	end
	return v_generateguid
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u3, (copy) v_u6, (copy) v_u2, (copy) v_u5, (copy) v_u1, (copy) v_u4, (copy) v_u8
	v_u3.PlayerData.PlayerDataEvent.Listen(function(arg1)
		-- upvalues: (ref) v_u6, (ref) v_u2, (ref) v_u5, (ref) v_u1, (ref) v_u4
		local v1 = v_u6[arg1.Player]
		if arg1.Data and arg1.Data.Inventory then
			v_u2.InjectStockItems(arg1.Data.Inventory)
		end
		v_u5[arg1.Player] = arg1.Data
		if v1 then
			for v2, v3 in pairs(v1) do
				local v_get = v_u1.Get(arg1.Player, v2)
				for _, v4 in pairs(v3) do
					v_u4.try(v4, v_get)
				end
			end
		end
	end)
	v_u3.PlayerData.PlayerDataChanged.Listen(function(arg1)
		-- upvalues: (ref) v_u5, (ref) v_u8
		local v_player = arg1.Player
		local v1 = v_u5[v_player]
		if not v1 then
			warn((("[DataController] Received data change for %* but profile not loaded yet. Requesting full profile."):format(v_player.Name)))
			return
		end
		for v2, v3 in pairs(arg1.Data) do
			local v_split = string.split(v2, ".")
			local v4 = v1
			for v5 = 1, #v_split - 1 do
				v1 = v1[v_split[v5]]
				if not v1 then
					warn((("[DataController] Failed to update %*\'s data at path %*: intermediate path not found"):format(v_player.Name, v2)))
					break
				end
			end
			if v1 then
				v1[v_split[#v_split]] = v3
				v_u8(v_player, v_split)
				v1 = v4
			else
				v1 = v4
			end
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u3, (copy) v_u_players, (copy) v_u5, (copy) v_u8, (copy) v_u6
	v_u3.PlayerData.RetrieveAllPlayerData.Send()
	v_u3.Store.NewInventoryItem.Listen(function(arg1)
		-- upvalues: (ref) v_u_players, (ref) v_u5, (ref) v_u8
		local v1 = tonumber(arg1.Player)
		if v1 then
			local v_getplayerbyuserid = v_u_players:GetPlayerByUserId(v1)
			if v_getplayerbyuserid and v_getplayerbyuserid:IsDescendantOf(v_u_players) then
				local v2 = v_u5[v_getplayerbyuserid]
				if v2 and v2.Inventory then
					local v3 = {}
					for _, v4 in ipairs(v2.Inventory) do
						if v4 and v4._id then
							v3[v4._id] = true
						end
					end
					for _, v5 in ipairs(arg1.Items) do
						if v5 and (v5._id and not v3[v5._id]) then
							table.insert(v2.Inventory, v5)
							v3[v5._id] = true
						end
					end
					v_u8(v_getplayerbyuserid, { "Inventory" })
					return
				end
			end
		end
	end)
	v_u_players.PlayerRemoving:Connect(function(arg1)
		-- upvalues: (ref) v_u6, (ref) v_u5
		v_u6[arg1] = nil
		v_u5[arg1] = nil
	end)
end
return v_u1