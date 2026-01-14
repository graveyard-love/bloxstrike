-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2, arg3)
	local v_u1 = nil
	local v_u2 = nil
	local v_u3 = 0
	local function v4()
		-- upvalues: (ref) v_u1, (ref) v_u3, (copy) arg1, (copy) arg2, (copy) arg3, (ref) v_u2
		if v_u1 ~= nil then
			task.spawn(v_u1)
			v_u1 = nil
		end
		v_u3 = v_u3 + 1
		local v_u1 = v_u3
		local v_u2 = arg1[arg2]
		task.spawn(function()
			-- upvalues: (ref) arg3, (copy) v_u2, (copy) v_u1, (ref) v_u3, (ref) v_u2, (ref) v_u1
			local v1 = arg3(v_u2)
			if v_u1 == v_u3 and v_u2.Connected then
				v_u1 = v1
			else
				task.spawn(v1)
			end
		end)
	end
	v_u2 = arg1:GetPropertyChangedSignal(arg2):Connect(v4)
	task.defer(function()
		-- upvalues: (ref) v_u2, (ref) v_u1, (ref) v_u3, (copy) arg1, (copy) arg2, (copy) arg3
		if v_u2.Connected then
			if v_u1 ~= nil then
				task.spawn(v_u1)
				v_u1 = nil
			end
			v_u3 = v_u3 + 1
			local v_u1 = v_u3
			local v_u2 = arg1[arg2]
			task.spawn(function()
				-- upvalues: (ref) arg3, (copy) v_u2, (copy) v_u1, (ref) v_u3, (ref) v_u2, (ref) v_u1
				local v1 = arg3(v_u2)
				if v_u1 == v_u3 and v_u2.Connected then
					v_u1 = v1
				else
					task.spawn(v1)
				end
			end)
		end
	end)
	return function()
		-- upvalues: (ref) v_u2, (ref) v_u1
		v_u2:Disconnect()
		if v_u1 ~= nil then
			task.spawn(v_u1)
			v_u1 = nil
		end
	end
end