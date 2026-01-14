-- Decompiled with Bunni.lol Decompiler

local v_u_players = game:GetService("Players")
local _ = game:GetService("RunService").Heartbeat
local v1 = require(script.Parent.Parent.Signal)
local v_u2 = require(script.Parent.Parent.Janitor)
local v_u3 = {}
v_u3.__index = v_u3
local v_u4 = {}
v_u3.trackers = v_u4
v_u3.itemAdded = v1.new()
v_u3.itemRemoved = v1.new()
v_u3.bodyPartsToIgnore = {
	["UpperTorso"] = true,
	["LowerTorso"] = true,
	["Torso"] = true,
	["LeftHand"] = true,
	["RightHand"] = true,
	["LeftFoot"] = true,
	["RightFoot"] = true
}
function v_u3.getCombinedTotalVolumes()
	-- upvalues: (copy) v_u4
	local v1 = 0
	for v2, _ in pairs(v_u4) do
		v1 = v1 + v2.totalVolume
	end
	return v1
end
function v_u3.getCharacterSize(arg1)
	local v1
	if arg1 then
		v1 = arg1:FindFirstChild("Head")
	else
		v1 = arg1
	end
	if arg1 then
		arg1 = arg1:FindFirstChild("HumanoidRootPart")
	end
	if not (arg1 and v1) then
		return nil
	end
	if not v1:IsA("BasePart") then
		v1 = arg1
	end
	local v_y = v1.Size.Y
	local v_size = arg1.Size
	return v_size * Vector3.new(2, 2, 1) + Vector3.new(0, v_y, 0), arg1.CFrame * CFrame.new(0, v_y / 2 - v_size.Y / 2, 0)
end
function v_u3.new(arg1)
	-- upvalues: (copy) v_u3, (copy) v_u2, (copy) v_u_players, (copy) v_u4
	local v_u1 = {}
	setmetatable(v_u1, v_u3)
	v_u1.name = arg1
	v_u1.totalVolume = 0
	v_u1.parts = {}
	v_u1.partToItem = {}
	v_u1.items = {}
	v_u1.whitelistParams = nil
	v_u1.characters = {}
	v_u1.baseParts = {}
	v_u1.exitDetections = {}
	v_u1.janitor = v_u2.new()
	if arg1 == "player" then
		local function v_u2()
			-- upvalues: (ref) v_u_players, (copy) v_u1
			local v1 = {}
			for _, v2 in pairs(v_u_players:GetPlayers()) do
				local v_character = v2.Character
				if v_character then
					v1[v_character] = true
				end
			end
			v_u1.characters = v1
		end
		local function v3(arg1)
			-- upvalues: (copy) v_u2, (copy) v_u1
			local function v1(arg1)
				-- upvalues: (ref) v_u2, (ref) v_u1
				local v_humanoid = arg1:WaitForChild("Humanoid", 3)
				if v_humanoid then
					v_u2()
					v_u1:update()
					for _, v1 in pairs(v_humanoid:GetChildren()) do
						if v1:IsA("NumberValue") then
							v1.Changed:Connect(function()
								-- upvalues: (ref) v_u1
								v_u1:update()
							end)
						end
					end
				end
			end
			if arg1.Character then
				v1(arg1.Character)
			end
			arg1.CharacterAdded:Connect(v1)
			arg1.CharacterRemoving:Connect(function(arg1)
				-- upvalues: (ref) v_u1
				v_u1.exitDetections[arg1] = nil
			end)
		end
		v_u_players.PlayerAdded:Connect(v3)
		for _, v4 in pairs(v_u_players:GetPlayers()) do
			v3(v4)
		end
		v_u_players.PlayerRemoving:Connect(function(_)
			-- upvalues: (copy) v_u2, (copy) v_u1
			v_u2()
			v_u1:update()
		end)
	elseif arg1 == "item" then
		v_u3.itemAdded:Connect(function(arg1)
			-- upvalues: (copy) v_u1
			if arg1.isCharacter then
				v_u1.characters[arg1.item] = true
			elseif arg1.isBasePart then
				v_u1.baseParts[arg1.item] = true
			end
			v_u1:update()
		end)
		v_u3.itemRemoved:Connect(function(arg1)
			-- upvalues: (copy) v_u1
			v_u1.exitDetections[arg1.item] = nil
			if arg1.isCharacter then
				v_u1.characters[arg1.item] = nil
			elseif arg1.isBasePart then
				v_u1.baseParts[arg1.item] = nil
			end
			v_u1:update()
		end)
	end
	v_u4[v_u1] = true
	task.defer(v_u1.update, v_u1)
	return v_u1
end
function v_u3._preventMultiFrameUpdates(arg1, arg2, ...)
	arg1._preventMultiDetails = arg1._preventMultiDetails or {}
	local v_u1 = arg1._preventMultiDetails[arg2]
	if not v_u1 then
		v_u1 = {
			["calling"] = false,
			["callsThisFrame"] = 0,
			["updatedThisFrame"] = false
		}
		arg1._preventMultiDetails[arg2] = v_u1
	end
	v_u1.callsThisFrame = v_u1.callsThisFrame + 1
	if v_u1.callsThisFrame ~= 1 then
		return true
	end
	local v_u_pack = table.pack(...)
	task.defer(function()
		-- upvalues: (ref) v_u1, (copy) arg1, (copy) arg2, (copy) v_u_pack
		v_u1.callsThisFrame = 0
		if v_u1.callsThisFrame > 1 then
			arg1[arg2](arg1, unpack(v_u_pack))
		end
	end)
	return false
end
function v_u3.update(self)
	-- upvalues: (copy) v_u3, (copy) v_u2
	if not self:_preventMultiFrameUpdates("update") then
		self.totalVolume = 0
		self.parts = {}
		self.partToItem = {}
		self.items = {}
		for v_u1, _ in pairs(self.characters) do
			local v_getcharactersize = v_u3.getCharacterSize(v_u1)
			if v_getcharactersize then
				self.totalVolume = self.totalVolume + v_getcharactersize.X * v_getcharactersize.Y * v_getcharactersize.Z
				local v_add = self.janitor:add(v_u2.new(), "destroy", "trackCharacterParts-" .. self.name)
				local v_u2 = v_add
				for _, v_u3 in pairs(v_u1:GetChildren()) do
					if v_u3:IsA("BasePart") and not v_u3.bodyPartsToIgnore[v_u3.Name] then
						self.partToItem[v_u3] = v_u1
						table.insert(self.parts, v_u3)
						v_u2:add(v_u3.AncestryChanged:Connect(function()
							-- upvalues: (copy) v_u3, (ref) v_u2, (copy) self
							if not v_u3:IsDescendantOf(game) and (v_u3.Parent == nil and v_u2 ~= nil) then
								v_u2:destroy()
								v_u2 = nil
								self:update()
							end
						end), "Disconnect")
					end
				end
				v_u2:add(v_u1.AncestryChanged:Connect(function()
					-- upvalues: (copy) v_u1, (ref) v_u2, (copy) self
					if not v_u1:IsDescendantOf(game) and (v_u1.Parent == nil and v_u2 ~= nil) then
						v_u2:destroy()
						v_u2 = nil
						self:update()
					end
				end), "Disconnect")
				table.insert(self.items, v_u1)
			end
		end
		for v4, _ in pairs(self.baseParts) do
			local v_size = v4.Size
			self.totalVolume = self.totalVolume + v_size.X * v_size.Y * v_size.Z
			self.partToItem[v4] = v4
			table.insert(self.parts, v4)
			table.insert(self.items, v4)
		end
		self.whitelistParams = OverlapParams.new()
		self.whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist
		self.whitelistParams.MaxParts = #self.parts
		self.whitelistParams.FilterDescendantsInstances = self.parts
	end
end
return v_u3