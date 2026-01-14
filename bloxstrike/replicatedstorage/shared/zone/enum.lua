-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_u2 = {}
v1.enums = v_u2
function v1.createEnum(arg1, arg2)
	-- upvalues: (copy) v_u2
	assert(typeof(arg1) == "string", "bad argument #1 - enums must be created using a string name!")
	assert(typeof(arg2) == "table", "bad argument #2 - enums must be created using a table!")
	assert(not v_u2[arg1], ("enum \'%s\' already exists!"):format(arg1))
	local v_u1 = {}
	local v_u2 = {}
	local v_u3 = {}
	local v4 = {}
	local v_u5 = {
		["getName"] = function(arg1)
			-- upvalues: (copy) v_u2, (copy) v_u3, (copy) arg2
			local v1 = tostring(arg1)
			local v2 = v_u2[v1] or v_u3[v1]
			if v2 then
				return arg2[v2][1]
			end
		end,
		["getValue"] = function(arg1)
			-- upvalues: (copy) v_u1, (copy) v_u3, (copy) arg2
			local v1 = tostring(arg1)
			local v2 = v_u1[v1] or v_u3[v1]
			if v2 then
				return arg2[v2][2]
			end
		end,
		["getProperty"] = function(arg1)
			-- upvalues: (copy) v_u1, (copy) v_u2, (copy) arg2
			local v1 = tostring(arg1)
			local v2 = v_u1[v1] or v_u2[v1]
			if v2 then
				return arg2[v2][3]
			end
		end
	}
	for v6, v7 in pairs(arg2) do
		assert(typeof(v7) == "table", ("bad argument #2.%s - details must only be comprised of tables!"):format(v6))
		local v8 = v7[1]
		assert(typeof(v8) == "string", ("bad argument #2.%s.1 - detail name must be a string!"):format(v6))
		local v9 = typeof(not v_u1[v8])
		assert(v9, ("bad argument #2.%s.1 - the detail name \'%s\' already exists!"):format(v6, v8))
		local v10 = typeof(not v_u5[v8])
		assert(v10, ("bad argument #2.%s.1 - that name is reserved."):format(v6, v8))
		v_u1[tostring(v8)] = v6
		local v11 = v7[2]
		local v12 = tostring(v11)
		local v13 = typeof(not v_u2[v12])
		assert(v13, ("bad argument #2.%s.2 - the detail value \'%s\' already exists!"):format(v6, v12))
		v_u2[v12] = v6
		local v14 = v7[3]
		if v14 then
			local v15 = typeof(not v_u3[v14])
			local v16 = tostring(v14)
			assert(v15, ("bad argument #2.%s.3 - the detail property \'%s\' already exists!"):format(v6, v16))
			v_u3[tostring(v14)] = v6
		end
		v4[v8] = v11
		setmetatable(v4, {
			["__index"] = function(_, arg2)
				-- upvalues: (copy) v_u5
				return v_u5[arg2]
			end
		})
	end
	v_u2[arg1] = v4
	return v4
end
function v1.getEnums()
	-- upvalues: (copy) v_u2
	return v_u2
end
local v_createenum = v1.createEnum
for _, v3 in pairs(script:GetChildren()) do
	if v3:IsA("ModuleScript") then
		local v4 = require(v3)
		v_createenum(v3.Name, v4)
	end
end
return v1