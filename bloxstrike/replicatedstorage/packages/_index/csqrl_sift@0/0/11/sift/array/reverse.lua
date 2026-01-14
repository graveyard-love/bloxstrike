-- Decompiled with Bunni.lol Decompiler

return function(arg1)
	local v1 = {}
	for v2 = #arg1, 1, -1 do
		table.insert(v1, arg1[v2])
	end
	return v1
end