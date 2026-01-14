-- Decompiled with Bunni.lol Decompiler

return function(arg1, ...)
	local v1 = {}
	for v2, _ in pairs(arg1) do
		v1[v2] = true
	end
	for _, v3 in ipairs({ ... }) do
		v1[v3] = true
	end
	return v1
end