-- Decompiled with Bunni.lol Decompiler

return function(arg1, ...)
	local v1 = {}
	for _, v2 in ipairs(arg1) do
		table.insert(v1, v2)
	end
	for _, v3 in ipairs({ ... }) do
		table.insert(v1, v3)
	end
	return v1
end