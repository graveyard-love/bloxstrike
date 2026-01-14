-- Decompiled with Bunni.lol Decompiler

return function(arg1)
	local v1 = {}
	for _, v2 in ipairs(arg1) do
		v1[v2[1]] = v2[2]
	end
	return v1
end