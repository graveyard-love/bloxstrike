-- Decompiled with Bunni.lol Decompiler

local v_u1 = require(script.Parent.Parent.Util)
local function v_u2(arg1, arg2)
	if type(arg1) ~= "table" or type(arg2) ~= "table" then
		return arg1 == arg2
	end
	local v1 = #arg1
	if #arg2 ~= v1 then
		return false
	end
	for v2 = 1, v1 do
		if arg1[v2] ~= arg2[v2] then
			return false
		end
	end
	return true
end
return function(...)
	-- upvalues: (copy) v_u1, (copy) v_u2
	if v_u1.equalObjects(...) then
		return true
	end
	local v1 = select("#", ...)
	local v2 = select(1, ...)
	for v3 = 2, v1 do
		if not v_u2(v2, (select(v3, ...))) then
			return false
		end
	end
	return true
end