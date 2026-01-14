-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2)
	local v1 = {}
	for v2 = type(arg2) ~= "number" and 2 or arg2 + 1, #arg1 do
		table.insert(v1, arg1[v2])
	end
	return v1
end