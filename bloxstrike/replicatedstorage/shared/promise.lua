-- Decompiled with Bunni.lol Decompiler

local v_u1 = {
	["__mode"] = "k"
}
local function v2(arg1, arg2)
	local v1 = {}
	for _, v2 in ipairs(arg2) do
		v1[v2] = v2
	end
	return setmetatable(v1, {
		["__index"] = function(_, arg2)
			-- upvalues: (copy) arg1
			error(string.format("%s is not in %s!", arg2, arg1), 2)
		end,
		["__newindex"] = function()
			-- upvalues: (copy) arg1
			error(string.format("Creating new members in %s is not allowed!", arg1), 2)
		end
	})
end
local v_u3 = {
	["Kind"] = v2("Promise.Error.Kind", {
		"ExecutionError",
		"AlreadyCancelled",
		"NotResolvedInTime",
		"TimedOut"
	})
}
v_u3.__index = v_u3
function v_u3.new(arg1, arg2)
	-- upvalues: (ref) v_u3
	local v1 = arg1 or {}
	return setmetatable({
		["error"] = tostring(v1.error) or "[This error has no error text.]",
		["trace"] = v1.trace,
		["context"] = v1.context,
		["kind"] = v1.kind,
		["parent"] = arg2,
		["createdTick"] = os.clock(),
		["createdTrace"] = debug.traceback()
	}, v_u3)
end
function v_u3.is(arg1)
	if type(arg1) == "table" then
		local v1 = getmetatable(arg1)
		if type(v1) == "table" then
			local v2
			if rawget(arg1, "error") == nil then
				v2 = false
			else
				local v3 = rawget(v1, "extend")
				v2 = type(v3) == "function"
			end
			return v2
		end
	end
	return false
end
function v_u3.isKind(arg1, arg2)
	-- upvalues: (ref) v_u3
	assert(arg2 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil")
	local v_is = v_u3.is(arg1)
	if v_is then
		v_is = arg1.kind == arg2
	end
	return v_is
end
function v_u3.extend(arg1, arg2)
	-- upvalues: (ref) v_u3
	local v1 = arg2 or {}
	v1.kind = v1.kind or arg1.kind
	return v_u3.new(v1, arg1)
end
function v_u3.getErrorChain(arg1)
	local v1 = { arg1 }
	while v1[#v1].parent do
		table.insert(v1, v1[#v1].parent)
	end
	return v1
end
function v_u3.__tostring(arg1)
	local v1 = { string.format("-- Promise.Error(%s) --", arg1.kind or "?") }
	for _, v2 in ipairs(arg1:getErrorChain()) do
		table.insert(v1, table.concat({ v2.trace or v2.error, v2.context }, "\n"))
	end
	return table.concat(v1, "\n")
end
local function v_u4(...)
	return select("#", ...), { ... }
end
local function v_u5(arg1, ...)
	return arg1, select("#", ...), { ... }
end
local function v_u6(arg1, arg2, ...)
	-- upvalues: (copy) v_u5, (ref) v_u3
	local v1 = xpcall
	assert(arg1 ~= nil)
	return v_u5(v1(arg2, function(arg1)
		-- upvalues: (ref) v_u3, (copy) arg1
		if type(arg1) == "table" then
			return arg1
		else
			return v_u3.new({
				["error"] = arg1,
				["kind"] = v_u3.Kind.ExecutionError,
				["trace"] = debug.traceback(tostring(arg1), 2),
				["context"] = "Promise created at:\n\n" .. arg1
			})
		end
	end, ...))
end
local v_u7 = {
	["Error"] = v_u3,
	["Status"] = v2("Promise.Status", {
		"Started",
		"Resolved",
		"Rejected",
		"Cancelled"
	}),
	["_getTime"] = os.clock,
	["_timeEvent"] = game:GetService("RunService").Heartbeat,
	["prototype"] = {}
}
v_u7.__index = v_u7.prototype
function v_u7._new(arg1, arg2, arg3)
	-- upvalues: (copy) v_u7, (copy) v_u1, (copy) v_u6
	if arg3 ~= nil and not v_u7.is(arg3) then
		error("Argument #2 to Promise.new must be a promise or nil", 2)
	end
	local v_u1 = {
		["_source"] = arg1,
		["_status"] = v_u7.Status.Started,
		["_values"] = nil,
		["_valuesLength"] = -1,
		["_unhandledRejection"] = true,
		["_queuedResolve"] = {},
		["_queuedReject"] = {},
		["_queuedFinally"] = {},
		["_cancellationHook"] = nil,
		["_parent"] = arg3,
		["_consumers"] = setmetatable({}, v_u1)
	}
	if arg3 and arg3._status == v_u7.Status.Started then
		arg3._consumers[v_u1] = true
	end
	setmetatable(v_u1, v_u7)
	local function v_u2(...)
		-- upvalues: (copy) v_u1
		v_u1:_resolve(...)
	end
	local function v_u3(...)
		-- upvalues: (copy) v_u1
		v_u1:_reject(...)
	end
	local function v_u4(arg1)
		-- upvalues: (copy) v_u1, (ref) v_u7
		if arg1 then
			if v_u1._status == v_u7.Status.Cancelled then
				arg1()
			else
				v_u1._cancellationHook = arg1
			end
		end
		return v_u1._status == v_u7.Status.Cancelled
	end
	coroutine.wrap(function()
		-- upvalues: (ref) v_u6, (copy) v_u1, (copy) arg2, (copy) v_u2, (copy) v_u3, (copy) v_u4
		local v1, _, v2 = v_u6(v_u1._source, arg2, v_u2, v_u3, v_u4)
		if not v1 then
			v_u3(v2[1])
		end
	end)()
	return v_u1
end
function v_u7.new(arg1)
	-- upvalues: (copy) v_u7
	return v_u7._new(debug.traceback(nil, 2), arg1)
end
function v_u7.__tostring(arg1)
	return string.format("Promise(%s)", arg1:getStatus())
end
function v_u7.defer(self)
	-- upvalues: (copy) v_u7, (copy) v_u6
	local v_u_traceback = debug.traceback(nil, 2)
	return v_u7._new(v_u_traceback, function(arg1, arg2, arg3)
		-- upvalues: (ref) v_u7, (ref) v_u6, (copy) v_u_traceback, (copy) self
		local v_u1 = nil
		v_u1 = v_u7._timeEvent:Connect(function()
			-- upvalues: (ref) v_u1, (ref) v_u6, (ref) v_u_traceback, (ref) self, (copy) arg1, (copy) arg2, (copy) arg3
			v_u1:Disconnect()
			local v1, _, v2 = v_u6(v_u_traceback, self, arg1, arg2, arg3)
			if not v1 then
				arg2(v2[1])
			end
		end)
	end)
end
v_u7.async = v_u7.defer
function v_u7.resolve(...)
	-- upvalues: (copy) v_u4, (copy) v_u7
	local v_u1, v_u2 = v_u4(...)
	return v_u7._new(debug.traceback(nil, 2), function(arg1)
		-- upvalues: (copy) v_u2, (copy) v_u1
		arg1(unpack(v_u2, 1, v_u1))
	end)
end
function v_u7.reject(...)
	-- upvalues: (copy) v_u4, (copy) v_u7
	local v_u1, v_u2 = v_u4(...)
	return v_u7._new(debug.traceback(nil, 2), function(_, arg2)
		-- upvalues: (copy) v_u2, (copy) v_u1
		arg2(unpack(v_u2, 1, v_u1))
	end)
end
function v_u7._try(arg1, arg2, ...)
	-- upvalues: (copy) v_u4, (copy) v_u7
	local v_u1, v_u2 = v_u4(...)
	return v_u7._new(arg1, function(arg1)
		-- upvalues: (copy) arg2, (copy) v_u2, (copy) v_u1
		arg1(arg2(unpack(v_u2, 1, v_u1)))
	end)
end
function v_u7.try(...)
	-- upvalues: (copy) v_u7
	return v_u7._try(debug.traceback(nil, 2), ...)
end
function v_u7._all(arg1, arg2, arg3)
	-- upvalues: (copy) v_u7
	if type(arg2) ~= "table" then
		error(string.format("Please pass a list of promises to %s", "Promise.all"), 3)
	end
	for v1, v2 in pairs(arg2) do
		if not v_u7.is(v2) then
			error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(v1))), 3)
		end
	end
	if #arg2 == 0 or arg3 == 0 then
		return v_u7.resolve({})
	else
		return v_u7._new(arg1, function(arg1, arg2, arg3)
			-- upvalues: (copy) arg3, (copy) arg2
			local v_u1 = {}
			local v_u2 = {}
			local v_u3 = 0
			local v_u4 = 0
			local v_u5 = false
			local function v_u6(arg1, ...)
				-- upvalues: (ref) v_u5, (ref) v_u3, (ref) arg3, (copy) v_u1, (ref) arg2, (copy) arg1, (copy) v_u2
				if not v_u5 then
					v_u3 = v_u3 + 1
					if arg3 == nil then
						v_u1[arg1] = ...
					else
						v_u1[v_u3] = ...
					end
					if v_u3 >= (arg3 or #arg2) then
						v_u5 = true
						arg1(v_u1)
						for _, v1 in ipairs(v_u2) do
							v1:cancel()
						end
					end
				end
			end
			arg3(function()
				-- upvalues: (copy) v_u2
				for _, v1 in ipairs(v_u2) do
					v1:cancel()
				end
			end)
			local v_u7 = v_u5
			for v_u8, v9 in ipairs(arg2) do
				v_u2[v_u8] = v9:andThen(function(...)
					-- upvalues: (copy) v_u6, (copy) v_u8
					v_u6(v_u8, ...)
				end, function(...)
					-- upvalues: (ref) v_u4, (ref) arg3, (ref) arg2, (copy) v_u2, (ref) v_u7, (copy) arg2
					v_u4 = v_u4 + 1
					if arg3 == nil or #arg2 - v_u4 < arg3 then
						for _, v1 in ipairs(v_u2) do
							v1:cancel()
						end
						v_u7 = true
						arg2(...)
					end
				end)
			end
			if v_u7 then
				for _, v10 in ipairs(v_u2) do
					v10:cancel()
				end
			end
		end)
	end
end
function v_u7.all(arg1)
	-- upvalues: (copy) v_u7
	return v_u7._all(debug.traceback(nil, 2), arg1)
end
function v_u7.some(arg1, arg2)
	-- upvalues: (copy) v_u7
	assert(type(arg2) == "number", "Bad argument #2 to Promise.some: must be a number")
	return v_u7._all(debug.traceback(nil, 2), arg1, arg2)
end
function v_u7.any(arg1)
	-- upvalues: (copy) v_u7
	return v_u7._all(debug.traceback(nil, 2), arg1, 1):andThen(function(arg1)
		return arg1[1]
	end)
end
function v_u7.allSettled(self)
	-- upvalues: (copy) v_u7
	if type(self) ~= "table" then
		error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2)
	end
	for v1, v2 in pairs(self) do
		if not v_u7.is(v2) then
			error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(v1))), 2)
		end
	end
	if #self == 0 then
		return v_u7.resolve({})
	else
		return v_u7._new(debug.traceback(nil, 2), function(arg1, _, arg3)
			-- upvalues: (copy) self
			local v_u1 = {}
			local v_u2 = {}
			local v_u3 = 0
			local function v_u4(arg1, ...)
				-- upvalues: (ref) v_u3, (copy) v_u1, (ref) self, (copy) arg1
				v_u1[arg1] = ...
				if v_u3 + 1 >= #self then
					arg1(v_u1)
				end
			end
			arg3(function()
				-- upvalues: (copy) v_u2
				for _, v1 in ipairs(v_u2) do
					v1:cancel()
				end
			end)
			for v_u5, v6 in ipairs(self) do
				v_u2[v_u5] = v6:finally(function(...)
					-- upvalues: (copy) v_u4, (copy) v_u5
					v_u4(v_u5, ...)
				end)
			end
		end)
	end
end
function v_u7.race(self)
	-- upvalues: (copy) v_u7
	assert(type(self) == "table", string.format("Please pass a list of promises to %s", "Promise.race"))
	for v1, v2 in pairs(self) do
		local v_is = v_u7.is(v2)
		local v3 = tostring(v1)
		assert(v_is, string.format("Non-promise value passed into %s at index %s", "Promise.race", v3))
	end
	return v_u7._new(debug.traceback(nil, 2), function(arg1, arg2, arg3)
		-- upvalues: (copy) self
		local v_u1 = {}
		local v_u2 = false
		if not arg3(function(...)
			-- upvalues: (copy) v_u1, (ref) v_u2, (copy) arg2
			for _, v1 in ipairs(v_u1) do
				v1:cancel()
			end
			v_u2 = true
			return arg2(...)
		end) then
			local v_u3 = v_u2
			for v4, v5 in ipairs(self) do
				v_u1[v4] = v5:andThen(function(...)
					-- upvalues: (copy) v_u1, (ref) v_u3, (copy) arg1
					for _, v1 in ipairs(v_u1) do
						v1:cancel()
					end
					v_u3 = true
					return arg1(...)
				end, function(...)
					-- upvalues: (copy) v_u1, (ref) v_u3, (copy) arg2
					for _, v1 in ipairs(v_u1) do
						v1:cancel()
					end
					v_u3 = true
					return arg2(...)
				end)
			end
			if v_u3 then
				for _, v6 in ipairs(v_u1) do
					v6:cancel()
				end
			end
		end
	end)
end
function v_u7.each(arg1, arg2)
	-- upvalues: (copy) v_u7, (ref) v_u3
	assert(type(arg1) == "table", string.format("Please pass a list of promises to %s", "Promise.each"))
	assert(type(arg2) == "function", string.format("Please pass a handler function to %s!", "Promise.each"))
	return v_u7._new(debug.traceback(nil, 2), function(arg1, arg2, arg3)
		-- upvalues: (copy) arg1, (ref) v_u7, (ref) v_u3, (copy) arg2
		local v1 = {}
		local v_u2 = {}
		local v_u3 = false
		arg3(function()
			-- upvalues: (ref) v_u3, (copy) v_u2
			v_u3 = true
			for _, v1 in ipairs(v_u2) do
				v1:cancel()
			end
		end)
		local v4 = v_u3
		local v5 = {}
		for v6, v7 in ipairs(arg1) do
			if v_u7.is(v7) then
				if v7:getStatus() == v_u7.Status.Cancelled then
					for _, v8 in ipairs(v_u2) do
						v8:cancel()
					end
					return arg2(v_u3.new({
						["error"] = "Promise is cancelled",
						["kind"] = v_u3.Kind.AlreadyCancelled,
						["context"] = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", v6, v7._source)
					}))
				end
				if v7:getStatus() == v_u7.Status.Rejected then
					for _, v9 in ipairs(v_u2) do
						v9:cancel()
					end
					return arg2(select(2, v7:await()))
				end
				local v_andthen = v7:andThen(function(...)
					return ...
				end)
				table.insert(v_u2, v_andthen)
				v5[v6] = v_andthen
			else
				v5[v6] = v7
			end
		end
		for v10, v12 in ipairs(v5) do
			if v_u7.is(v12) then
				local v_await, v12 = v12:await()
				if not v_await then
					for _, v13 in ipairs(v_u2) do
						v13:cancel()
					end
					return arg2(v12)
				end
			end
			if v4 then
				return
			end
			local v_resolve = v_u7.resolve(arg2(v12, v10))
			table.insert(v_u2, v_resolve)
			local v_await, v14 = v_resolve:await()
			if not v_await then
				for _, v15 in ipairs(v_u2) do
					v15:cancel()
				end
				return arg2(v14)
			end
			v1[v10] = v14
		end
		arg1(v1)
	end)
end
function v_u7.is(arg1)
	-- upvalues: (copy) v_u7
	if type(arg1) ~= "table" then
		return false
	end
	local v1 = getmetatable(arg1)
	if v1 == v_u7 then
		return true
	end
	if v1 == nil then
		return type(arg1.andThen) == "function"
	end
	if type(v1) == "table" then
		local v2 = rawget(v1, "__index")
		if type(v2) == "table" then
			local v3 = rawget(v1, "__index")
			local v4 = rawget(v3, "andThen")
			if type(v4) == "function" then
				return true
			end
		end
	end
	return false
end
function v_u7.promisify(self)
	-- upvalues: (copy) v_u7
	return function(...)
		-- upvalues: (ref) v_u7, (copy) self
		return v_u7._try(debug.traceback(nil, 2), self, ...)
	end
end
local v_u8 = nil
local v_u9 = nil
function v_u7.delay(arg1)
	-- upvalues: (copy) v_u7, (ref) v_u9, (ref) v_u8
	assert(type(arg1) == "number", "Bad argument #1 to Promise.delay, must be a number.")
	local v_u1 = (arg1 < 0.016666666666666666 or arg1 == (1 / 0)) and 0.016666666666666666 or arg1
	return v_u7._new(debug.traceback(nil, 2), function(arg1, _, arg3)
		-- upvalues: (ref) v_u7, (ref) v_u1, (ref) v_u9, (ref) v_u8
		local v__gettime = v_u7._getTime()
		local v1 = v__gettime + v_u1
		local v_u2 = {
			["resolve"] = arg1,
			["startTime"] = v__gettime,
			["endTime"] = v1
		}
		if v_u9 == nil then
			v_u8 = v_u2
			v_u9 = v_u7._timeEvent:Connect(function()
				-- upvalues: (ref) v_u7, (ref) v_u8, (ref) v_u9
				local v__gettime = v_u7._getTime()
				while v_u8 ~= nil and v_u8.endTime < v__gettime do
					local v1 = v_u8
					if v1.next == nil then
						v_u9:Disconnect()
						v_u9 = nil
					else
						v_u8.previous = nil
					end
					v1.resolve(v_u7._getTime() - v1.startTime)
				end
			end)
		elseif v_u8.endTime < v1 then
			local v3 = v_u8
			local v_next = v3.next
			while v_next ~= nil and v_next.endTime < v1 do
				local v_next = v_next.next
				v3 = v_next
				v_next = v_next
			end
			v3.next = v_u2
			v_u2.previous = v3
			if v_next ~= nil then
				v_u2.next = v_next
				v_next.previous = v_u2
			end
		else
			v_u2.next = v_u8
			v_u8.previous = v_u2
			v_u8 = v_u2
		end
		arg3(function()
			-- upvalues: (copy) v_u2, (ref) v_u8, (ref) v_u9
			local v_next = v_u2.next
			if v_u8 == v_u2 then
				if v_next == nil then
					v_u9:Disconnect()
					v_u9 = nil
				else
					v_next.previous = nil
				end
				v_u8 = v_next
			else
				local v_previous = v_u2.previous
				v_previous.next = v_next
				if v_next ~= nil then
					v_next.previous = v_previous
				end
			end
		end)
	end)
end
local function v10(arg1, arg2, arg3)
	-- upvalues: (copy) v_u7, (ref) v_u3
	local v_u_traceback = debug.traceback(nil, 2)
	return v_u7.race({ v_u7.delay(arg2):andThen(function()
			-- upvalues: (ref) v_u7, (copy) arg3, (ref) v_u3, (copy) arg2, (copy) v_u_traceback
			return v_u7.reject(arg3 == nil and v_u3.new({
				["kind"] = v_u3.Kind.TimedOut,
				["error"] = "Timed out",
				["context"] = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", arg2, v_u_traceback)
			}) or arg3)
		end), arg1 })
end
v_u7.prototype.timeout = v10
function v_u7.prototype.getStatus(arg1)
	return arg1._status
end
local function v11(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u7, (copy) v_u6, (ref) v_u3
	arg1._unhandledRejection = false
	return v_u7._new(arg2, function(arg1, arg2)
		-- upvalues: (copy) arg3, (copy) arg2, (ref) v_u6, (copy) arg4, (copy) arg1, (ref) v_u7, (ref) v_u3
		local v1
		if arg3 then
			local v_u2 = arg2
			local v_u3 = arg3
			v1 = function(...)
				-- upvalues: (ref) v_u6, (copy) v_u2, (copy) v_u3, (copy) arg1, (copy) arg2
				local v1, v2, v3 = v_u6(v_u2, v_u3, ...)
				if v1 then
					arg1(unpack(v3, 1, v2))
				else
					arg2(v3[1])
				end
			end
		else
			v1 = arg1
		end
		local v4
		if arg4 then
			local v_u5 = arg2
			local v_u6 = arg4
			v4 = function(...)
				-- upvalues: (ref) v_u6, (copy) v_u5, (copy) v_u6, (copy) arg1, (copy) arg2
				local v1, v2, v3 = v_u6(v_u5, v_u6, ...)
				if v1 then
					arg1(unpack(v3, 1, v2))
				else
					arg2(v3[1])
				end
			end
		else
			v4 = arg2
		end
		if arg1._status == v_u7.Status.Started then
			table.insert(arg1._queuedResolve, v1)
			table.insert(arg1._queuedReject, v4)
			return
		elseif arg1._status == v_u7.Status.Resolved then
			v1(unpack(arg1._values, 1, arg1._valuesLength))
			return
		elseif arg1._status == v_u7.Status.Rejected then
			v4(unpack(arg1._values, 1, arg1._valuesLength))
		elseif arg1._status == v_u7.Status.Cancelled then
			arg2(v_u3.new({
				["error"] = "Promise is cancelled",
				["kind"] = v_u3.Kind.AlreadyCancelled,
				["context"] = "Promise created at\n\n" .. arg2
			}))
		end
	end, arg1)
end
v_u7.prototype._andThen = v11
function v_u7.prototype.andThen(arg1, arg2, arg3)
	assert(arg2 == nil and true or type(arg2) == "function", string.format("Please pass a handler function to %s!", "Promise:andThen"))
	assert(arg3 == nil and true or type(arg3) == "function", string.format("Please pass a handler function to %s!", "Promise:andThen"))
	return arg1:_andThen(debug.traceback(nil, 2), arg2, arg3)
end
function v_u7.prototype.catch(arg1, arg2)
	assert(arg2 == nil and true or type(arg2) == "function", string.format("Please pass a handler function to %s!", "Promise:catch"))
	return arg1:_andThen(debug.traceback(nil, 2), nil, arg2)
end
function v_u7.prototype.tap(arg1, arg2)
	-- upvalues: (copy) v_u7, (copy) v_u4
	assert(type(arg2) == "function", string.format("Please pass a handler function to %s!", "Promise:tap"))
	return arg1:_andThen(debug.traceback(nil, 2), function(...)
		-- upvalues: (copy) arg2, (ref) v_u7, (ref) v_u4
		local v1 = arg2(...)
		if not v_u7.is(v1) then
			return ...
		end
		local v_u2, v_u3 = v_u4(...)
		return v1:andThen(function()
			-- upvalues: (copy) v_u3, (copy) v_u2
			return unpack(v_u3, 1, v_u2)
		end)
	end)
end
function v_u7.prototype.andThenCall(arg1, arg2, ...)
	-- upvalues: (copy) v_u4
	assert(type(arg2) == "function", string.format("Please pass a handler function to %s!", "Promise:andThenCall"))
	local v_u1, v_u2 = v_u4(...)
	return arg1:_andThen(debug.traceback(nil, 2), function()
		-- upvalues: (copy) arg2, (copy) v_u2, (copy) v_u1
		return arg2(unpack(v_u2, 1, v_u1))
	end)
end
function v_u7.prototype.andThenReturn(arg1, ...)
	-- upvalues: (copy) v_u4
	local v_u1, v_u2 = v_u4(...)
	return arg1:_andThen(debug.traceback(nil, 2), function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		return unpack(v_u2, 1, v_u1)
	end)
end
function v_u7.prototype.cancel(arg1)
	-- upvalues: (copy) v_u7
	if arg1._status == v_u7.Status.Started then
		arg1._status = v_u7.Status.Cancelled
		if arg1._cancellationHook then
			arg1._cancellationHook()
		end
		if arg1._parent then
			arg1._parent:_consumerCancelled(arg1)
		end
		for v1 in pairs(arg1._consumers) do
			v1:cancel()
		end
		arg1:_finalize()
	end
end
function v_u7.prototype._consumerCancelled(arg1, arg2)
	-- upvalues: (copy) v_u7
	if arg1._status == v_u7.Status.Started then
		arg1._consumers[arg2] = nil
		if next(arg1._consumers) == nil then
			arg1:cancel()
		end
	end
end
function v_u7.prototype._finally(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u7, (copy) v_u6
	if not arg4 then
		arg1._unhandledRejection = false
	end
	return v_u7._new(arg2, function(arg1, arg2)
		-- upvalues: (copy) arg3, (copy) arg2, (ref) v_u6, (copy) arg4, (copy) arg1, (ref) v_u7
		local v_u1
		if arg3 then
			local v_u2 = arg2
			local v_u3 = arg3
			v_u1 = function(...)
				-- upvalues: (ref) v_u6, (copy) v_u2, (copy) v_u3, (copy) arg1, (copy) arg2
				local v1, v2, v3 = v_u6(v_u2, v_u3, ...)
				if v1 then
					arg1(unpack(v3, 1, v2))
				else
					arg2(v3[1])
				end
			end
		else
			v_u1 = arg1
		end
		local v4 = arg4 and function(...)
			-- upvalues: (ref) arg1, (ref) v_u7, (copy) arg1, (copy) v_u1
			if arg1._status == v_u7.Status.Rejected then
				return arg1(arg1)
			else
				return v_u1(...)
			end
		end or v_u1
		if arg1._status == v_u7.Status.Started then
			table.insert(arg1._queuedFinally, v4)
		else
			v4(arg1._status)
		end
	end, arg1)
end
function v_u7.prototype.finally(arg1, arg2)
	assert(arg2 == nil and true or type(arg2) == "function", string.format("Please pass a handler function to %s!", "Promise:finally"))
	return arg1:_finally(debug.traceback(nil, 2), arg2)
end
function v_u7.prototype.finallyCall(arg1, arg2, ...)
	-- upvalues: (copy) v_u4
	assert(type(arg2) == "function", string.format("Please pass a handler function to %s!", "Promise:finallyCall"))
	local v_u1, v_u2 = v_u4(...)
	return arg1:_finally(debug.traceback(nil, 2), function()
		-- upvalues: (copy) arg2, (copy) v_u2, (copy) v_u1
		return arg2(unpack(v_u2, 1, v_u1))
	end)
end
function v_u7.prototype.finallyReturn(arg1, ...)
	-- upvalues: (copy) v_u4
	local v_u1, v_u2 = v_u4(...)
	return arg1:_finally(debug.traceback(nil, 2), function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		return unpack(v_u2, 1, v_u1)
	end)
end
function v_u7.prototype.done(arg1, arg2)
	assert(arg2 == nil and true or type(arg2) == "function", string.format("Please pass a handler function to %s!", "Promise:done"))
	return arg1:_finally(debug.traceback(nil, 2), arg2, true)
end
function v_u7.prototype.doneCall(arg1, arg2, ...)
	-- upvalues: (copy) v_u4
	assert(type(arg2) == "function", string.format("Please pass a handler function to %s!", "Promise:doneCall"))
	local v_u1, v_u2 = v_u4(...)
	return arg1:_finally(debug.traceback(nil, 2), function()
		-- upvalues: (copy) arg2, (copy) v_u2, (copy) v_u1
		return arg2(unpack(v_u2, 1, v_u1))
	end, true)
end
function v_u7.prototype.doneReturn(arg1, ...)
	-- upvalues: (copy) v_u4
	local v_u1, v_u2 = v_u4(...)
	return arg1:_finally(debug.traceback(nil, 2), function()
		-- upvalues: (copy) v_u2, (copy) v_u1
		return unpack(v_u2, 1, v_u1)
	end, true)
end
function v_u7.prototype.awaitStatus(arg1)
	-- upvalues: (copy) v_u7
	arg1._unhandledRejection = false
	if arg1._status == v_u7.Status.Started then
		local v_u_bindableevent = Instance.new("BindableEvent")
		arg1:finally(function()
			-- upvalues: (copy) v_u_bindableevent
			v_u_bindableevent:Fire()
		end)
		v_u_bindableevent.Event:Wait()
		v_u_bindableevent:Destroy()
	end
	if arg1._status == v_u7.Status.Resolved then
		return arg1._status, unpack(arg1._values, 1, arg1._valuesLength)
	elseif arg1._status == v_u7.Status.Rejected then
		return arg1._status, unpack(arg1._values, 1, arg1._valuesLength)
	else
		return arg1._status
	end
end
local function v_u12(arg1, ...)
	-- upvalues: (copy) v_u7
	return arg1 == v_u7.Status.Resolved, ...
end
function v_u7.prototype.await(arg1)
	-- upvalues: (copy) v_u12
	return v_u12(arg1:awaitStatus())
end
local function v_u13(arg1, ...)
	-- upvalues: (copy) v_u7
	if arg1 ~= v_u7.Status.Resolved then
		error(... == nil and "Expected Promise rejected with no value." or ..., 3)
	end
	return ...
end
function v_u7.prototype.expect(arg1)
	-- upvalues: (copy) v_u13
	return v_u13(arg1:awaitStatus())
end
v_u7.prototype.awaitValue = v_u7.prototype.expect
function v_u7.prototype._unwrap(arg1)
	-- upvalues: (copy) v_u7
	if arg1._status == v_u7.Status.Started then
		error("Promise has not resolved or rejected.", 2)
	end
	return arg1._status == v_u7.Status.Resolved, unpack(arg1._values, 1, arg1._valuesLength)
end
local function v14(self, ...)
	-- upvalues: (copy) v_u7, (ref) v_u3, (copy) v_u4
	if self._status == v_u7.Status.Started then
		if v_u7.is((...)) then
			if select("#", ...) > 1 then
				local v_format = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", self._source)
				warn(v_format)
			end
			local v_u1 = ...
			local v_andthen = v_u1:andThen(function(...)
				-- upvalues: (copy) self
				self:_resolve(...)
			end, function(...)
				-- upvalues: (copy) v_u1, (ref) v_u3, (copy) self
				local v1 = v_u1._values[1]
				if v_u1._error then
					v1 = v_u3.new({
						["error"] = v_u1._error,
						["kind"] = v_u3.Kind.ExecutionError,
						["context"] = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]"
					})
				end
				if v_u3.isKind(v1, v_u3.Kind.ExecutionError) then
					return self:_reject(v1:extend({
						["error"] = "This Promise was chained to a Promise that errored.",
						["trace"] = "",
						["context"] = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", self._source)
					}))
				end
				self:_reject(...)
			end)
			if v_andthen._status == v_u7.Status.Cancelled then
				self:cancel()
			elseif v_andthen._status == v_u7.Status.Started then
				self._parent = v_andthen
				v_andthen._consumers[self] = true
			end
		else
			self._status = v_u7.Status.Resolved
			local v2, v3 = v_u4(...)
			self._valuesLength = v2
			self._values = v3
			for _, v4 in ipairs(self._queuedResolve) do
				coroutine.wrap(v4)(...)
			end
			self:_finalize()
			return
		end
	else
		if v_u7.is((...)) then
			(...):_consumerCancelled(self)
		end
		return
	end
end
v_u7.prototype._resolve = v14
function v_u7.prototype._reject(self, ...)
	-- upvalues: (copy) v_u7, (copy) v_u4
	if self._status == v_u7.Status.Started then
		self._status = v_u7.Status.Rejected
		local v1, v2 = v_u4(...)
		self._valuesLength = v1
		self._values = v2
		if next(self._queuedReject) == nil then
			local v_u3 = tostring((...))
			coroutine.wrap(function()
				-- upvalues: (ref) v_u7, (copy) self, (copy) v_u3
				v_u7._timeEvent:Wait()
				if self._unhandledRejection then
					local v_format = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", v_u3, self._source)
					if not v_u7.TEST then
						warn(v_format)
					end
				else
					return
				end
			end)()
		else
			for _, v4 in ipairs(self._queuedReject) do
				coroutine.wrap(v4)(...)
			end
		end
		self:_finalize()
	end
end
function v_u7.prototype._finalize(arg1)
	-- upvalues: (copy) v_u7
	for _, v1 in ipairs(arg1._queuedFinally) do
		coroutine.wrap(v1)(arg1._status)
	end
	arg1._queuedFinally = nil
	arg1._queuedReject = nil
	arg1._queuedResolve = nil
	if not v_u7.TEST then
		arg1._parent = nil
		arg1._consumers = nil
	end
end
local function v15(arg1, arg2)
	-- upvalues: (copy) v_u7, (ref) v_u3
	local v_traceback = debug.traceback(nil, 2)
	if arg1:getStatus() == v_u7.Status.Resolved then
		return arg1:_andThen(v_traceback, function(...)
			return ...
		end)
	end
	local v_reject = v_u7.reject
	if arg2 == nil then
		arg2 = v_u3.new({
			["kind"] = v_u3.Kind.NotResolvedInTime,
			["error"] = "This Promise was not resolved in time for :now()",
			["context"] = ":now() was called at:\n\n" .. v_traceback
		}) or arg2
	end
	return v_reject(arg2)
end
v_u7.prototype.now = v15
function v_u7.retry(arg1, arg2, ...)
	-- upvalues: (copy) v_u7
	assert(type(arg1) == "function", "Parameter #1 to Promise.retry must be a function")
	assert(type(arg2) == "number", "Parameter #2 to Promise.retry must be a number")
	local v_u1 = { ... }
	local v_u2 = select("#", ...)
	return v_u7.resolve(arg1(...)):catch(function(...)
		-- upvalues: (copy) arg2, (ref) v_u7, (copy) arg1, (copy) v_u1, (copy) v_u2
		if arg2 > 0 then
			return v_u7.retry(arg1, arg2 - 1, unpack(v_u1, 1, v_u2))
		else
			return v_u7.reject(...)
		end
	end)
end
function v_u7.fromEvent(arg1, arg2)
	-- upvalues: (copy) v_u7
	local v_u1 = arg2 or function()
		return true
	end
	return v_u7._new(debug.traceback(nil, 2), function(arg1, _, arg3)
		-- upvalues: (copy) arg1, (ref) v_u1
		local v_u1 = nil
		local v_u2 = false
		local function v3()
			-- upvalues: (ref) v_u1
			v_u1:Disconnect()
			v_u1 = nil
		end
		v_u1 = arg1:Connect(function(...)
			-- upvalues: (ref) v_u1, (copy) arg1, (ref) v_u1, (ref) v_u2
			local v1 = v_u1(...)
			if v1 == true then
				arg1(...)
				if v_u1 then
					v_u1:Disconnect()
					v_u1 = nil
				else
					v_u2 = true
				end
			else
				if type(v1) ~= "boolean" then
					error("Promise.fromEvent predicate should always return a boolean")
				end
				return
			end
		end)
		if v_u2 and v_u1 then
			return v3()
		end
		arg3(function()
			-- upvalues: (ref) v_u1
			v_u1:Disconnect()
			v_u1 = nil
		end)
	end)
end
return v_u7