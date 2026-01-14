-- Decompiled with Bunni.lol Decompiler

local v_u1 = nil
local v_u2 = nil
return {
	["start"] = function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u2
		v_u1 = {}
		v_u2 = arg1
	end,
	["add"] = function(arg1)
		-- upvalues: (ref) v_u1
		if v_u1 then
			table.insert(v_u1, arg1)
		end
	end,
	["currentLength"] = function()
		-- upvalues: (ref) v_u1
		return v_u1 and #v_u1 or 0
	end,
	["currentName"] = function()
		-- upvalues: (ref) v_u2
		return v_u2
	end,
	["empty"] = function()
		-- upvalues: (ref) v_u1
		if v_u1 == nil then
			return {}
		end
		v_u1 = nil
		return v_u1
	end
}