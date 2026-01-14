-- Decompiled with Bunni.lol Decompiler

local v_u_run = game:GetService("RunService")
local v_u1 = newproxy()
local v_u2 = newproxy()
local v_u_freeze = table.freeze({
	"Destroy",
	"Disconnect",
	"destroy",
	"disconnect"
})
local function v_u3(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u2, (copy) v_u_freeze
	local v1 = typeof(arg1)
	if v1 == "function" then
		return v_u1
	end
	if v1 == "thread" then
		return v_u2
	end
	if arg2 then
		return arg2
	end
	if v1 == "Instance" then
		return "Destroy"
	end
	if v1 == "RBXScriptConnection" then
		return "Disconnect"
	end
	if v1 == "table" then
		for _, v2 in v_u_freeze do
			if typeof(arg1[v2]) == "function" then
				return v2
			end
		end
	end
	error(("failed to get cleanup function for object %*: %*"):format(v1, arg1), 3)
end
local v_u4 = {}
v_u4.__index = v_u4
function v_u4.new()
	-- upvalues: (copy) v_u4
	local v1 = setmetatable({}, v_u4)
	v1._objects = {}
	v1._cleaning = false
	return v1
end
function v_u4.Add(arg1, arg2, arg3)
	-- upvalues: (copy) v_u3
	if arg1._cleaning then
		error("cannot call trove:Add() while cleaning", 2)
	end
	local v1 = v_u3(arg2, arg3)
	table.insert(arg1._objects, { arg2, v1 })
	return arg2
end
function v_u4.Clone(arg1, arg2)
	if arg1._cleaning then
		error("cannot call trove:Clone() while cleaning", 2)
	end
	return arg1:Add(arg2:Clone())
end
function v_u4.Construct(arg1, arg2, ...)
	if arg1._cleaning then
		error("Cannot call trove:Construct() while cleaning", 2)
	end
	local v1 = nil
	local v2 = type(arg2)
	if v2 == "table" then
		v1 = arg2.new(...)
	elseif v2 == "function" then
		v1 = arg2(...)
	end
	return arg1:Add(v1)
end
function v_u4.Connect(arg1, arg2, arg3)
	if arg1._cleaning then
		error("Cannot call trove:Connect() while cleaning", 2)
	end
	return arg1:Add(arg2:Connect(arg3))
end
function v_u4.BindToRenderStep(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u_run
	if arg1._cleaning then
		error("cannot call trove:BindToRenderStep() while cleaning", 2)
	end
	v_u_run:BindToRenderStep(arg2, arg3, arg4)
	arg1:Add(function()
		-- upvalues: (ref) v_u_run, (copy) arg2
		v_u_run:UnbindFromRenderStep(arg2)
	end)
end
function v_u4.AddPromise(arg1, arg2)
	if arg1._cleaning then
		error("cannot call trove:AddPromise() while cleaning", 2)
	end
	if typeof(arg2) ~= "table" or (typeof(arg2.getStatus) ~= "function" or (typeof(arg2.finally) ~= "function" or typeof(arg2.cancel) ~= "function")) then
		error("did not receive a promise as an argument", 3)
	end
	if arg2:getStatus() == "Started" then
		arg2:finally(function()
			-- upvalues: (copy) arg1, (copy) arg2
			if not arg1._cleaning then
				arg1:_findAndRemoveFromObjects(arg2, false)
			end
		end)
		arg1:Add(arg2, "cancel")
	end
	return arg2
end
function v_u4.Remove(arg1, arg2)
	if arg1._cleaning then
		error("cannot call trove:Remove() while cleaning", 2)
	end
	return arg1:_findAndRemoveFromObjects(arg2, true)
end
function v_u4.Extend(arg1)
	-- upvalues: (copy) v_u4
	if arg1._cleaning then
		error("cannot call trove:Extend() while cleaning", 2)
	end
	return arg1:Construct(v_u4)
end
function v_u4.Clean(arg1)
	if not arg1._cleaning then
		arg1._cleaning = true
		for _, v1 in arg1._objects do
			arg1:_cleanupObject(v1[1], v1[2])
		end
		table.clear(arg1._objects)
		arg1._cleaning = false
	end
end
function v_u4.WrapClean(self)
	return function()
		-- upvalues: (copy) self
		self:Clean()
	end
end
function v_u4._findAndRemoveFromObjects(arg1, arg2, arg3)
	local v__objects = arg1._objects
	for v1, v2 in v__objects do
		if v2[1] == arg2 then
			local v3 = #v__objects
			v__objects[v1] = v__objects[v3]
			v__objects[v3] = nil
			if arg3 then
				arg1:_cleanupObject(v2[1], v2[2])
			end
			return true
		end
	end
	return false
end
function v_u4._cleanupObject(_, arg2, arg3)
	-- upvalues: (copy) v_u1, (copy) v_u2
	if arg3 == v_u1 then
		task.spawn(arg2)
		return
	elseif arg3 == v_u2 then
		pcall(task.cancel, arg2)
	else
		arg2[arg3](arg2)
	end
end
function v_u4.AttachToInstance(arg1, arg2)
	if arg1._cleaning then
		error("cannot call trove:AttachToInstance() while cleaning", 2)
	elseif not arg2:IsDescendantOf(game) then
		error("instance is not a descendant of the game hierarchy", 2)
	end
	return arg1:Connect(arg2.Destroying, function()
		-- upvalues: (copy) arg1
		arg1:Destroy()
	end)
end
function v_u4.Destroy(arg1)
	arg1:Clean()
end
return {
	["new"] = v_u4.new
}