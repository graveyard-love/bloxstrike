-- Decompiled with Bunni.lol Decompiler

local v_u1 = {
	["type"] = function(self)
		return function(arg1)
			-- upvalues: (copy) self
			local v1 = type(arg1)
			if v1 == self then
				return true
			else
				return false, string.format("%s expected, got %s", self, v1)
			end
		end
	end,
	["typeof"] = function(self)
		return function(arg1)
			-- upvalues: (copy) self
			local v1 = typeof(arg1)
			if v1 == self then
				return true
			else
				return false, string.format("%s expected, got %s", self, v1)
			end
		end
	end,
	["any"] = function(arg1)
		if arg1 == nil then
			return false, "any expected, got nil"
		else
			return true
		end
	end
}
v_u1.boolean = v_u1.typeof("boolean")
v_u1.buffer = v_u1.typeof("buffer")
v_u1.thread = v_u1.typeof("thread")
v_u1.callback = v_u1.typeof("function")
v_u1["function"] = v_u1.callback
v_u1.none = v_u1.typeof("nil")
v_u1["nil"] = v_u1.none
v_u1.string = v_u1.typeof("string")
v_u1.table = v_u1.typeof("table")
v_u1.userdata = v_u1.type("userdata")
v_u1.vector = v_u1.type("vector")
function v_u1.number(arg1)
	local v1 = typeof(arg1)
	if v1 == "number" then
		if arg1 == arg1 then
			return true
		else
			return false, "unexpected NaN value"
		end
	else
		return false, string.format("number expected, got %s", v1)
	end
end
function v_u1.nan(arg1)
	local v1 = typeof(arg1)
	if v1 == "number" then
		if arg1 == arg1 then
			return false, "unexpected non-NaN value"
		else
			return true
		end
	else
		return false, string.format("number expected, got %s", v1)
	end
end
v_u1.Axes = v_u1.typeof("Axes")
v_u1.BrickColor = v_u1.typeof("BrickColor")
v_u1.CatalogSearchParams = v_u1.typeof("CatalogSearchParams")
v_u1.CFrame = v_u1.typeof("CFrame")
v_u1.Color3 = v_u1.typeof("Color3")
v_u1.ColorSequence = v_u1.typeof("ColorSequence")
v_u1.ColorSequenceKeypoint = v_u1.typeof("ColorSequenceKeypoint")
v_u1.DateTime = v_u1.typeof("DateTime")
v_u1.DockWidgetPluginGuiInfo = v_u1.typeof("DockWidgetPluginGuiInfo")
v_u1.Enum = v_u1.typeof("Enum")
v_u1.EnumItem = v_u1.typeof("EnumItem")
v_u1.Enums = v_u1.typeof("Enums")
v_u1.Faces = v_u1.typeof("Faces")
v_u1.FloatCurveKey = v_u1.typeof("FloatCurveKey")
v_u1.Font = v_u1.typeof("Font")
v_u1.Instance = v_u1.typeof("Instance")
v_u1.NumberRange = v_u1.typeof("NumberRange")
v_u1.NumberSequence = v_u1.typeof("NumberSequence")
v_u1.NumberSequenceKeypoint = v_u1.typeof("NumberSequenceKeypoint")
v_u1.OverlapParams = v_u1.typeof("OverlapParams")
v_u1.PathWaypoint = v_u1.typeof("PathWaypoint")
v_u1.PhysicalProperties = v_u1.typeof("PhysicalProperties")
v_u1.Random = v_u1.typeof("Random")
v_u1.Ray = v_u1.typeof("Ray")
v_u1.RaycastParams = v_u1.typeof("RaycastParams")
v_u1.RaycastResult = v_u1.typeof("RaycastResult")
v_u1.RBXScriptConnection = v_u1.typeof("RBXScriptConnection")
v_u1.RBXScriptSignal = v_u1.typeof("RBXScriptSignal")
v_u1.Rect = v_u1.typeof("Rect")
v_u1.Region3 = v_u1.typeof("Region3")
v_u1.Region3int16 = v_u1.typeof("Region3int16")
v_u1.TweenInfo = v_u1.typeof("TweenInfo")
v_u1.UDim = v_u1.typeof("UDim")
v_u1.UDim2 = v_u1.typeof("UDim2")
v_u1.Vector2 = v_u1.typeof("Vector2")
v_u1.Vector2int16 = v_u1.typeof("Vector2int16")
v_u1.Vector3 = v_u1.typeof("Vector3")
v_u1.Vector3int16 = v_u1.typeof("Vector3int16")
function v_u1.literal(...)
	-- upvalues: (copy) v_u1
	local v1 = select("#", ...)
	if v1 == 1 then
		local v_u2 = ...
		return function(arg1)
			-- upvalues: (copy) v_u2
			if arg1 == v_u2 then
				return true
			else
				return false, string.format("expected %s, got %s", tostring(v_u2), (tostring(arg1)))
			end
		end
	end
	local v3 = {}
	for v4 = 1, v1 do
		local v5 = select(v4, ...)
		v3[v4] = v_u1.literal(v5)
	end
	return v_u1.union(table.unpack(v3, 1, v1))
end
v_u1.exactly = v_u1.literal
function v_u1.keyOf(arg1)
	-- upvalues: (copy) v_u1
	local v1 = 0
	local v2 = {}
	for v3 in pairs(arg1) do
		v1 = v1 + 1
		v2[v1] = v3
	end
	return v_u1.literal(table.unpack(v2, 1, v1))
end
function v_u1.valueOf(arg1)
	-- upvalues: (copy) v_u1
	local v1 = 0
	local v2 = {}
	for _, v3 in pairs(arg1) do
		v1 = v1 + 1
		v2[v1] = v3
	end
	return v_u1.literal(table.unpack(v2, 1, v1))
end
function v_u1.integer(arg1)
	-- upvalues: (copy) v_u1
	local v_number, v1 = v_u1.number(arg1)
	if v_number then
		if arg1 % 1 == 0 then
			return true
		else
			return false, string.format("integer expected, got %s", arg1)
		end
	else
		return false, v1 or ""
	end
end
function v_u1.numberMin(self)
	-- upvalues: (copy) v_u1
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		local v_number, v1 = v_u1.number(arg1)
		if v_number then
			if self <= arg1 then
				return true
			else
				return false, string.format("number >= %s expected, got %s", self, arg1)
			end
		else
			return false, v1 or ""
		end
	end
end
function v_u1.numberMax(self)
	-- upvalues: (copy) v_u1
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		local v_number, v1 = v_u1.number(arg1)
		if v_number then
			if arg1 <= self then
				return true
			else
				return false, string.format("number <= %s expected, got %s", self, arg1)
			end
		else
			return false, v1
		end
	end
end
function v_u1.numberMinExclusive(self)
	-- upvalues: (copy) v_u1
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		local v_number, v1 = v_u1.number(arg1)
		if v_number then
			if self < arg1 then
				return true
			else
				return false, string.format("number > %s expected, got %s", self, arg1)
			end
		else
			return false, v1 or ""
		end
	end
end
function v_u1.numberMaxExclusive(self)
	-- upvalues: (copy) v_u1
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		local v_number, v1 = v_u1.number(arg1)
		if v_number then
			if arg1 < self then
				return true
			else
				return false, string.format("number < %s expected, got %s", self, arg1)
			end
		else
			return false, v1 or ""
		end
	end
end
v_u1.numberPositive = v_u1.numberMinExclusive(0)
v_u1.numberNegative = v_u1.numberMaxExclusive(0)
function v_u1.numberConstrained(arg1, arg2)
	-- upvalues: (copy) v_u1
	assert(v_u1.number(arg1))
	assert(v_u1.number(arg2))
	local v_u_numbermin = v_u1.numberMin(arg1)
	local v_u_numbermax = v_u1.numberMax(arg2)
	return function(arg1)
		-- upvalues: (copy) v_u_numbermin, (copy) v_u_numbermax
		local v1, v2 = v_u_numbermin(arg1)
		if v1 then
			local v3, v4 = v_u_numbermax(arg1)
			if v3 then
				return true
			else
				return false, v4 or ""
			end
		else
			return false, v2 or ""
		end
	end
end
function v_u1.numberConstrainedExclusive(arg1, arg2)
	-- upvalues: (copy) v_u1
	assert(v_u1.number(arg1))
	assert(v_u1.number(arg2))
	local v_u_numberminexclusive = v_u1.numberMinExclusive(arg1)
	local v_u_numbermaxexclusive = v_u1.numberMaxExclusive(arg2)
	return function(arg1)
		-- upvalues: (copy) v_u_numberminexclusive, (copy) v_u_numbermaxexclusive
		local v1, v2 = v_u_numberminexclusive(arg1)
		if v1 then
			local v3, v4 = v_u_numbermaxexclusive(arg1)
			if v3 then
				return true
			else
				return false, v4 or ""
			end
		else
			return false, v2 or ""
		end
	end
end
function v_u1.match(self)
	-- upvalues: (copy) v_u1
	assert(v_u1.string(self))
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		local v_string, v1 = v_u1.string(arg1)
		if v_string then
			if string.match(arg1, self) == nil then
				return false, string.format("%q failed to match pattern %q", arg1, self)
			else
				return true
			end
		else
			return false, v1
		end
	end
end
function v_u1.optional(self)
	-- upvalues: (copy) v_u1
	assert(v_u1.callback(self))
	return function(arg1)
		-- upvalues: (copy) self
		if arg1 == nil then
			return true
		else
			local v1, v2 = self(arg1)
			if v1 then
				return true
			else
				return false, string.format("(optional) %s", v2 or "")
			end
		end
	end
end
function v_u1.tuple(...)
	local v_u1 = { ... }
	return function(...)
		-- upvalues: (copy) v_u1
		local v1 = { ... }
		for v2, v3 in ipairs(v_u1) do
			local v4, v5 = v3(v1[v2])
			if v4 == false then
				return false, string.format("Bad tuple index #%s:\n\t%s", v2, v5 or "")
			end
		end
		return true
	end
end
function v_u1.keys(self)
	-- upvalues: (copy) v_u1
	assert(v_u1.callback(self))
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		local v_table, v1 = v_u1.table(arg1)
		if v_table == false then
			return false, v1 or ""
		end
		for v2 in pairs(arg1) do
			local v3, v4 = self(v2)
			if v3 == false then
				return false, string.format("bad key %s:\n\t%s", tostring(v2), v4 or "")
			end
		end
		return true
	end
end
function v_u1.values(self)
	-- upvalues: (copy) v_u1
	assert(v_u1.callback(self))
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		local v_table, v1 = v_u1.table(arg1)
		if v_table == false then
			return false, v1 or ""
		end
		for v2, v3 in pairs(arg1) do
			local v4, v5 = self(v3)
			if v4 == false then
				return false, string.format("bad value for key %s:\n\t%s", tostring(v2), v5 or "")
			end
		end
		return true
	end
end
function v_u1.map(arg1, arg2)
	-- upvalues: (copy) v_u1
	assert(v_u1.callback(arg1))
	assert(v_u1.callback(arg2))
	local v_u_keys = v_u1.keys(arg1)
	local v_u_values = v_u1.values(arg2)
	return function(arg1)
		-- upvalues: (copy) v_u_keys, (copy) v_u_values
		local v1, v2 = v_u_keys(arg1)
		if v1 then
			local v3, v4 = v_u_values(arg1)
			if v3 then
				return true
			else
				return false, v4 or ""
			end
		else
			return false, v2 or ""
		end
	end
end
function v_u1.set(arg1)
	-- upvalues: (copy) v_u1
	return v_u1.map(arg1, v_u1.literal(true))
end
local v_u_keys = v_u1.keys(v_u1.integer)
function v_u1.array(arg1)
	-- upvalues: (copy) v_u1, (copy) v_u_keys
	assert(v_u1.callback(arg1))
	local v_u_values = v_u1.values(arg1)
	return function(arg1)
		-- upvalues: (ref) v_u_keys, (copy) v_u_values
		local v1, v2 = v_u_keys(arg1)
		if v1 == false then
			return false, string.format("[array] %s", v2 or "")
		else
			local v3 = 0
			for _ in ipairs(arg1) do
				v3 = v3 + 1
			end
			for v4 in pairs(arg1) do
				if v4 < 1 or v3 < v4 then
					return false, string.format("[array] key %s must be sequential", (tostring(v4)))
				end
			end
			local v5, v6 = v_u_values(arg1)
			if v5 then
				return true
			else
				return false, string.format("[array] %s", v6 or "")
			end
		end
	end
end
function v_u1.strictArray(...)
	-- upvalues: (copy) v_u1, (copy) v_u_keys
	local v_u1 = { ... }
	local v_array = v_u1.array(v_u1.callback)
	assert(v_array(v_u1))
	return function(arg1)
		-- upvalues: (ref) v_u_keys, (copy) v_u1
		local v1, v2 = v_u_keys(arg1)
		if v1 == false then
			return false, string.format("[strictArray] %s", v2 or "")
		end
		if #v_u1 < #arg1 then
			return false, string.format("[strictArray] Array size exceeds limit of %d", #v_u1)
		end
		for v3, v4 in pairs(v_u1) do
			local v5, v6 = v4(arg1[v3])
			if not v5 then
				return false, string.format("[strictArray] Array index #%d - %s", v3, v6)
			end
		end
		return true
	end
end
local v_u_array = v_u1.array(v_u1.callback)
function v_u1.union(...)
	-- upvalues: (copy) v_u_array
	local v_u1 = { ... }
	assert(v_u_array(v_u1))
	return function(arg1)
		-- upvalues: (copy) v_u1
		for _, v1 in ipairs(v_u1) do
			if v1(arg1) then
				return true
			end
		end
		return false, "bad type for union"
	end
end
v_u1.some = v_u1.union
function v_u1.intersection(...)
	-- upvalues: (copy) v_u_array
	local v_u1 = { ... }
	assert(v_u_array(v_u1))
	return function(arg1)
		-- upvalues: (copy) v_u1
		for _, v1 in ipairs(v_u1) do
			local v2, v3 = v1(arg1)
			if not v2 then
				return false, v3 or ""
			end
		end
		return true
	end
end
v_u1.every = v_u1.intersection
local v_u_map = v_u1.map(v_u1.any, v_u1.callback)
function v_u1.interface(self)
	-- upvalues: (copy) v_u_map, (copy) v_u1
	assert(v_u_map(self))
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		local v_table, v1 = v_u1.table(arg1)
		if v_table == false then
			return false, v1 or ""
		end
		for v2, v3 in pairs(self) do
			local v4, v5 = v3(arg1[v2])
			if v4 == false then
				return false, string.format("[interface] bad value for %s:\n\t%s", tostring(v2), v5 or "")
			end
		end
		return true
	end
end
function v_u1.strictInterface(self)
	-- upvalues: (copy) v_u_map, (copy) v_u1
	assert(v_u_map(self))
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		local v_table, v1 = v_u1.table(arg1)
		if v_table == false then
			return false, v1 or ""
		end
		for v2, v3 in pairs(self) do
			local v4, v5 = v3(arg1[v2])
			if v4 == false then
				return false, string.format("[interface] bad value for %s:\n\t%s", tostring(v2), v5 or "")
			end
		end
		for v6 in pairs(arg1) do
			if not self[v6] then
				return false, string.format("[interface] unexpected field %q", (tostring(v6)))
			end
		end
		return true
	end
end
function v_u1.instanceOf(arg1, arg2)
	-- upvalues: (copy) v_u1
	assert(v_u1.string(arg1))
	local v_u1
	if arg2 == nil then
		v_u1 = nil
	else
		v_u1 = v_u1.children(arg2)
	end
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) arg1, (ref) v_u1
		local v_instance, v1 = v_u1.Instance(arg1)
		if not v_instance then
			return false, v1 or ""
		end
		if arg1.ClassName ~= arg1 then
			return false, string.format("%s expected, got %s", arg1, arg1.ClassName)
		end
		if v_u1 then
			local v2, v3 = v_u1(arg1)
			if not v2 then
				return false, v3
			end
		end
		return true
	end
end
v_u1.instance = v_u1.instanceOf
function v_u1.instanceIsA(arg1, arg2)
	-- upvalues: (copy) v_u1
	assert(v_u1.string(arg1))
	local v_u1
	if arg2 == nil then
		v_u1 = nil
	else
		v_u1 = v_u1.children(arg2)
	end
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) arg1, (ref) v_u1
		local v_instance, v1 = v_u1.Instance(arg1)
		if not v_instance then
			return false, v1 or ""
		end
		if not arg1:IsA(arg1) then
			return false, string.format("%s expected, got %s", arg1, arg1.ClassName)
		end
		if v_u1 then
			local v2, v3 = v_u1(arg1)
			if not v2 then
				return false, v3
			end
		end
		return true
	end
end
function v_u1.enum(self)
	-- upvalues: (copy) v_u1
	assert(v_u1.Enum(self))
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		local v_enumitem, v1 = v_u1.EnumItem(arg1)
		if not v_enumitem then
			return false, v1
		end
		if arg1.EnumType == self then
			return true
		end
		local v2 = tostring(self)
		return false, string.format("enum of %s expected, got enum of %s", v2, (tostring(arg1.EnumType)))
	end
end
local v_u_tuple = v_u1.tuple(v_u1.callback, v_u1.callback)
function v_u1.wrap(arg1, arg2)
	-- upvalues: (copy) v_u_tuple
	assert(v_u_tuple(arg1, arg2))
	return function(...)
		-- upvalues: (copy) arg2, (copy) arg1
		assert(arg2(...))
		return arg1(...)
	end
end
function v_u1.strict(self)
	return function(...)
		-- upvalues: (copy) self
		assert(self(...))
	end
end
local v_u_map = v_u1.map(v_u1.string, v_u1.callback)
function v_u1.children(self)
	-- upvalues: (copy) v_u_map, (copy) v_u1
	assert(v_u_map(self))
	return function(arg1)
		-- upvalues: (ref) v_u1, (copy) self
		local v_instance, v1 = v_u1.Instance(arg1)
		if not v_instance then
			return false, v1 or ""
		end
		local v2 = {}
		for _, v3 in ipairs(arg1:GetChildren()) do
			local v_name = v3.Name
			if self[v_name] then
				if v2[v_name] then
					return false, string.format("Cannot process multiple children with the same name %q", v_name)
				end
				v2[v_name] = v3
			end
		end
		for v4, v5 in pairs(self) do
			local v6, v7 = v5(v2[v4])
			if not v6 then
				return false, string.format("[%s.%s] %s", arg1:GetFullName(), v4, v7 or "")
			end
		end
		return true
	end
end
return v_u1