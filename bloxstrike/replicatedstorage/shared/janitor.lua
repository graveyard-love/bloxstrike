-- Decompiled with Bunni.lol Decompiler

local v1 = require(script.GetPromiseLibrary)
local v_u2 = require(script.RbxScriptConnection)
local v3 = require(script.Symbol)
local v_u4, v_u5 = v1()
local v_u_indicesreference = v3("IndicesReference")
local v_u_linktoinstanceindex = v3("LinkToInstanceIndex")
local v_u6 = {
	["ClassName"] = "Janitor",
	["CurrentlyCleaning"] = true,
	["SuppressInstanceReDestroy"] = false,
	[v_u_indicesreference] = nil
}
v_u6.__index = v_u6
local v_u7 = {
	["function"] = true,
	["thread"] = true,
	["RBXScriptConnection"] = "Disconnect"
}
function v_u6.new()
	-- upvalues: (copy) v_u_indicesreference, (copy) v_u6
	return setmetatable({
		["CurrentlyCleaning"] = false,
		[v_u_indicesreference] = nil
	}, v_u6)
end
function v_u6.Is(arg1)
	-- upvalues: (copy) v_u6
	local v1
	if type(arg1) == "table" then
		v1 = getmetatable(arg1) == v_u6
	else
		v1 = false
	end
	return v1
end
function v_u6.Add(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_indicesreference, (copy) v_u7
	if arg4 then
		arg1:Remove(arg4)
		local v1 = arg1[v_u_indicesreference]
		if not v1 then
			v1 = {}
			arg1[v_u_indicesreference] = v1
		end
		v1[arg4] = arg2
	end
	local v2 = typeof(arg2)
	local v3 = arg3 or (v_u7[v2] or "Destroy")
	if v2 == "function" or v2 == "thread" then
		if v3 ~= true then
			warn(string.format("Object is a %s and as such expected `true?` for the method name and instead got %s. Traceback: %s", v2, tostring(v3), debug.traceback(nil, 2)))
		end
	elseif not arg2[v3] then
		warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(arg2), tostring(v3), debug.traceback(nil, 2)))
	end
	arg1[arg2] = v3
	return arg2
end
function v_u6.AddPromise(arg1, arg2)
	-- upvalues: (copy) v_u4, (copy) v_u5
	if not v_u4 then
		return arg2
	end
	if not v_u5.is(arg2) then
		error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %s (%s)) Traceback: %s", typeof(arg2), tostring(arg2), debug.traceback(nil, 2)))
	end
	if arg2:getStatus() ~= v_u5.Status.Started then
		return arg2
	end
	local v1 = newproxy(false)
	local v_add = arg1:Add(v_u5.new(function(arg1, _, arg3)
		-- upvalues: (copy) arg2
		if not arg3(function()
			-- upvalues: (ref) arg2
			arg2:cancel()
		end) then
			arg1(arg2)
		end
	end), "cancel", v1)
	v_add:finallyCall(arg1.Remove, arg1, v1)
	return v_add
end
function v_u6.Remove(arg1, arg2)
	-- upvalues: (copy) v_u_indicesreference
	local v1 = arg1[v_u_indicesreference]
	local v_u2 = v1 and v1[arg2]
	if v_u2 then
		local v3 = arg1[v_u2]
		if v3 then
			if v3 == true then
				if type(v_u2) == "function" then
					v_u2()
				else
					local v4
					if coroutine.running() == v_u2 then
						v4 = nil
					else
						v4 = pcall(function()
							-- upvalues: (copy) v_u2
							task.cancel(v_u2)
						end)
					end
					if not v4 then
						task.defer(function()
							-- upvalues: (copy) v_u2
							if v_u2 then
								task.cancel(v_u2)
							end
						end)
					end
				end
			else
				local v5 = v_u2[v3]
				if v5 then
					if arg1.SuppressInstanceReDestroy and (v3 == "Destroy" and typeof(v_u2) == "Instance") then
						pcall(v5, v_u2)
					else
						v5(v_u2)
					end
				end
			end
			arg1[v_u2] = nil
		end
		v1[arg2] = nil
	end
	return arg1
end
function v_u6.RemoveNoClean(arg1, arg2)
	-- upvalues: (copy) v_u_indicesreference
	local v1 = arg1[v_u_indicesreference]
	if v1 then
		local v2 = v1[arg2]
		if v2 then
			arg1[v2] = nil
		end
		v1[arg2] = nil
	end
	return arg1
end
function v_u6.RemoveList(arg1, ...)
	-- upvalues: (copy) v_u_indicesreference
	if arg1[v_u_indicesreference] then
		local v1 = select("#", ...)
		if v1 == 1 then
			return arg1:Remove(...)
		end
		for v2 = 1, v1 do
			arg1:Remove(select(v2, ...))
		end
	end
	return arg1
end
function v_u6.RemoveListNoClean(arg1, ...)
	-- upvalues: (copy) v_u_indicesreference
	local v1 = arg1[v_u_indicesreference]
	if v1 then
		local v2 = select("#", ...)
		if v2 == 1 then
			return arg1:RemoveNoClean(...)
		end
		for v3 = 1, v2 do
			local v4 = select(v3, ...)
			local v5 = v1[v4]
			if v5 then
				arg1[v5] = nil
			end
			v1[v4] = nil
		end
	end
	return arg1
end
function v_u6.Get(arg1, arg2)
	-- upvalues: (copy) v_u_indicesreference
	local v1 = arg1[v_u_indicesreference]
	if v1 then
		return v1[arg2]
	else
		return nil
	end
end
function v_u6.GetAll(arg1)
	-- upvalues: (copy) v_u_indicesreference
	local v1 = arg1[v_u_indicesreference]
	return not v1 and {} or table.freeze(table.clone(v1))
end
function v_u6.Cleanup(self)
	-- upvalues: (copy) v_u_indicesreference
	if not self.CurrentlyCleaning then
		self.CurrentlyCleaning = nil
		local function v1()
			-- upvalues: (copy) self, (ref) v_u_indicesreference
			for v1, v2 in next, self do
				if v1 ~= v_u_indicesreference then
					return v1, v2
				end
			end
		end
		local v_u2, v3 = v1()
		while v_u2 and v3 do
			if v3 == true then
				if type(v_u2) == "function" then
					v_u2()
				else
					local v4
					if coroutine.running() == v_u2 then
						v4 = nil
					else
						v4 = pcall(function()
							-- upvalues: (ref) v_u2
							task.cancel(v_u2)
						end)
					end
					if not v4 then
						task.defer(function()
							-- upvalues: (ref) v_u2
							if v_u2 then
								task.cancel(v_u2)
							end
						end)
					end
				end
			else
				local v5 = v_u2[v3]
				if v5 then
					if self.SuppressInstanceReDestroy and (v3 == "Destroy" and typeof(v_u2) == "Instance") then
						pcall(v5, v_u2)
					else
						v5(v_u2)
					end
				end
			end
			self[v_u2] = nil
			v_u2, v3 = v1()
		end
		local v6 = self[v_u_indicesreference]
		if v6 then
			table.clear(v6)
			self[v_u_indicesreference] = {}
		end
		self.CurrentlyCleaning = false
	end
end
function v_u6.Destroy(arg1)
	arg1:Cleanup()
end
v_u6.__call = v_u6.Cleanup
function v_u6.LinkToInstance(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_linktoinstanceindex
	return arg1:Add(arg2.Destroying:Connect(function()
		-- upvalues: (copy) arg1
		arg1:Cleanup()
	end), "Disconnect", arg3 and newproxy(false) or v_u_linktoinstanceindex)
end
function v_u6.LegacyLinkToInstance(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_linktoinstanceindex, (copy) v_u2
	local v_u1 = nil
	local v2 = arg3 and newproxy(false) or v_u_linktoinstanceindex
	local v_u3 = arg2.Parent == nil
	local v_u4 = setmetatable({}, v_u2)
	local function v5(_, arg2)
		-- upvalues: (copy) v_u4, (ref) v_u3, (ref) v_u1, (copy) arg1
		if v_u4.Connected and arg2 == nil then
			task.defer(function()
				-- upvalues: (ref) v_u4, (ref) v_u1, (ref) arg1, (ref) v_u3
				if v_u4.Connected then
					if v_u1.Connected then
						while v_u3 and (v_u1.Connected and v_u4.Connected) do
							task.wait()
						end
						if v_u4.Connected and v_u3 then
							arg1:Cleanup()
						end
					else
						arg1:Cleanup()
					end
				else
					return
				end
			end)
		end
	end
	local v_u_connection = arg2.AncestryChanged:Connect(v5)
	v_u4.Connection = v_u_connection
	if v_u3 then
		local v_parent = arg2.Parent
		if v_u4.Connected then
			if v_parent == nil then
				v_u3 = true
			else
				v_u3 = false
			end
			if v_u3 then
				task.defer(function()
					-- upvalues: (copy) v_u4, (ref) v_u_connection, (copy) arg1, (ref) v_u3
					if v_u4.Connected then
						if v_u_connection.Connected then
							while v_u3 and (v_u_connection.Connected and v_u4.Connected) do
								task.wait()
							end
							if v_u4.Connected and v_u3 then
								arg1:Cleanup()
							end
						else
							arg1:Cleanup()
						end
					else
						return
					end
				end)
			end
		end
	end
	return arg1:Add(v_u4, "Disconnect", v2)
end
function v_u6.LinkToInstances(arg1, ...)
	-- upvalues: (copy) v_u6
	local v_new = v_u6.new()
	for _, v1 in { ... } do
		v_new:Add(arg1:LinkToInstance(v1, true), "Disconnect")
	end
	return v_new
end
function v_u6.__tostring(_)
	return "Janitor"
end
table.freeze(v_u6)
return v_u6