-- Decompiled with Bunni.lol Decompiler

return function(arg1, arg2)
	local v1 = {}
	for v2, v3 in pairs(arg1) do
		local v4, v5 = arg2(v3, v2, arg1)
		v1[v5 or v2] = v4
	end
	return v1
end