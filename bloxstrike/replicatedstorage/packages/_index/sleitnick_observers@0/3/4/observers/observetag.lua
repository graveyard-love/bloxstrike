-- Decompiled with Bunni.lol Decompiler

local v_u_collection = game:GetService("CollectionService")
function observeTag(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_collection
	local v_u1 = {}
	local v_u2 = {}
	local v_u3 = nil
	local function v_u4(self)
		-- upvalues: (ref) v_u3, (copy) v_u1, (copy) v_u2, (copy) arg3, (copy) arg2, (copy) arg1
		if not v_u3.Connected then
			return
		end
		if v_u1[self] ~= nil then
			return
		end
		v_u1[self] = "__dead__"
		v_u2[self] = self.AncestryChanged:Connect(function()
			-- upvalues: (copy) self, (ref) arg3, (ref) v_u1, (ref) arg2, (ref) arg1
			local v_u1 = self
			local v2
			if arg3 == nil then
				v2 = true
				::l3::
				if v2 then
					if v_u1[v_u1] == "__dead__" then
						v_u1[v_u1] = "__inflight__"
						task.defer(function()
							-- upvalues: (ref) v_u1, (copy) v_u1, (ref) arg2, (ref) arg1
							if v_u1[v_u1] == "__inflight__" then
								local v1, v2 = xpcall(function(arg1)
									-- upvalues: (ref) arg2
									local v1 = arg2(arg1)
									if v1 ~= nil then
										assert(typeof(v1) == "function", "callback must return a function or nil")
									end
									return v1
								end, debug.traceback, v_u1)
								if v1 then
									if v_u1[v_u1] == "__inflight__" then
										v_u1[v_u1] = v2
									elseif v2 ~= nil then
										task.spawn(v2)
										return
									end
								else
									local v_find = string.find(string.split(v2, "\n")[1], ": ")
									warn((("error while calling observeTag(\"%*\") callback:%*\n%*"):format(arg1, not v_find and "" or UNNAMED_1728997333032:sub(v_find + 1), v2)))
								end
							else
								return
							end
						end)
						return
					end
				else
					local v3 = v_u1[v_u1]
					v_u1[v_u1] = "__dead__"
					if typeof(v3) == "function" then
						task.spawn(v3)
					end
				end
				return
			else
				for _, v4 in arg3 do
					if v_u1:IsDescendantOf(v4) then
						v2 = true
						goto l3
					end
				end
				v2 = false
				goto l3
			end
		end)
		local v1
		if arg3 == nil then
			v1 = true
			::l7::
			if v1 then
				if v_u1[self] == "__dead__" then
					v_u1[self] = "__inflight__"
					task.defer(function()
						-- upvalues: (ref) v_u1, (copy) self, (ref) arg2, (ref) arg1
						if v_u1[self] == "__inflight__" then
							local v1, v2 = xpcall(function(arg1)
								-- upvalues: (ref) arg2
								local v1 = arg2(arg1)
								if v1 ~= nil then
									assert(typeof(v1) == "function", "callback must return a function or nil")
								end
								return v1
							end, debug.traceback, self)
							if v1 then
								if v_u1[self] == "__inflight__" then
									v_u1[self] = v2
								elseif v2 ~= nil then
									task.spawn(v2)
									return
								end
							else
								local v_find = string.find(string.split(v2, "\n")[1], ": ")
								warn((("error while calling observeTag(\"%*\") callback:%*\n%*"):format(arg1, not v_find and "" or UNNAMED_1728994621720:sub(v_find + 1), v2)))
							end
						else
							return
						end
					end)
					return
				end
			else
				local v2 = v_u1[self]
				v_u1[self] = "__dead__"
				if typeof(v2) == "function" then
					task.spawn(v2)
				end
			end
			return
		else
			for _, v3 in arg3 do
				if self:IsDescendantOf(v3) then
					v1 = true
					goto l7
				end
			end
			v1 = false
			goto l7
		end
	end
	v_u3 = v_u_collection:GetInstanceAddedSignal(arg1):Connect(v_u4)
	local v_u_connection = v_u_collection:GetInstanceRemovedSignal(arg1):Connect(function(arg1)
		-- upvalues: (copy) v_u1, (copy) v_u2
		local v1 = v_u1[arg1]
		v_u1[arg1] = "__dead__"
		if typeof(v1) == "function" then
			task.spawn(v1)
		end
		local v2 = v_u2[arg1]
		if v2 then
			v2:Disconnect()
			v_u2[arg1] = nil
		end
		v_u1[arg1] = nil
	end)
	task.defer(function()
		-- upvalues: (ref) v_u3, (ref) v_u_collection, (copy) arg1, (copy) v_u4
		if v_u3.Connected then
			for _, v1 in v_u_collection:GetTagged(arg1) do
				task.spawn(v_u4, v1)
			end
		end
	end)
	return function()
		-- upvalues: (ref) v_u3, (ref) v_u_connection, (copy) v_u1, (copy) v_u2
		v_u3:Disconnect()
		v_u_connection:Disconnect()
		local v1 = next(v_u1)
		while v1 do
			local v2 = v_u1[v1]
			v_u1[v1] = "__dead__"
			if typeof(v2) == "function" then
				task.spawn(v2)
			end
			local v3 = v_u2[v1]
			if v3 then
				v3:Disconnect()
				v_u2[v1] = nil
			end
			v_u1[v1] = nil
			v1 = next(v_u1)
		end
	end
end
return observeTag