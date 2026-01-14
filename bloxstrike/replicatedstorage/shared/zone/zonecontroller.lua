-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.Janitor)
local v2 = require(script.Parent.Enum)
require(script.Parent.Signal)
local v_u3 = require(script.Tracker)
local v_u4 = require(script.CollectiveWorldModel)
local v_u_enums = v2.enums
local v_u_players = game:GetService("Players")
local v_u5 = {}
local v_u6 = 0
local v_u7 = {}
local v_u8 = {}
local v_u9 = {}
local v_u10 = {}
local v_u11 = {}
local v_u12 = {}
local v_u13 = 0
local v_run = game:GetService("RunService")
local v_u_heartbeat = v_run.Heartbeat
local v_u14 = {}
local v_u_isclient = v_run:IsClient()
if v_u_isclient then
	v_u_isclient = v_u_players.LocalPlayer
end
local v_u15 = {}
local v_u16 = {
	["player"] = v_u3.new("player"),
	["item"] = v_u3.new("item")
}
v_u15.trackers = v_u16
local v_u17 = {
	["player"] = function(arg1)
		-- upvalues: (copy) v_u15, (copy) v_u5, (ref) v_u6
		return v_u15._getZonesAndItems("player", v_u5, v_u6, true, arg1)
	end,
	["localPlayer"] = function(arg1)
		-- upvalues: (copy) v_u_isclient, (copy) v_u15, (copy) v_u16
		local v1 = {}
		local v_character = v_u_isclient.Character
		if not v_character then
			return v1
		end
		local v_gettouchingzones = v_u15.getTouchingZones(v_character, true, arg1, v_u16.player)
		for _, v2 in pairs(v_gettouchingzones) do
			if v2.activeTriggers.localPlayer then
				local v3 = v_u_isclient
				local v4 = v1[v2]
				if not v4 then
					v4 = {}
					v1[v2] = v4
				end
				local v_player = v3:IsA("Player")
				if v_player then
					v_player = v3.Character
				end
				v4[v3] = v_player or true
			end
		end
		return v1
	end,
	["item"] = function(arg1)
		-- upvalues: (copy) v_u15, (copy) v_u5, (ref) v_u6
		return v_u15._getZonesAndItems("item", v_u5, v_u6, true, arg1)
	end
}
function v_u15._registerZone(arg1)
	-- upvalues: (copy) v_u8, (copy) v_u1, (copy) v_u15
	v_u8[arg1] = true
	local v_add = arg1.janitor:add(v_u1.new(), "destroy")
	arg1._registeredJanitor = v_add
	v_add:add(arg1.updated:Connect(function()
		-- upvalues: (ref) v_u15
		v_u15._updateZoneDetails()
	end), "Disconnect")
	v_u15._updateZoneDetails()
end
function v_u15._deregisterZone(arg1)
	-- upvalues: (copy) v_u8, (copy) v_u15
	v_u8[arg1] = nil
	arg1._registeredJanitor:destroy()
	arg1._registeredJanitor = nil
	v_u15._updateZoneDetails()
end
function v_u15._registerConnection(arg1, arg2)
	-- upvalues: (ref) v_u13, (copy) v_u5, (copy) v_u15, (copy) v_u7, (copy) v_u17
	local v1 = 0
	for _, _ in pairs(arg1.activeTriggers) do
		v1 = v1 + 1
	end
	v_u13 = v_u13 + 1
	if v1 == 0 then
		v_u5[arg1] = true
		v_u15._updateZoneDetails()
	end
	local v2 = v_u7[arg2]
	v_u7[arg2] = v2 and v2 + 1 or 1
	arg1.activeTriggers[arg2] = true
	if arg1.touchedConnectionActions[arg2] then
		arg1:_formTouchedConnection(arg2)
	end
	if v_u17[arg2] then
		v_u15._formHeartbeat(arg2)
	end
end
function v_u15.updateDetection(arg1)
	-- upvalues: (copy) v_u3, (copy) v_u_enums
	for v1, v2 in pairs({
		["enterDetection"] = "_currentEnterDetection",
		["exitDetection"] = "_currentExitDetection"
	}) do
		local v3 = arg1[v1]
		local v_getcombinedtotalvolumes = v_u3.getCombinedTotalVolumes()
		if v3 == v_u_enums.Detection.Automatic then
			if v_getcombinedtotalvolumes > 729000 then
				v3 = v_u_enums.Detection.Centre
			else
				v3 = v_u_enums.Detection.WholeBody
			end
		end
		arg1[v2] = v3
	end
end
function v_u15._formHeartbeat(self)
	-- upvalues: (copy) v_u14, (copy) v_u_heartbeat, (copy) v_u5, (copy) v_u15, (copy) v_u17, (copy) v_u_enums
	if not v_u14[self] then
		local v_u1 = 0
		v_u14[self] = v_u_heartbeat:Connect(function()
			-- upvalues: (ref) v_u1, (ref) v_u5, (copy) self, (ref) v_u15, (ref) v_u17, (ref) v_u_enums
			local v_clock = os.clock()
			if v_u1 <= v_clock then
				local v1 = nil
				local v2 = nil
				for v3, _ in pairs(v_u5) do
					if v3.activeTriggers[self] then
						local v_accuracy = v3.accuracy
						if v1 ~= nil and v_accuracy >= v1 then
							v_accuracy = v1
						end
						v_u15.updateDetection(v3)
						local v__currententerdetection = v3._currentEnterDetection
						if v2 == nil or v__currententerdetection < v2 then
							v2 = v__currententerdetection
							v1 = v_accuracy
						else
							v1 = v_accuracy
						end
					end
				end
				local v4 = v_u17[self](v2)
				local v5 = {}
				local v6 = {}
				for v7, v8 in pairs(v4) do
					local v_settingsgroupname = v7.settingsGroupName
					if v_settingsgroupname then
						v_settingsgroupname = v_u15.getGroup(v7.settingsGroupName)
					end
					if v_settingsgroupname and v_settingsgroupname.onlyEnterOnceExitedAll == true then
						for v9, _ in pairs(v8) do
							local v10 = v5[v7.settingsGroupName]
							if not v10 then
								v10 = {}
								v5[v7.settingsGroupName] = v10
							end
							v10[v9] = v7
						end
						v6[v7] = v8
					end
				end
				for v11, v12 in pairs(v6) do
					local v13 = v5[v11.settingsGroupName]
					if v13 then
						for v14, _ in pairs(v12) do
							local v15 = v13[v14]
							if v15 and v15 ~= v11 then
								v12[v14] = nil
							end
						end
					end
				end
				local v16 = {
					{},
					{}
				}
				for v17, _ in pairs(v_u5) do
					if v17.activeTriggers[self] then
						local v_accuracy = v17.accuracy
						local v18 = v4[v17] or {}
						local v19 = false
						for _, _ in pairs(v18) do
							v19 = true
							break
						end
						if v19 then
							if v1 >= v_accuracy then
								v_accuracy = v1
							end
						else
							v_accuracy = v1
						end
						local v__updateoccupants = v17:_updateOccupants(self, v18)
						v16[1][v17] = v__updateoccupants.exited
						v16[2][v17] = v__updateoccupants.entered
						v1 = v_accuracy
					end
				end
				local v20 = { "Exited", "Entered" }
				for v21, v22 in pairs(v16) do
					local v23 = self .. v20[v21]
					for v24, v25 in pairs(v22) do
						local v26 = v24[v23]
						if v26 then
							for _, v27 in pairs(v25) do
								v26:Fire(v27)
							end
						end
					end
				end
				v_u1 = v_clock + v_u_enums.Accuracy.getProperty(v1)
			end
		end)
	end
end
function v_u15._deregisterConnection(arg1, arg2)
	-- upvalues: (ref) v_u13, (copy) v_u7, (copy) v_u14, (copy) v_u5, (copy) v_u15
	v_u13 = v_u13 - 1
	if v_u7[arg2] == 1 then
		v_u7[arg2] = nil
		local v1 = v_u14[arg2]
		if v1 then
			v_u14[arg2] = nil
			v1:Disconnect()
		end
	else
		local v2 = v_u7
		v2[arg2] = v2[arg2] - 1
	end
	arg1.activeTriggers[arg2] = nil
	local v3 = 0
	for _, _ in pairs(arg1.activeTriggers) do
		v3 = v3 + 1
	end
	if v3 == 0 then
		v_u5[arg1] = nil
		v_u15._updateZoneDetails()
	end
	if arg1.touchedConnectionActions[arg2] then
		arg1:_disconnectTouchedConnection(arg2)
	end
end
function v_u15._updateZoneDetails()
	-- upvalues: (ref) v_u9, (ref) v_u10, (ref) v_u11, (ref) v_u12, (ref) v_u6, (copy) v_u8, (copy) v_u5
	v_u9 = {}
	v_u10 = {}
	v_u11 = {}
	v_u12 = {}
	v_u6 = 0
	for v1, _ in pairs(v_u8) do
		local v2 = v_u5[v1]
		if v2 then
			v_u6 = v_u6 + v1.volume
		end
		for _, v3 in pairs(v1.zoneParts) do
			if v2 then
				table.insert(v_u9, v3)
				v_u10[v3] = v1
			end
			table.insert(v_u11, v3)
			v_u12[v3] = v1
		end
	end
end
function v_u15._getZonesAndItems(arg1, arg2, arg3, arg4, arg5)
	-- upvalues: (copy) v_u16, (copy) v_u15, (copy) v_u_players, (copy) v_u4
	if not arg3 then
		for v1, _ in pairs(arg2) do
			arg3 = arg3 + v1.volume
		end
	end
	local v2 = {}
	local v3 = v_u16[arg1]
	if v3.totalVolume < arg3 then
		for _, v4 in pairs(v3.items) do
			local v_gettouchingzones = v_u15.getTouchingZones(v4, arg4, arg5, v3)
			for _, v5 in pairs(v_gettouchingzones) do
				if not arg4 or v5.activeTriggers[arg1] then
					local v6
					if arg1 == "player" then
						v6 = v_u_players:GetPlayerFromCharacter(v4)
					else
						v6 = v4
					end
					if v6 then
						local v7 = v2[v5]
						if not v7 then
							v7 = {}
							v2[v5] = v7
						end
						local v_player = v6:IsA("Player")
						if v_player then
							v_player = v6.Character
						end
						v7[v6] = v_player or true
					end
				end
			end
		end
		return v2
	else
		for v8, _ in pairs(arg2) do
			if not arg4 or v8.activeTriggers[arg1] then
				local v_getpartboundsinbox = v_u4:GetPartBoundsInBox(v8.region.CFrame, v8.region.Size, v3.whitelistParams)
				local v9 = {}
				for _, v10 in pairs(v_getpartboundsinbox) do
					local v11 = v3.partToItem[v10]
					if not v9[v11] then
						v9[v11] = true
					end
				end
				for v12, _ in pairs(v9) do
					if arg1 == "player" then
						local v_getplayerfromcharacter = v_u_players:GetPlayerFromCharacter(v12)
						if v8:findPlayer(v_getplayerfromcharacter) then
							local v13 = v2[v8]
							if not v13 then
								v13 = {}
								v2[v8] = v13
							end
							local v_player = v_getplayerfromcharacter:IsA("Player")
							if v_player then
								v_player = v_getplayerfromcharacter.Character
							end
							v13[v_getplayerfromcharacter] = v_player or true
						end
					elseif v8:findItem(v12) then
						local v14 = v2[v8]
						if not v14 then
							v14 = {}
							v2[v8] = v14
						end
						local v_player = v12:IsA("Player")
						if v_player then
							v_player = v12.Character
						end
						v14[v12] = v_player or true
					end
				end
			end
		end
		return v2
	end
end
function v_u15.getZones()
	-- upvalues: (copy) v_u8
	local v1 = {}
	for v2, _ in pairs(v_u8) do
		table.insert(v1, v2)
	end
	return v1
end
function v_u15.getTouchingZones(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_enums, (copy) v_u3, (ref) v_u9, (ref) v_u11, (ref) v_u10, (ref) v_u12, (copy) v_u4
	local v1
	if arg4 then
		v1 = arg4.exitDetections[arg1]
		arg4.exitDetections[arg1] = nil
	else
		v1 = nil
	end
	local v2 = v1 or arg3
	local v3 = nil
	local v4 = nil
	local v_basepart = arg1:IsA("BasePart")
	local v5 = not v_basepart
	local v6 = {}
	if v_basepart then
		v3 = arg1.Size
		v4 = arg1.CFrame
		table.insert(v6, arg1)
	elseif v2 == v_u_enums.Detection.WholeBody then
		v3, v4 = v_u3.getCharacterSize(arg1)
		v6 = arg1:GetChildren()
	else
		local v_humanoidrootpart = arg1:FindFirstChild("HumanoidRootPart")
		if v_humanoidrootpart then
			v3 = v_humanoidrootpart.Size
			v4 = v_humanoidrootpart.CFrame
			table.insert(v6, v_humanoidrootpart)
		end
	end
	if not (v3 and v4) then
		return {}
	end
	local v7 = arg2 and v_u9 or v_u11
	local v8 = arg2 and v_u10 or v_u12
	local v_new = OverlapParams.new()
	v_new.FilterType = Enum.RaycastFilterType.Whitelist
	v_new.MaxParts = #v7
	v_new.FilterDescendantsInstances = v7
	local v_getpartboundsinbox = v_u4:GetPartBoundsInBox(v4, v3, v_new)
	local v9 = {}
	local v10 = {}
	local v11 = {}
	for _, v12 in pairs(v_getpartboundsinbox) do
		local v13 = v8[v12]
		if v13 and v13.allZonePartsAreBlocks then
			v9[v13] = true
			v10[v12] = v13
		else
			table.insert(v11, v12)
		end
	end
	local v14 = #v11
	local v15 = 0
	if v14 > 0 then
		local v_new = OverlapParams.new()
		v_new.FilterType = Enum.RaycastFilterType.Whitelist
		v_new.MaxParts = v14
		v_new.FilterDescendantsInstances = v11
		for _, v16 in pairs(v6) do
			local v17 = false
			if v16:IsA("BasePart") and not (v5 and v_u3.bodyPartsToIgnore[v16.Name]) then
				local v_getpartsinpart = v_u4:GetPartsInPart(v16, v_new)
				for _, v18 in pairs(v_getpartsinpart) do
					if not v10[v18] then
						local v19 = v8[v18]
						if v19 then
							v9[v19] = true
							v10[v18] = v19
							v15 = v15 + 1
						end
						if v15 == v14 then
							v17 = true
							break
						end
					end
				end
				if v17 then
					break
				end
			end
		end
	end
	local v20 = nil
	local v21 = {}
	for v22, _ in pairs(v9) do
		if v20 == nil or v22._currentExitDetection < v20 then
			v20 = v22._currentExitDetection
		end
		table.insert(v21, v22)
	end
	if v20 and arg4 then
		arg4.exitDetections[arg1] = v20
	end
	return v21, v10
end
local v_u18 = {}
function v_u15.setGroup(arg1, arg2)
	-- upvalues: (copy) v_u18
	local v1 = v_u18[arg1]
	if not v1 then
		v1 = {}
		v_u18[arg1] = v1
	end
	v1.onlyEnterOnceExitedAll = true
	v1._name = arg1
	v1._memberZones = {}
	if typeof(arg2) == "table" then
		for v2, v3 in pairs(arg2) do
			v1[v2] = v3
		end
	end
	return v1
end
function v_u15.getGroup(arg1)
	-- upvalues: (copy) v_u18
	return v_u18[arg1]
end
local v_u19 = nil
local v_u_format = string.format("ZonePlus%sContainer", v_run:IsClient() and "Client" or "Server")
function v_u15.getWorkspaceContainer()
	-- upvalues: (ref) v_u19, (copy) v_u_format
	local v1 = v_u19 or workspace:FindFirstChild(v_u_format)
	if not v1 then
		v1 = Instance.new("Folder")
		v1.Name = v_u_format
		v1.Parent = workspace
		v_u19 = v1
	end
	return v1
end
return v_u15