-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2)
	local v1 = {}
	for v2 = 1, #arg1 - (type(arg2) ~= "number" and 1 or arg2) do
		table.insert(v1, arg1[v2])
	end
	return v1
end