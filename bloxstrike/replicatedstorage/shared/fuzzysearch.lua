-- Decompiled with Bunni.lol Decompiler

return {
	["GetNames"] = function(arg1)
		local v1 = {}
		for v2 = 1, #arg1 do
			v1[v2] = arg1[v2].Name or tostring(arg1[v2])
		end
		return v1
	end,
	["MakeFuzzyFinder"] = function(arg1)
		local v_u1 = nil
		local v_u2 = {}
		if typeof(arg1) == "Enum" then
			arg1 = arg1:GetEnumItems()
		end
		if typeof(arg1) == "Instance" then
			v_u2 = arg1:GetChildren()
			v_u1 = {}
			for v3 = 1, #v_u2 do
				v_u1[v3] = v_u2[v3].Name
			end
		elseif typeof(arg1) == "table" then
			if typeof(arg1[1]) == "Instance" or (typeof(arg1[1]) == "EnumItem" or typeof(arg1[1]) == "table" and typeof(arg1[1].Name) == "string") then
				v_u1 = {}
				v_u2 = arg1
				for v4 = 1, #arg1 do
					v_u1[v4] = v_u2[v4].Name
					arg1 = v_u2
					v_u2 = arg1
				end
			elseif type(arg1[1]) == "string" then
				v_u1 = arg1
			elseif arg1[1] == nil then
				v_u1 = {}
			else
				error("MakeFuzzyFinder only accepts tables of instances or strings.")
			end
		else
			error("MakeFuzzyFinder only accepts a table, Enum, or Instance.")
		end
		return function(arg1, arg2)
			-- upvalues: (ref) v_u1, (ref) v_u2
			local v1 = {}
			for v2, v3 in pairs(v_u1) do
				local v4
				if v_u2 then
					v4 = v_u2[v2] or v3
				else
					v4 = v3
				end
				if v3:lower() == arg1:lower() then
					if arg2 then
						return v4
					end
					table.insert(v1, 1, v4)
				elseif v3:lower():find(arg1:lower(), 1, true) then
					v1[#v1 + 1] = v4
				end
			end
			if arg2 then
				return v1[1]
			else
				return v1
			end
		end
	end
}