-- Decompiled with Bunni.lol Decompiler

local function v_u1(_)
	return true
end
return function(arg1, arg2, arg3, arg4)
	-- upvalues: (copy) v_u1
	local v_u1 = nil
	local v_u2 = nil
	local v_u3 = 0
	if arg4 == nil then
		arg4 = v_u1
	end
	local function v_u4()
		-- upvalues: (ref) v_u1, (ref) v_u3, (copy) arg1, (copy) arg2, (copy) arg4, (copy) arg3, (ref) v_u2
		if v_u1 ~= nil then
			task.spawn(v_u1)
			v_u1 = nil
		end
		local v_u1 = v_u3 + 1
		local v_u_getattribute = arg1:GetAttribute(arg2)
		if v_u_getattribute ~= nil and arg4(v_u_getattribute) then
			task.spawn(function()
				-- upvalues: (ref) arg3, (copy) v_u_getattribute, (copy) v_u1, (ref) v_u3, (ref) v_u2, (ref) v_u1
				local v1 = arg3(v_u_getattribute)
				if v_u1 == v_u3 and v_u2.Connected then
					v_u1 = v1
				else
					task.spawn(v1)
				end
			end)
		end
	end
	local v_u_connection = arg1:GetAttributeChangedSignal(arg2):Connect(v_u4)
	task.defer(function()
		-- upvalues: (ref) v_u_connection, (copy) v_u4
		if v_u_connection.Connected then
			v_u4()
		end
	end)
	return function()
		-- upvalues: (ref) v_u_connection, (ref) v_u1
		v_u_connection:Disconnect()
		if v_u1 ~= nil then
			task.spawn(v_u1)
			v_u1 = nil
		end
	end
end