-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2, arg3)
	local v1 = #arg1
	local v2 = {}
	local v3 = type(arg2) ~= "number" and 1 or arg2
	if type(arg3) ~= "number" then
		arg3 = v1
	end
	if v3 < 1 then
		v3 = v3 + v1
	end
	if arg3 < 1 then
		arg3 = arg3 + v1
	end
	for v4 = v3, arg3 do
		table.insert(v2, arg1[v4])
	end
	return v2
end