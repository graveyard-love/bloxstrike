-- Decompiled with Bunni.lol Decompiler

local v_players = game:GetService("Players")
local v_u_run = game:GetService("RunService")
local v_u_heartbeat = v_u_run.Heartbeat
local v_u_isclient = v_u_run:IsClient()
if v_u_isclient then
	v_u_isclient = v_players.LocalPlayer
end
game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
local v_u_enums = require(script.Enum).enums
local v_u1 = require(script.Janitor)
local v_u2 = require(script.Signal)
local v3 = require(script.ZonePlusReference)
local v_getobject = v3.getObject()
local v_zonecontroller = script.ZoneController
local v_u_tracker = v_zonecontroller.Tracker
local v_u_collectiveworldmodel = v_zonecontroller.CollectiveWorldModel
local v_u4 = require(v_zonecontroller)
local v5 = game:GetService("RunService"):IsClient() and "Client" or "Server"
local v6
if v_getobject then
	v6 = v_getobject:FindFirstChild(v5)
else
	v6 = v_getobject
end
if v6 then
	return require(v_getobject.Value)
end
local v_u7 = {}
v_u7.__index = v_u7
if not v6 then
	v3.addToReplicatedStorage()
end
v_u7.enum = v_u_enums
function v_u7.new(arg1)
	-- upvalues: (copy) v_u7, (copy) v_u_enums, (copy) v_u1, (copy) v_u_http, (copy) v_u4, (copy) v_u2, (copy) v_u_isclient
	local v_u1 = {}
	setmetatable(v_u1, v_u7)
	local v2 = typeof(arg1)
	if v2 ~= "table" and v2 ~= "Instance" then
		error("The zone container must be a model, folder, basepart or table!")
	end
	v_u1.accuracy = v_u_enums.Accuracy.High
	v_u1.autoUpdate = true
	v_u1.respectUpdateQueue = true
	local v_new = v_u1.new()
	v_u1.janitor = v_new
	v_u1._updateConnections = v_new:add(v_u1.new(), "destroy")
	v_u1.container = arg1
	v_u1.zoneParts = {}
	v_u1.overlapParams = {}
	v_u1.region = nil
	v_u1.volume = nil
	v_u1.boundMin = nil
	v_u1.boundMax = nil
	v_u1.recommendedMaxParts = nil
	v_u1.zoneId = v_u_http:GenerateGUID()
	v_u1.activeTriggers = {}
	v_u1.occupants = {}
	v_u1.trackingTouchedTriggers = {}
	v_u1.enterDetection = v_u_enums.Detection.Centre
	v_u1.exitDetection = v_u_enums.Detection.Centre
	v_u1._currentEnterDetection = nil
	v_u1._currentExitDetection = nil
	v_u1.totalPartVolume = 0
	v_u1.allZonePartsAreBlocks = true
	v_u1.trackedItems = {}
	v_u1.settingsGroupName = nil
	v_u1.worldModel = workspace
	v_u1.onItemDetails = {}
	v_u1.itemsToUntrack = {}
	v_u4.updateDetection(v_u1)
	v_u1.updated = v_new:add(v_u2.new(), "destroy")
	local v3 = {
		"player",
		"part",
		"localPlayer",
		"item"
	}
	local v4 = { "entered", "exited" }
	for _, v_u5 in pairs(v3) do
		local v_u6 = 0
		local v_u7 = 0
		for _, v8 in pairs(v4) do
			local v_add = v_new:add(v_u2.new(true), "destroy")
			local v_u9 = v8:sub(1, 1):upper() .. v8:sub(2)
			v_u1[v_u5 .. v_u9] = v_add
			v_add.connectionsChanged:Connect(function(arg1)
				-- upvalues: (copy) v_u5, (ref) v_u_isclient, (copy) v_u9, (ref) v_u6, (ref) v_u7, (ref) v_u4, (copy) v_u1
				if v_u5 == "localPlayer" and (not v_u_isclient and arg1 == 1) then
					error(("Can only connect to \'localPlayer%s\' on the client!"):format(v_u9))
				end
				v_u7 = v_u7 + arg1
				if v_u7 == 0 and v_u7 > 0 then
					v_u4._registerConnection(v_u1, v_u5, v_u9)
				elseif v_u6 > 0 and v_u7 == 0 then
					v_u4._deregisterConnection(v_u1, v_u5)
				end
			end)
		end
	end
	v_u7.touchedConnectionActions = {}
	for _, v10 in pairs(v3) do
		local v_u11 = v_u1[("_%sTouchedZone"):format(v10)]
		if v_u11 then
			v_u1.trackingTouchedTriggers[v10] = {}
			v_u7.touchedConnectionActions[v10] = function(arg1)
				-- upvalues: (copy) v_u11, (copy) v_u1
				v_u11(v_u1, arg1)
			end
		end
	end
	v_u1:_update()
	v_u4._registerZone(v_u1)
	v_new:add(function()
		-- upvalues: (ref) v_u4, (copy) v_u1
		v_u4._deregisterZone(v_u1)
	end, true)
	return v_u1
end
function v_u7.fromRegion(arg1, arg2)
	-- upvalues: (copy) v_u7
	local v_u_model = Instance.new("Model")
	local function v_u1(arg1, arg2)
		-- upvalues: (copy) v_u1, (copy) v_u_model
		if arg2.X > 2024 or (arg2.Y > 2024 or arg2.Z > 2024) then
			local v1 = arg2 * 0.25
			local v2 = arg2 * 0.5
			v_u1(arg1 * CFrame.new(-v1.X, -v1.Y, -v1.Z), v2)
			v_u1(arg1 * CFrame.new(-v1.X, -v1.Y, v1.Z), v2)
			v_u1(arg1 * CFrame.new(-v1.X, v1.Y, -v1.Z), v2)
			v_u1(arg1 * CFrame.new(-v1.X, v1.Y, v1.Z), v2)
			v_u1(arg1 * CFrame.new(v1.X, -v1.Y, -v1.Z), v2)
			v_u1(arg1 * CFrame.new(v1.X, -v1.Y, v1.Z), v2)
			v_u1(arg1 * CFrame.new(v1.X, v1.Y, -v1.Z), v2)
			v_u1(arg1 * CFrame.new(v1.X, v1.Y, v1.Z), v2)
		else
			local v_part = Instance.new("Part")
			v_part.CFrame = arg1
			v_part.Size = arg2
			v_part.Anchored = true
			v_part.Parent = v_u_model
		end
	end
	v_u1(arg1, arg2)
	local v_new = v_u7.new(v_u_model)
	v_new:relocate()
	return v_new
end
function v_u7._calculateRegion(_, arg2, arg3)
	local v1 = {
		["Min"] = {},
		["Max"] = {}
	}
	for v_u2, v3 in pairs(v1) do
		v3.Values = {}
		function v3.parseCheck(arg1, arg2)
			-- upvalues: (copy) v_u2
			if v_u2 == "Min" then
				return arg1 <= arg2
			end
			if v_u2 == "Max" then
				return arg2 <= arg1
			end
		end
		function v3.parse(arg1, arg2)
			for v1, v2 in pairs(arg2) do
				if arg1.parseCheck(v2, arg1.Values[v1] or v2) then
					arg1.Values[v1] = v2
				end
			end
		end
	end
	for _, v4 in pairs(arg2) do
		local v5 = v4.Size * 0.5
		for _, v6 in pairs({
			v4.CFrame * CFrame.new(-v5.X, -v5.Y, -v5.Z),
			v4.CFrame * CFrame.new(-v5.X, -v5.Y, v5.Z),
			v4.CFrame * CFrame.new(-v5.X, v5.Y, -v5.Z),
			v4.CFrame * CFrame.new(-v5.X, v5.Y, v5.Z),
			v4.CFrame * CFrame.new(v5.X, -v5.Y, -v5.Z),
			v4.CFrame * CFrame.new(v5.X, -v5.Y, v5.Z),
			v4.CFrame * CFrame.new(v5.X, v5.Y, -v5.Z),
			v4.CFrame * CFrame.new(v5.X, v5.Y, v5.Z)
		}) do
			local v_getcomponents, v7, v8 = v6:GetComponents()
			local v9 = { v_getcomponents, v7, v8 }
			v1.Min:parse(v9)
			v1.Max:parse(v9)
		end
	end
	local v10 = {}
	local v11 = {}
	for v12, v13 in pairs(v1) do
		for _, v16 in pairs(v13.Values) do
			local v15 = v12 == "Min" and v11 and v11 or v10
			if not arg3 then
				local v16 = math.floor((v16 + (v12 == "Min" and -2 or 2) + 2) / 4) * 4
			end
			table.insert(v15, v16)
		end
	end
	local v_new = Vector3.new(unpack(v11))
	local v_new = Vector3.new(unpack(v10))
	return Region3.new(v_new, v_new), v_new, v_new
end
function v_u7._displayBounds(arg1)
	if not arg1.displayBoundParts then
		arg1.displayBoundParts = true
		for v1, v2 in pairs({
			["BoundMin"] = arg1.boundMin,
			["BoundMax"] = arg1.boundMax
		}) do
			local v_part = Instance.new("Part")
			v_part.Anchored = true
			v_part.CanCollide = false
			v_part.Transparency = 0.5
			v_part.Size = Vector3.new(1, 1, 1)
			v_part.Color = Color3.fromRGB(255, 0, 0)
			v_part.CFrame = CFrame.new(v2)
			v_part.Name = v1
			v_part.Parent = workspace
			arg1.janitor:add(v_part, "Destroy")
		end
	end
end
function v_u7._update(self)
	-- upvalues: (copy) v_u_run
	local v_container = self.container
	local v1 = {}
	local v_u2 = 0
	self._updateConnections:clean()
	local v3 = typeof(v_container)
	local v4 = {}
	if v3 == "table" then
		for _, v5 in pairs(v_container) do
			if v5:IsA("BasePart") then
				table.insert(v1, v5)
			end
		end
	elseif v3 == "Instance" then
		if v_container:IsA("BasePart") then
			table.insert(v1, v_container)
		else
			table.insert(v4, v_container)
			for _, v6 in pairs(v_container:GetDescendants()) do
				if v6:IsA("BasePart") then
					table.insert(v1, v6)
				else
					table.insert(v4, v6)
				end
			end
		end
	end
	self.zoneParts = v1
	self.overlapParams = {}
	local v7 = true
	for _, v_u8 in pairs(v1) do
		local _, v9 = pcall(function()
			-- upvalues: (copy) v_u8
			return v_u8.Shape.Name
		end)
		if v9 ~= "Block" then
			v7 = false
		end
	end
	self.allZonePartsAreBlocks = v7
	local v_new = OverlapParams.new()
	v_new.FilterType = Enum.RaycastFilterType.Include
	v_new.MaxParts = #v1
	v_new.FilterDescendantsInstances = v1
	self.overlapParams.zonePartsWhitelist = v_new
	local v_new = OverlapParams.new()
	v_new.FilterType = Enum.RaycastFilterType.Exclude
	v_new.FilterDescendantsInstances = v1
	self.overlapParams.zonePartsIgnorelist = v_new
	local function v10()
		-- upvalues: (copy) self, (ref) v_u2, (ref) v_u_run
		if self.autoUpdate then
			local v_u_clock = os.clock()
			if self.respectUpdateQueue then
				v_u2 = v_u2 + 1
				v_u_clock = v_u_clock + 0.1
			end
			local v_u1 = nil
			v_u1 = v_u_run.Heartbeat:Connect(function()
				-- upvalues: (ref) v_u_clock, (ref) v_u1, (ref) self, (ref) v_u2
				if v_u_clock <= os.clock() then
					v_u1:Disconnect()
					if self.respectUpdateQueue then
						v_u2 = v_u2 - 1
					end
					if v_u2 == 0 and self.zoneId then
						self:_update()
					end
				end
			end)
		end
	end
	local v11 = { "Size", "Position" }
	for _, v_u12 in pairs(v1) do
		for _, v13 in pairs(v11) do
			self._updateConnections:add(v_u12:GetPropertyChangedSignal(v13):Connect(v10), "Disconnect")
		end
		if v_u12.CollisionGroupId ~= 0 then
			error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
		end
		self._updateConnections:add(v_u12:GetPropertyChangedSignal("CollisionGroupId"):Connect(function()
			-- upvalues: (copy) v_u12
			if v_u12.CollisionGroupId ~= 0 then
				error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
			end
		end), "Disconnect")
	end
	local v14 = { "ChildAdded", "ChildRemoved" }
	for _, _ in pairs(v4) do
		for _, v15 in pairs(v14) do
			self._updateConnections:add(self.container[v15]:Connect(function(arg1)
				-- upvalues: (copy) self, (ref) v_u2, (ref) v_u_run
				if arg1:IsA("BasePart") and self.autoUpdate then
					local v_u_clock = os.clock()
					if self.respectUpdateQueue then
						v_u2 = v_u2 + 1
						v_u_clock = v_u_clock + 0.1
					end
					local v_u1 = nil
					v_u1 = v_u_run.Heartbeat:Connect(function()
						-- upvalues: (ref) v_u_clock, (ref) v_u1, (ref) self, (ref) v_u2
						if v_u_clock <= os.clock() then
							v_u1:Disconnect()
							if self.respectUpdateQueue then
								v_u2 = v_u2 - 1
							end
							if v_u2 == 0 and self.zoneId then
								self:_update()
							end
						end
					end)
				end
			end), "Disconnect")
		end
	end
	local v__calculateregion, v16, v17 = self:_calculateRegion(v1)
	local v__calculateregion, _, _ = self:_calculateRegion(v1, true)
	self.region = v__calculateregion
	self.exactRegion = v__calculateregion
	self.boundMin = v16
	self.boundMax = v17
	local v_size = v__calculateregion.Size
	self.volume = v_size.X * v_size.Y * v_size.Z
	self:_updateTouchedConnections()
	self.updated:Fire()
end
function v_u7._updateOccupants(arg1, arg2, arg3)
	local v1 = arg1.occupants[arg2]
	if not v1 then
		v1 = {}
		arg1.occupants[arg2] = v1
	end
	local v2 = {}
	for v3, v4 in pairs(v1) do
		local v5 = arg3[v3]
		if v5 == nil or v5 ~= v4 then
			v1[v3] = nil
			if not v2.exited then
				v2.exited = {}
			end
			table.insert(v2.exited, v3)
		end
	end
	for v6, _ in pairs(arg3) do
		if v1[v6] == nil then
			v1[v6] = v6:IsA("Player") and (v6.Character or true) or true
			if not v2.entered then
				v2.entered = {}
			end
			table.insert(v2.entered, v6)
		end
	end
	return v2
end
function v_u7._formTouchedConnection(arg1, arg2)
	-- upvalues: (copy) v_u1
	local v1 = "_touchedJanitor" .. arg2
	local v2 = arg1[v1]
	if v2 then
		v2:clean()
	else
		arg1[v1] = arg1.janitor:add(v_u1.new(), "destroy")
	end
	arg1:_updateTouchedConnection(arg2)
end
function v_u7._updateTouchedConnection(arg1, arg2)
	local v1 = arg1["_touchedJanitor" .. arg2]
	if v1 then
		for _, v2 in pairs(arg1.zoneParts) do
			v1:add(v2.Touched:Connect(arg1.touchedConnectionActions[arg2], arg1), "Disconnect")
		end
	end
end
function v_u7._updateTouchedConnections(arg1)
	for v1, _ in pairs(arg1.touchedConnectionActions) do
		local v2 = arg1["_touchedJanitor" .. v1]
		if v2 then
			v2:cleanup()
			arg1:_updateTouchedConnection(v1)
		end
	end
end
function v_u7._disconnectTouchedConnection(arg1, arg2)
	local v1 = "_touchedJanitor" .. arg2
	local v2 = arg1[v1]
	if v2 then
		v2:cleanup()
		arg1[v1] = nil
	end
end
function v_u7._partTouchedZone(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u_heartbeat, (copy) v_u_enums
	local v_u_part = arg1.trackingTouchedTriggers.part
	if not v_u_part[arg2] then
		local v_u1 = 0
		local v_u2 = false
		local v_u_position = arg2.Position
		local v_u_clock = os.clock()
		local v_u_add = arg1.janitor:add(v_u1.new(), "destroy")
		v_u_part[arg2] = v_u_add
		if not ({
			["Seat"] = true,
			["VehicleSeat"] = true
		})[arg2.ClassName] and ({
			["HumanoidRootPart"] = true
		})[arg2.Name] then
			arg2.CanTouch = false
		end
		local v_u3 = math.round(arg2.Size.X * arg2.Size.Y * arg2.Size.Z * 100000) * 0.00001
		arg1.totalPartVolume = arg1.totalPartVolume + v_u3
		v_u_add:add(v_u_heartbeat:Connect(function()
			-- upvalues: (ref) v_u1, (ref) v_u_enums, (copy) arg1, (copy) arg2, (ref) v_u2, (ref) v_u_position, (ref) v_u_clock, (copy) v_u_add
			local v_clock = os.clock()
			if v_u1 <= v_clock then
				local v_getproperty = v_u_enums.Accuracy.getProperty(arg1.accuracy)
				v_u1 = v_clock + v_getproperty
				local v1 = arg1:findPoint(arg2.CFrame) or arg1:findPart(arg2)
				if v_u2 then
					if not v1 then
						v_u2 = false
						v_u_position = arg2.Position
						v_u_clock = os.clock()
						arg1.partExited:Fire(arg2)
					end
				else
					if v1 then
						v_u2 = true
						arg1.partEntered:Fire(arg2)
						return
					end
					if (arg2.Position - v_u_position).Magnitude > 1.5 and v_getproperty <= v_clock - v_u_clock then
						v_u_add:cleanup()
						return
					end
				end
			end
		end), "Disconnect")
		v_u_add:add(function()
			-- upvalues: (copy) v_u_part, (copy) arg2, (copy) arg1, (copy) v_u3
			v_u_part[arg2] = nil
			arg2.CanTouch = true
			arg1.totalPartVolume = math.round((arg1.totalPartVolume - v_u3) * 100000) * 0.00001
		end, true)
	end
end
local v_u8 = {
	["Ball"] = function(arg1)
		return "GetPartBoundsInRadius", { arg1.Position, arg1.Size.X }
	end,
	["Block"] = function(arg1)
		return "GetPartBoundsInBox", { arg1.CFrame, arg1.Size }
	end,
	["Other"] = function(arg1)
		return "GetPartsInPart", { arg1 }
	end
}
function v_u7._getRegionConstructor(arg1, arg2, arg3)
	-- upvalues: (copy) v_u8
	local v1, v2 = pcall(function()
		-- upvalues: (copy) arg2
		return arg2.Shape.Name
	end)
	local v3 = nil
	local v4 = nil
	if v1 and arg1.allZonePartsAreBlocks then
		local v5 = v_u8[v2]
		if v5 then
			v3, v4 = v5(arg2)
		end
	end
	if not v3 then
		v3, v4 = v_u8.Other(arg2)
	end
	if arg3 then
		table.insert(v4, arg3)
	end
	return v3, v4
end
function v_u7.findLocalPlayer(arg1)
	-- upvalues: (copy) v_u_isclient
	if not v_u_isclient then
		error("Can only call \'findLocalPlayer\' on the client!")
	end
	return arg1:findPlayer(v_u_isclient)
end
function v_u7._find(arg1, arg2, arg3)
	-- upvalues: (copy) v_u4
	v_u4.updateDetection(arg1)
	local v_gettouchingzones = v_u4.getTouchingZones(arg3, false, arg1._currentEnterDetection, v_u4.trackers[arg2])
	for _, v1 in pairs(v_gettouchingzones) do
		if v1 == arg1 then
			return true
		end
	end
	return false
end
function v_u7.findPlayer(arg1, arg2)
	local v_character = arg2.Character
	if v_character then
		v_character = v_character:FindFirstChildOfClass("Humanoid")
	end
	if v_character then
		return arg1:_find("player", arg2.Character)
	else
		return false
	end
end
function v_u7.findItem(arg1, arg2)
	return arg1:_find("item", arg2)
end
function v_u7.findPart(arg1, arg2)
	local v__getregionconstructor, v1 = arg1:_getRegionConstructor(arg2, arg1.overlapParams.zonePartsWhitelist)
	local v2 = arg1.worldModel[v__getregionconstructor](arg1.worldModel, unpack(v1))
	if #v2 > 0 then
		return true, v2
	else
		return false
	end
end
function v_u7.getCheckerPart(arg1)
	-- upvalues: (copy) v_u4
	local v_checkerpart = arg1.checkerPart
	if not v_checkerpart then
		v_checkerpart = arg1.janitor:add(Instance.new("Part"), "Destroy")
		v_checkerpart.Size = Vector3.new(0.1, 0.1, 0.1)
		v_checkerpart.Name = "ZonePlusCheckerPart"
		v_checkerpart.Anchored = true
		v_checkerpart.Transparency = 1
		v_checkerpart.CanCollide = false
		arg1.checkerPart = v_checkerpart
	end
	local v_worldmodel = arg1.worldModel
	if v_worldmodel == workspace then
		v_worldmodel = v_u4.getWorkspaceContainer()
	end
	if v_checkerpart.Parent ~= v_worldmodel then
		v_checkerpart.Parent = v_worldmodel
	end
	return v_checkerpart
end
function v_u7.findPoint(arg1, arg2)
	if typeof(arg2) == "Vector3" then
		arg2 = CFrame.new(arg2)
	end
	local v_getcheckerpart = arg1:getCheckerPart()
	v_getcheckerpart.CFrame = arg2
	local v__getregionconstructor, v1 = arg1:_getRegionConstructor(v_getcheckerpart, arg1.overlapParams.zonePartsWhitelist)
	local v2 = arg1.worldModel[v__getregionconstructor](arg1.worldModel, unpack(v1))
	if #v2 > 0 then
		return true, v2
	else
		return false
	end
end
function v_u7._getAll(arg1, arg2)
	-- upvalues: (copy) v_u4
	v_u4.updateDetection(arg1)
	local v1 = {}
	local v2 = v_u4._getZonesAndItems(arg2, {
		["self"] = true
	}, arg1.volume, false, arg1._currentEnterDetection)[arg1]
	if v2 then
		for v3, _ in pairs(v2) do
			table.insert(v1, v3)
		end
	end
	return v1
end
function v_u7.getPlayers(arg1)
	return arg1:_getAll("player")
end
function v_u7.getItems(arg1)
	return arg1:_getAll("item")
end
function v_u7.getParts(arg1)
	local v1 = {}
	if arg1.activeTriggers.part then
		for v2, _ in pairs(arg1.trackingTouchedTriggers.part) do
			table.insert(v1, v2)
		end
		return v1
	end
	local v_getpartboundsinbox = arg1.worldModel:GetPartBoundsInBox(arg1.region.CFrame, arg1.region.Size, arg1.overlapParams.zonePartsIgnorelist)
	for _, v3 in pairs(v_getpartboundsinbox) do
		if arg1:findPart(v3) then
			table.insert(v1, v3)
		end
	end
	return v1
end
function v_u7.getRandomPoint(arg1)
	local v_exactregion = arg1.exactRegion
	local v_size = v_exactregion.Size
	local v_cframe = v_exactregion.CFrame
	local v_new = Random.new()
	local v1 = nil
	repeat
		local v2 = v_cframe * CFrame.new(v_new:NextNumber(-v_size.X / 2, v_size.X / 2), v_new:NextNumber(-v_size.Y / 2, v_size.Y / 2), v_new:NextNumber(-v_size.Z / 2, v_size.Z / 2))
		local v_findpoint, v3 = arg1:findPoint(v2)
		v1 = v_findpoint and true or v1
	until v1
	return v2.Position, v3
end
function v_u7.setAccuracy(arg1, arg2)
	-- upvalues: (copy) v_u_enums
	local v1 = tonumber(arg2)
	if v1 then
		if not v_u_enums.Accuracy.getName(v1) then
			error(("%s is an invalid enumId!"):format(v1))
		end
	else
		v1 = v_u_enums.Accuracy[arg2]
		if not v1 then
			error(("\'%s\' is an invalid enumName!"):format(arg2))
		end
	end
	arg1.accuracy = v1
end
function v_u7.setDetection(arg1, arg2)
	-- upvalues: (copy) v_u_enums
	local v1 = tonumber(arg2)
	if v1 then
		if not v_u_enums.Detection.getName(v1) then
			error(("%s is an invalid enumId!"):format(v1))
		end
	else
		v1 = v_u_enums.Detection[arg2]
		if not v1 then
			error(("\'%s\' is an invalid enumName!"):format(arg2))
		end
	end
	arg1.enterDetection = v1
	arg1.exitDetection = v1
end
function v_u7.trackItem(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u_tracker
	local v_basepart = arg2:IsA("BasePart")
	local v1
	if v_basepart then
		v1 = false
	else
		v1 = arg2:FindFirstChildOfClass("Humanoid")
		if v1 then
			v1 = arg2:FindFirstChild("HumanoidRootPart")
		end
	end
	assert(v_basepart or v1, "Only BaseParts or Characters/NPCs can be tracked!")
	if not arg1.trackedItems[arg2] then
		if arg1.itemsToUntrack[arg2] then
			arg1.itemsToUntrack[arg2] = nil
		end
		local v_add = arg1.janitor:add(v_u1.new(), "destroy")
		local v2 = {
			["janitor"] = v_add,
			["item"] = arg2,
			["isBasePart"] = v_basepart,
			["isCharacter"] = v1
		}
		arg1.trackedItems[arg2] = v2
		v_add:add(arg2.AncestryChanged:Connect(function()
			-- upvalues: (copy) arg2, (copy) arg1
			if not arg2:IsDescendantOf(game) then
				arg1:untrackItem(arg2)
			end
		end), "Disconnect")
		require(v_u_tracker).itemAdded:Fire(v2)
	end
end
function v_u7.untrackItem(arg1, arg2)
	-- upvalues: (copy) v_u_tracker
	local v1 = arg1.trackedItems[arg2]
	if v1 then
		v1.janitor:destroy()
	end
	arg1.trackedItems[arg2] = nil
	require(v_u_tracker).itemRemoved:Fire(v1)
end
function v_u7.bindToGroup(arg1, arg2)
	-- upvalues: (copy) v_u4
	arg1:unbindFromGroup()
	(v_u4.getGroup(arg2) or v_u4.setGroup(arg2))._memberZones[arg1.zoneId] = arg1
	arg1.settingsGroupName = arg2
end
function v_u7.unbindFromGroup(arg1)
	-- upvalues: (copy) v_u4
	if arg1.settingsGroupName then
		local v_getgroup = v_u4.getGroup(arg1.settingsGroupName)
		if v_getgroup then
			v_getgroup._memberZones[arg1.zoneId] = nil
		end
		arg1.settingsGroupName = nil
	end
end
function v_u7.relocate(arg1)
	-- upvalues: (copy) v_u_collectiveworldmodel
	if not arg1.hasRelocated then
		local v_setupworldmodel = require(v_u_collectiveworldmodel).setupWorldModel(arg1)
		arg1.worldModel = v_setupworldmodel
		arg1.hasRelocated = true
		local v_container = arg1.container
		if typeof(v_container) == "table" then
			v_container = Instance.new("Folder")
			for _, v1 in pairs(arg1.zoneParts) do
				v1.Parent = v_container
			end
		end
		arg1.relocationContainer = arg1.janitor:add(v_container, "Destroy", "RelocationContainer")
		v_container.Parent = v_setupworldmodel
	end
end
function v_u7._onItemCallback(arg1, arg2, arg3, arg4, arg5)
	local v1 = arg1.onItemDetails[arg4]
	if not v1 then
		v1 = {}
		arg1.onItemDetails[arg4] = v1
	end
	if #v1 == 0 then
		arg1.itemsToUntrack[arg4] = true
	end
	table.insert(v1, arg4)
	arg1:trackItem(arg4)
	if arg1:findItem(arg4) == arg3 then
		arg5()
		if arg1.itemsToUntrack[arg4] then
			arg1.itemsToUntrack[arg4] = nil
			arg1:untrackItem(arg4)
			return
		end
	else
		local v_u2 = nil
		v_u2 = arg1[arg2]:Connect(function(arg1)
			-- upvalues: (ref) v_u2, (copy) arg4, (copy) arg5, (copy) arg1
			if v_u2 and arg1 == arg4 then
				v_u2:Disconnect()
				v_u2 = nil
				arg5()
				if arg1.itemsToUntrack[arg4] then
					arg1.itemsToUntrack[arg4] = nil
					arg1:untrackItem(arg4)
				end
			end
		end)
	end
end
function v_u7.onItemEnter(arg1, ...)
	arg1:_onItemCallback("itemEntered", true, ...)
end
function v_u7.onItemExit(arg1, ...)
	arg1:_onItemCallback("itemExited", false, ...)
end
function v_u7.destroy(arg1)
	arg1:unbindFromGroup()
	arg1.janitor:destroy()
end
v_u7.Destroy = v_u7.destroy
return v_u7