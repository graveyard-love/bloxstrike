-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_u_http = game:GetService("HttpService")
local v_u_new = Random.new()
local function v_u2(arg1, arg2)
	-- upvalues: (copy) v_u2
	assert(type(arg1) == "table", "First argument must be a table")
	assert(type(arg2) == "table", "Second argument must be a table")
	local v_clone = table.clone(arg1)
	for v1, v2 in pairs(v_clone) do
		local v3 = arg2[v1]
		if v3 == nil then
			v_clone[v1] = nil
		elseif type(v2) == type(v3) then
			if type(v2) == "table" then
				v_clone[v1] = v_u2(v2, v3)
			end
		elseif type(v3) == "table" then
			local function v_u4(arg1)
				-- upvalues: (copy) v_u4
				local v_clone = table.clone(arg1)
				for v1, v2 in v_clone do
					if type(v2) == "table" then
						v_clone[v1] = v_u4(v2)
					end
				end
				return v_clone
			end
			v_clone[v1] = v_u4(v3)
		else
			v_clone[v1] = v3
		end
	end
	for v5, v6 in pairs(arg2) do
		if v_clone[v5] == nil then
			if type(v6) == "table" then
				local function v_u7(arg1)
					-- upvalues: (copy) v_u7
					local v_clone = table.clone(arg1)
					for v1, v2 in v_clone do
						if type(v2) == "table" then
							v_clone[v1] = v_u7(v2)
						end
					end
					return v_clone
				end
				v_clone[v5] = v_u7(v6)
			else
				v_clone[v5] = v6
			end
		end
	end
	return v_clone
end
local function v_u3(arg1, arg2)
	-- upvalues: (copy) v_u3
	assert(type(arg1) == "table", "First argument must be a table")
	assert(type(arg2) == "table", "Second argument must be a table")
	local v_clone = table.clone(arg1)
	for v1, v2 in arg2 do
		local v3 = arg1[v1]
		if v3 == nil then
			if type(v2) == "table" then
				local function v_u4(arg1)
					-- upvalues: (copy) v_u4
					local v_clone = table.clone(arg1)
					for v1, v2 in v_clone do
						if type(v2) == "table" then
							v_clone[v1] = v_u4(v2)
						end
					end
					return v_clone
				end
				v_clone[v1] = v_u4(v2)
			else
				v_clone[v1] = v2
			end
		elseif type(v3) == "table" then
			if type(v2) == "table" then
				v_clone[v1] = v_u3(v3, v2)
			else
				local function v_u5(arg1)
					-- upvalues: (copy) v_u5
					local v_clone = table.clone(arg1)
					for v1, v2 in v_clone do
						if type(v2) == "table" then
							v_clone[v1] = v_u5(v2)
						end
					end
					return v_clone
				end
				v_clone[v1] = v_u5(v3)
			end
		end
	end
	return v_clone
end
local function v_u4(arg1, arg2)
	assert(type(arg1) == "table", "First argument must be a table")
	assert(type(arg2) == "function", "Second argument must be a function")
	local v_create = table.create(#arg1)
	for v1, v2 in arg1 do
		v_create[v1] = arg2(v2, v1, arg1)
	end
	return v_create
end
function v1.Copy(arg1, arg2)
	if not arg2 then
		return table.clone(arg1)
	end
	local function v_u1(arg1)
		-- upvalues: (copy) v_u1
		local v_clone = table.clone(arg1)
		for v1, v2 in v_clone do
			if type(v2) == "table" then
				v_clone[v1] = v_u1(v2)
			end
		end
		return v_clone
	end
	return v_u1(arg1)
end
v1.Sync = v_u2
v1.Reconcile = v_u3
function v1.SwapRemove(arg1, arg2)
	local v1 = #arg1
	arg1[arg2] = arg1[v1]
	arg1[v1] = nil
end
function v1.SwapRemoveFirstValue(arg1, arg2)
	local v_find = table.find(arg1, arg2)
	if v_find then
		local v1 = #arg1
		arg1[v_find] = arg1[v1]
		arg1[v1] = nil
	end
	return v_find
end
v1.Map = v_u4
function v1.Filter(arg1, arg2)
	assert(type(arg1) == "table", "First argument must be a table")
	assert(type(arg2) == "function", "Second argument must be a function")
	local v_create = table.create(#arg1)
	if #arg1 <= 0 then
		for v1, v2 in arg1 do
			if arg2(v2, v1, arg1) then
				v_create[v1] = v2
			end
		end
		return v_create
	end
	local v3 = 0
	for v4, v5 in arg1 do
		if arg2(v5, v4, arg1) then
			v3 = v3 + 1
			v_create[v3] = v5
		end
	end
	return v_create
end
function v1.Reduce(arg1, arg2, arg3)
	assert(type(arg1) == "table", "First argument must be a table")
	assert(type(arg2) == "function", "Second argument must be a function")
	if #arg1 > 0 then
		local v1
		if arg3 == nil then
			arg3 = arg1[1]
			v1 = 2
		else
			v1 = 1
		end
		for v2 = v1, #arg1 do
			arg3 = arg2(arg3, arg1[v2], v2, arg1)
		end
		return arg3
	else
		local v3
		if arg3 == nil then
			v3 = next(arg1)
			arg3 = v3
		else
			v3 = nil
		end
		for v4, v5 in next, arg1, v3 do
			arg3 = arg2(arg3, v5, v4, arg1)
		end
		return arg3
	end
end
function v1.Assign(arg1, ...)
	local v_clone = table.clone(arg1)
	for _, v1 in { ... } do
		for v2, v3 in v1 do
			v_clone[v2] = v3
		end
	end
	return v_clone
end
function v1.Extend(arg1, arg2)
	local v_clone = table.clone(arg1)
	for _, v1 in arg2 do
		table.insert(v_clone, v1)
	end
	return v_clone
end
function v1.Reverse(arg1)
	local v1 = #arg1
	local v_create = table.create(v1)
	for v2 = 1, v1 do
		v_create[v2] = arg1[v1 - v2 + 1]
	end
	return v_create
end
function v1.Shuffle(arg1, arg2)
	-- upvalues: (copy) v_u_new
	assert(type(arg1) == "table", "First argument must be a table")
	local v_clone = table.clone(arg1)
	if typeof(arg2) ~= "Random" then
		arg2 = v_u_new
	end
	for v1 = #arg1, 2, -1 do
		local v_nextinteger = arg2:NextInteger(1, v1)
		v_clone[v1] = v_clone[v_nextinteger]
		v_clone[v_nextinteger] = v_clone[v1]
	end
	return v_clone
end
function v1.Sample(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_new
	assert(type(arg1) == "table", "First argument must be a table")
	assert(type(arg2) == "number", "Second argument must be a number")
	local v1 = #arg1
	if v1 == 0 then
		return {}
	end
	local v_clone = table.clone(arg1)
	local v_create = table.create(arg2)
	if typeof(arg3) ~= "Random" then
		arg3 = v_u_new
	end
	local v_clamp = math.clamp(arg2, 1, v1)
	for v2 = 1, v_clamp do
		local v_nextinteger = arg3:NextInteger(v2, v1)
		v_clone[v2] = v_clone[v_nextinteger]
		v_clone[v_nextinteger] = v_clone[v2]
	end
	table.move(v_clone, 1, v_clamp, 1, v_create)
	return v_create
end
function v1.Flat(arg1, arg2)
	local v_u1 = type(arg2) ~= "number" and 1 or arg2
	local v_u_create = table.create(#arg1)
	local function v_u2(arg1, arg2)
		-- upvalues: (copy) v_u1, (copy) v_u2, (copy) v_u_create
		for _, v1 in arg1 do
			if type(v1) == "table" and arg2 < v_u1 then
				v_u2(v1, arg2 + 1)
			else
				table.insert(v_u_create, v1)
			end
		end
	end
	v_u2(arg1, 0)
	return v_u_create
end
function v1.FlatMap(arg1, arg2)
	-- upvalues: (copy) v_u4
	local v1 = v_u4(arg1, arg2)
	local v_u_create = table.create(#v1)
	local v_u2 = 1
	local function v_u3(arg1, arg2)
		-- upvalues: (copy) v_u2, (copy) v_u3, (copy) v_u_create
		for _, v1 in arg1 do
			if type(v1) == "table" and arg2 < v_u2 then
				v_u3(v1, arg2 + 1)
			else
				table.insert(v_u_create, v1)
			end
		end
	end
	v_u3(v1, 0)
	return v_u_create
end
function v1.Keys(arg1)
	local v_create = table.create(#arg1)
	for v1 in arg1 do
		table.insert(v_create, v1)
	end
	return v_create
end
function v1.Values(arg1)
	local v_create = table.create(#arg1)
	for _, v1 in arg1 do
		table.insert(v_create, v1)
	end
	return v_create
end
function v1.Find(arg1, arg2)
	for v1, v2 in arg1 do
		if arg2(v2, v1, arg1) then
			return v2, v1
		end
	end
	return nil, nil
end
function v1.Every(arg1, arg2)
	for v1, v2 in arg1 do
		if not arg2(v2, v1, arg1) then
			return false
		end
	end
	return true
end
function v1.Some(arg1, arg2)
	for v1, v2 in arg1 do
		if arg2(v2, v1, arg1) then
			return true
		end
	end
	return false
end
function v1.Truncate(arg1, arg2)
	local v1 = #arg1
	local v_clamp = math.clamp(arg2, 1, v1)
	if v_clamp == v1 then
		return table.clone(arg1)
	else
		return table.move(arg1, 1, v_clamp, 1, table.create(v_clamp))
	end
end
function v1.Zip(...)
	assert(select("#", ...) > 0, "Must supply at least 1 table")
	local function v1(arg1, arg2)
		local v1 = arg2 + 1
		local v2 = {}
		for v3, v4 in arg1 do
			local v5 = v4[v1]
			if v5 == nil then
				return nil, nil
			end
			v2[v3] = v5
		end
		return v1, v2
	end
	local function v2(arg1, arg2)
		local v1 = {}
		for v2, v3 in arg1 do
			local v4 = next(v3, arg2)
			if v4 == nil then
				return nil, nil
			end
			v1[v2] = v4
		end
		return arg2, v1
	end
	local v3 = { ... }
	if #v3[1] > 0 then
		return v1, v3, 0
	else
		return v2, v3, nil
	end
end
function v1.Lock(arg1)
	local function v_u1(arg1)
		-- upvalues: (copy) v_u1
		for v1, v2 in pairs(arg1) do
			if type(v2) == "table" then
				arg1[v1] = v_u1(v2)
			end
		end
		return table.freeze(arg1)
	end
	return v_u1(arg1)
end
function v1.IsEmpty(arg1)
	return next(arg1) == nil
end
function v1.EncodeJSON(arg1)
	-- upvalues: (copy) v_u_http
	return v_u_http:JSONEncode(arg1)
end
function v1.DecodeJSON(arg1)
	-- upvalues: (copy) v_u_http
	return v_u_http:JSONDecode(arg1)
end
return v1