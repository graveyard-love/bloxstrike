-- Decompiled with Bunni.lol Decompiler

return function(arg1)
	local v1 = {}
	for v2, v3 in pairs(arg1) do
		table.insert(v1, { v2, v3 })
	end
	return v1
end