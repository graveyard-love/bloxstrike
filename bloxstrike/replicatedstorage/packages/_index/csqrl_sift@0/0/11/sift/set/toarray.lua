-- Decompiled with Bunni.lol Decompiler

return function(arg1)
	local v1 = {}
	for v2, _ in pairs(arg1) do
		table.insert(v1, v2)
	end
	return v1
end