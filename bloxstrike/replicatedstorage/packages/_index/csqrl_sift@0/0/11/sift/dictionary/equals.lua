-- Decompiled with Bunni.lol Decompiler

local v_parent = script.Parent.Parent
local v_u1 = require(v_parent.Util)
require(v_parent.Types)
local function v_u2(arg1, arg2)
	if type(arg1) ~= "table" or type(arg2) ~= "table" then
		return arg1 == arg2
	end
	for v1, v2 in pairs(arg1) do
		if arg2[v1] ~= v2 then
			return false
		end
	end
	for v3, v4 in pairs(arg2) do
		if arg1[v3] ~= v4 then
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